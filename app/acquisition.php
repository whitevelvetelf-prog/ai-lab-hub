<?php

declare(strict_types=1);

/**
 * AI LAB HUB — джерело приходу з власної реклами платформи (ref=house-A1 тощо) і з оголошень платформи в Marketplace
 * (ref=mp-free-materials тощо: кнопка «Створити акаунт», app/mp-platform-promo.php).
 *
 * Підключається з app/auth.php: якщо в адресі є ?ref=house-… — зберігаємо в сесії. Коли користувач уперше
 * створює рекламну кампанію чи оголошення, acq_ref_record() записує джерело в acquisition_ref цього запису
 * (і забирає його з сесії — рахується лише перше створення після переходу). Звіт — «Звіти» в адмінці реклами.
 *
 * Реєстрація (register.php, вхід через Google вперше) — acq_signup_record(): рядок у ad_house_signups
 * (user_id, ref_code, creative_id, campaign_id; міграція 2026-11-12). ref у сесії лишається — якщо той самий
 * користувач потім створить кампанію чи оголошення, вони теж зарахуються варіанту.
 */

// Загалом до 20 символів — як колонка acquisition_ref (mp_listings, ad_campaigns).
const ACQ_REF_PATTERN = '/^(?:house-[A-Za-z0-9_-]{1,14}|mp-[A-Za-z0-9_-]{1,17})$/';

function acq_ref_capture(): void
{
    $ref = is_string($_GET['ref'] ?? null) ? (string) $_GET['ref'] : '';
    if ($ref !== '' && preg_match(ACQ_REF_PATTERN, $ref) === 1 && session_status() === PHP_SESSION_ACTIVE) {
        $_SESSION['acq_ref'] = $ref;
    }
}

/** Поточне джерело з сесії або null. */
function acq_ref_current(): ?string
{
    $ref = $_SESSION['acq_ref'] ?? null;

    return is_string($ref) && preg_match(ACQ_REF_PATTERN, $ref) === 1 ? $ref : null;
}

/**
 * Записати джерело в щойно створений запис: $kind = 'campaign' (ad_campaigns) | 'listing' (mp_listings).
 * Лише якщо в сесії є ref і колонка acquisition_ref ще порожня. Помилки (немає колонки) не ламають створення.
 */
function acq_ref_record(PDO $pdo, string $kind, int $id): void
{
    $ref = acq_ref_current();
    if ($ref === null || $id <= 0) {
        return;
    }
    $table = $kind === 'campaign' ? 'ad_campaigns' : 'mp_listings';
    try {
        $pdo->prepare("UPDATE {$table} SET acquisition_ref = :r WHERE id = :id AND acquisition_ref IS NULL")->execute([':r' => $ref, ':id' => $id]);
        unset($_SESSION['acq_ref']);
    } catch (Throwable $e) {
        error_log('[acq] record: ' . $e->getMessage());
    }
}

/** Зарахувати реєстрацію нового користувача варіанту власної реклами (ref із сесії). Помилки не ламають реєстрацію. */
function acq_signup_record(PDO $pdo, int $userId): void
{
    $ref = acq_ref_current();
    if ($ref === null || $userId <= 0) {
        return;
    }
    try {
        $st = $pdo->prepare('SELECT id, campaign_id FROM ad_creatives WHERE ref_code = :r ORDER BY id LIMIT 1');
        $st->execute([':r' => $ref]);
        $cr = $st->fetch(PDO::FETCH_ASSOC) ?: null;
        $pdo->prepare('INSERT IGNORE INTO ad_house_signups (user_id, ref_code, creative_id, campaign_id, created_at) VALUES (:u, :r, :cr, :c, NOW())')
            ->execute([':u' => $userId, ':r' => $ref, ':cr' => $cr !== null ? (int) $cr['id'] : null, ':c' => $cr !== null ? (int) $cr['campaign_id'] : null]);
    } catch (Throwable $e) {
        error_log('[acq] signup: ' . $e->getMessage());
    }
}

/** Скільки реєстрацій принесла реклама з цим ref (0, якщо таблиці ще немає). */
function acq_signups_count(PDO $pdo, string $ref): int
{
    try {
        $st = $pdo->prepare('SELECT COUNT(*) FROM ad_house_signups WHERE ref_code = :r');
        $st->execute([':r' => $ref]);

        return (int) $st->fetchColumn();
    } catch (Throwable $e) {
        return 0;
    }
}

acq_ref_capture();
