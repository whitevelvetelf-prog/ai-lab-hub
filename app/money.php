<?php

declare(strict_types=1);

/**
 * AI LAB HUB — єдине форматування грошей.
 *
 * Суми скрізь — цілі числа в мінімальних одиницях (центи, копійки), без float і під час виведення.
 *   USD: «10,00 $» (UA) / «$10.00» (EN)
 *   UAH: «1 000,00 ₴» (UA) / «₴1,000.00» (EN)
 *   інші: «10,00 EUR» / «10.00 EUR»
 * Мова — явна ($lang) або мова реклами (promo_lang()), інакше українська.
 */

function formatMoney(int|string|null $minor, string $currency, ?string $lang = null): string
{
    $minor = (int) $minor;
    $lang ??= function_exists('promo_lang') ? promo_lang() : 'uk';
    $en = $lang === 'en';
    $abs = abs($minor);
    $num = number_format(intdiv($abs, 100), 0, '', $en ? ',' : ' ') . ($en ? '.' : ',') . sprintf('%02d', $abs % 100);
    $sign = $minor < 0 ? '−' : '';
    $symbol = ['USD' => '$', 'UAH' => '₴'][$currency] ?? null;

    if ($symbol === null) {
        return $sign . $num . ' ' . $currency;
    }

    return $en ? $sign . $symbol . $num : $sign . $num . ' ' . $symbol;
}

/** Курс (рядок DECIMAL, напр. «44.852600») для показу: «44,8526» (UA) / «44.8526» (EN), без зайвих нулів. */
function formatRate(string $rate, ?string $lang = null): string
{
    $lang ??= function_exists('promo_lang') ? promo_lang() : 'uk';
    [$whole, $frac] = array_pad(explode('.', $rate, 2), 2, '');
    $frac = rtrim($frac, '0');
    if (strlen($frac) < 2) {
        $frac = str_pad($frac, 2, '0');
    }

    $whole = ltrim($whole, '0');

    return ($whole === '' ? '0' : $whole) . ($lang === 'en' ? '.' : ',') . $frac;
}
