<?php

declare(strict_types=1);

/**
 * AI LAB HUB — донати: публікується лише посилання на банку monobank, налаштування
 * не затираються релізами й імпортами SQL, номер картки ніде не виводиться.
 *   php tests/donate-tests.php            — усе (частина з БД — лише якщо є config/database.php)
 *   php tests/donate-tests.php --no-build — без збірки архіву (build-deploy.ps1)
 * Лише CLI. Тестові значення в site_settings ставляться тимчасово; наприкінці відновлюються
 * попередні значення, а ключі, яких до тесту не було, видаляються за ключем (PK таблиці).
 * Значення реального посилання тест не читає й не друкує.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$root = dirname(__DIR__);
$fails = 0;
$total = 0;
$skips = 0;
function check(bool $cond, string $label): void
{
    global $fails, $total;
    $total++;
    echo ($cond ? '  OK   ' : '  FAIL ') . $label . "\n";
    if (!$cond) {
        $fails++;
    }
}
function skip(string $label): void
{
    global $skips;
    $skips++;
    echo "  SKIP {$label}\n";
}

require_once $root . '/app/donations.php';

const T_JAR = 'https://send.monobank.ua/jar/TESTdonate001';
const T_CARD = '4111 1111 1111 1111';   // стандартний тестовий номер (Visa), не реальний
const T_CARD_DIGITS = '4111111111111111';

// ---------------------------------------------------------------- 1. Перевірка посилання
echo "1. Перевірка посилання на банку\n";
foreach ([T_JAR, 'https://monobank.ua/jar/abc', 'https://SEND.monobank.ua/jar/abc'] as $u) {
    check(donate_jar_url_ok($u), "приймає {$u}");
}
foreach (['http://send.monobank.ua/jar/abc', 'https://evil.com/send.monobank.ua', 'https://send.monobank.ua.evil.com/jar',
          'https://x@send.monobank.ua/jar', 'https://send.monobank.ua:8443/jar', 'https://send.monobank.ua/jar/a"onclick',
          'javascript:alert(1)', '', 'https://privat24.ua/x'] as $u) {
    check(!donate_jar_url_ok($u), 'відхиляє ' . ($u === '' ? '(порожнє)' : $u));
}
[$vals, $errs] = donate_validate(['donate_jar_url' => 'https://evil.com/x', 'donate_enabled' => '1']);
check($errs !== [], 'форма: чужий домен — помилка');
[$vals, $errs] = donate_validate(['donate_jar_url' => T_JAR, 'donate_enabled' => '1', 'donate_card_number' => T_CARD]);
check($errs === [] && $vals['donate_jar_url'] === T_JAR, 'форма: коректне посилання зберігається');
check(!array_key_exists('donate_card_number', $vals), 'форма не зберігає (і не затирає) номер картки');
check(array_keys($vals) === array_keys(DONATE_FIELDS), 'форма зберігає лише DONATE_FIELDS');

// ---------------------------------------------------------------- 2. Код: картка ніде не виводиться
echo "2. Код сторінок не виводить номер картки\n";
foreach (['public/donate.php', 'app/donations-admin.php', 'public/crm-donations.php', 'app/donation-history.php', 'app/footer.php'] as $f) {
    $src = (string) @file_get_contents($root . '/' . $f);
    check($src !== '' && !preg_match('/donate_card_number|donate_iban|donate_card_holder/', $src), "{$f}: немає полів картки/IBAN/ПІБ");
}
check(!preg_match('#https://(send\.)?monobank\.ua/jar/[A-Za-z0-9]{6,}#', (string) file_get_contents($root . '/public/donate.php')), 'donate.php: посилання не зашите в коді');

// ---------------------------------------------------------------- 3. Підвал
echo "3. Підвал\n";
check((bool) preg_match('#<a\b[^>]*href="/donate\.php"#', (string) file_get_contents($root . '/app/footer.php')), 'app/footer.php: пункт «Донат» веде на /donate.php');

// ---------------------------------------------------------------- 4. SQL не затирає налаштування донатів
echo "4. SQL-файли (database/, hosting-upload/)\n";
$sqlFiles = array_merge(glob($root . '/database/*.sql') ?: [], glob($root . '/database/batches/*.sql') ?: [], glob($root . '/hosting-upload/*/*.sql') ?: []);
$bad = [];
foreach ($sqlFiles as $f) {
    $t = (string) file_get_contents($f);
    if (preg_match("/(INSERT|REPLACE|UPDATE)[^;]*site_settings[^;]*'donate_/is", $t)
        || preg_match('/(DROP\s+TABLE|TRUNCATE|DELETE\s+FROM|REPLACE\s+INTO|UPDATE)\s+[`]?site_settings/is', $t)
        || preg_match('/INSERT\s+INTO\s+[`]?site_settings(?![^;]*ON\s+DUPLICATE\s+KEY\s+UPDATE\s+setting_value\s*=\s*setting_value)/is', $t)) {
        $bad[] = basename($f);
    }
}
check(count($sqlFiles) > 10, 'знайдено SQL-файли (' . count($sqlFiles) . ')');
check($bad === [], 'жоден SQL не перезаписує site_settings / donate_*' . ($bad ? ': ' . implode(', ', $bad) : ''));

// ---------------------------------------------------------------- 5–6. З БД: рендер сторінки й імпорт SQL
$pdo = null;
if (is_file($root . '/config/database.php')) {
    try {
        $pdo = require $root . '/config/database.php';
        $pdo->query('SELECT 1 FROM site_settings LIMIT 1');
    } catch (Throwable $e) {
        $pdo = null;
    }
}

function render_donate(): string
{
    $cmd = escapeshellarg(PHP_BINARY) . ' -r ' . escapeshellarg(
        '$_SERVER["REQUEST_METHOD"]="GET";$_SERVER["HTTP_HOST"]="ai-lab-hub.test";$_SERVER["REQUEST_URI"]="/donate.php";'
        . '$_SERVER["SCRIPT_NAME"]="/donate.php";chdir(' . var_export(dirname(__DIR__) . '/public', true) . ');'
        . 'include "donate.php";'
    );

    return (string) shell_exec($cmd);   // окремий процес: свіжий кеш site_settings і сесія
}

if ($pdo === null) {
    skip('5–6: немає config/database.php або таблиці site_settings — тести з БД пропущено');
} else {
    $keys = ['donate_enabled', 'donate_jar_url', 'donate_show_qr', 'donate_card_number'];
    $in = implode(',', array_fill(0, count($keys), '?'));
    $st = $pdo->prepare("SELECT setting_key, setting_value FROM site_settings WHERE setting_key IN ($in)");
    $st->execute($keys);
    $saved = $st->fetchAll(PDO::FETCH_KEY_PAIR);
    try {
        echo "5. Сторінка /donate.php\n";
        site_settings_save($pdo, ['donate_enabled' => '1', 'donate_jar_url' => T_JAR, 'donate_show_qr' => '1', 'donate_card_number' => T_CARD]);
        $html = render_donate();
        check(str_contains($html, '</html>'), 'з посиланням: сторінка дорендерена');
        check((bool) preg_match('#class="donate-btn" href="' . preg_quote(T_JAR, '#') . '"#', $html), 'з посиланням: кнопка банки є');
        check(str_contains($html, 'data-qr="' . T_JAR . '"'), 'з посиланням: QR того ж посилання');
        check(!str_contains($html, T_CARD) && !str_contains($html, T_CARD_DIGITS), 'номер картки з БД на сторінці НЕ виводиться');
        check((bool) preg_match('#<a\b[^>]*href="/donate\.php"#', $html), 'підвал сторінки: пункт «Донат» → /donate.php');

        site_settings_save($pdo, ['donate_jar_url' => '']);
        $html = render_donate();
        check(!str_contains($html, 'class="donate-btn"') && !str_contains($html, 'monobank.ua/jar'), 'без посилання: кнопки немає');
        check(str_contains($html, 'Скоро'), 'без посилання: текст «Скоро»');
        check(donate_status($pdo)['configured'] === false && str_contains(donate_status_warning_html($pdo), 'не налаштовано'), 'без посилання: CRM — «не налаштовано» з попередженням');

        site_settings_save($pdo, ['donate_jar_url' => 'https://evil.com/jar/x']);
        $html = render_donate();
        check(!str_contains($html, 'evil.com'), 'некоректне посилання в БД не публікується');

        site_settings_save($pdo, ['donate_jar_url' => T_JAR, 'donate_enabled' => '0']);
        check(!str_contains(render_donate(), 'class="donate-btn"'), 'сторінку вимкнено: кнопки немає');

        echo "6. Імпорт SQL не затирає значення\n";
        site_settings_save($pdo, ['donate_enabled' => '1', 'donate_jar_url' => T_JAR]);
        $ran = 0;
        foreach ($sqlFiles as $f) {
            $t = (string) file_get_contents($f);
            if (!str_contains($t, 'site_settings')) {
                continue;
            }
            $t = preg_replace('/^\s*--.*$/m', '', $t) ?? '';
            foreach (preg_split('/;\s*\n/', $t) ?: [] as $stmt) {
                if (preg_match('/^\s*(CREATE\s+TABLE\s+IF\s+NOT\s+EXISTS\s+site_settings|INSERT\s+IGNORE\s+INTO\s+site_settings)/is', $stmt)) {
                    $pdo->exec($stmt);
                    $ran++;
                }
            }
        }
        site_settings($pdo, true);
        $cfg = donate_config($pdo);
        check($ran > 0, "виконано інструкцій SQL для site_settings: {$ran}");
        check($cfg['donate_jar_url'] === T_JAR && $cfg['donate_enabled'] === '1', 'після імпорту посилання й перемикач не змінилися');
        check(donate_status($pdo)['configured'], 'після імпорту: «налаштовано»');
    } finally {
        // Відновлення: попередні значення назад, нові ключі — видалити за ключем.
        $restore = array_intersect_key($saved, array_flip($keys));
        if ($restore !== []) {
            site_settings_save($pdo, $restore);
        }
        $del = $pdo->prepare('DELETE FROM site_settings WHERE setting_key = :k');
        foreach (array_diff($keys, array_keys($saved)) as $k) {
            $del->execute([':k' => $k]);
        }
        $st->execute($keys);
        check($st->fetchAll(PDO::FETCH_KEY_PAIR) == $saved, 'тестові значення прибрано, попередні відновлено');
    }
}

// ---------------------------------------------------------------- 7. Збірка
echo "7. Збірка build-deploy.ps1\n";
if (in_array('--no-build', $argv, true) || PHP_OS_FAMILY !== 'Windows') {
    skip('збірку пропущено');
} else {
    $zip = sys_get_temp_dir() . DIRECTORY_SEPARATOR . 'donate-test-' . getmypid() . '.zip';
    $out = (string) shell_exec('powershell -NoProfile -ExecutionPolicy Bypass -File ' . escapeshellarg($root . '\\scripts\\build-deploy.ps1')
        . ' -Output ' . escapeshellarg($zip) . ' 2>&1');
    if (!is_file($zip)) {
        if (str_contains($out, 'uncommitted changes')) {
            skip('збірку не зібрано: незакомічені зміни в public/ чи app/ (запустіть після коміту)');
        } else {
            check(false, 'архів зібрано: ' . trim(substr($out, 0, 400)));
        }
    } else {
        // Розпакувати (tar є у Windows 10+; розширення zip у PHP може не бути) і перевірити вміст.
        $dir = sys_get_temp_dir() . DIRECTORY_SEPARATOR . 'donate-test-' . getmypid();
        @mkdir($dir);
        $tar = (getenv('SystemRoot') ?: 'C:\Windows') . '\System32\tar.exe';   // не GNU tar із Git (не розуміє «C:»)
        shell_exec(escapeshellarg($tar) . ' -xf ' . escapeshellarg($zip) . ' -C ' . escapeshellarg($dir) . ' 2>&1');
        $cfgEntries = [];
        $leak = [];
        $count = 0;
        $it = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($dir, FilesystemIterator::SKIP_DOTS));
        foreach ($it as $fi) {
            $n = str_replace(DIRECTORY_SEPARATOR, '/', substr($fi->getPathname(), strlen($dir) + 1));
            $count++;
            if (str_starts_with($n, 'config/') && $n !== 'config/languages.php') {
                $cfgEntries[] = $n;
            }
            if (preg_match('/\.(php|sql|md|js)$/', $n)) {
                $c = (string) file_get_contents($fi->getPathname());
                if (preg_match('#https://(send\.)?monobank\.ua/jar/[A-Za-z0-9]{6,}#', $c)
                    || preg_match("/(INSERT|REPLACE|UPDATE)[^;]*site_settings[^;]*'donate_/is", $c)) {
                    $leak[] = $n;
                }
            }
        }
        foreach (new RecursiveIteratorIterator(new RecursiveDirectoryIterator($dir, FilesystemIterator::SKIP_DOTS), RecursiveIteratorIterator::CHILD_FIRST) as $fi) {
            $fi->isDir() ? @rmdir($fi->getPathname()) : @unlink($fi->getPathname());
        }
        @rmdir($dir);
        @unlink($zip);
        check($count > 100, "архів розпаковано ({$count} файлів)");
        check(str_contains($out, 'Done:'), 'архів зібрано');
        check($cfgEntries === [], 'в архіві немає config/, крім languages.php' . ($cfgEntries ? ': ' . implode(', ', $cfgEntries) : ''));
        check($leak === [], 'в архіві немає посилання на банку й SQL, що пише donate_*' . ($leak ? ': ' . implode(', ', $leak) : ''));
    }
}

echo "\nУсього: {$total}, провалено: {$fails}, пропущено: {$skips}\n";
exit($fails === 0 ? 0 : 1);
