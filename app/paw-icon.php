<?php

declare(strict_types=1);

/**
 * AI LAB HUB — іконка-лапка для кнопки «зберегти в добірку».
 *
 * Джерело: public/assets/icons/paw-icon.svg (один <path fill="currentColor">,
 * viewBox 0 0 1024 1024). Щоб не інлайнити важкий <path> у кожну картку,
 * вкладаємо його ОДИН раз як <symbol> (paw_icon_sprite(), викликається з
 * app/footer.php), а картки посилаються на нього через <use> (paw_icon_use()).
 * Колір керується через currentColor.
 */

/** Дані <path d="…"> з файлу іконки (кешовано на час запиту). */
function paw_icon_path_d(): string
{
    static $d = null;
    if ($d === null) {
        $file = __DIR__ . '/../public/assets/icons/paw-icon.svg';
        $svg = is_readable($file) ? (string) file_get_contents($file) : '';
        $d = (preg_match('/<path\b[^>]*\bd="([^"]+)"/s', $svg, $m) === 1) ? $m[1] : '';
    }

    return $d;
}

/**
 * Прихований <symbol> з іконкою — підключати один раз на сторінку
 * (робить app/footer.php). Порожній рядок, якщо файл іконки не знайдено.
 */
function paw_icon_sprite(): string
{
    $d = paw_icon_path_d();
    if ($d === '') {
        return '';
    }

    return '<svg xmlns="http://www.w3.org/2000/svg" style="position:absolute;width:0;height:0;overflow:hidden" aria-hidden="true">'
        . '<symbol id="paw-icon" viewBox="0 0 1024 1024">'
        . '<path fill="currentColor" fill-rule="evenodd" clip-rule="evenodd" d="' . htmlspecialchars($d, ENT_QUOTES) . '"/>'
        . '</symbol></svg>';
}

/** Inline-SVG посилання на <symbol> для вставки в кнопку картки. */
function paw_icon_use(): string
{
    return '<svg class="paw-icon" viewBox="0 0 1024 1024" aria-hidden="true" focusable="false"><use href="#paw-icon"></use></svg>';
}
