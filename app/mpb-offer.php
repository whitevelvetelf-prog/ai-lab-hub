<?php

/**
 * AI LAB HUB — сторінка оголошення дошки (offer.php?id=N для section='board').
 *
 * Партіал: підключається з public/offer.php, який уже зробив mp_public_require(), відкрив $pdo,
 * визначив $lang та поклав у $board рядок із mpb_listing() (тексти, фото, категорії; БЕЗ контактів).
 * Контакти сюди не потрапляють: кнопка «Показати контакт» робить POST на mp-contact.php.
 * Живе оголошення бачать усі; інші статуси — лише власник і employee/admin (перегляд із банером).
 * Рейтингів і відгуків немає.
 */

$bid = (int) $board['id'];
$isLive = mpb_row_is_live($board);
$viewerId = auth_user_id();
$isOwner = $viewerId !== null && $board['seller_user_id'] !== null && (int) $board['seller_user_id'] === $viewerId;
if (!$isLive && !$isOwner && !mpb_is_staff()) {
    mp_not_found();
}
if ($isLive) {
    mpb_count_view($pdo, $bid, $board['seller_user_id'] !== null ? (int) $board['seller_user_id'] : null);
}

$photos = $board['photos'];
$fallbackLang = (string) $board['text_lang'] !== $lang ? (string) $board['text_lang'] : null;
$langNames = active_languages();
$isFav = $viewerId !== null && $isLive && mpb_is_favorite($pdo, $viewerId, $bid);
$others = $isLive && $board['seller_id'] !== null ? mpb_seller_other($pdo, (int) $board['seller_id'], $bid, $lang) : [];
$priceText = mpb_price_label($board);   // '' — ціну не вказано
$statusKey = ['pending' => 'mpb_st_pending', 'draft' => 'mpb_st_pending', 'published' => 'mpb_st_published', 'rejected' => 'mpb_st_rejected', 'archived' => 'mpb_st_archived', 'expired' => 'mpb_st_expired'];
$reasons = array_combine(MPB_REPORT_REASONS, array_map(static fn(string $r): string => t('mpb_reason_' . $r), MPB_REPORT_REASONS));

mpb_open((string) $board['title'], !$isLive);
?>
    <div class="mp-page mp-page--narrow">
        <a class="mp-back" href="marketplace.php"><?= mp_e(t('mp_back')) ?></a>

        <?= mpb_flash_html() ?>

        <?php if (!$isLive): ?>
            <div class="mp-alert mp-alert--error"><?= mp_e(t('mpb_preview_banner')) ?> <strong><?= mp_e(t($statusKey[$board['status']] ?? 'mpb_st_pending')) ?></strong>
                <?php if ((string) $board['status'] === 'rejected' && !empty($board['reject_reason'])): ?>
                    — <?= mp_e($board['reject_reason']) ?>
                <?php endif; ?>
            </div>
        <?php endif; ?>

        <h1 class="mp-title"><?= mp_e($board['title']) ?></h1>

        <?php if ($fallbackLang !== null): ?>
            <p class="mp-note"><?= mp_e(sprintf(t('mp_original_lang'), $langNames[$fallbackLang] ?? strtoupper($fallbackLang))) ?></p>
        <?php endif; ?>

        <?php // Поля — у порядку форми подачі (mp-post.php); усе, крім заголовка, одним стилем (.mp-info). ?>
        <div class="mp-info">
            <?php if (!empty($board['short_desc'])): ?>
                <p class="mp-info__row"><?= mp_e($board['short_desc']) ?></p>
            <?php endif; ?>
            <?php if (!empty($board['full_desc'])): ?>
                <p class="mp-info__row mp-text--pre"><?= mp_e($board['full_desc']) ?></p>
            <?php endif; ?>
            <?php if ($board['categories'] !== []): ?>
                <p class="mp-info__row"><span class="mp-info__label"><?= mp_e(t('mpb_f_categories')) ?>:</span> <?= mp_e(implode(', ', array_column($board['categories'], 'name'))) ?></p>
            <?php endif; ?>
            <?php if ($priceText !== ''): ?>
                <p class="mp-info__row"><span class="mp-info__label"><?= mp_e(t('mpb_f_price_range')) ?>:</span> <?= mp_e($priceText) ?></p>
            <?php endif; ?>
            <?php if (!empty($board['city'])): ?>
                <p class="mp-info__row"><span class="mp-info__label"><?= mp_e(t('mpb_f_city')) ?>:</span> <?= mp_e($board['city']) ?></p>
            <?php endif; ?>
            <?php if ((int) ($board['is_remote'] ?? 0) === 1): ?>
                <p class="mp-info__row"><?= mp_e(t('mpb_f_remote')) ?></p>
            <?php endif; ?>
        </div>

        <?php if ($isLive && !$isOwner): ?>
            <div class="mp-offer__actions">
                <form method="post" action="mp-contact.php" id="mpContactForm" data-error="<?= mp_e(t('mpb_contact_error')) ?>">
                    <?= mp_csrf_field() ?><input type="hidden" name="id" value="<?= $bid ?>">
                    <button class="mp-btn mp-btn--primary mp-btn--lg" type="submit" id="mpContactBtn"><?= mp_e(t('mpb_contact_btn')) ?></button>
                </form>
                <?php if ($viewerId !== null): ?>
                    <form method="post" action="mp-favorite.php">
                        <?= mp_csrf_field() ?><input type="hidden" name="id" value="<?= $bid ?>">
                        <button class="mp-btn mp-btn--lg" type="submit"><?= mp_e(t($isFav ? 'mpb_fav_remove' : 'mpb_fav_add')) ?></button>
                    </form>
                <?php else: ?>
                    <a class="mp-btn mp-btn--lg" href="login.php"><?= mp_e(t('mpb_fav_login')) ?></a>
                <?php endif; ?>
            </div>
            <div id="mpContacts" class="mp-contacts mp-info" aria-live="polite"></div>
        <?php endif; ?>

        <?php if ($photos !== []): ?>
            <?php $mainUrl = mpb_photo_url($photos[0]['file_name']); ?>
            <div class="mp-gallery">
                <a href="<?= mp_e($mainUrl ?? '') ?>" target="_blank" rel="noopener" id="mpGalleryLink"><img class="mp-gallery__main" id="mpGalleryMain" src="<?= mp_e($mainUrl ?? '') ?>" alt="<?= mp_e($board['title']) ?>"></a>
                <?php if (count($photos) > 1): ?>
                    <div class="mp-gallery__thumbs">
                        <?php foreach ($photos as $i => $p): ?>
                            <a href="<?= mp_e(mpb_photo_url($p['file_name']) ?? '') ?>" target="_blank" rel="noopener" data-full="<?= mp_e(mpb_photo_url($p['file_name']) ?? '') ?>">
                                <img src="<?= mp_e(mpb_photo_url($p['thumb_name']) ?? '') ?>" alt="<?= mp_e(sprintf(t('mpb_photo_n'), $i + 1)) ?>" loading="lazy">
                            </a>
                        <?php endforeach; ?>
                    </div>
                <?php endif; ?>
            </div>
        <?php endif; ?>

        <?php // Службова інформація (не поля форми) — після полів, тим самим стилем. ?>
        <div class="mp-info">
            <?php if (!empty($board['seller_name'])): ?>
                <p class="mp-info__row"><span class="mp-info__label"><?= mp_e(t('mp_seller_label')) ?>:</span> <?= mp_e($board['seller_name']) ?></p>
            <?php endif; ?>
            <?php if (!empty($board['published_at'])): ?>
                <p class="mp-info__row"><span class="mp-info__label"><?= mp_e(t('mpb_published_label')) ?>:</span> <?= mp_e(date('d.m.Y', (int) strtotime((string) $board['published_at']))) ?></p>
            <?php endif; ?>
            <p class="mp-info__row"><span class="mp-info__label"><?= mp_e(t('mpb_views')) ?>:</span> <?= (int) $board['views_count'] ?></p>
        </div>

        <?php if ($isOwner): ?>
            <div class="mp-alert mp-alert--ok"><?= mp_e(t('mpb_own_note')) ?> <a href="mp-post.php?id=<?= $bid ?>"><?= mp_e(t('mpb_edit_btn')) ?></a> · <a href="mp-my.php"><?= mp_e(t('mpb_my_link')) ?></a></div>
        <?php endif; ?>

        <?php if ($isLive && !$isOwner): ?>
            <details class="mp-report">
                <summary><?= mp_e(t('mpb_report_btn')) ?></summary>
                <?php if ($viewerId !== null): ?>
                    <form method="post" action="mp-report.php" class="mp-form">
                        <?= mp_csrf_field() ?><input type="hidden" name="id" value="<?= $bid ?>">
                        <div class="mp-field">
                            <label class="mp-label" for="rp_reason"><?= mp_e(t('mpb_report_reason')) ?></label>
                            <select class="mp-input" id="rp_reason" name="reason" required>
                                <?php foreach ($reasons as $k => $label): ?><option value="<?= mp_e($k) ?>"><?= mp_e($label) ?></option><?php endforeach; ?>
                            </select>
                        </div>
                        <div class="mp-field">
                            <label class="mp-label" for="rp_note"><?= mp_e(t('mpb_report_note')) ?></label>
                            <textarea class="mp-input" id="rp_note" name="note" rows="3" maxlength="500"></textarea>
                        </div>
                        <button class="mp-btn" type="submit"><?= mp_e(t('mpb_report_send')) ?></button>
                    </form>
                <?php else: ?>
                    <p class="mp-text"><?= mp_e(t('mpb_report_login')) ?> <a href="login.php"><?= mp_e(t('nav_login')) ?></a></p>
                <?php endif; ?>
            </details>
        <?php endif; ?>

        <p class="mp-note mp-note--box"><?= mp_e(t('mpb_disclaimer')) ?></p>

        <?php if ($others !== []): ?>
            <h2 class="mp-section-title"><?= mp_e(t('mpb_seller_other')) ?></h2>
            <div class="mp-grid">
                <?php foreach ($others as $card): ?>
                    <?php include __DIR__ . '/mpb-card.php'; ?>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>
    </div>
    <script>
    (function () {
        // Галерея: клік по мініатюрі підміняє головне фото (без JS мініатюри просто відкривають фото).
        var main = document.getElementById('mpGalleryMain'), link = document.getElementById('mpGalleryLink');
        document.querySelectorAll('.mp-gallery__thumbs a').forEach(function (a) {
            a.addEventListener('click', function (e) { e.preventDefault(); main.src = a.dataset.full; link.href = a.dataset.full; });
        });

        // «Показати контакт»: POST на mp-contact.php, контакти виводяться лише після відповіді.
        var form = document.getElementById('mpContactForm'), box = document.getElementById('mpContacts');
        if (!form || !box) { return; }
        function safeHref(h) { return /^(tel:|mailto:|https:\/\/t\.me\/)/.test(h || '') ? h : null; }
        function say(text, loginUrl, verifyUrl) {
            box.textContent = '';
            var p = document.createElement('p'); p.className = 'mp-text'; p.textContent = text; box.appendChild(p);
            if (loginUrl) { var a = document.createElement('a'); a.className = 'mp-btn mp-btn--primary'; a.href = loginUrl; a.textContent = <?= json_encode(t('nav_login'), JSON_UNESCAPED_UNICODE | JSON_HEX_TAG) ?>; box.appendChild(a); }
            if (verifyUrl) { var b = document.createElement('a'); b.className = 'mp-btn mp-btn--primary'; b.href = verifyUrl; b.textContent = <?= json_encode(t('mpv_send_btn'), JSON_UNESCAPED_UNICODE | JSON_HEX_TAG) ?>; box.appendChild(b); }
        }
        form.addEventListener('submit', function (e) {
            e.preventDefault();
            fetch(form.action, { method: 'POST', body: new FormData(form), credentials: 'same-origin', headers: { 'Accept': 'application/json' } })
                .then(function (r) { return r.json().catch(function () { return {}; }); })
                .then(function (j) {
                    if (!j.ok) { say(j.message || form.dataset.error, j.login_url, j.verify_url); return; }
                    box.textContent = '';
                    var ul = document.createElement('ul'); ul.className = 'mp-contact-list';
                    j.contacts.forEach(function (c) {
                        var li = document.createElement('li'), l = document.createElement('span');
                        l.className = 'mp-contact-list__label'; l.textContent = c.label + ' '; li.appendChild(l);
                        var h = safeHref(c.href), v = document.createElement(h ? 'a' : 'span');
                        v.className = 'mp-contact'; v.textContent = c.value;
                        if (h) { v.href = h; v.rel = 'nofollow noopener'; }
                        li.appendChild(v); ul.appendChild(li);
                    });
                    box.appendChild(ul);
                })
                .catch(function () { say(form.dataset.error); });
        });
    })();
    </script>
<?php mpb_close(); ?>
