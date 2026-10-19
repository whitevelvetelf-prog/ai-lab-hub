<?php

declare(strict_types=1);

/**
 * AI LAB HUB — керований аутріч (блок M3). КОЖЕН лист схвалює людина; автоматично нічого не надсилається.
 *
 * Шлях листа: лід «Схвалено для аутрічу» → «Підготувати чернетку» (шаблон, за бажання — перефразування моделлю
 * без персональних даних) → адмін редагує → «Схвалити й поставити в чергу» (draft → queued, хто й коли схвалив —
 * у журналі) → диспетчер (cron/outreach-send.php) переносить ОДИН лист у наявну mail_queue, якщо:
 *   аутріч увімкнено й налаштовано (omail_ready_issues() порожній), зараз робочі години (Київ, пн–пт),
 *   денний ліміт не вичерпано (з графіком розгону), минула випадкова пауза після попереднього листа,
 *   адреса й домен НЕ в списку заборон (перевірка перед КОЖНОЮ відправкою).
 * Лист містить ім'я й роль відправника, причину звернення, адресу відправника, посилання відписки
 * (unsubscribe.php?t=…, одноразовий токен із терміном дії) і заголовки List-Unsubscribe / List-Unsubscribe-Post.
 * Нагадування — максимум одне, через N днів без відповіді, теж лише після схвалення людиною.
 * Лід без адреси (лише форма контактів): система готує текст, адмін надсилає вручну → «надіслано вручну».
 */

require_once __DIR__ . '/outreach.php';
require_once __DIR__ . '/listing.php';
require_once __DIR__ . '/promo-mail.php';

const OMAIL_SUPPRESS_REASONS = [
    'unsubscribe' => 'Відписка', 'declined' => 'Відмова', 'bounce' => 'Відскок', 'complaint' => 'Скарга',
    'manual' => 'Ручне блокування', 'erasure' => 'Видалення на прохання',
];
const OMAIL_VARS = ['company', 'context_sentence', 'title', 'source_name', 'company_website', 'free_until', 'join_url', 'unsubscribe_url',
    'sender_name', 'sender_role', 'site_url', 'legal_address'];
const OMAIL_UNSUB_DAYS = 365;   // термін дії посилання відписки
const OMAIL_JOIN_DAYS = 120;    // термін дії посилання-запрошення
const OMAIL_MAX_WORDS = 120;    // ліміт слів для перефразованого листа
const OMAIL_TZ = 'Europe/Kyiv';

// =========================================================================
// Налаштування й готовність
// =========================================================================

/** @return array<string,string> */
function omail_settings(PDO $pdo): array
{
    $keys = ['enabled' => '0', 'sender_name' => '', 'sender_role' => '', 'legal_address' => '', 'unsubscribe_email' => '',
        'reply_to' => 'partners@ailabhub-directory.com', 'from_email' => 'partners@ailabhub-directory.com', 'rules_ack' => '',
        'daily_cap' => '10', 'rampup' => '10,15,20,30,40', 'ramp_start' => '', 'pause_min' => '3', 'pause_max' => '9',
        'window_start' => '9', 'window_end' => '18', 'followup_days' => '7', 'paraphrase' => '0', 'next_send_at' => ''];
    $out = [];
    foreach ($keys as $k => $def) {
        $out[$k] = site_setting($pdo, 'outreach_' . $k, $def);
    }

    return $out;
}

/** Чого бракує, щоб аутріч міг працювати (порожньо — готово). @return list<string> */
function omail_ready_issues(PDO $pdo): array
{
    $s = omail_settings($pdo);
    $issues = [];
    foreach (['sender_name' => 'ім\'я відправника', 'sender_role' => 'роль відправника', 'legal_address' => 'юридична чи поштова адреса відправника'] as $k => $label) {
        if (trim($s[$k]) === '') {
            $issues[] = 'Не заповнено: ' . $label . '.';
        }
    }
    if (filter_var($s['unsubscribe_email'], FILTER_VALIDATE_EMAIL) === false) {
        $issues[] = 'Не заповнено: адреса для відписки (email).';
    }
    if (filter_var($s['reply_to'], FILTER_VALIDATE_EMAIL) === false) {
        $issues[] = 'Не заповнено: адреса для відповідей.';
    }
    if (filter_var($s['from_email'], FILTER_VALIDATE_EMAIL) === false) {
        $issues[] = 'Не заповнено: адреса відправника (From).';
    }
    if ($s['rules_ack'] === '') {
        $issues[] = 'Не підтверджено перегляд правил розсилок у країні відправника й одержувачів.';
    }
    $free = lst_settings($pdo)['free_until'];
    if ($free === '' || $free < date('Y-m-d')) {
        $issues[] = 'Не задано майбутню дату безкоштовного розміщення (вкладка «Налаштування»).';
    }
    if (!mp_public_enabled()) {
        $issues[] = 'Маркетплейс приховано від відвідувачів — запрошені компанії не зможуть розмістити оголошення.';
    }

    return $issues;
}

function omail_enabled(PDO $pdo): bool
{
    return site_setting($pdo, 'outreach_enabled', '0') === '1' && omail_ready_issues($pdo) === [];
}

/** Денний ліміт з урахуванням графіка розгону: min(стеля outreach_daily_cap, значення тижня з outreach_rampup). */
function omail_effective_cap(PDO $pdo, ?int $now = null): int
{
    $s = omail_settings($pdo);
    $cap = max(0, (int) $s['daily_cap']);
    $ramp = array_values(array_filter(array_map('intval', explode(',', $s['rampup'])), static fn($x) => $x > 0));
    if ($ramp === [] || $s['ramp_start'] === '') {
        return $ramp === [] ? $cap : min($cap, $ramp[0]);
    }
    $days = max(0, (int) floor((($now ?? time()) - (int) strtotime($s['ramp_start'])) / 86400));
    $week = min(count($ramp) - 1, intdiv($days, 7));

    return min($cap, $ramp[$week]);
}

/** Чи зараз вікно відправки (Київ, пн–пт, [start; end) год). */
function omail_in_window(PDO $pdo, ?int $now = null): bool
{
    $s = omail_settings($pdo);
    $d = (new DateTimeImmutable('@' . ($now ?? time())))->setTimezone(new DateTimeZone(OMAIL_TZ));
    $h = (int) $d->format('G');

    return (int) $d->format('N') <= 5 && $h >= (int) $s['window_start'] && $h < (int) $s['window_end'];
}

/** Скільки листів аутрічу передано у відправку за поточну київську добу. */
function omail_sent_today(PDO $pdo, ?int $now = null): int
{
    $tz = new DateTimeZone(OMAIL_TZ);
    $d = (new DateTimeImmutable('@' . ($now ?? time())))->setTimezone($tz);
    $start = $d->setTime(0, 0)->setTimezone(new DateTimeZone('UTC'))->format('Y-m-d H:i:s');
    $st = $pdo->prepare("SELECT COUNT(*) FROM outreach_messages WHERE status IN ('sent', 'failed') AND sent_at >= :s");
    $st->execute([':s' => $start]);

    return (int) $st->fetchColumn();
}

// =========================================================================
// Журнал, список заборон, токени
// =========================================================================

function omail_log(PDO $pdo, ?int $leadId, ?int $actor, string $action, ?string $note = null, ?int $messageId = null): void
{
    $pdo->prepare('INSERT INTO outreach_log (lead_id, message_id, actor_id, action, note, created_at) VALUES (:l, :m, :a, :act, :n, :c)')
        ->execute([':l' => $leadId, ':m' => $messageId, ':a' => $actor, ':act' => mb_substr($action, 0, 30),
            ':n' => $note !== null ? mb_substr($note, 0, 500) : null, ':c' => gmdate('Y-m-d H:i:s')]);
}

/** Причина заборони для адреси (сама адреса або її домен чи батьківський домен) або null. */
function omail_suppressed(PDO $pdo, ?string $email, ?string $domain = null): ?string
{
    $email = strtolower(trim((string) $email));
    $domains = [];
    $d = $domain !== null && $domain !== '' ? strtolower($domain) : ($email !== '' && str_contains($email, '@') ? substr($email, strpos($email, '@') + 1) : '');
    while ($d !== '' && str_contains($d, '.')) {
        $domains[] = $d;
        $d = substr($d, strpos($d, '.') + 1);
    }
    $st = $pdo->prepare("SELECT reason FROM outreach_suppression WHERE (kind = 'email' AND value = :e) OR (kind = 'domain' AND value IN ('" . implode("','", array_map(static fn($x) => preg_replace('/[^a-z0-9.\-]/', '', $x), $domains ?: ['-'])) . "')) LIMIT 1");
    $st->execute([':e' => $email !== '' ? $email : '-']);
    $r = $st->fetchColumn();

    return $r === false ? null : (string) $r;
}

/** Додати до списку заборон (повтор — без помилки). */
function omail_suppress(PDO $pdo, string $kind, string $value, string $reason, ?string $note = null, ?int $actor = null): bool
{
    $kind = $kind === 'domain' ? 'domain' : 'email';
    $value = strtolower(trim($value));
    if ($kind === 'email' && filter_var($value, FILTER_VALIDATE_EMAIL) === false) {
        return false;
    }
    if ($kind === 'domain') {
        $value = outreach_domain($value);
        if ($value === '' || !str_contains($value, '.')) {
            return false;
        }
    }
    if (!isset(OMAIL_SUPPRESS_REASONS[$reason])) {
        $reason = 'manual';
    }
    $pdo->prepare('INSERT IGNORE INTO outreach_suppression (kind, value, reason, note, created_by) VALUES (:k, :v, :r, :n, :a)')
        ->execute([':k' => $kind, ':v' => $value, ':r' => $reason, ':n' => $note !== null ? mb_substr($note, 0, 500) : null, ':a' => $actor]);

    return true;
}

/** Новий токен (повертає «сирий» рядок; у БД — лише sha256). */
function omail_token_create(PDO $pdo, int $leadId, string $purpose, ?int $messageId, int $days): string
{
    $raw = bin2hex(random_bytes(24));
    $pdo->prepare('INSERT INTO outreach_tokens (token_hash, purpose, lead_id, message_id, expires_at, created_at) VALUES (:h, :p, :l, :m, :e, :c)')
        ->execute([':h' => hash('sha256', $raw), ':p' => $purpose, ':l' => $leadId, ':m' => $messageId,
            ':e' => gmdate('Y-m-d H:i:s', time() + $days * 86400), ':c' => gmdate('Y-m-d H:i:s')]);

    return $raw;
}

/** Рядок токена (будь-який стан) або null: формат перевіряється до запиту. */
function omail_token_find(PDO $pdo, string $raw, string $purpose): ?array
{
    if (preg_match('/^[a-f0-9]{48}$/', $raw) !== 1) {
        return null;
    }
    $st = $pdo->prepare('SELECT * FROM outreach_tokens WHERE token_hash = :h AND purpose = :p');
    $st->execute([':h' => hash('sha256', $raw), ':p' => $purpose]);
    $r = $st->fetch(PDO::FETCH_ASSOC);

    return $r === false ? null : $r;
}

// =========================================================================
// Шаблони й чернетки
// =========================================================================

/** @return array{subject:string,body:string} */
function omail_template(PDO $pdo, string $key, string $lang): array
{
    $st = $pdo->prepare('SELECT subject, body FROM outreach_templates WHERE template_key = :k AND lang = :l');
    $st->execute([':k' => $key, ':l' => $lang]);
    $r = $st->fetch(PDO::FETCH_ASSOC);

    return $r === false ? ['subject' => '', 'body' => ''] : ['subject' => (string) $r['subject'], 'body' => (string) $r['body']];
}

/** Мова листа: uk для українськомовних лідів, інакше en. */
function omail_lead_lang(array $lead): string
{
    return ($lead['language'] ?? '') === 'uk' || ($lead['country'] ?? '') === 'UA' ? 'uk' : 'en';
}

/**
 * Змінні ліду, що підставляються вже в чернетку: company, context_sentence, title, source_name, company_website.
 * Решта (дані відправника, адреса, дата, сайт — omail_send_vars(), і посилання join_url / unsubscribe_url)
 * підставляються в момент відправки: тоді вони гарантовано заповнені (omail_ready_issues()) і актуальні.
 *
 * @return array<string,string>
 */
function omail_vars(PDO $pdo, array $lead, string $lang): array
{
    $title = trim((string) ($lead['title'] ?? ''));
    $source = trim((string) ($lead['source_name'] ?? ''));
    $website = trim((string) ($lead['company_website'] ?? ''));
    $websiteShort = $website !== '' ? (outreach_domain($website) ?: $website) : '';
    if ($lead['lead_type'] === 'job' && $title !== '' && $source !== '' && !in_array($lead['source_key'], ['manual', 'csv'], true)) {
        $context = $lang === 'uk' ? 'Ми побачили вашу вакансію «' . $title . '» на ' . $source . '.' : 'We saw your job posting “' . $title . '” on ' . $source . '.';
    } elseif ($websiteShort !== '') {
        $context = $lang === 'uk' ? 'Ми знайшли ваш сайт ' . $websiteShort . '.' : 'We came across your website ' . $websiteShort . '.';
    } else {
        $context = $lang === 'uk' ? 'Ми знайшли інформацію про ' . $lead['company_name'] . ' у відкритих джерелах.' : 'We came across ' . $lead['company_name'] . ' in public sources.';
    }

    return [
        'company' => (string) $lead['company_name'], 'context_sentence' => $context, 'title' => $title, 'source_name' => $source,
        'company_website' => $websiteShort,
    ];
}

/** Змінні з налаштувань — у момент відправки. @return array<string,string> */
function omail_send_vars(PDO $pdo, string $lang): array
{
    $s = omail_settings($pdo);
    $free = lst_settings($pdo)['free_until'];

    return [
        'free_until' => $free !== '' ? lst_date_lang($free, $lang) : '', 'sender_name' => $s['sender_name'], 'sender_role' => $s['sender_role'],
        'site_url' => lst_site_url(), 'legal_address' => $s['legal_address'],
    ];
}

/** Підставити змінні; невідомі/відкладені ({join_url}, {unsubscribe_url}) лишаються як є. */
function omail_fill(string $text, array $vars): string
{
    $repl = [];
    foreach ($vars as $k => $v) {
        $repl['{' . $k . '}'] = $v;
    }

    return strtr($text, $repl);
}

/** Змінні {…}, присутні в тексті. @return list<string> */
function omail_placeholders(string $text): array
{
    preg_match_all('/\{([a-z_]+)\}/', $text, $m);
    $found = array_values(array_unique(array_intersect($m[1], OMAIL_VARS)));
    sort($found);

    return $found;
}

/**
 * Перефразування шаблону моделлю: у промпт іде ЛИШЕ текст шаблону зі змінними {…} (без імен, адрес, назв компаній).
 * Перевірка результату: ті самі змінні, не більше OMAIL_MAX_WORDS слів, без нових посилань/цифр. Інакше — null.
 */
function omail_paraphrase(PDO $pdo, string $templateBody, string $lang, ?callable $transport = null): ?string
{
    $cfgFile = __DIR__ . '/../config/ai-assistant.php';
    if (!is_file($cfgFile)) {
        return null;
    }
    require_once __DIR__ . '/eli.php';
    $cfg = eli_settings(require $cfgFile);
    if ($cfg['api_key'] === '' && $transport === null) {
        return null;
    }
    $system = 'You rewrite a short business email template. Keep it polite, short and factual, at most ' . OMAIL_MAX_WORDS . ' words, '
        . 'in the same language (' . ($lang === 'uk' ? 'Ukrainian' : 'English') . '). No flattery, no new claims, no numbers, no links. '
        . 'Keep EVERY placeholder in curly braces exactly as written (e.g. {join_url}, {unsubscribe_url}), keep the unsubscribe sentence '
        . 'and the signature lines. Answer with JSON only: {"body":"..."}.';
    try {
        $r = eli_provider_call($cfg, (string) $cfg['model'], $system, $templateBody, 20, $transport ?? 'eli_http_post', null, 0.2);
    } catch (Throwable $e) {
        error_log('[outreach] paraphrase: ' . $e->getMessage());

        return null;
    }
    $json = !empty($r['ok']) ? eli_extract_json((string) $r['text']) : null;
    $out = is_array($json) && is_string($json['body'] ?? null) ? trim($json['body']) : '';

    return omail_paraphrase_valid($templateBody, $out) ? $out : null;
}

/** Чи придатний перефразований текст (ті самі змінні, ліміт слів, без нових посилань і цифр). */
function omail_paraphrase_valid(string $original, string $candidate): bool
{
    if ($candidate === '' || omail_placeholders($original) !== omail_placeholders($candidate)) {
        return false;
    }
    $plain = preg_replace('/\{[a-z_]+\}/', '', $candidate) ?? $candidate;
    if (count(preg_split('/\s+/u', trim($plain)) ?: []) > OMAIL_MAX_WORDS) {
        return false;
    }
    $origPlain = preg_replace('/\{[a-z_]+\}/', '', $original) ?? $original;

    return preg_match('~https?://|www\.~i', $plain) !== 1 && (preg_match('/\d/', $plain) !== 1 || preg_match('/\d/', $origPlain) === 1);
}

/**
 * «Підготувати чернетку»: initial — для ліду «Схвалено для аутрічу», followup — для ліду «Надіслано» без нагадування.
 * @return array{ok:bool,message:string,id:?int}
 */
function omail_prepare_draft(PDO $pdo, int $leadId, ?int $actor, string $kind = 'initial', ?callable $transport = null): array
{
    $st = $pdo->prepare('SELECT * FROM outreach_leads WHERE id = :id');
    $st->execute([':id' => $leadId]);
    $lead = $st->fetch(PDO::FETCH_ASSOC);
    if ($lead === false) {
        return ['ok' => false, 'message' => 'лід не знайдено', 'id' => null];
    }
    $need = $kind === 'followup' ? 'sent' : 'approved';
    if ($lead['status'] !== $need) {
        return ['ok' => false, 'message' => 'статус ліду має бути «' . OUTREACH_STATUS_UK[$need] . '»', 'id' => null];
    }
    $exists = $pdo->prepare("SELECT COUNT(*) FROM outreach_messages WHERE lead_id = :l AND kind = :k AND status <> 'cancelled'");
    $exists->execute([':l' => $leadId, ':k' => $kind]);
    if ((int) $exists->fetchColumn() > 0) {
        return ['ok' => false, 'message' => $kind === 'followup' ? 'нагадування вже є (максимум одне)' : 'чернетка вже є', 'id' => null];
    }
    if (($why = omail_suppressed($pdo, $lead['contact_email'], $lead['company_domain'])) !== null) {
        return ['ok' => false, 'message' => 'адреса або домен у списку заборон (' . (OMAIL_SUPPRESS_REASONS[$why] ?? $why) . ')', 'id' => null];
    }
    $lang = omail_lead_lang($lead);
    $tplKey = $kind === 'followup' ? 'followup' : 'invite';
    $tpl = omail_template($pdo, $tplKey, $lang);
    if ($tpl['body'] === '') {
        return ['ok' => false, 'message' => 'немає шаблону ' . $tplKey . '/' . $lang, 'id' => null];
    }
    $body = $tpl['body'];
    $paraphrased = 0;
    if (site_setting($pdo, 'outreach_paraphrase', '0') === '1') {
        $p = omail_paraphrase($pdo, $body, $lang, $transport);
        if ($p !== null) {
            $body = $p;
            $paraphrased = 1;
        }
    }
    $vars = omail_vars($pdo, $lead, $lang);
    $email = $lead['contact_email'] !== null && outreach_is_business_email((string) $lead['contact_email']) ? (string) $lead['contact_email'] : null;
    $pdo->prepare(
        "INSERT INTO outreach_messages (lead_id, kind, template_key, lang, to_email, subject, body, paraphrased, status, created_by, created_at)
         VALUES (:l, :k, :t, :lang, :e, :s, :b, :p, 'draft', :a, :c)"
    )->execute([':l' => $leadId, ':k' => $kind, ':t' => $tplKey, ':lang' => $lang, ':e' => $email,
        ':s' => mb_substr(omail_fill($tpl['subject'], $vars), 0, 200), ':b' => omail_fill($body, $vars), ':p' => $paraphrased, ':a' => $actor, ':c' => gmdate('Y-m-d H:i:s')]);
    $id = (int) $pdo->lastInsertId();
    if ($kind === 'initial') {
        $pdo->prepare("UPDATE outreach_leads SET status = 'draft_ready', last_action_at = NOW() WHERE id = :id")->execute([':id' => $leadId]);
    }
    omail_log($pdo, $leadId, $actor, 'draft', $kind . ($paraphrased ? ' (перефразовано)' : ''), $id);

    return ['ok' => true, 'message' => 'чернетку підготовлено' . ($paraphrased ? ' (перефразовано моделлю)' : ''), 'id' => $id];
}

/** @return array<string,mixed>|null */
function omail_message(PDO $pdo, int $id): ?array
{
    $st = $pdo->prepare('SELECT m.*, l.company_name, l.company_domain, l.contact_url, l.status AS lead_status FROM outreach_messages m JOIN outreach_leads l ON l.id = m.lead_id WHERE m.id = :id');
    $st->execute([':id' => $id]);
    $r = $st->fetch(PDO::FETCH_ASSOC);

    return $r === false ? null : $r;
}

/** Редагування чернетки (лише draft). */
function omail_update_draft(PDO $pdo, int $id, string $subject, string $body, ?int $actor): bool
{
    $subject = mb_substr(trim(str_replace(["\r", "\n"], ' ', strip_tags($subject))), 0, 200);
    $body = mb_substr(trim(strip_tags(str_replace("\r\n", "\n", $body))), 0, 6000);
    if ($subject === '' || $body === '') {
        return false;
    }
    $st = $pdo->prepare("UPDATE outreach_messages SET subject = :s, body = :b WHERE id = :id AND status = 'draft'");
    $st->execute([':s' => $subject, ':b' => $body, ':id' => $id]);
    if ($st->rowCount() > 0) {
        $m = omail_message($pdo, $id);
        omail_log($pdo, $m !== null ? (int) $m['lead_id'] : null, $actor, 'draft_edit', null, $id);
    }

    return true;
}

/** Гарантує рядок відписки в тексті (якщо адмін випадково його видалив). */
function omail_ensure_unsub(string $body, string $lang): string
{
    if (str_contains($body, '{unsubscribe_url}')) {
        return $body;
    }

    return rtrim($body) . "\n\n" . ($lang === 'uk' ? 'Відписатися: {unsubscribe_url}' : 'Unsubscribe: {unsubscribe_url}');
}

/**
 * «Схвалити й поставити в чергу» (лише людина, лише draft з діловою адресою). draft → queued.
 * @return string 'ok' або текст помилки
 */
function omail_approve(PDO $pdo, int $id, int $actor): string
{
    $m = omail_message($pdo, $id);
    if ($m === null || $m['status'] !== 'draft') {
        return 'чернетку не знайдено або її вже схвалено';
    }
    if ($m['to_email'] === null || !outreach_is_business_email((string) $m['to_email'])) {
        return 'немає ділової адреси — використайте ручну відправку через форму контактів';
    }
    if (($why = omail_suppressed($pdo, (string) $m['to_email'], (string) $m['company_domain'])) !== null) {
        return 'адреса або домен у списку заборон (' . (OMAIL_SUPPRESS_REASONS[$why] ?? $why) . ')';
    }
    $pdo->prepare("UPDATE outreach_messages SET status = 'queued', body = :b, approved_by = :a, approved_at = :t WHERE id = :id AND status = 'draft'")
        ->execute([':b' => omail_ensure_unsub((string) $m['body'], (string) $m['lang']), ':a' => $actor, ':t' => gmdate('Y-m-d H:i:s'), ':id' => $id]);
    if ($m['kind'] === 'initial') {
        $pdo->prepare("UPDATE outreach_leads SET status = 'queued', last_action_at = NOW() WHERE id = :id")->execute([':id' => (int) $m['lead_id']]);
    }
    omail_log($pdo, (int) $m['lead_id'], $actor, 'approved', 'схвалено й поставлено в чергу', $id);

    return 'ok';
}

/** Скасувати чернетку або лист у черзі. */
function omail_cancel(PDO $pdo, int $id, int $actor): bool
{
    $m = omail_message($pdo, $id);
    if ($m === null || !in_array($m['status'], ['draft', 'queued'], true)) {
        return false;
    }
    $pdo->prepare("UPDATE outreach_messages SET status = 'cancelled' WHERE id = :id")->execute([':id' => $id]);
    if ($m['kind'] === 'initial' && in_array($m['lead_status'], ['draft_ready', 'queued'], true)) {
        $pdo->prepare("UPDATE outreach_leads SET status = 'approved' WHERE id = :id")->execute([':id' => (int) $m['lead_id']]);
    }
    omail_log($pdo, (int) $m['lead_id'], $actor, 'cancelled', null, $id);

    return true;
}

/**
 * Фінальні тема й текст листа: створює (один раз на лист) токени відписки й запрошення і підставляє посилання.
 * @return array{subject:string,body:string,unsubscribe_url:string}
 */
function omail_finalize(PDO $pdo, array $m): array
{
    $site = lst_site_url();
    $st = $pdo->prepare("SELECT purpose FROM outreach_tokens WHERE message_id = :m");
    $st->execute([':m' => (int) $m['id']]);
    if ($st->fetchAll(PDO::FETCH_COLUMN) !== []) {
        // Токени вже створено (повторна фіналізація ручного листа): «сирих» значень не зберігаємо — створюємо нові.
        $pdo->prepare("UPDATE outreach_tokens SET expires_at = :now WHERE message_id = :m AND used_at IS NULL")
            ->execute([':now' => gmdate('Y-m-d H:i:s'), ':m' => (int) $m['id']]);
    }
    $unsub = $site . '/unsubscribe.php?t=' . omail_token_create($pdo, (int) $m['lead_id'], 'unsub', (int) $m['id'], OMAIL_UNSUB_DAYS);
    $join = $site . '/marketplace-join.php?t=' . omail_token_create($pdo, (int) $m['lead_id'], 'join', (int) $m['id'], OMAIL_JOIN_DAYS);
    $vars = omail_send_vars($pdo, (string) $m['lang']) + ['unsubscribe_url' => $unsub, 'join_url' => $join];
    $body = omail_fill(omail_ensure_unsub((string) $m['body'], (string) $m['lang']), $vars);

    return ['subject' => omail_fill((string) $m['subject'], $vars), 'body' => $body, 'unsubscribe_url' => $unsub];
}

/** Ручна відправка (лід без адреси): готує фінальний текст для форми контактів. */
function omail_manual_text(PDO $pdo, int $id): ?array
{
    $m = omail_message($pdo, $id);
    if ($m === null || $m['status'] !== 'draft') {
        return null;
    }

    return omail_finalize($pdo, $m);
}

/** «Позначити: надіслано вручну» (людина надіслала текст через форму контактів компанії). */
function omail_mark_manual(PDO $pdo, int $id, int $actor): bool
{
    $m = omail_message($pdo, $id);
    if ($m === null || $m['status'] !== 'draft') {
        return false;
    }
    if (omail_suppressed($pdo, null, (string) $m['company_domain']) !== null) {
        return false;
    }
    $now = gmdate('Y-m-d H:i:s');
    $pdo->prepare("UPDATE outreach_messages SET status = 'sent_manual', approved_by = :a, approved_at = :t1, sent_at = :t2 WHERE id = :id")
        ->execute([':a' => $actor, ':t1' => $now, ':t2' => $now, ':id' => $id]);
    $pdo->prepare("UPDATE outreach_leads SET status = 'sent_manual', last_action_at = NOW() WHERE id = :id")->execute([':id' => (int) $m['lead_id']]);
    omail_log($pdo, (int) $m['lead_id'], $actor, 'sent_manual', 'надіслано вручну через форму контактів', $id);

    return true;
}

// =========================================================================
// Диспетчер: один лист за запуск, у межах правил
// =========================================================================

/**
 * Переносить у mail_queue щонайбільше ОДИН схвалений лист, якщо всі умови виконано.
 * $now / $rand — для тестів. Повертає опис того, що сталося.
 */
function omail_dispatch(PDO $pdo, ?int $now = null, ?callable $rand = null): string
{
    $now ??= time();
    $rand ??= static fn(int $a, int $b): int => random_int($a, $b);
    if (site_setting($pdo, 'outreach_enabled', '0') !== '1') {
        return 'аутріч вимкнено';
    }
    if (($issues = omail_ready_issues($pdo)) !== []) {
        return 'аутріч не налаштовано: ' . $issues[0];
    }
    if (!omail_in_window($pdo, $now)) {
        return 'поза вікном відправки';
    }
    $s = omail_settings($pdo);
    if ($s['next_send_at'] !== '' && strtotime($s['next_send_at'] . ' UTC') > $now) {
        return 'пауза до ' . $s['next_send_at'] . ' UTC';
    }
    $cap = omail_effective_cap($pdo, $now);
    if (omail_sent_today($pdo, $now) >= $cap) {
        return 'денний ліміт вичерпано (' . $cap . ')';
    }
    $m = $pdo->query("SELECT id FROM outreach_messages WHERE status = 'queued' AND approved_by IS NOT NULL AND approved_at IS NOT NULL ORDER BY approved_at, id LIMIT 1")->fetchColumn();
    if ($m === false) {
        return 'черга порожня';
    }
    $msg = omail_message($pdo, (int) $m);
    // Перевірка списку заборон безпосередньо перед відправкою.
    if (($why = omail_suppressed($pdo, (string) $msg['to_email'], (string) $msg['company_domain'])) !== null) {
        $pdo->prepare("UPDATE outreach_messages SET status = 'cancelled', error = :e WHERE id = :id")->execute([':e' => 'список заборон: ' . $why, ':id' => (int) $msg['id']]);
        omail_log($pdo, (int) $msg['lead_id'], null, 'blocked', 'список заборон: ' . $why, (int) $msg['id']);

        return 'лист #' . $msg['id'] . ' скасовано: адреса в списку заборон';
    }
    if ($msg['to_email'] === null || !outreach_is_business_email((string) $msg['to_email'])) {
        $pdo->prepare("UPDATE outreach_messages SET status = 'cancelled', error = 'немає ділової адреси' WHERE id = :id")->execute([':id' => (int) $msg['id']]);

        return 'лист #' . $msg['id'] . ' скасовано: немає ділової адреси';
    }
    $fin = omail_finalize($pdo, $msg);
    $unsubMail = $s['unsubscribe_email'];
    $headers = [
        'from_email' => $s['from_email'],
        'from_name' => $s['sender_name'] . ' · AI LAB HUB',
        'reply_to' => $s['reply_to'],
        'headers' => [
            'List-Unsubscribe' => '<' . $fin['unsubscribe_url'] . '>, <mailto:' . $unsubMail . '?subject=unsubscribe>',
            'List-Unsubscribe-Post' => 'List-Unsubscribe=One-Click',
        ],
    ];
    $html = '<div style="font-family:Arial,sans-serif;font-size:15px;line-height:1.55;color:#1d2433">'
        . nl2br(preg_replace('~(https?://[^\s<]+)~', '<a href="$1" style="color:#2f5bd3">$1</a>', htmlspecialchars($fin['body'], ENT_QUOTES)) ?? '') . '</div>';
    $nowUtc = gmdate('Y-m-d H:i:s', $now);
    $pdo->prepare(
        "INSERT INTO mail_queue (to_email, to_name, subject, body_text, body_html, lang, status, attempts, send_after, created_at, headers_json, channel)
         VALUES (:e, :n, :s, :t, :h, :l, 'pending', 0, :a, :c, :hj, 'outreach')"
    )->execute([':e' => $msg['to_email'], ':n' => mb_substr((string) $msg['company_name'], 0, 190), ':s' => $fin['subject'], ':t' => $fin['body'],
        ':h' => $html, ':l' => $msg['lang'], ':a' => $nowUtc, ':c' => $nowUtc, ':hj' => json_encode($headers, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES)]);
    $qid = (int) $pdo->lastInsertId();
    $pdo->prepare("UPDATE outreach_messages SET status = 'sent', sent_at = :t, mail_queue_id = :q WHERE id = :id")->execute([':t' => $nowUtc, ':q' => $qid, ':id' => (int) $msg['id']]);
    $pdo->prepare("UPDATE outreach_leads SET status = 'sent', last_action_at = NOW() WHERE id = :id AND status IN ('queued', 'sent', 'approved', 'draft_ready')")
        ->execute([':id' => (int) $msg['lead_id']]);
    omail_log($pdo, (int) $msg['lead_id'], null, 'sent', $msg['kind'] . ' → mail_queue #' . $qid, (int) $msg['id']);
    $pauseMin = max(1, (int) $s['pause_min']);
    $pauseMax = max($pauseMin, (int) $s['pause_max']);
    $next = gmdate('Y-m-d H:i:s', $now + $rand($pauseMin, $pauseMax) * 60);
    site_settings_save($pdo, ['outreach_next_send_at' => $next]);

    return 'лист #' . $msg['id'] . ' передано у відправку (mail_queue #' . $qid . '), наступний не раніше ' . $next . ' UTC';
}

/** Відскоки: лист аутрічу, який mail_queue остаточно не відправила → failed, лід bounced, адреса в список заборон. */
function omail_sync_queue(PDO $pdo): int
{
    $rows = $pdo->query(
        "SELECT m.id, m.lead_id, m.to_email, q.last_error FROM outreach_messages m JOIN mail_queue q ON q.id = m.mail_queue_id
         WHERE m.status = 'sent' AND q.status = 'failed'"
    )->fetchAll(PDO::FETCH_ASSOC);
    foreach ($rows as $r) {
        $pdo->prepare("UPDATE outreach_messages SET status = 'failed', error = :e WHERE id = :id")->execute([':e' => mb_substr((string) $r['last_error'], 0, 500), ':id' => (int) $r['id']]);
        $pdo->prepare("UPDATE outreach_leads SET status = 'bounced', last_action_at = NOW() WHERE id = :id")->execute([':id' => (int) $r['lead_id']]);
        omail_suppress($pdo, 'email', (string) $r['to_email'], 'bounce', 'помилка SMTP: ' . mb_substr((string) $r['last_error'], 0, 200));
        omail_log($pdo, (int) $r['lead_id'], null, 'bounced', mb_substr((string) $r['last_error'], 0, 300), (int) $r['id']);
    }

    return count($rows);
}

/** Чернетки нагадувань (одне на лід) для лідів «Надіслано» без відповіді понад N днів. Схвалює людина. */
function omail_followup_drafts(PDO $pdo, int $limit = 20): int
{
    $days = max(1, (int) site_setting($pdo, 'outreach_followup_days', '7'));
    $ids = $pdo->query(
        "SELECT l.id FROM outreach_leads l
         JOIN outreach_messages m ON m.lead_id = l.id AND m.kind = 'initial' AND m.status = 'sent'
         WHERE l.status = 'sent' AND m.sent_at <= '" . gmdate('Y-m-d H:i:s', time() - $days * 86400) . "'
           AND NOT EXISTS (SELECT 1 FROM outreach_messages f WHERE f.lead_id = l.id AND f.kind = 'followup')
         ORDER BY m.sent_at LIMIT " . max(1, $limit)
    )->fetchAll(PDO::FETCH_COLUMN);
    $n = 0;
    foreach ($ids as $id) {
        $n += (int) omail_prepare_draft($pdo, (int) $id, null, 'followup')['ok'];
    }

    return $n;
}

// =========================================================================
// Відписка, запрошення, зміна статусу, видалення на прохання
// =========================================================================

/** @return string ok | already | expired | invalid */
function omail_unsubscribe(PDO $pdo, string $raw): string
{
    $t = omail_token_find($pdo, $raw, 'unsub');
    if ($t === null) {
        return 'invalid';
    }
    if ($t['used_at'] !== null) {
        return 'already';
    }
    if (strtotime($t['expires_at'] . ' UTC') < time()) {
        return 'expired';
    }
    $upd = $pdo->prepare('UPDATE outreach_tokens SET used_at = :u WHERE id = :id AND used_at IS NULL');
    $upd->execute([':u' => gmdate('Y-m-d H:i:s'), ':id' => (int) $t['id']]);
    if ($upd->rowCount() === 0) {
        return 'already';
    }
    $lead = $pdo->prepare('SELECT * FROM outreach_leads WHERE id = :id');
    $lead->execute([':id' => (int) $t['lead_id']]);
    $l = $lead->fetch(PDO::FETCH_ASSOC);
    if ($l !== false) {
        $msgEmail = $pdo->prepare('SELECT to_email FROM outreach_messages WHERE id = :m');
        $msgEmail->execute([':m' => (int) $t['message_id']]);
        $email = (string) ($msgEmail->fetchColumn() ?: $l['contact_email']);
        if ($email !== '') {
            omail_suppress($pdo, 'email', $email, 'unsubscribe', 'відписка за посиланням');
        }
        if (!empty($l['company_domain'])) {
            omail_suppress($pdo, 'domain', (string) $l['company_domain'], 'unsubscribe', 'відписка за посиланням');
        }
        $pdo->prepare("UPDATE outreach_leads SET status = 'unsubscribed', last_action_at = NOW() WHERE id = :id")->execute([':id' => (int) $l['id']]);
        $pdo->prepare("UPDATE outreach_messages SET status = 'cancelled', error = 'відписка' WHERE lead_id = :id AND status IN ('draft', 'queued')")->execute([':id' => (int) $l['id']]);
        omail_log($pdo, (int) $l['id'], null, 'unsubscribed', null, $t['message_id'] !== null ? (int) $t['message_id'] : null);
    }

    return 'ok';
}

/** Візит за запрошенням: id ліду (без персональних даних) або null. */
function omail_join_lead(PDO $pdo, string $raw): ?int
{
    $t = omail_token_find($pdo, $raw, 'join');
    if ($t === null || strtotime($t['expires_at'] . ' UTC') < time()) {
        return null;
    }
    if ($t['used_at'] === null) {
        $pdo->prepare('UPDATE outreach_tokens SET used_at = :u WHERE id = :id')->execute([':u' => gmdate('Y-m-d H:i:s'), ':id' => (int) $t['id']]);
        omail_log($pdo, (int) $t['lead_id'], null, 'join_visit', null, $t['message_id'] !== null ? (int) $t['message_id'] : null);
    }

    return (int) $t['lead_id'];
}

/** Оголошення створено за запрошенням → лід «Розмістили». */
function omail_join_listed(PDO $pdo, int $leadId, int $listingId): void
{
    $pdo->prepare("UPDATE outreach_leads SET status = 'listed', listing_id = :li, last_action_at = NOW() WHERE id = :id AND status NOT IN ('unsubscribed')")
        ->execute([':li' => $listingId, ':id' => $leadId]);
    omail_log($pdo, $leadId, null, 'listed', 'оголошення #' . $listingId);
}

/** Ручна зміна статусу ліду (адмінка): відповідь, відмова, відскок тощо. */
function omail_on_status(PDO $pdo, int $leadId, string $status, ?int $actor): void
{
    $l = $pdo->prepare('SELECT contact_email, company_domain FROM outreach_leads WHERE id = :id');
    $l->execute([':id' => $leadId]);
    $lead = $l->fetch(PDO::FETCH_ASSOC) ?: ['contact_email' => null, 'company_domain' => null];
    if ($status === 'replied') {
        $pdo->prepare('UPDATE outreach_leads SET replied_at = COALESCE(replied_at, :t) WHERE id = :id')->execute([':t' => gmdate('Y-m-d H:i:s'), ':id' => $leadId]);
    }
    $reason = ['declined' => 'declined', 'unsubscribed' => 'unsubscribe', 'bounced' => 'bounce'][$status] ?? null;
    if ($reason !== null) {
        if (!empty($lead['contact_email'])) {
            omail_suppress($pdo, 'email', (string) $lead['contact_email'], $reason, 'статус змінено вручну', $actor);
        }
        if ($reason !== 'bounce' && !empty($lead['company_domain'])) {
            omail_suppress($pdo, 'domain', (string) $lead['company_domain'], $reason, 'статус змінено вручну', $actor);
        }
        $pdo->prepare("UPDATE outreach_messages SET status = 'cancelled', error = :e WHERE lead_id = :id AND status IN ('draft', 'queued')")
            ->execute([':e' => 'статус ліду: ' . $status, ':id' => $leadId]);
    }
    omail_log($pdo, $leadId, $actor, 'status:' . $status);
}

/**
 * Видалення компанії на прохання: домен і адреси — у список заборон (щоб більше не писати), дані ліду знеособлено
 * (назва, сайт, контакти, нотатки, тексти листів). Рядки не видаляються, щоб лишалась заборона й статистика.
 * @return int кількість знеособлених лідів
 */
function omail_erase(PDO $pdo, string $domainOrEmail, ?int $actor): int
{
    $v = strtolower(trim($domainOrEmail));
    $domain = str_contains($v, '@') ? substr($v, strpos($v, '@') + 1) : outreach_domain($v);
    if ($domain === '' || !str_contains($domain, '.')) {
        return 0;
    }
    omail_suppress($pdo, 'domain', $domain, 'erasure', 'видалення на прохання', $actor);
    if (str_contains($v, '@')) {
        omail_suppress($pdo, 'email', $v, 'erasure', 'видалення на прохання', $actor);
    }
    $st = $pdo->prepare('SELECT id, contact_email FROM outreach_leads WHERE company_domain = :d OR contact_email LIKE :e');
    $st->execute([':d' => $domain, ':e' => '%@' . $domain]);
    $ids = [];
    foreach ($st->fetchAll(PDO::FETCH_ASSOC) as $r) {
        if (!empty($r['contact_email'])) {
            omail_suppress($pdo, 'email', (string) $r['contact_email'], 'erasure', 'видалення на прохання', $actor);
        }
        $ids[] = (int) $r['id'];
    }
    foreach ($ids as $id) {
        $pdo->prepare("UPDATE outreach_leads SET company_name = '[видалено на прохання]', company_website = NULL, contact_email = NULL, contact_url = NULL,
                       contact_source_url = NULL, title = NULL, notes = NULL, source_url = NULL, status = 'declined', last_action_at = NOW() WHERE id = :id")
            ->execute([':id' => $id]);
        $pdo->prepare("UPDATE outreach_messages SET subject = '[видалено]', body = '[видалено на прохання]', to_email = NULL,
                       status = IF(status IN ('draft', 'queued'), 'cancelled', status) WHERE lead_id = :id")->execute([':id' => $id]);
        omail_log($pdo, $id, $actor, 'erased', 'видалення на прохання');
    }

    return count($ids);
}

// =========================================================================
// Показники
// =========================================================================

/**
 * @return array{funnel:array<string,int>,weeks:list<array<string,mixed>>,sources:list<array<string,mixed>>,templates:list<array<string,mixed>>,
 *               avg_reply_hours:?float,sent30:int,unsub30:int,bounce30:int,warnings:list<string>}
 */
function omail_metrics(PDO $pdo): array
{
    $funnel = array_map('intval', $pdo->query('SELECT status, COUNT(*) FROM outreach_leads GROUP BY status')->fetchAll(PDO::FETCH_KEY_PAIR));
    $weeks = [];
    for ($w = 7; $w >= 0; $w--) {
        $from = gmdate('Y-m-d H:i:s', strtotime('monday this week 00:00 UTC') - $w * 7 * 86400);
        $to = gmdate('Y-m-d H:i:s', strtotime($from . ' UTC') + 7 * 86400);
        $st = $pdo->prepare('SELECT action, COUNT(*) FROM outreach_log WHERE created_at >= :f AND created_at < :t GROUP BY action');
        $st->execute([':f' => $from, ':t' => $to]);
        $a = array_map('intval', $st->fetchAll(PDO::FETCH_KEY_PAIR));
        $weeks[] = ['week' => substr($from, 0, 10), 'sent' => ($a['sent'] ?? 0) + ($a['sent_manual'] ?? 0), 'replied' => $a['status:replied'] ?? 0,
            'listed' => $a['listed'] ?? 0, 'unsubscribed' => $a['unsubscribed'] ?? 0, 'bounced' => $a['bounced'] ?? 0];
    }
    $sources = $pdo->query(
        "SELECT source_key, COUNT(*) AS leads,
                SUM(status IN ('sent', 'sent_manual', 'replied', 'listed', 'declined', 'unsubscribed', 'bounced')) AS contacted,
                SUM(status IN ('replied', 'listed')) AS replied, SUM(status = 'listed') AS listed
         FROM outreach_leads GROUP BY source_key ORDER BY leads DESC"
    )->fetchAll(PDO::FETCH_ASSOC);
    $templates = $pdo->query(
        "SELECT m.template_key, m.lang, m.paraphrased, COUNT(*) AS sent, SUM(l.status IN ('replied', 'listed')) AS replied, SUM(l.status = 'listed') AS listed
         FROM outreach_messages m JOIN outreach_leads l ON l.id = m.lead_id
         WHERE m.status IN ('sent', 'sent_manual') GROUP BY m.template_key, m.lang, m.paraphrased"
    )->fetchAll(PDO::FETCH_ASSOC);
    $avg = $pdo->query(
        "SELECT AVG(TIMESTAMPDIFF(MINUTE, m.sent_at, l.replied_at)) / 60 FROM outreach_leads l
         JOIN outreach_messages m ON m.lead_id = l.id AND m.kind = 'initial' AND m.status IN ('sent', 'sent_manual')
         WHERE l.replied_at IS NOT NULL AND l.replied_at >= m.sent_at"
    )->fetchColumn();
    $since = gmdate('Y-m-d H:i:s', time() - 30 * 86400);
    $cnt = static function (string $sql) use ($pdo, $since): int {
        $st = $pdo->prepare($sql);
        $st->execute([':s' => $since]);

        return (int) $st->fetchColumn();
    };
    $sent30 = $cnt("SELECT COUNT(*) FROM outreach_messages WHERE status IN ('sent', 'failed') AND sent_at >= :s");
    $unsub30 = $cnt("SELECT COUNT(*) FROM outreach_log WHERE action = 'unsubscribed' AND created_at >= :s");
    $bounce30 = $cnt("SELECT COUNT(*) FROM outreach_log WHERE action = 'bounced' AND created_at >= :s");
    $warnings = [];
    if ($sent30 >= 10 && $unsub30 / $sent30 > 0.02) {
        $warnings[] = sprintf('Частка відписок за 30 днів %.1f%% (більше 2%%). Рекомендуємо призупинити аутріч і переглянути добір лідів і текст.', 100 * $unsub30 / $sent30);
    }
    if ($sent30 >= 10 && $bounce30 / $sent30 > 0.05) {
        $warnings[] = sprintf('Частка відскоків за 30 днів %.1f%% (більше 5%%). Рекомендуємо призупинити аутріч і перевірити адреси й налаштування SPF/DKIM/DMARC.', 100 * $bounce30 / $sent30);
    }

    return ['funnel' => $funnel, 'weeks' => $weeks, 'sources' => $sources, 'templates' => $templates,
        'avg_reply_hours' => $avg !== null && $avg !== false ? round((float) $avg, 1) : null, 'sent30' => $sent30, 'unsub30' => $unsub30, 'bounce30' => $bounce30, 'warnings' => $warnings];
}
