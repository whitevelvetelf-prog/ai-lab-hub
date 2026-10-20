<?php

declare(strict_types=1);

/**
 * AI LAB HUB — список «Цифрових матеріалів» маркетплейсу (лише схвалені й не прострочені).
 *
 *   assets.php [?kind=image|illustration|character] [&license=код] [&q=…] [&page=N]
 *
 * Превʼю — підписані адреси asset-preview.php з терміном дії; alt-текст обов'язковий.
 * Мета-теги noai/noimageai (добровільні сигнали для ШІ-краулерів).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/asset.php';
require_once __DIR__ . '/../app/analytics.php';

mp_public_require();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
$lang = current_lang();
$get = static fn(string $k, int $max = 100): string => is_string($_GET[$k] ?? null) ? mb_substr(trim((string) $_GET[$k]), 0, $max) : '';
$licenses = ast_licenses($pdo);
$filters = [
    'kind' => in_array($get('kind', 20), AST_KINDS, true) ? $get('kind', 20) : '',
    'license' => isset($licenses[$get('license', 30)]) ? $get('license', 30) : '',
    'q' => $get('q'),
];
$hasFilters = $filters['kind'] !== '' || $filters['license'] !== '' || $filters['q'] !== '';
$result = ast_search($pdo, $lang, $filters, max(1, (int) ($_GET['page'] ?? 1)));
analytics_log_view($pdo, $hasFilters ? 'marketplace_search' : 'marketplace_category', null, 'asset');

$pageUrl = static function (int $p) use ($filters): string {
    $q = array_filter($filters + ['page' => $p > 1 ? $p : null], static fn($x): bool => $x !== null && $x !== '');

    return 'assets.php' . ($q !== [] ? '?' . http_build_query($q) : '');
};

ast_open(ast_tr('nav'), ast_meta_robots(true, !mp_public_enabled()) . "\n" . '<link rel="canonical" href="' . ast_e(mail_site_url_safe() . '/assets.php') . '">');
?>
    <div class="mp-page">
        <h1 class="mp-title"><?= ast_e(ast_tr('nav')) ?></h1>
        <p class="mp-subtitle"><?= ast_e(ast_tr('sub')) ?></p>
        <p class="mp-note mp-note--box mp-note--disclaimer" role="note"><?= mp_e(t('mpb_disclaimer')) ?> <a href="copyright-policy.php"><?= ast_e(ast_tr('policy_link')) ?></a></p>
        <p class="mp-actions mp-actions--tight"><a class="mp-btn mp-btn--primary" href="asset-post.php"><?= ast_e(ast_tr('post_btn')) ?></a></p>
        <?= mpb_flash_html() ?>

        <form class="mp-filters" method="get" action="assets.php" role="search">
            <div class="mp-field mp-field--grow">
                <label class="mp-label" for="f_q"><?= ast_e(ast_tr('filter_q')) ?></label>
                <input class="mp-input" type="search" id="f_q" name="q" maxlength="100" value="<?= ast_e($filters['q']) ?>">
            </div>
            <div class="mp-field">
                <label class="mp-label" for="f_kind"><?= ast_e(ast_tr('filter_kind')) ?></label>
                <select class="mp-input" id="f_kind" name="kind">
                    <option value=""><?= ast_e(ast_tr('kinds_all')) ?></option>
                    <?php foreach (AST_KINDS as $k): ?><option value="<?= $k ?>"<?= $filters['kind'] === $k ? ' selected' : '' ?>><?= ast_e(ast_tr('kind_' . $k)) ?></option><?php endforeach; ?>
                </select>
            </div>
            <div class="mp-field">
                <label class="mp-label" for="f_lic"><?= ast_e(ast_tr('filter_license')) ?></label>
                <select class="mp-input" id="f_lic" name="license">
                    <option value=""><?= ast_e(ast_tr('licenses_all')) ?></option>
                    <?php foreach ($licenses as $code => $lic): ?><option value="<?= ast_e($code) ?>"<?= $filters['license'] === $code ? ' selected' : '' ?>><?= ast_e(ast_license_title($lic, $lang)) ?></option><?php endforeach; ?>
                </select>
            </div>
            <div class="mp-actions mp-actions--tight">
                <button class="mp-btn mp-btn--primary" type="submit"><?= ast_e(ast_tr('filter_apply')) ?></button>
                <?php if ($hasFilters): ?><a class="mp-btn" href="assets.php"><?= ast_e(ast_tr('filter_reset')) ?></a><?php endif; ?>
            </div>
        </form>

        <p class="mp-count"><?= ast_e(ast_tr('found', $result['total'])) ?></p>
        <?php if ($result['rows'] === []): ?>
            <p class="mp-empty"><?= ast_e(ast_tr($hasFilters ? 'empty_search' : 'empty')) ?></p>
        <?php else: ?>
            <div class="mp-grid ast-guard">
                <?php foreach ($result['rows'] as $r) { echo ast_card_html($pdo, $r); } ?>
            </div>
            <?php if ($result['pages'] > 1): ?>
                <nav class="mp-pager" aria-label="<?= ast_e(ast_tr('pages')) ?>">
                    <?php for ($p = 1; $p <= $result['pages']; $p++): ?>
                        <a class="mp-btn<?= $p === $result['page'] ? ' mp-btn--primary' : '' ?>" href="<?= ast_e($pageUrl($p)) ?>"<?= $p === $result['page'] ? ' aria-current="page"' : '' ?>><?= $p ?></a>
                    <?php endfor; ?>
                </nav>
            <?php endif; ?>
        <?php endif; ?>
    </div>
    <?= ast_guard_script($pdo) ?>
<?php mpb_close(); ?>
