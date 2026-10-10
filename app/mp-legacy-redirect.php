<?php

declare(strict_types=1);

/**
 * AI LAB HUB — постійні редіректи зі старих адрес Marketplace на нові (2026-10-10).
 *
 * Старі файли (offer.php, mp-post.php, mp-my.php, mp-favorites.php, mp-rules.php) лишаються заглушками,
 * що викликають mp_legacy_redirect(): посилання ззовні й у пошуковиках не ламаються, а редірект працює
 * незалежно від mod_rewrite. GET/HEAD → 301; інші методи → 308 (тіло POST не губиться).
 */

/**
 * Редірект на $target (ім'я файлу в public/) із query string поточного запиту.
 *
 * @param array<string,string|int> $params параметри, що додаються/замінюють наявні
 * @param list<string>             $drop   параметри зі старої адреси, які не переносяться
 */
function mp_legacy_redirect(string $target, array $params = [], array $drop = []): never
{
    $query = $_GET;
    foreach ($drop as $key) {
        unset($query[$key]);
    }
    $query = array_merge($query, $params);
    $qs = http_build_query($query);
    $method = $_SERVER['REQUEST_METHOD'] ?? 'GET';

    header('Location: /' . $target . ($qs !== '' ? '?' . $qs : ''), true, in_array($method, ['GET', 'HEAD'], true) ? 301 : 308);
    exit;
}
