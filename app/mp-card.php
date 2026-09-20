<?php

/**
 * AI LAB HUB — картка пропозиції Marketplace (стиль карток продуктів).
 *
 * Партіал: перед підключенням задати $card — рядок із mp_public_listings() (див. app/marketplace.php),
 * тексти вже вибрані за мовою інтерфейсу з запасним варіантом — мова оригіналу.
 * Стилі: public/assets/css/mp-public.css.
 */

$cardId = (int) $card['id'];
$cardCover = mp_cover_url($card['cover_image'] ?? null);
$cardUrl = 'offer.php?id=' . $cardId;
$cardFallback = (string) $card['text_lang'] !== current_lang();
?>
<article class="mp-card">
    <?php if ($cardCover !== null): ?>
        <a href="<?= $cardUrl ?>" tabindex="-1" aria-hidden="true"><img class="mp-card__cover" src="<?= mp_e($cardCover) ?>" alt="" loading="lazy"></a>
    <?php else: ?>
        <a class="mp-card__cover" href="<?= $cardUrl ?>" tabindex="-1" aria-hidden="true"></a>
    <?php endif; ?>
    <?php if ($card['categories'] !== []): ?>
        <div class="mp-card__cats">
            <?php foreach ($card['categories'] as $cardCat): ?>
                <span><?= mp_e($cardCat['name']) ?></span>
            <?php endforeach; ?>
        </div>
    <?php endif; ?>
    <h3 class="mp-card__name"><a href="<?= $cardUrl ?>"><?= mp_e($card['title']) ?></a></h3>
    <p class="mp-card__desc"<?= $cardFallback ? ' lang="' . mp_e($card['text_lang']) . '"' : '' ?>><?= mp_e($card['short_desc'] ?? '') ?></p>
    <div class="mp-card__footer">
        <span class="mp-badge"><?= mp_e(t('price_free')) ?></span>
        <a class="mp-btn" href="<?= $cardUrl ?>"><?= mp_e(t('mp_details')) ?></a>
    </div>
</article>
