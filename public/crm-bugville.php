<?php

declare(strict_types=1);

/**
 * AI LAB HUB — CRM гри «Багвіль» (крок 5 плану; MAIN_TASK, розділ 12). Лише admin (роль за БД); зміни — POST + CSRF;
 * без видалення (статус «off»).
 *   ?view=missions (типово) — місії Етапу 1: режим, генератор, активні варіанти, попередження («менше 6», «немає генератора»,
 *                              «варіанти перевіряють різне»).
 *   ?view=mission&m=ID       — варіанти пулу (додавання / редагування), перегляд будь-якого варіанта чи seed очима гравця
 *                              з панеллю «відповідь і розбір», «Згенерувати 5 прикладів».
 *   ?view=exams              — пул кожного іспиту: завдання, вага, статус, лічильник «пул / потрібно» (іспит вмикається сам,
 *                              коли пул ≥ 3 × завдань).
 *   ?view=words              — чарівні слова Етапу 1.
 * Звання, значки й майстерня зʼявляться тут разом із їхніми таблицями.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/csrf.php';
require_once __DIR__ . '/../app/bugville/bv-missions.php';
require_once __DIR__ . '/../app/bugville/bv-crm.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
$uid = auth_user_id();
$roleSt = $pdo->prepare('SELECT role FROM users WHERE id = :u');
$roleSt->execute([':u' => (int) $uid]);
if ($uid === null || $roleSt->fetchColumn() !== 'admin') {
    header('Location: account.php');
    exit;
}
header('X-Robots-Tag: noindex, nofollow');
header('Cache-Control: no-store');
bv_load_missions($pdo);

$e = static fn(mixed $v): string => htmlspecialchars((string) $v, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
$view = (string) ($_GET['view'] ?? 'missions');
$all = bv_world_missions();
$errors = [];
$form = null;

if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    $action = (string) ($_POST['action'] ?? '');
    if (!csrf_ok()) {
        $errors[] = 'Сторінка застаріла. Оновіть її й спробуйте ще раз.';
    } elseif ($action === 'save_variant') {
        $m = (int) ($_POST['m'] ?? 0);
        $vid = (int) ($_POST['id'] ?? 0);
        if (!isset($all[$m])) {
            $errors[] = 'Невідома місія.';
        } else {
            [$errors, $clean] = bv_crm_check_variant($_POST);
            if ($errors === []) {
                $saved = bv_crm_save_variant($pdo, $vid, $m, $clean);
                $_SESSION['bv_crm_flash'] = 'Варіант №' . $saved . ' збережено.';
                header('Location: crm-bugville.php?view=mission&m=' . $m . '&preview=' . $saved);
                exit;
            }
        }
        $view = 'mission';
        $_GET['m'] = (string) $m;
        $form = $_POST;
    } elseif ($action === 'save_item') {
        $errors = bv_crm_save_exam_item($pdo, (int) ($_POST['id'] ?? 0), $_POST);
        if ($errors === []) {
            $_SESSION['bv_crm_flash'] = 'Завдання іспиту збережено.';
            header('Location: crm-bugville.php?view=exams');
            exit;
        }
        $view = 'exams';
    } else {
        $errors[] = 'Невідома дія.';
    }
}
$flash = (string) ($_SESSION['bv_crm_flash'] ?? '');
unset($_SESSION['bv_crm_flash']);

/** Сцена очима гравця (без позначки правильної відповіді). */
$scene = static function (array $p) use ($e): string {
    $h = '<p>' . $e($p['text'] ?? '') . '</p>';
    if (!empty($p['items'])) {
        $h .= '<ul>' . implode('', array_map(static fn($i) => '<li>' . $e($i['text'] ?? '') . '</li>', (array) $p['items'])) . '</ul>';
    }
    $h .= '<p><strong>' . $e($p['question'] ?? '') . '</strong></p>';
    if (!empty($p['options'])) {
        $h .= '<ol>' . implode('', array_map(static fn($o) => '<li>' . $e($o['text'] ?? '') . ' <code>' . $e($o['id'] ?? '') . '</code></li>', (array) $p['options'])) . '</ol>';
    }
    if (($p['input'] ?? '') === 'number') {
        $h .= '<p><em>Поле для числа</em></p>';
    }

    return $h;
};
$adminPanel = static function (array $pv) use ($e): string {
    return '<div class="bvc-answer"><p><strong>Відповідь:</strong> ' . $e(implode(' · ', $pv['correct_text']) ?: json_encode($pv['answer'], JSON_UNESCAPED_UNICODE))
        . '</p><p><strong>Розбір:</strong> ' . $e($pv['explain']) . '</p>'
        . ($pv['hint'] !== '' ? '<p><strong>Підказка:</strong> ' . $e($pv['hint']) . '</p>' : '')
        . '<p class="rep__note">Ключ варіанта: ' . $e($pv['key']) . ($pv['seed'] !== null ? ' · seed ' . $e($pv['seed']) : '') . '</p></div>';
};
$tabs = ['missions' => 'Місії', 'exams' => 'Іспити', 'words' => 'Слова'];
?>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="noindex, nofollow">
    <title>AI LAB HUB — Багвіль (CRM)</title>
    <link rel="stylesheet" href="<?= '/assets/css/admin-report.css?v=' . (int) @filemtime(__DIR__ . '/assets/css/admin-report.css') ?>">
    <style>
        .bvc-tabs { display: flex; flex-wrap: wrap; gap: 8px; margin: 0 0 18px; }
        .bvc-warn { color: #fde047; }
        .bvc-ok { color: #bbf7d0; }
        .bvc-bad { color: #fecaca; }
        .bvc-grid { display: grid; gap: 12px; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); }
        .bvc-card { border: 1px solid var(--card-border); border-radius: 12px; padding: 12px; background: rgba(255, 255, 255, 0.04); overflow-wrap: anywhere; }
        .bvc-answer { margin-top: 8px; padding: 8px 10px; border-radius: 10px; background: rgba(52, 211, 153, 0.12); border: 1px solid rgba(52, 211, 153, 0.45); }
        .bvc-form label { display: block; margin: 10px 0 4px; font-weight: 600; font-size: 0.9rem; }
        .bvc-form textarea, .bvc-form input, .bvc-form select { box-sizing: border-box; width: 100%; min-height: 44px; padding: 8px 10px; border-radius: 10px;
            border: 1px solid rgba(255, 255, 255, 0.25); background: #11163f; color: #fff; font: inherit; font-size: 16px; }
        .bvc-form textarea { min-height: 140px; font-family: ui-monospace, Consolas, monospace; font-size: 14px; }
        .bvc-inline { display: flex; flex-wrap: wrap; gap: 8px; align-items: flex-end; }
        .bvc-inline > * { flex: 1 1 140px; }
        .bvc-msg { padding: 10px 12px; border-radius: 10px; margin: 0 0 14px; }
        .bvc-msg--ok { background: rgba(52, 211, 153, 0.15); border: 1px solid rgba(52, 211, 153, 0.5); }
        .bvc-msg--bad { background: rgba(248, 113, 113, 0.15); border: 1px solid rgba(248, 113, 113, 0.5); }
        code { font-size: 0.85em; opacity: 0.8; }
    </style>
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
<main class="rep">
    <a class="rep__back" href="account.php#acc-crm">← Кабінет</a>
    <h1 class="rep__title">Багвіль</h1>
    <p class="rep__sub">Місії, варіанти поломок, пул іспитів і слова. Нічого не видаляється: непотрібне — статус «off».
        <?= bv_cfg('bugville_public') === true ? 'Гра відкрита для всіх.' : 'Гра поки видна лише адміністраторам (bugville_public = false).' ?>
        <a href="bugville.php">Відкрити гру</a></p>
    <nav class="bvc-tabs">
        <?php foreach ($tabs as $k => $label): ?>
            <a class="rep-btn<?= ($view === $k || ($view === 'mission' && $k === 'missions')) ? ' is-active' : '' ?>" href="crm-bugville.php?view=<?= $e($k) ?>"><?= $e($label) ?></a>
        <?php endforeach; ?>
    </nav>
    <?php if ($flash !== ''): ?><p class="bvc-msg bvc-msg--ok" role="status"><?= $e($flash) ?></p><?php endif; ?>
    <?php if ($errors !== []): ?><div class="bvc-msg bvc-msg--bad" role="alert"><?php foreach ($errors as $er): ?><p><?= $e($er) ?></p><?php endforeach; ?></div><?php endif; ?>

<?php if ($view === 'mission' && isset($all[(int) ($_GET['m'] ?? 0)])):
    $ms = $all[(int) $_GET['m']];
    $st = $pdo->prepare('SELECT * FROM bv_mission_variants WHERE mission_id = :m ORDER BY id');
    $st->execute([':m' => (int) $ms['id']]);
    $variants = $st->fetchAll(PDO::FETCH_ASSOC);
    $editId = (int) ($_GET['edit'] ?? ($form['id'] ?? 0));
    $edit = null;
    foreach ($variants as $v) {
        if ((int) $v['id'] === $editId) {
            $edit = $v;
        }
    }
    $fv = $form ?? ($edit ?? ['payload_json' => '{"text": "", "question": "", "options": [{"id": "o1", "text": ""}, {"id": "o2", "text": ""}]}',
        'answer_json' => '{"type": "single", "correct": "o1"}', 'explain_json' => '{"text": "", "hint": ""}', 'skill' => $ms['word'], 'status' => 'draft']);
    $previewVid = isset($_GET['preview']) ? (int) $_GET['preview'] : null;
    $seed = isset($_GET['seed']) && preg_match('/^[a-z0-9]{1,32}$/i', (string) $_GET['seed']) === 1 ? (string) $_GET['seed'] : null;
    ?>
    <h2 class="rep__h2"><?= $e($ms['n'] . ' ' . $ms['title']) ?> <code>#<?= (int) $ms['id'] ?></code></h2>
    <p class="rep__note">Режим: <?= $e($ms['mode']) ?> · генератор: <?= $e($ms['generator'] ?? '—') ?> · слово: <?= $e($ms['word']) ?>
        · <a href="bugville-mission.php?m=<?= (int) $ms['id'] ?>">у грі</a></p>

    <?php if ($ms['mode'] !== 'pool'): ?>
        <p><a class="rep-btn" href="crm-bugville.php?view=mission&amp;m=<?= (int) $ms['id'] ?>&amp;gen=5">Згенерувати 5 прикладів</a></p>
    <?php endif; ?>

    <?php if (isset($_GET['gen']) && $ms['mode'] !== 'pool'): ?>
        <h3 class="rep__h2">5 випадкових прикладів</h3>
        <div class="bvc-grid">
            <?php for ($i = 0; $i < 5; $i++):
                $pv = bv_crm_preview($pdo, $ms, $ms['mode'] === 'mixed' ? (int) ($variants[$i % max(1, count($variants))]['id'] ?? 0) : null, null); ?>
                <div class="bvc-card">
                    <?php if ($pv === null): ?><p class="bvc-warn">Немає генератора<?= $ms['mode'] === 'mixed' ? ' або варіантів пулу' : '' ?> — прикладів не буде.</p>
                    <?php else: ?><?= $scene($pv['payload']) ?><?= $adminPanel($pv) ?><?php endif; ?>
                </div>
            <?php endfor; ?>
        </div>
    <?php endif; ?>

    <?php if ($previewVid !== null || $seed !== null):
        $pv = bv_crm_preview($pdo, $ms, $previewVid, $seed); ?>
        <h3 class="rep__h2">Перегляд <?= $previewVid !== null ? 'варіанта №' . (int) $previewVid : 'seed ' . $e($seed) ?></h3>
        <div class="bvc-card"><?= $pv === null ? '<p class="bvc-warn">Не вдалося зібрати варіант.</p>' : $scene($pv['payload']) . $adminPanel($pv) ?></div>
    <?php endif; ?>

    <?php if ($ms['mode'] !== 'pool'): ?>
        <form class="bvc-form bvc-inline" method="get" action="crm-bugville.php">
            <input type="hidden" name="view" value="mission"><input type="hidden" name="m" value="<?= (int) $ms['id'] ?>">
            <label>Переглянути seed<input name="seed" pattern="[A-Za-z0-9]{1,32}" placeholder="напр. a1b2c3" value="<?= $e($seed ?? '') ?>"></label>
            <button class="rep-btn" type="submit">Показати</button>
        </form>
    <?php endif; ?>

    <h3 class="rep__h2">Варіанти пулу (<?= count($variants) ?>)</h3>
    <?php if ($variants === []): ?><p class="rep__note">Варіантів ще немає.</p><?php else: ?>
        <div class="rep-table-wrap"><table class="rep-table">
            <thead><tr><th>№</th><th>Статус</th><th>Навичка</th><th>Сцена</th><th></th></tr></thead>
            <tbody>
            <?php foreach ($variants as $v): $p = (array) json_decode((string) $v['payload_json'], true); ?>
                <tr>
                    <td><?= (int) $v['id'] ?></td>
                    <td class="<?= $v['status'] === 'active' ? 'bvc-ok' : 'bvc-warn' ?>"><?= $e($v['status']) ?></td>
                    <td><?= $e($v['skill']) ?></td>
                    <td><?= $e(mb_strimwidth((string) ($p['text'] ?? ''), 0, 90, '…')) ?></td>
                    <td><a href="crm-bugville.php?view=mission&amp;m=<?= (int) $ms['id'] ?>&amp;preview=<?= (int) $v['id'] ?>">перегляд</a>
                        · <a href="crm-bugville.php?view=mission&amp;m=<?= (int) $ms['id'] ?>&amp;edit=<?= (int) $v['id'] ?>#bvc-form">редагувати</a></td>
                </tr>
            <?php endforeach; ?>
            </tbody>
        </table></div>
    <?php endif; ?>

    <h3 class="rep__h2" id="bvc-form"><?= $editId > 0 ? 'Редагувати варіант №' . $editId : 'Новий варіант' ?></h3>
    <form class="bvc-form" method="post" action="crm-bugville.php">
        <?= csrf_field() ?>
        <input type="hidden" name="action" value="save_variant">
        <input type="hidden" name="m" value="<?= (int) $ms['id'] ?>">
        <input type="hidden" name="id" value="<?= (int) $editId ?>">
        <label for="bvc-p">Сцена (payload JSON: text, question, options [{id, text}] або input "number"; у змішаному режимі — {{плейсхолдери}})</label>
        <textarea id="bvc-p" name="payload_json"><?= $e($fv['payload_json'] ?? '') ?></textarea>
        <label for="bvc-a">Відповідь (answer JSON: {"type":"single","correct":"o2"} / multi / {"type":"number","value":12,"tolerance":0})</label>
        <textarea id="bvc-a" name="answer_json"><?= $e($fv['answer_json'] ?? '') ?></textarea>
        <label for="bvc-x">Розбір (explain JSON: {"text": "…", "hint": "…"})</label>
        <textarea id="bvc-x" name="explain_json"><?= $e($fv['explain_json'] ?? '') ?></textarea>
        <div class="bvc-inline">
            <label>Навичка<input name="skill" maxlength="64" value="<?= $e($fv['skill'] ?? '') ?>"></label>
            <label>Статус
                <select name="status">
                    <?php foreach (BV_VARIANT_STATUSES as $s): ?><option value="<?= $e($s) ?>"<?= ($fv['status'] ?? '') === $s ? ' selected' : '' ?>><?= $e($s) ?></option><?php endforeach; ?>
                </select>
            </label>
            <button class="rep-btn" type="submit">Зберегти</button>
        </div>
    </form>

<?php elseif ($view === 'exams'): ?>
    <?php foreach (bv_world() as $ch): foreach ($ch['levels'] as $lv):
        $exId = bv_exam_id((int) $lv['id']);
        $data = bv_crm_exam_items($pdo, $exId);
        $pool = $data['pool']; ?>
        <h2 class="rep__h2">Іспит рівня «<?= $e($lv['title']) ?>» <code>#<?= $exId ?></code></h2>
        <p class="<?= $pool['ok'] ? 'bvc-ok' : 'bvc-warn' ?>">Пул: <?= (int) $pool['weight'] ?> / потрібно <?= (int) $pool['need'] ?> —
            <?= $pool['ok'] ? 'іспит увімкнено' : 'іспит вимкнено, доки пул замалий (рахуються лише активні завдання з місіями, в які можна грати)' ?>.</p>
        <?php if ($data['rows'] !== []): ?>
            <div class="rep-table-wrap"><table class="rep-table">
                <thead><tr><th>№</th><th>Місія</th><th>Вага</th><th>Статус</th><th>Змінити</th></tr></thead>
                <tbody>
                <?php foreach ($data['rows'] as $r): $mm = $all[(int) $r['mission_id']] ?? null; ?>
                    <tr>
                        <td><?= (int) $r['id'] ?></td>
                        <td><?= $e($mm !== null ? $mm['n'] . ' ' . $mm['title'] : '#' . $r['mission_id']) ?><?= $mm !== null && bv_mission((int) $mm['id']) === null ? ' <span class="bvc-warn">(немає контенту)</span>' : '' ?></td>
                        <td><?= (int) $r['weight'] ?></td>
                        <td class="<?= $r['status'] === 'active' ? 'bvc-ok' : 'bvc-warn' ?>"><?= $e($r['status']) ?></td>
                        <td>
                            <form class="bvc-form bvc-inline" method="post" action="crm-bugville.php">
                                <?= csrf_field() ?><input type="hidden" name="action" value="save_item"><input type="hidden" name="id" value="<?= (int) $r['id'] ?>">
                                <input type="hidden" name="exam_id" value="<?= $exId ?>"><input type="hidden" name="mission_id" value="<?= (int) $r['mission_id'] ?>">
                                <label>Вага<input type="number" name="weight" min="1" max="50" value="<?= (int) $r['weight'] ?>"></label>
                                <label>Статус<select name="status"><option value="active"<?= $r['status'] === 'active' ? ' selected' : '' ?>>active</option><option value="off"<?= $r['status'] === 'off' ? ' selected' : '' ?>>off</option></select></label>
                                <button class="rep-btn" type="submit">Зберегти</button>
                            </form>
                        </td>
                    </tr>
                <?php endforeach; ?>
                </tbody>
            </table></div>
        <?php endif; ?>
        <form class="bvc-form bvc-inline" method="post" action="crm-bugville.php">
            <?= csrf_field() ?><input type="hidden" name="action" value="save_item"><input type="hidden" name="id" value="0"><input type="hidden" name="exam_id" value="<?= $exId ?>">
            <label>Додати місію
                <select name="mission_id">
                    <?php foreach ($lv['missions'] as $mm): ?><option value="<?= (int) $mm['id'] ?>"><?= $e($mm['n'] . ' ' . $mm['title']) ?></option><?php endforeach; ?>
                </select>
            </label>
            <label>Вага<input type="number" name="weight" min="1" max="50" value="3"></label>
            <input type="hidden" name="status" value="active">
            <button class="rep-btn" type="submit">Додати</button>
        </form>
    <?php endforeach; endforeach; ?>

<?php elseif ($view === 'words'): ?>
    <div class="rep-table-wrap"><table class="rep-table">
        <thead><tr><th>Слово</th><th>Вимова</th><th>Значення</th><th>Місія</th></tr></thead>
        <tbody>
        <?php foreach ($all as $ms): $w = bv_word_card($ms['word']); ?>
            <tr><td lang="en"><strong><?= $e($ms['word']) ?></strong></td><td><?= $e($w['say'] ?? '') ?></td><td><?= $e($w['meaning'] ?? '') ?></td><td><?= $e($ms['n'] . ' ' . $ms['title']) ?></td></tr>
        <?php endforeach; ?>
        </tbody>
    </table></div>

<?php else: $rows = bv_crm_missions($pdo); $warn = count(array_filter($rows, static fn($r) => $r['warnings'] !== [])); ?>
    <p class="<?= $warn > 0 ? 'bvc-warn' : 'bvc-ok' ?>"><?= $warn > 0 ? "Місій із попередженнями: $warn з " . count($rows) . '.' : 'Усі місії готові.' ?></p>
    <div class="rep-table-wrap"><table class="rep-table">
        <thead><tr><th>Місія</th><th>Режим</th><th>Генератор</th><th>Варіанти (активні / усі)</th><th>У грі</th><th>Попередження</th></tr></thead>
        <tbody>
        <?php foreach ($rows as $r): $ms = $r['mission']; ?>
            <tr>
                <td><a href="crm-bugville.php?view=mission&amp;m=<?= (int) $ms['id'] ?>"><?= $e($ms['n'] . ' ' . $ms['title']) ?></a></td>
                <td><?= $e($ms['mode']) ?></td>
                <td class="<?= $r['has_generator'] ? 'bvc-ok' : '' ?>"><?= $e($r['generator'] ?? '—') ?></td>
                <td><?= (int) $r['active'] ?> / <?= (int) $r['total'] ?></td>
                <td class="<?= $r['playable'] ? 'bvc-ok' : 'bvc-warn' ?>"><?= $r['playable'] ? 'так' : 'ні' ?></td>
                <td class="bvc-warn"><?= $e(implode('; ', $r['warnings'])) ?></td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table></div>
<?php endif; ?>
</main>
</body>
</html>
