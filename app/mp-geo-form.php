<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: HTML блоку «Де надається» (форми оголошення) і поля вибору місця з автопідказкою.
 * Логіка й перевірка — app/mp-geo.php; поведінка — public/assets/js/mp-geo.js (без JS форма теж надсилається,
 * але місто вибирається лише з підказки: вільний текст не приймається).
 */

require_once __DIR__ . '/mp-geo.php';

/**
 * Поле вибору місця: видимий текст + прихований id (або код країни для $type='country').
 *
 * @param string $name     ім'я прихованого поля (place_id, extra_place[], countries[] …)
 * @param string $value    поточне значення (id місця або код країни)
 * @param string $label    вже підготовлений підпис поточного значення
 */
function mpg_picker_html(string $name, string $value, string $label, string $type, string $lang, string $id, string $ariaLabel, bool $required = false): string
{
    $valueMode = $type === 'country' ? 'code' : 'id';

    return '<div class="mp-geo-picker" data-geo-picker data-type="' . mp_e($type) . '" data-lang="' . mp_e($lang) . '" data-value="' . $valueMode . '">'
        . '<input class="mp-input" type="text" id="' . mp_e($id) . '" autocomplete="off" role="combobox" aria-autocomplete="list" aria-expanded="false"'
        . ' aria-controls="' . mp_e($id) . '_list" aria-label="' . mp_e($ariaLabel) . '" maxlength="60" value="' . mp_e($label) . '"'
        . ' placeholder="' . mp_e(t($type === 'country' ? 'mpg_ph_country' : 'mpg_ph_city')) . '" data-geo-input' . ($required ? ' aria-required="true"' : '') . '>'
        . '<input type="hidden" name="' . mp_e($name) . '" value="' . mp_e($value) . '" data-geo-id>'
        . '<ul class="mp-geo-list" id="' . mp_e($id) . '_list" role="listbox" hidden></ul>'
        . '</div>';
}

/** Блок «Де надається» для форм оголошення. $v — mpg_form_defaults() / _from_listing() / _from_post(). */
function mpg_form_html(PDO $pdo, array $v, string $lang): string
{
    if (!mpg_ready($pdo)) {
        return '';
    }
    $ids = [(int) $v['place_id']];
    foreach ($v['extra'] as $e) {
        $ids[] = (int) $e['place_id'];
    }
    $labels = mpg_labels($pdo, $ids, $lang);
    $countries = mpg_countries($pdo, $lang);
    $lbl = static fn(int $id): string => $labels[$id]['label'] ?? '';
    $radiusSelect = static function (string $name, int $cur, string $aria): string {
        $h = '<select class="mp-input mp-input--short" name="' . mp_e($name) . '" aria-label="' . mp_e($aria) . '">';
        $h .= '<option value="0"' . ($cur === 0 ? ' selected' : '') . '>' . mp_e(t('mpg_radius_city_only')) . '</option>';
        foreach (MPG_RADII as $r) {
            $h .= '<option value="' . $r . '"' . ($cur === $r ? ' selected' : '') . '>+' . $r . ' ' . mp_e(t('mpg_unit_km')) . '</option>';
        }

        return $h . '</select>';
    };
    $wf = $v['work_format'];
    $chk = static fn(bool $on): string => $on ? ' checked' : '';

    ob_start();
    ?>
    <fieldset class="mp-field mp-fieldset mp-geo" data-geo-form>
        <legend class="mp-label"><?= mp_e(t('mpg_where_title')) ?></legend>
        <div class="mp-geo-formats" role="radiogroup">
            <?php foreach (MPG_FORMATS as $f): ?>
                <label class="mp-check"><input type="radio" name="work_format" value="<?= $f ?>"<?= $chk($wf === $f) ?> data-geo-format> <span><?= mp_e(t('mpg_fmt_' . $f)) ?></span></label>
            <?php endforeach; ?>
        </div>
        <p class="mp-hint"><?= mp_e(t('mpg_where_hint')) ?></p>

        <div class="mp-geo-section" data-geo-show="online"<?= $wf === 'online' ? '' : ' hidden' ?>>
            <p class="mp-label"><?= mp_e(t('mpg_scope_title')) ?></p>
            <label class="mp-check"><input type="radio" name="online_scope" value="worldwide"<?= $chk($v['online_scope'] !== 'country') ?>> <span><?= mp_e(t('mpg_scope_worldwide')) ?></span></label>
            <label class="mp-check"><input type="radio" name="online_scope" value="country"<?= $chk($v['online_scope'] === 'country') ?>> <span><?= mp_e(t('mpg_scope_countries')) ?></span></label>
            <div class="mp-geo-countries">
                <?php for ($i = 0; $i < MPG_MAX_EXTRA; $i++): $cc = $v['countries'][$i] ?? ''; ?>
                    <select class="mp-input" name="countries[]" aria-label="<?= mp_e(sprintf(t('mpg_country_n'), $i + 1)) ?>">
                        <option value=""><?= mp_e(t('mpg_country_none')) ?></option>
                        <?php foreach ($countries as $code => $name): ?>
                            <option value="<?= mp_e($code) ?>"<?= $cc === $code ? ' selected' : '' ?>><?= mp_e($name) ?></option>
                        <?php endforeach; ?>
                    </select>
                <?php endfor; ?>
            </div>
        </div>

        <div class="mp-geo-section" data-geo-show="offline hybrid"<?= $wf === 'online' ? ' hidden' : '' ?>>
            <label class="mp-label" for="geo_place"><?= mp_e(t('mpg_city_label')) ?> <span class="mp-req">*</span></label>
            <?= mpg_picker_html('place_id', $v['place_id'] > 0 ? (string) $v['place_id'] : '', $lbl((int) $v['place_id']), 'city', $lang, 'geo_place', t('mpg_city_label'), true) ?>
            <p class="mp-label"><?= mp_e(t('mpg_scope_title')) ?></p>
            <div class="mp-inline">
                <label class="mp-check"><input type="radio" name="local_scope" value="local"<?= $chk($v['local_scope'] !== 'country') ?>> <span><?= mp_e(t('mpg_scope_local')) ?></span></label>
                <?= $radiusSelect('service_radius', (int) $v['radius_km'], t('mpg_radius_label')) ?>
            </div>
            <label class="mp-check"><input type="radio" name="local_scope" value="country"<?= $chk($v['local_scope'] === 'country') ?>> <span><?= mp_e(t('mpg_scope_country')) ?></span></label>

            <p class="mp-label"><?= mp_e(sprintf(t('mpg_extra_title'), MPG_MAX_EXTRA)) ?></p>
            <div class="mp-geo-extra">
                <?php for ($i = 0; $i < MPG_MAX_EXTRA; $i++): $e = $v['extra'][$i] ?? ['place_id' => 0, 'radius_km' => 0]; ?>
                    <div class="mp-inline mp-geo-extra__row">
                        <?= mpg_picker_html('extra_place[' . $i . ']', $e['place_id'] > 0 ? (string) $e['place_id'] : '', $lbl((int) $e['place_id']), 'any', $lang, 'geo_extra_' . $i, sprintf(t('mpg_extra_n'), $i + 1)) ?>
                        <?= $radiusSelect('extra_radius[' . $i . ']', (int) $e['radius_km'], t('mpg_radius_label')) ?>
                    </div>
                <?php endfor; ?>
            </div>
        </div>
    </fieldset>
    <script src="/assets/js/mp-geo.js?v=<?= (int) @filemtime(__DIR__ . '/../public/assets/js/mp-geo.js') ?>" defer></script>
    <?php

    return (string) ob_get_clean();
}
