<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: надіслати лист підтвердження email (лише залогінені).
 * GET — стан і кнопка; POST (CSRF) — надсилає лист на поточний email користувача (не вводиться вручну,
 * тож сторінка нічого не розкриває про чужі акаунти). Ліміт: 1 лист на 2 хв і 5 на добу.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-email.php';

mp_public_require();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$userId = mpb_require_login();

if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    mpb_require_post();
    $res = mpv_send($pdo, $userId);
    $msg = match ($res) {
        'sent'     => ['ok', sprintf(t('mpv_sent'), (int) mp_config()['verify_ttl_hours'])],
        'too_soon' => ['error', sprintf(t('mpv_too_soon'), (int) mp_config()['verify_resend_min'])],
        'daily'    => ['error', sprintf(t('mpv_daily'), (int) mp_config()['verify_max_per_day'])],
        'already'  => ['ok', t('mpv_already')],
        'rate'     => ['error', t('mpb_rate_limited')],
        default    => ['error', t('mpv_fail')],
    };
    mpb_flash($msg[0], $msg[1]);
    mpb_redirect('mp-verify-email.php');
}

$verified = mpv_is_verified($pdo, $userId);
$u = $pdo->prepare('SELECT email FROM users WHERE id = :id');
$u->execute([':id' => $userId]);
$email = (string) $u->fetchColumn();

mpb_open(t('mpv_title'));
?>
    <div class="mp-page mp-page--narrow">
        <a class="mp-back" href="marketplace.php"><?= mp_e(t('mp_back')) ?></a>
        <h1 class="mp-title"><?= mp_e(t('mpv_title')) ?></h1>
        <?= mpb_flash_html() ?>
        <section class="mp-panel">
            <?php if ($verified): ?>
                <p class="mp-text"><?= mp_e(t('mpv_already')) ?></p>
                <?php if (mpb_posting_open()): ?>
                    <p class="mp-actions"><a class="mp-btn mp-btn--primary" href="mp-post.php"><?= mp_e(t('mpb_post_btn')) ?></a></p>
                <?php endif; ?>
            <?php else: ?>
                <p class="mp-text"><?= mp_e(sprintf(t('mpv_page_text'), $email)) ?></p>
                <?= mpv_block_html() ?>
            <?php endif; ?>
        </section>
    </div>
<?php mpb_close(); ?>
