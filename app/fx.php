<?php

declare(strict_types=1);

/**
 * AI LAB HUB — курси валют для поповнення рекламного балансу (баланс і ціни — лише в USD).
 *
 *   * Дозволені валюти поповнення — FX_TOPUP_CURRENCIES (валюта => джерело курсу). Зараз лише UAH:
 *     банка monobank приймає тільки гривні. Інші валюти відхиляються.
 *   * UAH — офіційний курс НБУ (bank.gov.ua), гривень за 1 USD. Береться лише на сервері,
 *     ніколи з запиту клієнта.
 *   * Кеш — таблиця fx_rates: свіжий (до FX_CACHE_SECONDS) береться без запиту; НБУ не відповів —
 *     кешований, якщо йому не більше FX_MAX_AGE_SECONDS; інакше null (оплата тимчасово недоступна) і запис у лог.
 *   * Курс — рядок DECIMAL(12,6) («44.852600») і ціле в мільйонних (44852600). Жодного float.
 *   * Конвертація в центи — завжди вниз (не зараховуємо більше, ніж сплачено).
 */

const FX_TOPUP_CURRENCIES = ['UAH' => 'NBU'];
const FX_CACHE_SECONDS = 3600;
const FX_MAX_AGE_SECONDS = 86400;
const FX_NBU_URL = 'https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?valcode=USD&json';

/** Валюта дозволена для поповнення? */
function fx_currency_allowed(string $currency): bool
{
    return isset(FX_TOPUP_CURRENCIES[$currency]);
}

/**
 * Курс валюти до USD (одиниць валюти за 1 USD) або null, якщо курсу немає.
 *
 * @param callable|null $fetch для тестів: fn(string $currency): ?array{rate:string,date:string}
 * @return array{rate:string,micro:int,date:string,source:string}|null
 */
function fx_usd_rate(PDO $pdo, string $currency, ?callable $fetch = null): ?array
{
    if (!fx_currency_allowed($currency)) {
        return null;
    }
    $source = FX_TOPUP_CURRENCIES[$currency];
    $cached = null;
    try {
        $st = $pdo->prepare('SELECT rate, rate_date, source, TIMESTAMPDIFF(SECOND, fetched_at, NOW()) AS age FROM fx_rates WHERE currency = :c');
        $st->execute([':c' => $currency]);
        $cached = $st->fetch() ?: null;
    } catch (Throwable $e) {
        error_log('[fx] cache read: ' . $e->getMessage());

        return null;   // без таблиці кешу курсу немає — не вгадуємо
    }
    if ($cached !== null && (int) $cached['age'] < FX_CACHE_SECONDS) {
        return fx_rate_row($cached);
    }

    $fetch ??= $GLOBALS['fx_fetch'] ?? null;   // тести підміняють джерело курсу
    $fresh = is_callable($fetch) ? $fetch($currency) : fx_fetch_nbu();
    if ($fresh !== null && fx_rate_micro($fresh['rate']) > 0) {
        $pdo->prepare(
            'INSERT INTO fx_rates (currency, rate, rate_date, source, fetched_at) VALUES (:c, :r, :d, :s, NOW())
             ON DUPLICATE KEY UPDATE rate = VALUES(rate), rate_date = VALUES(rate_date), source = VALUES(source), fetched_at = VALUES(fetched_at)'
        )->execute([':c' => $currency, ':r' => $fresh['rate'], ':d' => $fresh['date'], ':s' => $source]);

        return fx_rate_row(['rate' => $fresh['rate'], 'rate_date' => $fresh['date'], 'source' => $source]);
    }

    if ($cached !== null && (int) $cached['age'] < FX_MAX_AGE_SECONDS) {
        error_log('[fx] ' . $source . ' недоступний, використано кешований курс ' . $currency . ' віком ' . (int) $cached['age'] . ' с');

        return fx_rate_row($cached);
    }
    error_log('[fx] курс ' . $currency . ' недоступний (' . $source . ' не відповів, кешу немає або він старший за ' . FX_MAX_AGE_SECONDS . ' с) — поповнення тимчасово недоступне');

    return null;
}

/** @return array{rate:string,micro:int,date:string,source:string} */
function fx_rate_row(array $r): array
{
    $micro = fx_rate_micro((string) $r['rate']);

    return ['rate' => fx_rate_string($micro), 'micro' => $micro, 'date' => (string) $r['rate_date'], 'source' => (string) $r['source']];
}

/**
 * Офіційний курс НБУ гривні до долара на сьогодні.
 *
 * @return array{rate:string,date:string}|null
 */
function fx_fetch_nbu(): ?array
{
    if (!function_exists('curl_init')) {
        return null;
    }
    $ch = curl_init(FX_NBU_URL);
    curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_TIMEOUT => 6, CURLOPT_CONNECTTIMEOUT => 4,
        CURLOPT_USERAGENT => 'AI LAB HUB fx', CURLOPT_FOLLOWLOCATION => false]);
    $body = curl_exec($ch);
    $code = (int) curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);
    if (!is_string($body) || $code !== 200) {
        error_log('[fx] NBU HTTP ' . $code);

        return null;
    }
    // Курс читаємо з тексту відповіді (не через json_decode — той дав би float).
    if (!preg_match('/"cc"\s*:\s*"USD"/', $body)
        || !preg_match('/"rate"\s*:\s*(\d{1,6}(?:\.\d{1,6})?)\b/', $body, $r)
        || !preg_match('/"exchangedate"\s*:\s*"(\d{2})\.(\d{2})\.(\d{4})"/', $body, $d)) {
        error_log('[fx] NBU: неочікувана відповідь');

        return null;
    }

    return ['rate' => $r[1], 'date' => $d[3] . '-' . $d[2] . '-' . $d[1]];
}

/** «44.8526» → 44852600 (мільйонні). Некоректне — 0. */
function fx_rate_micro(string $rate): int
{
    if (!preg_match('/^(\d{1,6})(?:\.(\d{1,6}))?$/', trim($rate), $m)) {
        return 0;
    }

    return (int) $m[1] * 1000000 + (int) str_pad($m[2] ?? '', 6, '0');
}

/** 44852600 → «44.852600» (для DECIMAL(12,6)). */
function fx_rate_string(int $micro): string
{
    return intdiv($micro, 1000000) . '.' . sprintf('%06d', $micro % 1000000);
}

/** Мінімальні одиниці валюти (копійки) → центи USD за курсом, округлення вниз. */
function fx_to_usd_cents(int $minor, int $rateMicro): int
{
    if ($minor <= 0 || $rateMicro <= 0) {
        return 0;
    }

    return intdiv($minor * 1000000, $rateMicro);
}

/** Центи USD → мінімальні одиниці валюти за курсом, округлення вгору (скільки сплатити, щоб вистачило). */
function fx_from_usd_cents(int $cents, int $rateMicro): int
{
    if ($cents <= 0 || $rateMicro <= 0) {
        return 0;
    }

    return intdiv($cents * $rateMicro + 999999, 1000000);
}
