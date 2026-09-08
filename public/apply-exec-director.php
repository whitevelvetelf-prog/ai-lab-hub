<?php

declare(strict_types=1);

/**
 * AI LAB HUB — приватна заявка на посаду Виконавчого директора.
 *
 * Ця сама форма надсилається двом різним кандидатам окремо (посада —
 * не одномісна, максимум 2). Доступ лише за прямим посиланням.
 * Уся логіка — у спільному шаблоні app/director-application.php.
 */

$directorPositionKey = 'exec_director';
require __DIR__ . '/../app/director-application.php';
