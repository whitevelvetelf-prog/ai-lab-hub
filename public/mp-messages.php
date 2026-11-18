<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: «Повідомлення» — список розмов користувача.
 *
 *   mp-messages.php?tab=all|unread|archive[&page=N]
 *
 * Рядок: мініатюра й назва оголошення, співрозмовник, початок останнього повідомлення (звичайний текст), час,
 * лічильник непрочитаних. Архів — розмови, сховані користувачем (до нового повідомлення), і лише для читання
 * (оголошення закрито довше за msg_readonly_after_days). Лише свої розмови (покупець або автор). Приватна сторінка.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/mp-messages.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
msg_require_enabled($pdo);
msg_private_headers();
$uid = mpb_require_login();

$tabs = ['all' => t('msg_tab_all'), 'unread' => t('msg_tab_unread'), 'archive' => t('msg_tab_archive')];
$tab = isset($tabs[$_GET['tab'] ?? '']) ? (string) $_GET['tab'] : 'all';
$page = max(1, (int) ($_GET['page'] ?? 1));
$rows = msg_inbox($pdo, $uid, $tab, $page);
$hasMore = count($rows) > MSG_PAGE_SIZE;
$rows = array_slice($rows, 0, MSG_PAGE_SIZE);
$fmt = current_lang() === 'uk' ? 'd.m.Y H:i' : 'Y-m-d H:i';

msg_open(t('msg_title'));
?>
    <div class="mp-page mp-page--narrow">
        <h1 class="mp-title"><?= mp_e(t('msg_title')) ?></h1>
        <?= mpb_flash_html() ?>
        <nav class="msg-tabs" aria-label="<?= mp_e(t('msg_title')) ?>">
            <?php foreach ($tabs as $k => $label): ?>
                <a class="mp-tab<?= $k === $tab ? ' is-active' : '' ?>" href="mp-messages.php?tab=<?= $k ?>"<?= $k === $tab ? ' aria-current="page"' : '' ?>><?= mp_e($label) ?></a>
            <?php endforeach; ?>
            <a class="mp-tab" href="mp-notify-settings.php"><?= mp_e(t('msg_settings')) ?></a>
        </nav>

        <?php if ($rows === []): ?>
            <p class="mp-text"><?= mp_e(t($tab === 'archive' ? 'msg_empty_archive' : ($tab === 'unread' ? 'msg_empty_unread' : 'msg_empty'))) ?></p>
        <?php else: ?>
            <ul class="msg-list">
                <?php foreach ($rows as $r): $l = $r['listing']; ?>
                    <li class="msg-item<?= $r['unread'] > 0 ? ' msg-item--unread' : '' ?>">
                        <a class="msg-item__link" href="mp-thread.php?id=<?= (int) $r['id'] ?>">
                            <?= $l !== null && $l['thumb'] !== null ? '<img class="msg-thumb" src="' . mp_e($l['thumb']) . '" alt="" loading="lazy">' : '<span class="msg-thumb" aria-hidden="true">✉</span>' ?>
                            <span class="msg-item__main">
                                <span class="msg-item__title"><?= mp_e($l['title'] ?? t('msg_listing_removed')) ?></span>
                                <span class="msg-item__meta"><?= mp_e($r['role'] === 'buyer' ? t('msg_role_author') : t('msg_role_buyer')) ?>: <?= mp_e($r['counterpart']) ?><?= $r['muted'] ? ' · ' . mp_e(t('msg_muted_short')) : '' ?></span>
                                <span class="msg-item__preview"><?= $r['last_mine'] ? mp_e(t('msg_you')) . ': ' : '' ?><?= mp_e($r['preview']) ?></span>
                            </span>
                            <span class="msg-item__side">
                                <time datetime="<?= mp_e(date('c', strtotime($r['time']) ?: time())) ?>"><?= mp_e(date($fmt, strtotime($r['time']) ?: time())) ?></time>
                                <?php if ($r['unread'] > 0): ?><br><span class="msg-badge" aria-label="<?= mp_e(sprintf(t('msg_unread_aria'), $r['unread'])) ?>"><?= $r['unread'] > 99 ? '99+' : $r['unread'] ?></span><?php endif; ?>
                            </span>
                        </a>
                    </li>
                <?php endforeach; ?>
            </ul>
            <p class="mp-actions">
                <?php if ($page > 1): ?><a class="mp-btn" href="mp-messages.php?tab=<?= $tab ?>&amp;page=<?= $page - 1 ?>">← <?= mp_e(t('msg_prev')) ?></a><?php endif; ?>
                <?php if ($hasMore): ?><a class="mp-btn" href="mp-messages.php?tab=<?= $tab ?>&amp;page=<?= $page + 1 ?>"><?= mp_e(t('msg_next')) ?> →</a><?php endif; ?>
            </p>
        <?php endif; ?>
        <p class="msg-note"><?= mp_e(t('msg_privacy_note')) ?></p>
    </div>
<?php
mpb_close();
