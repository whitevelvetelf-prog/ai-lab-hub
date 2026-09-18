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
