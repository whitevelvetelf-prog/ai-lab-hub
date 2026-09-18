<?php

/**
 * AI LAB HUB — кнопка «Назад» на картці продукту.
 *
 * Підключати на початку картки товару (product.php та будь-яка інша
 * сторінка з тим самим шаблоном), одразу перед лого/назвою:
 *   include __DIR__ . '/../app/back-button.php';
 *
 * Поведінка (public/assets/js/back-button.js):
 *  - referrer з того ж домену й є історія в цій вкладці → history.back()
 *    (повертає точно туди, звідки прийшли: каталог, категорія, пошук,
 *    добірка Елі чи інша картка продукту);
 *  - інакше (зовнішнє посилання, пряме відкриття) → перехід за href,
 *    тобто на $backButtonFallback. Це ж href — резервний варіант і без JS.
 *
 * $backButtonFallback (рядок, необов'язково) задає адресу за замовчуванням.
 */

$fallback = $backButtonFallback ?? 'catalog.php';

?>
<a href="<?= htmlspecialchars($fallback, ENT_QUOTES) ?>" class="back-nav" data-fallback="<?= htmlspecialchars($fallback, ENT_QUOTES) ?>">
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M19 12H5"/><path d="M12 19l-7-7 7-7"/></svg>
    <?= htmlspecialchars(t('back_button'), ENT_QUOTES) ?>
</a>
