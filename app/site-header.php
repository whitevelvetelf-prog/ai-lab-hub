<?php

/**
 * AI LAB HUB — спільна шапка сайту (лого, «Головна», «Кабінет/Увійти»,
 * «Викликати Асистента», гамбургер).
 *
 * Єдине джерело розмітки: підключати першим елементом <body>
 *   <?php include __DIR__ . '/../app/site-header.php'; ?>
 * Потрібні app/auth.php (auth_check), app/translations.php (t()) і стилі
 * public/assets/css/site-nav.css у <head> сторінки. Закріплення шапки,
 * мовний перемикач, гамбургер і пошук додає app/footer.php.
 */

?>
<header class="site-header">
    <a class="site-header__brand" href="index.php">
        <img class="site-header__logo" src="/logo.png" alt="AI LAB HUB">
    </a>
    <nav class="site-nav" id="siteNav">
        <a class="site-nav__link" href="index.php"><?= htmlspecialchars(t('nav_home'), ENT_QUOTES) ?></a>
        <?php if (auth_check()): ?>
        <a class="site-nav__link" href="account.php"><?= htmlspecialchars(t('nav_account'), ENT_QUOTES) ?></a>
        <?php else: ?>
        <a class="site-nav__link" href="login.php"><?= htmlspecialchars(t('nav_login'), ENT_QUOTES) ?></a>
        <?php endif; ?>
    </nav>
    <a class="site-nav__link site-nav__link--cta site-header__cta" href="eli.php">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9.937 15.5A2 2 0 0 0 8.5 14.063l-6.135-1.582a.5.5 0 0 1 0-.962L8.5 9.936A2 2 0 0 0 9.937 8.5l1.582-6.135a.5.5 0 0 1 .962 0L14.063 8.5A2 2 0 0 0 15.5 9.937l6.135 1.581a.5.5 0 0 1 0 .964L15.5 14.063a2 2 0 0 0-1.437 1.437l-1.582 6.135a.5.5 0 0 1-.962 0z"/><path d="M20 3v4"/><path d="M22 5h-4"/><path d="M4 17v2"/><path d="M6 18H2"/></svg>
        <?= htmlspecialchars(t('nav_assistant'), ENT_QUOTES) ?>
    </a>
    <button class="site-nav__toggle" type="button" aria-label="<?= htmlspecialchars(t('nav_menu'), ENT_QUOTES) ?>" aria-expanded="false" aria-controls="siteNav">
        <span></span>
        <span></span>
        <span></span>
    </button>
</header>
