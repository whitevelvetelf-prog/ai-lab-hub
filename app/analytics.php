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
 */

/** Анонімний хеш поточної сесії — не персональні дані, IP у явному вигляді не зберігається. */
function analytics_session_hash(): string
{
    $sid = session_id() ?: '';
    $ip = $_SERVER['REMOTE_ADDR'] ?? '';

    return hash('sha256', $sid . '|' . $ip);
}

/**
 * Записати перегляд сторінки. Помилки запису (напр. таблиці ще нема,
 * якщо міграцію не застосовано) не повинні ламати рендер сторінки —
 * лише лог.
 *
 * $pageSlug — для сторінок без запису в БД (статті блогу), замість $pageId.
 * Колонка page_slug — з міграції 2026-09-27; без неї пишеться лише базовий
 * рядок, щоб загальний лічильник не зупинився.
 */
function analytics_log_view(PDO $pdo, string $pageType, ?int $pageId = null, ?string $pageSlug = null): void
{
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

/** Записати клік по кнопці «Перейти на сайт» (public/go.php). */
function analytics_log_click(PDO $pdo, int $productId, string $linkType): void
{
    try {
        $stmt = $pdo->prepare(
            'INSERT INTO link_clicks (product_id, link_type, session_hash) VALUES (:pid, :type, :hash)'
        );
        $stmt->execute([
            ':pid' => $productId,
            ':type' => $linkType,
            ':hash' => analytics_session_hash(),
        ]);
    } catch (Throwable $e) {
        error_log('[analytics] ' . $e->getMessage());
    }
}
