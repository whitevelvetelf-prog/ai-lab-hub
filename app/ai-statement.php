<?php

declare(strict_types=1);

/**
 * AI LAB HUB — сторінка «Як ми використовуємо АІ» (public/ai-statement.php).
 *
 * Єдине джерело тексту — docs/ai_statement_uk.md (як Правила Marketplace: поза webroot, docs/.htaccess забороняє
 * доступ з вебу; рендер — mpb_rules_render() з app/mpb-rules.php). Поки у файлі є маркери «[ПІДТВЕРДИТИ…]»,
 * сторінка публічно віддає 404 (admin і employee бачать її з попередженням), а посилання в підвалі не показується.
 * Збірка (scripts/build-deploy.ps1) попереджає, якщо маркери лишилися.
 */

// Тести (tests/ai-statement-tests.php) підставляють тимчасову копію, визначаючи AIS_FILE до підключення файлу.
if (!defined('AIS_FILE')) {
    define('AIS_FILE', __DIR__ . '/../docs/ai_statement_uk.md');
}
const AIS_MARKER = '[ПІДТВЕРДИТИ';

/** Кількість маркерів «[ПІДТВЕРДИТИ…]» у файлі (-1 — файлу немає). */
function ais_marker_count(): int
{
    static $count = null;
    if ($count === null) {
        $text = is_file(AIS_FILE) ? @file_get_contents(AIS_FILE) : false;
        $count = is_string($text) ? substr_count($text, AIS_MARKER) : -1;
    }

    return $count;
}

/** Чи сторінка опублікована (файл є і маркерів немає) — для посилання в підвалі. */
function ais_is_public(): bool
{
    return ais_marker_count() === 0;
}
