<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace, етап 5: підтвердження email (лише для дій у Marketplace).
 *
 * Таблиця mp_email_verifications (migration ...-marketplace-email-verification.sql). Таблицю users не
 * змінюємо: «підтверджений» = є запис із verified_at IS NOT NULL, у якому email збігається з поточним
 * users.email (зміна email робить підтвердження недійсним). Employee/admin звільнені.
 * Підключати після app/auth.php і app/translations.php:
 *   require_once __DIR__ . '/../app/marketplace-email.php';   // підключає marketplace-board.php і mailer.php
 */

require_once __DIR__ . '/marketplace-board.php';
require_once __DIR__ . '/mailer.php';

/** Дата (DATETIME рядком) першого підтвердження ПОТОЧНОГО email користувача або null. */
function mpv_verified_at(PDO $pdo, int $userId): ?string
{
    $stmt = $pdo->prepare(
        'SELECT MIN(v.verified_at) FROM mp_email_verifications v JOIN users u ON u.id = v.user_id
         WHERE v.user_id = :u AND v.verified_at IS NOT NULL AND v.email = u.email'
    );
    $stmt->execute([':u' => $userId]);
    $v = $stmt->fetchColumn();

    return $v === false || $v === null ? null : (string) $v;
}

/** Чи може користувач виконувати дії, що вимагають підтвердженого email (staff — завжди). */
function mpv_is_verified(PDO $pdo, int $userId): bool
{
    return mpb_is_staff() || mpv_verified_at($pdo, $userId) !== null;
}

/** HTML блоку «Підтвердьте email» з кнопкою надсилання листа. */
function mpv_block_html(): string
{
    return '<p class="mp-text">' . mp_e(t('mpv_block_text')) . '</p>'
        . '<form method="post" action="mp-verify-email.php" class="mp-inline-form">' . mp_csrf_field()
        . '<button class="mp-btn mp-btn--primary" type="submit">' . mp_e(t('mpv_send_btn')) . '</button></form>';
}

/** Сторінка-блок для HTML-дій; лише для залогінених (гостя раніше відсікає mpb_require_login). */
function mpv_require_verified(PDO $pdo, int $userId): void
{
    if (!mpv_is_verified($pdo, $userId)) {
        mpb_message_page(403, t('mpv_block_title'), mpv_block_html(), 'marketplace.php');
    }
}

/**
 * Абсолютна адреса сайту для посилань у листах — ЛИШЕ з config 'site_url' (http/https, без слеша в кінці).
 * Заголовок Host не використовується ніде (захист від підміни домену в листі). Порожньо/некоректно → null.
 */
function mpv_site_url(): ?string
{
    $cfg = rtrim(trim((string) mp_config()['site_url']), '/');

    return preg_match('#^https?://[A-Za-z0-9.\-]+(?::\d{1,5})?(?:/[A-Za-z0-9._~/\-]*)?$#', $cfg) === 1 ? $cfg : null;
}

/** Відправка листа: 'log' → storage/marketplace-mail.log (без відправки), інакше send_mail() (PHP mail()). */
function mpv_deliver(string $to, string $subject, string $html, string $text): bool
{
    if ((string) mp_config()['mail_transport'] === 'log') {
        $dir = __DIR__ . '/../storage';
        if (!is_dir($dir)) {
            @mkdir($dir, 0775, true);
        }
        $entry = sprintf("[%s] To: %s | Subject: %s\n%s\n%s\n\n", date('Y-m-d H:i:s'), $to, $subject, str_repeat('-', 70), $text);

        return @file_put_contents($dir . '/marketplace-mail.log', $entry, FILE_APPEND | LOCK_EX) !== false;
    }

    return send_mail($to, $subject, $html, $text);
}

/**
 * Надсилає користувачу лист підтвердження на його поточний email.
 * Ліміти: не частіше 1 листа на verify_resend_min хв (на користувача) і verify_max_per_day на добу (на користувача й email).
 *
 * @return string sent | too_soon | daily | already | fail
 */
function mpv_send(PDO $pdo, int $userId): string
{
    $cfg = mp_config();
    $u = $pdo->prepare('SELECT email FROM users WHERE id = :id');
    $u->execute([':id' => $userId]);
    $email = $u->fetchColumn();
    if ($email === false || $email === '' || mb_strlen((string) $email) > 190) {
        return 'fail';
    }
    if (mpv_is_verified($pdo, $userId)) {
        return 'already';
    }

    // Посилання будується лише з site_url. Немає site_url (і це не 'log') — лист не надсилаємо,
    // пишемо помилку в лог, користувач бачить нейтральне «не вдалося надіслати».
    $base = mpv_site_url();
    $logOnly = (string) $cfg['mail_transport'] === 'log';
    if ($base === null && !$logOnly) {
        error_log("[marketplace] verification email NOT sent (user {$userId}): config 'site_url' is empty or invalid");

        return 'fail';
    }

    // Ліміти + запис — під блокуванням користувача (паралельні запити не обходять «1 лист на 2 хв» і «5 на добу»).
    $lock = 'mp_mail_' . $userId;
    if (!mpb_lock($pdo, $lock)) {
        return 'too_soon';
    }
    $token = bin2hex(random_bytes(32));
    $ttl = max(1, (int) $cfg['verify_ttl_hours']);
    try {
        $soon = $pdo->prepare('SELECT COUNT(*) FROM mp_email_verifications WHERE user_id = :u AND created_at > (NOW() - INTERVAL ' . max(1, (int) $cfg['verify_resend_min']) . ' MINUTE)');
        $soon->execute([':u' => $userId]);
        if ((int) $soon->fetchColumn() > 0) {
            return 'too_soon';
        }
        // Добовий ліміт — на пару (користувач, email): після зміни email лічильник починається заново.
        $day = $pdo->prepare('SELECT COUNT(*) FROM mp_email_verifications WHERE user_id = :u AND email = :e AND created_at > (NOW() - INTERVAL 1 DAY)');
        $day->execute([':u' => $userId, ':e' => (string) $email]);
        if ((int) $day->fetchColumn() >= (int) $cfg['verify_max_per_day']) {
            return 'daily';
        }

        $ins = $pdo->prepare(
            "INSERT INTO mp_email_verifications (user_id, email, token_hash, expires_at) VALUES (:u, :e, :h, NOW() + INTERVAL $ttl HOUR)"
        );
        $ins->execute([':u' => $userId, ':e' => (string) $email, ':h' => hash('sha256', $token)]);
        $rowId = (int) $pdo->lastInsertId();
    } finally {
        mpb_unlock($pdo, $lock);
    }

    $link = ($base ?? '') . '/mp-verify.php?token=' . $token;   // 'log' без site_url: відносне посилання
    $subject = t('mpv_mail_subject');
    $text = t('mpv_mail_intro') . "\n" . $link . "\n\n" . sprintf(t('mpv_mail_expiry'), $ttl) . "\n" . t('mpv_mail_ignore');
    $html = '<p>' . mp_e(t('mpv_mail_intro')) . '</p><p><a href="' . mp_e($link) . '">' . mp_e(t('mpv_mail_button')) . '</a></p>'
        . '<p>' . mp_e($link) . '</p><p>' . mp_e(sprintf(t('mpv_mail_expiry'), $ttl)) . ' ' . mp_e(t('mpv_mail_ignore')) . '</p>';

    if (!mpv_deliver((string) $email, $subject, $html, $text)) {
        // не вдалося надіслати — лист не «витрачає» ліміт
        $pdo->prepare('DELETE FROM mp_email_verifications WHERE id = :id')->execute([':id' => $rowId]);

        return 'fail';
    }

    return 'sent';
}

/**
 * Стан токена БЕЗ його витрачання (для GET-сторінки з кнопкою).
 *
 * @return array{status:string,id:int} status: ok | invalid | expired | used | changed
 */
function mpv_check(PDO $pdo, string $token): array
{
    if (preg_match('/^[a-f0-9]{64}$/', $token) !== 1) {
        return ['status' => 'invalid', 'id' => 0];
    }
    $stmt = $pdo->prepare(
        'SELECT v.id, v.email, v.verified_at, (v.expires_at <= NOW()) AS expired, u.email AS current_email
         FROM mp_email_verifications v LEFT JOIN users u ON u.id = v.user_id WHERE v.token_hash = :h LIMIT 1'
    );
    $stmt->execute([':h' => hash('sha256', $token)]);
    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    if ($row === false) {
        return ['status' => 'invalid', 'id' => 0];
    }
    $id = (int) $row['id'];
    if ($row['verified_at'] !== null) {
        return ['status' => 'used', 'id' => $id];
    }
    if ((int) $row['expired'] === 1) {
        return ['status' => 'expired', 'id' => $id];
    }
    if ($row['current_email'] === null || strcasecmp((string) $row['current_email'], (string) $row['email']) !== 0) {
        return ['status' => 'changed', 'id' => $id];   // email змінено після надсилання листа
    }

    return ['status' => 'ok', 'id' => $id];
}

/**
 * Підтвердження за токеном (виконується лише POST-ом із mp-verify.php; одноразове).
 *
 * @return string ok | invalid | expired | used | changed
 */
function mpv_confirm(PDO $pdo, string $token): string
{
    $c = mpv_check($pdo, $token);
    if ($c['status'] !== 'ok') {
        return $c['status'];
    }
    // Одноразовість: UPDATE лише поки verified_at ще NULL і термін не минув.
    $upd = $pdo->prepare('UPDATE mp_email_verifications SET verified_at = NOW() WHERE id = :id AND verified_at IS NULL AND expires_at > NOW()');
    $upd->execute([':id' => $c['id']]);

    return $upd->rowCount() === 1 ? 'ok' : 'used';
}
