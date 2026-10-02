<?php

declare(strict_types=1);

/**
 * AI LAB HUB — блог: реєстр статей + завантаження контенту з content/blog/.
 *
 * Кожна стаття існує як окремий Markdown-файл на мову (простий текстовий
 * контент, без БД чи CMS) у content/blog/ (поза public/ — не веб-доступний
 * напряму, читається лише через public/blog.php і public/blog-post.php).
 *
 * Формат файлу: YAML-подібний frontmatter (--- title / description ---)
 * і далі Markdown-тіло. Підтримується підмножина Markdown, якої досить для
 * статей-порівнянь: заголовки #/##/###, **жирний**, *курсив*, [текст](url), списки
 * "- пункт", таблиці "| ... | ... |", роздільник "---". Розширювати конвертер лише під
 * реальну потребу нової статті — не про запас.
 */

const BLOG_CONTENT_DIR = __DIR__ . '/../content/blog';

/**
 * Реєстр статей: slug (у URL) => файл Markdown на кожну мову.
 * Один запис тут = одна стаття, синхронізована по мовах.
 */
const BLOG_ARTICLES = [
    'ai-for-design-and-images' => [
        'uk' => 'ai-dlya-dyzainu-ta-zobrazhen-ua.md',
        'en' => 'ai-for-design-and-image-generation-en.md',
    ],
    'ai-for-language-learning' => [
        'uk' => 'ai-dlya-vyvchennya-mov-ua.md',
        'en' => 'ai-for-language-learning-en.md',
    ],
    'ai-for-psychology-and-mental-health' => [
        'uk' => 'ai-dlya-psyhologiyi-ta-mentalnogo-zdorovya-ua.md',
        'en' => 'ai-for-psychology-and-mental-health-en.md',
    ],
];

/**
 * Мова оригіналу статей: її файл є завжди, на нього падає фолбек, коли
 * перекладу ще немає, і його URL (без параметра hl) — x-default для hreflang.
 *
 * Якою мовою показати статтю, вирішує глобальний перемикач UA/EN у шапці
 * ($_SESSION['lang'], current_lang()) — окремого перемикача в блозі немає.
 * URL з &hl=<код> лишається лише адресою мовної версії для пошуковиків
 * (hreflang, sitemap): відкриття такої адреси вмикає цю мову для всього
 * сайту, а перемикач у шапці прибирає hl з адреси (app/translations.php).
 */
const BLOG_DEFAULT_LANG = 'uk';

/** Канонічний домен для абсолютних URL у hreflang/canonical (і public/sitemap.xml). */
const BLOG_SITE_URL = 'https://ailabhub-directory.com';

/** Мови, для яких у статті є файл (порядок — як у реєстрі). @return list<string> */
function blog_article_langs(string $slug): array
{
    return array_keys(BLOG_ARTICLES[$slug] ?? []);
}

/** URL мовної версії статті (відносний або абсолютний на канонічному домені). */
function blog_article_url(string $slug, string $lang, bool $absolute = false): string
{
    $url = 'blog-post.php?slug=' . rawurlencode($slug)
        . ($lang !== BLOG_DEFAULT_LANG ? '&hl=' . rawurlencode($lang) : '');

    return $absolute ? BLOG_SITE_URL . '/' . $url : $url;
}

/** @return array{title: string, description: string, body: string}|null */
function blog_read_file(string $filename): ?array
{
    $path = BLOG_CONTENT_DIR . '/' . $filename;
    if (!is_file($path)) {
        return null;
    }

    $raw = file_get_contents($path);
    if ($raw === false) {
        return null;
    }

    $title = '';
    $description = '';
    $body = $raw;

    if (preg_match('/^---\s*\n(.*?)\n---\s*\n(.*)$/s', $raw, $m)) {
        foreach (explode("\n", $m[1]) as $line) {
            if (preg_match('/^(title|description):\s*"(.*)"\s*$/', trim($line), $fm)) {
                if ($fm[1] === 'title') {
                    $title = $fm[2];
                } else {
                    $description = $fm[2];
                }
            }
        }
        $body = $m[2];
    }

    return ['title' => $title, 'description' => $description, 'body' => trim($body)];
}

/**
 * Мова файлу, з якого показати статтю: запитана, якщо переклад уже є,
 * інакше мова оригіналу (переклади додаються поступово).
 */
function blog_file_lang(array $files, string $lang): string
{
    return isset($files[$lang]) ? $lang : BLOG_DEFAULT_LANG;
}

/**
 * Дані статті мовою $lang (з фолбеком на мову оригіналу, якщо перекладу
 * ще немає) — заголовок, мета-опис, готовий HTML і мова файлу, з якого
 * їх узято (lang ≠ $lang означає «переклад ще готується»).
 *
 * @return array{title: string, description: string, html: string, lang: string}|null
 */
function blog_load_article(string $slug, string $lang): ?array
{
    $files = BLOG_ARTICLES[$slug] ?? null;
    if ($files === null) {
        return null;
    }

    $fileLang = blog_file_lang($files, $lang);
    $filename = $files[$fileLang] ?? null;
    if ($filename === null) {
        return null;
    }

    $article = blog_read_file($filename);
    if ($article === null) {
        return null;
    }

    return [
        'title' => $article['title'],
        'description' => $article['description'],
        'html' => blog_markdown_to_html($article['body']),
        'lang' => $fileLang,
    ];
}

/**
 * Список усіх статей для сторінки блогу: slug, заголовок і опис мовою
 * $lang з тим самим фолбеком (без конвертації в HTML — на списку лише анонс).
 *
 * @return list<array{slug: string, title: string, description: string, lang: string}>
 */
function blog_list_articles(string $lang): array
{
    $list = [];

    foreach (BLOG_ARTICLES as $slug => $files) {
        $fileLang = blog_file_lang($files, $lang);
        $filename = $files[$fileLang] ?? null;
        if ($filename === null) {
            continue;
        }

        $article = blog_read_file($filename);
        if ($article === null) {
            continue;
        }

        $list[] = [
            'slug' => $slug,
            'title' => $article['title'],
            'description' => $article['description'],
            'lang' => $fileLang,
        ];
    }

    return $list;
}

/** Екранує текст і застосовує inline-розмітку (**жирний**, *курсив*, [текст](url)). */
function blog_inline_html(string $text): string
{
    $escaped = htmlspecialchars($text, ENT_QUOTES, 'UTF-8');

    $escaped = preg_replace('/\*\*(.+?)\*\*/', '<strong>$1</strong>', $escaped);
    $escaped = preg_replace('/\*(.+?)\*/', '<em>$1</em>', $escaped);

    return preg_replace_callback(
        '/\[([^\]]+)\]\(([^)]+)\)/',
        static fn (array $m): string => '<a href="' . $m[2] . '">' . $m[1] . '</a>',
        $escaped
    );
}

/**
 * Мінімальний Markdown → HTML для статей блогу.
 * Підтримує: #/##/### заголовки (перший # у тілі пропускається — дублює
 * H1 сторінки), **жирний**, *курсив*, [текст](url), списки "- ", таблиці "| ... |",
 * роздільник "---".
 */
function blog_markdown_to_html(string $markdown): string
{
    $lines = explode("\n", $markdown);
    $html = [];

    $listBuffer = [];
    $tableBuffer = [];
    $skippedH1 = false;

    $flushList = static function () use (&$listBuffer, &$html): void {
        if ($listBuffer === []) {
            return;
        }
        $html[] = '<ul>';
        foreach ($listBuffer as $item) {
            $html[] = '<li>' . blog_inline_html($item) . '</li>';
        }
        $html[] = '</ul>';
        $listBuffer = [];
    };

    $flushTable = static function () use (&$tableBuffer, &$html): void {
        if ($tableBuffer === []) {
            return;
        }

        $rows = array_values(array_filter($tableBuffer, static function (string $row): bool {
            return !preg_match('/^\|[\s:|-]+\|$/', trim($row));
        }));

        if ($rows !== []) {
            $html[] = '<div class="blog-table-wrap"><table>';
            foreach ($rows as $i => $row) {
                $cells = array_map('trim', explode('|', trim($row, "| \t")));
                $tag = $i === 0 ? 'th' : 'td';
                $html[] = $i === 0 ? '<thead><tr>' : ($i === 1 ? '<tbody><tr>' : '<tr>');
                foreach ($cells as $cell) {
                    $html[] = "<{$tag}>" . blog_inline_html($cell) . "</{$tag}>";
                }
                $html[] = '</tr>';
                if ($i === 0) {
                    $html[] = '</thead>';
                }
            }
            $html[] = '</tbody></table></div>';
        }

        $tableBuffer = [];
    };

    foreach ($lines as $line) {
        $trimmed = trim($line);

        if ($trimmed === '') {
            $flushList();
            $flushTable();
            continue;
        }

        if (str_starts_with($trimmed, '#')) {
            $flushList();
            $flushTable();

            if (preg_match('/^(#{1,3})\s+(.*)$/', $trimmed, $m)) {
                $level = strlen($m[1]);
                if ($level === 1 && !$skippedH1) {
                    // Перший H1 тіла дублює заголовок сторінки — пропускаємо.
                    $skippedH1 = true;
                    continue;
                }
                $html[] = "<h{$level}>" . blog_inline_html($m[2]) . "</h{$level}>";
            }
            continue;
        }

        if (preg_match('/^-{3,}$/', $trimmed)) {
            $flushList();
            $flushTable();
            $html[] = '<hr>';
            continue;
        }

        if (str_starts_with($trimmed, '|')) {
            $flushList();
            $tableBuffer[] = $trimmed;
            continue;
        }

        if (str_starts_with($trimmed, '- ')) {
            $flushTable();
            $listBuffer[] = substr($trimmed, 2);
            continue;
        }

        $flushList();
        $flushTable();
        $html[] = '<p>' . blog_inline_html($trimmed) . '</p>';
    }

    $flushList();
    $flushTable();

    return implode("\n", $html);
}
