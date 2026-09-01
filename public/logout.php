<?php

declare(strict_types=1);

/**
 * AI LAB HUB — вихід із акаунта.
 */

require_once __DIR__ . '/../app/auth.php';

auth_logout();

header('Location: index.php');
exit;
