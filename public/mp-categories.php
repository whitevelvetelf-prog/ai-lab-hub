<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: керування деревом категорій (лише admin; іншим — 404).
 *
 * Перегляд дерева (блоки → підкатегорії, кількість живих оголошень), для кожного рядка: назва uk і en, порядок,
 * піктограма з набору MPT_ICONS, активна/прихована. Додавання підкатегорії в блок. Затвердження «чернетки списку»
 * (is_draft): нові категорії видно й до затвердження, позначка — лише для admin.
 * Видалення немає — лише деактивація (прив'язки оголошень лишаються). Будь-яка зміна скидає кеш лічильників.
 * POST з CSRF, prepared statements, PRG із повідомленням.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/listing.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

if (mp_live_role() !== 'admin') {
    mp_not_found();
}
header('Cache-Control: no-store');
$adminId = (int) auth_user_id();

if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    if (!mp_csrf_verify()) {
        mpb_message_page(403, t('mpb_err_csrf_title'), '<p class="mp-text">' . mp_e(t('mpb_err_csrf')) . '</p>', 'mp-categories.php');
    }
    $str = static fn(string $k, int $max = 150): string => is_string($_POST[$k] ?? null) ? mb_substr(trim((string) $_POST[$k]), 0, $max) : '';
    $tree = mpt_tree($pdo, 'uk', true);
    $action = $str('action', 20);
    $msg = 'Нічого не змінено.';
    $setName = $pdo->prepare(
        'INSERT INTO mp_category_translations (category_id, lang, name, is_auto) VALUES (:c, :l, :n, 0)
         ON DUPLICATE KEY UPDATE name = VALUES(name), is_auto = 0'
    );
    if ($action === 'save') {
        $node = mpt_node($tree, (int) $str('id', 10));
        $uk = $str('name_uk');
        $en = $str('name_en');
        $icon = in_array($str('icon', 40), MPT_ICONS, true) ? $str('icon', 40) : null;
        if ($node === null || $uk === '') {
            $msg = 'Помилка: категорію не знайдено або порожня назва українською.';
        } else {
            $cid = ($node['sub'] ?? $node['block'])['id'];
            $pdo->prepare('UPDATE mp_categories SET sort_order = :s, is_active = :a, icon = COALESCE(:i, icon) WHERE id = :id')
                ->execute([':s' => max(0, min(9999, (int) $str('sort', 5))), ':a' => $str('active', 1) === '1' ? 1 : 0, ':i' => $icon, ':id' => $cid]);
            $setName->execute([':c' => $cid, ':l' => 'uk', ':n' => $uk]);
            if ($en !== '') {
                $setName->execute([':c' => $cid, ':l' => 'en', ':n' => $en]);
            }
            error_log('[mp-categories] admin ' . $adminId . ' ' . 'category_saved' . ' ' . '#' . $cid . ' ' . $uk);
            $msg = 'Збережено: ' . $uk . '.';
        }
    } elseif ($action === 'add') {
        $node = mpt_node($tree, (int) $str('block', 10));
        $uk = $str('name_uk');
        $en = $str('name_en');
        $icon = in_array($str('icon', 40), MPT_ICONS, true) ? $str('icon', 40) : 'shapes';
        if ($node === null || $node['sub'] !== null || $uk === '') {
            $msg = 'Помилка: оберіть блок і вкажіть назву українською.';
        } else {
            $b = $node['block'];
            $base = mb_substr(lst_slug($en !== '' ? $en : $uk), 0, 70);
            $slug = $base;
            $chk = $pdo->prepare('SELECT 1 FROM mp_categories WHERE section = :s AND slug = :g');
            for ($i = 2; $chk->execute([':s' => $b['section'], ':g' => $slug]) && $chk->fetchColumn() !== false; $i++) {
                $slug = $base . '-' . $i;
            }
            $sort = 1 + (int) array_reduce($b['children'], static fn(int $m, array $c): int => max($m, $c['sort']), 0);
            $pdo->prepare('INSERT INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) VALUES (:s, :p, :g, :i, :o, 1, 1)')
                ->execute([':s' => $b['section'], ':p' => $b['id'], ':g' => $slug, ':i' => $icon, ':o' => $sort]);
            $cid = (int) $pdo->lastInsertId();
            $setName->execute([':c' => $cid, ':l' => 'uk', ':n' => $uk]);
            if ($en !== '') {
                $setName->execute([':c' => $cid, ':l' => 'en', ':n' => $en]);
            }
            error_log('[mp-categories] admin ' . $adminId . ' ' . 'category_added' . ' ' . '#' . $cid . ' ' . $b['section'] . '/' . $slug);
            $msg = 'Додано підкатегорію «' . $uk . '» у блок «' . $b['name'] . '» (чернетка списку).';
        }
    } elseif ($action === 'approve_all') {
        $n = $pdo->exec("UPDATE mp_categories SET is_draft = 0 WHERE is_draft = 1 AND section <> 'focus'");
        error_log('[mp-categories] admin ' . $adminId . ' ' . 'categories_approved' . ' ' . (string) $n);
        $msg = 'Затверджено категорій: ' . (int) $n . '.';
    }
    mpt_cache_reset();
    $_SESSION['mpt_admin_flash'] = $msg;
    header('Location: mp-categories.php', true, 303);
    exit;
}

$tree = mpt_tree($pdo, 'uk', true);
$counts = mpt_counts($pdo);
$flash = $_SESSION['mpt_admin_flash'] ?? null;
unset($_SESSION['mpt_admin_flash']);
$drafts = 0;
foreach ($tree as $b) {
    $drafts += ($b['draft'] ? 1 : 0) + count(array_filter($b['children'], static fn(array $c): bool => $c['draft']));
}
$csrf = mp_csrf_field();
$iconSelect = static function (string $current, string $name = 'icon'): string {
    $h = '<select class="mp-input" name="' . $name . '" aria-label="Піктограма">';
    foreach (MPT_ICONS as $ic) {
        $h .= '<option value="' . mp_e($ic) . '"' . ($ic === $current ? ' selected' : '') . '>' . mp_e($ic) . '</option>';
    }

    return $h . '</select>';
};
$row = static function (array $c, bool $isBlock, int $cnt) use ($csrf, $iconSelect): string {
    return '<form method="post" action="mp-categories.php" class="mpt-admin-row' . ($c['active'] ? '' : ' is-off') . '">' . $csrf
        . '<input type="hidden" name="action" value="save"><input type="hidden" name="id" value="' . $c['id'] . '">'
        . '<span class="direction-card__icon" aria-hidden="true" style="width:36px;height:36px"><i data-lucide="' . mp_e($c['icon']) . '"></i></span>'
        . '<span>' . ($isBlock ? '<strong>' : '') . '#' . $c['id'] . ' ' . mp_e($c['slug']) . ($isBlock ? '</strong>' : '')
        . ' · ' . $cnt . ' ог.' . ($c['draft'] ? ' <span class="mpt-badge-draft">чернетка</span>' : '') . '</span>'
        . '<input class="mp-input" type="text" name="name_uk" maxlength="150" required value="' . mp_e($c['name_uk']) . '" aria-label="Назва українською">'
        . '<input class="mp-input" type="text" name="name_en" maxlength="150" value="' . mp_e($c['name_en']) . '" aria-label="Назва англійською">'
        . '<input class="mp-input mp-input--num" type="number" name="sort" min="0" max="9999" value="' . $c['sort'] . '" aria-label="Порядок">'
        . $iconSelect($c['icon'])
        . '<label class="mp-check"><input type="checkbox" name="active" value="1"' . ($c['active'] ? ' checked' : '') . '> <span>активна</span></label>'
        . '<button class="mp-btn" type="submit">Зберегти</button></form>';
};

mpt_open('Категорії Marketplace', 'Керування деревом категорій Marketplace', 'mp-categories.php', true, '');
?>
    <div class="mp-page">
        <?= mpt_crumbs([['CRM', 'account.php'], [t('mp_heading'), 'marketplace.php'], ['Категорії', null]]) ?>
        <h1 class="mp-title">Категорії Marketplace</h1>
        <p class="mp-subtitle">Блоки → підкатегорії. Видалення немає: прихована категорія зникає з сайту, прив'язки оголошень лишаються. Зміни одразу скидають кеш лічильників.</p>
        <?php if (is_string($flash)): ?><div class="mp-alert" role="status"><?= mp_e($flash) ?></div><?php endif; ?>
        <?php if ($drafts > 0): ?>
            <form method="post" action="mp-categories.php" class="mp-note mp-note--box"><?= $csrf ?><input type="hidden" name="action" value="approve_all">
                Чернетка списку: <?= $drafts ?> категорій (видимі на сайті). <button class="mp-btn mp-btn--primary" type="submit">Затвердити список</button></form>
        <?php endif; ?>

        <?php foreach ($tree as $b): ?>
            <section class="mpt-admin-block">
                <?= $row($b, true, (int) ($counts['blocks'][$b['section']] ?? 0)) ?>
                <?php foreach ($b['children'] as $c): ?>
                    <?= $row($c, false, (int) ($counts['cats'][$c['id']] ?? 0)) ?>
                <?php endforeach; ?>
                <?php if ($b['section'] !== 'other'): ?>
                <form method="post" action="mp-categories.php" class="mpt-admin-row"><?= $csrf ?>
                    <input type="hidden" name="action" value="add"><input type="hidden" name="block" value="<?= (int) $b['id'] ?>">
                    <span>+ Нова підкатегорія</span>
                    <input class="mp-input" type="text" name="name_uk" maxlength="150" required placeholder="Назва українською" aria-label="Назва українською">
                    <input class="mp-input" type="text" name="name_en" maxlength="150" placeholder="Назва англійською" aria-label="Назва англійською">
                    <?= $iconSelect('shapes') ?>
                    <button class="mp-btn mp-btn--primary" type="submit">Додати</button>
                </form>
                <?php endif; ?>
            </section>
        <?php endforeach; ?>
        <p class="mp-hint">Тематичні категорії вакансій/курсів/послуг (AI-спрямування, section='focus') тут не показуються — вони лишаються додатковим фільтром.</p>
    </div>
<?php mpt_close(); ?>
