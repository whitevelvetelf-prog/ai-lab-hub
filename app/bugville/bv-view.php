<?php

declare(strict_types=1);

/**
 * Багвіль — оболонка сторінок гри (крок 3). Власна шапка й підвал замість сайтових: на сторінках гри немає реклами
 * (app/ad-popup.php підключає лише footer.php), статистики переглядів, банера згоди (гра не ставить необовʼязкових кукі),
 * сторонніх скриптів, шрифтів і зовнішніх посилань (MAIN_TASK, розділи 2, 15). «Назад» і «Поділитися» є, як на всьому
 * сайті, але «Поділитися» — лише системне вікно пристрою або «скопіювати посилання», без кнопок соцмереж.
 */

require_once __DIR__ . '/../csrf.php';

function bv_h(mixed $v): string
{
    return htmlspecialchars((string) $v, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
}

/** Версія статичного файлу для кешу (?v=mtime). */
function bv_asset(string $path): string
{
    $file = dirname(__DIR__, 2) . '/public/' . $path;

    return '/' . $path . '?v=' . (is_file($file) ? (int) filemtime($file) : 0);
}

/** Сторінка недоступна: 404 у стилі гри (або коли сторінки ще закриті для публіки). */
function bv_not_found(): never
{
    http_response_code(404);
    bv_page_start('Сторінку не знайдено', ['back' => 'bugville.php']);
    echo '<main class="bv-main" id="bv-main"><section class="bv-card"><h1 class="bv-title">Сторінку не знайдено</h1>'
        . '<p>Можливо, вона ще готується.</p><p><a class="bv-btn" href="/">На головну AI LAB HUB</a></p></section></main>';
    bv_page_end();
    exit;
}

/**
 * Початок сторінки. $o: back (резервна адреса «Назад»), user (рядок users або null), next (сторінка гри для входу),
 * description, body_class.
 */
function bv_page_start(string $title, array $o = []): void
{
    $user = $o['user'] ?? null;
    $next = (string) ($o['next'] ?? 'bugville.php');
    header('X-Content-Type-Options: nosniff');
    header('Referrer-Policy: same-origin');
    ?>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
    <title><?= bv_h($title) ?> — Багвіль</title>
    <meta name="description" content="<?= bv_h($o['description'] ?? 'Багвіль — навчальна гра AI LAB HUB: місто дрібних поломок і чарівних англійських слів.') ?>">
    <meta name="csrf-token" content="<?= bv_h(csrf_token()) ?>">
    <meta name="theme-color" content="#00032c">
    <link rel="icon" href="/logo.png">
    <link rel="stylesheet" href="<?= bv_h(bv_asset('assets/css/bugville.css')) ?>">
</head>
<body class="bv <?= bv_h($o['body_class'] ?? '') ?>">
<a class="bv-skip" href="#bv-main">До змісту</a>
<header class="bv-top">
    <a class="bv-top__btn bv-back" href="<?= bv_h($o['back'] ?? 'bugville.php') ?>" data-fallback="<?= bv_h($o['back'] ?? 'bugville.php') ?>" aria-label="Назад">
        <svg viewBox="0 0 24 24" width="22" height="22" aria-hidden="true"><path d="M15 5l-7 7 7 7" fill="none" stroke="currentColor" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round"/></svg>
    </a>
    <a class="bv-top__brand" href="bugville.php">
        <img src="/logo.png" alt="" width="28" height="28">
        <span>Багвіль</span>
    </a>
    <span class="bv-top__spacer"></span>
    <button type="button" class="bv-top__btn bv-share" aria-label="Поділитися">
        <svg viewBox="0 0 24 24" width="22" height="22" aria-hidden="true"><g fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><circle cx="18" cy="5" r="3"/><circle cx="6" cy="12" r="3"/><circle cx="18" cy="19" r="3"/><path d="M8.6 13.5l6.8 4M15.4 6.5l-6.8 4"/></g></svg>
    </button>
    <?php if ($user === null): ?>
        <a class="bv-top__link" href="<?= bv_h(auth_login_url($next)) ?>">Увійти</a>
    <?php else: ?>
        <a class="bv-top__link" href="account.php">Кабінет</a>
    <?php endif; ?>
</header>
<p class="bv-toast" id="bv-toast" role="status" aria-live="polite" hidden></p>
    <?php
}

/** Кінець сторінки: короткий підвал (лише внутрішні посилання) і скрипти гри. $parents — показати «Для батьків». */
function bv_page_end(bool $parents = false): void
{
    ?>
<footer class="bv-foot">
    <p>Навчальна гра AI LAB HUB. Без реклами й сторонніх скриптів.</p>
    <p>
        <?php if ($parents): ?><a href="bugville-parents.php">Для батьків і вчителів</a> · <?php endif; ?>
        <a href="privacy.php">Конфіденційність</a> · <a href="/">AI LAB HUB</a>
    </p>
</footer>
<script src="<?= bv_h(bv_asset('assets/js/bugville.js')) ?>" defer></script>
</body>
</html>
    <?php
}
