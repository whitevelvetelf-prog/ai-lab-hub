<?php

declare(strict_types=1);

/**
 * AI LAB HUB — «Багвіль»: перша сторінка гри (Етап 0, еталон docs/bugville/prototype/bugville_prototype_home.html).
 * Вечірнє місто: смужка звання й XP, майстер Гайка, одна головна кнопка (Почати / Продовжити), три будинки-рівні з
 * крапками прогресу (закриті — затемнені із замком), шлях місій обраного будинку («???» для ще не досягнутих),
 * «Як грати», далі — Поломка дня, Книга слів, Майстерня, значки. Місії відкриваються по черзі (bv_world_progress);
 * закриту місію чи іспит закритого будинку сервер не віддає й за прямим посиланням (bugville-mission.php, bv-api.php).
 * Назви рівнів і місій — з bv_world_texts (міграція № 41). Без реклами, статистики переглядів і сторонніх ресурсів.
 * Видима для всіх лише з 'bugville_public' => true; інакше — лише admin (решті 404).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/bugville/bv-player.php';
require_once __DIR__ . '/../app/bugville/bv-missions.php';
require_once __DIR__ . '/../app/bugville/bv-exam.php';
require_once __DIR__ . '/../app/bugville/bv-progress.php';
require_once __DIR__ . '/../app/bugville/bv-daily.php';
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
$credXp = 0;
$cr = null;
try {
    $saveId = $account !== null && bv_age_confirmed($pdo, (int) $account['id']) ? (int) $account['id'] : null;
    if ($saveId !== null) {
        $cr = bv_credit_guest_session($pdo, $saveId);   // щойно ввійшли після гри гостем — зарахувати сеанс до показу
        $credXp = (int) ($cr['xp'] ?? 0);
    }
    $stars = bv_stars_by_mission($pdo, $saveId);
    $totals = $saveId !== null ? bv_totals($pdo, $saveId) : bv_guest_totals();
} catch (Throwable $e) {
    error_log('[bugville] home progress: ' . get_class($e));
}
// Звання, серія, значки (міграція № 36): акаунт 16+ — збережені; гість — звання за XP цього сеансу.
$prog = null;
if ($saveId !== null) {
    try {
        if (($cr['credited'] ?? 0) > 0) {
            bv_progress_update($pdo, $saveId, $totals['xp'] - $credXp, false);
        }
        $prog = bv_progress_summary($pdo, $saveId);
    } catch (Throwable $e) {
        error_log('[bugville] home rank/badges: ' . get_class($e));
    }
}
$ranks = bv_ranks($pdo);
$rk = $prog ?? bv_rank_for($ranks, (int) $totals['xp']);
$rankNo = 1;
foreach ($ranks as $i => $r) {
    if ($r['key'] === $rk['rank']['key']) {
        $rankNo = $i + 1;
    }
}
$rankFrom = (int) $rk['rank']['min_xp'];
$rankTo = $rk['next'] !== null ? (int) $rk['next']['min_xp'] : $rankFrom;
$rankPct = $rk['next'] === null ? 100 : (int) max(0, min(100, round(100 * ((int) $totals['xp'] - $rankFrom) / max(1, $rankTo - $rankFrom))));

$world = bv_world();
$chapter = $world[0];
$levels = $chapter['levels'];
$all = bv_world_missions();
$wp = bv_world_progress($stars);
$nextId = $wp['next'];
$doneCount = count(array_filter($wp['missions'], static fn($s) => $s === 'done'));
$nextMs = $nextId !== null ? $all[$nextId] : null;
// Обраний будинок: той, де наступна місія (усе пройдено — останній відкритий).
$selLevel = $nextMs !== null ? (int) $nextMs['level'] : (int) $levels[count($levels) - 1]['id'];

$examStatus = [];
foreach ($levels as $lv) {
    try {
        $examStatus[$lv['id']] = bv_exam_status($pdo, $saveId, bv_exam_id((int) $lv['id']));
    } catch (Throwable $e) {
        error_log('[bugville] exam status: ' . get_class($e));
    }
}

// Привітання майстра: HTML складається з власних рядків, імʼя й назва місії — лише через bv_h().
$name = $account !== null ? trim((string) ($account['name'] ?? '')) : '';
$name = mb_substr($name, 0, 40);
$hi = $name !== '' ? ', ' . bv_h($name) : '';
if ($nextMs === null) {
    $sayHtml = 'Ура! Усі місії Глави 1 пройдено. Зіграйте «Поломку дня» або складіть іспити рівнів.';
    $go = ['text' => 'Поломка дня', 'href' => 'bugville-daily.php'];
} elseif ($doneCount === 0) {
    $sayHtml = 'Привіт' . $hi . '! Я майстер Гайка. У місті Багвіль усе ламається: автомати, пошта, бібліотека. '
        . 'Допоможи мені <em>знайти поломки</em>, і я розповім, як вони називаються.';
    $go = ['text' => 'Почати: ' . $nextMs['level_title'], 'href' => 'bugville-mission.php?m=' . (int) $nextId];
} else {
    $sayHtml = 'З поверненням' . $hi . '! Наступна поломка ховається в місії <em>«' . bv_h($nextMs['title']) . '»</em>.';
    $go = ['text' => 'Продовжити: ' . $nextMs['n'] . ' ' . $nextMs['title'], 'href' => 'bugville-mission.php?m=' . (int) $nextId];
}

/** Будинки (власні SVG із прототипу). */
function bvh_building_svg(string $icon): string
{
    return match ($icon) {
        'vending' => '<svg viewBox="0 0 210 190" aria-hidden="true" focusable="false"><rect x="62" y="8" width="86" height="168" rx="12" fill="#2dd4a7" stroke="#0d6b55" stroke-width="4"/>'
            . '<rect x="70" y="16" width="70" height="22" rx="6" fill="#ffd23f"/><rect x="70" y="44" width="46" height="82" rx="6" fill="#0f1a3d"/>'
            . '<g><rect x="76" y="52" width="10" height="22" rx="3" fill="#ffd23f"/><rect x="90" y="52" width="10" height="22" rx="3" fill="#9be15d"/><rect x="104" y="52" width="8" height="22" rx="3" fill="#ff9f43"/>'
            . '<rect x="76" y="82" width="10" height="22" rx="3" fill="#9be15d"/><rect x="90" y="82" width="10" height="22" rx="3" fill="#ff9f43"/><rect x="104" y="82" width="8" height="22" rx="3" fill="#ffd23f"/></g>'
            . '<rect x="122" y="44" width="18" height="30" rx="4" fill="#0b2a22"/><rect x="124" y="80" width="14" height="10" rx="3" fill="#e9fff7"/><rect x="124" y="94" width="14" height="10" rx="3" fill="#e9fff7"/>'
            . '<rect x="124" y="108" width="14" height="10" rx="3" fill="#ff6b5b"/><rect x="72" y="136" width="66" height="24" rx="6" fill="#0d1a38"/><path d="M20 176h170" stroke="#1b2a6e" stroke-width="4"/></svg>',
        'post' => '<svg viewBox="0 0 210 190" aria-hidden="true" focusable="false"><rect x="22" y="56" width="166" height="120" fill="#c9553f" stroke="#7a2a1c" stroke-width="4"/>'
            . '<path d="M14 58L105 8l91 50z" fill="#8a3524" stroke="#7a2a1c" stroke-width="4" stroke-linejoin="round"/><rect x="88" y="112" width="34" height="64" rx="4" fill="#3a2a00"/>'
            . '<rect x="40" y="76" width="34" height="30" rx="3" fill="#ffd23f"/><rect x="136" y="76" width="34" height="30" rx="3" fill="#ffd23f"/>'
            . '<rect x="180" y="124" width="22" height="52" rx="6" fill="#ff6b5b" stroke="#7a2a1c" stroke-width="3"/><rect x="184" y="132" width="14" height="4" fill="#3a2a00"/></svg>',
        default => '<svg viewBox="0 0 210 190" aria-hidden="true" focusable="false"><path d="M12 60L105 12l93 48z" fill="#5b6fd6" stroke="#2c3a85" stroke-width="4" stroke-linejoin="round"/>'
            . '<rect x="24" y="60" width="162" height="116" fill="#e8ecff" stroke="#2c3a85" stroke-width="4"/>'
            . '<g fill="#b4bdf0" stroke="#2c3a85" stroke-width="2"><rect x="38" y="68" width="16" height="100"/><rect x="72" y="68" width="16" height="100"/><rect x="122" y="68" width="16" height="100"/><rect x="156" y="68" width="16" height="100"/></g>'
            . '<rect x="92" y="108" width="26" height="68" rx="3" fill="#2c3a85"/><path d="M92 40h26v12H92z" fill="#ffd23f"/></svg>',
    };
}

/** Майстер Гайка (SVG із затвердженого прототипу; класи .bvs-mentor__svg — спільні анімації сцен). */
const BVH_MENTOR = '<svg class="bvs-mentor__svg bvh-mentor wave" viewBox="0 0 120 124" aria-hidden="true" focusable="false"><g class="hero">'
    . '<g class="ant"><line x1="60" y1="16" x2="60" y2="30" stroke="#f2f5ff" stroke-width="4"/><circle cx="60" cy="12" r="7" fill="#ffd23f"/></g>'
    . '<g class="armL"><line x1="26" y1="88" x2="16" y2="68" stroke="#3a2a00" stroke-width="3" stroke-linecap="round"/><circle cx="15" cy="64" r="8" fill="#ff6b5b" stroke="#3a2a00" stroke-width="2"/></g>'
    . '<g class="armR"><line x1="94" y1="88" x2="104" y2="68" stroke="#3a2a00" stroke-width="3" stroke-linecap="round"/><circle cx="105" cy="64" r="8" fill="#ff6b5b" stroke="#3a2a00" stroke-width="2"/></g>'
    . '<rect x="24" y="30" width="72" height="62" rx="20" fill="#ffd23f" stroke="#3a2a00" stroke-width="3"/><rect x="42" y="92" width="36" height="24" rx="8" fill="#ff6b5b" stroke="#3a2a00" stroke-width="3"/>'
    . '<g class="eyes"><circle cx="46" cy="56" r="9" fill="#fff"/><circle cx="74" cy="56" r="9" fill="#fff"/><circle cx="48" cy="58" r="4.5" fill="#1b2559"/><circle cx="76" cy="58" r="4.5" fill="#1b2559"/></g>'
    . '<path d="M46 74 Q60 88 74 74" fill="none" stroke="#3a2a00" stroke-width="4" stroke-linecap="round"/></g></svg>';

function bvh_stars(int $n): string
{
    $n = max(0, min(3, $n));

    return '<span class="bvh-st" aria-label="Зірок: ' . $n . ' з 3">' . str_repeat('<span class="is-on" aria-hidden="true">★</span>', $n)
        . str_repeat('<span aria-hidden="true">☆</span>', 3 - $n) . '</span>';
}

bv_page_start('Місто', ['user' => $account, 'back' => '/', 'next' => 'bugville.php', 'body_class' => 'bv-home',
    'description' => 'Багвіль — навчальна гра: знаходьте поломки в автоматі, на пошті й у бібліотеці та вивчайте чарівні англійські слова.']);
?>
<main class="bv-main bvh" id="bv-main">
    <h1 class="bv-sr">Багвіль — місто поломок</h1>

    <header class="bvh-bar">
        <div class="bvh-rank" title="Звання зростає разом з XP">
            <span class="bvh-rank__no" aria-hidden="true"><?= (int) $rankNo ?></span>
            <span class="bvh-rank__t"><small>Ваше звання</small><b><?= bv_h($rk['rank']['title']) ?></b></span>
            <span class="bvh-meter" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="<?= $rankPct ?>"
                  aria-label="<?= $rk['next'] === null ? 'Найвище звання' : bv_h('До звання «' . $rk['next']['title'] . '»: ' . ((int) $totals['xp'] - $rankFrom) . ' із ' . ($rankTo - $rankFrom) . ' XP') ?>"><i style="width: <?= max(3, $rankPct) ?>%"></i></span>
        </div>
        <ul class="bvh-pills" aria-label="Ваш рахунок">
            <li><i>XP</i> <?= (int) $totals['xp'] ?></li>
            <li><i aria-label="Зірки">★</i> <?= (int) $totals['stars'] ?></li>
            <?php if ($saveId !== null): ?><li><i aria-label="Монети">●</i> <?= (int) $totals['coins'] ?></li><?php endif; ?>
        </ul>
        <?php if ($saveId === null && $doneCount > 0): ?>
            <p class="bvh-guestnote">Це прогрес цього сеансу. <a href="<?= bv_h(auth_login_url('bugville.php', 'register.php')) ?>">Зареєструйтесь, щоб зберегти</a>.</p>
        <?php endif; ?>
    </header>

    <section class="bvh-town" aria-label="Місто Багвіль">
        <svg class="bvh-sky" viewBox="0 0 400 160" preserveAspectRatio="none" aria-hidden="true" focusable="false"><g fill="#fff" opacity=".9"><circle cx="30" cy="30" r="1.6"/><circle cx="90" cy="70" r="1.2"/><circle cx="150" cy="22" r="1.8"/><circle cx="240" cy="55" r="1.3"/><circle cx="310" cy="25" r="1.7"/><circle cx="370" cy="75" r="1.2"/><circle cx="200" cy="100" r="1"/><circle cx="60" cy="120" r="1.1"/><circle cx="270" cy="110" r="1.3"/></g></svg>
        <div class="bvh-moon" aria-hidden="true"></div>

        <div class="bvh-hello">
            <?= BVH_MENTOR ?>
            <p class="bvh-say" aria-live="polite"><?= $sayHtml ?></p>
        </div>

        <div class="bvh-cta">
            <a class="bvh-go" href="<?= bv_h($go['href']) ?>"><?= bv_h($go['text']) ?></a>
            <?php if ($saveId === null && $doneCount === 0): ?>
                <small>Грати можна одразу, без реєстрації. Зберегти прогрес можна пізніше.</small>
            <?php endif; ?>
        </div>

        <div class="bvh-street" role="group" aria-label="Будинки міста">
            <?php foreach ($levels as $i => $lv): $ls = $wp['levels'][$lv['id']] ?? ['open' => false, 'done' => 0, 'total' => 0];
                $prev = $levels[$i - 1] ?? null; ?>
                <button type="button" class="bvh-bld<?= $ls['open'] ? '' : ' is-locked' ?>" data-level="<?= (int) $lv['id'] ?>"
                        aria-controls="bvh-p<?= (int) $lv['id'] ?>" aria-pressed="<?= (int) $lv['id'] === $selLevel ? 'true' : 'false' ?>">
                    <?= bvh_building_svg((string) $lv['icon']) ?>
                    <?php if (!$ls['open'] && $prev !== null): ?>
                        <span class="bvh-lock"><span aria-hidden="true">🔒</span><span class="bvh-lock__t"> відкриється після: <?= bv_h($prev['title']) ?></span></span>
                    <?php endif; ?>
                    <span class="bvh-plate"><?= (int) ($i + 1) ?>. <?= bv_h($lv['title']) ?><small><?= bv_h($lv['subtitle'] ?? '') ?></small>
                        <span class="bvh-dots" aria-label="<?= bv_h('Пройдено ' . $ls['done'] . ' з ' . $ls['total']) ?>"><?php
                            foreach ($lv['missions'] as $ms): ?><i class="<?= ($wp['missions'][$ms['id']] ?? '') === 'done' ? 'on' : '' ?>"></i><?php endforeach; ?></span>
                        <?php if (!$ls['open']): ?><span class="bv-sr">(закрито)</span><?php endif; ?></span>
                </button>
            <?php endforeach; ?>
        </div>
        <div class="bvh-road" aria-hidden="true"></div>
    </section>

    <?php /* Резерв над шляхом місій: «Поломка дня» (окрема місія; картка — коли вона увімкнена). */
    $daily = bv_daily_card($pdo, $saveId); ?>
    <div class="bvh-daily-slot" id="bvh-daily"<?= $daily === null ? ' hidden' : '' ?>>
        <?php if ($daily !== null): $ds = $daily['streak']; ?>
            <section class="bvh-card bvh-daily<?= $daily['done'] ? ' is-done' : '' ?>" aria-labelledby="bvh-daily-h">
                <div class="bvh-daily__icon" aria-hidden="true"><svg viewBox="0 0 64 64" focusable="false"><rect x="8" y="12" width="48" height="44" rx="6" fill="#2dd4a7"/>
                    <rect x="8" y="12" width="48" height="12" rx="6" fill="#ff6b5b"/><rect x="8" y="18" width="48" height="6" fill="#ff6b5b"/>
                    <rect x="18" y="6" width="5" height="12" rx="2" fill="#ffd23f"/><rect x="41" y="6" width="5" height="12" rx="2" fill="#ffd23f"/>
                    <circle cx="32" cy="40" r="10" fill="#0f1a3d"/><circle cx="32" cy="40" r="4" fill="#ffd23f"/></svg></div>
                <div>
                    <h2 id="bvh-daily-h">Поломка дня<?php if ($daily['done']): ?> <span class="bvh-chip">✓ Пройдено</span><?php endif; ?></h2>
                    <p><?= bv_h($daily['teaser']) ?></p>
                    <?php if ($ds !== null): ?>
                        <p class="bvh-streak"><span class="bv-flame<?= (int) $ds['current'] > 0 ? '' : ' is-sleep' ?>" aria-hidden="true"><svg viewBox="0 0 24 28">
                            <path class="f-out" d="M12 1c1 5 7 8 7 15a7 7 0 0 1-14 0c0-4 2-6 3-8 0 3 1 4 2 5 0-5 1-8 2-12z" fill="#ff6b5b"/>
                            <path class="f-in" d="M12 12c.5 3 4 5 4 8.5a4 4 0 0 1-8 0c0-2 1-3 2-4 0 1.5.5 2 1 2.5 0-3 .5-5 1-7z" fill="#ffd23f"/></svg></span>Днів поспіль: <b><?= (int) $ds['current'] ?></b> · рекорд <b><?= (int) $ds['best'] ?></b></p>
                    <?php elseif ($account === null): ?>
                        <p><a href="<?= bv_h(auth_login_url('bugville.php', 'register.php')) ?>">Зареєструйтесь</a>, щоб рахувати дні підряд.</p>
                    <?php endif; ?>
                    <p><a class="bvh-play" href="bugville-daily.php"><?= $daily['done'] ? 'Зіграти ще раз' : 'Грати' ?></a></p>
                </div>
            </section>
        <?php endif; ?>
    </div>

    <?php foreach ($levels as $i => $lv): $ls = $wp['levels'][$lv['id']] ?? ['open' => false]; $prev = $levels[$i - 1] ?? null; ?>
        <section class="bvh-path" id="bvh-p<?= (int) $lv['id'] ?>" data-level="<?= (int) $lv['id'] ?>" aria-labelledby="bvh-ph<?= (int) $lv['id'] ?>">
            <h2 id="bvh-ph<?= (int) $lv['id'] ?>"><?= bv_h($lv['title']) ?></h2>
            <p><?= bv_h($lv['intro']) ?></p>
            <ol class="bvh-steps">
                <?php if (!$ls['open']): ?>
                    <li class="bvh-step is-locked"><span class="bvh-n" aria-hidden="true">🔒</span>
                        <span><b>Ще закрито</b><small>Спершу пройдіть <?= bv_h($prev !== null ? '«' . $prev['title'] . '»' : 'попередні місії') ?>.</small></span><span></span></li>
                <?php else: foreach ($lv['missions'] as $ms): $state = $wp['missions'][$ms['id']] ?? 'soon'; $s = (int) ($stars[$ms['id']] ?? 0); ?>
                    <?php if ($state === 'done'): ?>
                        <li class="bvh-step is-done"><span class="bvh-n"><?= bv_h($ms['n']) ?></span>
                            <span><b><?= bv_h($ms['title']) ?></b><small>Пройдено</small></span>
                            <span class="bvh-step__end"><?= bvh_stars($s) ?><a class="bvh-again" href="bugville-mission.php?m=<?= (int) $ms['id'] ?>" aria-label="<?= bv_h('Зіграти ще раз: ' . $ms['n'] . ' ' . $ms['title']) ?>">Ще раз</a></span></li>
                    <?php elseif ($state === 'next'): ?>
                        <li class="bvh-step is-next"><span class="bvh-n"><?= bv_h($ms['n']) ?></span>
                            <span><b><?= bv_h($ms['title']) ?></b><small>Наступна місія</small></span>
                            <a class="bvh-play" href="bugville-mission.php?m=<?= (int) $ms['id'] ?>" aria-label="<?= bv_h('Грати: ' . $ms['n'] . ' ' . $ms['title']) ?>">Грати</a></li>
                    <?php elseif ($state === 'locked'): ?>
                        <li class="bvh-step is-locked"><span class="bvh-n"><?= bv_h($ms['n']) ?></span>
                            <span><b>???</b><small>Відкриється пізніше</small></span><?= bvh_stars(0) ?></li>
                    <?php else: ?>
                        <li class="bvh-step is-locked"><span class="bvh-n"><?= bv_h($ms['n']) ?></span>
                            <span><b><?= bv_h($ms['title']) ?></b><small>Скоро</small></span><span></span></li>
                    <?php endif; ?>
                <?php endforeach; endif; ?>
            </ol>
            <?php if ($ls['open']): $ex = $examStatus[$lv['id']] ?? null; ?>
                <p class="bvh-exam">
                    <?php if ($ex === null || !$ex['enabled']): ?>
                        <span class="bvh-chip is-muted">Іспит рівня — готується</span>
                    <?php elseif ($ex['passed']): ?>
                        <span class="bvh-chip">✓ Іспит складено</span>
                        <?php if ($ex['certificate'] !== null): ?><a href="bugville-certificate.php?c=<?= bv_h($ex['certificate']) ?>">Грамота</a><?php endif; ?>
                    <?php else: ?>
                        <a class="bvh-ghost" href="bugville-exam.php?e=<?= (int) $lv['id'] ?>">Іспит рівня</a>
                        <?php if ($saveId === null): ?><small class="bvh-note">Іспити — зі збереженим прогресом.</small><?php endif; ?>
                    <?php endif; ?>
                </p>
            <?php endif; ?>
        </section>
    <?php endforeach; ?>

    <?php if ($saveId === null && $doneCount > 0): ?>
        <section class="bvh-card bvh-save" aria-labelledby="bvh-save-h">
            <h2 id="bvh-save-h">Зберегти прогрес?</h2>
            <?php if ($account === null): ?>
                <p>Ви вже пройшли <?= $doneCount ?> <?= $doneCount === 1 ? 'місію' : ($doneCount < 5 ? 'місії' : 'місій') ?>. Створіть акаунт, і зірки, звання та слова не загубляться.</p>
                <p class="bvh-row"><a class="bvh-play" href="<?= bv_h(auth_login_url('bugville.php', 'register.php')) ?>">Зареєструватися</a>
                    <a class="bvh-ghost" href="<?= bv_h(auth_login_url('bugville.php')) ?>">Увійти</a></p>
            <?php else: ?>
                <p>Ви вже пройшли <?= $doneCount ?> <?= $doneCount === 1 ? 'місію' : ($doneCount < 5 ? 'місії' : 'місій') ?>. Щоб прогрес зберігся в акаунті, погодьтеся на збереження у вікні після наступної місії.</p>
            <?php endif; ?>
        </section>
    <?php endif; ?>

    <section class="bvh-how" aria-label="Як грати">
        <div><svg viewBox="0 0 48 48" aria-hidden="true" focusable="false"><circle cx="24" cy="24" r="22" fill="#ffd23f"/><path d="M14 26l6 6 14-16" fill="none" stroke="#3a2a00" stroke-width="5" stroke-linecap="round" stroke-linejoin="round"/></svg>
            <h3>Спробуй</h3><p>Натискай, вводь числа, заповнюй форми. Місто реагує на кожну дію.</p></div>
        <div><svg viewBox="0 0 48 48" aria-hidden="true" focusable="false"><circle cx="24" cy="24" r="22" fill="#ff6b5b"/><ellipse cx="24" cy="27" rx="9" ry="11" fill="#3a2a00"/><path d="M15 20l-6-4M33 20l6-4M15 30H8M33 30h7M16 37l-5 4M32 37l5 4" stroke="#3a2a00" stroke-width="3" stroke-linecap="round"/></svg>
            <h3>Знайди поломку</h3><p>Щось працює не так, як обіцяно? Це і є поломка. Отримуй зірки.</p></div>
        <div><svg viewBox="0 0 48 48" aria-hidden="true" focusable="false"><circle cx="24" cy="24" r="22" fill="#4fe0b6"/><rect x="11" y="13" width="26" height="22" rx="4" fill="#053b2d"/><path d="M16 20h16M16 26h10" stroke="#4fe0b6" stroke-width="3" stroke-linecap="round"/></svg>
            <h3>Збери слово</h3><p>За кожну місію отримуєш чарівне англійське слово. Збирай колекцію.</p></div>
    </section>

    <?php
    try {
        $wbook = $saveId !== null ? bv_words_book($pdo, (int) $saveId) : bv_words_book_guest($pdo);
    } catch (Throwable) {
        $wbook = [];
    }
    $wsLook = null;
    $wsCoins = 0;
    if ($saveId !== null) {
        try {
            $wsLook = bv_ws_look($pdo, (int) $saveId);
            $wsCoins = bv_ws_balance($pdo, (int) $saveId)['coins'];
        } catch (Throwable) {
            $wsLook = null;
        }
    }
    $wOpen = count(array_filter($wbook, static fn($w) => $w['state'] !== 'locked'));
    $wLearned = count(array_filter($wbook, static fn($w) => $w['state'] === 'learned')); ?>
    <section class="bvh-more" aria-label="Ще в місті">
        <?php if ($wbook !== []): ?>
            <a class="bvh-card bvh-link" href="bugville-words.php"><span class="bvh-link__i" aria-hidden="true">📖</span>
                <span><b>Книга чарівних слів</b><small><?= $saveId !== null ? 'Вивчено ' . $wLearned . ' з ' . count($wbook) . ' · відкрито ' . $wOpen
                    : 'Відкрито в цьому сеансі: ' . $wOpen . ' з ' . count($wbook) ?></small></span></a>
        <?php endif; ?>
        <a class="bvh-card bvh-link" href="bugville-workshop.php">
            <?php if ($wsLook !== null): ?>
                <span class="bvw-look bvw-bg--<?= bv_h($wsLook['background'] ?? 'none') ?>"><?= bv_ws_look_svg($wsLook, 48) ?></span>
                <span><b>Майстерня</b><small>Монети: <?= (int) $wsCoins ?> · рамки, наклейки й фони</small></span>
            <?php else: ?>
                <span class="bvh-link__i" aria-hidden="true">🛠</span>
                <span><b>Майстерня</b><small>Прикраси для героя за монети гри</small></span>
            <?php endif; ?>
        </a>
    </section>

    <?php if ($prog !== null && $prog['badges'] !== []): $got = count(array_filter($prog['badges'], static fn($b) => $b['earned'])); ?>
        <section class="bvh-card" aria-labelledby="bvh-badges-h">
            <h2 id="bvh-badges-h">Значки: <?= $got ?> з <?= count($prog['badges']) ?></h2>
            <ul class="bv-badges bvh-badges">
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

    <?php if ($nextMs === null): ?>
        <section class="bvh-card bvh-reveal" aria-labelledby="bvh-reveal-h">
            <h2 id="bvh-reveal-h">Тепер ви знаєте, що це називається тестування</h2>
            <p>Шукати поломки, перевіряти межі й описувати, що пішло не так, — це і є тестування. Нове чарівне слово: <strong lang="en">test</strong> [тест] — перевірка.</p>
        </section>
    <?php endif; ?>

    <section class="bvh-card" aria-labelledby="bvh-next-h">
        <h2 id="bvh-next-h">Далі в місті</h2>
        <ul class="bvh-soon">
            <?php foreach ($world as $ch): if ($ch['status'] === 'open') { continue; } ?>
                <li><span class="bvh-path-tag"><?= bv_h($ch['path']) ?></span> Глава <?= (int) $ch['id'] ?>. <?= bv_h($ch['title']) ?> <span class="bvh-chip is-muted">скоро</span></li>
            <?php endforeach; ?>
        </ul>
    </section>
</main>
<?php
bv_page_end(bv_parents_text() !== null);
