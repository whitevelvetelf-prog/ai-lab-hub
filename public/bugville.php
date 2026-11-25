<?php

declare(strict_types=1);

/**
 * AI LAB HUB — «Багвіль»: карта гри (крок 3). Глави → рівні → місії, зірки гравця, «скоро» для місій без контенту.
 * Гість бачить результати сеансу; акаунт 16+ — збережені. Без реклами, статистики переглядів і сторонніх скриптів.
 * Видима для всіх лише з 'bugville_public' => true; інакше — лише admin (решті 404).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/bugville/bv-player.php';
require_once __DIR__ . '/../app/bugville/bv-missions.php';
require_once __DIR__ . '/../app/bugville/bv-exam.php';
require_once __DIR__ . '/../app/bugville/bv-progress.php';
require_once __DIR__ . '/../app/bugville/bv-words.php';
require_once __DIR__ . '/../app/bugville/bv-workshop.php';
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
$stars = [];
$totals = ['xp' => 0, 'stars' => 0, 'coins' => 0];
try {
    $saveId = $account !== null && bv_age_confirmed($pdo, (int) $account['id']) ? (int) $account['id'] : null;
    if ($saveId !== null) {
        $cr = bv_credit_guest_session($pdo, $saveId);   // щойно ввійшли після гри гостем — зарахувати сеанс до показу карти
        $credXp = (int) ($cr['xp'] ?? 0);
    }
    $stars = bv_stars_by_mission($pdo, $saveId);
    $totals = $saveId !== null ? bv_totals($pdo, $saveId) : bv_guest_totals();
} catch (Throwable $e) {
    error_log('[bugville] map progress: ' . get_class($e));
}
// Звання, серія, значки (міграція № 36) — лише акаунтам 16+; без таблиць — блок не показується.
$prog = null;
if ($saveId !== null) {
    try {
        if (($cr['credited'] ?? 0) > 0) {
            bv_progress_update($pdo, $saveId, $totals['xp'] - $credXp, true);   // значки й серія за зарахований сеанс
        }
        $prog = bv_progress_summary($pdo, $saveId);
    } catch (Throwable $e) {
        error_log('[bugville] map rank/badges: ' . get_class($e));
    }
}

$world = bv_world();
$examStatus = [];
foreach ($world as $ch) {
    foreach ($ch['levels'] as $lv) {
        try {
            $examStatus[$lv['id']] = bv_exam_status($pdo, $saveId, bv_exam_id((int) $lv['id']));
        } catch (Throwable $e) {
            error_log('[bugville] exam status: ' . get_class($e));   // таблиць іспитів ще немає (міграція № 34)
        }
    }
}
$ch1Missions = array_filter(bv_world_missions(), static fn($m) => $m['chapter'] === 1);
$ch1Done = $ch1Missions !== [] && count(array_filter($ch1Missions, static fn($m) => ($stars[$m['id']] ?? 0) > 0)) === count($ch1Missions);

/** Власні SVG-сцени рівнів (без тексту всередині). */
function bv_level_icon(string $key): string
{
    return match ($key) {
        'vending' => '<svg viewBox="0 0 64 64" aria-hidden="true"><rect x="14" y="6" width="36" height="52" rx="5" fill="#2116ad"/><rect x="19" y="12" width="20" height="26" rx="2" fill="#fff"/>'
            . '<circle cx="24" cy="18" r="2.5" fill="#f2b632"/><circle cx="33" cy="18" r="2.5" fill="#e4572e"/><circle cx="24" cy="27" r="2.5" fill="#4caf7a"/><circle cx="33" cy="27" r="2.5" fill="#f2b632"/>'
            . '<rect x="42" y="14" width="4" height="8" rx="1" fill="#c9cdf5"/><rect x="42" y="26" width="4" height="4" rx="1" fill="#c9cdf5"/><rect x="19" y="44" width="26" height="7" rx="2" fill="#00032c"/></svg>',
        'post' => '<svg viewBox="0 0 64 64" aria-hidden="true"><rect x="8" y="16" width="48" height="34" rx="4" fill="#2116ad"/><path d="M8 20l24 17 24-17" fill="none" stroke="#fff" stroke-width="3" stroke-linejoin="round"/>'
            . '<rect x="42" y="22" width="9" height="11" rx="1" fill="#f2b632"/></svg>',
        default => '<svg viewBox="0 0 64 64" aria-hidden="true"><rect x="8" y="12" width="9" height="42" rx="2" fill="#2116ad"/><rect x="19" y="8" width="9" height="46" rx="2" fill="#4c43d8"/>'
            . '<rect x="30" y="14" width="9" height="40" rx="2" fill="#f2b632"/><rect x="41" y="10" width="9" height="44" rx="2" transform="rotate(8 45 32)" fill="#e4572e"/><rect x="6" y="54" width="52" height="4" rx="1" fill="#00032c"/></svg>',
    };
}

function bv_stars_html(int $n): string
{
    $n = max(0, min(3, $n));

    return '<span class="bv-stars" aria-label="Зірок: ' . $n . ' з 3">' . str_repeat('<span class="bv-star is-on" aria-hidden="true">★</span>', $n)
        . str_repeat('<span class="bv-star" aria-hidden="true">☆</span>', 3 - $n) . '</span>';
}

bv_page_start('Карта міста', ['user' => $account, 'back' => '/', 'next' => 'bugville.php',
    'description' => 'Багвіль — навчальна гра: знаходьте поломки в автоматі, на пошті й у бібліотеці та вивчайте чарівні англійські слова.']);
?>
<main class="bv-main" id="bv-main">
    <section class="bv-hero">
        <h1 class="bv-title">Багвіль</h1>
        <p class="bv-lead">У цьому місті дрібні поломки ховаються в усьому. Ви — Помічник майстра: знайдіть поломку, а місто розповість, як вона називається.</p>
        <dl class="bv-totals">
            <div><dt>XP</dt><dd><?= (int) $totals['xp'] ?></dd></div>
            <div><dt>Зірки</dt><dd><?= (int) $totals['stars'] ?></dd></div>
            <?php if ($saveId !== null): ?><div><dt>Монети</dt><dd><?= (int) $totals['coins'] ?></dd></div><?php endif; ?>
        </dl>
        <?php if ($prog !== null): $pct = $prog['next'] === null ? 100
            : (int) round(100 * ($prog['xp'] - $prog['rank']['min_xp']) / max(1, $prog['next']['min_xp'] - $prog['rank']['min_xp'])); ?>
            <div class="bv-rank">
                <p class="bv-rank__title">Звання: <strong><?= bv_h($prog['rank']['title']) ?></strong></p>
                <div class="bv-bar" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="<?= $pct ?>"
                     aria-label="<?= $prog['next'] === null ? 'Найвище звання' : 'До звання «' . bv_h($prog['next']['title']) . '»' ?>"><span style="width: <?= $pct ?>%"></span></div>
                <p class="bv-muted"><?= $prog['next'] === null ? 'Це найвище звання Глави 1.'
                    : 'Ще ' . (int) $prog['to_next'] . ' XP до звання «' . bv_h($prog['next']['title']) . '».' ?>
                    Серія: <?= (int) $prog['streak']['current'] ?> дн. (рекорд <?= (int) $prog['streak']['best'] ?>).</p>
            </div>
        <?php endif; ?>
        <?php if ($saveId === null): ?>
            <p class="bv-note"><?= $account === null
                ? 'Грати можна без реєстрації. Результати цього сеансу зберігаються, лише якщо ввійти в акаунт (від ' . bv_min_age() . ' років).'
                : 'Щоб зберігати прогрес, підтвердьте вік у будь-якій місії (від ' . bv_min_age() . ' років). Поки що результати лише цього сеансу.' ?>
                Звання, значки й щоденна серія — теж для акаунтів.</p>
        <?php endif; ?>
    </section>

    <?php
    try {
        $wbook = $saveId !== null ? bv_words_book($pdo, (int) $saveId) : bv_words_book_guest($pdo);
    } catch (Throwable) {
        $wbook = [];
    }
    if ($wbook !== []): $wOpen = count(array_filter($wbook, static fn($w) => $w['state'] !== 'locked'));
        $wLearned = count(array_filter($wbook, static fn($w) => $w['state'] === 'learned')); ?>
        <section class="bv-card">
            <a class="bv-map-words" href="bugville-words.php">
                <span class="bv-map-words__icon" aria-hidden="true">📖</span>
                <span><strong>Книга чарівних слів</strong><br><span class="bv-muted"><?= $saveId !== null
                    ? 'Вивчено ' . $wLearned . ' з ' . count($wbook) . ' · відкрито ' . $wOpen
                    : 'Відкрито в цьому сеансі: ' . $wOpen . ' з ' . count($wbook) ?></span></span>
            </a>
        </section>
    <?php endif; ?>

    <?php
    $wsLook = null;
    $wsCoins = 0;
    if ($saveId !== null) {
        try {
            $wsLook = bv_ws_look($pdo, (int) $saveId);
            $wsCoins = bv_ws_balance($pdo, (int) $saveId)['coins'];
        } catch (Throwable) {
            $wsLook = null;
        }
    } ?>
    <section class="bv-card">
        <a class="bv-map-look" href="bugville-workshop.php">
            <?php if ($wsLook !== null): ?>
                <span class="bvw-look bvw-bg--<?= bv_h($wsLook['background'] ?? 'none') ?>"><?= bv_ws_look_svg($wsLook, 64) ?></span>
                <span><strong>Майстерня</strong><br><span class="bv-muted">Монети: <?= (int) $wsCoins ?> · рамки, наклейки й фони карти</span></span>
            <?php else: ?>
                <span class="bv-map-words__icon" aria-hidden="true">🛠</span>
                <span><strong>Майстерня</strong><br><span class="bv-muted">Прикраси для героя за монети гри — для акаунтів від <?= bv_min_age() ?> років</span></span>
            <?php endif; ?>
        </a>
    </section>

    <?php if ($prog !== null && $prog['badges'] !== []): $got = count(array_filter($prog['badges'], static fn($b) => $b['earned'])); ?>
        <section class="bv-card" aria-labelledby="bv-badges-h">
            <h2 class="bv-chapter__title" id="bv-badges-h" style="margin-top: 0">Значки: <?= $got ?> з <?= count($prog['badges']) ?></h2>
            <ul class="bv-badges">
                <?php foreach ($prog['badges'] as $b): ?>
                    <li class="bv-badge-item<?= $b['earned'] ? ' is-earned' : '' ?>">
                        <span class="bv-badge-item__icon" aria-hidden="true"><?= $b['earned'] ? '★' : '☆' ?></span>
                        <span><strong><?= bv_h($b['title']) ?></strong><br><span class="bv-muted"><?= bv_h($b['description']) ?></span>
                            <span class="bv-sr"><?= $b['earned'] ? '(отримано)' : '(ще ні)' ?></span></span>
                    </li>
                <?php endforeach; ?>
            </ul>
        </section>
    <?php endif; ?>

    <?php if ($ch1Done): ?>
        <section class="bv-card bv-reveal" aria-labelledby="bv-reveal-h">
            <h2 id="bv-reveal-h">Тепер ви знаєте, що це називається тестування</h2>
            <p>Шукати поломки, перевіряти межі й описувати, що пішло не так, — це і є тестування. Нове чарівне слово: <strong lang="en">test</strong> [тест] — перевірка.</p>
        </section>
    <?php endif; ?>

    <?php foreach ($world as $ch): ?>
        <?php if ($ch['status'] !== 'open'): continue; endif; ?>
        <section class="bv-chapter" aria-labelledby="bv-ch<?= (int) $ch['id'] ?>">
            <h2 class="bv-chapter__title" id="bv-ch<?= (int) $ch['id'] ?>">Глава <?= (int) $ch['id'] ?>. <?= bv_h($ch['title']) ?></h2>
            <?php foreach ($ch['levels'] as $lv): ?>
                <article class="bv-level">
                    <header class="bv-level__head">
                        <span class="bv-level__icon"><?= bv_level_icon($lv['icon']) ?></span>
                        <div>
                            <h3 class="bv-level__title">Рівень <?= (int) $lv['id'] ?>. <?= bv_h($lv['title']) ?></h3>
                            <p class="bv-level__intro"><?= bv_h($lv['intro']) ?></p>
                        </div>
                    </header>
                    <ol class="bv-missions">
                        <?php foreach ($lv['missions'] as $ms): $play = bv_world_playable($ms['id']); $s = (int) ($stars[$ms['id']] ?? 0); ?>
                            <li class="bv-mission<?= $play ? '' : ' is-soon' ?><?= $s > 0 ? ' is-done' : '' ?>">
                                <?php if ($play): ?>
                                    <a class="bv-mission__link" href="bugville-mission.php?m=<?= (int) $ms['id'] ?>">
                                        <span class="bv-mission__n"><?= bv_h($ms['n']) ?></span>
                                        <span class="bv-mission__title"><?= bv_h($ms['title']) ?></span>
                                        <?= bv_stars_html($s) ?>
                                    </a>
                                <?php else: ?>
                                    <span class="bv-mission__link" aria-disabled="true">
                                        <span class="bv-mission__n"><?= bv_h($ms['n']) ?></span>
                                        <span class="bv-mission__title"><?= bv_h($ms['title']) ?></span>
                                        <span class="bv-soon">скоро</span>
                                    </span>
                                <?php endif; ?>
                            </li>
                        <?php endforeach; ?>
                    </ol>
                    <?php $ex = $examStatus[$lv['id']] ?? null; ?>
                    <p class="bv-level__exam">
                        <?php if ($ex === null || !$ex['enabled']): ?>
                            <span class="bv-badge">Іспит рівня — готується</span>
                        <?php elseif ($ex['passed']): ?>
                            <span class="bv-badge is-ok">✓ Іспит складено</span>
                            <?php if ($ex['certificate'] !== null): ?><a class="bv-link44" href="bugville-certificate.php?c=<?= bv_h($ex['certificate']) ?>">Грамота</a><?php endif; ?>
                        <?php else: ?>
                            <a class="bv-btn bv-btn--small bv-btn--ghost" href="bugville-exam.php?e=<?= (int) $lv['id'] ?>">Іспит рівня</a>
                            <?php if ($saveId === null): ?><span class="bv-muted">Іспити — для акаунтів від <?= bv_min_age() ?> років.</span><?php endif; ?>
                        <?php endif; ?>
                    </p>
                </article>
            <?php endforeach; ?>
        </section>
    <?php endforeach; ?>

    <section class="bv-chapter" aria-labelledby="bv-next-h">
        <h2 class="bv-chapter__title" id="bv-next-h">Далі в місті</h2>
        <ul class="bv-soon-list">
            <?php foreach ($world as $ch): if ($ch['status'] === 'open') { continue; } ?>
                <li><span class="bv-path"><?= bv_h($ch['path']) ?></span> Глава <?= (int) $ch['id'] ?>. <?= bv_h($ch['title']) ?> <span class="bv-soon">скоро</span></li>
            <?php endforeach; ?>
        </ul>
    </section>
</main>
<?php
bv_page_end(bv_parents_text() !== null);
