<?php

declare(strict_types=1);

/**
 * AI LAB HUB — оголошення самої платформи в Marketplace (запрошення зареєструватися, «Реклама на сайті» тощо).
 *
 * Це звичайні оголошення дошки (post_form='ad') продавця з is_platform = 1, без контактів і фото.
 * Замість «Показати контакт» сторінка (app/mpb-offer.php) показує одну кнопку на сторінку НАШОГО сайту з
 * delivery_type = 'link' і delivery_url:
 *   • гість — «Створити акаунт» (UA) / «Create an account» (EN) → delivery_url (/register.php?ref=mp-…);
 *   • той, хто увійшов, — «Відкрити кабінет» → кабінет (для ref=mp-advertise — вкладка «Створити кампанію»).
 * Адреса перевіряється без HTTP-запиту тим самим правилом, що й власна реклама (promo_internal_url_check:
 * відносний шлях або https://<наш домен>/…, сам шлях — з config/promo-internal.php). Сторонні адреси, «//…»,
 * javascript: і шляхи не з переліку відхиляються — кнопки тоді немає. Абсолютна адреса нашого домену
 * виводиться відносною (локальна копія сайту веде на себе, а не на живий сайт).
 *
 * Сторінки таких оголошень — noindex, follow. Схема БД не змінюється.
 */

require_once __DIR__ . '/promo-internal.php';

/** Сторінки, на які може вести кнопка оголошення платформи (підмножина promo_internal_paths). */
const MPP_CTA_PATHS = ['/register.php', '/advertise.php', '/promo-rules.php', '/marketplace-post.php', '/listing-post.php', '/assets.php', '/marketplace-solutions.php'];

/**
 * Відносна адреса для кнопки або null, якщо адреса недозволена.
 * Приймає /register.php?ref=mp-… або https://ailabhub-directory.com/register.php?ref=mp-…
 */
function mpp_cta_href(string $url): ?string
{
    $url = trim($url);
    $chk = promo_internal_url_check($url);
    if (!$chk['ok'] || !in_array((string) $chk['path'], MPP_CTA_PATHS, true)) {
        return null;
    }
    if (promo_url_is_absolute_http($url)) {
        $p = parse_url($url);
        $url = ($p['path'] ?? '/') . (isset($p['query']) ? '?' . $p['query'] : '') . (isset($p['fragment']) ? '#' . $p['fragment'] : '');
    }

    return $url;
}

/** Параметр ref адреси ('' — немає). */
function mpp_ref_of(string $url): string
{
    $q = (string) parse_url($url, PHP_URL_QUERY);
    parse_str($q, $params);

    return is_string($params['ref'] ?? null) ? (string) $params['ref'] : '';
}

/**
 * Дані оголошення платформи для сторінки або null (звичайне оголошення користувача / недозволена адреса).
 *
 * @return array{href:string,label:string,hint:string,features:string,for_whom:string}|null
 */
function mpp_listing_cta(PDO $pdo, int $listingId, string $lang): ?array
{
    $st = $pdo->prepare(
        "SELECT l.delivery_type, l.delivery_url, l.source_lang,
                COALESCE(NULLIF(tc.features, ''), ts.features) AS features,
                COALESCE(NULLIF(tc.for_whom, ''), ts.for_whom) AS for_whom
         FROM mp_listings l
         JOIN mp_sellers s ON s.id = l.seller_id AND s.is_platform = 1
         LEFT JOIN mp_listing_translations tc ON tc.listing_id = l.id AND tc.lang = :lang
         LEFT JOIN mp_listing_translations ts ON ts.listing_id = l.id AND ts.lang = l.source_lang
         WHERE l.id = :id AND l.post_form = 'ad'"
    );
    $st->execute([':id' => $listingId, ':lang' => $lang]);
    $r = $st->fetch(PDO::FETCH_ASSOC);
    if ($r === false || (string) $r['delivery_type'] !== 'link') {
        return null;
    }
    $href = mpp_cta_href((string) ($r['delivery_url'] ?? ''));
    if ($href === null) {
        return null;
    }
    $loggedIn = function_exists('auth_user_id') && auth_user_id() !== null;
    $path = (string) parse_url($href, PHP_URL_PATH);
    if ($loggedIn && $path === '/register.php') {
        $href = mpp_ref_of($href) === 'mp-advertise' ? '/account.php?promo_tab=create#acc-promo' : '/account.php';
        $label = t('mpp_cta_cabinet');
        $hint = t('mpp_cta_hint_user');
    } else {
        $label = $path === '/register.php' ? t('mpp_cta_signup') : t('mp_get');
        $hint = $path === '/register.php' ? t('mpp_cta_hint_guest') : '';
    }

    return ['href' => $href, 'label' => $label, 'hint' => $hint,
        'features' => (string) ($r['features'] ?? ''), 'for_whom' => (string) ($r['for_whom'] ?? '')];
}
