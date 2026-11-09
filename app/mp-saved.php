<?php

declare(strict_types=1);

/**
 * AI LAB HUB — збережені пошуки Marketplace (Хвиля 1), таблиця mp_saved_searches (міграція 2026-11-09, № 20).
 *
 *   Зберегти можна сторінку блока / підкатегорії (marketplace-category.php) або загальний пошук (marketplace.php), коли
 *   заданий запит чи фільтр. Лише залогінені з підтвердженою поштою (mpv_is_verified), не більше saved_search_max
 *   активних. Параметри — лише з білих списків тих самих розборів, що й на сторінках (mpj_block_filters,
 *   mpb_search_filters), нормалізовані (JSON із відсортованими ключами) → params_hash (sha256) — унікальність на
 *   користувача. Пошук повторюється тими самими функціями (mpt_search / mpb_search) з фільтром «опубліковано після».
 *   Видалення — is_active = 0 (рядки не видаляються); повторне збереження того самого пошуку його відновлює.
 *   Сповіщення поштою — лише за явною згодою (notify_email = 1) і лише коли saved_search_email_enabled = true;
 *   розсилка — public/mp-cron-saved-searches.php. Відписка — підписаний HMAC-токен (секрет saved_search_secret), без входу.
 */

require_once __DIR__ . '/marketplace-email.php';   // mpv_is_verified, mpv_deliver, mpv_site_url
require_once __DIR__ . '/mp-search.php';           // mpb_search_filters (+ app/mp-jobs.php)

const MPSS_TITLE_MAX = 150;
const MPSS_PARAMS_MAX = 1000;
const MPSS_MAIL_TITLES = 5;

function mpss_ready(PDO $pdo): bool
{
    return function_exists('mpt_table_exists') && mpt_table_exists($pdo, 'mp_saved_searches');
}

function mpss_max(): int
{
    return max(1, (int) (mp_config()['saved_search_max'] ?? 10));
}

/**
 * Нормалізований пошук з адреси сторінки (лише marketplace-category.php?id=… або marketplace.php?…) або null,
 * якщо адреса не та чи в ній немає жодного запиту/фільтра.
 *
 * @return array{p:string,id:int,q:array<string,mixed>}|null
 */
function mpss_from_url(PDO $pdo, string $url, string $lang): ?array
{
    $parts = parse_url($url);
    $path = basename((string) ($parts['path'] ?? ''));
    $get = [];
    parse_str((string) ($parts['query'] ?? ''), $get);
    $tree = mpt_tree($pdo, $lang);
    if ($path === 'marketplace-category.php') {
        $id = is_string($get['id'] ?? null) && ctype_digit((string) $get['id']) ? (int) $get['id'] : 0;
        $node = $id > 0 ? mpt_node($tree, $id) : null;
        if ($node === null) {
            return null;
        }
        $bf = mpj_block_filters($pdo, $node['block'], $node['sub'], $get);
        if (!$bf['filtered']) {
            return null;
        }
        $q = $bf['params'];
        unset($q['page']);

        return ['p' => 'cat', 'id' => $id, 'q' => mpss_sort_keys($q)];
    }
    if ($path === 'marketplace.php') {
        $f = mpb_search_filters($pdo, $get, $lang, ['saved' => false, 'units' => 'km']);
        if (!mpb_search_has_filters($f)) {
            return null;
        }
        $q = $f['url'];
        unset($q['page']);

        return ['p' => 'search', 'id' => 0, 'q' => mpss_sort_keys($q)];
    }

    return null;
}

/** @return array<string,mixed> */
function mpss_sort_keys(array $q): array
{
    $q = array_map(static fn($v) => is_float($v) && floor($v) === $v ? (int) $v : $v, $q);
    ksort($q);

    return $q;
}

/** JSON параметрів і хеш. @return array{0:string,1:string} */
function mpss_encode(array $s): array
{
    $json = (string) json_encode(['p' => $s['p'], 'id' => (int) $s['id'], 'q' => $s['q']], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);

    return [$json, hash('sha256', $json)];
}

/** @return array{p:string,id:int,q:array<string,mixed>}|null */
function mpss_decode(string $json): ?array
{
    $d = json_decode($json, true);
    if (!is_array($d) || !in_array($d['p'] ?? '', ['cat', 'search'], true) || !is_array($d['q'] ?? null)) {
        return null;
    }

    return ['p' => (string) $d['p'], 'id' => (int) ($d['id'] ?? 0), 'q' => $d['q']];
}

/** Адреса сторінки пошуку (відносна). */
function mpss_url(array $s): string
{
    $q = array_map(static fn($v) => is_bool($v) ? (int) $v : $v, $s['q']);
    if ($s['p'] === 'cat') {
        return 'marketplace-category.php?' . http_build_query(['id' => (int) $s['id']] + $q, '', '&', PHP_QUERY_RFC3986);
    }
    if (!isset($q['country']) && !isset($q['place']) && !isset($q['format'])) {
        $q['country'] = '';   // «будь-де», як на сторінці пошуку
    }

    return 'marketplace.php?' . http_build_query($q, '', '&', PHP_QUERY_RFC3986);
}

/**
 * Автоматична назва: «Вакансії · Київ · від 30 000 грн» тощо (до 150 символів).
 */
function mpss_auto_title(PDO $pdo, array $s, string $lang): string
{
    $tree = mpt_tree($pdo, $lang);
    $q = $s['q'];
    $parts = [];
    $block = null;
    if ($s['p'] === 'cat') {
        $node = mpt_node($tree, (int) $s['id']);
        if ($node !== null) {
            $block = $node['block'];
            $parts[] = $node['block']['name'];
            if ($node['sub'] !== null) {
                $parts[] = $node['sub']['name'];
            }
        }
    } else {
        $block = isset($q['section']) ? mpt_block($tree, (string) $q['section']) : null;
        if ($block !== null) {
            $parts[] = $block['name'];
            if ((int) ($q['cat'] ?? 0) > 0 && ($n = mpt_node($tree, (int) $q['cat'])) !== null && $n['sub'] !== null) {
                $parts[] = $n['sub']['name'];
            }
        } else {
            $parts[] = t('mpss_title_all');
        }
    }
    if (trim((string) ($q['q'] ?? '')) !== '') {
        $parts[] = '«' . mb_substr((string) $q['q'], 0, 40) . '»';
    }
    if (trim((string) ($q['city'] ?? '')) !== '') {
        $parts[] = mb_substr((string) $q['city'], 0, 40);
    }
    if ((int) ($q['place'] ?? 0) > 0 && function_exists('mpg_labels')) {
        $parts[] = mpg_labels($pdo, [(int) $q['place']], $lang)[(int) $q['place']]['name'] ?? '';
    } elseif (($q['country'] ?? '') !== '' && function_exists('mpg_countries')) {
        $parts[] = mpg_countries($pdo, $lang)[(string) $q['country']] ?? (string) $q['country'];
    }
    if ((int) ($q['region'] ?? 0) > 0) {
        $parts[] = mpj_region_name($pdo, (int) $q['region'], $lang);
    }
    $jf = mpj_parse($q, (string) ($block['section'] ?? ''));
    if (($jf['sal'] ?? null) !== null) {
        $parts[] = sprintf(t('mpss_title_salary'), number_format((int) $jf['sal'], 0, ',', "\u{00A0}"), t('mpj_cur_' . $jf['scur']));
    }
    foreach (mpj_chips(['sal' => null] + $jf, []) as [$label]) {
        $parts[] = $label;
    }
    if (($q['price_min'] ?? null) !== null || ($q['price_max'] ?? null) !== null) {
        $parts[] = '$' . ($q['price_min'] ?? '0') . '–' . ($q['price_max'] ?? '…');
    }
    $title = implode(' · ', array_values(array_filter(array_map('strval', $parts), static fn($p): bool => trim($p) !== '')));

    return mb_substr($title !== '' ? $title : t('mpss_title_all'), 0, MPSS_TITLE_MAX);
}

/**
 * Повторити пошук: ['total' => N, 'rows' => list] (сортування — найновіші). $after — 'Y-m-d H:i:s' або null.
 *
 * @return array{total:int,rows:list<array<string,mixed>>}
 */
function mpss_run(PDO $pdo, array $s, string $lang, ?string $after, int $limit = MPSS_MAIL_TITLES): array
{
    $tree = mpt_tree($pdo, $lang);
    if ($s['p'] === 'cat') {
        $node = mpt_node($tree, (int) $s['id']);
        if ($node === null) {
            return ['total' => 0, 'rows' => []];
        }
        $bf = mpj_block_filters($pdo, $node['block'], $node['sub'], array_map('strval', $s['q']));
        $f = ['sort' => 'new', 'after' => $after] + $bf['f'];
        $f['sort'] = 'new';
        $r = mpt_search($pdo, $lang, $f, 1, max(1, $limit));

        return ['total' => $r['total'], 'rows' => $r['rows']];
    }
    $f = mpb_search_filters($pdo, array_map(static fn($v) => is_scalar($v) ? (string) $v : '', $s['q']) + ['country' => ''], $lang, ['saved' => false, 'units' => 'km']);
    $f['sort'] = 'new';
    $f['after'] = $after;
    $r = mpb_search($pdo, $lang, $f, 1);

    return ['total' => $r['total'], 'rows' => array_slice($r['rows'], 0, max(1, $limit))];
}

/** Активні збережені пошуки користувача. @return list<array<string,mixed>> */
function mpss_list(PDO $pdo, int $userId): array
{
    $st = $pdo->prepare('SELECT * FROM mp_saved_searches WHERE user_id = :u AND is_active = 1 ORDER BY created_at DESC, id DESC');
    $st->execute([':u' => $userId]);

    return $st->fetchAll(PDO::FETCH_ASSOC);
}

function mpss_active_count(PDO $pdo, int $userId): int
{
    $st = $pdo->prepare('SELECT COUNT(*) FROM mp_saved_searches WHERE user_id = :u AND is_active = 1');
    $st->execute([':u' => $userId]);

    return (int) $st->fetchColumn();
}

/**
 * Зберегти пошук з адреси сторінки.
 *
 * @return array{status:string,id:int}  status: saved | exists | limit | invalid | unverified
 */
function mpss_create(PDO $pdo, int $userId, string $url, string $lang): array
{
    if (!mpv_is_verified($pdo, $userId)) {
        return ['status' => 'unverified', 'id' => 0];
    }
    $s = mpss_from_url($pdo, $url, $lang);
    if ($s === null) {
        return ['status' => 'invalid', 'id' => 0];
    }
    [$json, $hash] = mpss_encode($s);
    if (strlen($json) > MPSS_PARAMS_MAX) {
        return ['status' => 'invalid', 'id' => 0];
    }
    $lock = 'mpss_' . $userId;
    if (!mpb_lock($pdo, $lock)) {
        return ['status' => 'invalid', 'id' => 0];
    }
    try {
        $ex = $pdo->prepare('SELECT id, is_active FROM mp_saved_searches WHERE user_id = :u AND params_hash = :h');
        $ex->execute([':u' => $userId, ':h' => $hash]);
        $row = $ex->fetch(PDO::FETCH_ASSOC);
        if ($row !== false && (int) $row['is_active'] === 1) {
            return ['status' => 'exists', 'id' => (int) $row['id']];
        }
        if (mpss_active_count($pdo, $userId) >= mpss_max()) {
            return ['status' => 'limit', 'id' => 0];
        }
        $title = mpss_auto_title($pdo, $s, $lang);
        if ($row !== false) {
            // Раніше видалений той самий пошук — відновлюємо (сповіщення лишаються вимкненими).
            $pdo->prepare('UPDATE mp_saved_searches SET is_active = 1, notify_email = 0, title = :t, last_seen_at = NOW(), last_notified_at = NULL, created_at = NOW() WHERE id = :id')
                ->execute([':t' => $title, ':id' => (int) $row['id']]);

            return ['status' => 'saved', 'id' => (int) $row['id']];
        }
        $pdo->prepare('INSERT INTO mp_saved_searches (user_id, title, params, params_hash, notify_email, is_active, last_seen_at, created_at)
                       VALUES (:u, :t, :p, :h, 0, 1, NOW(), NOW())')
            ->execute([':u' => $userId, ':t' => $title, ':p' => $json, ':h' => $hash]);

        return ['status' => 'saved', 'id' => (int) $pdo->lastInsertId()];
    } finally {
        mpb_unlock($pdo, $lock);
    }
}

/** Власний активний пошук або null. */
function mpss_own(PDO $pdo, int $userId, int $id): ?array
{
    $st = $pdo->prepare('SELECT * FROM mp_saved_searches WHERE id = :id AND user_id = :u AND is_active = 1');
    $st->execute([':id' => $id, ':u' => $userId]);
    $r = $st->fetch(PDO::FETCH_ASSOC);

    return $r === false ? null : $r;
}

/** Відкрити: last_seen_at = NOW(), повертає адресу пошуку. */
function mpss_open(PDO $pdo, int $userId, int $id): ?string
{
    $row = mpss_own($pdo, $userId, $id);
    $s = $row !== null ? mpss_decode((string) $row['params']) : null;
    if ($s === null) {
        return null;
    }
    $pdo->prepare('UPDATE mp_saved_searches SET last_seen_at = NOW() WHERE id = :id')->execute([':id' => $id]);

    return mpss_url($s);
}

function mpss_rename(PDO $pdo, int $userId, int $id, string $title): bool
{
    $title = trim(mb_substr((string) preg_replace('/\s+/u', ' ', strip_tags($title)), 0, MPSS_TITLE_MAX));
    if ($title === '' || mpss_own($pdo, $userId, $id) === null) {
        return false;
    }
    $pdo->prepare('UPDATE mp_saved_searches SET title = :t WHERE id = :id AND user_id = :u')->execute([':t' => $title, ':id' => $id, ':u' => $userId]);

    return true;
}

/** «Видалити» — is_active = 0 і сповіщення вимкнено (рядок лишається). */
function mpss_remove(PDO $pdo, int $userId, int $id): bool
{
    $st = $pdo->prepare('UPDATE mp_saved_searches SET is_active = 0, notify_email = 0 WHERE id = :id AND user_id = :u AND is_active = 1');
    $st->execute([':id' => $id, ':u' => $userId]);

    return $st->rowCount() > 0;
}

function mpss_set_notify(PDO $pdo, int $userId, int $id, bool $on): bool
{
    if (mpss_own($pdo, $userId, $id) === null) {
        return false;
    }
    // Після ввімкнення — лише оголошення, опубліковані відтепер.
    $pdo->prepare('UPDATE mp_saved_searches SET notify_email = :n' . ($on ? ', last_notified_at = COALESCE(last_notified_at, NOW())' : '') . ' WHERE id = :id AND user_id = :u')
        ->execute([':n' => $on ? 1 : 0, ':id' => $id, ':u' => $userId]);

    return true;
}

/** Кількість нових (опублікованих після last_seen_at) для рядка. */
function mpss_new_count(PDO $pdo, array $row, string $lang): int
{
    $s = mpss_decode((string) $row['params']);
    if ($s === null) {
        return 0;
    }
    try {
        return mpss_run($pdo, $s, $lang, (string) $row['last_seen_at'], 1)['total'];
    } catch (Throwable $e) {
        error_log('[mp-saved] count #' . $row['id'] . ': ' . $e->getMessage());

        return 0;
    }
}

// =========================================================================
// Відписка (HMAC) і розсилка
// =========================================================================

function mpss_secret(): string
{
    return (string) (mp_config()['saved_search_secret'] ?? '');
}

/** Токен відписки: base64url("<id>.<uid>.<hmac>"); порожній секрет → ''. */
function mpss_unsub_token(int $id, int $userId): string
{
    $secret = mpss_secret();
    if (strlen($secret) < 16) {
        return '';
    }
    $mac = hash_hmac('sha256', 'mpss-unsub|' . $id . '|' . $userId, $secret);

    return rtrim(strtr(base64_encode($id . '.' . $userId . '.' . $mac), '+/', '-_'), '=');
}

/** Перевірка токена (hash_equals). @return array{id:int,user_id:int}|null */
function mpss_unsub_verify(string $token): ?array
{
    if ($token === '' || strlen($token) > 200 || preg_match('/^[A-Za-z0-9_-]+$/', $token) !== 1) {
        return null;
    }
    $raw = base64_decode(strtr($token, '-_', '+/'), true);
    if (!is_string($raw) || preg_match('/^(\d{1,10})\.(\d{1,10})\.([a-f0-9]{64})$/', $raw, $m) !== 1) {
        return null;
    }
    $expected = mpss_unsub_token((int) $m[1], (int) $m[2]);
    if ($expected === '' || !hash_equals($expected, $token)) {
        return null;
    }

    return ['id' => (int) $m[1], 'user_id' => (int) $m[2]];
}

/** Вимкнути сповіщення за токеном (без входу). Повертає true, якщо токен справжній. */
function mpss_unsubscribe(PDO $pdo, string $token): bool
{
    $v = mpss_unsub_verify($token);
    if ($v === null) {
        return false;
    }
    $pdo->prepare('UPDATE mp_saved_searches SET notify_email = 0 WHERE id = :id AND user_id = :u')->execute([':id' => $v['id'], ':u' => $v['user_id']]);

    return true;
}

/**
 * Розсилка: не частіше 1 листа на добу на користувача, у листі — до 5 назв на пошук і лічильник, посилання на пошук
 * і на відписку; без контактів авторів. Не більше $batch листів за запуск.
 *
 * @return array{users:int,sent:int,skipped:int,failed:int,disabled:bool}
 */
function mpss_notify_run(PDO $pdo, int $batch, string $lang = 'uk', ?bool $enabledOverride = null): array
{
    $out = ['users' => 0, 'sent' => 0, 'skipped' => 0, 'failed' => 0, 'disabled' => false];
    // $enabledOverride — лише для локальних тестів (tests/mp-wave1-tests.php); скрипт cron його не передає.
    $enabled = $enabledOverride ?? !empty(mp_config()['saved_search_email_enabled']);
    if (!$enabled || strlen(mpss_secret()) < 16 || mpv_site_url() === null || !mpss_ready($pdo)) {
        $out['disabled'] = true;

        return $out;
    }
    $users = $pdo->query(
        'SELECT s.user_id, MAX(s.last_notified_at) AS last_sent
         FROM mp_saved_searches s
         WHERE s.notify_email = 1 AND s.is_active = 1
         GROUP BY s.user_id
         HAVING last_sent IS NULL OR last_sent <= NOW() - INTERVAL 1 DAY
         ORDER BY last_sent, s.user_id LIMIT ' . max(1, min(1000, $batch * 4))
    )->fetchAll(PDO::FETCH_ASSOC);
    $site = (string) mpv_site_url();
    foreach ($users as $u) {
        if ($out['sent'] >= $batch) {
            break;
        }
        $out['users']++;
        $uid = (int) $u['user_id'];
        $em = $pdo->prepare('SELECT email FROM users WHERE id = :u');
        $em->execute([':u' => $uid]);
        $email = (string) $em->fetchColumn();
        if ($email === '' || !filter_var($email, FILTER_VALIDATE_EMAIL) || !mpv_is_verified($pdo, $uid)) {
            $out['skipped']++;
            continue;
        }
        $st = $pdo->prepare('SELECT * FROM mp_saved_searches WHERE user_id = :u AND notify_email = 1 AND is_active = 1 ORDER BY id');
        $st->execute([':u' => $uid]);
        $blocks = [];
        foreach ($st->fetchAll(PDO::FETCH_ASSOC) as $row) {
            $s = mpss_decode((string) $row['params']);
            if ($s === null) {
                continue;
            }
            $since = (string) ($row['last_notified_at'] ?? $row['created_at']);
            $res = mpss_run($pdo, $s, $lang, $since, MPSS_MAIL_TITLES);
            if ($res['total'] > 0) {
                $blocks[] = ['row' => $row, 'total' => $res['total'], 'titles' => array_map(static fn($r) => (string) ($r['title'] ?? ''), $res['rows']),
                    'url' => $site . '/' . mpss_url($s), 'unsub' => $site . '/mp-saved.php?unsub=' . mpss_unsub_token((int) $row['id'], $uid)];
            }
        }
        // Позначка «опрацьовано зараз» — і коли нових немає (наступного разу шукаємо від цієї миті).
        $mark = static fn() => $pdo->prepare('UPDATE mp_saved_searches SET last_notified_at = NOW() WHERE user_id = :u AND notify_email = 1 AND is_active = 1')->execute([':u' => $uid]);
        if ($blocks === []) {
            $mark();
            $out['skipped']++;
            continue;
        }
        [$subject, $html, $text] = mpss_mail_body($blocks, $site);
        if (mpv_deliver($email, $subject, $html, $text)) {
            $mark();
            $out['sent']++;
        } else {
            $out['failed']++;
        }
    }

    return $out;
}

/** Лист-зведення. Лише назви оголошень, лічильники й посилання — жодних контактів. @return array{0:string,1:string,2:string} */
function mpss_mail_body(array $blocks, string $site): array
{
    $e = static fn(string $s): string => htmlspecialchars($s, ENT_QUOTES);
    $total = array_sum(array_column($blocks, 'total'));
    $subject = sprintf(t('mpss_mail_subject'), $total);
    $html = '<div style="font-family:Arial,sans-serif;color:#00032c;max-width:560px">'
        . '<h1 style="font-size:20px;color:#2116ad">' . $e(t('mpss_mail_heading')) . '</h1>';
    $text = t('mpss_mail_heading') . "\n\n";
    foreach ($blocks as $b) {
        $html .= '<h2 style="font-size:16px;margin:20px 0 6px">' . $e((string) $b['row']['title']) . ' — ' . $e(sprintf(t('mpss_new_n'), $b['total'])) . '</h2><ul>';
        $text .= $b['row']['title'] . ' — ' . sprintf(t('mpss_new_n'), $b['total']) . "\n";
        foreach ($b['titles'] as $title) {
            $html .= '<li>' . $e($title) . '</li>';
            $text .= '  • ' . $title . "\n";
        }
        $html .= '</ul><p><a href="' . $e($b['url']) . '" style="color:#2116ad">' . $e(t('mpss_mail_open')) . '</a> · '
            . '<a href="' . $e($b['unsub']) . '" style="color:#55577a">' . $e(t('mpss_mail_unsub')) . '</a></p>';
        $text .= t('mpss_mail_open') . ': ' . $b['url'] . "\n" . t('mpss_mail_unsub') . ': ' . $b['unsub'] . "\n\n";
    }
    $html .= '<p style="font-size:12px;color:#55577a">' . $e(t('mpss_mail_footer')) . ' <a href="' . $e($site . '/mp-saved.php') . '">' . $e(t('mpss_page_title')) . '</a></p></div>';
    $text .= t('mpss_mail_footer') . ' ' . $site . "/mp-saved.php\n";

    return [$subject, $html, $text];
}

/** Кнопка «Зберегти пошук» (форма POST на mp-saved.php) для поточної адреси. */
function mpss_button_html(string $currentUrl): string
{
    $uid = function_exists('auth_user_id') ? auth_user_id() : null;
    if ($uid === null) {
        return '<p class="mpss-save"><a class="mp-btn mpss-save__btn" href="' . mp_e(auth_login_url($currentUrl)) . '">'
            . '<span aria-hidden="true">☆</span> ' . mp_e(t('mpss_save_btn')) . '</a> <span class="mp-hint">' . mp_e(t('mpss_login_hint')) . '</span></p>';
    }

    return '<form class="mpss-save" method="post" action="mp-saved.php">' . mp_csrf_field()
        . '<input type="hidden" name="action" value="save"><input type="hidden" name="url" value="' . mp_e($currentUrl) . '">'
        . '<button class="mp-btn mpss-save__btn" type="submit"><span aria-hidden="true">☆</span> ' . mp_e(t('mpss_save_btn')) . '</button></form>';
}
