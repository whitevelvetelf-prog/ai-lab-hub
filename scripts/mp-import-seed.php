<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: імпорт стартових безкоштовних матеріалів із marketplace-seed/.
 *
 * ТІЛЬКИ CLI (лежить у scripts/, поза public/ і поза збіркою; з вебу недоступний, при виклику не з CLI — вихід).
 *
 *   php scripts/mp-import-seed.php                 # --dry-run (за замовчуванням): лише показує план
 *   php scripts/mp-import-seed.php --apply         # реальний імпорт
 *   php scripts/mp-import-seed.php --seed-dir=DIR  # інша тека з manifest.json + files/ (за замовчуванням marketplace-seed/)
 *
 * Для кожного manifest.items[]: продавець (seller_slug), секція solution, категорія за category_slug, status='draft'
 * (НІЧОГО не публікується), pricing_model='free', delivery_type='file', платформа/рівень/ліцензія, source_lang='uk',
 * переклад uk (title, short_desc, full_desc, features, for_whom). Файл — та сама перевірка, що в CRM-формі
 * (mp_validate_offer_file: розширення з білого списку, реальний MIME, sha256), зберігання поза webroot,
 * запис у mp_files; якщо sha256 уже є — використовується наявний запис. Ідемпотентно: пропозиція продавця з такою
 * назвою вже є → пропускається й НЕ змінюється. Усе перевіряється ДО першого запису; будь-яка помилка → нічого не створено.
 * Для .zip додатково перевіряється вміст: блокуються виконувані/скриптові файли (exe, bat, sh, dll, php, js та ін.),
 * .py/.csv/.md дозволені; небезпечні шляхи (../, абсолютні) і завеликий розпакований обсяг — теж помилка.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

require_once __DIR__ . '/../app/marketplace.php';

const MPI_BLOCKED_EXT = ['exe', 'bat', 'sh', 'dll', 'php', 'js', 'cmd', 'com', 'scr', 'msi', 'ps1', 'vbs', 'jar', 'phtml', 'phar', 'pht'];
const MPI_ZIP_MAX_ENTRIES = 200;
const MPI_ZIP_MAX_UNCOMPRESSED = 50 * 1024 * 1024;

function mpi_out(string $line = ''): void
{
    fwrite(STDOUT, $line . "\n");
}

function mpi_die(string $msg, int $code = 1): never
{
    fwrite(STDERR, "ПОМИЛКА: $msg\n");
    exit($code);
}

/** Доповнення пробілами до ширини за СИМВОЛАМИ (sprintf рахує байти й «пливе» на кирилиці). */
function mpi_pad(string $s, int $w): string
{
    $s = mb_strimwidth($s, 0, $w, '…');

    return $s . str_repeat(' ', max(0, $w - mb_strlen($s)));
}

/** Імена та розміри записів zip із центрального каталогу (без ZipArchive). @return list<array{name:string,size:int}>|null */
function mpi_zip_entries(string $path): ?array
{
    $data = @file_get_contents($path);
    if ($data === false || strlen($data) < 22) {
        return null;
    }
    $eocd = strrpos($data, "PK\x05\x06");
    if ($eocd === false || $eocd + 22 > strlen($data)) {
        return null;
    }
    $count = unpack('v', substr($data, $eocd + 10, 2))[1];
    $offset = unpack('V', substr($data, $eocd + 16, 4))[1];
    $entries = [];
    $pos = $offset;
    for ($i = 0; $i < $count; $i++) {
        if (substr($data, $pos, 4) !== "PK\x01\x02" || $pos + 46 > strlen($data)) {
            return null;
        }
        $h = unpack('Vsig/vvm/vvn/vflags/vcomp/vtime/vdate/Vcrc/Vcsize/Vusize/vnlen/velen/vclen', substr($data, $pos, 34));
        $name = substr($data, $pos + 46, $h['nlen']);
        $entries[] = ['name' => $name, 'size' => (int) $h['usize']];
        $pos += 46 + $h['nlen'] + $h['elen'] + $h['clen'];
    }

    return $entries;
}

/** Проблеми вмісту zip (порожній список = можна). @return list<string> */
function mpi_zip_problems(string $path): array
{
    $entries = mpi_zip_entries($path);
    if ($entries === null) {
        return ['не вдалося прочитати zip (пошкоджений архів)'];
    }
    if ($entries === []) {
        return ['zip порожній'];
    }
    $problems = [];
    if (count($entries) > MPI_ZIP_MAX_ENTRIES) {
        $problems[] = 'забагато файлів в архіві (' . count($entries) . ' > ' . MPI_ZIP_MAX_ENTRIES . ')';
    }
    if (array_sum(array_column($entries, 'size')) > MPI_ZIP_MAX_UNCOMPRESSED) {
        $problems[] = 'розпакований обсяг перевищує ' . (MPI_ZIP_MAX_UNCOMPRESSED / 1048576) . ' МБ';
    }
    foreach ($entries as $e) {
        $name = str_replace('\\', '/', $e['name']);
        if (str_starts_with($name, '/') || preg_match('~(^|/)\.\.(/|$)~', $name) === 1 || preg_match('~^[A-Za-z]:~', $name) === 1 || str_contains($name, "\0")) {
            $problems[] = "небезпечний шлях у архіві: «{$e['name']}»";
            continue;
        }
        if (str_ends_with($name, '/')) {
            continue;   // каталог
        }
        $ext = strtolower(pathinfo($name, PATHINFO_EXTENSION));
        if (in_array($ext, MPI_BLOCKED_EXT, true)) {
            $problems[] = "заборонений тип файлу в архіві: «{$e['name']}» (.$ext)";
        }
    }

    return $problems;
}

// --- Аргументи ------------------------------------------------------------------
$apply = false;
$dryRunFlag = false;
$seedDir = dirname(__DIR__) . '/marketplace-seed';
foreach (array_slice($argv, 1) as $arg) {
    if ($arg === '--apply') {
        $apply = true;
    } elseif ($arg === '--dry-run') {
        $dryRunFlag = true;
    } elseif (str_starts_with($arg, '--seed-dir=')) {
        $seedDir = rtrim(substr($arg, 11), '/\\');
    } elseif ($arg === '--help' || $arg === '-h') {
        mpi_out("Використання: php scripts/mp-import-seed.php [--dry-run | --apply] [--seed-dir=ТЕКА]");
        mpi_out('За замовчуванням --dry-run (нічого не записує).');
        exit(0);
    } else {
        mpi_die("невідомий аргумент «{$arg}» (див. --help)", 2);
    }
}
if ($apply && $dryRunFlag) {
    mpi_die('--apply і --dry-run разом не можна', 2);
}

// --- Маніфест ---------------------------------------------------------------------
$manifestPath = $seedDir . '/manifest.json';
if (!is_file($manifestPath)) {
    mpi_die("не знайдено $manifestPath");
}
$manifest = json_decode((string) file_get_contents($manifestPath), true);
if (!is_array($manifest) || !isset($manifest['items']) || !is_array($manifest['items']) || $manifest['items'] === []) {
    mpi_die('manifest.json некоректний або без items');
}
$sellerSlug = (string) ($manifest['seller_slug'] ?? '');
if ($sellerSlug === '') {
    mpi_die('manifest.json: не задано seller_slug');
}
if (($manifest['source_lang'] ?? 'uk') !== 'uk') {
    mpi_die("manifest.json: source_lang має бути 'uk' (зараз «" . (string) $manifest['source_lang'] . '»)');
}
if (($manifest['import_status'] ?? 'draft') !== 'draft') {
    mpi_die("manifest.json: import_status має бути 'draft' — скрипт нічого не публікує");
}

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$sellerId = mp_seller_id($pdo, $sellerSlug);
if ($sellerId === null) {
    mpi_die("продавця «{$sellerSlug}» не знайдено (mp_sellers) — застосуйте міграцію Marketplace");
}
$cats = [];
foreach ($pdo->query("SELECT id, slug FROM mp_categories WHERE section = 'solution' AND is_active = 1")->fetchAll(PDO::FETCH_ASSOC) as $c) {
    $cats[(string) $c['slug']] = (int) $c['id'];
}
$existingTitles = [];
$st = $pdo->prepare(
    "SELECT l.id, t.title FROM mp_listings l JOIN mp_listing_translations t ON t.listing_id = l.id AND t.lang = 'uk'
     WHERE l.seller_id = :s AND l.section = 'solution'"
);
$st->execute([':s' => $sellerId]);
foreach ($st->fetchAll(PDO::FETCH_ASSOC) as $r) {
    $existingTitles[mp_norm_title((string) $r['title'])] = (int) $r['id'];
}

// --- Перевірка ВСЬОГО до будь-якого запису ------------------------------------------------
$plan = [];
$errors = [];
$seenSlugs = [];
$seenTitles = [];
$filesRoot = realpath($seedDir . '/files');
foreach ($manifest['items'] as $i => $it) {
    $n = $i + 1;
    $label = "елемент #$n" . (is_array($it) && isset($it['slug']) ? ' (' . (string) $it['slug'] . ')' : '');
    $e = [];
    if (!is_array($it)) {
        $errors[] = "$label: не об'єкт";
        continue;
    }
    foreach (['slug', 'category_slug', 'file', 'title', 'short_desc', 'full_desc', 'platform', 'skill_level', 'license'] as $req) {
        if (!isset($it[$req]) || !is_string($it[$req]) || trim($it[$req]) === '') {
            $e[] = "не задано поле «{$req}»";
        }
    }
    foreach (['features', 'for_whom'] as $opt) {
        if (isset($it[$opt]) && !is_string($it[$opt])) {
            $e[] = "поле «{$opt}» має бути рядком";
        }
    }
    if ($e === []) {
        $slug = (string) $it['slug'];
        if (isset($seenSlugs[$slug])) {
            $e[] = "повтор slug «{$slug}»";
        }
        $seenSlugs[$slug] = true;
        $normTitle = mp_norm_title((string) $it['title']);
        if (isset($seenTitles[$normTitle])) {
            $e[] = 'назва повторюється в manifest';
        }
        $seenTitles[$normTitle] = true;
        if (mb_strlen($it['title']) < 3 || mb_strlen($it['title']) > 200) {
            $e[] = 'назва: від 3 до 200 символів';
        }
        if (mb_strlen($it['short_desc']) > 500) {
            $e[] = 'короткий опис: не більше 500 символів';
        }
        if (mb_strlen($it['platform']) > 100) {
            $e[] = 'платформа: не більше 100 символів';
        }
        if (mb_strlen($it['license']) > 40) {
            $e[] = 'ліцензія: не більше 40 символів';
        }
        if (!isset(mp_skill_labels()[$it['skill_level']])) {
            $e[] = 'некоректний skill_level «' . $it['skill_level'] . '» (допустимо: ' . implode(', ', array_keys(mp_skill_labels())) . ')';
        }
        if (!isset($cats[$it['category_slug']])) {
            $e[] = 'категорію «' . $it['category_slug'] . '» (секція solution) не знайдено';
        }
        // файл: лише всередині seedDir/files (без ../ і абсолютних шляхів)
        $rel = str_replace('\\', '/', $it['file']);
        $real = $filesRoot !== false && !str_starts_with($rel, '/') && preg_match('~^[A-Za-z]:~', $rel) !== 1 ? realpath($seedDir . '/' . $rel) : false;
        $inside = $real !== false && $filesRoot !== false && str_starts_with(str_replace('\\', '/', $real), str_replace('\\', '/', $filesRoot) . '/');
        if (!$inside || !is_file($real)) {
            $e[] = 'файл «' . $it['file'] . '» не знайдено в теці files/ (шлях має бути всередині неї)';
        } else {
            $fe = [];
            $info = mp_validate_offer_file($real, basename($real), $fe);
            if ($info === null) {
                foreach ($fe as $x) {
                    $e[] = "файл: $x";
                }
            } elseif ($info['ext'] === 'zip') {
                foreach (mpi_zip_problems($real) as $x) {
                    $e[] = "zip: $x";
                }
            }
        }
    }
    if ($e !== []) {
        foreach ($e as $x) {
            $errors[] = "$label: $x";
        }
        continue;
    }
    $dup = $existingTitles[mp_norm_title((string) $it['title'])] ?? null;
    $reuse = $pdo->prepare('SELECT id FROM mp_files WHERE sha256 = :h ORDER BY id LIMIT 1');
    $reuse->execute([':h' => $info['sha256']]);
    $fid = $reuse->fetchColumn();
    $zipNames = $info['ext'] === 'zip' ? array_map(static fn(array $x): string => $x['name'], mpi_zip_entries($real) ?? []) : [];
    $plan[] = ['item' => $it, 'info' => $info, 'cat_id' => $cats[$it['category_slug']], 'skip_id' => $dup, 'file_id' => $fid === false ? null : (int) $fid, 'zip' => $zipNames];
}
if ($errors !== []) {
    fwrite(STDERR, "Перевірка не пройдена — НІЧОГО не створено:\n");
    foreach ($errors as $x) {
        fwrite(STDERR, "  • $x\n");
    }
    exit(1);
}

// --- План (dry-run) ---------------------------------------------------------------------------
mpi_out($apply ? 'РЕЖИМ: --apply (реальний імпорт, усе — draft)' : 'РЕЖИМ: --dry-run (нічого не записується; для імпорту додайте --apply)');
mpi_out("Продавець: $sellerSlug (id $sellerId) · тека: $seedDir · елементів: " . count($plan));
mpi_out(str_repeat('-', 100));
foreach ($plan as $k => $p) {
    $it = $p['item'];
    $act = $p['skip_id'] !== null ? "ПРОПУСТИТИ (вже є: пропозиція №{$p['skip_id']})" : 'СТВОРИТИ (draft)';
    $fileNote = $p['file_id'] !== null ? "наявний файл №{$p['file_id']} (той самий sha256)" : 'новий файл';
    mpi_out(sprintf('%d. [%s] %s', $k + 1, $act, $it['title']));
    mpi_out(sprintf('   категорія: %s · платформа: %s · рівень: %s · ліцензія: %s', $it['category_slug'], $it['platform'], $it['skill_level'], $it['license']));
    mpi_out(sprintf('   файл: %s (%s, %s, %s КБ, sha256 %s…) — %s', basename($p['info']['tmp']), $p['info']['ext'], $p['info']['mime'], number_format($p['info']['size'] / 1024, 1, '.', ''), substr($p['info']['sha256'], 0, 12), $fileNote));
    if ($p['zip'] !== []) {
        mpi_out('   вміст zip: ' . implode(', ', $p['zip']) . ' — перевірку пройдено');
    }
}
mpi_out(str_repeat('-', 100));
$toCreate = count(array_filter($plan, static fn(array $p): bool => $p['skip_id'] === null));
mpi_out("Буде створено: $toCreate · пропущено (вже є): " . (count($plan) - $toCreate));
if (!$apply) {
    exit(0);
}

// --- Реальний імпорт ------------------------------------------------------------------------------
$created = 0;
$skipped = 0;
foreach ($plan as $p) {
    $it = $p['item'];
    if ($p['skip_id'] !== null) {
        $skipped++;
        continue;
    }
    $saved = null;
    try {
        $saved = mp_save_offer_file($pdo, $p['info'], null, false);
        $pdo->beginTransaction();
        $ins = $pdo->prepare(
            "INSERT INTO mp_listings
                (section, seller_id, status, pricing_model, price_amount, currency, delivery_type, delivery_url, file_id,
                 license, cover_image, source_lang, platform, skill_level, created_by)
             VALUES ('solution', :seller, 'draft', 'free', NULL, NULL, 'file', NULL, :fid, :lic, NULL, 'uk', :platform, :skill, NULL)"
        );
        $ins->execute([':seller' => $sellerId, ':fid' => $saved['id'], ':lic' => $it['license'], ':platform' => $it['platform'], ':skill' => $it['skill_level']]);
        $lid = (int) $pdo->lastInsertId();
        $tr = $pdo->prepare(
            "INSERT INTO mp_listing_translations (listing_id, lang, title, short_desc, full_desc, features, for_whom, is_auto)
             VALUES (:id, 'uk', :t, :s, :f, :ft, :fw, 0)"
        );
        $tr->execute([
            ':id' => $lid, ':t' => $it['title'], ':s' => $it['short_desc'], ':f' => $it['full_desc'],
            ':ft' => isset($it['features']) && trim($it['features']) !== '' ? $it['features'] : null,
            ':fw' => isset($it['for_whom']) && trim($it['for_whom']) !== '' ? $it['for_whom'] : null,
        ]);
        $pdo->prepare('INSERT INTO mp_listing_categories (listing_id, category_id) VALUES (:l, :c)')->execute([':l' => $lid, ':c' => $p['cat_id']]);
        mp_log($pdo, $lid, null, 'created', 'імпорт із marketplace-seed (draft): ' . $it['slug']);
        $pdo->commit();
        $created++;
    } catch (Throwable $ex) {
        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }
        // файл, який ми щойно створили для цього елемента (а не наявний), прибираємо
        if ($saved !== null && !$saved['existing']) {
            if ($saved['stored_path'] !== null && is_file($saved['stored_path'])) {
                @unlink($saved['stored_path']);
            }
            $pdo->prepare('DELETE FROM mp_files WHERE id = :id')->execute([':id' => $saved['id']]);
        }
        mpi_die('збій при імпорті «' . $it['title'] . '»: ' . $ex->getMessage() . " (створено до збою: $created)");
    }
}
mpi_out("Готово: створено $created, пропущено $skipped. Усі — draft; публікуйте через mp-list.php.");
mpi_out();

// --- Підсумкова таблиця -------------------------------------------------------------------------------
$rows = [];
foreach ($plan as $p) {
    $q = $pdo->prepare(
        "SELECT l.id, l.status, t.title, COALESCE(ct.name, c.slug) AS category, f.original_name, l.file_id
         FROM mp_listings l
         JOIN mp_listing_translations t ON t.listing_id = l.id AND t.lang = 'uk'
         LEFT JOIN mp_listing_categories lc ON lc.listing_id = l.id
         LEFT JOIN mp_categories c ON c.id = lc.category_id
         LEFT JOIN mp_category_translations ct ON ct.category_id = c.id AND ct.lang = 'uk'
         LEFT JOIN mp_files f ON f.id = l.file_id
         WHERE l.seller_id = :s AND l.section = 'solution' AND t.title = :t
         ORDER BY l.id LIMIT 1"
    );
    $q->execute([':s' => $sellerId, ':t' => $p['item']['title']]);
    $r = $q->fetch(PDO::FETCH_ASSOC);
    if ($r !== false) {
        $rows[] = $r;
    }
}
mpi_out(mpi_pad('id', 4) . ' | ' . mpi_pad('назва', 58) . ' | ' . mpi_pad('категорія', 26) . ' | ' . mpi_pad('статус', 7) . ' | файл');
mpi_out(str_repeat('-', 140));
foreach ($rows as $r) {
    mpi_out(mpi_pad((string) $r['id'], 4) . ' | ' . mpi_pad((string) $r['title'], 58) . ' | ' . mpi_pad((string) $r['category'], 26) . ' | ' . mpi_pad((string) $r['status'], 7) . ' | ' . $r['original_name'] . ' (файл №' . $r['file_id'] . ')');
}
