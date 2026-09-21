<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: рендер Правил розміщення оголошень із docs/marketplace_rules_uk.md.
 *
 * Текст правил редагується в цьому md-файлі (без правок коду). Рендерер розуміє лише те, що є у файлі:
 * # / ## заголовки, абзаци, списки «- », цитати «> », горизонтальну лінію. Увесь текст екранується.
 * Фрагменти в квадратних дужках [ ... ] (місця для підстановки) виводяться видимим маркером.
 * Рядок «Редакція від: …» показує дату з config 'rules_version'. Розділ «Текст для галочки…» на сторінку
 * не виводиться на сторінку: його бере mpb_rules_checkbox_text() для галочки в mp-post.php (той самий файл —
 * єдине джерело тексту; у app/translations.php тексту Правил немає).
 */

const MPB_RULES_FILE = __DIR__ . '/../docs/marketplace_rules_uk.md';

/** Екранує текст і підсвічує [місця для підстановки]. */
function mpb_rules_inline(string $text): string
{
    $safe = htmlspecialchars($text, ENT_QUOTES);

    return preg_replace('/\[[^\]\n]*\]/u', '<mark class="mp-ph">$0</mark>', $safe) ?? $safe;
}

/** Дата редакції з конфігу для показу: 2026-09-21 → 21.09.2026 (некоректне значення показується як є). */
function mpb_rules_version_label(): string
{
    $v = trim((string) mp_config()['rules_version']);
    $t = preg_match('/^\d{4}-\d{2}-\d{2}$/', $v) === 1 ? strtotime($v) : false;

    return $t !== false ? date('d.m.Y', $t) : $v;
}

/**
 * @return array{title:string,html:string}|null  null — файл правил відсутній
 */
function mpb_rules_render(?string $file = null): ?array
{
    $file ??= MPB_RULES_FILE;
    if (!is_file($file)) {
        return null;
    }
    $lines = preg_split('/\r\n|\r|\n/', (string) file_get_contents($file)) ?: [];
    $title = '';
    $html = '';
    $para = [];
    $list = [];
    $quote = [];

    $flush = static function () use (&$html, &$para, &$list, &$quote): void {
        if ($para !== []) {
            $html .= '<p>' . mpb_rules_inline(implode(' ', $para)) . '</p>';
            $para = [];
        }
        if ($list !== []) {
            $html .= '<ul>' . implode('', array_map(static fn(string $i): string => '<li>' . mpb_rules_inline($i) . '</li>', $list)) . '</ul>';
            $list = [];
        }
        if ($quote !== []) {
            $html .= '<div class="mp-callout">' . mpb_rules_inline(implode(' ', $quote)) . '</div>';
            $quote = [];
        }
    };

    foreach ($lines as $line) {
        $line = rtrim($line);
        if (preg_match('/^##\s+Текст для галочки/u', $line) === 1) {
            break;   // далі — службовий розділ, не для сторінки
        }
        if ($line === '' || $line === '---') {
            $flush();
            continue;
        }
        if (preg_match('/^#\s+(.+)$/u', $line, $m) === 1) {
            $flush();
            $title = $m[1];
            continue;
        }
        if (preg_match('/^##\s+(.+)$/u', $line, $m) === 1) {
            $flush();
            $html .= '<h2>' . mpb_rules_inline($m[1]) . '</h2>';
            continue;
        }
        if (preg_match('/^Редакція від:/u', $line) === 1) {
            $flush();
            $html .= '<p class="mp-rules__version">Редакція від: <strong>' . htmlspecialchars(mpb_rules_version_label(), ENT_QUOTES) . '</strong></p>';
            continue;
        }
        if (preg_match('/^>\s?(.*)$/u', $line, $m) === 1) {
            if ($para !== [] || $list !== []) {
                $flush();
            }
            $quote[] = $m[1];
            continue;
        }
        if (preg_match('/^-\s+(.+)$/u', $line, $m) === 1) {
            if ($para !== [] || $quote !== []) {
                $flush();
            }
            $list[] = $m[1];
            continue;
        }
        if ($list !== [] || $quote !== []) {
            $flush();
        }
        $para[] = $line;
    }
    $flush();

    return ['title' => $title, 'html' => $html];
}

/**
 * Текст галочки з розділу «Текст для галочки…» файлу правил (блок цитати «> …»), або null.
 */
function mpb_rules_checkbox_uk(?string $file = null): ?string
{
    $file ??= MPB_RULES_FILE;
    if (!is_file($file)) {
        return null;
    }
    $in = false;
    $parts = [];
    foreach (preg_split('/\r\n|\r|\n/', (string) file_get_contents($file)) ?: [] as $line) {
        if (preg_match('/^##\s+Текст для галочки/u', $line) === 1) {
            $in = true;
            continue;
        }
        if (!$in) {
            continue;
        }
        if (preg_match('/^##?\s/u', $line) === 1) {
            break;   // наступний заголовок — кінець розділу
        }
        if (preg_match('/^>\s?(.*)$/u', $line, $m) === 1 && trim($m[1]) !== '') {
            $parts[] = trim($m[1]);
        }
    }

    return $parts === [] ? null : implode(' ', $parts);
}

/**
 * Текст галочки для мови інтерфейсу: українською — дослівно з md; іншими мовами — готовий переклад
 * ключа mpb_f_rules_text з ui_translations (мова → en); без перекладу — український текст із md.
 * (t() тут не викликаємо: українського значення в app/translations.php свідомо немає.)
 */
function mpb_rules_checkbox_text(string $lang): string
{
    $uk = mpb_rules_checkbox_uk() ?? '';
    if ($lang === 'uk') {
        return $uk;
    }
    try {
        foreach ([$lang, 'en'] as $l) {
            $map = ui_translations_map($l);
            if (!empty($map['mpb_f_rules_text'])) {
                return (string) $map['mpb_f_rules_text'];
            }
        }
    } catch (Throwable) {
        // немає таблиці ui_translations — лишається український текст
    }

    return $uk;
}
