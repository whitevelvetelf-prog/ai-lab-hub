<?php

/**
 * AI LAB HUB — розмітка рекламного банера (app/ads.php обирає кампанію).
 *
 * Підключати після того, як $campaign отримано через ads_pick_campaign():
 *   require_once __DIR__ . '/../app/ads.php';
 *   $campaign = ads_pick_campaign($pdo, 'homepage_banner');
 *   if ($campaign !== null) { include __DIR__ . '/../app/ad-banner.php'; }
 *
 * Нічого не виводить, якщо $campaign === null (порожній слот — сторінка
 * просто не показує банер, це не помилка).
 */

/*
 * Режим «зона» (ad server, app/ads.php → getAdForZone): задано $zoneId
 * (обов'язково) і, за потреби, $categoryId / $subcategoryId:
 *   $zoneId = 1; $categoryId = 5; include __DIR__ . '/../app/ad-banner.php';
 * Немає оголошення — нічого не виводиться (без порожньої рамки).
 */
if (isset($zoneId)) {
    require_once __DIR__ . '/ads.php';

    $zoneAd = getAdForZone((int) $zoneId, isset($categoryId) ? (int) $categoryId : null, isset($subcategoryId) ? (int) $subcategoryId : null, $pdo ?? null);
    if ($zoneAd === null) {
        return;
    }
    $zoneAdId = (int) $zoneAd['id'];

    // Текст оголошення — з БД і перекладається як решта контенту
    // (ad_translations, app/translations.php → localized_field).
    $adPdo = $pdo ?? translation_pdo();
    $adHeadline = localized_field($adPdo, 'ad_translations', 'ad_id', $zoneAd, 'headline');
    $adSubtext = localized_field($adPdo, 'ad_translations', 'ad_id', $zoneAd, 'subtext');
    $adHasText = trim($adHeadline) !== '' || trim($adSubtext) !== '';
    ?>
<div class="ad-zone" id="ad-zone-<?= $zoneAdId ?>">
    <span class="ad-zone__label"><?= htmlspecialchars(t('ad_label'), ENT_QUOTES) ?></span>
    <a class="ad-zone__link<?= $adHasText ? '' : ' ad-zone__link--image-only' ?>" href="/ad-click.php?id=<?= $zoneAdId ?>" target="_blank" rel="sponsored noopener">
        <img class="ad-zone__image" src="<?= htmlspecialchars($zoneAd['image_url'], ENT_QUOTES) ?>" alt="" loading="lazy">
        <?php if ($adHasText): ?>
        <span class="ad-zone__text">
            <?php if (trim($adHeadline) !== ''): ?>
            <span class="ad-zone__headline"><?= htmlspecialchars($adHeadline, ENT_QUOTES) ?></span>
            <?php endif; ?>
            <?php if (trim($adSubtext) !== ''): ?>
            <span class="ad-zone__subtext"><?= htmlspecialchars($adSubtext, ENT_QUOTES) ?></span>
            <?php endif; ?>
        </span>
        <?php endif; ?>
    </a>
</div>
<script>
    fetch('/log-impression.php', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'ad_id=<?= $zoneAdId ?>',
        keepalive: true
    }).catch(function () {});
</script>
<?php
    return;
}

if (!isset($campaign) || $campaign === null) {
    return;
}

$isExternal = str_starts_with($campaign['target_url'], 'http://') || str_starts_with($campaign['target_url'], 'https://');

?>
<a class="ad-banner" href="<?= htmlspecialchars($campaign['target_url'], ENT_QUOTES) ?>"<?= $isExternal ? ' target="_blank" rel="noopener sponsored"' : '' ?>>
    <span class="ad-banner__label"><?= htmlspecialchars(t('ad_label'), ENT_QUOTES) ?></span>
    <?php if ($campaign['image_url']): ?>
    <img class="ad-banner__image" src="<?= htmlspecialchars($campaign['image_url'], ENT_QUOTES) ?>" alt="">
    <?php endif; ?>
    <span class="ad-banner__text">
        <span class="ad-banner__title"><?= htmlspecialchars($campaign['title'], ENT_QUOTES) ?></span>
        <?php if ($campaign['description']): ?>
        <span class="ad-banner__desc"><?= htmlspecialchars($campaign['description'], ENT_QUOTES) ?></span>
        <?php endif; ?>
    </span>
</a>
