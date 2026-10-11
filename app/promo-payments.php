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

/**
 * Базова заглушка онлайн-провайдера. Реальної інтеграції НЕМАЄ: для оплати
 * карткою потрібен мерчант-акаунт, якого поки немає. Будь-який виклик кидає
 * виняток, тож випадково увімкнути «оплату», яка не працює, неможливо.
 *
 * Як додати провайдера, коли з'явиться мерчант:
 *   1. Ключі — у config/promo.php (не в git), напр. 'wayforpay' => ['merchant' => …, 'secret' => …].
 *   2. createTopup(): створити ad_transactions (topup / pending / method='provider',
 *      provider=code()), сформувати рахунок у провайдера, повернути redirect_url
 *      на його сторінку оплати. Картку вводить покупець на сторінці провайдера —
 *      сайт номерів карток НЕ отримує й не зберігає.
 *   3. handleCallback(): перевірити підпис провайдера, знайти заявку за reference,
 *      ідемпотентно підтвердити її (status='confirmed', confirmed_at) і зарахувати
 *      суму на баланс — тією ж транзакцією, що й ручне підтвердження в адмінці
 *      (promo_admin_balance_add у app/promo-admin.php).
 *   4. Публічний endpoint зворотного виклику (напр. public/promo-pay-callback.php)
 *      і перемикання promo_payment_provider() на нового провайдера.
 * Кабінет і баланс переробляти не треба: вони працюють лише через PaymentProvider.
 */
abstract class PromoProviderStub implements PaymentProvider
{
    public function createTopup(PDO $pdo, int $userId, int $amountKop, string $currency): array
    {
        throw new LogicException(static::class . ': онлайн-оплата не підключена (немає мерчант-акаунта).');
    }

    public function status(PDO $pdo, int $transactionId): string
    {
        throw new LogicException(static::class . ': онлайн-оплата не підключена.');
    }

    public function handleCallback(PDO $pdo, array $request): ?int
    {
        throw new LogicException(static::class . ': онлайн-оплата не підключена.');
    }
}

/**
 * WayForPay (Україна). Потрібно: merchantAccount, merchantSecretKey, merchantDomainName;
 * підпис запитів і відповіді — HMAC-MD5 за полями з документації; serviceUrl для callback;
 * відповідь на callback — підписаний JSON «accept».
 */
final class WayForPayProvider extends PromoProviderStub
{
    public function code(): string
    {
        return 'wayforpay';
    }
}

/**
 * LiqPay (ПриватБанк). Потрібно: public_key, private_key; data (base64 JSON) і
 * signature = base64(sha1(private_key . data . private_key)); server_url для callback,
 * перевірка підпису callback тим самим способом; action=pay, currency=UAH.
 */
final class LiqPayProvider extends PromoProviderStub
{
    public function code(): string
    {
        return 'liqpay';
    }
}

/**
 * Stripe (міжнародні картки). Потрібно: secret key (sk_live_…), webhook signing
 * secret (whsec_…); Checkout Session з success_url / cancel_url; webhook
 * checkout.session.completed з перевіркою заголовка Stripe-Signature.
 * Підтримку валюти UAH і країни мерчанта треба перевірити окремо.
 */
final class StripeProvider extends PromoProviderStub
{
    public function code(): string
    {
        return 'stripe';
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
