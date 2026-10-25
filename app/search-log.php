<?php

declare(strict_types=1);

/**
 * AI LAB HUB — журнал пошукових запитів (таблиця search_queries, міграція 2026-10-25).
 *
 * Пишуть: api-search.php (живий пошук у шапці, source = header), catalog.php?search=
 * (сторінка результатів, catalog) і api-eli-chat.php (запит до Елі, eli).
 *
 * Анонімно, як page_views: session_hash без IP і User-Agent; боти (analytics_device_class)
 * і співробітники (site_stats_skip_view) не пишуться. Пошта, телефони й посилання в тексті
 * маскуються, текст обрізається до 160 символів. Живий пошук шле запит на кожне натискання,
 * тож у межах SEARCH_LOG_TYPING_SEC одного сеансу рядок не множиться, а оновлюється до
 * довшого варіанта («chat» → «chatgpt»). Рядки старші за SEARCH_LOG_KEEP_DAYS видаляються
 * самим логером (зрідка, з імовірністю 1/200 на запис).
 *
 * Помилки (напр. міграцію ще не застосовано) лише йдуть у лог — пошук працює як раніше.
 */

require_once __DIR__ . '/analytics.php';

const SEARCH_LOG_MAX_LEN = 160;
const SEARCH_LOG_TYPING_SEC = 90;
const SEARCH_LOG_KEEP_DAYS = 180;

/** Маскування персональних даних і обрізання. */
function search_log_sanitize(string $text): string
{
    $t = (string) preg_replace('/\s+/u', ' ', trim($text));
    $t = (string) preg_replace('~https?://\S+|www\.\S+~iu', '[url]', $t);
    $t = (string) preg_replace('/[\p{L}\p{N}._%+-]+@[\p{L}\p{N}.-]+\.\p{L}{2,}/u', '[email]', $t);
    $t = (string) preg_replace('/\+?\d[\d\s()-]{6,}\d/u', '[phone]', $t);

    return mb_substr($t, 0, SEARCH_LOG_MAX_LEN);
}

/** Нормалізована форма для групування: малі літери, без розділових знаків. */
function search_log_normalize(string $text): string
{
    $t = mb_strtolower($text);
    $t = str_replace(["'", '’', 'ʼ', '`'], '', $t);
    $t = (string) preg_replace('/[^\p{L}\p{N}\[\]]+/u', ' ', $t);

    return mb_substr(trim($t), 0, SEARCH_LOG_MAX_LEN);
}

function search_log_query(PDO $pdo, string $query, string $source, int $results): void
{
    try {
        if (analytics_device_class() === 'bot') {
            return;
        }
        // api-search.php не підключає auth.php — роль беремо прямо із сесії (якщо вона відкрита).
        $role = function_exists('auth_role') ? auth_role() : (is_string($_SESSION['role'] ?? null) ? $_SESSION['role'] : null);
        if (in_array($role, ['admin', 'employee'], true) && site_setting($pdo, 'stats_exclude_staff', '1') === '1') {
            return;
        }
        $text = search_log_sanitize($query);
        $norm = search_log_normalize($text);
        if (mb_strlen($norm) < 2) {
            return;
        }
        $hash = analytics_session_hash();
        $lang = function_exists('current_lang') ? current_lang() : 'uk';
        $lang = substr(preg_replace('/[^a-z-]/', '', strtolower($lang)) ?: 'uk', 0, 5);
        $results = max(0, min(65535, $results));

        if ($source === 'header') {
            $prev = $pdo->prepare(
                "SELECT id, query_norm FROM search_queries
                 WHERE session_hash = :h AND source = 'header'
                   AND created_at >= NOW() - INTERVAL " . SEARCH_LOG_TYPING_SEC . ' SECOND
                 ORDER BY id DESC LIMIT 1'
            );
            $prev->execute([':h' => $hash]);
            $row = $prev->fetch();
            if ($row !== false) {
                $old = (string) $row['query_norm'];
                if ($old === $norm || str_starts_with($old, $norm)) {
                    return; // стирання символів або той самий запит
                }
                if (str_starts_with($norm, $old)) {
                    $pdo->prepare(
                        'UPDATE search_queries SET query_text = :t, query_norm = :n, results_count = :r, created_at = NOW() WHERE id = :id'
                    )->execute([':t' => $text, ':n' => $norm, ':r' => $results, ':id' => (int) $row['id']]);

                    return;
                }
            }
        }

        $pdo->prepare(
            'INSERT INTO search_queries (query_text, query_norm, source, results_count, session_hash, lang, created_at)
             VALUES (:t, :n, :s, :r, :h, :l, NOW())'
        )->execute([':t' => $text, ':n' => $norm, ':s' => $source, ':r' => $results, ':h' => $hash, ':l' => $lang]);

        if (random_int(1, 200) === 1) {
            $pdo->exec('DELETE FROM search_queries WHERE created_at < NOW() - INTERVAL ' . SEARCH_LOG_KEEP_DAYS . ' DAY');
        }
    } catch (Throwable $e) {
        error_log('[search-log] ' . $e->getMessage());
    }
}
