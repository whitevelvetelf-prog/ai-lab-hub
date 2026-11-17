<?php

declare(strict_types=1);

/**
 * AI LAB HUB — запасні значення констант Правил Marketplace (п. 1.5, 7.1–7.6, 10.1–10.3, 12.3, 13.3).
 *
 * Основне місце — config/marketplace.php (там самі константи з коментарями). Цей файл підключає mp_config()
 * ПІСЛЯ config/marketplace.php і config/marketplace.local.php, тож тут визначається лише те, чого там немає
 * (наприклад, серверна копія config/marketplace.php на проді, яку архіви розгортання не перезаписують).
 */

defined('MP_RULES_VERSION') || define('MP_RULES_VERSION', '2026-11-17');
defined('MP_ABUSE_EMAIL') || define('MP_ABUSE_EMAIL', 'abuse.ailabhub.directory@gmail.com');
defined('MP_MODERATION_DAYS') || define('MP_MODERATION_DAYS', 3);
defined('MP_APPEAL_WINDOW_DAYS') || define('MP_APPEAL_WINDOW_DAYS', 14);
defined('MP_APPEAL_ANSWER_DAYS') || define('MP_APPEAL_ANSWER_DAYS', 10);
defined('MP_IP_REVIEW_DAYS') || define('MP_IP_REVIEW_DAYS', 3);
defined('MP_COUNTER_NOTICE_DAYS') || define('MP_COUNTER_NOTICE_DAYS', 10);
defined('MP_LISTING_LIFETIME_DAYS') || define('MP_LISTING_LIFETIME_DAYS', 90);
defined('MP_RULES_CHANGE_NOTICE_DAYS') || define('MP_RULES_CHANGE_NOTICE_DAYS', 7);
defined('MP_CONTACT_VIEWS_PER_DAY') || define('MP_CONTACT_VIEWS_PER_DAY', 50);
