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
require_once __DIR__ . '/mp-verify-core.php';   // mpv_verified_at(), mpv_mark_verified() — єдине джерело істини
require_once __DIR__ . '/mp-flow-i18n.php';

/** Чи може користувач виконувати дії, що вимагають підтвердженого email (staff — завжди). */
function mpv_is_verified(PDO $pdo, int $userId): bool
{
    return mpb_is_staff() || mpv_verified_at($pdo, $userId) !== null;
}

/**
 * Останній ДІЙСНИЙ (не прострочений, не використаний) лист для поточного email або null.
 *
 * @return array{id:int,created_at:string,expires_at:string}|null
 */
function mpv_pending(PDO $pdo, int $userId): ?array
{
    $st = $pdo->prepare(
        'SELECT v.id, v.created_at, v.expires_at FROM mp_email_verifications v JOIN users u ON u.id = v.user_id
         WHERE v.user_id = :u AND v.verified_at IS NULL AND v.expires_at > NOW() AND LOWER(TRIM(v.email)) = LOWER(TRIM(u.email))
         ORDER BY v.id DESC LIMIT 1'
    );
    $st->execute([':u' => $userId]);
    $r = $st->fetch(PDO::FETCH_ASSOC);

    return $r === false ? null : ['id' => (int) $r['id'], 'created_at' => (string) $r['created_at'], 'expires_at' => (string) $r['expires_at']];
}

/** Адреса сторінки «Підтвердьте пошту» з поверненням на $next. */
function mpv_page_url(?string $next): string
{
    $next = $next !== null ? auth_safe_next($next) : null;

    return 'mp-verify-email.php' . ($next !== null ? '?next=' . rawurlencode($next) : '');
}

/** HTML блоку «Підтвердьте email» (для JSON-відповідей і старих викликів): посилання на сторінку підтвердження. */
function mpv_block_html(?string $next = null): string
{
    return '<p class="mp-text">' . mp_e(t('mpv_block_text')) . '</p>'
        . '<p class="mp-actions"><a class="mp-btn mp-btn--primary" href="' . mp_e(mpv_page_url($next ?? auth_current_next())) . '">'
        . mp_e(mpf_tr('v_cabinet_btn')) . '</a></p>';
}

/**
 * Пошта не підтверджена → на сторінку «Підтвердьте пошту» ДО показу форми, з поверненням на поточну сторінку
 * (після підтвердження користувач повертається до форми). Лише для залогінених (гостя раніше відсікає mpb_require_login).
 */
function mpv_require_verified(PDO $pdo, int $userId, ?string $next = null): void
{
    if (mpv_is_verified($pdo, $userId)) {
        return;
    }
    header('Location: ' . mpv_page_url($next ?? auth_current_next()), true, 303);
    header('Cache-Control: no-store');
    exit;
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
 * Поки є дійсне (не прострочене й не використане) посилання, новий лист НЕ надсилається ('pending') —
 * крім явного «Надіслати ще раз» ($force). Нове посилання не скасовує попередні: будь-яке дійсне спрацює.
 * Ліміти: не частіше 1 листа на verify_resend_min хв (на користувача) і verify_max_per_day на добу (на користувача й email).
 * $next — внутрішня сторінка, куди повернути після підтвердження (зберігається з токеном).
 *
 * @return string sent | pending | too_soon | daily | rate | already | fail
 */
function mpv_send(PDO $pdo, int $userId, ?string $next = null, bool $force = false): string
{
    $cfg = mp_config();
    $u = $pdo->prepare('SELECT email FROM users WHERE id = :id');
    $u->execute([':id' => $userId]);
    $email = $u->fetchColumn();
    $email = $email === false ? '' : trim((string) $email);
    if ($email === '' || mb_strlen($email) > 190) {
        return 'fail';
    }
    if (mpv_is_verified($pdo, $userId)) {
        return 'already';
    }
    if (!$force && mpv_pending($pdo, $userId) !== null) {
        return 'pending';
    }

    // Посилання будується лише з site_url. Немає site_url (і це не 'log') — лист не надсилаємо,
    // пишемо помилку в лог, користувач бачить нейтральне «не вдалося надіслати».
    $base = mpv_site_url();
    $logOnly = (string) $cfg['mail_transport'] === 'log';
    if ($base === null && !$logOnly) {
        error_log("[marketplace] verification email NOT sent (user {$userId}): config 'site_url' is empty or invalid");

        return 'fail';
    }
    $next = $next !== null ? auth_safe_next($next) : null;

    // Ліміти + запис — під блокуванням користувача (паралельні запити не обходять «1 лист на 2 хв» і «5 на добу»).
    $lock = 'mp_mail_' . $userId;
    if (!mpb_lock($pdo, $lock)) {
        return 'too_soon';
    }
    $token = bin2hex(random_bytes(32));
    $ttl = max(1, (int) $cfg['verify_ttl_hours']);
    try {
        $soon = $pdo->prepare('SELECT COUNT(*) FROM mp_email_verifications WHERE user_id = :u AND verified_at IS NULL AND created_at > (NOW() - INTERVAL ' . max(1, (int) $cfg['verify_resend_min']) . ' MINUTE)');
        $soon->execute([':u' => $userId]);
        if ((int) $soon->fetchColumn() > 0) {
            return 'too_soon';
        }
        // Добовий ліміт — на пару (користувач, email): після зміни email лічильник починається заново.
        $day = $pdo->prepare('SELECT COUNT(*) FROM mp_email_verifications WHERE user_id = :u AND LOWER(TRIM(email)) = LOWER(:e) AND verified_at IS NULL AND created_at > (NOW() - INTERVAL 1 DAY)');
        $day->execute([':u' => $userId, ':e' => $email]);
        if ((int) $day->fetchColumn() >= (int) $cfg['verify_max_per_day']) {
            return 'daily';
        }

        // IP-ліміт листів (другий шар); не витрачаємо, якщо ліміт перевищено
        if (!mpb_ip_hit($pdo, 'mail', (int) $cfg['ip_limit_mail'])) {
            return 'rate';
        }

        $hasNext = mpv_has_next_column($pdo);
        $ins = $pdo->prepare(
            'INSERT INTO mp_email_verifications (user_id, email, token_hash, expires_at' . ($hasNext ? ', next_path' : '') . ')'
            . " VALUES (:u, :e, :h, NOW() + INTERVAL $ttl HOUR" . ($hasNext ? ', :n' : '') . ')'
        );
        $params = [':u' => $userId, ':e' => $email, ':h' => hash('sha256', $token)];
        if ($hasNext) {
            $params[':n'] = $next;
        }
        $ins->execute($params);
        $rowId = (int) $pdo->lastInsertId();
    } finally {
        mpb_unlock($pdo, $lock);
    }

    $link = ($base ?? '') . '/mp-verify.php?token=' . $token;   // 'log' без site_url: відносне посилання
    $subject = t('mpv_mail_subject');
    $text = t('mpv_mail_intro') . "\n" . $link . "\n\n" . sprintf(t('mpv_mail_expiry'), $ttl) . "\n" . t('mpv_mail_ignore');
    $html = '<p>' . mp_e(t('mpv_mail_intro')) . '</p><p><a href="' . mp_e($link) . '">' . mp_e(t('mpv_mail_button')) . '</a></p>'
        . '<p>' . mp_e($link) . '</p><p>' . mp_e(sprintf(t('mpv_mail_expiry'), $ttl)) . ' ' . mp_e(t('mpv_mail_ignore')) . '</p>';

    if (!mpv_deliver($email, $subject, $html, $text)) {
        // не вдалося надіслати — лист не «витрачає» ліміт
        $pdo->prepare('DELETE FROM mp_email_verifications WHERE id = :id AND verified_at IS NULL')->execute([':id' => $rowId]);

        return 'fail';
    }

    return 'sent';
}

/** Чи застосовано міграцію 2026-11-06 (колонка next_path). */
function mpv_has_next_column(PDO $pdo): bool
{
    static $has = null;
    if ($has === null) {
        try {
            $pdo->query('SELECT next_path FROM mp_email_verifications LIMIT 0');
            $has = true;
        } catch (Throwable $e) {
            $has = false;
        }
    }

    return $has;
}

/**
 * Стан токена БЕЗ його витрачання (для GET-сторінки з кнопкою). Сесія не потрібна: токен прив'язаний до user_id.
 *
 * @return array{status:string,id:int,user_id:int,next:?string} status: ok | invalid | expired | used | changed
 */
function mpv_check(PDO $pdo, string $token): array
{
    $none = ['status' => 'invalid', 'id' => 0, 'user_id' => 0, 'next' => null];
    if (preg_match('/^[a-f0-9]{64}$/', $token) !== 1) {
        return $none;
    }
    $stmt = $pdo->prepare(
        'SELECT v.*, (v.expires_at <= NOW()) AS expired, u.email AS current_email
         FROM mp_email_verifications v LEFT JOIN users u ON u.id = v.user_id WHERE v.token_hash = :h LIMIT 1'
    );
    $stmt->execute([':h' => hash('sha256', $token)]);
    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    if ($row === false) {
        return $none;
    }
    $res = ['status' => 'ok', 'id' => (int) $row['id'], 'user_id' => (int) $row['user_id'], 'next' => auth_safe_next((string) ($row['next_path'] ?? ''))];
    if ($row['verified_at'] !== null) {
        $res['status'] = 'used';
    } elseif ((int) $row['expired'] === 1) {
        $res['status'] = 'expired';
    } elseif ($row['current_email'] === null || mpv_norm_email((string) $row['current_email']) !== mpv_norm_email((string) $row['email'])) {
        $res['status'] = 'changed';   // email змінено після надсилання листа
    }

    return $res;
}

/**
 * Підтвердження за токеном (POST із mp-verify.php; одноразове). Працює без входу: успіх записується в БД
 * для user_id токена, незалежно від поточної сесії.
 *
 * @return array{status:string,id:int,user_id:int,next:?string} status: ok | invalid | expired | used | changed
 */
function mpv_confirm(PDO $pdo, string $token): array
{
    $c = mpv_check($pdo, $token);
    if ($c['status'] !== 'ok') {
        return $c;
    }
    // Одноразовість: UPDATE лише поки verified_at ще NULL і термін не минув.
    $upd = $pdo->prepare('UPDATE mp_email_verifications SET verified_at = NOW() WHERE id = :id AND verified_at IS NULL AND expires_at > NOW()');
    $upd->execute([':id' => $c['id']]);
    if ($upd->rowCount() !== 1) {
        $c['status'] = 'used';
    }

    return $c;
}
