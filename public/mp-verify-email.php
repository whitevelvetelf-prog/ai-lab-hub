<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: екран «Підтвердьте пошту» (лише залогінені; гість → вхід із поверненням сюди).
 *
 *   mp-verify-email.php[?next=сторінка]        — стан: підтверджено ✓ / лист уже надіслано / надіслати лист
 *   mp-verify-email.php?check=1[&next=…]       — «Я підтвердив(ла)»: перевірка стану в БД (посилання відкрили
 *                                                в іншому браузері чи застосунку) → якщо так, одразу на next
 *   POST send=1 (CSRF)                          — надіслати лист (лише коли немає дійсного посилання)
 *   POST resend=1 (CSRF)                        — «Надіслати ще раз» (ліміт: 1 лист на N хв і M на добу)
 *
 * Лист іде на поточний email акаунта (не вводиться вручну — сторінка нічого не розкриває про чужі акаунти).
 * Коли пошту підтверджено і є next — автоматичне повернення до форми.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-email.php';

mp_public_require();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

header('Cache-Control: no-store');

$next = auth_safe_next(is_string($_REQUEST['next'] ?? null) ? (string) $_REQUEST['next'] : '');
if ($next !== null && str_starts_with($next, 'mp-verify-email.php')) {
    $next = null;   // повернення «на себе» — без циклу
}
$self = mpv_page_url($next);
$userId = mpb_require_login();

if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    mpb_require_post();
    $res = mpv_send($pdo, $userId, $next, ($_POST['resend'] ?? '') === '1');
    $msg = match ($res) {
        'sent'     => ['ok', sprintf(t('mpv_sent'), (int) mp_config()['verify_ttl_hours'])],
        'pending'  => ['ok', mpf_tr('v_already_sent')],
        'too_soon' => ['error', sprintf(t('mpv_too_soon'), (int) mp_config()['verify_resend_min'])],
        'daily'    => ['error', sprintf(t('mpv_daily'), (int) mp_config()['verify_max_per_day'])],
        'already'  => ['ok', t('mpv_already')],
        'rate'     => ['error', t('mpb_rate_limited')],
        default    => ['error', t('mpv_fail')],
    };
    mpb_flash($msg[0], $msg[1]);
    mpb_redirect($self);
}

$verified = mpv_is_verified($pdo, $userId);

// Пошту підтверджено і є куди повертатися → одразу до форми (без зайвого кліку).
if ($verified && $next !== null) {
    header('Location: ' . $next, true, 303);
    exit;
}
if (($_GET['check'] ?? '') === '1' && !$verified) {
    mpb_flash('error', mpf_tr('v_check_not_yet'));
    mpb_redirect($self);
}

$u = $pdo->prepare('SELECT email FROM users WHERE id = :id');
$u->execute([':id' => $userId]);
$email = trim((string) $u->fetchColumn());
$pending = $verified ? null : mpv_pending($pdo, $userId);
$fmt = static fn(string $dt): string => date('d.m.Y H:i', (int) strtotime($dt));
$nextField = $next !== null ? '<input type="hidden" name="next" value="' . mp_e($next) . '">' : '';
$checkUrl = 'mp-verify-email.php?check=1' . ($next !== null ? '&next=' . rawurlencode($next) : '');

mpb_open(mpf_tr('v_title'), true, 'post');
?>
    <div class="mp-page mp-page--narrow">
        <h1 class="mp-title"><?= mp_e(mpf_tr($verified ? 'v_ok_state' : 'v_need_state')) ?></h1>
        <?= mpb_flash_html() ?>
        <section class="mp-panel">
            <?php if ($verified): ?>
                <p class="mp-text"><?= mp_e(t('mpv_already')) ?></p>
                <p class="mp-actions">
                    <a class="mp-btn mp-btn--primary" href="<?= mp_e($next ?? 'account.php') ?>"><?= mp_e(mpf_tr('v_continue')) ?></a>
                </p>
            <?php else: ?>
                <p class="mp-text"><?= mp_e(mpf_tr('v_need_text', $email)) ?></p>
                <?php if ($pending !== null): ?>
                    <p class="mp-callout"><?= mp_e(mpf_tr('v_sent_at', $email, $fmt($pending['created_at']), $fmt($pending['expires_at']))) ?></p>
                    <p class="mp-actions">
                        <a class="mp-btn mp-btn--primary mp-btn--lg" href="<?= mp_e($checkUrl) ?>"><?= mp_e(mpf_tr('v_check_btn')) ?></a>
                    </p>
                    <p class="mp-hint"><?= mp_e(mpf_tr('v_check_hint')) ?></p>
                    <form method="post" action="mp-verify-email.php" class="mp-inline-form">
                        <?= mp_csrf_field() ?><?= $nextField ?><input type="hidden" name="resend" value="1">
                        <button class="mp-btn" type="submit"><?= mp_e(mpf_tr('v_resend_btn')) ?></button>
                    </form>
                    <p class="mp-hint"><?= mp_e(mpf_tr('v_resend_hint', (int) mp_config()['verify_resend_min'])) ?></p>
                <?php else: ?>
                    <form method="post" action="mp-verify-email.php" class="mp-inline-form">
                        <?= mp_csrf_field() ?><?= $nextField ?><input type="hidden" name="send" value="1">
                        <button class="mp-btn mp-btn--primary mp-btn--lg" type="submit"><?= mp_e(mpf_tr('v_send_btn')) ?></button>
                    </form>
                    <p class="mp-actions"><a class="mp-btn" href="<?= mp_e($checkUrl) ?>"><?= mp_e(mpf_tr('v_check_btn')) ?></a></p>
                    <p class="mp-hint"><?= mp_e(mpf_tr('v_check_hint')) ?></p>
                <?php endif; ?>
            <?php endif; ?>
        </section>
    </div>
<?php mpb_close(); ?>
