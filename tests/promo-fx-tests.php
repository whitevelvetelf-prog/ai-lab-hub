<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тести поповнення в гривнях з конвертацією в USD (app/fx.php, app/money.php,
 * promo_request_topup, promo_admin_topup_decide), без живої мережі (курс НБУ підміняється).
 *   php tests/promo-fx-tests.php
 * Лише CLI. Створює тимчасового користувача й заявки й прибирає все за собою; кеш курсу й
 * налаштування реклами повертаються як були.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

require_once __DIR__ . '/../app/auth.php';   // сесія — до будь-якого виводу
require_once __DIR__ . '/../app/promo-admin.php';

$fails = 0;
$total = 0;
function check(bool $cond, string $label): void
{
    global $fails, $total;
    $total++;
    echo ($cond ? '  OK   ' : '  FAIL ') . $label . "\n";
    if (!$cond) {
        $fails++;
    }
}

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

echo "Форматування (formatMoney)\n";
check(formatMoney(1000, 'USD', 'uk') === '10,00 $', 'USD UA: 10,00 $');
check(formatMoney(1000, 'USD', 'en') === '$10.00', 'USD EN: $10.00');
check(formatMoney(100000, 'UAH', 'uk') === '1 000,00 ₴', 'UAH UA: 1 000,00 ₴');
check(formatMoney(100000, 'UAH', 'en') === '₴1,000.00', 'UAH EN: ₴1,000.00');
check(formatMoney(-2550, 'USD', 'uk') === '−25,50 $', 'мінус: −25,50 $');
check(formatMoney(5, 'EUR', 'uk') === '0,05 EUR', 'інша валюта — кодом');
check(formatRate('44.852600', 'uk') === '44,8526' && formatRate('45.000000', 'en') === '45.00', 'курс без зайвих нулів');

echo "Конвертація (цілі числа, вниз)\n";
check(fx_rate_micro('44.8526') === 44852600 && fx_rate_string(44852600) === '44.852600', 'курс → мільйонні й назад');
check(fx_to_usd_cents(1000, 44852600) === 22, '10,00 ₴ → 22 центи (22,29 вниз)');
check(fx_to_usd_cents(100000, 44852600) === 2229, '1 000,00 ₴ → 2229 центів');
check(fx_to_usd_cents(2000, 44852600) === 44, '20,00 ₴ → 44 центи (баланс #18 на проді)');
check(fx_from_usd_cents(1000, 44852600) === 44853, '$10 мінімуму ≈ 448,53 ₴ (вгору)');
check(!fx_currency_allowed('EUR') && fx_currency_allowed('UAH'), 'allowlist: лише UAH');

// --- Збереження стану й тимчасові дані ---------------------------------------
$oldFx = $pdo->query("SELECT * FROM fx_rates WHERE currency = 'UAH'")->fetch() ?: null;
$oldSettings = $pdo->query("SELECT setting_key, setting_value FROM ad_settings WHERE setting_key IN ('payment_jar_url', 'min_topup')")->fetchAll(PDO::FETCH_KEY_PAIR);
$mailBefore = (int) $pdo->query('SELECT COALESCE(MAX(id), 0) FROM mail_queue')->fetchColumn();   // листи тесту (рекламодавцю й адміну) — прибрати
$email = 'fx-test-' . bin2hex(random_bytes(4)) . '@example.test';
$pdo->prepare('INSERT INTO users (name, email, password_hash) VALUES (:n, :e, :p)')->execute([':n' => 'FX test', ':e' => $email, ':p' => 'x']);
$uid = (int) $pdo->lastInsertId();
$setSetting = static function (string $k, string $v) use ($pdo): void {
    $pdo->prepare('INSERT INTO ad_settings (setting_key, setting_value) VALUES (:k, :v) ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value)')
        ->execute([':k' => $k, ':v' => $v]);
};
$setSetting('payment_jar_url', 'https://send.monobank.ua/jar/test');
$setSetting('min_topup', '1');
$calls = 0;
$GLOBALS['fx_fetch'] = static function () use (&$calls): ?array {
    $calls++;

    return ['rate' => '44.8526', 'date' => '2026-10-22'];
};

try {
    echo "Курс і кеш\n";
    $pdo->exec("DELETE FROM fx_rates WHERE currency = 'UAH'");
    $r = fx_usd_rate($pdo, 'UAH');
    check($r !== null && $r['micro'] === 44852600 && $r['source'] === 'NBU' && $calls === 1, 'курс отримано з джерела й закешовано');
    fx_usd_rate($pdo, 'UAH');
    check($calls === 1, 'свіжий кеш (до 1 год) — без повторного запиту');
    check(fx_usd_rate($pdo, 'EUR') === null, 'валюта поза allowlist — null');
    $GLOBALS['fx_fetch'] = static fn(): ?array => null;   // НБУ «не відповідає»
    $pdo->exec("UPDATE fx_rates SET fetched_at = NOW() - INTERVAL 2 HOUR WHERE currency = 'UAH'");
    check(fx_usd_rate($pdo, 'UAH') !== null, 'джерело недоступне, кешу 2 год — кешований курс');
    $pdo->exec("UPDATE fx_rates SET fetched_at = NOW() - INTERVAL 25 HOUR WHERE currency = 'UAH'");
    check(fx_usd_rate($pdo, 'UAH') === null, 'джерело недоступне, кешу 25 год — курсу немає');
    [$ok, $msg] = promo_request_topup($pdo, $uid, '1000');
    check(!$ok && $msg === 'err_topup_rate', 'заявка без курсу — «оплата тимчасово недоступна»');
    check((int) $pdo->query('SELECT COUNT(*) FROM ad_transactions WHERE user_id = ' . $uid)->fetchColumn() === 0, '…і заявки не створено');

    echo "Заявка й підтвердження\n";
    $GLOBALS['fx_fetch'] = static fn(): ?array => ['rate' => '44.8526', 'date' => '2026-10-22'];
    $pdo->exec("UPDATE fx_rates SET fetched_at = NOW() - INTERVAL 2 HOUR WHERE currency = 'UAH'");   // кеш застарів — оновиться
    [$ok, $msg, $req] = promo_request_topup($pdo, $uid, '1 000,00');
    $tx = $pdo->query('SELECT * FROM ad_transactions WHERE id = ' . (int) ($req['id'] ?? 0))->fetch();
    check($ok && $tx && (int) $tx['amount'] === 2229 && $tx['currency'] === 'USD' && (int) $tx['credited_usd'] === 2229
        && (int) $tx['original_amount'] === 100000 && $tx['original_currency'] === 'UAH' && $tx['fx_rate'] === '44.852600'
        && $tx['fx_rate_source'] === 'NBU' && $tx['fx_rate_at'] === '2026-10-22', 'заявка 1 000 ₴: курс зафіксовано, 22,29 $ до зарахування');
    $GLOBALS['__force_lang'] = null;
    check(promo_tx_money($tx)['main'] === '22,29 $' && str_contains((string) promo_tx_money($tx)['original'], '1 000,00 ₴'), 'показ: 22,29 $, оригінал 1 000,00 ₴');
    // Курс змінився після заявки — зарахування однаково за зафіксованим.
    $pdo->exec("UPDATE fx_rates SET rate = 50.000000 WHERE currency = 'UAH'");
    [$ok] = promo_admin_topup_decide($pdo, 1, (int) $tx['id'], true, '');
    check(!$ok, 'підтвердження без «фактично надійшло» — відмова');
    [$ok, $msg] = promo_admin_topup_decide($pdo, 1, (int) $tx['id'], true, '', '1000');
    check($ok && promo_balance($pdo, $uid) === 2229 && promo_balance_currency($pdo, $uid) === 'USD', 'надійшло 1000 ₴ — на баланс 22,29 $ за курсом заявки (не 50)');
    [$ok] = promo_admin_topup_decide($pdo, 1, (int) $tx['id'], true, '', '1000');
    check(!$ok && promo_balance($pdo, $uid) === 2229, 'повторне підтвердження нічого не нараховує');

    echo "Розбіжність суми\n";
    $pdo->exec('DELETE FROM ad_rate_limits WHERE user_id = ' . $uid);
    $pdo->exec("UPDATE fx_rates SET rate = 44.852600 WHERE currency = 'UAH'");   // нова заявка — за поточним курсом
    [$ok, , $req2] = promo_request_topup($pdo, $uid, '1000');
    $id2 = (int) ($req2['id'] ?? 0);
    [$ok, $msg] = promo_admin_topup_decide($pdo, 1, $id2, true, '', '900');
    check(!$ok && str_contains($msg, 'нічого не зараховано') && promo_balance($pdo, $uid) === 2229, 'надійшло 900 замість 1000 — без позначки нічого не зараховано');
    [$ok, $msg] = promo_admin_topup_decide($pdo, 1, $id2, true, '', '900', true);
    $t2 = $pdo->query('SELECT * FROM ad_transactions WHERE id = ' . $id2)->fetch();
    check($ok && (int) $t2['credited_usd'] === 2006 && (int) $t2['original_amount'] === 90000 && promo_balance($pdo, $uid) === 2229 + 2006,
        'з позначкою — 900 ₴ за курсом заявки = 20,06 $');

    echo "Відхилення\n";
    $pdo->exec('DELETE FROM ad_rate_limits WHERE user_id = ' . $uid);
    [, , $req3] = promo_request_topup($pdo, $uid, '500');
    [$ok] = promo_admin_topup_decide($pdo, 1, (int) $req3['id'], false, 'тест');
    check($ok && promo_balance($pdo, $uid) === 4235, 'відхилена заявка баланс не змінює');
} finally {
    $pdo->prepare('DELETE FROM ad_transactions WHERE user_id = :u')->execute([':u' => $uid]);
    $pdo->prepare('DELETE FROM ad_balances WHERE user_id = :u')->execute([':u' => $uid]);
    $pdo->prepare('DELETE FROM ad_rate_limits WHERE user_id = :u')->execute([':u' => $uid]);
    $pdo->prepare('DELETE FROM mail_queue WHERE id > :m')->execute([':m' => $mailBefore]);
    $pdo->prepare('DELETE FROM promo_event_log WHERE user_id = :u')->execute([':u' => $uid]);
    $pdo->prepare('DELETE FROM promo_notify_prefs WHERE user_id = :u')->execute([':u' => $uid]);
    $pdo->prepare('DELETE FROM users WHERE id = :u')->execute([':u' => $uid]);
    $pdo->exec("DELETE FROM fx_rates WHERE currency = 'UAH'");
    if ($oldFx !== null) {
        $pdo->prepare('INSERT INTO fx_rates (currency, rate, rate_date, source, fetched_at) VALUES (:c, :r, :d, :s, :f)')
            ->execute([':c' => 'UAH', ':r' => $oldFx['rate'], ':d' => $oldFx['rate_date'], ':s' => $oldFx['source'], ':f' => $oldFx['fetched_at']]);
    }
    foreach (['payment_jar_url', 'min_topup'] as $k) {
        $setSetting($k, (string) ($oldSettings[$k] ?? ''));
    }
}

echo "\n" . ($fails === 0 ? "УСЕ PASS ({$total})" : "FAIL: {$fails} з {$total}") . "\n";
exit($fails === 0 ? 0 : 1);
