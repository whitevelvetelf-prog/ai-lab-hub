<?php

declare(strict_types=1);

/**
 * AI LAB HUB — шар оплати рекламного балансу.
 *
 * Кабінет рекламодавця й баланс працюють лише через інтерфейс PaymentProvider,
 * тож новий провайдер (онлайн-оплата карткою) додається окремим класом без
 * переробки кабінету: promo_payment_provider() повертає активний.
 *
 * Робоча реалізація — ManualBankTransfer: заявка на поповнення
 * (ad_transactions: topup / pending / manual), рекламодавець переказує кошти
 * за реквізитами з унікальним призначенням платежу, адмін підтверджує вручну
 * (кабінет «Реклама: адмін» → «Платежі»), і лише тоді сума йде на баланс.
 *
 * Номери карток і будь-які платіжні дані карток НІКОЛИ не зберігаються.
 */

interface PaymentProvider
{
    /** Ідентифікатор для ad_transactions.provider (manual, wayforpay, liqpay, stripe). */
    public function code(): string;

    /**
     * Створити рахунок / заявку на поповнення. Повертає дані для показу
     * рекламодавцю: id заявки, reference (призначення платежу), а для онлайн-
     * провайдерів — redirect_url на сторінку оплати.
     *
     * @return array{id:int,reference:string,redirect_url:?string}
     */
    public function createTopup(PDO $pdo, int $userId, int $amountKop, string $currency): array;

    /** Поточний статус заявки: pending / confirmed / rejected. */
    public function status(PDO $pdo, int $transactionId): string;

    /**
     * Обробка зворотного виклику провайдера (webhook). Для ручного переказу
     * не використовується. Повертає id підтвердженої заявки або null.
     */
    public function handleCallback(PDO $pdo, array $request): ?int;
}

/** Ручний банківський переказ за реквізитами, підтвердження адміном. */
final class ManualBankTransfer implements PaymentProvider
{
    public function code(): string
    {
        return 'manual';
    }

    public function createTopup(PDO $pdo, int $userId, int $amountKop, string $currency): array
    {
        $pdo->prepare(
            "INSERT INTO ad_transactions (user_id, type, amount, currency, status, method, provider, note)
             VALUES (:u, 'topup', :a, :cur, 'pending', 'manual', 'manual', 'Заявка на поповнення (банківський переказ)')"
        )->execute([':u' => $userId, ':a' => $amountKop, ':cur' => $currency]);
        $id = (int) $pdo->lastInsertId();

        $reference = promo_payment_reference($id);
        $pdo->prepare('UPDATE ad_transactions SET reference = :r WHERE id = :id')
            ->execute([':r' => $reference, ':id' => $id]);

        return ['id' => $id, 'reference' => $reference, 'redirect_url' => null];
    }

    public function status(PDO $pdo, int $transactionId): string
    {
        $st = $pdo->prepare("SELECT status FROM ad_transactions WHERE id = :id AND type = 'topup'");
        $st->execute([':id' => $transactionId]);

        return (string) ($st->fetchColumn() ?: 'rejected');
    }

    public function handleCallback(PDO $pdo, array $request): ?int
    {
        return null;
    }
}

/** Унікальне призначення платежу для заявки (містить ID заявки). */
function promo_payment_reference(int $transactionId): string
{
    return 'AILABHUB-PROMO-' . $transactionId;
}

/** Активний провайдер оплати. Поки що — лише ручний переказ. */
function promo_payment_provider(): PaymentProvider
{
    return new ManualBankTransfer();
}
