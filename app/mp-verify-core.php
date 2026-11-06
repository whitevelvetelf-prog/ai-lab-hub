<?php

declare(strict_types=1);

/**
 * AI LAB HUB — єдине джерело істини «пошту підтверджено» (без залежностей, лише PDO).
 *
 * Таблиця mp_email_verifications: «підтверджено» = є рядок із verified_at IS NOT NULL для цього user_id,
 * у якому email збігається з поточним users.email (без урахування регістру й пробілів по краях).
 * Зміна email у акаунті скасовує підтвердження (старі рядки вже не збігаються).
 * Вхід через Google з підтвердженою Google адресою, що збігається з email акаунта, записує такий самий
 * рядок (mpv_mark_verified) — Marketplace не просить підтвердити ту саму пошту вдруге.
 */

/** Нормалізація email для порівняння: обрізати пробіли, нижній регістр. */
function mpv_norm_email(string $email): string
{
    return mb_strtolower(trim($email));
}

/** Дата (DATETIME рядком) першого підтвердження ПОТОЧНОГО email користувача або null. */
function mpv_verified_at(PDO $pdo, int $userId): ?string
{
    $stmt = $pdo->prepare(
        'SELECT MIN(v.verified_at) FROM mp_email_verifications v JOIN users u ON u.id = v.user_id
         WHERE v.user_id = :u AND v.verified_at IS NOT NULL AND LOWER(TRIM(v.email)) = LOWER(TRIM(u.email))'
    );
    $stmt->execute([':u' => $userId]);
    $v = $stmt->fetchColumn();

    return $v === false || $v === null ? null : (string) $v;
}

/**
 * Записує «підтверджено» без листа — коли адресу вже підтвердив довірений провайдер (Google, email_verified).
 * Лише якщо $email збігається з поточним email акаунта і підтвердження ще немає. Повертає true, якщо записано.
 */
function mpv_mark_verified(PDO $pdo, int $userId, string $email): bool
{
    try {
        $u = $pdo->prepare('SELECT email FROM users WHERE id = :id');
        $u->execute([':id' => $userId]);
        $current = $u->fetchColumn();
        if ($current === false || mpv_norm_email((string) $current) !== mpv_norm_email($email) || mb_strlen((string) $current) > 190) {
            return false;
        }
        if (mpv_verified_at($pdo, $userId) !== null) {
            return false;
        }
        $ins = $pdo->prepare(
            'INSERT INTO mp_email_verifications (user_id, email, token_hash, expires_at, verified_at)
             VALUES (:u, :e, :h, NOW(), NOW())'
        );
        // token_hash — випадкове значення, якому не відповідає жоден лист (рядок не можна «використати»).
        $ins->execute([':u' => $userId, ':e' => trim((string) $current), ':h' => hash('sha256', 'provider:' . bin2hex(random_bytes(32)))]);

        return true;
    } catch (Throwable $e) {
        error_log('[marketplace] mpv_mark_verified failed: ' . $e->getMessage());

        return false;
    }
}
