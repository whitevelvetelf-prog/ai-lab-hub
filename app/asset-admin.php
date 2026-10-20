<?php

declare(strict_types=1);

/**
 * AI LAB HUB — адмінка «Цифрових матеріалів» (вкладки в розділі «Маркетплейс: оголошення», account.php):
 *   assets      — черга модерації: превʼю, оригінал (лише модератору), метадані (інший автор / стокове
 *                 джерело), сигнали схожості, декларації, чек-лист, «запитати докази», шаблони відмов;
 *   claims      — скарги на авторські права: черга, рішення з шаблонами, журнал, експорт CSV;
 *   asset_susp  — «Підозріла активність» (без персональних даних) і ручне блокування анонімного хешу;
 *   asset_set   — налаштування (лише admin) і стан сервера (GD/WebP/EXIF, каталоги, секрет).
 * Дії — public/asset-admin-action.php. Тексти адмінки — українською (як решта CRM).
 */

require_once __DIR__ . '/asset.php';

const AST_REJECT_TEMPLATES = [
    'foreign_ip' => 'Схоже на чужого персонажа, бренд чи франшизу без дозволу правовласника.',
    'not_author' => 'Немає підтвердження, що ви автор або маєте права на роботу.',
    'stock' => 'Метадані вказують на стокове джерело чи іншого автора.',
    'real_person' => 'Зображення реальної людини без підтвердженої згоди.',
    'origin' => 'Декларація походження не відповідає роботі (AI-згенероване подано як ручну роботу).',
    'unsafe' => 'Заборонений контент (зокрема неповнолітні в небезпечному чи інтимному контексті).',
    'quality' => 'Файл пошкоджений або неналежної якості.',
    'license' => 'Умови ліцензії некоректні або суперечливі.',
    'duplicate' => 'Такий самий матеріал уже опубліковано.',
];
const AST_CLAIM_REPLY_TEMPLATES = [
    'disabled' => 'Порушення підтверджено, матеріал приховано.',
    'restored' => 'Після розгляду зустрічної заяви матеріал відновлено.',
    'rejected' => 'Скаргу відхилено: недостатньо доказів порушення.',
    'review' => 'Скаргу взято на розгляд.',
];

function ast_admin_tabs(array $tabs, bool $isAdmin): array
{
    $tabs['assets'] = 'Цифрові матеріали';
    $tabs['claims'] = 'Скарги (авторські права)';
    $tabs['asset_susp'] = 'Підозріла активність';
    if ($isAdmin) {
        $tabs['asset_set'] = 'Активи: налаштування';
    }

    return $tabs;
}

function ast_admin_panels(PDO $pdo, string $tab, bool $isAdmin): void
{
    try {
        $pdo->query('SELECT 1 FROM mp_assets LIMIT 1');
    } catch (Throwable $e) {
        if (in_array($tab, ['assets', 'claims', 'asset_susp', 'asset_set'], true)) {
            echo '<p class="pc-note pc-note--warn">Застосуйте міграцію database/migration-2026-10-22-digital-assets.sql.</p>';
        }

        return;
    }
    $csrf = mp_csrf_field();
    if ($tab === 'assets') {
        ast_admin_queue_html($pdo, $csrf);
    } elseif ($tab === 'claims') {
        ast_admin_claims_html($pdo, $csrf);
    } elseif ($tab === 'asset_susp') {
        ast_admin_susp_html($pdo, $csrf);
    } elseif ($tab === 'asset_set' && $isAdmin) {
        ast_admin_settings_html($pdo, $csrf);
    }
}

function ast_admin_queue_html(PDO $pdo, string $csrf): void
{
    $caps = ast_capabilities();
    if (!$caps['ok']) {
        echo '<p class="pc-note pc-note--warn">' . ast_e($caps['message']) . '</p>';
    }
    $ids = $pdo->query("SELECT l.id FROM mp_listings l WHERE l.section = 'asset' AND l.status = 'pending' ORDER BY l.updated_at, l.id LIMIT 50")->fetchAll(PDO::FETCH_COLUMN);
    if ($ids === []) {
        echo '<p class="pc-empty">Черга модерації матеріалів порожня.</p>';
    }
    $rejOptions = '';
    foreach (AST_REJECT_TEMPLATES as $k => $txt) {
        $rejOptions .= '<option value="' . $k . '">' . ast_e($txt) . '</option>';
    }
    foreach ($ids as $id) {
        $r = ast_listing($pdo, (int) $id, 'orig');
        if ($r === null) {
            continue;
        }
        $meta = json_decode((string) $r['meta_json'], true) ?: [];
        $similar = json_decode((string) $r['similar_json'], true) ?: [];
        $u = $pdo->prepare('SELECT email, name FROM users WHERE id = :u');
        $u->execute([':u' => (int) $r['seller_user_id']]);
        $owner = $u->fetch(PDO::FETCH_ASSOC) ?: ['email' => '', 'name' => ''];
        $strikes = ast_strikes($pdo, (int) $r['seller_user_id']);
        $lic = ast_licenses($pdo)[(string) $r['license_code']] ?? null;
        ?>
        <article class="pc-mod">
            <div class="pc-grid-2">
                <div>
                    <img src="<?= ast_e(ast_preview_url($pdo, (int) $id)) ?>" alt="<?= ast_e($r['alt_text']) ?>" style="max-width:100%;height:auto;border-radius:10px">
                    <p><a href="asset-original.php?id=<?= (int) $id ?>" target="_blank" rel="noopener">Оригінал (лише модератору)</a> · <a href="asset.php?id=<?= (int) $id ?>" target="_blank" rel="noopener">Сторінка</a></p>
                </div>
                <dl class="pc-summary">
                    <dt>№ / назва</dt><dd>#<?= (int) $id ?> <?= ast_e($r['title']) ?></dd>
                    <dt>Автор</dt><dd><?= ast_e($r['seller_name']) ?> · <?= ast_e($owner['email']) ?><?= $strikes > 0 ? ' <strong class="pc-warn-text">порушень: ' . $strikes . '</strong>' : '' ?></dd>
                    <dt>Вид</dt><dd><?= ast_e(ast_tr_lang('kind_' . $r['asset_kind'], 'uk')) ?><?= $r['character_name'] ? ' — ' . ast_e($r['character_name']) : '' ?></dd>
                    <dt>Alt</dt><dd><?= ast_e($r['alt_text']) ?></dd>
                    <dt>Походження</dt><dd><?= ast_e(ast_tr_lang('origin_' . $r['origin'], 'uk')) ?></dd>
                    <dt>Декларація прав</dt><dd><?= ast_e($r['ownership_declared_at']) ?> UTC, користувач #<?= (int) $r['ownership_user_id'] ?></dd>
                    <dt>Ліцензія</dt><dd><?= $lic ? ast_e($lic['title_uk']) : ast_e($r['license_code']) ?><?= (int) $r['allow_download'] === 1 ? ', оригінал завантажується' : ', без завантаження' ?>
                        <?php if ($r['license_code'] === 'custom'): ?><br><span class="pc-muted"><?= ast_e(mb_substr((string) $r['license_custom'], 0, 600)) ?></span><?php endif; ?></dd>
                    <dt>Файл</dt><dd><?= (int) $r['width'] ?>×<?= (int) $r['height'] ?>, <?= number_format((int) $r['orig_size'] / 1048576, 2) ?> МБ, <?= ast_e($r['orig_mime']) ?><br><code><?= ast_e(substr((string) $r['orig_sha256'], 0, 24)) ?>…</code></dd>
                    <dt>Метадані</dt><dd>
                        <?= $meta === [] || ($meta['artist'] === '' && $meta['copyright'] === '' && $meta['stock'] === []) ? 'без автора й прав' : '' ?>
                        <?php if (($meta['artist'] ?? '') !== ''): ?>автор: <strong><?= ast_e($meta['artist']) ?></strong><br><?php endif; ?>
                        <?php if (($meta['copyright'] ?? '') !== ''): ?>права: <strong><?= ast_e($meta['copyright']) ?></strong><br><?php endif; ?>
                        <?php if (($meta['stock'] ?? []) !== []): ?><strong class="pc-warn-text">стокове джерело: <?= ast_e(implode(', ', $meta['stock'])) ?></strong><br><?php endif; ?>
                        <?php if (!empty($meta['software'])): ?><span class="pc-muted">програма: <?= ast_e($meta['software']) ?></span><?php endif; ?>
                    </dd>
                    <dt>Схожість</dt><dd><?php if ($similar === []): ?>схожих не знайдено<?php else: foreach ($similar as $sm): ?>
                        <strong class="pc-warn-text"><?= $sm['same_file'] ? 'той самий файл, що' : 'схоже на' ?> оголошення <a href="asset.php?id=<?= (int) $sm['id'] ?>" target="_blank" rel="noopener">#<?= (int) $sm['id'] ?></a></strong> (відстань <?= (int) $sm['distance'] ?>)<br>
                    <?php endforeach; endif; ?></dd>
                </dl>
            </div>
            <div class="pc-box">
                <p><strong>Чек-лист:</strong> відомі чужі персонажі чи бренди? логотипи? реальні люди без згоди? неповнолітні? декларація походження правдоподібна? метадані не вказують на іншого автора чи сток? alt-текст описує зображення?</p>
            </div>
            <form method="post" action="asset-admin-action.php" class="pc-inline-form">
                <?= $csrf ?><input type="hidden" name="id" value="<?= (int) $id ?>">
                <button class="pc-btn pc-btn--primary" type="submit" name="action" value="approve">Схвалити</button>
            </form>
            <form method="post" action="asset-admin-action.php" class="pc-inline-form">
                <?= $csrf ?><input type="hidden" name="id" value="<?= (int) $id ?>">
                <select name="template" aria-label="Причина"><?= $rejOptions ?></select>
                <input type="text" name="comment" maxlength="300" placeholder="Коментар (необов'язково)" aria-label="Коментар">
                <button class="pc-btn pc-btn--danger" type="submit" name="action" value="reject">Відхилити</button>
                <button class="pc-btn" type="submit" name="action" value="request_proof">Запитати докази авторства</button>
            </form>
        </article>
        <?php
    }
    $counts = $pdo->query("SELECT status, COUNT(*) FROM mp_listings WHERE section = 'asset' GROUP BY status")->fetchAll(PDO::FETCH_KEY_PAIR);
    echo '<p class="pc-muted">Матеріали за статусами: ' . ast_e(json_encode($counts, JSON_UNESCAPED_UNICODE)) . '. Публічні лише схвалені.</p>';
}

function ast_admin_claims_html(PDO $pdo, string $csrf): void
{
    $rows = $pdo->query(
        "SELECT c.*, t.title FROM copyright_claims c LEFT JOIN mp_listings l ON l.id = c.listing_id
         LEFT JOIN mp_listing_translations t ON t.listing_id = l.id AND t.lang = l.source_lang
         ORDER BY FIELD(c.status, 'new', 'counter_notice', 'content_disabled', 'under_review', 'restored', 'rejected'), c.id DESC LIMIT 200"
    )->fetchAll(PDO::FETCH_ASSOC);
    echo '<p><a class="pc-btn" href="asset-admin-action.php?export=claims">Експорт CSV</a></p>';
    if ($rows === []) {
        echo '<p class="pc-empty">Скарг немає.</p>';

        return;
    }
    $tpl = '';
    foreach (AST_CLAIM_REPLY_TEMPLATES as $k => $txt) {
        $tpl .= '<option value="' . ast_e($txt) . '">' . ast_e($txt) . '</option>';
    }
    foreach ($rows as $c) {
        $log = $pdo->prepare('SELECT action, note, created_at FROM copyright_claim_log WHERE claim_id = :c ORDER BY id');
        $log->execute([':c' => (int) $c['id']]);
        ?>
        <article class="pc-mod">
            <dl class="pc-summary">
                <dt>Скарга</dt><dd>№<?= (int) $c['id'] ?> · <?= ast_e($c['created_at']) ?> · <strong><?= ast_e(ast_tr_lang('cst_' . $c['status'], 'uk')) ?></strong><?= (int) $c['auto_hidden'] === 1 ? ' · приховано автоматично' : '' ?></dd>
                <dt>Матеріал</dt><dd><?php if ($c['listing_id']): ?><a href="asset.php?id=<?= (int) $c['listing_id'] ?>" target="_blank" rel="noopener">#<?= (int) $c['listing_id'] ?> <?= ast_e($c['title']) ?></a><?php else: ?><?= ast_e($c['listing_ref']) ?> (не розпізнано)<?php endif; ?></dd>
                <dt>Що порушено</dt><dd class="mp-text--pre"><?= ast_e($c['what_infringed']) ?></dd>
                <dt>Докази</dt><dd class="mp-text--pre"><?= ast_e((string) $c['evidence']) ?></dd>
                <dt>Заявник</dt><dd><?= ast_e($c['claimant_name']) ?> · <?= ast_e($c['claimant_email']) ?><?= $c['claimant_contact'] ? ' · ' . ast_e($c['claimant_contact']) : '' ?></dd>
                <dt>Зустрічна заява</dt><dd><?= $c['counter_at'] ? ast_e($c['counter_at']) . '<br><span class="mp-text--pre">' . ast_e($c['counter_text']) . '</span>' : 'немає (строк до ' . ast_e((string) $c['counter_deadline']) . ')' ?></dd>
                <dt>Журнал</dt><dd><?php foreach ($log as $l): ?><?= ast_e($l['created_at'] . ' ' . $l['action'] . ($l['note'] ? ': ' . $l['note'] : '')) ?><br><?php endforeach; ?></dd>
            </dl>
            <form method="post" action="asset-admin-action.php" class="pc-inline-form">
                <?= $csrf ?><input type="hidden" name="claim_id" value="<?= (int) $c['id'] ?>">
                <select name="status" aria-label="Рішення">
                    <option value="under_review">На розгляд</option>
                    <option value="content_disabled">Приховати матеріал (порушення підтверджено)</option>
                    <option value="restored">Відновити матеріал</option>
                    <option value="rejected">Відхилити скаргу</option>
                </select>
                <select name="note" aria-label="Шаблон відповіді"><option value="">— шаблон відповіді —</option><?= $tpl ?></select>
                <input type="text" name="note_extra" maxlength="500" placeholder="Додатково (необов'язково)" aria-label="Додатково">
                <button class="pc-btn pc-btn--primary" type="submit" name="action" value="claim_decide">Зберегти рішення</button>
            </form>
        </article>
        <?php
    }
}

function ast_admin_susp_html(PDO $pdo, string $csrf): void
{
    echo '<p class="pc-muted">Записи без персональних даних: лише анонімний хеш IP (сіль, IPv6 → /64). Тимчасові блоки знімаються самі через «assets_block_minutes»; ручні — безстрокові.</p>';
    $rows = $pdo->query(
        "SELECT anon_hash, COUNT(*) AS n, GROUP_CONCAT(DISTINCT reason) AS reasons, MAX(created_at) AS last_at
         FROM asset_suspicious WHERE created_at >= NOW() - INTERVAL 7 DAY GROUP BY anon_hash ORDER BY last_at DESC LIMIT 100"
    )->fetchAll(PDO::FETCH_ASSOC);
    $blocked = $pdo->query('SELECT * FROM asset_blocked_hashes WHERE expires_at IS NULL OR expires_at > NOW() ORDER BY created_at DESC LIMIT 100')->fetchAll(PDO::FETCH_ASSOC);
    echo '<h3 class="pc-h3">Останні 7 днів</h3>';
    if ($rows === []) {
        echo '<p class="pc-empty">Підозрілої активності немає.</p>';
    } else {
        echo '<div class="pc-table-wrap"><table class="pc-table"><thead><tr><th>Хеш</th><th>Подій</th><th>Причини</th><th>Остання</th><th>Дія</th></tr></thead><tbody>';
        foreach ($rows as $r) {
            echo '<tr><td data-label="Хеш"><code>' . ast_e(substr((string) $r['anon_hash'], 0, 16)) . '…</code></td><td data-label="Подій">' . (int) $r['n'] . '</td>'
                . '<td data-label="Причини">' . ast_e($r['reasons']) . '</td><td data-label="Остання">' . ast_e($r['last_at']) . '</td>'
                . '<td data-label="Дія"><form method="post" action="asset-admin-action.php" class="pc-inline-form">' . $csrf
                . '<input type="hidden" name="hash" value="' . ast_e($r['anon_hash']) . '"><button class="pc-btn pc-btn--small" type="submit" name="action" value="block">Заблокувати</button></form></td></tr>';
        }
        echo '</tbody></table></div>';
    }
    echo '<h3 class="pc-h3">Заблоковані</h3>';
    if ($blocked === []) {
        echo '<p class="pc-empty">Немає.</p>';

        return;
    }
    echo '<div class="pc-table-wrap"><table class="pc-table"><thead><tr><th>Хеш</th><th>Причина</th><th>До</th><th>Дія</th></tr></thead><tbody>';
    foreach ($blocked as $b) {
        echo '<tr><td data-label="Хеш"><code>' . ast_e(substr((string) $b['anon_hash'], 0, 16)) . '…</code></td><td data-label="Причина">' . ast_e((string) $b['reason']) . '</td>'
            . '<td data-label="До">' . ast_e($b['expires_at'] ?? 'безстроково') . '</td>'
            . '<td data-label="Дія"><form method="post" action="asset-admin-action.php" class="pc-inline-form">' . $csrf
            . '<input type="hidden" name="hash" value="' . ast_e($b['anon_hash']) . '"><button class="pc-btn pc-btn--small" type="submit" name="action" value="unblock">Розблокувати</button></form></td></tr>';
    }
    echo '</tbody></table></div>';
}

/** Ключі налаштувань, що змінюються у вкладці (ключ => [підпис, тип]). */
const AST_ADMIN_SETTINGS = [
    'assets_max_mb' => ['Максимальний розмір файлу, МБ', 'int'],
    'assets_preview_px' => ['Довша сторона превʼю, пікселів', 'int'],
    'assets_preview_ttl_min' => ['Термін дії адреси превʼю, хвилин', 'int'],
    'assets_preview_per_min' => ['Ліміт запитів превʼю з одного хешу за хвилину', 'int'],
    'assets_unique_burst' => ['Різних превʼю за 5 хвилин до тимчасового блоку', 'int'],
    'assets_block_minutes' => ['Тривалість тимчасового блоку, хвилин', 'int'],
    'assets_downloads_per_day' => ['Завантажень оригіналів на користувача за добу', 'int'],
    'assets_download_token_min' => ['Термін дії токена завантаження, хвилин', 'int'],
    'assets_similarity_threshold' => ['Поріг схожості dHash (0–32; менше — суворіше)', 'int'],
    'assets_listing_days' => ['Строк публікації матеріалу, днів', 'int'],
    'copyright_counter_days' => ['Строк зустрічної заяви, днів', 'int'],
    'copyright_strikes_limit' => ['Підтверджених порушень до блоку публікації активів', 'int'],
    'assets_context_guard' => ['Перешкода збереженню превʼю (контекстне меню) — лише перешкода, не захист', 'bool'],
    'copyright_auto_hide' => ['Автоматично приховувати актив після скарги до розгляду', 'bool'],
];

function ast_admin_settings_html(PDO $pdo, string $csrf): void
{
    $caps = ast_capabilities();
    $st = ast_storage();
    ?>
    <h3 class="pc-h3">Стан сервера</h3>
    <ul>
        <li>GD: <?= $caps['gd'] ? 'є' : '<strong class="pc-warn-text">немає — публікація активів вимкнена</strong>' ?>; WebP: <?= $caps['webp'] ? 'є' : 'немає (превʼю у JPEG)' ?>; поворот водяного знака: <?= $caps['rotate'] ? 'є' : 'немає (горизонтальний знак)' ?>; fileinfo: <?= $caps['fileinfo'] ? 'є' : '<strong class="pc-warn-text">немає</strong>' ?>; EXIF: <?= $caps['exif'] ? 'є' : 'немає (метадані JPEG читаються лише з XMP)' ?>; Imagick: <?= extension_loaded('imagick') ? 'є' : 'немає (не потрібен)' ?>.</li>
        <li>upload_max_filesize = <?= ast_e(ini_get('upload_max_filesize')) ?>, post_max_size = <?= ast_e(ini_get('post_max_size')) ?>, memory_limit = <?= ast_e(ini_get('memory_limit')) ?>.</li>
        <?php foreach ($st['warnings'] as $w): ?><li class="pc-warn-text"><?= ast_e($w) ?></li><?php endforeach; ?>
    </ul>
    <p class="pc-muted">Чесно про межі: метадані у виданих файлах (XMP з номером завантаження) легко прибрати — це доказова підтримка, а не захист. robots.txt і мета-теги noai/noimageai — добровільні сигнали, не всі ШІ-краулери їх поважають. Перешкода контекстному меню не заважає знімку екрана.</p>
    <form method="post" action="asset-admin-action.php">
        <?= $csrf ?>
        <div class="pc-table-wrap"><table class="pc-table"><tbody>
        <?php foreach (AST_ADMIN_SETTINGS as $k => [$label, $type]): $val = site_setting($pdo, $k, ''); ?>
            <tr><td data-label="Налаштування"><?= ast_e($label) ?><br><span class="pc-muted"><?= ast_e($k) ?></span></td>
                <td data-label="Значення"><?php if ($type === 'bool'): ?>
                    <label class="pc-check"><input type="checkbox" name="s[<?= $k ?>]" value="1"<?= $val === '1' ? ' checked' : '' ?>> <span>так</span></label>
                <?php else: ?>
                    <input type="number" name="s[<?= $k ?>]" value="<?= ast_e($val) ?>" min="0" style="width:7em">
                <?php endif; ?></td></tr>
        <?php endforeach; ?>
        </tbody></table></div>
        <button class="pc-btn pc-btn--primary" type="submit" name="action" value="settings">Зберегти налаштування</button>
    </form>
    <?php
}
