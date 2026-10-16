<?php

declare(strict_types=1);

/**
 * AI LAB HUB — власна аналітика (перегляди сторінок, кліки на посилання).
 *
 * Видима лише для admin (public/admin-stats.php). Жодних персональних
 * даних не зберігається — лише session_hash: sha256(session_id . IP),
 * сам IP у явному вигляді ніде не пишеться, використовується тільки як
 * сіль для лічильника унікальних відвідувачів.
 *
 * Підключати після app/auth.php (потрібна активна сесія для session_id()):
 *   require_once __DIR__ . '/../app/auth.php';
 *   require_once __DIR__ . '/../app/analytics.php';
 *
 * Перегляди адмінів і працівників не пишуться, поки в admin-stats.php увімкнено
 * «Не рахувати перегляди адмінів» (site_settings.stats_exclude_staff, типово 1).
 */

require_once __DIR__ . '/site-stats.php';

/** Анонімний хеш поточної сесії — не персональні дані, IP у явному вигляді не зберігається. */
function analytics_session_hash(): string
{
    $sid = session_id() ?: '';
    $ip = $_SERVER['REMOTE_ADDR'] ?? '';

    return hash('sha256', $sid . '|' . $ip);
}

/**
 * Клас пристрою за User-Agent (без збереження самого UA): mobile / tablet /
 * desktop, або bot для відомих ботів і сканерів. Лише для агрегованої
 * статистики аудиторії (медіакіт public/advertise.php).
 */
function analytics_device_class(): string
{
    $ua = (string) ($_SERVER['HTTP_USER_AGENT'] ?? '');
    if ($ua === '' || preg_match('~bot|crawl|spider|slurp|scrap|headless|lighthouse|pagespeed|preview|facebookexternalhit|curl|wget|python|java/|go-http|httpclient|okhttp|axios|node-fetch|monitor|uptime~i', $ua)) {
        return 'bot';
    }
    if (preg_match('~iPad|Tablet|PlayBook|Silk|Android(?!.*Mobile)~i', $ua)) {
        return 'tablet';
    }

    return preg_match('~Mobi|iPhone|iPod|Android~i', $ua) ? 'mobile' : 'desktop';
}

/**
 * Записати перегляд сторінки. Помилки запису (напр. таблиці ще нема,
 * якщо міграцію не застосовано) не повинні ламати рендер сторінки —
 * лише лог.
 *
 * $pageSlug — для сторінок без запису в БД (статті блогу), замість $pageId.
 * Колонка page_slug — з міграції 2026-09-27; device_class і lang — з міграції
 * 2026-10-12 (анонімні: клас пристрою й мова інтерфейсу, без UA й IP). Без
 * нових колонок пишеться попередній варіант рядка, щоб лічильник не зупинився.
 */
function analytics_log_view(PDO $pdo, string $pageType, ?int $pageId = null, ?string $pageSlug = null): void
{
    if (site_stats_skip_view($pdo)) {
        return;
    }
    $lang = function_exists('current_lang') ? substr(current_lang(), 0, 5) : null;
    try {
        $stmt = $pdo->prepare(
            'INSERT INTO page_views (page_type, page_id, page_slug, session_hash, device_class, lang)
             VALUES (:type, :id, :slug, :hash, :dev, :lang)'
        );
        $stmt->execute([
            ':type' => $pageType,
            ':id' => $pageId,
            ':slug' => $pageSlug,
            ':hash' => analytics_session_hash(),
            ':dev' => analytics_device_class(),
            ':lang' => $lang,
        ]);

        return;
    } catch (PDOException $e) {
        // Міграцію 2026-10-12 ще не застосовано — нижче попередній формат.
    }

    try {
        if ($pageSlug !== null) {
            try {
                $stmt = $pdo->prepare(
                    'INSERT INTO page_views (page_type, page_id, page_slug, session_hash)
                     VALUES (:type, :id, :slug, :hash)'
                );
                $stmt->execute([
                    ':type' => $pageType,
                    ':id' => $pageId,
                    ':slug' => $pageSlug,
                    ':hash' => analytics_session_hash(),
                ]);

                return;
            } catch (PDOException $e) {
                error_log('[analytics] page_slug: ' . $e->getMessage());
            }
        }

        $stmt = $pdo->prepare(
            'INSERT INTO page_views (page_type, page_id, session_hash) VALUES (:type, :id, :hash)'
        );
        $stmt->execute([
            ':type' => $pageType,
            ':id' => $pageId,
            ':hash' => analytics_session_hash(),
        ]);
    } catch (Throwable $e) {
        error_log('[analytics] ' . $e->getMessage());
    }
}

/** Повторний клік того самого сеансу по тому самому продукту в межах стільки секунд не рахується. */
const ANALYTICS_CLICK_DEDUP_SEC = 1800;

/**
 * Записати клік по кнопці «Перейти на сайт» (public/go.php).
 *
 * Не пишуться: боти (analytics_device_class), перегляди співробітників (як для page_views,
 * site_settings.stats_exclude_staff) і повторний клік того самого сеансу по тому самому
 * продукту протягом ANALYTICS_CLICK_DEDUP_SEC. Колонка lang — з міграції 2026-10-16
 * (без неї пишеться попередній формат рядка).
 */
function analytics_log_click(PDO $pdo, int $productId, string $linkType): void
{
    if (analytics_device_class() === 'bot' || site_stats_skip_view($pdo)) {
        return;
    }
    $hash = analytics_session_hash();
    try {
        $dup = $pdo->prepare(
            'SELECT 1 FROM link_clicks WHERE product_id = :pid AND session_hash = :hash
               AND clicked_at >= NOW() - INTERVAL ' . ANALYTICS_CLICK_DEDUP_SEC . ' SECOND LIMIT 1'
        );
        $dup->execute([':pid' => $productId, ':hash' => $hash]);
        if ($dup->fetchColumn() !== false) {
            return;
        }
        // go.php не підключає translations.php: мова — із сесії, без неї — мова оригіналу (uk).
        $lang = function_exists('current_lang') ? current_lang() : (is_string($_SESSION['lang'] ?? null) ? $_SESSION['lang'] : 'uk');
        $lang = substr(preg_replace('/[^a-z-]/', '', strtolower($lang)) ?: 'uk', 0, 5);
        try {
            $pdo->prepare('INSERT INTO link_clicks (product_id, link_type, session_hash, lang) VALUES (:pid, :type, :hash, :lang)')
                ->execute([':pid' => $productId, ':type' => $linkType, ':hash' => $hash, ':lang' => $lang]);

            return;
        } catch (PDOException $e) {
            // Міграцію 2026-10-16 (колонка lang) ще не застосовано — попередній формат.
        }
        $pdo->prepare('INSERT INTO link_clicks (product_id, link_type, session_hash) VALUES (:pid, :type, :hash)')
            ->execute([':pid' => $productId, ':type' => $linkType, ':hash' => $hash]);
    } catch (Throwable $e) {
        error_log('[analytics] ' . $e->getMessage());
    }
}
