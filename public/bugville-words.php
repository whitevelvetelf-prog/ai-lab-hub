<?php

declare(strict_types=1);

/**
 * AI LAB HUB — «Багвіль»: Книга чарівних слів (MAIN_TASK, розділи 3 і 6). 15 слів Етапу 1 по рівнях: слово, вимова
 * українськими літерами, значення, приклад речення з перекладом. Слово відкривається після своєї місії.
 * Акаунт 16+: вправа «Що означає…?» (bv-api.php word_quiz / word_check; правильна відповідь лише на сервері) і «вивчено».
 * Гість: відкриті в цьому сеансі слова — лише перегляд, і пропозиція зберегти прогрес. Без озвучення (рішення 19.4 відкрите).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/bugville/bv-player.php';
require_once __DIR__ . '/../app/bugville/bv-missions.php';
require_once __DIR__ . '/../app/bugville/bv-words.php';
require_once __DIR__ . '/../app/bugville/bv-view.php';
require_once __DIR__ . '/../app/bugville/bv-parents.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
$account = auth_check() ? auth_current_user($pdo) : null;
if (!bv_pages_visible($account)) {
    bv_not_found();
}
bv_load_missions($pdo);

$saveId = null;
try {
    $ctx = bv_request_ctx($pdo, $account !== null ? (int) $account['id'] : null);
    $saveId = $ctx['user_id'];
} catch (Throwable) {
    $saveId = null;
}
try {
    $book = $saveId !== null ? bv_words_book($pdo, (int) $saveId) : bv_words_book_guest($pdo);
} catch (Throwable) {
    $book = bv_words_book_guest($pdo);
}
$learned = count(array_filter($book, static fn($w) => $w['state'] === 'learned'));
$opened = count(array_filter($book, static fn($w) => $w['state'] !== 'locked'));
$levels = [];
$missions = bv_world_missions();
foreach ($book as $w) {
    $ms = $missions[$w['mission_id']] ?? null;
    $levels[(int) ($ms['level'] ?? 0)]['title'] = (string) ($ms['level_title'] ?? '');
    $levels[(int) ($ms['level'] ?? 0)]['words'][] = $w;
}
ksort($levels);

bv_page_start('Книга чарівних слів', ['user' => $account, 'back' => 'bugville.php', 'next' => 'bugville-words.php',
    'description' => 'Книга чарівних слів Багвіля: англійські слова з вимовою, значенням і прикладом.']);
?>
<main class="bv-main" id="bv-main">
    <nav class="bv-crumbs" aria-label="Де ви"><a href="bugville.php">Карта</a> › Книга чарівних слів</nav>
    <h1 class="bv-title">Книга чарівних слів</h1>
    <section class="bv-card">
        <p class="bv-lead" style="margin-top: 0">Кожна знайдена поломка дарує англійське слово. Слово відкривається, коли ви проходите його місію.</p>
        <?php if ($saveId !== null): ?>
            <p class="bv-words-count" id="bv-words-count" aria-live="polite">Вивчено: <strong><?= $learned ?></strong> з <?= count($book) ?> · відкрито: <?= $opened ?></p>
            <p class="bv-muted">Щоб слово стало «вивченим», правильно виконайте його вправу. Вправу можна повторювати скільки завгодно.</p>
        <?php else: ?>
            <p class="bv-words-count">Відкрито в цьому сеансі: <strong><?= $opened ?></strong> з <?= count($book) ?></p>
            <p class="bv-note"><?= $account === null
                ? 'Вправи й позначка «вивчено» — для акаунтів від ' . bv_min_age() . ' років. <a href="' . bv_h(auth_login_url('bugville-words.php')) . '">Увійти</a> або <a href="' . bv_h(auth_login_url('bugville-words.php', 'register.php')) . '">зареєструватися</a>.'
                : 'Щоб робити вправи й зберігати вивчені слова, підтвердьте вік у будь-якій місії (від ' . bv_min_age() . ' років).' ?></p>
        <?php endif; ?>
    </section>

    <div id="bv-words" data-account="<?= $saveId !== null ? '1' : '0' ?>">
    <?php foreach ($levels as $lvId => $lv): ?>
        <section class="bv-card" aria-labelledby="bv-wl-<?= (int) $lvId ?>">
            <h2 class="bv-chapter__title" id="bv-wl-<?= (int) $lvId ?>" style="margin-top: 0">Рівень <?= (int) $lvId ?>. <?= bv_h($lv['title']) ?></h2>
            <ul class="bv-words">
                <?php foreach ($lv['words'] as $w): $st = $w['state']; ?>
                    <li class="bv-wcard is-<?= bv_h($st) ?>" data-word="<?= bv_h($w['key']) ?>">
                        <?php if ($st === 'locked'): ?>
                            <p class="bv-wcard__lock"><span aria-hidden="true">🔒</span> Слово відкриється після місії
                                <a href="bugville-mission.php?m=<?= (int) $w['mission_id'] ?>"><?= bv_h($w['mission_n'] . ' «' . $w['mission_title'] . '»') ?></a>.</p>
                        <?php else: ?>
                            <p class="bv-wcard__state"><?= $st === 'learned' ? '<span aria-hidden="true">✓</span> Вивчено' : '<span aria-hidden="true">✦</span> Відкрито' ?></p>
                            <p class="bv-wcard__word" lang="en"><?= bv_h($w['key']) ?></p>
                            <p class="bv-wcard__say">[<?= bv_h($w['say']) ?>] — <?= bv_h($w['meaning']) ?></p>
                            <p class="bv-wcard__ex"><span lang="en">«<?= bv_h($w['example_en']) ?>»</span><br><span class="bv-muted"><?= bv_h($w['example_tr']) ?></span></p>
                            <p class="bv-muted bv-wcard__from">З місії <?= bv_h($w['mission_n'] . ' «' . $w['mission_title'] . '»') ?></p>
                            <?php if ($saveId !== null): ?>
                                <p class="bv-actions"><button type="button" class="bv-btn bv-btn--small bv-wquiz-btn"><?= $st === 'learned' ? 'Повторити вправу' : 'Вправа' ?></button></p>
                                <div class="bv-wquiz" hidden></div>
                            <?php endif; ?>
                        <?php endif; ?>
                    </li>
                <?php endforeach; ?>
            </ul>
        </section>
    <?php endforeach; ?>
    </div>
    <p><a class="bv-btn bv-btn--ghost" href="bugville.php">До карти</a></p>
</main>
<?php
bv_page_end(bv_parents_text() !== null);
