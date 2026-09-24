<?php

/**
 * AI LAB HUB — картка оголошення дошки (marketplace.php, mp-favorites.php, «інші оголошення продавця»).
 *
 * Партіал: перед підключенням задати $card — рядок із mpb_search()/mpb_seller_other() (див. app/marketplace-board.php).
 * Контактів у $card немає за побудовою. Стилі: public/assets/css/mp-public.css.
 */

$cardId = (int) $card['id'];
$cardUrl = 'offer.php?id=' . $cardId;
$cardThumb = !empty($card['cover_thumb']) ? mpb_photo_url((string) $card['cover_thumb']) : null;
$cardFallback = (string) ($card['text_lang'] ?? '') !== current_lang();
$cardLoc = mpb_location_label($card);
$cardPrice = mpb_price_label($card);   // '' — ціну не вказано
$cardDate = !empty($card['published_at']) ? date('d.m.Y', (int) strtotime((string) $card['published_at'])) : '';
?>
<article class="mp-card mp-card--ad">
    <?php if ($cardThumb !== null): ?>
        <a href="<?= mp_e($cardUrl) ?>" tabindex="-1" aria-hidden="true"><img class="mp-card__cover" src="<?= mp_e($cardThumb) ?>" alt="" loading="lazy"></a>
    <?php else: ?>
        <a class="mp-card__cover mp-card__cover--empty" href="<?= mp_e($cardUrl) ?>" tabindex="-1" aria-hidden="true"></a>
    <?php endif; ?>
    <?php // Порядок — як у формі подачі: назва, короткий опис, ціна, місто; усе, крім назви, одним стилем (.mp-card__info). ?>
    <h3 class="mp-card__name"><a href="<?= mp_e($cardUrl) ?>"><?= mp_e($card['title']) ?></a></h3>
    <?php if (!empty($card['short_desc'])): ?>
        <p class="mp-card__desc mp-card__info"<?= $cardFallback ? ' lang="' . mp_e($card['text_lang']) . '"' : '' ?>><?= mp_e($card['short_desc']) ?></p>
    <?php endif; ?>
    <?php if ($cardPrice !== ''): ?>
        <p class="mp-card__price mp-card__info"><?= mp_e($cardPrice) ?></p>
    <?php endif; ?>
    <div class="mp-card__meta mp-card__info">
        <?php if ($cardLoc !== ''): ?><span><?= mp_e($cardLoc) ?></span><?php endif; ?>
        <?php if ($cardDate !== ''): ?><span><?= mp_e($cardDate) ?></span><?php endif; ?>
    </div>
</article>
