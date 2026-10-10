<?php

declare(strict_types=1);

/**
 * AI LAB HUB — колишня сторінка категорії Готових рішень (?id=N): 301 на
 * marketplace.php?category=solutions&sub=N (Готові AI-рішення платформи тепер — оголошення Marketplace).
 */

require __DIR__ . '/../app/mp-legacy-redirect.php';

$sub = (int) ($_GET['id'] ?? 0);
mp_legacy_redirect('marketplace.php', $sub > 0 ? ['category' => 'solutions', 'sub' => $sub] : ['category' => 'solutions'], ['id']);
