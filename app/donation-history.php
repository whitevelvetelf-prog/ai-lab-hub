<?php

declare(strict_types=1);

/**
 * AI LAB HUB — історія донатів (ручний облік).
 *
 * Донати йдуть повз сайт (банка / картка / IBAN за реквізитами з donate.php), тому адмін вносить
 * кожен запис вручну в CRM (public/crm-donations.php). Користувач бачить лише свої записи —
 * вибірка завжди за user_id із сесії, ніколи з запиту (кабінет → «Мої підтримки проєкту»).
 *
 * Суми — цілі в мінімальних одиницях: amount_minor — центи USD (валюта сайту),
 * original_amount_minor + original_currency — фактично сплачене, якщо відомо. Показ — formatMoney().
 * Жодних номерів карток чи реквізитів у таблиці donations (migration-2026-10-31-donations-history.sql).
 */

require_once __DIR__ . '/money.php';

const DONHIST_STATUSES = ['received', 'pending', 'refunded', 'cancelled'];
const DONHIST_METHODS = ['jar', 'card', 'iban_uah', 'iban_intl', 'other'];
const DONHIST_USER_PER_PAGE = 10;
const DONHIST_ADMIN_PER_PAGE = 25;

/** Таблиця donations уже є (міграцію застосовано)? */
function donhist_table_ok(PDO $pdo): bool
{
    static $ok = null;
    if ($ok === null) {
        try {
            $pdo->query('SELECT 1 FROM donations LIMIT 1');
            $ok = true;
        } catch (Throwable $e) {
            $ok = false;
        }
    }

    return $ok;
}

/** Сума з поля форми («12,50», «1 000.5», «500») → мінімальні одиниці; null — некоректно чи порожньо. */
function donhist_parse_amount(string $raw): ?int
{
    $s = str_replace([' ', "\u{00A0}", "\u{202F}"], '', trim($raw));
    $s = str_replace(',', '.', $s);
    if (!preg_match('/^(\d{1,9})(?:\.(\d{1,2}))?$/', $s, $m)) {
        return null;
    }
    $minor = (int) $m[1] * 100 + (int) str_pad($m[2] ?? '0', 2, '0');

    return $minor > 0 ? $minor : null;
}

/** «12,50 $ (500,00 ₴ сплачено)» — основна сума в USD і, якщо збережено, оригінальна. */
function donhist_amount_html(array $row, string $lang): string
{
    $html = htmlspecialchars(formatMoney($row['amount_minor'], 'USD', $lang), ENT_QUOTES);
    $cur = (string) ($row['original_currency'] ?? '');
    if ($row['original_amount_minor'] !== null && $cur !== '' && $cur !== 'USD') {
        $html .= '<span class="donhist-orig">' . htmlspecialchars(formatMoney($row['original_amount_minor'], $cur, $lang) . ' ' . t('donhist_paid'), ENT_QUOTES) . '</span>';
    }

    return $html;
}

function donhist_date(string $datetime, string $lang): string
{
    $ts = strtotime($datetime);

    return $ts === false ? '' : date($lang === 'en' ? 'M j, Y' : 'd.m.Y', $ts);
}

/**
 * Сторінка донатів одного користувача (нові зверху).
 *
 * @return array{rows:list<array>,total:int,pages:int,page:int,received_minor:int}
 */
function donhist_user_page(PDO $pdo, int $userId, int $page): array
{
    $out = ['rows' => [], 'total' => 0, 'pages' => 1, 'page' => 1, 'received_minor' => 0];
    if (!donhist_table_ok($pdo)) {
        return $out;
    }
    $st = $pdo->prepare("SELECT COUNT(*), COALESCE(SUM(CASE WHEN status = 'received' THEN amount_minor END), 0) FROM donations WHERE user_id = :u");
    $st->execute([':u' => $userId]);
    [$total, $received] = $st->fetch(PDO::FETCH_NUM);
    $out['total'] = (int) $total;
    $out['received_minor'] = (int) $received;
    $out['pages'] = max(1, (int) ceil($out['total'] / DONHIST_USER_PER_PAGE));
    $out['page'] = min(max(1, $page), $out['pages']);
    if ($out['total'] === 0) {
        return $out;
    }
    $st = $pdo->prepare(
        'SELECT id, amount_minor, original_amount_minor, original_currency, status, method, donated_at
         FROM donations WHERE user_id = :u ORDER BY donated_at DESC, id DESC LIMIT ' . DONHIST_USER_PER_PAGE . ' OFFSET ' . (($out['page'] - 1) * DONHIST_USER_PER_PAGE)
    );
    $st->execute([':u' => $userId]);
    $out['rows'] = $st->fetchAll(PDO::FETCH_ASSOC);

    return $out;
}

/**
 * Нормалізовані фільтри CRM із $_GET.
 *
 * @return array{from:string,to:string,status:string,page:int}
 */
function donhist_admin_filters(array $q): array
{
    $date = static fn($v): string => is_string($v) && preg_match('/^\d{4}-\d{2}-\d{2}$/', $v) && strtotime($v) !== false ? $v : '';
    $status = is_string($q['status'] ?? null) && in_array($q['status'], DONHIST_STATUSES, true) ? $q['status'] : '';

    return ['from' => $date($q['from'] ?? null), 'to' => $date($q['to'] ?? null), 'status' => $status, 'page' => max(1, (int) ($q['page'] ?? 1))];
}

/**
 * Усі донати для CRM з фільтрами за датою й статусом.
 *
 * @return array{rows:list<array>,total:int,pages:int,page:int,sum_minor:int}
 */
function donhist_admin_list(PDO $pdo, array $f): array
{
    $where = [];
    $params = [];
    if ($f['from'] !== '') {
        $where[] = 'd.donated_at >= :from';
        $params[':from'] = $f['from'] . ' 00:00:00';
    }
    if ($f['to'] !== '') {
        $where[] = 'd.donated_at <= :to';
        $params[':to'] = $f['to'] . ' 23:59:59';
    }
    if ($f['status'] !== '') {
        $where[] = 'd.status = :status';
        $params[':status'] = $f['status'];
    }
    $sqlWhere = $where === [] ? '' : ' WHERE ' . implode(' AND ', $where);

    $st = $pdo->prepare('SELECT COUNT(*), COALESCE(SUM(d.amount_minor), 0) FROM donations d' . $sqlWhere);
    $st->execute($params);
    [$total, $sum] = $st->fetch(PDO::FETCH_NUM);
    $pages = max(1, (int) ceil((int) $total / DONHIST_ADMIN_PER_PAGE));
    $page = min($f['page'], $pages);

    $st = $pdo->prepare(
        'SELECT d.*, u.name AS user_name, u.email AS user_email
         FROM donations d LEFT JOIN users u ON u.id = d.user_id' . $sqlWhere .
        ' ORDER BY d.donated_at DESC, d.id DESC LIMIT ' . DONHIST_ADMIN_PER_PAGE . ' OFFSET ' . (($page - 1) * DONHIST_ADMIN_PER_PAGE)
    );
    $st->execute($params);

    return ['rows' => $st->fetchAll(PDO::FETCH_ASSOC), 'total' => (int) $total, 'pages' => $pages, 'page' => $page, 'sum_minor' => (int) $sum];
}

/**
 * Перевірити форму «Додати донат».
 *
 * @return array{0:array<string,mixed>|null,1:list<string>} [рядок для INSERT, помилки]
 */
function donhist_validate(PDO $pdo, array $in): array
{
    $str = static fn(string $k): string => trim(is_string($in[$k] ?? null) ? $in[$k] : '');
    $errors = [];

    $date = $str('donated_at');
    $ts = preg_match('/^\d{4}-\d{2}-\d{2}$/', $date) ? strtotime($date . ' 12:00:00') : false;
    if ($ts === false) {
        $errors[] = 'Дата: оберіть дату донату.';
    } elseif ($ts > time() + 86400) {
        $errors[] = 'Дата: донат не може бути з майбутнього.';
    }

    $origRaw = $str('original_amount');
    $currency = strtoupper($str('original_currency'));
    $orig = null;
    if ($origRaw !== '') {
        $orig = donhist_parse_amount($origRaw);
        if ($orig === null) {
            $errors[] = 'Оригінальна сума: число більше нуля, до 2 знаків після коми.';
        }
        if (!preg_match('/^[A-Z]{3}$/', $currency)) {
            $errors[] = 'Валюта: три латинські літери (UAH, EUR…).';
        }
    }

    $usdRaw = $str('amount_usd');
    $usd = null;
    if ($usdRaw !== '') {
        $usd = donhist_parse_amount($usdRaw);
        if ($usd === null) {
            $errors[] = 'Сума в USD: число більше нуля, до 2 знаків після коми.';
        }
    } elseif ($orig !== null && $currency === 'USD') {
        $usd = $orig;
    } elseif ($orig !== null && $currency !== '') {
        // Порожня сума в USD — перераховуємо за офіційним курсом (лише валюти з app/fx.php, зараз UAH).
        require_once __DIR__ . '/fx.php';
        $rate = fx_currency_allowed($currency) ? fx_usd_rate($pdo, $currency) : null;
        if ($rate !== null) {
            $usd = fx_to_usd_cents($orig, $rate['micro']);
        } else {
            $errors[] = "Сума в USD: для {$currency} курс автоматично не рахується — введіть суму в доларах.";
        }
    } else {
        $errors[] = 'Сума в USD: обов’язкова (або вкажіть оригінальну суму в UAH — перерахуємо за курсом НБУ).';
    }

    $status = $str('status');
    if (!in_array($status, DONHIST_STATUSES, true)) {
        $errors[] = 'Статус: оберіть зі списку.';
    }
    $method = $str('method');
    if (!in_array($method, DONHIST_METHODS, true)) {
        $errors[] = 'Спосіб оплати: оберіть зі списку.';
    }

    $userId = null;
    $email = $str('user_email');
    if ($email !== '') {
        $st = $pdo->prepare('SELECT id FROM users WHERE email = :e');
        $st->execute([':e' => $email]);
        $found = $st->fetchColumn();
        if ($found === false) {
            $errors[] = 'Користувача з таким e-mail немає. Залиште поле порожнім, якщо донат анонімний.';
        } else {
            $userId = (int) $found;
        }
    }

    $donor = trim(preg_replace('/\s+/u', ' ', strip_tags($str('donor_name'))) ?? '');
    $note = trim(preg_replace('/\s+/u', ' ', strip_tags($str('note'))) ?? '');
    if (mb_strlen($donor) > 100) {
        $errors[] = 'Ім’я донора: не довше 100 символів.';
    }
    if (mb_strlen($note) > 255) {
        $errors[] = 'Примітка: не довше 255 символів.';
    }
    // Захист від випадкового збереження номера картки / IBAN у вільних полях.
    foreach (['Ім’я донора' => $donor, 'Примітка' => $note] as $label => $text) {
        if (preg_match('/\d(?:[\s-]?\d){12,}/', $text) || preg_match('/\b[A-Z]{2}\d{2}[A-Z0-9]{11,30}\b/', strtoupper(str_replace(' ', '', $text)))) {
            $errors[] = "{$label}: схоже на номер картки чи IBAN — такі дані не зберігаємо.";
        }
    }

    if ($errors !== []) {
        return [null, $errors];
    }

    return [[
        ':user_id' => $userId,
        ':donor_name' => $donor !== '' ? $donor : null,
        ':amount' => $usd,
        ':orig' => $orig,
        ':cur' => $orig !== null ? $currency : null,
        ':status' => $status,
        ':method' => $method,
        ':donated_at' => date('Y-m-d 12:00:00', (int) $ts),
        ':note' => $note !== '' ? $note : null,
    ], []];
}

function donhist_insert(PDO $pdo, array $row, int $adminId): void
{
    $pdo->prepare(
        'INSERT INTO donations (user_id, donor_name, amount_minor, original_amount_minor, original_currency, status, method, donated_at, note, created_by)
         VALUES (:user_id, :donor_name, :amount, :orig, :cur, :status, :method, :donated_at, :note, :created_by)'
    )->execute($row + [':created_by' => $adminId]);
}

function donhist_set_status(PDO $pdo, int $id, string $status): bool
{
    if (!in_array($status, DONHIST_STATUSES, true)) {
        return false;
    }
    $st = $pdo->prepare('UPDATE donations SET status = :s WHERE id = :id');
    $st->execute([':s' => $status, ':id' => $id]);

    return true;
}

function donhist_delete(PDO $pdo, int $id): void
{
    $pdo->prepare('DELETE FROM donations WHERE id = :id')->execute([':id' => $id]);
}

/** Кнопка «Підтримати проєкт» (стилі .support-btn — app/footer.php). */
function support_button_html(string $extraClass = ''): string
{
    return '<a class="support-btn' . ($extraClass !== '' ? ' ' . $extraClass : '') . '" href="donate.php">'
        . '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M19 14c1.49-1.46 3-3.21 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.76 0-3 .5-4.5 2-1.5-1.5-2.74-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.3 1.5 4.05 3 5.5l7 7Z"/></svg>'
        . '<span>' . htmlspecialchars(t('support_cta_btn'), ENT_QUOTES) . '</span></a>';
}

/** Акордеон «Мої підтримки проєкту» в кабінеті — лише записи поточного користувача. */
function donhist_account_render(PDO $pdo, array $user): void
{
    $lang = current_lang();
    $page = isset($_GET['dpage']) ? (int) $_GET['dpage'] : 1;
    $data = donhist_user_page($pdo, (int) $user['id'], $page);
    $e = static fn(mixed $v): string => htmlspecialchars((string) $v, ENT_QUOTES);
    $pageUrl = static fn(int $p): string => 'account.php?dpage=' . $p . '#acc-donations';
    ?>
            <div class="accordion" id="acc-donations">
                <button type="button" class="accordion__header" aria-expanded="false" aria-controls="acc-donations-panel">
                    <span class="accordion__title"><?= $e(t('donhist_title')) ?><?= $data['total'] > 0 ? ' · ' . $data['total'] : '' ?></span>
                    <span class="accordion__chevron" aria-hidden="true">&#9662;</span>
                </button>
                <div class="accordion__panel" id="acc-donations-panel">
                    <div class="accordion__panel-inner donhist">
                        <?php if ($data['total'] === 0): ?>
                        <p class="donhist-empty"><?= $e(t('donhist_empty')) ?></p>
                        <?= support_button_html() ?>
                        <?php else: ?>
                        <?php if ($data['received_minor'] > 0): ?>
                        <p class="donhist-total"><?= $e(sprintf(t('donhist_total'), formatMoney($data['received_minor'], 'USD', $lang))) ?></p>
                        <?php endif; ?>
                        <div class="donhist-wrap">
                            <table class="donhist-table">
                                <thead><tr>
                                    <th><?= $e(t('donhist_col_date')) ?></th>
                                    <th><?= $e(t('donhist_col_amount')) ?></th>
                                    <th><?= $e(t('donhist_col_status')) ?></th>
                                    <th><?= $e(t('donhist_col_method')) ?></th>
                                </tr></thead>
                                <tbody>
                                <?php foreach ($data['rows'] as $r): ?>
                                <tr>
                                    <td data-label="<?= $e(t('donhist_col_date')) ?>"><?= $e(donhist_date($r['donated_at'], $lang)) ?></td>
                                    <td data-label="<?= $e(t('donhist_col_amount')) ?>" class="donhist-amount"><?= donhist_amount_html($r, $lang) ?></td>
                                    <td data-label="<?= $e(t('donhist_col_status')) ?>"><span class="donhist-status donhist-status--<?= $e($r['status']) ?>"><?= $e(t('donhist_status_' . $r['status'])) ?></span></td>
                                    <td data-label="<?= $e(t('donhist_col_method')) ?>"><?= $e(t('donhist_method_' . $r['method'])) ?></td>
                                </tr>
                                <?php endforeach; ?>
                                </tbody>
                            </table>
                        </div>
                        <?php if ($data['pages'] > 1): ?>
                        <nav class="donhist-pager" aria-label="<?= $e(t('donhist_title')) ?>">
                            <?php if ($data['page'] > 1): ?><a href="<?= $e($pageUrl($data['page'] - 1)) ?>"><?= $e(t('donhist_prev')) ?></a><?php endif; ?>
                            <span><?= $e(sprintf(t('donhist_page'), $data['page'], $data['pages'])) ?></span>
                            <?php if ($data['page'] < $data['pages']): ?><a href="<?= $e($pageUrl($data['page'] + 1)) ?>"><?= $e(t('donhist_next')) ?></a><?php endif; ?>
                        </nav>
                        <?php endif; ?>
                        <?php endif; ?>
                        <p class="donhist-note"><?= $e(t('donhist_note')) ?></p>
                    </div>
                </div>
            </div>
            <style>
                .donhist-empty, .donhist-total { margin: 0 0 14px; }
                .donhist-total { font-weight: 700; }
                .donhist-note { margin: 14px 0 0; font-size: 0.85rem; color: rgba(255, 255, 255, 0.7); }
                .donhist-wrap { overflow-x: auto; border: 1px solid rgba(255, 255, 255, 0.14); border-radius: 12px; }
                .donhist-table { width: 100%; border-collapse: collapse; font-size: 0.93rem; }
                .donhist-table th, .donhist-table td { padding: 9px 12px; text-align: left; vertical-align: top; border-bottom: 1px solid rgba(255, 255, 255, 0.12); }
                .donhist-table th { font-size: 0.82rem; font-weight: 600; color: rgba(255, 255, 255, 0.72); }
                .donhist-table tr:last-child td { border-bottom: 0; }
                .donhist-amount { font-weight: 700; white-space: nowrap; }
                .donhist-orig { display: block; font-weight: 400; font-size: 0.82rem; color: rgba(255, 255, 255, 0.72); }
                .donhist-status { display: inline-block; padding: 2px 10px; border-radius: 999px; font-size: 0.82rem; background: rgba(255, 255, 255, 0.1); }
                .donhist-status--received { background: rgba(52, 211, 153, 0.18); color: #b6f5dc; }
                .donhist-status--pending { background: rgba(143, 180, 255, 0.2); color: #d6e3ff; }
                .donhist-pager { display: flex; flex-wrap: wrap; gap: 8px 16px; align-items: center; justify-content: center; margin-top: 14px; font-size: 0.9rem; }
                .donhist-pager a { color: #bcd0ff; }
                @media (max-width: 560px) {
                    .donhist-wrap { border: 0; overflow: visible; }
                    .donhist-table thead { display: none; }
                    .donhist-table, .donhist-table tbody, .donhist-table tr, .donhist-table td { display: block; width: 100%; }
                    .donhist-table tr { padding: 10px 12px; margin-bottom: 10px; border: 1px solid rgba(255, 255, 255, 0.14); border-radius: 12px; }
                    .donhist-table td { display: flex; justify-content: space-between; gap: 12px; padding: 4px 0; border: 0; text-align: right; }
                    .donhist-table td::before { content: attr(data-label); color: rgba(255, 255, 255, 0.72); font-weight: 400; text-align: left; }
                    .donhist-table td.donhist-amount { flex-wrap: wrap; }
                    .donhist-table td.donhist-amount .donhist-orig { flex-basis: 100%; }
                    .donhist-table tr:last-child td { border: 0; }
                }
            </style>
    <?php
}
