<?php

declare(strict_types=1);

/**
 * AI LAB HUB — блок «Де показувати рекламу» (галочки місць показу) для майстра
 * кампанії й форми «Місця показу» у списку кампаній (app/promo-cabinet.php).
 *
 * Кожне місце: галочка, назва, одне речення «де саме», схематичний SVG-макет
 * сторінки з підсвіченим місцем блока, ціна за обраною моделлю (з прайсу) і
 * орієнтовна ємність (перегляди за 30 днів — public/promo-capacity.php).
 * Місце вимкнене адміном, залежне від вимкненого налаштування чи без ціни —
 * неактивне з поясненням. Ціни й доступність перемикає promo-cabinet.js при зміні
 * цілі кампанії; сервер перевіряє те саме ще раз (promo_save_campaign,
 * promo_update_placements).
 */

require_once __DIR__ . '/promo-placements.php';

/** Схематичний макет сторінки (світлий каркас, місце блока підсвічене). */
function promo_placement_svg(string $key): string
{
    $hl = '<rect class="pc-pl-svg__hl" ';
    $box = '<rect class="pc-pl-svg__box" ';
    $line = '<rect class="pc-pl-svg__line" ';
    $body = match ($key) {
        'category_page' => $line . 'x="8" y="8" width="60" height="6" rx="2"/>'
            . $line . 'x="8" y="18" width="104" height="3" rx="1.5"/>' . $line . 'x="8" y="24" width="80" height="3" rx="1.5"/>'
            . $hl . 'x="8" y="32" width="104" height="14" rx="3"/>'
            . $box . 'x="8" y="50" width="32" height="22" rx="3"/>' . $box . 'x="44" y="50" width="32" height="22" rx="3"/>' . $box . 'x="80" y="50" width="32" height="22" rx="3"/>',
        'subcategory_list' => $line . 'x="8" y="8" width="56" height="6" rx="2"/>'
            . $box . 'x="8" y="20" width="32" height="24" rx="3"/>' . $box . 'x="44" y="20" width="32" height="24" rx="3"/>' . $hl . 'x="80" y="20" width="32" height="24" rx="3"/>'
            . $box . 'x="8" y="48" width="32" height="24" rx="3"/>' . $box . 'x="44" y="48" width="32" height="24" rx="3"/>' . $box . 'x="80" y="48" width="32" height="24" rx="3"/>',
        'search_results' => $box . 'x="8" y="8" width="104" height="10" rx="5"/>'
            . $box . 'x="8" y="24" width="32" height="22" rx="3"/>' . $box . 'x="44" y="24" width="32" height="22" rx="3"/>' . $hl . 'x="80" y="24" width="32" height="22" rx="3"/>'
            . $box . 'x="8" y="50" width="32" height="22" rx="3"/>' . $box . 'x="44" y="50" width="32" height="22" rx="3"/>' . $box . 'x="80" y="50" width="32" height="22" rx="3"/>',
        'product_page' => $box . 'x="8" y="8" width="26" height="26" rx="4"/>'
            . $line . 'x="40" y="10" width="56" height="6" rx="2"/>' . $line . 'x="40" y="21" width="72" height="3" rx="1.5"/>' . $line . 'x="40" y="27" width="64" height="3" rx="1.5"/>'
            . $line . 'x="8" y="40" width="104" height="3" rx="1.5"/>' . $line . 'x="8" y="46" width="96" height="3" rx="1.5"/>'
            . $hl . 'x="8" y="54" width="104" height="18" rx="3"/>',
        'blog_list' => $box . 'x="8" y="6" width="104" height="11" rx="3"/>' . $box . 'x="8" y="20" width="104" height="11" rx="3"/>' . $box . 'x="8" y="34" width="104" height="11" rx="3"/>'
            . $hl . 'x="8" y="48" width="104" height="12" rx="3"/>' . $box . 'x="8" y="63" width="104" height="11" rx="3"/>',
        'blog_article' => $line . 'x="8" y="6" width="70" height="6" rx="2"/>'
            . $line . 'x="8" y="16" width="104" height="3" rx="1.5"/>' . $line . 'x="8" y="22" width="100" height="3" rx="1.5"/>' . $line . 'x="8" y="28" width="104" height="3" rx="1.5"/>'
            . $hl . 'x="8" y="36" width="104" height="16" rx="3"/>'
            . $line . 'x="8" y="57" width="50" height="4" rx="2"/>' . $line . 'x="8" y="65" width="104" height="3" rx="1.5"/>' . $line . 'x="8" y="71" width="90" height="3" rx="1.5"/>',
        default => $box . 'x="8" y="8" width="50" height="30" rx="3"/>' . $hl . 'x="62" y="8" width="50" height="30" rx="3"/>'
            . $box . 'x="8" y="42" width="50" height="30" rx="3"/>' . $box . 'x="62" y="42" width="50" height="30" rx="3"/>',
    };

    return '<svg class="pc-pl-svg" viewBox="0 0 120 80" width="120" height="80" aria-hidden="true" focusable="false">'
        . '<rect class="pc-pl-svg__page" x="0.5" y="0.5" width="119" height="79" rx="6"/>' . $body . '</svg>';
}

/**
 * Ключі місць, які можна обрати зараз за моделлю $model (cpm|cpc): доступні й з
 * ціною в прайсі. Власна реклама сайту ($house) — без прайсу: лише доступність.
 *
 * @return list<string>
 */
function promo_placements_selectable(PDO $pdo, array $rates, ?string $model, bool $house = false): array
{
    $out = [];
    foreach (array_keys(promo_placements($pdo)) as $k) {
        if (promo_placement_available($pdo, $k) && ($house || ($model !== null && !empty($rates[$k][$model])))) {
            $out[] = $k;
        }
    }

    return $out;
}

/**
 * HTML блока галочок. $selected — обрані ключі; $model — поточна модель для
 * початкового стану (JS оновлює при зміні цілі); $fixedModel — модель не змінюється
 * (форма «Місця показу» наявної кампанії).
 *
 * @param list<string> $selected
 * @param array{language?:string,device?:string,cats?:list<int>,subs?:list<int>}|null $fixedTargeting
 */
function promo_placement_picker_html(PDO $pdo, array $selected, string $lang, array $rates, ?string $model, bool $house, ?array $fixedTargeting = null): string
{
    $e = static fn(mixed $v): string => htmlspecialchars((string) $v, ENT_QUOTES);
    $i18n = promo_tr_many(['place_price_cpm', 'place_price_cpc', 'place_no_price', 'place_no_model', 'capacity_views', 'capacity_few',
        'capacity_none', 'capacity_loading', 'places_required'], $lang);
    $groups = [];
    foreach (promo_placements($pdo) as $k => $p) {
        $groups[$p['group_key']][] = $p;
    }

    $attrs = ' data-pc-places data-house="' . ($house ? '1' : '0') . '"'
        . ' data-i18n="' . $e((string) json_encode($i18n, JSON_UNESCAPED_UNICODE)) . '"'
        . ' data-capacity-url="promo-capacity.php"'
        . ' data-min-views="' . PROMO_CAPACITY_MIN_VIEWS . '"';
    if ($fixedTargeting !== null) {
        $attrs .= ' data-fixed-model="' . $e((string) $model) . '"'
            . ' data-fixed-targeting="' . $e((string) json_encode([
                'language' => $fixedTargeting['language'] ?? 'all',
                'device' => $fixedTargeting['device'] ?? 'all',
                'cats' => array_values($fixedTargeting['cats'] ?? []),
                'subs' => array_values($fixedTargeting['subs'] ?? []),
            ])) . '"';
    }

    $html = '<div class="pc-places"' . $attrs . '>';
    $html .= '<label class="pc-check pc-places__all"><input type="checkbox" data-pc-places-all> <span><strong>' . $e(promo_tr('places_all')) . '</strong> <small>' . $e(promo_tr('places_all_hint')) . '</small></span></label>';
    $html .= '<p class="pc-note pc-note--warn" data-pc-places-required hidden role="alert">' . $e(promo_tr('places_required')) . '</p>';

    foreach (PROMO_PLACEMENT_GROUPS as $g) {
        if (empty($groups[$g])) {
            continue;
        }
        $html .= '<fieldset class="pc-places__group"><legend>' . $e(promo_tr('group_' . $g)) . '</legend><div class="pc-places__grid">';
        foreach ($groups[$g] as $p) {
            $k = $p['key'];
            $block = promo_placement_block_reason($pdo, $k);
            $cpm = (int) ($rates[$k]['cpm'] ?? 0);
            $cpc = (int) ($rates[$k]['cpc'] ?? 0);
            $price = $model !== null ? (int) ($rates[$k][$model] ?? 0) : 0;
            $selectable = $block === null && ($house || $price > 0);
            $checked = $selectable && in_array($k, $selected, true);
            $blockText = $block === null ? '' : promo_tr($block === 'disabled' ? 'place_disabled' : 'place_soon');
            $priceText = $house ? '' : ($model === null ? promo_tr('place_no_model')
                : ($price > 0 ? promo_tr('place_price_' . $model, promo_money($price)) : promo_tr('place_no_price')));

            $html .= '<label class="pc-place' . ($selectable ? '' : ' is-disabled') . '" data-pc-place="' . $e($k) . '"'
                . ' data-block="' . $e((string) $block) . '" data-cpm="' . $cpm . '" data-cpc="' . $cpc . '"'
                . ' data-cpm-text="' . $e($cpm > 0 ? promo_tr('place_price_cpm', promo_money($cpm)) : '') . '"'
                . ' data-cpc-text="' . $e($cpc > 0 ? promo_tr('place_price_cpc', promo_money($cpc)) : '') . '">'
                . '<span class="pc-place__head"><input type="checkbox" name="placements[]" value="' . $e($k) . '"'
                . ($checked ? ' checked' : '') . ($selectable ? '' : ' disabled') . '>'
                . ' <strong>' . $e($lang === 'en' ? $p['title_en'] : $p['title_uk']) . '</strong>'
                . ($blockText !== '' ? ' <span class="pc-place__badge">' . $e($blockText) . '</span>' : '') . '</span>'
                . promo_placement_svg($k)
                . '<span class="pc-place__desc">' . $e($lang === 'en' ? $p['description_en'] : $p['description_uk']) . '</span>'
                . ($house ? '' : '<span class="pc-place__price" data-pc-place-price>' . $e($block === null ? $priceText : '') . '</span>')
                . '<span class="pc-place__capacity" data-pc-place-capacity></span>'
                . '</label>';
        }
        $html .= '</div></fieldset>';
    }

    return $html . '</div>';
}
