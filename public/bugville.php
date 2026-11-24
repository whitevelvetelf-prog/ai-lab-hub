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
require_once __DIR__ . '/../app/bugville/bv-view.php';
require_once __DIR__ . '/../app/bugville/bv-parents.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
$account = auth_check() ? auth_current_user($pdo) : null;
if (!bv_pages_visible($account)) {
    bv_not_found();
}
bv_load_missions();

$saveId = null;
$stars = [];
$totals = ['xp' => 0, 'stars' => 0, 'coins' => 0];
try {
    $saveId = $account !== null && bv_age_confirmed($pdo, (int) $account['id']) ? (int) $account['id'] : null;
    if ($saveId !== null) {
        bv_credit_guest_session($pdo, $saveId);   // щойно ввійшли після гри гостем — зарахувати сеанс до показу карти
    }
    $stars = bv_stars_by_mission($pdo, $saveId);
    $totals = $saveId !== null ? bv_totals($pdo, $saveId) : bv_guest_totals();
} catch (Throwable $e) {
    error_log('[bugville] map progress: ' . get_class($e));
}

$world = bv_world();
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
        <?php if ($saveId === null): ?>
            <p class="bv-note"><?= $account === null
                ? 'Грати можна без реєстрації. Результати цього сеансу зберігаються, лише якщо ввійти в акаунт (від ' . bv_min_age() . ' років).'
                : 'Щоб зберігати прогрес, підтвердьте вік у будь-якій місії (від ' . bv_min_age() . ' років). Поки що результати лише цього сеансу.' ?></p>
        <?php endif; ?>
    </section>

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
                    <p class="bv-level__exam">
                        <span class="bv-badge">Іспит рівня — скоро</span>
                        <?php if ($saveId === null): ?><span class="bv-muted">Іспити — для акаунтів від <?= bv_min_age() ?> років.</span><?php endif; ?>
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
