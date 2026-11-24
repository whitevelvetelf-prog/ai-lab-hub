<?php

declare(strict_types=1);

/**
 * AI LAB HUB — «Багвіль»: іспит рівня (крок 4). ?e=<номер рівня>. Сервер віддає лише оболонку; завдання, відповіді
 * й підсумок бере assets/js/bugville.js через bv-api.php (exam_state / exam_start / exam_answer / exam_finish).
 * Гостям і акаунтам без підтвердженого віку — пропозиція реєстрації (exam_start → 403).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/bugville/bv-missions.php';
require_once __DIR__ . '/../app/bugville/bv-exam.php';
require_once __DIR__ . '/../app/bugville/bv-view.php';
require_once __DIR__ . '/../app/bugville/bv-parents.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
$account = auth_check() ? auth_current_user($pdo) : null;
if (!bv_pages_visible($account)) {
    bv_not_found();
}
bv_load_missions();

$level = filter_var($_GET['e'] ?? null, FILTER_VALIDATE_INT, ['options' => ['min_range' => 1]]);
$lv = $level === false ? null : bv_exam_level(bv_exam_id((int) $level));
if ($lv === null) {
    bv_not_found();
}
$examId = bv_exam_id((int) $level);
$self = 'bugville-exam.php?e=' . (int) $level;
$enabled = bv_exam_pool($pdo, $examId)['ok'];

bv_page_start('Іспит: ' . $lv['title'], ['user' => $account, 'back' => 'bugville.php', 'next' => $self]);
?>
<main class="bv-main" id="bv-main">
    <nav class="bv-crumbs" aria-label="Де ви"><a href="bugville.php">Карта</a> › Рівень <?= (int) $level ?>. <?= bv_h($lv['title']) ?></nav>
    <h1 class="bv-title">Іспит рівня «<?= bv_h($lv['title']) ?>»</h1>
    <?php if (!$enabled): ?>
        <section class="bv-card">
            <p>Іспит цього рівня ще готується. Поки що можна потренуватися в місіях.</p>
            <p><a class="bv-btn" href="bugville.php">До карти</a></p>
        </section>
    <?php else: ?>
        <p class="bv-lead"><?= bv_exam_tasks_count() ?> завдань у нових варіантах. Щоб скласти, потрібно <?= (int) bv_cfg('bugville_exam_pass_percent') ?>% правильних відповідей.
            Підказок немає, відповіді й розбір — наприкінці.</p>
        <div id="bv-exam" class="bv-game"
             data-exam="<?= (int) $examId ?>"
             data-login="<?= bv_h(auth_login_url($self)) ?>"
             data-register="<?= bv_h(auth_login_url($self, 'register.php')) ?>"
             data-min-age="<?= bv_min_age() ?>">
            <section class="bv-card" id="bv-scene" aria-live="polite" aria-busy="true">
                <p class="bv-loading">Завантажуємо іспит…</p>
            </section>
            <noscript><section class="bv-card"><p>Для іспиту потрібен увімкнений JavaScript.</p></section></noscript>
        </div>
    <?php endif; ?>
</main>
<?php
bv_page_end(bv_parents_text() !== null);
