<?php

declare(strict_types=1);

/**
 * AI LAB HUB — активні мови інтерфейсу.
 *
 * Єдине місце, що визначає, які мови показує перемикач UA/EN і на які
 * мови кешується переклад. Логіка кешування (app/translation-cache.php,
 * app/translations.php) не хардкодить жодного коду мови — все звідси.
 *
 * source — мова оригіналу контенту (products, pricing_plans,
 *          $GLOBALS['TRANSLATIONS'] у app/translations.php). Для неї
 *          переклад ніколи не шукається й не кешується — виводиться
 *          напряму джерело.
 * active — код мови => підпис для перемикача, у порядку показу.
 *          Джерело (uk) має бути серед активних.
 *
 * Щоб додати нову мову: дописати рядок в active. Жодних змін структури
 * БД чи функцій кешування не потрібно — product_translations,
 * pricing_plan_translations і ui_translations мовонезалежні.
 */
return [
    'source' => 'uk',
    'active' => [
        'uk' => 'UA',
        'en' => 'EN',
    ],
];
