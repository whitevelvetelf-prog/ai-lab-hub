<?php

declare(strict_types=1);

/**
 * AI LAB HUB — базова багатомовність інтерфейсу (UA / EN).
 *
 * Перекладаємо лише статичні написи сторінок. Контент із бази даних
 * (назви категорій, продуктів тощо) тут НЕ перекладається — це окремий крок.
 *
 * Підключати до будь-якого виводу, одразу після app/auth.php (або першим,
 * якщо auth на сторінці не потрібен):
 *   require_once __DIR__ . '/../app/translations.php';
 *
 * Використання у шаблонах:
 *   <?= t('nav_home') ?>
 *
 * Поточна мова береться з $_SESSION['lang']; типова — 'uk'.
 * Перемикання: посилання на ту саму сторінку з ?lang=uk | ?lang=en.
 */

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

/** Підтримувані мови інтерфейсу. */
const LANGS = ['uk', 'en'];

/** Мова за замовчуванням. */
const LANG_DEFAULT = 'uk';

/**
 * Словник перекладів: ключ => ['uk' => '…', 'en' => '…'].
 * Список фраз зібрано з наявних шаблонів (шапка, підвал, index.php).
 */
$GLOBALS['TRANSLATIONS'] = [
    // --- Шапка / навігація ---
    'nav_home'      => ['uk' => 'Головна',              'en' => 'Home'],
    'nav_account'   => ['uk' => 'Кабінет',              'en' => 'Account'],
    'nav_login'     => ['uk' => 'Увійти',               'en' => 'Log In'],
    'nav_assistant' => ['uk' => 'Викликати Асистента',  'en' => 'Call Assistant'],
    // Короткий підпис кнопки асистента для вузьких екранів (додається через CSS ::after).
    'nav_assistant_short' => ['uk' => 'Спитати Елю',    'en' => 'Ask Eli'],
    'nav_menu'      => ['uk' => 'Меню',                 'en' => 'Menu'],
    'lang_switch'   => ['uk' => 'Мова інтерфейсу',      'en' => 'Interface language'],

    // --- index.php: hero + напрямки ---
    'title_home'        => ['uk' => 'AI LAB HUB — Головна', 'en' => 'AI LAB HUB — Home'],
    'hero_title'        => ['uk' => 'AI LAB HUB',           'en' => 'AI LAB HUB'],
    'hero_subtitle'     => [
        'uk' => 'Знайдіть AI-інструмент для будь-якого завдання',
        'en' => 'Find an AI tool for any task',
    ],
    'hero_image_alt'    => ['uk' => 'Колба — AI LAB HUB', 'en' => 'Flask — AI LAB HUB'],
    'directions_title'  => ['uk' => 'Напрямки AI',        'en' => 'AI Directions'],

    // --- Підвал ---
    'footer_blog'     => ['uk' => 'Блог',                        'en' => 'Blog'],
    'footer_about'    => ['uk' => 'Про проєкт',                  'en' => 'About'],
    'footer_contacts' => ['uk' => 'Контакти',                    'en' => 'Contacts'],
    'footer_terms'    => ['uk' => 'Умови використання',          'en' => 'Terms of Use'],
    'footer_privacy'  => ['uk' => 'Політика конфіденційності',   'en' => 'Privacy Policy'],
    'footer_support'  => ['uk' => 'Підтримати проєкт',           'en' => 'Support the Project'],
    'footer_social'   => ['uk' => 'Соцмережі',                   'en' => 'Social media'],
];

/**
 * Поточна мова інтерфейсу: значення з сесії, якщо воно валідне,
 * інакше — мова за замовчуванням.
 */
function current_lang(): string
{
    $lang = $_SESSION['lang'] ?? LANG_DEFAULT;

    return in_array($lang, LANGS, true) ? $lang : LANG_DEFAULT;
}

/** Зберігає обрану мову в сесію (тихо ігнорує непідтримувані значення). */
function set_lang(string $lang): void
{
    if (in_array($lang, LANGS, true)) {
        $_SESSION['lang'] = $lang;
    }
}

/**
 * Переклад за ключем для поточної мови.
 * Порядок пошуку: поточна мова → мова за замовчуванням → сам ключ.
 */
function t(string $key): string
{
    $lang = current_lang();
    $entry = $GLOBALS['TRANSLATIONS'][$key] ?? null;

    if ($entry === null) {
        return $key;
    }

    return $entry[$lang] ?? $entry[LANG_DEFAULT] ?? $key;
}

/*
 * Перемикач мови.
 *
 * Посилання ведуть на поточну сторінку з ?lang=uk|en. Зберігаємо вибір
 * у сесію і, якщо вивід ще не почався, робимо чистий редірект назад на цю ж
 * сторінку без параметра lang (інші параметри зберігаються). Якщо заголовки
 * вже надіслані (translations.php підключено пізно, напр. із підвалу) —
 * просто зберігаємо вибір, він застосується з наступного завантаження.
 */
if (isset($_GET['lang'])) {
    set_lang((string) $_GET['lang']);

    if (!headers_sent()) {
        $params = $_GET;
        unset($params['lang']);

        $path = strtok($_SERVER['REQUEST_URI'] ?? '', '?');
        $query = http_build_query($params);

        header('Location: ' . $path . ($query !== '' ? '?' . $query : ''), true, 302);
        exit;
    }
}
