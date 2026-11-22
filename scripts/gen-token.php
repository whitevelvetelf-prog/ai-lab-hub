<?php

declare(strict_types=1);

/**
 * AI LAB HUB — випадковий токен для cron і секретів конфігу (cron_token, rate_limit_salt, saved_search_secret,
 * messaging_secret, promo secret/cron_key).
 *
 *   php scripts/gen-token.php        — 1 токен, 32 байти (64 шістнадцяткові символи)
 *   php scripts/gen-token.php 4      — 4 різні токени (по одному на рядок)
 *
 * Токен друкується лише в консоль і ніде не зберігається. Для кожного поля — свій токен.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$n = max(1, min(20, (int) ($argv[1] ?? 1)));
for ($i = 0; $i < $n; $i++) {
    fwrite(STDOUT, bin2hex(random_bytes(32)) . "\n");
}
