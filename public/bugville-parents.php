<?php

declare(strict_types=1);

/**
 * AI LAB HUB — «Багвіль»: сторінка «Для батьків і вчителів» (MAIN_TASK, розділ 2). Текст — docs/bugville/PARENTS_uk.md;
 * поки в ньому є [ПІДТВЕРДИТИ] або гра закрита для публіки — 404.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/bugville/bv-world.php';
require_once __DIR__ . '/../app/bugville/bv-view.php';
require_once __DIR__ . '/../app/bugville/bv-parents.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
$account = auth_check() ? auth_current_user($pdo) : null;
$text = bv_parents_text();
if ($text === null || !bv_pages_visible($account)) {
    bv_not_found();
}

bv_page_start('Для батьків і вчителів', ['user' => $account, 'back' => 'bugville.php', 'next' => 'bugville.php']);
?>
<main class="bv-main" id="bv-main">
    <article class="bv-card bv-prose"><?= bv_parents_html($text) ?></article>
</main>
<?php
bv_page_end(false);
