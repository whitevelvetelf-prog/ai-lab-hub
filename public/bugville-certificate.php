<?php

declare(strict_types=1);

/**
 * AI LAB HUB — «Багвіль»: грамота за складений іспит (крок 4; MAIN_TASK, розділ 6). ?c=<код>. Бачить лише власник
 * (інші й гості — 404). Імʼя на грамоті гравець вводить сам (POST + CSRF, до 60 символів; радимо псевдонім); без імені —
 * «Помічник майстра». Сторінка для друку (print CSS), PDF не будується. Текст: навчальна грамота, не сертифікація.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/csrf.php';
require_once __DIR__ . '/../app/bugville/bv-missions.php';
require_once __DIR__ . '/../app/bugville/bv-exam.php';
require_once __DIR__ . '/../app/bugville/bv-view.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
$account = auth_check() ? auth_current_user($pdo) : null;
if ($account === null || !bv_pages_visible($account)) {
    bv_not_found();
}
$code = is_string($_GET['c'] ?? null) ? strtoupper((string) $_GET['c']) : '';
if (preg_match('/^[0-9A-F]{20}$/', $code) !== 1) {
    bv_not_found();
}
$st = $pdo->prepare('SELECT * FROM bv_certificates WHERE code = :c AND user_id = :u');
$st->execute([':c' => $code, ':u' => (int) $account['id']]);
$cert = $st->fetch(PDO::FETCH_ASSOC);
$lv = $cert ? bv_exam_level((int) $cert['exam_id']) : null;
if (!$cert || $lv === null) {
    bv_not_found();
}

$saved = false;
$error = '';
if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    $name = trim(preg_replace('/\s+/u', ' ', (string) ($_POST['display_name'] ?? '')) ?? '');
    if (!csrf_ok()) {
        $error = 'Сторінка застаріла. Оновіть її й спробуйте ще раз.';
    } elseif (mb_strlen($name) > 60) {
        $error = 'Імʼя — не довше за 60 символів.';
    } elseif ($name !== '' && preg_match('/[\p{C}<>]/u', $name) === 1) {
        $error = 'Імʼя містить недопустимі символи.';
    } else {
        $pdo->prepare('UPDATE bv_certificates SET display_name = :n, updated_at = :t WHERE id = :id AND user_id = :u')
            ->execute([':n' => $name === '' ? null : $name, ':t' => bv_now(), ':id' => (int) $cert['id'], ':u' => (int) $account['id']]);
        $cert['display_name'] = $name === '' ? null : $name;
        $saved = true;
    }
}

$display = (string) ($cert['display_name'] ?? '') !== '' ? (string) $cert['display_name'] : 'Помічник майстра';
$date = date('d.m.Y', strtotime($cert['created_at'] . ' UTC'));

bv_page_start('Грамота: ' . $lv['title'], ['user' => $account, 'back' => 'bugville.php', 'body_class' => 'bv-cert-page']);
?>
<main class="bv-main" id="bv-main">
    <article class="bv-cert" aria-label="Грамота">
        <p class="bv-cert__kicker">Місто Багвіль</p>
        <h1 class="bv-cert__title">Грамота</h1>
        <p>засвідчує, що</p>
        <p class="bv-cert__name"><?= bv_h($display) ?></p>
        <p>склав(-ла) іспит рівня «<?= bv_h($lv['title']) ?>» з результатом <?= (int) $cert['score'] ?>%.</p>
        <p class="bv-cert__date"><?= bv_h($date) ?> · № <?= bv_h($cert['code']) ?></p>
        <p class="bv-cert__note">Це навчальна грамота гри, а не офіційна сертифікація.</p>
    </article>

    <section class="bv-card bv-noprint">
        <h2 class="bv-result__sub">Імʼя на грамоті</h2>
        <?php if ($saved): ?><p class="bv-reward" role="status">Збережено.</p><?php endif; ?>
        <?php if ($error !== ''): ?><p class="bv-msg is-bad" role="alert"><?= bv_h($error) ?></p><?php endif; ?>
        <form method="post" action="bugville-certificate.php?c=<?= bv_h($cert['code']) ?>">
            <?= csrf_field() ?>
            <label for="bv-name">Як підписати грамоту (радимо псевдонім)</label>
            <input class="bv-input" id="bv-name" name="display_name" maxlength="60" value="<?= bv_h($cert['display_name'] ?? '') ?>" autocomplete="off">
            <p class="bv-actions">
                <button class="bv-btn" type="submit">Зберегти імʼя</button>
                <button class="bv-btn bv-btn--ghost" type="button" data-print>Надрукувати</button>
                <a class="bv-btn bv-btn--ghost" href="bugville.php">До карти</a>
            </p>
        </form>
    </section>
</main>
<?php
bv_page_end(false);
