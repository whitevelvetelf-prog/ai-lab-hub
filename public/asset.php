<?php

declare(strict_types=1);

/**
 * AI LAB HUB — сторінка «Цифрового матеріалу»: превʼю (підписана адреса, водяний знак, alt), ліцензія з іконкою
 * й повними умовами, автор, позначка походження (вручну / за участі AI / повністю AI), теги, персонаж.
 * «Завантажити оригінал» — лише за ліцензією й дозволом автора, для залогіненого, з прийняттям ліцензії
 * (asset-download.php). Комерційна / лише перегляд — «Зв'язатися з автором» (mp-contact.php, як у дошці).
 * «Повідомити про порушення» — copyright-report.php. Мета-теги noai/noimageai (+ noimageindex за вибором автора).
 *
 *   asset.php?id=N    — живий актив усім; неопублікований — лише власнику й співробітникам (noindex)
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/asset.php';
require_once __DIR__ . '/../app/analytics.php';

mp_public_or_staff_require();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
$lang = current_lang();
$id = (int) ($_GET['id'] ?? 0);
$row = $id > 0 ? ast_listing($pdo, $id, $lang) : null;
if ($row === null) {
    mp_not_found();
}
$uid = auth_user_id();
$isOwner = $uid !== null && (int) $row['seller_user_id'] === $uid;
$live = ast_is_live($row);
if (!$live && !$isOwner && !mp_is_staff()) {
    mp_not_found();
}
if ($live && !$isOwner) {
    mpb_count_view($pdo, $id, $row['seller_user_id'] !== null ? (int) $row['seller_user_id'] : null);
    analytics_log_view($pdo, 'marketplace_listing', $id, 'asset');
}
$lic = ast_licenses($pdo)[(string) $row['license_code']] ?? null;
$licText = (string) $row['license_code'] === 'custom'
    ? (string) $row['license_custom']
    : (string) ($lic !== null ? ($lang === 'en' ? $lic['text_en'] : $lic['text_uk']) : '');
$downloadable = $live && ast_downloadable($pdo, $row);
$hasContact = (string) ($row['contact_email'] ?? '') !== '' || (string) ($row['contact_telegram'] ?? '') !== '';
$tags = array_values(array_filter(array_map('trim', explode(',', (string) $row['tags']))));

$head = ast_meta_robots((int) $row['noimageindex'] === 1, !($live && mp_public_enabled()))
    . "\n" . '<link rel="canonical" href="' . ast_e(mail_site_url_safe() . '/asset.php?id=' . $id) . '">'
    . ($lic !== null && (string) $row['license_code'] === 'cc_by' ? "\n" . '<link rel="license" href="https://creativecommons.org/licenses/by/4.0/">' : '');
ast_open((string) $row['title'], $head);
?>
    <div class="mp-page mp-page--narrow">
        <p><a class="mp-back" href="assets.php"><?= ast_e(ast_tr('nav')) ?></a></p>
        <p class="mp-note mp-note--box mp-note--disclaimer" role="note"><?= mp_e(t('mpb_disclaimer')) ?></p>
        <?= mpb_flash_html() ?>
        <?php if (!$live): ?>
            <div class="mp-alert mp-alert--error"><?= ast_e(ast_tr('st_' . ((string) $row['status'] === 'disabled' ? 'disabled' : (string) $row['status']))) ?>
                <?php if ((string) $row['status'] === 'rejected' && !empty($row['reject_reason'])): ?> — <?= ast_e($row['reject_reason']) ?><?php endif; ?></div>
        <?php endif; ?>

        <article class="mp-panel ast-item">
            <p class="mp-card__tag"><?= ast_e(ast_tr('kind_' . $row['asset_kind'])) ?> · <?= ast_origin_badge((string) $row['origin']) ?></p>
            <h1 class="mp-title"><?= ast_e($row['title']) ?></h1>
            <figure class="ast-figure ast-guard">
                <img src="<?= ast_e(ast_preview_url($pdo, $id)) ?>" alt="<?= ast_e($row['alt_text']) ?>" width="<?= (int) $row['preview_w'] ?>" height="<?= (int) $row['preview_h'] ?>" draggable="false" decoding="async">
                <figcaption class="mp-hint"><?= ast_e(ast_tr('preview_note')) ?></figcaption>
            </figure>

            <dl class="mp-facts">
                <div class="mp-fact"><dt class="mp-fact__label"><?= ast_e(ast_tr('author')) ?></dt><dd class="mp-fact__value"><?= ast_e($row['seller_name']) ?></dd></div>
                <div class="mp-fact"><dt class="mp-fact__label"><?= ast_e(ast_tr('license')) ?></dt><dd class="mp-fact__value"><?= ast_license_badge($pdo, (string) $row['license_code']) ?></dd></div>
                <div class="mp-fact"><dt class="mp-fact__label"><?= ast_e(ast_tr('origin_label')) ?></dt><dd class="mp-fact__value"><?= ast_e(ast_tr('origin_' . $row['origin'])) ?></dd></div>
                <?php if (!empty($row['published_at'])): ?>
                    <div class="mp-fact"><dt class="mp-fact__label"><?= ast_e(ast_tr('published')) ?></dt><dd class="mp-fact__value"><?= ast_e(date('d.m.Y', (int) strtotime((string) $row['published_at']))) ?></dd></div>
                <?php endif; ?>
                <?php if ((string) $row['asset_kind'] === 'character' && !empty($row['character_name'])): ?>
                    <div class="mp-fact"><dt class="mp-fact__label"><?= ast_e(ast_tr('character_name')) ?></dt><dd class="mp-fact__value"><?= ast_e($row['character_name']) ?></dd></div>
                <?php endif; ?>
            </dl>

            <?php if (trim((string) $row['full_desc']) !== ''): ?>
                <div class="mp-block"><div class="mp-text mp-text--pre"><?= ast_e($row['full_desc']) ?></div></div>
            <?php endif; ?>
            <?php if ((string) $row['asset_kind'] === 'character' && (!empty($row['character_desc']) || !empty($row['character_terms']))): ?>
                <div class="mp-block">
                    <?php if (!empty($row['character_desc'])): ?><p class="mp-text"><?= ast_e($row['character_desc']) ?></p><?php endif; ?>
                    <?php if (!empty($row['character_terms'])): ?>
                        <h2 class="mp-block__title"><?= ast_e(ast_tr('character_terms')) ?></h2>
                        <p class="mp-text mp-text--pre"><?= ast_e($row['character_terms']) ?></p>
                    <?php endif; ?>
                </div>
            <?php endif; ?>
            <?php if ($tags !== []): ?>
                <p class="lst-card__tags"><?php foreach ($tags as $tg): ?><a class="mp-badge" href="assets.php?q=<?= ast_e(rawurlencode($tg)) ?>"><?= ast_e($tg) ?></a> <?php endforeach; ?></p>
            <?php endif; ?>

            <section class="mp-block ast-license-box" id="license">
                <h2 class="mp-block__title"><?= ast_license_badge($pdo, (string) $row['license_code']) ?></h2>
                <?php if ($lic !== null): ?><p class="mp-text"><?= ast_e($lang === 'en' ? $lic['summary_en'] : $lic['summary_uk']) ?></p><?php endif; ?>
                <?php if ($licText !== ''): ?>
                    <details><summary><?= ast_e(ast_tr('license_full')) ?></summary><p class="mp-text mp-text--pre"><?= ast_e($licText) ?></p></details>
                <?php endif; ?>
            </section>

            <?php if ($live && !$isOwner): ?>
                <div class="mp-offer__actions">
                    <?php if ($downloadable): ?>
                        <?php if ($uid === null): ?>
                            <p class="mp-text"><?= ast_e(ast_tr('download_login')) ?> <a href="login.php"><?= mp_e(t('nav_login')) ?></a></p>
                        <?php else: ?>
                            <form method="post" action="asset-download.php" class="mp-form ast-download">
                                <?= mp_csrf_field() ?><input type="hidden" name="id" value="<?= $id ?>">
                                <label class="mp-check"><input type="checkbox" name="accept" value="1" required> <span><?= ast_e(ast_tr('download_accept', $lic !== null ? ast_license_title($lic, $lang) : '')) ?></span></label>
                                <button class="mp-btn mp-btn--primary mp-btn--lg" type="submit"><?= ast_e(ast_tr('download_btn')) ?></button>
                                <p class="mp-hint"><?= ast_e(ast_tr('download_note')) ?></p>
                            </form>
                        <?php endif; ?>
                    <?php else: ?>
                        <p class="mp-text"><?= ast_e(ast_tr('download_not_allowed')) ?></p>
                    <?php endif; ?>
                    <?php if ($hasContact): ?>
                        <form method="post" action="mp-contact.php" id="mpContactForm" data-error="<?= mp_e(t('mpb_contact_error')) ?>">
                            <?= mp_csrf_field() ?><input type="hidden" name="id" value="<?= $id ?>">
                            <button class="mp-btn mp-btn--lg" type="submit"><?= ast_e(ast_tr('download_contact')) ?></button>
                        </form>
                        <div id="mpContacts" class="mp-contacts mp-info" aria-live="polite"></div>
                    <?php endif; ?>
                </div>
            <?php endif; ?>
        </article>

        <p class="mp-actions">
            <a class="mp-btn" href="copyright-report.php?listing=<?= $id ?>"><?= ast_e(ast_tr('report_btn')) ?></a>
            <a href="copyright-policy.php"><?= ast_e(ast_tr('policy_link')) ?></a>
        </p>
        <?php if ($isOwner): ?>
            <p class="mp-actions"><a class="mp-btn" href="asset-post.php?id=<?= $id ?>"><?= ast_e(ast_tr('my_edit')) ?></a>
                <a class="mp-btn" href="asset-proof.php?id=<?= $id ?>"><?= ast_e(ast_tr('my_proof')) ?></a>
                <a class="mp-btn" href="account.php#acc-assets"><?= ast_e(ast_tr('my_title')) ?></a></p>
        <?php endif; ?>
        <?php if (ast_settings($pdo)['context_guard']): ?><p class="mp-hint"><?= ast_e(ast_tr('guard_note')) ?></p><?php endif; ?>
    </div>
    <?= ast_guard_script($pdo) ?>
    <?php if ($hasContact && $live && !$isOwner): ?>
    <script>
    (function () {
        // «Зв'язатися з автором»: POST на mp-contact.php (ліміти й підтвердження e-mail — як у дошці оголошень).
        var form = document.getElementById('mpContactForm'), box = document.getElementById('mpContacts');
        if (!form || !box) { return; }
        function safeHref(h) { return /^(tel:|mailto:|https:\/\/t\.me\/)/.test(h || '') ? h : null; }
        form.addEventListener('submit', function (e) {
            e.preventDefault();
            fetch(form.action, { method: 'POST', body: new FormData(form), credentials: 'same-origin', headers: { 'Accept': 'application/json' } })
                .then(function (r) { return r.json().catch(function () { return {}; }); })
                .then(function (j) {
                    box.textContent = '';
                    if (!j.ok) {
                        var p = document.createElement('p'); p.className = 'mp-text'; p.textContent = j.message || form.dataset.error; box.appendChild(p);
                        if (j.login_url) { var a = document.createElement('a'); a.className = 'mp-btn mp-btn--primary'; a.href = j.login_url; a.textContent = <?= json_encode(t('nav_login'), JSON_UNESCAPED_UNICODE | JSON_HEX_TAG) ?>; box.appendChild(a); }
                        return;
                    }
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
                .catch(function () { box.textContent = form.dataset.error; });
        });
    })();
    </script>
    <?php endif; ?>
<?php mpb_close(); ?>
