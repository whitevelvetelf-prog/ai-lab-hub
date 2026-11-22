<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: налаштування повідомлень.
 *
 *  - перемикач «Листи про нові повідомлення» (mp_notify_prefs.email_new_message, за замовчуванням вимкнено);
 *  - список заблокованих користувачів із кнопкою «Розблокувати»;
 *  - відписка з листа без входу: mp-notify-settings.php?unsub=<id>.<hmac> (підпис — config messaging_secret).
 * POST + CSRF. Приватна сторінка (no-store, noindex).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/mp-messages.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
msg_require_enabled($pdo);
msg_private_headers();

// Відписка з листа: працює без входу, лише вимикає листи (нічого іншого токен не дає).
$unsub = is_string($_GET['unsub'] ?? null) ? (string) $_GET['unsub'] : '';
if ($unsub !== '') {
    $who = msg_unsub_verify($unsub);
    if ($who !== null) {
        msg_set_email_pref($pdo, $who, false);
    }
    msg_message_page($who !== null ? 200 : 400, t('msg_settings'), '<p class="mp-text">' . mp_e(t($who !== null ? 'msg_unsub_done' : 'msg_unsub_bad')) . '</p>', 'marketplace.php');
}

$uid = mpb_require_login();

if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    if (!mp_csrf_verify()) {
        msg_message_page(403, t('msg_settings'), '<p class="mp-text">' . mp_e(t('mpb_err_csrf')) . '</p>');
    }
    $action = (string) ($_POST['action'] ?? '');
    if ($action === 'email') {
        msg_set_email_pref($pdo, $uid, ($_POST['email_new_message'] ?? '') === '1');
        if (($_POST['return'] ?? '') === 'account') {   // перемикач у кабінеті (account.php, блок «Повідомлення»)
            $_SESSION['account_flash'] = t('msg_settings_saved');
            header('Location: account.php#acc-messages', true, 303);   // фіксована адреса з якорем (mpb_redirect якорів не приймає)
            exit;
        }
        mpb_flash('ok', t('msg_settings_saved'));
    } elseif ($action === 'unblock') {
        msg_unblock($pdo, $uid, (int) ($_POST['user_id'] ?? 0));
        mpb_flash('ok', t('msg_unblocked_done'));
    }
    mpb_redirect('mp-notify-settings.php');
}

$emailOn = msg_email_pref($pdo, $uid);
$blocks = msg_blocks($pdo, $uid);

msg_open(t('msg_settings'));
?>
    <div class="mp-page mp-page--narrow">
        <p><a class="mp-back" href="mp-messages.php">← <?= mp_e(t('msg_title')) ?></a></p>
        <h1 class="mp-title"><?= mp_e(t('msg_settings')) ?></h1>
        <?= mpb_flash_html() ?>
        <section class="mp-panel">
            <h2 class="mp-panel__title"><?= mp_e(t('msg_email_title')) ?></h2>
            <form method="post" action="mp-notify-settings.php">
                <?= mp_csrf_field() ?>
                <input type="hidden" name="action" value="email">
                <label class="msg-check"><input type="checkbox" name="email_new_message" value="1"<?= $emailOn ? ' checked' : '' ?>> <span><?= mp_e(t('msg_email_toggle')) ?></span></label>
                <p class="mp-hint"><?= mp_e(t('msg_email_hint')) ?></p>
                <?php if (msg_cfg('messaging_email_enabled') !== true): ?><p class="mp-hint"><?= mp_e(t('msg_email_site_off')) ?></p><?php endif; ?>
                <p class="mp-actions msg-actions"><button class="mp-btn mp-btn--primary" type="submit"><?= mp_e(t('msg_save')) ?></button></p>
            </form>
        </section>
        <section class="mp-panel">
            <h2 class="mp-panel__title"><?= mp_e(t('msg_blocks_title')) ?></h2>
            <?php if ($blocks === []): ?>
                <p class="mp-text"><?= mp_e(t('msg_blocks_empty')) ?></p>
            <?php else: ?>
                <ul class="msg-list">
                    <?php foreach ($blocks as $b): ?>
                        <li class="msg-item"><form class="msg-item__link" method="post" action="mp-notify-settings.php">
                            <?= mp_csrf_field() ?><input type="hidden" name="action" value="unblock"><input type="hidden" name="user_id" value="<?= $b['user_id'] ?>">
                            <span class="msg-item__main"><span class="msg-item__title"><?= mp_e($b['label']) ?></span></span>
                            <button class="mp-btn" type="submit"><?= mp_e(t('msg_unblock')) ?></button>
                        </form></li>
                    <?php endforeach; ?>
                </ul>
            <?php endif; ?>
        </section>
    </div>
<?php
mpb_close();
