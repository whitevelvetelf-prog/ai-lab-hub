<?php

declare(strict_types=1);

/**
 * AI LAB HUB — колишня вітрина «Готові рішення»: 301 на спільний список marketplace.php?category=solutions
 * (Готові AI-рішення платформи тепер — оголошення Marketplace). Пошук ?q= зберігається.
 */

require __DIR__ . '/../app/mp-legacy-redirect.php';

mp_legacy_redirect('marketplace.php', ['category' => 'solutions']);
