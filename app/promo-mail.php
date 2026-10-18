<?php

declare(strict_types=1);

/**
 * AI LAB HUB — транзакційні листи реклами (блок I).
 *
 *   * Запити сайту лише ДОДАЮТЬ листи в чергу mail_queue (promo_mail_enqueue) —
 *     сторінки не чекають на SMTP. Відправляє cron/promo-mail.php (кожні 5 хв):
 *     до PROMO_MAIL_MAX_ATTEMPTS спроб із наростаючою паузою.
 *   * Транспорт — config/mail.php: SMTP через PHPMailer (app/lib/phpmailer, без
 *     Composer), запасний mail(), або 'log' — тестовий режим без реальної відправки.
 *   * Лише транзакційні листи про рекламу (жодних розсилок). Мова — мова, яку
 *     користувач востаннє мав у кабінеті реклами (promo_notify_prefs.lang), інакше UA.
 *   * promo_notify() — єдина точка подій: визначає одержувачів і шаблон.
 */

require_once __DIR__ . '/promo.php';
require_once __DIR__ . '/mailer.php';

const PROMO_MAIL_MAX_ATTEMPTS = 5;
/** Пауза перед повторною спробою (хв) за номером невдалої спроби. */
const PROMO_MAIL_BACKOFF_MIN = [1 => 5, 2 => 15, 3 => 60, 4 => 240];
const PROMO_MAIL_CONTACT = 'partners@ailabhub-directory.com';

/** @return array{transport:string,host:string,port:int,encryption:string,username:string,password:string,from_email:string,from_name:string,reply_to:string,admin_emails:list<string>} */
function promo_mail_config(): array
{
    static $cfg = null;
    if ($cfg !== null) {
        return $cfg;
    }
    $file = __DIR__ . '/../config/mail.php';
    $raw = is_file($file) ? require $file : [];
    $raw = is_array($raw) ? $raw : [];
    $cfg = [
        'transport' => (string) ($raw['transport'] ?? 'mail'),
        'host' => (string) ($raw['host'] ?? ''),
        'port' => (int) ($raw['port'] ?? 465),
        'encryption' => (string) ($raw['encryption'] ?? 'ssl'),
        'username' => (string) ($raw['username'] ?? ''),
        'password' => (string) ($raw['password'] ?? ''),
        'from_email' => (string) ($raw['from_email'] ?? 'hello@ailabhub-directory.com'),
        'from_name' => (string) ($raw['from_name'] ?? 'AI LAB HUB'),
        'reply_to' => (string) ($raw['reply_to'] ?? PROMO_MAIL_CONTACT),
        'admin_emails' => array_values(array_filter(array_map('strval', (array) ($raw['admin_emails'] ?? [])))),
    ];
    if ($cfg['transport'] === 'smtp' && $cfg['host'] === '') {
        $cfg['transport'] = 'mail'; // SMTP не налаштовано — запасний mail()
    }

    return $cfg;
}

// --- Черга --------------------------------------------------------------------

function promo_mail_enqueue(PDO $pdo, string $toEmail, string $toName, string $subject, string $text, string $html, string $lang = 'uk', ?string $sendAfterUtc = null): bool
{
    if (filter_var($toEmail, FILTER_VALIDATE_EMAIL) === false) {
        return false;
    }
    try {
        $pdo->prepare(
            "INSERT INTO mail_queue (to_email, to_name, subject, body_text, body_html, lang, status, attempts, send_after, created_at)
             VALUES (:e, :n, :s, :t, :h, :l, 'pending', 0, :a, :c)"
        )->execute([
            ':e' => $toEmail, ':n' => mb_substr($toName, 0, 190), ':s' => mb_substr($subject, 0, 255), ':t' => $text, ':h' => $html,
            ':l' => $lang === 'en' ? 'en' : 'uk', ':a' => $sendAfterUtc ?? promo_utc_now(), ':c' => promo_utc_now(),
        ]);

        return true;
    } catch (Throwable $e) {
        error_log('[promo] mail enqueue: ' . $e->getMessage());

        return false;
    }
}

/**
 * Відправити один лист. Повертає null при успіху або текст помилки.
 */
function promo_mail_transport_send(array $m): ?string
{
    $cfg = promo_mail_config();
    $clean = static fn(string $v): string => str_replace(["\r", "\n", "\0"], '', $v);

    if ($cfg['transport'] === 'log') {
        $dir = __DIR__ . '/../storage/logs';
        if (!is_dir($dir)) {
            @mkdir($dir, 0775, true);
        }
        $ok = @file_put_contents(
            $dir . '/mail-dryrun.log',
            sprintf("[%s UTC] To: %s <%s> | %s\n%s\n%s\n\n", gmdate('Y-m-d H:i:s'), $m['to_name'], $m['to_email'], $m['subject'], str_repeat('-', 60), $m['body_text']),
            FILE_APPEND | LOCK_EX
        );

        return $ok === false ? 'не вдалося записати mail-dryrun.log' : null;
    }

    if ($cfg['transport'] === 'smtp') {
        require_once __DIR__ . '/lib/phpmailer/Exception.php';
        require_once __DIR__ . '/lib/phpmailer/PHPMailer.php';
        require_once __DIR__ . '/lib/phpmailer/SMTP.php';
        $mail = new PHPMailer\PHPMailer\PHPMailer(true);
        try {
            $mail->isSMTP();
            $mail->Host = $cfg['host'];
            $mail->Port = $cfg['port'];
            $mail->SMTPAuth = $cfg['username'] !== '';
            $mail->Username = $cfg['username'];
            $mail->Password = $cfg['password'];
            $mail->SMTPSecure = in_array($cfg['encryption'], ['ssl', 'tls'], true)
                ? ($cfg['encryption'] === 'ssl' ? PHPMailer\PHPMailer\PHPMailer::ENCRYPTION_SMTPS : PHPMailer\PHPMailer\PHPMailer::ENCRYPTION_STARTTLS)
                : '';
            $mail->SMTPAutoTLS = $cfg['encryption'] !== '';
            $mail->Timeout = 20;
            $mail->CharSet = 'UTF-8';
            $mail->setFrom($cfg['from_email'], $cfg['from_name']);
            $mail->addReplyTo($cfg['reply_to']);
            $mail->addAddress($m['to_email'], $m['to_name']);
            $mail->Subject = $m['subject'];
            $mail->isHTML(true);
            $mail->Body = $m['body_html'];
            $mail->AltBody = $m['body_text'];
            $mail->send();

            return null;
        } catch (Throwable $e) {
            return 'SMTP: ' . mb_substr($mail->ErrorInfo ?: $e->getMessage(), 0, 400);
        }
    }

    // Запасний варіант — PHP mail().
    $to = $clean($m['to_email']);
    $boundary = bin2hex(random_bytes(16));
    $headers = implode("\r\n", [
        'MIME-Version: 1.0',
        'Content-Type: multipart/alternative; boundary="' . $boundary . '"',
        'From: ' . $clean($cfg['from_name']) . ' <' . $clean($cfg['from_email']) . '>',
        'Reply-To: ' . $clean($cfg['reply_to']),
    ]);
    $body = "--{$boundary}\r\nContent-Type: text/plain; charset=UTF-8\r\n\r\n" . $m['body_text'] . "\r\n\r\n"
        . "--{$boundary}\r\nContent-Type: text/html; charset=UTF-8\r\n\r\n" . $m['body_html'] . "\r\n\r\n--{$boundary}--";
    $ok = @mail($to, '=?UTF-8?B?' . base64_encode($clean($m['subject'])) . '?=', $body, $headers);

    return $ok ? null : 'mail() повернув false';
}

/**
 * Відправити листи з черги, час яких настав (cron/promo-mail.php).
 *
 * @return array{sent:int,failed:int,retry:int}
 */
function promo_mail_send_pending(PDO $pdo, int $limit = 50): array
{
    $out = ['sent' => 0, 'failed' => 0, 'retry' => 0];
    $st = $pdo->prepare("SELECT * FROM mail_queue WHERE status = 'pending' AND send_after <= :now ORDER BY id LIMIT " . max(1, $limit));
    $st->execute([':now' => promo_utc_now()]);
    foreach ($st->fetchAll() as $m) {
        $error = promo_mail_transport_send($m);
        $attempts = (int) $m['attempts'] + 1;
        if ($error === null) {
            $pdo->prepare("UPDATE mail_queue SET status = 'sent', attempts = :a, sent_at = :t, last_error = NULL WHERE id = :id")
                ->execute([':a' => $attempts, ':t' => promo_utc_now(), ':id' => $m['id']]);
            $out['sent']++;
        } elseif ($attempts >= PROMO_MAIL_MAX_ATTEMPTS) {
            $pdo->prepare("UPDATE mail_queue SET status = 'failed', attempts = :a, last_error = :e WHERE id = :id")
                ->execute([':a' => $attempts, ':e' => $error, ':id' => $m['id']]);
            $out['failed']++;
        } else {
            $delay = PROMO_MAIL_BACKOFF_MIN[$attempts] ?? 240;
            $pdo->prepare('UPDATE mail_queue SET attempts = :a, last_error = :e, send_after = :s WHERE id = :id')
                ->execute([':a' => $attempts, ':e' => $error, ':s' => gmdate('Y-m-d H:i:s', time() + $delay * 60), ':id' => $m['id']]);
            $out['retry']++;
        }
    }

    return $out;
}

// --- Налаштування сповіщень користувача ---------------------------------------

/** Запам'ятати мову інтерфейсу користувача для листів (викликає кабінет реклами). */
function promo_notify_remember_lang(PDO $pdo, int $userId, string $lang): void
{
    try {
        $pdo->prepare(
            'INSERT INTO promo_notify_prefs (user_id, lang, low_balance) VALUES (:u, :l, 1)
             ON DUPLICATE KEY UPDATE lang = VALUES(lang)'
        )->execute([':u' => $userId, ':l' => $lang === 'en' ? 'en' : 'uk']);
    } catch (Throwable $e) {
        error_log('[promo] notify lang: ' . $e->getMessage());
    }
}

/** @return array{lang:string,low_balance:bool} */
function promo_notify_prefs(PDO $pdo, int $userId): array
{
    try {
        $st = $pdo->prepare('SELECT lang, low_balance FROM promo_notify_prefs WHERE user_id = :u');
        $st->execute([':u' => $userId]);
        $r = $st->fetch();
    } catch (Throwable $e) {
        $r = false;
    }

    return ['lang' => $r !== false && $r['lang'] === 'en' ? 'en' : 'uk', 'low_balance' => $r === false || (int) $r['low_balance'] === 1];
}

function promo_notify_set_low_balance(PDO $pdo, int $userId, bool $on): void
{
    $pdo->prepare(
        'INSERT INTO promo_notify_prefs (user_id, lang, low_balance) VALUES (:u, :l, :o)
         ON DUPLICATE KEY UPDATE low_balance = VALUES(low_balance)'
    )->execute([':u' => $userId, ':l' => promo_lang(), ':o' => $on ? 1 : 0]);
}

// --- Шаблони ------------------------------------------------------------------

/**
 * Тексти листів: ключ → [UA, EN], кожен — [тема, абзаци...]. Плейсхолдери %s
 * заповнюються в promo_notify (назва кампанії, причина, сума тощо).
 */
const PROMO_MAIL_TEMPLATES = [
    'creative_approved' => [
        ['Кампанію «%s» схвалено', 'Модератор схвалив креатив вашої кампанії «%s».', 'Показ почнеться з дати старту, якщо на балансі є кошти.'],
        ['Campaign “%s” approved', 'A moderator approved the creative of your campaign “%s”.', 'Delivery starts on the start date if your balance has funds.'],
    ],
    'creative_rejected' => [
        ['Кампанію «%s» відхилено', 'Модератор відхилив креатив вашої кампанії «%s».', 'Причина: %s', 'Ви можете відредагувати кампанію в кабінеті й надіслати її повторно.'],
        ['Campaign “%s” rejected', 'A moderator rejected the creative of your campaign “%s”.', 'Reason: %s', 'You can edit the campaign in your account and submit it again.'],
    ],
    'campaign_started' => [
        ['Кампанія «%s» стартувала', 'Ваша кампанія «%s» почала показуватися на сайті.', 'Статистика — у кабінеті, розділ «Реклама» → «Статистика».'],
        ['Campaign “%s” has started', 'Your campaign “%s” is now being shown on the site.', 'Statistics are in your account: “Advertising” → “Statistics”.'],
    ],
    'campaign_paused_system' => [
        ['Кампанію «%s» призупинено', 'Кампанію «%s» автоматично призупинено.', 'Причина: %s', 'Подробиці — у кабінеті, розділ «Реклама».'],
        ['Campaign “%s” paused', 'Campaign “%s” was paused automatically.', 'Reason: %s', 'Details are in your account, “Advertising” section.'],
    ],
    'low_balance' => [
        ['Низький баланс реклами', 'На вашому рекламному балансі лишилося %s.', 'Кампанії можуть зупинитися, коли кошти закінчаться. Поповнити баланс можна в кабінеті: «Реклама» → «Баланс і оплата».', 'Ці сповіщення можна вимкнути в тому ж розділі.'],
        ['Low advertising balance', 'Your advertising balance is down to %s.', 'Campaigns may stop when funds run out. You can top up in your account: “Advertising” → “Balance & payment”.', 'You can turn these notifications off in the same section.'],
    ],
    'campaign_completed' => [
        ['Кампанію «%s» завершено', 'Кампанію «%s» завершено.', 'Причина: %s', 'Підсумкову статистику можна переглянути й вивантажити в кабінеті.'],
        ['Campaign “%s” completed', 'Campaign “%s” has completed.', 'Reason: %s', 'You can view and export the final statistics in your account.'],
    ],
    'topup_confirmed' => [
        ['Поповнення зараховано', 'Поповнення №%s на суму %s зараховано на ваш рекламний баланс.'],
        ['Top-up credited', 'Top-up #%s for %s has been credited to your advertising balance.'],
    ],
    'topup_rejected' => [
        ['Заявку на поповнення відхилено', 'Заявку на поповнення №%s на суму %s відхилено.', 'Причина: %s'],
        ['Top-up request rejected', 'Top-up request #%s for %s was rejected.', 'Reason: %s'],
    ],
];

/** Причини зупинки людською мовою. */
const PROMO_MAIL_REASONS = [
    'balance' => ['на балансі закінчилися кошти', 'your balance ran out'],
    'budget' => ['загальний бюджет вичерпано', 'the total budget has been spent'],
    'end_date' => ['настала дата завершення', 'the end date has passed'],
    'link_check' => ['автоматична перевірка посилання — кампанія повернулась на модерацію', 'an automatic link check sent the campaign back to review'],
];

/**
 * Лист рекламодавцю: HTML + текст. $subjectArgs — для теми, $bodyArgs — по черзі
 * для плейсхолдерів абзаців.
 *
 * @return array{0:string,1:string,2:string} тема, текст, HTML
 */
function promo_mail_render(string $template, string $lang, array $subjectArgs, array $bodyArgs): array
{
    $parts = PROMO_MAIL_TEMPLATES[$template][$lang === 'en' ? 1 : 0];
    $subject = vsprintf(array_shift($parts), $subjectArgs);
    $paragraphs = [];
    $i = 0;
    foreach ($parts as $p) {
        $n = substr_count($p, '%s');
        $paragraphs[] = $n > 0 ? vsprintf($p, array_slice($bodyArgs, $i, $n)) : $p;
        $i += $n;
    }
    $site = mail_site_url();
    $cabinet = $site . '/account.php?promo_tab=campaigns#acc-promo';
    $footer = $lang === 'en'
        ? ['Open your account: ' . $cabinet, 'Questions? Reply to ' . PROMO_MAIL_CONTACT . '.', 'This is a service message about your advertising on AI LAB HUB.']
        : ['Кабінет: ' . $cabinet, 'Питання? Напишіть на ' . PROMO_MAIL_CONTACT . '.', 'Це службовий лист про вашу рекламу на AI LAB HUB.'];
    $text = implode("\n\n", array_merge($paragraphs, ['—'], $footer));

    $e = static fn(string $v): string => htmlspecialchars($v, ENT_QUOTES);
    $body = '';
    foreach ($paragraphs as $p) {
        $body .= '<p style="margin:0 0 14px;font-size:15px;line-height:1.6;color:#1d2340;">' . $e($p) . '</p>';
    }
    $btn = $lang === 'en' ? 'Open account' : 'Відкрити кабінет';
    $html = '<!doctype html><html lang="' . ($lang === 'en' ? 'en' : 'uk') . '"><body style="margin:0;padding:0;background:#f2f4fb;font-family:Segoe UI,Roboto,Arial,sans-serif;">'
        . '<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background:#f2f4fb;padding:24px 12px;"><tr><td align="center">'
        . '<table role="presentation" width="560" cellpadding="0" cellspacing="0" style="max-width:560px;background:#ffffff;border-radius:14px;padding:28px;">'
        . '<tr><td><p style="margin:0 0 18px;font-size:18px;font-weight:700;color:#2116ad;">AI LAB HUB</p>'
        . '<h1 style="margin:0 0 16px;font-size:20px;color:#00032c;">' . $e($subject) . '</h1>' . $body
        . '<p style="margin:20px 0;"><a href="' . $e($cabinet) . '" style="display:inline-block;padding:11px 22px;border-radius:999px;background:#2116ad;color:#ffffff;text-decoration:none;font-weight:600;">' . $e($btn) . '</a></p>'
        . '<p style="margin:0 0 6px;font-size:13px;color:#5a6185;">' . $e($footer[1]) . '</p>'
        . '<p style="margin:0;font-size:12px;color:#8a90ad;">' . $e($footer[2]) . '</p>'
        . '</td></tr></table></td></tr></table></body></html>';

    return [$subject, $text, $html];
}

/** Адреси адміністраторів для службових сповіщень. @return list<string> */
function promo_admin_emails(PDO $pdo): array
{
    $cfg = promo_mail_config()['admin_emails'];
    if ($cfg !== []) {
        return $cfg;
    }

    return array_map('strval', $pdo->query("SELECT email FROM users WHERE role = 'admin' AND email <> ''")->fetchAll(PDO::FETCH_COLUMN));
}

/** Службовий лист адміну (лише українською, як адмінка). */
function promo_mail_admin(PDO $pdo, string $subject, array $lines, string $tab): void
{
    $site = mail_site_url();
    $link = $site . '/account.php?padm_tab=' . rawurlencode($tab) . '#acc-promo-admin';
    $text = implode("\n", $lines) . "\n\n" . $link;
    $html = '<!doctype html><html lang="uk"><body style="font-family:Segoe UI,Roboto,Arial,sans-serif;color:#1d2340;">'
        . '<p><strong>AI LAB HUB · реклама</strong></p>';
    foreach ($lines as $l) {
        $html .= '<p>' . htmlspecialchars($l, ENT_QUOTES) . '</p>';
    }
    $html .= '<p><a href="' . htmlspecialchars($link, ENT_QUOTES) . '">Відкрити адмінку реклами</a></p></body></html>';
    foreach (promo_admin_emails($pdo) as $email) {
        promo_mail_enqueue($pdo, $email, 'AI LAB HUB admin', '[AI LAB HUB] ' . $subject, $text, $html, 'uk');
    }
}

// --- Події --------------------------------------------------------------------

/**
 * Подія реклами → листи в чергу. Помилки не ламають основну дію (лише лог).
 *
 * Рекламодавцю: creative_approved, creative_rejected (reason), campaign_started,
 * campaign_paused_system (reason_key), low_balance (balance), campaign_completed
 * (reason_key), topup_confirmed / topup_rejected (tx_id, amount, reason).
 * Адміну: creative_pending, topup_requested, report_new, link_autopause.
 * Сповіщення про низький баланс рекламодавець може вимкнути; решта обов'язкові.
 */
function promo_notify(PDO $pdo, string $event, array $d): void
{
    try {
        $campaign = null;
        if (!empty($d['campaign_id'])) {
            $st = $pdo->prepare('SELECT c.id, c.name, c.user_id, c.campaign_type, u.email, u.name AS user_name
                                 FROM ad_campaigns c LEFT JOIN users u ON u.id = c.user_id WHERE c.id = :id');
            $st->execute([':id' => (int) $d['campaign_id']]);
            $campaign = $st->fetch() ?: null;
        }
        $user = null;
        if (!empty($d['user_id'])) {
            $st = $pdo->prepare('SELECT id, email, name FROM users WHERE id = :id');
            $st->execute([':id' => (int) $d['user_id']]);
            $user = $st->fetch() ?: null;
        } elseif ($campaign !== null && $campaign['user_id'] !== null) {
            $user = ['id' => $campaign['user_id'], 'email' => $campaign['email'], 'name' => $campaign['user_name']];
        }
        $isHouse = $campaign !== null && $campaign['campaign_type'] === 'internal';
        $name = $campaign !== null ? ((string) $campaign['name'] ?: '#' . $campaign['id']) : '';

        $toAdvertiser = function (string $template, array $subjectArgs, array $args) use ($pdo, $user, $isHouse, $event, $campaign): void {
            if ($user === null || $isHouse || (string) $user['email'] === '') {
                return;
            }
            $prefs = promo_notify_prefs($pdo, (int) $user['id']);
            [$subject, $text, $html] = promo_mail_render($template, $prefs['lang'], $subjectArgs, $args);
            promo_mail_enqueue($pdo, (string) $user['email'], (string) $user['name'], $subject, $text, $html, $prefs['lang']);
            promo_log_event_safe($pdo, 'mail_' . $event, null, $campaign !== null ? (int) $campaign['id'] : null, $subject, (int) $user['id']);
        };
        $reason = static function (string $key, string $lang) : string {
            return PROMO_MAIL_REASONS[$key][$lang === 'en' ? 1 : 0] ?? $key;
        };
        $lang = $user !== null ? promo_notify_prefs($pdo, (int) $user['id'])['lang'] : 'uk';

        switch ($event) {
            case 'creative_approved':
                $toAdvertiser('creative_approved', [$name], [$name]);
                break;
            case 'creative_rejected':
                $toAdvertiser('creative_rejected', [$name], [$name, (string) ($d['reason'] ?? '')]);
                break;
            case 'campaign_started':
                $toAdvertiser('campaign_started', [$name], [$name]);
                break;
            case 'campaign_paused_system':
                $toAdvertiser('campaign_paused_system', [$name], [$name, $reason((string) ($d['reason_key'] ?? ''), $lang)]);
                break;
            case 'campaign_completed':
                $toAdvertiser('campaign_completed', [$name], [$name, $reason((string) ($d['reason_key'] ?? ''), $lang)]);
                break;
            case 'low_balance':
                if ($user !== null && promo_notify_prefs($pdo, (int) $user['id'])['low_balance']) {
                    $toAdvertiser('low_balance', [], [promo_mail_money((int) ($d['balance'] ?? 0))]);
                }
                break;
            case 'topup_confirmed':
                $toAdvertiser('topup_confirmed', [], [(string) $d['tx_id'], promo_mail_money((int) $d['amount'])]);
                break;
            case 'topup_rejected':
                $toAdvertiser('topup_rejected', [], [(string) $d['tx_id'], promo_mail_money((int) $d['amount']), (string) ($d['reason'] ?? '')]);
                break;

            case 'creative_pending':
                promo_mail_admin($pdo, 'Новий креатив на модерації', ['Кампанія #' . (int) $d['campaign_id'] . ' «' . $name . '» чекає модерації.',
                    'Рекламодавець: ' . ($user['email'] ?? '—')], 'moderation');
                break;
            case 'topup_requested':
                promo_mail_admin($pdo, 'Нова заявка на поповнення', ['Заявка №' . (int) $d['tx_id'] . ' на ' . promo_mail_money((int) $d['amount']) . '.',
                    'Рекламодавець: ' . ($user['email'] ?? '—'), 'Підтвердьте після надходження коштів.'], 'payments');
                break;
            case 'report_new':
                promo_mail_admin($pdo, 'Нова скарга на рекламу', ['Скарга на креатив #' . (int) $d['creative_id'] . ', причина: ' . (string) ($d['reason'] ?? '') . '.'], 'reports');
                break;
            case 'link_autopause':
                promo_mail_admin($pdo, 'Автопауза: перевірка посилання', ['Кампанію #' . (int) $d['campaign_id'] . ' «' . $name . '» повернуто на модерацію.',
                    'Причина: ' . (string) ($d['reason'] ?? '')], 'moderation');
                $toAdvertiser('campaign_paused_system', [$name], [$name, $reason('link_check', $lang)]);
                break;
        }
    } catch (Throwable $e) {
        error_log('[promo] notify ' . $event . ': ' . $e->getMessage());
    }
}

function promo_mail_money(int $kop): string
{
    return number_format($kop / 100, 2, ',', ' ') . ' $';
}

/** promo_log_event без залежності від порядку підключення файлів. */
function promo_log_event_safe(PDO $pdo, string $event, ?int $creativeId, ?int $campaignId, string $details, ?int $userId = null): void
{
    if (!function_exists('promo_log_event')) {
        require_once __DIR__ . '/promo-linkcheck.php';
    }
    promo_log_event($pdo, $event, $creativeId, $campaignId, $details, $userId);
}

// --- Періодичні перевірки (cron/promo-hourly.php) -----------------------------

/**
 * Щогодинні дії: старт кампаній (лист «стартувала»), пауза за вичерпанням
 * балансу/бюджету, завершення за датою, низький баланс (не частіше разу на добу).
 *
 * @return array<string,int>
 */
function promo_hourly(PDO $pdo): array
{
    $today = promo_today();
    $out = ['started' => 0, 'paused_balance' => 0, 'completed_budget' => 0, 'completed_end' => 0, 'low_balance' => 0, 'link_checked' => 0];

    // Нові креативи без перевірки посилання (напр. збій під час надсилання).
    foreach ($pdo->query("SELECT cr.id FROM ad_creatives cr JOIN ad_campaigns c ON c.id = cr.campaign_id
                          WHERE c.format = 'video' AND cr.status = 'pending' AND cr.link_checked_at IS NULL AND cr.destination_url <> '' LIMIT 20")
                 ->fetchAll(PDO::FETCH_COLUMN) as $cid) {
        if (!function_exists('promo_linkcheck_creative')) {
            require_once __DIR__ . '/promo-linkcheck.php';
        }
        promo_linkcheck_creative($pdo, (int) $cid, true);
        $out['link_checked']++;
    }

    // Бюджет вичерпано → завершено.
    $st = $pdo->query("SELECT id FROM ad_campaigns WHERE format = 'video' AND campaign_type <> 'internal' AND status = 'active'
                       AND total_budget IS NOT NULL AND spent >= total_budget");
    foreach ($st->fetchAll(PDO::FETCH_COLUMN) as $id) {
        $u = $pdo->prepare("UPDATE ad_campaigns SET status = 'completed', stop_reason = 'budget' WHERE id = :id AND status = 'active'");
        $u->execute([':id' => $id]);
        if ($u->rowCount() > 0) {
            promo_notify($pdo, 'campaign_completed', ['campaign_id' => (int) $id, 'reason_key' => 'budget']);
            $out['completed_budget']++;
        }
    }

    // Баланс вичерпано → пауза (відновиться після поповнення).
    $st = $pdo->query("SELECT c.id FROM ad_campaigns c LEFT JOIN ad_balances b ON b.user_id = c.user_id
                       WHERE c.format = 'video' AND c.campaign_type <> 'internal' AND c.status = 'active' AND COALESCE(b.balance, 0) <= 0");
    foreach ($st->fetchAll(PDO::FETCH_COLUMN) as $id) {
        $u = $pdo->prepare("UPDATE ad_campaigns SET status = 'paused', stop_reason = 'balance' WHERE id = :id AND status = 'active'");
        $u->execute([':id' => $id]);
        if ($u->rowCount() > 0) {
            promo_notify($pdo, 'campaign_paused_system', ['campaign_id' => (int) $id, 'reason_key' => 'balance']);
            $out['paused_balance']++;
        }
    }

    // Дата завершення минула → завершено.
    $st = $pdo->prepare("SELECT id FROM ad_campaigns WHERE format = 'video' AND status IN ('active', 'paused') AND end_date IS NOT NULL AND end_date < :d");
    $st->execute([':d' => $today]);
    foreach ($st->fetchAll(PDO::FETCH_COLUMN) as $id) {
        $u = $pdo->prepare("UPDATE ad_campaigns SET status = 'completed', stop_reason = 'end_date' WHERE id = :id AND status IN ('active', 'paused')");
        $u->execute([':id' => $id]);
        if ($u->rowCount() > 0) {
            promo_notify($pdo, 'campaign_completed', ['campaign_id' => (int) $id, 'reason_key' => 'end_date']);
            $out['completed_end']++;
        }
    }

    // Старт: активна, дата настала, лист ще не надсилали.
    $st = $pdo->prepare("SELECT id FROM ad_campaigns WHERE format = 'video' AND campaign_type <> 'internal' AND status = 'active'
                         AND started_notified_at IS NULL AND (start_date IS NULL OR start_date <= :d)");
    $st->execute([':d' => $today]);
    foreach ($st->fetchAll(PDO::FETCH_COLUMN) as $id) {
        $pdo->prepare('UPDATE ad_campaigns SET started_notified_at = :t WHERE id = :id')->execute([':t' => promo_utc_now(), ':id' => $id]);
        promo_notify($pdo, 'campaign_started', ['campaign_id' => (int) $id]);
        $out['started']++;
    }

    // Низький баланс: менше 20% денного бюджету активних кампаній або нижче min_topup.
    $minTopup = 0;
    $raw = str_replace(',', '.', trim(promo_setting($pdo, 'min_topup', '')));
    if (preg_match('/^\d+(\.\d{1,2})?$/', $raw)) {
        $minTopup = (int) round((float) $raw * 100);
    }
    $rows = $pdo->query("SELECT c.user_id, COALESCE(b.balance, 0) AS balance, SUM(COALESCE(c.daily_budget, 0)) AS daily
                         FROM ad_campaigns c LEFT JOIN ad_balances b ON b.user_id = c.user_id
                         WHERE c.format = 'video' AND c.campaign_type <> 'internal' AND c.status = 'active' AND c.user_id IS NOT NULL
                         GROUP BY c.user_id, b.balance")->fetchAll();
    foreach ($rows as $r) {
        $bal = (int) $r['balance'];
        $low = ($r['daily'] > 0 && $bal < (int) $r['daily'] * 0.2) || ($minTopup > 0 && $bal < $minTopup);
        if (!$low || $bal <= 0) {
            continue;
        }
        $recent = $pdo->prepare("SELECT COUNT(*) FROM promo_event_log WHERE event = 'mail_low_balance' AND user_id = :u AND created_at >= :t");
        $recent->execute([':u' => $r['user_id'], ':t' => gmdate('Y-m-d H:i:s', time() - 86400)]);
        if ((int) $recent->fetchColumn() > 0) {
            continue;
        }
        promo_notify($pdo, 'low_balance', ['user_id' => (int) $r['user_id'], 'balance' => $bal]);
        if (promo_notify_prefs($pdo, (int) $r['user_id'])['low_balance']) {
            $out['low_balance']++;
        }
    }

    return $out;
}

/**
 * Звірити лічильники ad_stats_daily з сирими подіями за київську добу (якщо
 * запис агрегату колись не вдався). Витрати (spend) не змінюються — вони
 * пишуться в транзакції списання.
 */
function promo_reconcile_stats(PDO $pdo, string $kyivDate): int
{
    [$from, $to] = promo_day_bounds_utc($kyivDate);
    $st = $pdo->prepare(
        "SELECT campaign_id, creative_id, placement,
                SUM(type = 'impression') AS i, SUM(type = 'view') AS v, SUM(type = 'click') AS c
         FROM ad_events WHERE created_at >= :f AND created_at < :t
         GROUP BY campaign_id, creative_id, placement"
    );
    $st->execute([':f' => $from, ':t' => $to]);
    $n = 0;
    $up = $pdo->prepare(
        'INSERT INTO ad_stats_daily (stat_date, campaign_id, creative_id, placement, impressions, views, clicks, spend)
         VALUES (:d, :c, :cr, :p, :i, :v, :k, 0)
         ON DUPLICATE KEY UPDATE impressions = GREATEST(impressions, VALUES(impressions)),
             views = GREATEST(views, VALUES(views)), clicks = GREATEST(clicks, VALUES(clicks))'
    );
    foreach ($st->fetchAll() as $r) {
        $up->execute([':d' => $kyivDate, ':c' => $r['campaign_id'], ':cr' => $r['creative_id'], ':p' => $r['placement'],
            ':i' => (int) $r['i'], ':v' => (int) $r['v'], ':k' => (int) $r['c']]);
        $n++;
    }

    return $n;
}
