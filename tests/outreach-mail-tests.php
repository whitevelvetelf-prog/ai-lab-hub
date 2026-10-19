<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тести аутрічу (M3) без живої мережі. Підключається з tests/outreach-tests.php.
 * Диспетчер сам відкриває транзакції (site_settings_save), тож тут без зовнішньої транзакції: тестові дані мають
 * домен *.outreach-test.example і прибираються наприкінці; змінені налаштування відновлюються.
 */

require_once __DIR__ . '/../app/outreach-mail.php';

function omail_tests(PDO $pdo): void
{
    echo "Аутріч (M3)\n";
    $keys = ['outreach_enabled', 'outreach_sender_name', 'outreach_sender_role', 'outreach_legal_address', 'outreach_unsubscribe_email',
        'outreach_reply_to', 'outreach_from_email', 'outreach_rules_ack', 'outreach_daily_cap', 'outreach_rampup', 'outreach_ramp_start',
        'outreach_pause_min', 'outreach_pause_max', 'outreach_window_start', 'outreach_window_end', 'outreach_next_send_at', 'outreach_paraphrase',
        'marketplace_free_until', 'marketplace_public'];
    $saved = [];
    foreach ($keys as $k) {
        $saved[$k] = site_setting($pdo, $k, '');
    }
    $mailMax = (int) $pdo->query('SELECT COALESCE(MAX(id), 0) FROM mail_queue')->fetchColumn();
    $leadIds = [];
    // Залишки попереднього перерваного прогону.
    $old = $pdo->query("SELECT id FROM outreach_leads WHERE company_domain LIKE '%outreach-test.example'")->fetchAll(PDO::FETCH_COLUMN);
    $leadIds = array_map('intval', $old);
    try {
        // Вівторок 10:00 за Києвом (у вікні), субота 10:00 (поза вікном)
        $tue = (new DateTimeImmutable('next tuesday 10:00', new DateTimeZone(OMAIL_TZ)))->getTimestamp();
        $sat = (new DateTimeImmutable('next saturday 10:00', new DateTimeZone(OMAIL_TZ)))->getTimestamp();
        site_settings_save($pdo, ['outreach_enabled' => '0', 'outreach_sender_name' => '', 'outreach_next_send_at' => '', 'outreach_paraphrase' => '0',
            'marketplace_free_until' => date('Y-m-d', time() + 90 * 86400), 'marketplace_public' => '1']);
        check(omail_dispatch($pdo, $tue) === 'аутріч вимкнено', 'вимкнений аутріч нічого не надсилає');
        check(count(omail_ready_issues($pdo)) >= 3, 'без імені, ролі, адреси й підтвердження правил — «не готово»');

        $mk = static function (string $name, ?string $email, string $status = 'approved') use ($pdo, &$leadIds): int {
            $domain = strtolower(preg_replace('/\W+/', '', $name)) . '.outreach-test.example';
            $pdo->prepare("INSERT INTO outreach_leads (source_key, source_name, source_url, company_name, company_domain, title, lead_type, country, language,
                           relevance_score, status, company_website, contact_email) VALUES ('remoteok', 'Remote OK', 'https://remoteok.com/remote-jobs/x', :n, :d,
                           'ML Engineer', 'job', 'PL', 'en', 80, :s, :w, :e)")
                ->execute([':n' => $name, ':d' => $domain, ':s' => $status, ':w' => 'https://' . $domain, ':e' => $email]);
            $id = (int) $pdo->lastInsertId();
            $leadIds[] = $id;

            return $id;
        };
        $l1 = $mk('Alpha AI', 'partners@alphaai.outreach-test.example');
        $d1 = omail_prepare_draft($pdo, $l1, null);
        check($d1['ok'], 'чернетка для схваленого ліду');
        $msg = omail_message($pdo, (int) $d1['id']);
        check(str_contains($msg['body'], 'We saw your job posting “ML Engineer” on Remote OK.') && str_contains($msg['body'], '{unsubscribe_url}') && str_contains($msg['body'], '{join_url}') && str_contains($msg['body'], '{sender_name}'),
            'чернетка: речення-контекст підставлено; посилання й дані відправника — у момент відправки');
        check(!omail_prepare_draft($pdo, $l1, null)['ok'], 'друга чернетка для того самого ліду не створюється');

        site_settings_save($pdo, ['outreach_enabled' => '1', 'outreach_sender_name' => 'Test Sender', 'outreach_sender_role' => 'Partnerships',
            'outreach_legal_address' => 'Test street 1, Kyiv', 'outreach_unsubscribe_email' => 'partners@ailabhub-directory.com',
            'outreach_reply_to' => 'partners@ailabhub-directory.com', 'outreach_from_email' => 'partners@ailabhub-directory.com', 'outreach_rules_ack' => 'test',
            'outreach_daily_cap' => '2', 'outreach_rampup' => '2,5', 'outreach_ramp_start' => date('Y-m-d'), 'outreach_pause_min' => '3', 'outreach_pause_max' => '9',
            'outreach_window_start' => '9', 'outreach_window_end' => '18', 'outreach_next_send_at' => '']);
        check(omail_ready_issues($pdo) === [], 'усі умови ввімкнення виконано: ' . implode(' ', omail_ready_issues($pdo)));
        check(omail_dispatch($pdo, $tue) === 'черга порожня', 'чернетку без схвалення людиною не надіслано');
        check((int) $pdo->query("SELECT COUNT(*) FROM mail_queue WHERE id > $mailMax")->fetchColumn() === 0, 'mail_queue порожня без схвалення');
        check(omail_dispatch($pdo, $sat) === 'поза вікном відправки', 'у вихідні — поза вікном');
        check(omail_approve($pdo, (int) $d1['id'], 1) === 'ok', 'схвалення людиною: draft → queued');
        $msg = omail_message($pdo, (int) $d1['id']);
        check($msg['status'] === 'queued' && (int) $msg['approved_by'] === 1 && $msg['approved_at'] !== null, 'журнал схвалення: хто й коли');
        $r = omail_dispatch($pdo, $tue, static fn(int $a, int $b): int => 5);
        check(str_contains($r, 'передано у відправку'), 'диспетчер передав схвалений лист: ' . $r);
        $q = $pdo->query("SELECT * FROM mail_queue WHERE id > $mailMax ORDER BY id DESC LIMIT 1")->fetch(PDO::FETCH_ASSOC);
        $h = json_decode((string) $q['headers_json'], true);
        check($q['channel'] === 'outreach' && str_contains((string) $h['headers']['List-Unsubscribe'], 'unsubscribe.php?t=') && $h['headers']['List-Unsubscribe-Post'] === 'List-Unsubscribe=One-Click',
            'заголовки List-Unsubscribe і One-Click');
        check($h['reply_to'] === 'partners@ailabhub-directory.com', 'Reply-To — окрема адреса partners@');
        check(str_contains($q['body_text'], 'Test Sender, Partnerships') && str_contains($q['body_text'], 'Test street 1, Kyiv') && str_contains($q['body_text'], '/unsubscribe.php?t=')
            && str_contains($q['body_text'], '/marketplace-join.php?t=') && !str_contains($q['body_text'], '{'), 'лист: ім\'я й роль, адреса відправника, відписка, запрошення, без незаповнених змінних');

        // Пауза й ліміт
        $l2 = $mk('Beta AI', 'hello@betaai.outreach-test.example');
        $d2 = omail_prepare_draft($pdo, $l2, null);
        omail_approve($pdo, (int) $d2['id'], 1);
        check(str_starts_with(omail_dispatch($pdo, $tue + 60), 'пауза до'), 'випадкова пауза між листами');
        check(str_contains(omail_dispatch($pdo, $tue + 6 * 60), 'передано'), 'після паузи — наступний лист');
        $l3 = $mk('Gamma AI', 'info@gammaai.outreach-test.example');
        $d3 = omail_prepare_draft($pdo, $l3, null);
        omail_approve($pdo, (int) $d3['id'], 1);
        check(str_starts_with(omail_dispatch($pdo, $tue + 30 * 60), 'денний ліміт вичерпано'), 'денний ліміт (стеля 2)');

        // Список заборон перед відправкою
        site_settings_save($pdo, ['outreach_daily_cap' => '10', 'outreach_rampup' => '10', 'outreach_next_send_at' => '']);
        omail_suppress($pdo, 'domain', 'gammaai.outreach-test.example', 'manual', 'test');
        $r = omail_dispatch($pdo, $tue + 40 * 60);
        check(str_contains($r, 'скасовано') && omail_message($pdo, (int) $d3['id'])['status'] === 'cancelled', 'адреса в списку заборон перед відправкою → лист скасовано');
        check(omail_suppressed($pdo, 'jobs@sub.gammaai.outreach-test.example') === 'manual', 'заборона домену діє й на піддомени');

        // Відписка: одноразовий токен
        preg_match('~unsubscribe\.php\?t=([a-f0-9]{48})~', (string) $q['body_text'], $m);
        $raw = $m[1] ?? '';
        check(omail_unsubscribe($pdo, $raw) === 'ok', 'відписка за токеном');
        check(omail_unsubscribe($pdo, $raw) === 'already', 'повторне використання токена — «уже відписано»');
        check(omail_suppressed($pdo, 'partners@alphaai.outreach-test.example') !== null && omail_suppressed($pdo, 'other@alphaai.outreach-test.example') !== null, 'після відписки — адреса й домен у списку заборон');
        check($pdo->query("SELECT status FROM outreach_leads WHERE id = $l1")->fetchColumn() === 'unsubscribed', 'лід «Відписались»');
        check(omail_unsubscribe($pdo, str_repeat('0', 48)) === 'invalid' && omail_unsubscribe($pdo, 'x\' OR 1=1 --') === 'invalid', 'невідомий / некоректний токен');
        $exp = omail_token_create($pdo, $l2, 'unsub', null, 1);
        $pdo->prepare("UPDATE outreach_tokens SET expires_at = '2000-01-01 00:00:00' WHERE token_hash = :h")->execute([':h' => hash('sha256', $exp)]);
        check(omail_unsubscribe($pdo, $exp) === 'expired', 'прострочений токен');
        check((int) $pdo->query("SELECT COUNT(*) FROM outreach_tokens WHERE token_hash REGEXP '^[a-f0-9]{64}$' AND lead_id IN (" . implode(',', $leadIds) . ')')->fetchColumn() > 0, 'у БД — лише хеші токенів');

        // Запрошення
        preg_match('~marketplace-join\.php\?t=([a-f0-9]{48})~', (string) $q['body_text'], $m2);
        check(omail_join_lead($pdo, $m2[1] ?? '') === $l1, 'токен запрошення прив\'язує візит до ліду');

        // Лід без ділової адреси — лише ручна відправка
        $l4 = $mk('Delta AI', null);
        $d4 = omail_prepare_draft($pdo, $l4, null);
        check($d4['ok'] && omail_approve($pdo, (int) $d4['id'], 1) !== 'ok', 'без адреси схвалити в автоматичну чергу не можна');
        $fin = omail_manual_text($pdo, (int) $d4['id']);
        check($fin !== null && str_contains($fin['body'], '/unsubscribe.php?t=') && omail_mark_manual($pdo, (int) $d4['id'], 1), 'ручна відправка: фінальний текст і позначка «надіслано вручну»');
        $l5 = $mk('Epsilon AI', 'john.smith@epsilonai.outreach-test.example');
        $d5 = omail_prepare_draft($pdo, $l5, null);
        check($d5['ok'] && omail_message($pdo, (int) $d5['id'])['to_email'] === null, 'особиста адреса (ім\'я.прізвище@) не стає адресою листа');

        // Нагадування — максимум одне
        $pdo->prepare("UPDATE outreach_messages SET sent_at = :t WHERE id = :id")->execute([':t' => gmdate('Y-m-d H:i:s', time() - 8 * 86400), ':id' => (int) $d2['id']]);
        $pdo->prepare("UPDATE outreach_leads SET status = 'sent' WHERE id = :id")->execute([':id' => $l2]);
        check(omail_followup_drafts($pdo) >= 1 && omail_followup_drafts($pdo) === 0, 'нагадування: одна чернетка, повторно не створюється');
        check((int) $pdo->query("SELECT COUNT(*) FROM outreach_messages WHERE lead_id = $l2 AND kind = 'followup' AND status = 'draft'")->fetchColumn() === 1, 'нагадування чекає схвалення людиною (draft)');

        // Перефразування: перевірка результату (без мережі)
        $tpl = omail_template($pdo, 'invite', 'en')['body'];
        check(!omail_paraphrase_valid($tpl, str_replace('{unsubscribe_url}', '', $tpl)), 'перефразування без {unsubscribe_url} відкидається');
        check(!omail_paraphrase_valid($tpl, str_replace('{sender_name}', 'John', $tpl) . ' Visit https://evil.example'), 'нові посилання / підміна змінних відкидаються');
        $fake = static fn(string $url, array $headers, string $payload, int $timeout): array => ['errno' => 0, 'error' => '', 'status' => 200, 'retry_after' => null,
            'body' => json_encode(['candidates' => [['content' => ['parts' => [['text' => json_encode(['body' => "Hello,\n{context_sentence} You can post for free until {free_until}: {join_url}. {site_url}\nNot interested? {unsubscribe_url}\n{sender_name}, {sender_role}\n{legal_address}"])]]]]]])];
        $p = omail_paraphrase($pdo, $tpl, 'en', $fake);
        check($p !== null && omail_placeholders($p) === omail_placeholders($tpl), 'перефразування з тим самим набором змінних приймається');
        $payloadSeen = '';
        $spy = static function (string $url, array $headers, string $payload, int $timeout) use (&$payloadSeen): array {
            $payloadSeen = $payload;

            return ['errno' => 0, 'error' => '', 'status' => 500, 'body' => '{}', 'retry_after' => null];
        };
        omail_paraphrase($pdo, $tpl, 'en', $spy);
        check($payloadSeen === '' || (!str_contains($payloadSeen, 'Test Sender') && !str_contains($payloadSeen, 'Alpha AI') && !str_contains($payloadSeen, '@alphaai')), 'у промпт перефразування не потрапляють імена, компанії й адреси');

        // Відмова → заборона; видалення на прохання
        omail_on_status($pdo, $l5, 'declined', 1);
        check(omail_suppressed($pdo, null, 'epsilonai.outreach-test.example') === 'declined', 'відмова → домен у списку заборон');
        $n = omail_erase($pdo, 'betaai.outreach-test.example', 1);
        $bl = $pdo->query("SELECT company_name, contact_email, company_website FROM outreach_leads WHERE id = $l2")->fetch(PDO::FETCH_ASSOC);
        check($n === 1 && $bl['company_name'] === '[видалено на прохання]' && $bl['contact_email'] === null && omail_suppressed($pdo, null, 'betaai.outreach-test.example') === 'erasure', 'видалення на прохання: знеособлено, домен у забороні');
        site_settings_save($pdo, ['outreach_rampup' => '2,5']);
        check(omail_effective_cap($pdo, time() + 8 * 86400) === 5 && omail_effective_cap($pdo, time()) === 2, 'графік розгону: тиждень 1 — 2, тиждень 2 — 5 (стеля 10)');
    } finally {
        // Прибирання тестових даних (лише *.outreach-test.example) і відновлення налаштувань.
        if ($leadIds !== []) {
            $in = implode(',', $leadIds);
            $msgIds = $pdo->query("SELECT id, mail_queue_id FROM outreach_messages WHERE lead_id IN ($in)")->fetchAll(PDO::FETCH_ASSOC);
            $q = array_filter(array_map(static fn($r) => (int) $r['mail_queue_id'], $msgIds));
            if ($q !== []) {
                $pdo->exec('DELETE FROM mail_queue WHERE id IN (' . implode(',', $q) . ')');
            }
            $pdo->exec("DELETE FROM outreach_messages WHERE lead_id IN ($in)");
            $pdo->exec("DELETE FROM outreach_tokens WHERE lead_id IN ($in)");
            $pdo->exec("DELETE FROM outreach_log WHERE lead_id IN ($in)");
            $pdo->exec("DELETE FROM outreach_leads WHERE id IN ($in)");
        }
        $pdo->exec("DELETE FROM outreach_suppression WHERE value LIKE '%outreach-test.example'");
        $pdo->exec("DELETE FROM outreach_log WHERE lead_id IS NULL AND action IN ('settings')");
        site_settings_save($pdo, $saved);
    }
}
