<?php

declare(strict_types=1);

/**
 * AI LAB HUB — «Багвіль»: «Поломка дня» (app/bugville/bv-daily.php). Оболонка сцени, як у місії: сцену дня, дії й здачу
 * бере assets/js/bugville.js через bv-api.php (start {daily: true} / scene_act / scene_finish). Місію обирає сервер.
 * Без таймерів, відліків часу, рейтингів і нагадувань.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/bugville/bv-player.php';
require_once __DIR__ . '/../app/bugville/bv-missions.php';
require_once __DIR__ . '/../app/bugville/bv-daily.php';
require_once __DIR__ . '/../app/bugville/bv-view.php';
require_once __DIR__ . '/../app/bugville/bv-parents.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
$account = auth_check() ? auth_current_user($pdo) : null;
if (!bv_pages_visible($account)) {
    bv_not_found();
}
bv_load_missions($pdo);
$self = 'bugville-daily.php';
$card = bv_daily_card($pdo, null);

bv_page_start('Поломка дня', ['user' => $account, 'back' => 'bugville.php', 'next' => $self, 'body_class' => 'bv-mission-page',
    'description' => 'Поломка дня в Багвілі: одна коротка місія на день, однакова для всіх.']);
?>
<main class="bv-main" id="bv-main">
    <nav class="bv-crumbs" aria-label="Де ви"><a href="bugville.php">Карта</a> › Поломка дня</nav>
    <h1 class="bv-title">Поломка дня</h1>
    <?php if ($card === null): ?>
        <section class="bv-card">
            <p>Поломка дня ще готується. Загляньте трохи згодом.</p>
            <p><a class="bv-btn" href="bugville.php">До карти</a></p>
        </section>
    <?php else: ?>
        <p class="bv-lead"><?= bv_h($card['teaser']) ?> Коротка місія: знайдіть щонайменше
            <?= (int) max(1, min((int) (bv_cfg('bugville_daily_min_found') ?? 2), bv_daily_bugs())) ?> з <?= bv_daily_bugs() ?> поломок.</p>
        <div id="bv-game" class="bv-game"
             data-mission="<?= BV_DAILY_ID ?>"
             data-daily="1"
             data-next=""
             data-login="<?= bv_h(auth_login_url($self)) ?>"
             data-register="<?= bv_h(auth_login_url($self, 'register.php')) ?>"
             data-min-age="<?= bv_min_age() ?>"
             data-word="null">
            <section class="bv-card" id="bv-scene" aria-live="polite" aria-busy="true">
                <p class="bv-loading">Завантажуємо поломку дня…</p>
            </section>
            <noscript><section class="bv-card"><p>Для гри потрібен увімкнений JavaScript.</p></section></noscript>
        </div>
    <?php endif; ?>
</main>
<?php
bv_page_end(bv_parents_text() !== null);
