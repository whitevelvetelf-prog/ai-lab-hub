<?php

declare(strict_types=1);

/**
 * AI LAB HUB — нативна рекламна картка в списках (каталог, категорія, маркетплейс).
 *
 * Замість окремого великого банера реклама стоїть усередині сітки списку як ще одна
 * картка того самого розміру, що й картка продукту/оголошення, з позначкою
 * «Реклама» / «Ad». Структура: медіа (зображення, відео або градієнт власної
 * реклами) → заголовок → підпис → кнопка. Уся картка — одне посилання на
 * /promo-click.php?t=ТОКЕН (адреса переходу береться з БД; нейтральна назва
 * файлу, бо шляхи з «ad» ріжуть блокувальники реклами).
 *
 * До 5 креативів обираються на сервері (promo_pick_set, app/promo-select.php) у момент
 * рендеру сторінки: перший — одразу в розмітці (без стрибка сітки й без окремого
 * запиту), усі — JSON поруч. public/assets/js/sponsored.js оживляє картку (облік
 * показу, відео, звук) і крутить кандидатів. Креативи не повторюються на сторінці.
 * Немає реклами — не виводиться нічого (без порожньої рамки).
 *
 * Позиції в списку й ліміт карток на сторінку — у правилі місця (ad_placements:
 * position_rule {"position":3,"every":8}, slots_per_page 2; адмінка «Місця показу»),
 * не в шаблонах:
 *
 *   $adAt = ad_card_positions($pdo, 'subcategory_list', count($products));
 *   foreach ($products as $i => $p) {
 *       if (in_array($i, $adAt, true)) { echo ad_card_slot($pdo, 'subcategory_list', $cats, $subs); }
 *       …картка продукту…
 *   }
 *   if (in_array(count($products), $adAt, true)) { echo ad_card_slot(…); }
 */

require_once __DIR__ . '/promo.php';

/**
 * Індекси карток списку (з нуля), ПЕРЕД якими стоїть рекламна картка — з правила місця.
 *
 * @return list<int>
 */
function ad_card_positions(PDO $pdo, string $placement, int $count): array
{
    return promo_placement_positions($pdo, $placement, $count, 3);
}

/**
 * HTML нативної рекламної картки для місця $placement або '' (реклами немає, система
 * чи місце вимкнені, сторінку виключено no_promo, бот, вичерпано ліміт карток місця).
 * Креативи не повторюються на сторінці; власна реклама — не більше одного блока.
 *
 * @param list<int> $categoryIds
 * @param list<int> $subcategoryIds
 * @param array<string,mixed> $page як у promo_slot (product, article, mp)
 */
function ad_card_slot(PDO $pdo, string $placement, array $categoryIds = [], array $subcategoryIds = [], array $page = []): string
{
    static $perPage = [];

    if (!in_array($placement, PROMO_PLACEMENTS, true)) {
        return '';
    }
    $preview = promo_preview_active($pdo);
    if (!$preview && (!promo_video_ready($pdo) || !promo_placement_available($pdo, $placement) || promo_is_bot())) {
        return '';
    }
    if (promo_page_excluded($pdo, $categoryIds, $subcategoryIds, $page) !== null) {
        return '';
    }
    $perPage[$placement] = ($perPage[$placement] ?? 0) + 1;
    if ($perPage[$placement] > promo_placement_slots($pdo, $placement)) {
        return '';
    }

    // До PROMO_ROTATION_SIZE кандидатів — sponsored.js крутить їх у слоті (ротація).
    $state = &promo_page_state();
    if ($preview) {
        $set = array_values(array_filter([promo_preview_creative($pdo)]));
    } else {
        $set = promo_pick_set(
            $pdo,
            $placement,
            $categoryIds,
            $subcategoryIds,
            promo_lang(),
            promo_device(),
            analytics_session_hash(),
            $page + ($state['house'] ? ['no_house' => true] : []),
            $state['shown']
        );
    }
    if ($set === []) {
        return '';
    }
    $payloads = array_map(static fn(array $cr): array => promo_public_payload($cr, $placement, $preview, $pdo), $set);
    if (!$preview) {
        foreach ($payloads as $p) {
            $state['shown'][] = (int) $p['id'];
            $state['house'] = $state['house'] || !empty($p['house']);
        }
    }

    $marketplace = promo_placement_is_marketplace($pdo, $placement);
    $data = ['creatives' => $payloads, 'labels' => promo_labels()];
    $payload = $payloads[0];

    return '<div class="sponsored-slot sponsored-slot--native sponsored-slot--' . $placement . '" data-native="1"'
        . ' data-placement="' . $placement . '"' . ($marketplace ? ' data-group="marketplace"' : '')
        . ($preview ? ' data-preview="1"' : '') . '>'
        . ad_card_html($payload)
        . '<script type="application/json" class="sponsored-slot__data">'
        . json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_HEX_TAG | JSON_HEX_AMP)
        . '</script></div>'
        . promo_assets_html();
}

/** Розмітка картки для одного креативу (дані promo_public_payload). */
function ad_card_html(array $c): string
{
    $e = static fn(?string $v): string => htmlspecialchars((string) $v, ENT_QUOTES);
    $type = (string) ($c['type'] ?? 'card');

    $media = '';
    if ($type === 'upload' && !empty($c['video'])) {
        // Відео вантажиться лише поблизу екрана (sponsored.js підставляє src), до того — постер.
        $media = '<video muted playsinline loop preload="none" disablepictureinpicture'
            . (!empty($c['poster']) ? ' poster="' . $e($c['poster']) . '"' : '')
            . ' data-src="' . $e($c['video']) . '"></video>';
    } elseif ($type === 'youtube' && !empty($c['youtube'])) {
        $poster = !empty($c['poster']) ? $c['poster'] : 'https://i.ytimg.com/vi/' . rawurlencode((string) $c['youtube']) . '/hqdefault.jpg';
        $media = '<img src="' . $e($poster) . '" alt="" loading="lazy">';
    } elseif (!empty($c['poster'])) {
        $media = '<img src="' . $e($c['poster']) . '" alt="" loading="lazy">';
    }

    return '<article class="sponsored-card sponsored-card--native' . ($media === '' ? ' sponsored-card--card' : '') . '"'
        . ' data-id="' . (int) $c['id'] . '">'
        . '<span class="sponsored-card__label">' . $e(t('ad_label')) . '</span>'
        . ($media !== '' ? '<div class="sponsored-card__media">' . $media . '</div>' : '')
        . '<h3 class="sponsored-card__title"><a class="sponsored-card__link" href="/promo-click.php?t=' . $e(rawurlencode((string) $c['token'])) . '"'
        . ' target="_blank" rel="sponsored noopener noreferrer">' . $e($c['title']) . '</a></h3>'
        . ((string) ($c['description'] ?? '') !== '' ? '<p class="sponsored-card__desc">' . $e($c['description']) . '</p>' : '')
        . '<div class="sponsored-card__footer"><span class="sponsored-card__cta">' . $e($c['cta']) . '</span></div>'
        . '</article>';
}
