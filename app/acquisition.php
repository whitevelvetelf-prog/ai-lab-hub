<?php

declare(strict_types=1);

/**
 * AI LAB HUB — джерело приходу з власної реклами платформи (ref=house-A1 тощо).
 *
 * Підключається з app/auth.php: якщо в адресі є ?ref=house-… — зберігаємо в сесії. Коли користувач уперше
 * створює рекламну кампанію чи оголошення, acq_ref_record() записує джерело в acquisition_ref цього запису
 * (і забирає його з сесії — рахується лише перше створення після переходу). Звіт — «Звіти» в адмінці реклами.
 */

const ACQ_REF_PATTERN = '/^house-[A-Za-z0-9_-]{1,14}$/';

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

acq_ref_capture();
