<?php

declare(strict_types=1);

/**
 * AI LAB HUB — резервна копія завантажень Marketplace (CLI). Ці файли НЕ потрапляють у Git і в архів для хостингу,
 * тож без окремої копії їх неможливо відновити.
 *
 *   php scripts/backup-uploads.php            — створити архів
 *   php scripts/backup-uploads.php --dry-run  — лише показати, що буде заархівовано
 *
 * Що архівується (лише те, що існує):
 *   - photos/  — фото оголошень, config/marketplace.php 'photo_dir' (поза webroot; на проді …/marketplace-files/photos);
 *   - covers/  — обкладинки матеріалів платформи, public/assets/images/marketplace/covers/;
 *   - uploads-marketplace/ — стара тека public/uploads/marketplace/ (до 2026-09-24), якщо вона ще є.
 * Архів: backups/marketplace-uploads-YYYYmmdd-HHMMSS.tar.gz у корені проєкту (тека в .gitignore; scripts/build-deploy.ps1
 * бере файли за білим списком, тож backups/ у збірку не потрапляє). Зберігаються 5 найновіших архівів, старіші
 * видаляються — лише власні архіви скрипта (за шаблоном імені). Вихідні теки скрипт лише читає: нічого не видаляє й не переміщує.
 * Код виходу: 0 — успіх, 1 — помилка.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

const BACKUP_KEEP = 5;
const BACKUP_PREFIX = 'marketplace-uploads-';

date_default_timezone_set('Europe/Kyiv');   // дата в імені архіву — київський час
$root = dirname(__DIR__);
$dryRun = in_array('--dry-run', $argv, true);

require_once $root . '/app/marketplace.php';   // mp_config() з урахуванням marketplace.local.php

$sources = [
    'photos'              => rtrim((string) mp_config()['photo_dir'], '/\\'),
    'covers'              => $root . '/public/assets/images/marketplace/covers',
    'uploads-marketplace' => $root . '/public/uploads/marketplace',
];

$backupDir = $root . '/backups';
$files = [];   // шлях в архіві => абсолютний шлях
foreach ($sources as $prefix => $dir) {
    if (!is_dir($dir)) {
        fwrite(STDOUT, "skip   {$prefix}: немає теки {$dir}\n");
        continue;
    }
    $n = 0;
    $bytes = 0;
    $it = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($dir, FilesystemIterator::SKIP_DOTS));
    foreach ($it as $f) {
        /** @var SplFileInfo $f */
        if (!$f->isFile()) {
            continue;
        }
        $rel = $prefix . '/' . str_replace('\\', '/', substr($f->getPathname(), strlen($dir) + 1));
        $files[$rel] = $f->getPathname();
        $n++;
        $bytes += $f->getSize();
    }
    fwrite(STDOUT, sprintf("source %s: %s — %d файлів, %.1f КБ\n", $prefix, $dir, $n, $bytes / 1024));
}

if ($files === []) {
    fwrite(STDOUT, "Немає файлів для копії — архів не створено.\n");
    exit(0);
}
if ($dryRun) {
    fwrite(STDOUT, 'dry-run: буде заархівовано ' . count($files) . " файлів у {$backupDir}/\n");
    exit(0);
}

if (!is_dir($backupDir) && !mkdir($backupDir, 0750, true) && !is_dir($backupDir)) {
    fwrite(STDERR, "Не вдалося створити {$backupDir}\n");
    exit(1);
}

$base = $backupDir . '/' . BACKUP_PREFIX . date('Ymd-His');
$tar = $base . '.tar';
try {
    $a = new PharData($tar);
    foreach ($files as $rel => $abs) {
        $a->addFile($abs, $rel);
    }
    $a->compress(Phar::GZ);   // створює $base.tar.gz
    unset($a);
    Phar::unlinkArchive($tar);
} catch (Throwable $e) {
    fwrite(STDERR, 'Помилка архівації: ' . $e->getMessage() . "\n");
    @unlink($tar);
    exit(1);
}

$out = $base . '.tar.gz';
// Перевірка: архів читається і містить усі файли.
try {
    $count = iterator_count(new RecursiveIteratorIterator(new PharData($out)));
} catch (Throwable $e) {
    fwrite(STDERR, 'Архів не читається: ' . $e->getMessage() . "\n");
    exit(1);
}
if ($count !== count($files)) {
    fwrite(STDERR, "У архіві {$count} файлів замість " . count($files) . "\n");
    exit(1);
}
fwrite(STDOUT, sprintf("OK %s — %d файлів, %.1f КБ\n", $out, $count, filesize($out) / 1024));

// Ротація: лишаємо BACKUP_KEEP найновіших власних архівів.
$all = glob($backupDir . '/' . BACKUP_PREFIX . '[0-9]*-[0-9]*.tar.gz') ?: [];
rsort($all);   // ім'я містить дату — сортування за іменем = за часом
foreach (array_slice($all, BACKUP_KEEP) as $old) {
    if (@unlink($old)) {
        fwrite(STDOUT, 'rotate видалено старий архів ' . basename($old) . "\n");
    }
}
exit(0);
