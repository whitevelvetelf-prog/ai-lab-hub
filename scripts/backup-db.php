<?php

declare(strict_types=1);

/**
 * AI LAB HUB — резервна копія бази й завантажень (CLI).
 *
 *   php scripts/backup-db.php              — дамп бази + архів завантажень
 *   php scripts/backup-db.php --db-only    — лише база
 *   php scripts/backup-db.php --files-only — лише завантаження
 *   php scripts/backup-db.php --dry-run    — показати, що буде зроблено (нічого не пише)
 *   php scripts/backup-db.php --php-export — не шукати mysqldump, одразу PHP-експорт
 *
 * База: mysqldump (Laragon або PATH; пароль передається через тимчасовий файл параметрів, не в командному рядку),
 * якщо його немає або він завершився з помилкою — PHP-експорт через PDO (CREATE TABLE + INSERT частинами по 200 рядків).
 * Підключення — з config/database.php (той самий файл, що й у сайту). Результат: backups/ailh-db-<база>-YYYYmmdd-HHMMSS.sql.gz.
 *
 * Завантаження (те, чого немає ні в Git, ні в архіві коду): public/uploads/, логотипи продуктів, банери реклами,
 * обкладинки Marketplace, фото оголошень (config/marketplace.php 'photo_dir'), файли матеріалів ('file_storage_dir').
 * Результат: backups/ailh-uploads-YYYYmmdd-HHMMSS.tar.gz. Вихідні теки скрипт лише читає.
 *
 * Ротація: зберігаються 7 найновіших копій кожного виду; видаляються ЛИШЕ власні старі копії скрипта
 * (за шаблоном імені ailh-db-*.sql.gz / ailh-uploads-*.tar.gz). Інші файли в backups/ не чіпаються.
 * Тека backups/ — у .gitignore і поза збіркою для хостингу. Значень паролів скрипт не друкує.
 * Код виходу: 0 — успіх, 1 — помилка.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

const KEEP = 7;
const DB_PREFIX = 'ailh-db-';
const FILES_PREFIX = 'ailh-uploads-';

date_default_timezone_set('Europe/Kyiv');
$root = dirname(__DIR__);
$args = array_slice($argv, 1);
$dryRun = in_array('--dry-run', $args, true);
$doDb = !in_array('--files-only', $args, true);
$doFiles = !in_array('--db-only', $args, true);
$forcePhp = in_array('--php-export', $args, true);
$backupDir = $root . '/backups';
$stamp = date('Ymd-His');
$exit = 0;

function out(string $s): void
{
    fwrite(STDOUT, $s . "\n");
}

function err(string $s): void
{
    fwrite(STDERR, $s . "\n");
}

/** Параметри підключення з config/database.php: сам PDO і (якщо файл задає їх змінними) host/port/dbname/user/password. */
function db_params(string $root): array
{
    $file = $root . '/config/database.php';
    if (!is_file($file)) {
        throw new RuntimeException('немає config/database.php');
    }
    $pdo = require $file;
    if (!$pdo instanceof PDO) {
        throw new RuntimeException('config/database.php не повернув PDO');
    }
    $name = (string) $pdo->query('SELECT DATABASE()')->fetchColumn();
    return [
        'pdo'      => $pdo,
        'host'     => isset($host) ? (string) $host : null,
        'port'     => isset($port) ? (int) $port : 3306,
        'dbname'   => $name !== '' ? $name : (isset($dbname) ? (string) $dbname : ''),
        'user'     => isset($user) ? (string) $user : null,
        'password' => isset($password) ? (string) $password : null,
    ];
}

function find_mysqldump(): ?string
{
    $candidates = glob('C:/laragon/bin/mysql/*/bin/mysqldump.exe') ?: [];
    rsort($candidates);
    foreach (explode(PATH_SEPARATOR, (string) getenv('PATH')) as $dir) {
        foreach (['mysqldump', 'mysqldump.exe'] as $exe) {
            $candidates[] = rtrim($dir, '/\\') . DIRECTORY_SEPARATOR . $exe;
        }
    }
    foreach ($candidates as $c) {
        if (is_file($c)) {
            return $c;
        }
    }
    return null;
}

/** mysqldump → gzip. Повертає true при успіху. */
function dump_mysqldump(string $bin, array $p, string $outGz): bool
{
    if ($p['host'] === null || $p['user'] === null || $p['password'] === null || $p['dbname'] === '') {
        return false;   // config/database.php не задає параметри змінними — лише PHP-експорт
    }
    $cnf = tempnam(sys_get_temp_dir(), 'ailh');
    file_put_contents($cnf, "[client]\nhost=\"{$p['host']}\"\nport={$p['port']}\nuser=\"{$p['user']}\"\npassword=\"" . addcslashes($p['password'], "\"\\") . "\"\n");
    $cmd = escapeshellarg($bin) . ' --defaults-extra-file=' . escapeshellarg($cnf)
        . ' --single-transaction --quick --routines --triggers --no-tablespaces --hex-blob'
        . ' --default-character-set=utf8mb4 ' . escapeshellarg($p['dbname']);
    $proc = proc_open($cmd, [1 => ['pipe', 'w'], 2 => ['pipe', 'w']], $pipes);
    if (!is_resource($proc)) {
        @unlink($cnf);
        return false;
    }
    $gz = gzopen($outGz, 'wb6');
    $bytes = 0;
    while (!feof($pipes[1])) {
        $chunk = fread($pipes[1], 1 << 16);
        if ($chunk === false) {
            break;
        }
        $bytes += strlen($chunk);
        gzwrite($gz, $chunk);
    }
    gzclose($gz);
    $stderr = stream_get_contents($pipes[2]);
    fclose($pipes[1]);
    fclose($pipes[2]);
    $code = proc_close($proc);
    @unlink($cnf);
    if ($code !== 0 || $bytes < 100) {
        err('mysqldump: код ' . $code . ($stderr !== '' ? ' — ' . trim(strtok($stderr, "\n")) : ''));
        @unlink($outGz);
        return false;
    }
    return true;
}

/** PHP-експорт через PDO: структура + дані (INSERT по 200 рядків), представлення — як CREATE VIEW. */
function dump_php(PDO $pdo, string $dbname, string $outGz): bool
{
    $gz = gzopen($outGz, 'wb6');
    $w = static function (string $s) use ($gz): void { gzwrite($gz, $s); };
    $w("-- AI LAB HUB: PHP-експорт бази `{$dbname}` " . date('Y-m-d H:i:s') . "\n");
    $w("SET NAMES utf8mb4;\nSET FOREIGN_KEY_CHECKS = 0;\nSET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';\n\n");
    $tables = $pdo->query('SHOW FULL TABLES')->fetchAll(PDO::FETCH_NUM);
    $views = [];
    foreach ($tables as [$t, $type]) {
        if ($type === 'VIEW') {
            $views[] = $t;
            continue;
        }
        $create = $pdo->query('SHOW CREATE TABLE `' . str_replace('`', '``', $t) . '`')->fetch(PDO::FETCH_NUM)[1];
        $w("-- Таблиця `{$t}`\nCREATE TABLE IF NOT EXISTS " . substr($create, strlen('CREATE TABLE ')) . ";\n");
        $st = $pdo->query('SELECT * FROM `' . str_replace('`', '``', $t) . '`', PDO::FETCH_NUM);
        $batch = [];
        while (($row = $st->fetch(PDO::FETCH_NUM)) !== false) {
            $vals = array_map(static fn ($v) => $v === null ? 'NULL' : $pdo->quote((string) $v), $row);
            $batch[] = '(' . implode(',', $vals) . ')';
            if (count($batch) >= 200) {
                $w('INSERT INTO `' . $t . '` VALUES ' . implode(",\n", $batch) . ";\n");
                $batch = [];
            }
        }
        if ($batch !== []) {
            $w('INSERT INTO `' . $t . '` VALUES ' . implode(",\n", $batch) . ";\n");
        }
        $w("\n");
    }
    foreach ($views as $v) {
        $create = $pdo->query('SHOW CREATE VIEW `' . str_replace('`', '``', $v) . '`')->fetch(PDO::FETCH_NUM)[1];
        $w(preg_replace('/DEFINER=`[^`]+`@`[^`]+`\s*/', '', $create) . ";\n");
    }
    $w("SET FOREIGN_KEY_CHECKS = 1;\n");
    gzclose($gz);
    return true;
}

/** Лишає KEEP найновіших файлів, що відповідають шаблону (лише власні копії скрипта). */
function rotate(string $dir, string $pattern): void
{
    $all = glob($dir . '/' . $pattern) ?: [];
    rsort($all);   // дата в імені → сортування за іменем = за часом
    foreach (array_slice($all, KEEP) as $old) {
        if (@unlink($old)) {
            out('rotate видалено стару копію ' . basename($old));
        }
    }
}

if (!$dryRun && !is_dir($backupDir) && !mkdir($backupDir, 0750, true) && !is_dir($backupDir)) {
    err("Не вдалося створити {$backupDir}");
    exit(1);
}

// ---- База ----
if ($doDb) {
    try {
        $p = db_params($root);
        $safeName = preg_replace('/[^A-Za-z0-9_-]/', '_', $p['dbname']);
        $outGz = "{$backupDir}/" . DB_PREFIX . "{$safeName}-{$stamp}.sql.gz";
        $bin = $forcePhp ? null : find_mysqldump();
        if ($dryRun) {
            out('dry-run база: ' . $p['dbname'] . ' → ' . basename($outGz) . ' (' . ($bin !== null ? 'mysqldump' : 'PHP-експорт') . ')');
        } else {
            $how = 'mysqldump';
            if ($bin === null || !dump_mysqldump($bin, $p, $outGz)) {
                $how = 'PHP-експорт';
                dump_php($p['pdo'], $p['dbname'], $outGz);
            }
            // Перевірка: архів читається, у ньому є CREATE TABLE.
            $head = gzopen($outGz, 'rb');
            $probe = '';
            while (!gzeof($head) && strlen($probe) < 2_000_000 && !str_contains($probe, 'CREATE TABLE')) {
                $probe .= gzread($head, 1 << 16);
            }
            gzclose($head);
            if (!str_contains($probe, 'CREATE TABLE')) {
                throw new RuntimeException('у дампі немає CREATE TABLE');
            }
            out(sprintf('OK база (%s): %s — %.1f КБ', $how, basename($outGz), filesize($outGz) / 1024));
            rotate($backupDir, DB_PREFIX . '*-[0-9]*-[0-9]*.sql.gz');
        }
    } catch (Throwable $e) {
        err('Помилка бази: ' . $e->getMessage());
        $exit = 1;
    }
}

// ---- Завантаження ----
if ($doFiles) {
    $sources = [
        'uploads'      => $root . '/public/uploads',
        'logos'        => $root . '/public/assets/images/logos',
        'ad-uploads'   => $root . '/public/assets/images/ads/uploads',
        'mp-covers'    => $root . '/public/assets/images/marketplace/covers',
    ];
    if (is_file($root . '/app/marketplace.php')) {
        try {
            require_once $root . '/app/marketplace.php';
            $cfg = mp_config();
            $sources['mp-photos'] = rtrim((string) ($cfg['photo_dir'] ?? ''), '/\\');
            $sources['mp-files'] = rtrim((string) ($cfg['file_storage_dir'] ?? ''), '/\\');
        } catch (Throwable $e) {
            out('skip   теки Marketplace: ' . $e->getMessage());
        }
    }
    $files = [];
    foreach ($sources as $prefix => $dir) {
        if ($dir === '' || !is_dir($dir)) {
            out("skip   {$prefix}: немає теки");
            continue;
        }
        $n = 0;
        $bytes = 0;
        $it = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($dir, FilesystemIterator::SKIP_DOTS));
        foreach ($it as $f) {
            if (!$f->isFile()) {
                continue;
            }
            $files[$prefix . '/' . str_replace('\\', '/', substr($f->getPathname(), strlen($dir) + 1))] = $f->getPathname();
            $n++;
            $bytes += $f->getSize();
        }
        out(sprintf('source %s: %d файлів, %.1f КБ', $prefix, $n, $bytes / 1024));
    }
    if ($files === []) {
        out('Немає завантажень — архів не створено.');
    } elseif ($dryRun) {
        out('dry-run завантаження: ' . count($files) . ' файлів → ' . FILES_PREFIX . $stamp . '.tar.gz');
    } else {
        $base = $backupDir . '/' . FILES_PREFIX . $stamp;
        try {
            $a = new PharData($base . '.tar');
            foreach ($files as $rel => $abs) {
                $a->addFile($abs, $rel);
            }
            $a->compress(Phar::GZ);
            unset($a);
            Phar::unlinkArchive($base . '.tar');
            $count = iterator_count(new RecursiveIteratorIterator(new PharData($base . '.tar.gz')));
            if ($count !== count($files)) {
                throw new RuntimeException("в архіві {$count} файлів замість " . count($files));
            }
            out(sprintf('OK завантаження: %s — %d файлів, %.1f КБ', basename($base . '.tar.gz'), $count, filesize($base . '.tar.gz') / 1024));
            rotate($backupDir, FILES_PREFIX . '[0-9]*-[0-9]*.tar.gz');
        } catch (Throwable $e) {
            @unlink($base . '.tar');
            err('Помилка архіву завантажень: ' . $e->getMessage());
            $exit = 1;
        }
    }
}

exit($exit);
