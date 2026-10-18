<?php

declare(strict_types=1);

/**
 * AI LAB HUB — дії адмінки реклами (розділ «Реклама: адмін» в account.php).
 *
 * Лише POST, CSRF обов'язковий, роль admin перевіряється за БД.
 *   moderate          creative_id, decision=approve|reject, reason
 *   topup_decide      tx_id, decision=confirm|reject, reason
 *   adjust            who (email|ID), type=adjust|refund, amount (±$), note
 *   rates             price[placement][cpm|cpc] ($; порожньо — ціна неактивна)
 *   settings          поля ad_settings
 *   toggle_system     enabled=0|1 — увімкнути/вимкнути ВСЮ рекламу сайту
 *   campaign_status   campaign_id, op=stop|resume|complete
 *   suspend_creative  creative_id, reason
 *   reports_reviewed  creative_id
 *   link_recheck      creative_id — перевірити адресу переходу ще раз (блок G)
 *   blocklist_add     domain, reason;  blocklist_remove  id
 *   shorteners        shortener_domains (домен на рядок)
 *   no_promo          type=category|subcategory|product|article, id, on=0|1 (блок H)
 *   rule_add          advertiser_category, scope=all:0|category:N|subcategory:N, note;  rule_delete  id
 *   diagnose_page     url — «перевірити сторінку»: чи буде реклама й чому ні
 * Після дії — редирект у кабінет (account.php?padm_tab=…#acc-promo-admin).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/promo-admin.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
promo_db_utc($pdo);

$adminId = auth_user_id();
if (!promo_is_admin($pdo, $adminId) || ($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST') {
    header('Location: account.php');
    exit;
}

$back = static function (string $tab, bool $ok, array $msgs): never {
    $_SESSION['padm_flash'] = ['ok' => $ok, 'msgs' => $msgs];
    header('Location: account.php?padm_tab=' . rawurlencode($tab) . '#acc-promo-admin', true, 303);
    exit;
};

if (!promo_csrf_verify()) {
    $back('moderation', false, ['Сесія застаріла. Оновіть сторінку й спробуйте ще раз.']);
}

$action = (string) ($_POST['action'] ?? '');
$str = static fn(string $k): string => is_string($_POST[$k] ?? null) ? $_POST[$k] : '';

switch ($action) {
    case 'moderate':
        [$ok, $msg] = promo_admin_moderate($pdo, $adminId, (int) $str('creative_id'), $str('decision') === 'approve', $str('reason'),
            $str('confirm_flagged') === '1', $str('override_reason'));
        $back('moderation', $ok, [$msg]);

    case 'link_recheck':
        $r = promo_linkcheck_creative($pdo, (int) $str('creative_id'), true);
        promo_log_event($pdo, 'link_check', (int) $str('creative_id'), null, ($r['status'] ?? '') . ': ' . implode(', ', $r['flags'] ?? []), $adminId);
        $back('moderation', true, ['Посилання перевірено: ' . (($r['status'] ?? '') === 'ok' ? 'без прапорців.' : 'є прапорці — див. картку креативу.')]);

    case 'blocklist_add':
        [$ok, $msg] = promo_admin_blocklist_add($pdo, $adminId, $str('domain'), $str('reason'));
        $back('links', $ok, [$msg]);

    case 'blocklist_remove':
        [$ok, $msg] = promo_admin_blocklist_remove($pdo, $adminId, (int) $str('id'));
        $back('links', $ok, [$msg]);

    case 'no_promo':
        [$ok, $msg] = promo_set_no_promo($pdo, $str('type'), $str('id'), $str('on') === '1');
        promo_log_event($pdo, 'no_promo', null, null, $str('type') . ' ' . $str('id') . ' = ' . ($str('on') === '1' ? '1' : '0'), $adminId);
        $back('exclusions', $ok, [$msg]);

    case 'rule_add':
        [$scopeType, $scopeId] = array_pad(explode(':', $str('scope'), 2), 2, '0');
        [$ok, $msg] = promo_rule_add($pdo, $scopeType, (int) $scopeId, $str('advertiser_category'), $str('note'));
        $back('exclusions', $ok, [$msg]);

    case 'rule_delete':
        [$ok, $msg] = promo_rule_delete($pdo, (int) $str('id'));
        $back('exclusions', $ok, [$msg]);

    case 'diagnose_page':
        $_SESSION['padm_diagnose_url'] = mb_substr($str('url'), 0, 500);
        $_SESSION['padm_diagnose'] = promo_page_diagnose($pdo, $str('url'));
        $back('exclusions', true, []);

    case 'shorteners':
        [$ok, $msg] = promo_admin_save_shorteners($pdo, $str('shortener_domains'));
        $back('links', $ok, [$msg]);

    case 'topup_decide':
        [$ok, $msg] = promo_admin_topup_decide($pdo, $adminId, (int) $str('tx_id'), $str('decision') === 'confirm', $str('reason'));
        $back('payments', $ok, [$msg]);

    case 'adjust':
        [$ok, $msg] = promo_admin_adjust($pdo, $adminId, $str('who'), $str('type'), $str('amount'), $str('note'));
        $back('payments', $ok, [$msg]);

    case 'rates':
        $errors = promo_admin_save_rates($pdo, $_POST);
        $back('rates', $errors === [], $errors === [] ? ['Прайс збережено.'] : $errors);

    case 'settings':
        $errors = promo_admin_save_settings($pdo, $_POST);
        $back('settings', $errors === [], $errors === [] ? ['Налаштування збережено.'] : $errors);

    case 'toggle_system':
        $on = $str('enabled') === '1';
        promo_admin_set_setting($pdo, 'enabled', $on ? '1' : '0');
        $msgs = [$on ? 'Рекламу на сайті ввімкнено.' : 'Усю рекламу на сайті вимкнено.'];
        if ($on && strlen(promo_config()['secret']) < 32) {
            $msgs[] = 'Увага: немає config/promo.php із секретом — відеореклама не показуватиметься (старі банери працюють).';
        }
        $back($str('return_tab') ?: 'settings', true, $msgs);

    case 'campaign_status':
        $op = $str('op');
        if ($op === 'complete') {
            $st = $pdo->prepare("UPDATE ad_campaigns SET status = 'completed', stop_reason = 'admin' WHERE id = :id AND format = 'video' AND status <> 'completed'");
            $st->execute([':id' => (int) $str('campaign_id')]);
            $back($str('return_tab') ?: 'campaigns', $st->rowCount() > 0, [$st->rowCount() > 0 ? 'Кампанію завершено.' : 'Кампанію не знайдено або вже завершено.']);
        }
        [$ok, $msg] = promo_admin_campaign_status($pdo, (int) $str('campaign_id'), $op);
        $back($str('return_tab') ?: 'campaigns', $ok, [$msg]);

    case 'suspend_creative':
        [$ok, $msg] = promo_admin_suspend_creative($pdo, $adminId, (int) $str('creative_id'), $str('reason'));
        $back('reports', $ok, [$msg]);

    case 'reports_reviewed':
        $pdo->prepare("UPDATE ad_reports SET status = 'reviewed' WHERE creative_id = :id")->execute([':id' => (int) $str('creative_id')]);
        $back('reports', true, ['Скарги позначено як розглянуті.']);
}

$back('moderation', false, ['Невідома дія.']);
