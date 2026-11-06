<?php

declare(strict_types=1);

/**
 * AI LAB HUB — колишній розділ «Вакансії / Курси / Послуги» (listings.php?type=…): з 2026-11-06 це блоки дерева
 * категорій Marketplace. Постійний редірект (301) на сторінку блока marketplace-category.php?id=N:
 *   type=job|course|service → блок; cat|focus=ID (тематична категорія) → &focus=ID; q, city → як є;
 *   format=remote|onsite (стара remote=1) → format=online|offline. Без type чи невідомий type → marketplace.php.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/mp-legacy-redirect.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$g = static fn(string $k): string => is_string($_GET[$k] ?? null) ? trim((string) $_GET[$k]) : '';
$block = mpt_block(mpt_tree($pdo, 'uk'), $g('type'));
if ($block === null) {
    mp_legacy_redirect('marketplace.php', [], array_keys($_GET));
}
$focus = ctype_digit($g('focus')) ? $g('focus') : (ctype_digit($g('cat')) ? $g('cat') : '');
$format = ['remote' => 'online', 'onsite' => 'offline'][$g('format')] ?? ($g('remote') === '1' ? 'online' : '');
$params = array_filter(['id' => $block['id'], 'focus' => $focus, 'q' => mb_substr($g('q'), 0, 100), 'city' => mb_substr($g('city'), 0, 80), 'format' => $format],
    static fn(string|int $v): bool => $v !== '');
mp_legacy_redirect('marketplace-category.php', $params, array_keys($_GET));
