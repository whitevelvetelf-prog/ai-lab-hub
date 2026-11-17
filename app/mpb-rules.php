<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: рендер Правил Marketplace з docs/marketplace_rules_uk.md (UA) і docs/marketplace_rules_en.md (EN).
 *
 * Текст правил редагується в md-файлах (без правок коду). Рендерер розуміє лише те, що є у файлах:
 * # / ## заголовки, абзаци, списки «- » і «1. », таблиці «| … |», цитати «> », горизонтальну лінію, **жирний**,
 * посилання [текст](url) (лише відносні *.php або https; решта не стає посиланням). Увесь текст екранується.
 *
 * [MP_XXX] — підстановка значення константи з config/marketplace.php (строки, email, дата редакції), тож числа
 * в Правилах і в коді завжди однакові. Інші фрагменти в квадратних дужках [ ... ] виводяться видимим маркером.
 * Якорі: розділ «## 7. …» → id="section-7"; абзац «7.5. …» → id="section-7-5" (для посилань із форм і листів).
 */

require_once __DIR__ . '/marketplace.php';       // константи MP_* (config/marketplace.php)
require_once __DIR__ . '/mp-legal-i18n.php';

const MPB_RULES_FILE = __DIR__ . '/../docs/marketplace_rules_uk.md';
const MPB_RULES_FILE_EN = __DIR__ . '/../docs/marketplace_rules_en.md';

/** Файл Правил для мови інтерфейсу: uk → український, інші → англійський (якщо є). */
function mpb_rules_file(string $lang): string
{
    return $lang !== 'uk' && is_file(MPB_RULES_FILE_EN) ? MPB_RULES_FILE_EN : MPB_RULES_FILE;
}

/** Безпечний href для посилання в тексті правил: відносна сторінка сайту (*.php) або https-адреса. */
function mpb_rules_safe_href(string $url): bool
{
    return preg_match('@^(?:[A-Za-z0-9_\-]+\.php(?:\?[A-Za-z0-9_=&%.\-]*)?(?:#[A-Za-z0-9_\-]+)?|https://[A-Za-z0-9.\-]+(?::\d{1,5})?(?:/[A-Za-z0-9._~%/\-]*)?(?:\?[A-Za-z0-9_=&%.\-]*)?)$@', $url) === 1;
}

/** Дата редакції для показу: 2026-11-17 → 17.11.2026 (uk) або 2026-11-17 (en); некоректне значення — як є. */
function mpb_rules_version_label(string $lang = 'uk'): string
{
    $v = trim((string) MP_RULES_VERSION);
    $t = preg_match('/^\d{4}-\d{2}-\d{2}$/', $v) === 1 ? strtotime($v) : false;

    return $t !== false ? date($lang === 'uk' ? 'd.m.Y' : 'Y-m-d', $t) : $v;
}

/** Значення підстановок [MP_XXX] (лише відомі константи; невідомі лишаються маркером). @return array<string,string> */
function mpb_rules_values(string $lang = 'uk'): array
{
    $out = ['MP_RULES_VERSION' => mpb_rules_version_label($lang)];
    foreach (['MP_ABUSE_EMAIL', 'MP_MODERATION_DAYS', 'MP_APPEAL_WINDOW_DAYS', 'MP_APPEAL_ANSWER_DAYS', 'MP_IP_REVIEW_DAYS',
        'MP_COUNTER_NOTICE_DAYS', 'MP_LISTING_LIFETIME_DAYS', 'MP_RULES_CHANGE_NOTICE_DAYS', 'MP_CONTACT_VIEWS_PER_DAY'] as $c) {
        if (defined($c)) {
            $out[$c] = (string) constant($c);
        }
    }

    return $out;
}

/** Екранує текст, підставляє [MP_XXX], підсвічує інші [маркери], робить посилання з [текст](url) і email-адрес. */
function mpb_rules_inline(string $text, string $lang = 'uk'): string
{
    $values = mpb_rules_values($lang);
    $text = preg_replace_callback('/\[(MP_[A-Z_]+)\]/', static fn(array $m): string => $values[$m[1]] ?? $m[0], $text) ?? $text;
    $parts = preg_split('/(\[[^\]\n]+\]\([^)\s]+\))/u', $text, -1, PREG_SPLIT_DELIM_CAPTURE) ?: [$text];
    $html = '';
    foreach ($parts as $i => $part) {
        if ($i % 2 === 1 && preg_match('/^\[([^\]\n]+)\]\(([^)\s]+)\)$/u', $part, $m) === 1 && mpb_rules_safe_href($m[2])) {
            $ext = str_starts_with($m[2], 'https://') ? ' target="_blank" rel="noopener noreferrer"' : '';
            $html .= '<a href="' . htmlspecialchars($m[2], ENT_QUOTES) . '"' . $ext . '>' . htmlspecialchars($m[1], ENT_QUOTES) . '</a>';
            continue;
        }
        $safe = htmlspecialchars($part, ENT_QUOTES);
        $safe = preg_replace('/\[[^\]\n]*\]/u', '<mark class="mp-ph">$0</mark>', $safe) ?? $safe;
        $safe = preg_replace('/\b([a-z0-9._-]+@ailabhub-directory\.com|hello\.ailabhub\.directory@gmail\.com)\b/', '<a href="mailto:$1">$1</a>', $safe) ?? $safe;   // уже екрановано
        $html .= preg_replace('/\*\*(?=\S)(.+?)(?<=\S)\*\*/u', '<strong>$1</strong>', $safe) ?? $safe;
    }

    return $html;
}

/**
 * @return array{title:string,html:string,toc:list<array{id:string,title:string}>}|null  null — файл правил відсутній
 */
function mpb_rules_render(?string $file = null, string $lang = 'uk'): ?array
{
    $file ??= mpb_rules_file($lang);
    if (!is_file($file)) {
        return null;
    }
    $lines = preg_split('/\r\n|\r|\n/', (string) file_get_contents($file)) ?: [];
    $title = '';
    $html = '';
    $toc = [];
    $para = [];
    $paraId = '';
    $list = [];
    $olist = [];
    $quote = [];
    $table = [];
    $in = static fn(string $s): string => mpb_rules_inline($s, $lang);

    $flush = static function () use (&$html, &$para, &$paraId, &$list, &$olist, &$quote, &$table, $in): void {
        if ($para !== []) {
            $html .= '<p' . ($paraId !== '' ? ' id="' . $paraId . '"' : '') . '>' . $in(implode(' ', $para)) . '</p>';
            $para = [];
            $paraId = '';
        }
        if ($list !== []) {
            $html .= '<ul>' . implode('', array_map(static fn(string $i): string => '<li>' . $in($i) . '</li>', $list)) . '</ul>';
            $list = [];
        }
        if ($olist !== []) {
            $html .= '<ol>' . implode('', array_map(static fn(string $i): string => '<li>' . $in($i) . '</li>', $olist)) . '</ol>';
            $olist = [];
        }
        if ($quote !== []) {
            $html .= '<div class="mp-callout">' . $in(implode(' ', $quote)) . '</div>';
            $quote = [];
        }
        if ($table !== []) {
            $rows = '';
            foreach ($table as $ri => $cells) {
                $tag = $ri === 0 ? 'th' : 'td';
                $rows .= '<tr>' . implode('', array_map(static fn(string $c): string => "<$tag>" . $in($c) . "</$tag>", $cells)) . '</tr>';
            }
            $html .= '<div class="mp-rules__table"><table>' . $rows . '</table></div>';
            $table = [];
        }
    };

    foreach ($lines as $line) {
        $line = rtrim($line);
        if (preg_match('/^##\s+Текст для галочки/u', $line) === 1) {
            break;   // службовий розділ давніх редакцій — не для сторінки
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
            $id = preg_match('/^(\d+)\.\s/u', $m[1], $n) === 1 ? 'section-' . $n[1] : '';
            $html .= '<h2' . ($id !== '' ? ' id="' . $id . '"' : '') . '>' . $in($m[1]) . '</h2>';
            if ($id !== '') {
                $toc[] = ['id' => $id, 'title' => $m[1]];
            }
            continue;
        }
        if (preg_match('/^(?:Редакція від|Version of)\s/u', $line) === 1) {
            $flush();
            $html .= '<p class="mp-rules__version">' . $in($line) . '</p>';
            continue;
        }
        if (preg_match('/^\|(.+)\|$/u', $line, $m) === 1) {
            if ($para !== [] || $list !== [] || $olist !== [] || $quote !== []) {
                $flush();
            }
            $cells = array_map('trim', explode('|', $m[1]));
            if (!preg_match('/^[\s\-:|]+$/', $m[1])) {   // рядок-роздільник «| --- | --- |» пропускаємо
                $table[] = $cells;
            }
            continue;
        }
        if (preg_match('/^>\s?(.*)$/u', $line, $m) === 1) {
            if ($para !== [] || $list !== [] || $olist !== [] || $table !== []) {
                $flush();
            }
            $quote[] = $m[1];
            continue;
        }
        if (preg_match('/^-\s+(.+)$/u', $line, $m) === 1) {
            if ($para !== [] || $quote !== [] || $olist !== [] || $table !== []) {
                $flush();
            }
            $list[] = $m[1];
            continue;
        }
        if (preg_match('/^\d+\.\s+(.+)$/u', $line, $m) === 1) {
            if ($para !== [] || $quote !== [] || $list !== [] || $table !== []) {
                $flush();
            }
            $olist[] = $m[1];
            continue;
        }
        if ($list !== [] || $olist !== [] || $quote !== [] || $table !== []) {
            $flush();
        }
        if ($para === [] && preg_match('/^(\d+)\.(\d+)\.\s/u', $line, $m) === 1) {
            $flush();
            $paraId = 'section-' . $m[1] . '-' . $m[2];
        }
        $para[] = $line;
    }
    $flush();

    return ['title' => $title, 'html' => $html, 'toc' => $toc];
}

/** Текст галочки згоди (п. 1.5) мовою інтерфейсу — з app/mp-legal-i18n.php. Посилання на Правила додає форма. */
function mpb_rules_checkbox_text(string $lang): string
{
    return mpl_tr('consent_label');
}
