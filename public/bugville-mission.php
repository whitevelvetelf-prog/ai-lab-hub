<?php

declare(strict_types=1);

/**
 * AI LAB HUB — «Багвіль»: сцена місії (крок 3). Сервер віддає лише оболонку; сцену, підказку, перевірку й розбір
 * бере assets/js/bugville.js через bv-api.php (start / hint / check / confirm_age). У HTML немає жодної відповіді.
 * ?m=<id місії зі світу>. Місія без контенту — картка «скоро»; невідома — 404.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/bugville/bv-player.php';
require_once __DIR__ . '/../app/bugville/bv-missions.php';
require_once __DIR__ . '/../app/bugville/bv-view.php';
require_once __DIR__ . '/../app/bugville/bv-parents.php';
require_once __DIR__ . '/../app/bugville/bv-words.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
$account = auth_check() ? auth_current_user($pdo) : null;
if (!bv_pages_visible($account)) {
    bv_not_found();
}
bv_load_missions($pdo);

$id = filter_var($_GET['m'] ?? null, FILTER_VALIDATE_INT, ['options' => ['min_range' => 1]]);
$all = bv_world_missions();
if ($id === false || !isset($all[$id])) {
    bv_not_found();
}
$ms = $all[$id];
$play = bv_world_playable($id);
// Етап 0: місії відкриваються по черзі — закриту за прямим посиланням не показуємо (сервер перевіряє й у bv-api start).
$progressUid = null;
try {
    $progressUid = $account !== null && bv_age_confirmed($pdo, (int) $account['id']) ? (int) $account['id'] : null;
} catch (Throwable) {
    $progressUid = null;
}
$locked = $play && !bv_world_mission_open($pdo, $progressUid, $id);
$self = 'bugville-mission.php?m=' . $id;
$next = $play ? bv_world_next_playable($id) : null;
$word = bv_word_card($ms['word']);
$wdb = bv_words_all($pdo)[$ms['word']] ?? null;   // тексти з Книги слів (CRM / сид), приклад речення
if ($word !== null && $wdb !== null) {
    $word = ['word' => $word['word'], 'say' => $wdb['say'], 'meaning' => $wdb['meaning'], 'example' => $wdb['example_en'], 'example_tr' => $wdb['example_tr']];
}

bv_page_start($ms['n'] . ' ' . $ms['title'], ['user' => $account, 'back' => 'bugville.php', 'next' => $self,
    'body_class' => 'bv-mission-page']);
?>
<main class="bv-main" id="bv-main">
    <nav class="bv-crumbs" aria-label="Де ви"><a href="bugville.php">Карта</a> › Рівень <?= (int) $ms['level'] ?>. <?= bv_h($ms['level_title']) ?></nav>
    <h1 class="bv-title"><span class="bv-mission__n"><?= bv_h($ms['n']) ?></span> <?= bv_h($ms['title']) ?></h1>

    <?php if ($locked): ?>
        <section class="bv-card bv-locked" role="status">
            <p><span aria-hidden="true">🔒</span> Ця місія ще закрита. Вона відкриється, коли ви пройдете попередні.</p>
            <p><a class="bv-btn" href="bugville.php">До міста</a></p>
        </section>
    <?php elseif (!$play): ?>
        <section class="bv-card">
            <p>Ця місія ще готується. Загляньте трохи згодом.</p>
            <p><a class="bv-btn" href="bugville.php">До карти</a></p>
        </section>
    <?php else: ?>
        <div id="bv-game" class="bv-game"
             data-mission="<?= (int) $id ?>"
             data-next="<?= $next !== null ? 'bugville-mission.php?m=' . (int) $next : '' ?>"
             data-login="<?= bv_h(auth_login_url($self)) ?>"
             data-register="<?= bv_h(auth_login_url($self, 'register.php')) ?>"
             data-min-age="<?= bv_min_age() ?>"
             data-word="<?= bv_h(json_encode($word, JSON_UNESCAPED_UNICODE)) ?>">
            <section class="bv-card" id="bv-scene" aria-live="polite" aria-busy="true">
                <p class="bv-loading">Завантажуємо місію…</p>
            </section>
            <noscript><section class="bv-card"><p>Для гри потрібен увімкнений JavaScript.</p></section></noscript>
        </div>
    <?php endif; ?>
</main>
<?php
bv_page_end(bv_parents_text() !== null);
