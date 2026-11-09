<?php

declare(strict_types=1);

/**
 * AI LAB HUB — популярні запити (Хвиля 1): агрегати search_query_stats і ручні рішення search_query_overrides
 * (міграція 2026-11-09, № 20).
 *
 *   Запис — mpq_record(): лише після пошуку з результатом > 0, не частіше 1 разу за сесію на запит на день
 *   (позначка в $_SESSION), INSERT … ON DUPLICATE KEY UPDATE hits = hits + 1. Без IP, без користувача, без сесії
 *   в таблиці — лише (scope, нормалізований запит, дата, лічильник). Боти не рахуються.
 *   Не записуються запити з «@», з 6+ цифрами поспіль і з посиланнями (персональні дані).
 *   Нормалізація: нижній регістр, обрізка й стиснення пробілів, до 60 символів.
 *   Чипи — mpq_chips(): спершу закріплені (pin, за sort_order), далі найчастіші за 30 днів з hits ≥ popular_min_hits,
 *   разом до 8, без прихованих (hide). Підпис — label_uk / label_en мовою інтерфейсу, запасний — сам запит.
 *   Scope 'catalog' закладено в структуру, але запис і чипи для каталогу не ввімкнені (popular_queries_catalog=false).
 *   Очищення > 90 днів — mpq_cleanup() у public/mp-cron-expire.php.
 */

require_once __DIR__ . '/marketplace.php';
require_once __DIR__ . '/analytics.php';

const MPQ_SCOPES = ['marketplace', 'catalog'];
const MPQ_MAX_LEN = 60;
const MPQ_DAYS = 30;
const MPQ_CHIPS = 8;
const MPQ_KEEP_DAYS = 90;

/** Нормалізований запит або '' (порожній / персональні дані / посилання — не записується). */
function mpq_normalize(string $q): string
{
    $q = trim((string) preg_replace('/\s+/u', ' ', $q));
    if ($q === '' || !mpq_allowed($q)) {
        return '';
    }
    $q = mb_strtolower($q);
    $q = trim(mb_substr($q, 0, MPQ_MAX_LEN));

    return mb_strlen($q) >= 2 ? $q : '';
}

/** Чи можна записувати запит: без «@», без 6+ цифр поспіль, без посилань. */
function mpq_allowed(string $q): bool
{
    if (str_contains($q, '@') || preg_match('/\d{6,}/u', (string) preg_replace('/[\s\-()+.]/u', '', $q)) === 1) {
        return false;
    }
    if (preg_match('~https?://|www\.|://|\b[\p{L}\d-]+\.(?:com|net|org|ua|io|ai|me|info|biz|ru|co|app|dev|site|online|shop|pl|de|uk)\b~iu', $q) === 1) {
        return false;
    }

    return true;
}

/** Чи готові таблиці. */
function mpq_ready(PDO $pdo): bool
{
    static $ready = null;
    if ($ready === null) {
        $ready = function_exists('mpt_table_exists')
            ? mpt_table_exists($pdo, 'search_query_stats') && mpt_table_exists($pdo, 'search_query_overrides')
            : false;
    }

    return $ready;
}

/**
 * Записати успішний пошук. $results — кількість знайдених (0 → не записується).
 * Сесійна позначка не дає рахувати повтор того самого запиту того ж дня.
 */
function mpq_record(PDO $pdo, string $scope, string $query, int $results): void
{
    if ($results <= 0 || !in_array($scope, MPQ_SCOPES, true)) {
        return;
    }
    if ($scope === 'catalog' && empty(mp_config()['popular_queries_catalog'])) {
        return;
    }
    if (analytics_device_class() === 'bot' || ($_SERVER['REQUEST_METHOD'] ?? 'GET') === 'HEAD') {
        return;
    }
    $norm = mpq_normalize($query);
    if ($norm === '' || !mpq_ready($pdo)) {
        return;
    }
    $day = date('Y-m-d');
    $key = hash('sha256', $scope . '|' . $norm . '|' . $day);
    if (!isset($_SESSION) || !is_array($_SESSION)) {
        return;   // без сесії не можемо гарантувати «один раз за сесію»
    }
    $seen = is_array($_SESSION['mpq_seen'] ?? null) ? $_SESSION['mpq_seen'] : [];
    if (isset($seen[$key])) {
        return;
    }
    // Лише сьогоднішні позначки (сесія не росте безмежно).
    $seen = array_filter($seen, static fn($d): bool => $d === $day);
    $seen[$key] = $day;
    $_SESSION['mpq_seen'] = array_slice($seen, -200, null, true);
    try {
        $pdo->prepare(
            'INSERT INTO search_query_stats (scope, query_norm, stat_date, hits) VALUES (:s, :q, CURDATE(), 1)
             ON DUPLICATE KEY UPDATE hits = hits + 1'
        )->execute([':s' => $scope, ':q' => $norm]);
    } catch (Throwable $e) {
        error_log('[mp-popular] ' . $e->getMessage());
    }
}

/**
 * Чипи популярних запитів: list<array{query:string,label:string}>.
 */
function mpq_chips(PDO $pdo, string $scope, string $lang, ?int $minHits = null, int $limit = MPQ_CHIPS): array
{
    if (!mpq_ready($pdo) || !in_array($scope, MPQ_SCOPES, true)) {
        return [];
    }
    $minHits ??= max(1, (int) (mp_config()['popular_min_hits'] ?? 10));
    $labelCol = $lang === 'en' ? 'label_en' : 'label_uk';
    $out = [];
    $taken = [];
    try {
        $pin = $pdo->prepare("SELECT query_norm, $labelCol AS label FROM search_query_overrides
                              WHERE scope = :s AND status = 'pin' ORDER BY sort_order, id LIMIT " . (int) $limit);
        $pin->execute([':s' => $scope]);
        foreach ($pin->fetchAll(PDO::FETCH_ASSOC) as $r) {
            $q = (string) $r['query_norm'];
            $out[] = ['query' => $q, 'label' => trim((string) $r['label']) !== '' ? (string) $r['label'] : $q];
            $taken[$q] = true;
        }
        if (count($out) < $limit) {
            $auto = $pdo->prepare(
                "SELECT s.query_norm, SUM(s.hits) AS h, MAX(o.$labelCol) AS label
                 FROM search_query_stats s
                 LEFT JOIN search_query_overrides o ON o.scope = s.scope AND o.query_norm = s.query_norm
                 WHERE s.scope = :s AND s.stat_date >= CURDATE() - INTERVAL " . MPQ_DAYS . " DAY
                   AND COALESCE(o.status, '') NOT IN ('hide', 'pin')
                 GROUP BY s.query_norm HAVING h >= :m ORDER BY h DESC, s.query_norm LIMIT " . (int) ($limit * 2)
            );
            $auto->execute([':s' => $scope, ':m' => $minHits]);
            foreach ($auto->fetchAll(PDO::FETCH_ASSOC) as $r) {
                $q = (string) $r['query_norm'];
                if (isset($taken[$q]) || !mpq_allowed($q) || count($out) >= $limit) {
                    continue;
                }
                $out[] = ['query' => $q, 'label' => trim((string) $r['label']) !== '' ? (string) $r['label'] : $q];
                $taken[$q] = true;
            }
        }
    } catch (Throwable $e) {
        error_log('[mp-popular] chips: ' . $e->getMessage());

        return [];
    }

    return $out;
}

/** HTML блока чипів під пошуком ('' — чипів немає, блок не показується). $url — fn(string $q): string. */
function mpq_chips_html(array $chips, callable $url): string
{
    if ($chips === []) {
        return '';
    }
    $html = '<nav class="mpq-chips" aria-label="' . mp_e(t('mpq_title')) . '"><span class="mpq-chips__title">' . mp_e(t('mpq_title')) . '</span>';
    foreach ($chips as $c) {
        $html .= '<a class="mpq-chip" href="' . mp_e($url($c['query'])) . '">' . mp_e($c['label']) . '</a>';
    }

    return $html . '</nav>';
}

/** Запити за 30 днів для адмінки разом із ручними рішеннями. @return list<array<string,mixed>> */
function mpq_admin_rows(PDO $pdo, string $scope): array
{
    $st = $pdo->prepare(
        "SELECT q.query_norm, COALESCE(h.hits, 0) AS hits, COALESCE(o.status, '') AS status, COALESCE(o.sort_order, 0) AS sort_order,
                COALESCE(o.label_uk, '') AS label_uk, COALESCE(o.label_en, '') AS label_en
         FROM (SELECT query_norm FROM search_query_stats WHERE scope = :s1 AND stat_date >= CURDATE() - INTERVAL " . MPQ_DAYS . " DAY
               UNION SELECT query_norm FROM search_query_overrides WHERE scope = :s2 AND status <> '') q
         LEFT JOIN (SELECT query_norm, SUM(hits) AS hits FROM search_query_stats
                    WHERE scope = :s3 AND stat_date >= CURDATE() - INTERVAL " . MPQ_DAYS . " DAY GROUP BY query_norm) h ON h.query_norm = q.query_norm
         LEFT JOIN search_query_overrides o ON o.scope = :s4 AND o.query_norm = q.query_norm
         ORDER BY (COALESCE(o.status, '') = 'pin') DESC, hits DESC, q.query_norm LIMIT 300"
    );
    $st->execute([':s1' => $scope, ':s2' => $scope, ':s3' => $scope, ':s4' => $scope]);

    return $st->fetchAll(PDO::FETCH_ASSOC);
}

/**
 * Зберегти ручне рішення адміна: status pin | hide | '' (без рішення), порядок і мітки.
 * Рядки не видаляються: «зняти» = status ''.
 */
function mpq_admin_save(PDO $pdo, string $scope, string $query, string $status, int $sort, string $labelUk, string $labelEn): bool
{
    $norm = mpq_normalize($query);
    if ($norm === '' || !in_array($scope, MPQ_SCOPES, true) || !in_array($status, ['pin', 'hide', ''], true)) {
        return false;
    }
    $clean = static fn(string $s): ?string => ($s = trim(mb_substr((string) preg_replace('/\s+/u', ' ', strip_tags($s)), 0, MPQ_MAX_LEN))) !== '' ? $s : null;
    $pdo->prepare(
        'INSERT INTO search_query_overrides (scope, query_norm, status, sort_order, label_uk, label_en, updated_at)
         VALUES (:s, :q, :st, :o, :lu, :le, NOW())
         ON DUPLICATE KEY UPDATE status = VALUES(status), sort_order = VALUES(sort_order), label_uk = VALUES(label_uk),
                                 label_en = VALUES(label_en), updated_at = NOW()'
    )->execute([':s' => $scope, ':q' => $norm, ':st' => $status, ':o' => max(-999, min(999, $sort)),
        ':lu' => $clean($labelUk), ':le' => $clean($labelEn)]);

    return true;
}

/** Очищення агрегатів старших за 90 днів (єдиний DELETE модуля). Повертає кількість видалених рядків. */
function mpq_cleanup(PDO $pdo): int
{
    if (!mpq_ready($pdo)) {
        return 0;
    }
    $st = $pdo->prepare('DELETE FROM search_query_stats WHERE stat_date < CURDATE() - INTERVAL ' . MPQ_KEEP_DAYS . ' DAY');
    $st->execute();

    return $st->rowCount();
}
