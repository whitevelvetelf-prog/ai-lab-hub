<?php

declare(strict_types=1);

/**
 * AI LAB HUB — донати: реквізити зберігаються в site_settings (ключі donate_*),
 * їх вводить адмін у кабінеті (розділ «Донати»). Жодних реальних реквізитів у
 * коді, git чи SQL — лише структура.
 *
 * Сторінка — public/donate.php, адмінка — app/donations-admin.php,
 * обробник форми — public/donations-admin-action.php.
 */

require_once __DIR__ . '/site-settings.php';

/** Поля реквізитів (ключ site_settings → правило). Усі необов'язкові. */
const DONATE_FIELDS = [
    'donate_enabled'      => 'flag',
    'donate_jar_url'      => 'url',
    'donate_card_number'  => 'card',
    'donate_card_holder'  => 'text:100',
    'donate_iban_uah'     => 'iban_ua',
    'donate_iban_usd'     => 'iban',
    'donate_iban_eur'     => 'iban',
    'donate_swift'        => 'swift',
    'donate_bank_name'    => 'text:150',
    'donate_purpose'      => 'text:200',
    'donate_text_uk'      => 'longtext:2000',
    'donate_text_en'      => 'longtext:2000',
    'donate_show_qr'      => 'flag',
];

const DONATE_DEFAULT_PURPOSE = 'Добровільний внесок на розвиток AI LAB HUB';

/** Лише цифри. */
function donate_digits(string $s): string
{
    return preg_replace('/\D+/', '', $s) ?? '';
}

/** Перевірка номера картки за алгоритмом Луна. */
function donate_luhn_ok(string $digits): bool
{
    if (!preg_match('/^\d{13,19}$/', $digits)) {
        return false;
    }
    $sum = 0;
    $double = false;
    for ($i = strlen($digits) - 1; $i >= 0; $i--) {
        $d = (int) $digits[$i];
        if ($double) {
            $d *= 2;
            if ($d > 9) {
                $d -= 9;
            }
        }
        $sum += $d;
        $double = !$double;
    }

    return $sum % 10 === 0;
}

/** IBAN без пробілів, великими літерами. */
function donate_iban_normalize(string $s): string
{
    return strtoupper(preg_replace('/[\s-]+/', '', $s) ?? '');
}

/** Контрольна сума IBAN (ISO 13616, mod 97). */
function donate_iban_checksum_ok(string $iban): bool
{
    $moved = substr($iban, 4) . substr($iban, 0, 4);
    $numeric = '';
    foreach (str_split($moved) as $ch) {
        $numeric .= ctype_alpha($ch) ? (string) (ord($ch) - 55) : $ch;
    }
    $rest = 0;
    foreach (str_split($numeric, 7) as $chunk) {
        $rest = (int) ($rest . $chunk) % 97;
    }

    return $rest === 1;
}

/** Групи по 4 символи для показу (довгі IBAN переносяться по пробілах). */
function donate_group4(string $s): string
{
    return trim(chunk_split($s, 4, ' '));
}

/**
 * Перевірити й нормалізувати форму адмінки.
 *
 * @return array{0:array<string,string>,1:list<string>} [значення для збереження, помилки]
 */
function donate_validate(array $in): array
{
    $values = [];
    $errors = [];
    $labels = donate_field_labels();
    foreach (DONATE_FIELDS as $key => $rule) {
        $raw = trim(str_replace("\r\n", "\n", is_string($in[$key] ?? null) ? $in[$key] : ''));
        [$type, $max] = array_pad(explode(':', $rule, 2), 2, null);
        $label = $labels[$key] ?? $key;

        if ($type === 'flag') {
            $values[$key] = !empty($in[$key]) ? '1' : '0';
            continue;
        }
        if ($raw === '') {
            $values[$key] = '';
            continue;
        }
        if (!mb_check_encoding($raw, 'UTF-8')) {
            $errors[] = "{$label}: текст містить некоректні символи (кодування). Введіть його ще раз.";
            continue;
        }
        switch ($type) {
            case 'url':
                $p = parse_url($raw);
                if (mb_strlen($raw) > 500 || !is_array($p) || strtolower((string) ($p['scheme'] ?? '')) !== 'https'
                    || empty($p['host']) || isset($p['user']) || preg_match('/[\s<>"\']/', $raw)) {
                    $errors[] = "{$label}: потрібна повна адреса, що починається з https://";
                    continue 2;
                }
                $values[$key] = $raw;
                break;
            case 'card':
                $digits = donate_digits($raw);
                if (!donate_luhn_ok($digits)) {
                    $errors[] = "{$label}: номер не пройшов перевірку (13–19 цифр, алгоритм Луна). Перевірте, чи немає помилки.";
                    continue 2;
                }
                $values[$key] = donate_group4($digits);
                break;
            case 'iban_ua':
                $iban = donate_iban_normalize($raw);
                if (!preg_match('/^UA\d{27}$/', $iban)) {
                    $errors[] = "{$label}: український IBAN — це UA і ще 27 цифр (29 символів).";
                    continue 2;
                }
                if (!donate_iban_checksum_ok($iban)) {
                    $errors[] = "{$label}: не збігається контрольна сума IBAN — ймовірно, помилка в цифрах.";
                    continue 2;
                }
                $values[$key] = $iban;
                break;
            case 'iban':
                $iban = donate_iban_normalize($raw);
                if (!preg_match('/^[A-Z]{2}\d{2}[A-Z0-9]{11,30}$/', $iban)) {
                    $errors[] = "{$label}: IBAN — 2 літери країни, 2 цифри й до 30 символів рахунку (15–34 символи).";
                    continue 2;
                }
                if (!donate_iban_checksum_ok($iban)) {
                    $errors[] = "{$label}: не збігається контрольна сума IBAN — ймовірно, помилка в символах.";
                    continue 2;
                }
                $values[$key] = $iban;
                break;
            case 'swift':
                $swift = strtoupper(preg_replace('/\s+/', '', $raw) ?? '');
                if (!preg_match('/^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$/', $swift)) {
                    $errors[] = "{$label}: 8 або 11 символів (напр. ABCDUAUKXXX).";
                    continue 2;
                }
                $values[$key] = $swift;
                break;
            case 'text':
            case 'longtext':
                $txt = strip_tags($raw);
                if ($type === 'text') {
                    $txt = trim(preg_replace('/\s+/u', ' ', $txt) ?? '');
                }
                if (mb_strlen($txt) > (int) $max) {
                    $errors[] = "{$label}: не довше {$max} символів.";
                    continue 2;
                }
                $values[$key] = $txt;
                break;
        }
    }

    return [$values, $errors];
}

/** @return array<string,string> */
function donate_field_labels(): array
{
    return [
        'donate_enabled' => 'Увімкнути сторінку донатів',
        'donate_jar_url' => 'Посилання на банку / збір',
        'donate_card_number' => 'Номер картки',
        'donate_card_holder' => 'ПІБ отримувача',
        'donate_iban_uah' => 'IBAN UAH',
        'donate_iban_usd' => 'IBAN USD',
        'donate_iban_eur' => 'IBAN EUR',
        'donate_swift' => 'SWIFT / BIC',
        'donate_bank_name' => 'Назва банку',
        'donate_purpose' => 'Призначення платежу',
        'donate_text_uk' => 'Додатковий текст (UA)',
        'donate_text_en' => 'Додатковий текст (EN)',
        'donate_show_qr' => 'Показувати QR-код для посилання',
    ];
}

/** Поточні значення (з порожніми за замовчуванням). @return array<string,string> */
function donate_config(PDO $pdo): array
{
    $all = site_settings($pdo);
    $out = [];
    foreach (array_keys(DONATE_FIELDS) as $k) {
        $out[$k] = (string) ($all[$k] ?? '');
    }

    return $out;
}

/** Актуальна роль admin за БД. */
function donate_is_admin(PDO $pdo, ?int $userId): bool
{
    if ($userId === null) {
        return false;
    }
    $st = $pdo->prepare('SELECT role FROM users WHERE id = :u');
    $st->execute([':u' => $userId]);

    return $st->fetchColumn() === 'admin';
}

function donate_csrf_token(): string
{
    if (empty($_SESSION['donate_csrf']) || !is_string($_SESSION['donate_csrf'])) {
        $_SESSION['donate_csrf'] = bin2hex(random_bytes(32));
    }

    return $_SESSION['donate_csrf'];
}

function donate_csrf_verify(): bool
{
    $sent = $_POST['csrf'] ?? '';

    return is_string($sent) && $sent !== '' && hash_equals(donate_csrf_token(), $sent);
}
