<?php

declare(strict_types=1);

/**
 * AI LAB HUB — «Багвіль»: Майстерня (MAIN_TASK, розділ 7). Косметика за монети гри: рамки аватара, наклейки, фони
 * карти; аватар — безкоштовно з набору. Купівля, вдягання й вибір аватара — bv-api.php (ws_buy / ws_equip / ws_avatar),
 * баланс рахує лише сервер. Гість і акаунт без 16+ бачать каталог без кнопок (MAIN_TASK §8: гостям майстерні немає).
 * Жодних реальних грошей, реклами, зовнішніх зображень: усі малюнки — власні SVG (app/bugville/bv-workshop.php).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/bugville/bv-player.php';
require_once __DIR__ . '/../app/bugville/bv-missions.php';
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

$uid = null;
try {
    $uid = bv_request_ctx($pdo, $account !== null ? (int) $account['id'] : null)['user_id'];
} catch (Throwable) {
    $uid = null;
}
$catalog = bv_ws_catalog($pdo);
$owned = [];
$look = ['avatar' => BV_WS_DEFAULT_AVATAR, 'frame' => null, 'sticker' => null, 'background' => null];
$bal = ['earned' => 0, 'spent' => 0, 'coins' => 0];
if ($uid !== null) {
    try {
        $owned = bv_ws_owned($pdo, (int) $uid);
        $look = bv_ws_look($pdo, (int) $uid);
        $bal = bv_ws_balance($pdo, (int) $uid);
    } catch (Throwable) {
        $uid = null;   // таблиць міграції № 39 немає — показуємо лише каталог
    }
}

bv_page_start('Майстерня', ['user' => $account, 'back' => 'bugville.php', 'next' => 'bugville-workshop.php',
    'description' => 'Майстерня Багвіля: прикраси для аватара й карти за монети гри.']);
?>
<main class="bv-main" id="bv-main">
    <nav class="bv-crumbs" aria-label="Де ви"><a href="bugville.php">Карта</a> › Майстерня</nav>
    <h1 class="bv-title">Майстерня</h1>
    <section class="bv-card">
        <p class="bv-lead" style="margin-top: 0">Тут можна прикрасити свого героя: рамка, наклейка й фон карти. Прикраси купуються лише за монети гри,
            які ви заробляєте в місіях та іспитах. За справжні гроші тут нічого не продається, і прикраси не дають переваг у грі.</p>
        <?php if ($uid === null): ?>
            <p class="bv-note"><?= $account === null
                ? 'Майстерня — для акаунтів від ' . bv_min_age() . ' років. <a href="' . bv_h(auth_login_url('bugville-workshop.php')) . '">Увійти</a> або <a href="'
                    . bv_h(auth_login_url('bugville-workshop.php', 'register.php')) . '">зареєструватися</a>.'
                : 'Щоб купувати прикраси, підтвердьте вік у будь-якій місії (від ' . bv_min_age() . ' років).' ?></p>
        <?php endif; ?>
    </section>

    <div id="bv-workshop" data-account="<?= $uid !== null ? '1' : '0' ?>">
    <?php if ($uid !== null): ?>
        <section class="bv-card bvw-me" aria-labelledby="bvw-me-h">
            <div class="bvw-look bvw-bg--<?= bv_h($look['background'] ?? 'none') ?>"><?= bv_ws_look_svg($look, 120) ?></div>
            <div>
                <h2 class="bv-chapter__title" id="bvw-me-h" style="margin-top: 0">Ваш вигляд</h2>
                <p class="bvw-coins">Монети: <strong><?= (int) $bal['coins'] ?></strong></p>
                <p class="bv-muted">Зароблено <?= (int) $bal['earned'] ?>, витрачено в Майстерні <?= (int) $bal['spent'] ?>.</p>
                <p class="bv-msg" id="bvw-msg" role="status" aria-live="polite"></p>
            </div>
        </section>

        <section class="bv-card" aria-labelledby="bvw-av-h">
            <h2 class="bv-chapter__title" id="bvw-av-h" style="margin-top: 0">Аватар <span class="bv-muted">(безкоштовно)</span></h2>
            <ul class="bvw-grid bvw-grid--avatars">
                <?php foreach (BV_WS_AVATARS as $ak => $an): $on = $look['avatar'] === $ak; ?>
                    <li><button type="button" class="bvw-avatar<?= $on ? ' is-on' : '' ?>" data-action="ws_avatar" data-item="<?= bv_h($ak) ?>" aria-pressed="<?= $on ? 'true' : 'false' ?>">
                        <?= bv_ws_look_svg(['avatar' => $ak], 64, $an) ?><span><?= bv_h($an) ?><?= $on ? ' ✓' : '' ?></span></button></li>
                <?php endforeach; ?>
            </ul>
        </section>
    <?php endif; ?>

    <?php foreach (BV_WS_KINDS as $kind => $kindTitle): $items = array_filter($catalog, static fn($i) => $i['kind'] === $kind); ?>
        <section class="bv-card" aria-labelledby="bvw-<?= bv_h($kind) ?>-h">
            <h2 class="bv-chapter__title" id="bvw-<?= bv_h($kind) ?>-h" style="margin-top: 0"><?= bv_h($kindTitle) ?></h2>
            <ul class="bvw-grid">
                <?php foreach ($items as $it): $has = isset($owned[$it['key']]); $worn = $look[$kind] === $it['key']; ?>
                    <li class="bvw-item<?= $has ? ' is-owned' : '' ?><?= $worn ? ' is-worn' : '' ?>">
                        <div class="bvw-item__art bvw-bg--<?= $kind === 'background' ? bv_h($it['key']) : 'none' ?>">
                            <?= $kind === 'background' ? bv_ws_look_svg(['avatar' => $look['avatar']], 72, $it['title']) : bv_ws_item_svg($it) ?>
                        </div>
                        <p class="bvw-item__title"><strong><?= bv_h($it['title']) ?></strong></p>
                        <p class="bv-muted bvw-item__desc"><?= bv_h($it['description']) ?></p>
                        <?php if ($uid === null): ?>
                            <p class="bvw-item__price"><?= (int) $it['price'] ?> монет</p>
                        <?php elseif (!$has): $can = $bal['coins'] >= $it['price']; ?>
                            <p class="bv-actions"><button type="button" class="bv-btn bv-btn--small" data-action="ws_buy" data-item="<?= bv_h($it['key']) ?>"
                                <?= $can ? '' : 'disabled' ?>><?= $can ? 'Купити за ' . (int) $it['price'] . ' монет' : 'Потрібно ' . (int) $it['price'] . ' монет' ?></button></p>
                        <?php else: ?>
                            <p class="bvw-item__state"><span aria-hidden="true">✓</span> <?= $worn ? 'Вдягнуто' : 'Куплено' ?></p>
                            <p class="bv-actions"><button type="button" class="bv-btn bv-btn--small<?= $worn ? ' bv-btn--ghost' : '' ?>" data-action="ws_equip"
                                data-kind="<?= bv_h($kind) ?>" data-item="<?= $worn ? '' : bv_h($it['key']) ?>"><?= $worn ? 'Зняти' : 'Вдягнути' ?></button></p>
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
