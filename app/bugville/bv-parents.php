<?php

declare(strict_types=1);

/**
 * Багвіль — текст «Для батьків і вчителів» з docs/bugville/PARENTS_uk.md (MAIN_TASK, розділ 2).
 * Поки в тексті є маркер [ПІДТВЕРДИТИ], сторінка недоступна (404), а посилання на неї не показується.
 */

/** Текст сторінки або null (файлу немає чи є маркери [ПІДТВЕРДИТИ]). */
function bv_parents_text(): ?string
{
    $file = dirname(__DIR__, 2) . '/docs/bugville/PARENTS_uk.md';
    $text = is_file($file) ? (string) file_get_contents($file) : '';
    if (trim($text) === '' || str_contains($text, '[ПІДТВЕРДИТИ')) {
        return null;
    }

    return $text;
}

/** Мінімальний Markdown → HTML: «# »/«## » заголовки, «- » списки, абзаци, **жирний**. Увесь текст екранується. */
function bv_parents_html(string $md): string
{
    $out = [];
    $list = false;
    // /u обовʼязковий: без нього \R ловить байт 0x85, що є всередині кириличних літер (напр. «х» = D1 85), і рве слова.
    foreach (preg_split('/\R/u', $md) as $line) {
        $line = rtrim($line);
        $inline = static fn(string $s) => preg_replace('/\*\*(.+?)\*\*/u', '<strong>$1</strong>', htmlspecialchars($s, ENT_QUOTES, 'UTF-8'));
        if (str_starts_with($line, '- ')) {
            if (!$list) {
                $out[] = '<ul>';
                $list = true;
            }
            $out[] = '<li>' . $inline(substr($line, 2)) . '</li>';
            continue;
        }
        if ($list) {
            $out[] = '</ul>';
            $list = false;
        }
        if ($line === '') {
            continue;
        }
        if (preg_match('/^(#{1,3}) (.+)$/u', $line, $m) === 1) {
            $lvl = strlen($m[1]);
            $out[] = '<h' . $lvl . ($lvl === 1 ? ' class="bv-title"' : '') . '>' . $inline($m[2]) . '</h' . $lvl . '>';
            continue;
        }
        $out[] = '<p>' . $inline($line) . '</p>';
    }
    if ($list) {
        $out[] = '</ul>';
    }

    return implode("\n", $out);
}
