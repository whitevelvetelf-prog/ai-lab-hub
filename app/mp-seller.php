<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: публічна сторінка продавця (Хвиля 1). Колонки mp_sellers bio, logo, page_public
 * (міграція 2026-11-09, № 20).
 *
 *   Сторінка public/mp-seller.php?id=N: назва (display_name), логотип, короткий опис, «на платформі з {місяць рік}»,
 *   мітка «перевірений» (is_verified), сайт — лише в перевірених продавців і платформи, усі живі оголошення продавця,
 *   згруповані за блоками дерева. Жодних контактів (вони лише через «Показати контакт» в оголошенні) і жодних оцінок.
 *   Приватна особа (не перевірена) — лише відображуване ім'я, без сайту. page_public = 0 → сторінки й посилань на неї
 *   немає (оголошення лишаються). Опис — простий текст без контактів (пошта, телефон, посилання, @нік відхиляються).
 *   Логотип — той самий конвеєр, що фото оголошень (mpb_inspect_photo → GD-перекодування mpb_process_photo), зберігається
 *   ОДИН файл (мініатюра до 400 px, jpg) у photo_dir; віддає mp-photo.php (логотип відкритої сторінки — усім).
 */

require_once __DIR__ . '/marketplace-board.php';

const MPSL_BIO_MAX = 500;

function mpsl_ready(PDO $pdo): bool
{
    static $ready = null;
    if ($ready === null) {
        try {
            $ready = (int) $pdo->query("SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE()
                                        AND TABLE_NAME = 'mp_sellers' AND COLUMN_NAME IN ('bio', 'logo', 'page_public')")->fetchColumn() === 3;
        } catch (Throwable $e) {
            $ready = false;
        }
    }

    return $ready;
}

/** Продавець або null. */
function mpsl_get(PDO $pdo, int $id): ?array
{
    if ($id <= 0 || !mpsl_ready($pdo)) {
        return null;
    }
    $st = $pdo->prepare('SELECT id, user_id, display_name, slug, website_url, is_platform, is_verified, status, created_at, bio, logo, page_public
                         FROM mp_sellers WHERE id = :id');
    $st->execute([':id' => $id]);
    $r = $st->fetch(PDO::FETCH_ASSOC);

    return $r === false ? null : $r;
}

/** Продавець користувача або null. */
function mpsl_for_user(PDO $pdo, int $userId): ?array
{
    if (!mpsl_ready($pdo)) {
        return null;
    }
    $st = $pdo->prepare('SELECT id FROM mp_sellers WHERE user_id = :u ORDER BY id LIMIT 1');
    $st->execute([':u' => $userId]);
    $id = $st->fetchColumn();

    return $id !== false ? mpsl_get($pdo, (int) $id) : null;
}

/** Чи сторінка відкрита публічно. */
function mpsl_is_public(array $s): bool
{
    return (int) $s['page_public'] === 1 && (string) $s['status'] === 'active';
}

/** Чи показувати сайт (перевірений продавець або платформа). */
function mpsl_show_website(array $s): bool
{
    return ((int) $s['is_verified'] === 1 || (int) $s['is_platform'] === 1) && mp_is_http_url((string) ($s['website_url'] ?? ''));
}

/** Кількість живих оголошень продавця. */
function mpsl_live_count(PDO $pdo, int $sellerId): int
{
    $st = $pdo->prepare('SELECT COUNT(*) FROM mp_listings l WHERE l.seller_id = :s AND ' . mpt_live_sql());
    $st->execute([':s' => $sellerId]);

    return (int) $st->fetchColumn();
}

/**
 * Живі оголошення продавця, згруповані за блоками дерева (у порядку блоків).
 *
 * @return list<array{block:array<string,mixed>,rows:list<array<string,mixed>>}>
 */
function mpsl_listings_by_block(PDO $pdo, int $sellerId, string $lang): array
{
    $st = $pdo->prepare('SELECT l.id FROM mp_listings l WHERE l.seller_id = :s AND ' . mpt_live_sql() . ' ORDER BY l.published_at DESC, l.id DESC LIMIT 200');
    $st->execute([':s' => $sellerId]);
    $rows = mpt_rows($pdo, $lang, array_map('intval', $st->fetchAll(PDO::FETCH_COLUMN)));
    $by = [];
    foreach ($rows as $r) {
        $by[(string) $r['section']][] = $r;
    }
    $out = [];
    foreach (mpt_tree($pdo, $lang) as $b) {
        if (!empty($by[$b['section']])) {
            $out[] = ['block' => $b, 'rows' => $by[$b['section']]];
        }
    }

    return $out;
}

/** «Усі оголошення продавця (N)» для сторінки оголошення ('' — сторінка прихована або оголошень немає). */
function mpsl_link_html(PDO $pdo, ?int $sellerId): string
{
    if ($sellerId === null || $sellerId <= 0) {
        return '';
    }
    $s = mpsl_get($pdo, $sellerId);
    if ($s === null || !mpsl_is_public($s)) {
        return '';
    }
    $n = mpsl_live_count($pdo, $sellerId);
    if ($n <= 0) {
        return '';
    }

    return '<p class="mpsl-link"><a class="mp-btn" href="mp-seller.php?id=' . $sellerId . '">' . mp_e(sprintf(t('mpsl_all_listings'), $n)) . '</a></p>';
}

/** Адреса логотипа або null. */
function mpsl_logo_url(?string $logo): ?string
{
    return $logo !== null && $logo !== '' ? mpb_photo_url($logo) : null;
}

/** «на платформі з листопада 2026» / «on the platform since November 2026». */
function mpsl_since(string $createdAt, string $lang): string
{
    $ts = strtotime($createdAt) ?: time();
    $m = (int) date('n', $ts);
    $uk = ['січня', 'лютого', 'березня', 'квітня', 'травня', 'червня', 'липня', 'серпня', 'вересня', 'жовтня', 'листопада', 'грудня'];
    $month = $lang === 'uk' ? $uk[$m - 1] : date('F', $ts);

    return sprintf(t('mpsl_since'), $month . ' ' . date('Y', $ts));
}

/** Чи містить текст контакти (пошта, телефон, посилання, @нік, t.me). */
function mpsl_has_contacts(string $text): bool
{
    return preg_match('~[\p{L}\p{N}._%+-]+@[\p{L}\p{N}.-]+\.\p{L}{2,}|https?://|www\.|t\.me/|(?:^|\s)@[A-Za-z0-9_]{3,}|\+?\d[\d\s()\-]{7,}\d|\b[\p{L}\d-]+\.(?:com|net|org|ua|io|ai|me|info)\b~iu', $text) === 1;
}

/**
 * Збереження налаштувань сторінки. $in: bio, website_url, page_public (bool), remove_logo (bool); $file — $_FILES['logo'] або null.
 *
 * @return list<string> ключі помилок t()
 */
function mpsl_save(PDO $pdo, array $seller, array $in, ?array $file): array
{
    $errors = [];
    $bio = trim((string) preg_replace("/[ \t]+/u", ' ', strip_tags((string) ($in['bio'] ?? ''))));
    $bio = (string) preg_replace("/\n{3,}/", "\n\n", str_replace("\r", '', $bio));
    if (mb_strlen($bio) > MPSL_BIO_MAX) {
        $errors[] = 'mpsl_err_bio_len';
    }
    if ($bio !== '' && mpsl_has_contacts($bio)) {
        $errors[] = 'mpsl_err_bio_contacts';
    }
    $site = trim((string) ($in['website_url'] ?? ''));
    if ($site !== '' && (!mp_is_http_url($site) || !str_starts_with($site, 'https://') || mb_strlen($site) > 500)) {
        $errors[] = 'mpsl_err_site';
    }
    $newLogo = null;
    if ($file !== null && (int) ($file['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_NO_FILE) {
        $chk = mpb_inspect_photo($file);
        if (is_string($chk)) {
            $errors[] = $chk;
        } elseif ($errors === []) {
            try {
                $p = mpb_process_photo($chk['tmp'], $chk['mime']);
                mpb_delete_photo_files($p['file_name']);   // зберігаємо один файл — мініатюру
                $newLogo = $p['thumb_name'];
            } catch (Throwable $e) {
                error_log('[mp-seller] logo: ' . $e->getMessage());
                $errors[] = 'mpb_err_photo_upload';
            }
        }
    }
    if ($errors !== []) {
        if ($newLogo !== null) {
            mpb_delete_photo_files($newLogo);
        }

        return $errors;
    }
    $logo = $seller['logo'] !== null && $seller['logo'] !== '' ? (string) $seller['logo'] : null;
    $oldToDelete = null;
    if ($newLogo !== null) {
        $oldToDelete = $logo;
        $logo = $newLogo;
    } elseif (!empty($in['remove_logo'])) {
        $oldToDelete = $logo;
        $logo = null;
    }
    $pdo->prepare('UPDATE mp_sellers SET bio = :b, website_url = :w, page_public = :p, logo = :l WHERE id = :id')
        ->execute([':b' => $bio !== '' ? $bio : null, ':w' => $site !== '' ? $site : null, ':p' => !empty($in['page_public']) ? 1 : 0, ':l' => $logo, ':id' => (int) $seller['id']]);
    if ($oldToDelete !== null && $oldToDelete !== $logo) {
        mpb_delete_photo_files($oldToDelete);
    }

    return [];
}
