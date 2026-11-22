<?php

declare(strict_types=1);

/**
 * AI LAB HUB — стан налаштувань сайту БЕЗ значень: лише «налаштовано / не налаштовано / вимкнено».
 * Використовують scripts/config-check.php (CLI) і блок «Стан сайту» в кабінеті адміністратора (public/account.php).
 *
 * Жодне значення (ключ, пароль, токен, посилання на банку) не повертається й не друкується — лише ознака наявності.
 * Файли конфігів лише читаються; релізи (scripts/build-deploy.ps1) їх ніколи не містять, а SQL-пакети не пишуть у
 * site_settings donate_* — тож заливка чи імпорт не перезаписують ці налаштування.
 */

/** Безпечне читання config/*.php: масив або значення, null — файлу немає / помилка. */
function cfgs_load(string $file): mixed
{
    $path = dirname(__DIR__) . '/config/' . $file;
    if (!is_file($path)) {
        return null;
    }
    try {
        return (static function (string $p) {
            return require $p;
        })($path);
    } catch (Throwable $e) {
        return null;
    }
}

/** Значення схоже на справжнє (не порожнє й не заглушка з шаблону). */
function cfgs_filled(mixed $v): bool
{
    if (!is_string($v)) {
        return false;
    }
    $v = trim($v);
    return $v !== '' && preg_match('/^(your|YOUR_|xxx|changeme|example|<|\[)/i', $v) !== 1;
}

/**
 * @return list<array{group:string, name:string, state:string, hint:string}>
 *   state: 'ok' (налаштовано) | 'missing' (не налаштовано) | 'off' (вимкнено — це не помилка)
 */
function config_status(?PDO $pdo): array
{
    $rows = [];
    $add = static function (string $group, string $name, string $state, string $hint = '') use (&$rows): void {
        $rows[] = ['group' => $group, 'name' => $name, 'state' => $state, 'hint' => $hint];
    };

    // База
    $add('База', 'config/database.php — підключення', $pdo instanceof PDO ? 'ok' : 'missing');

    // Переклад
    $tr = cfgs_load('translation.php');
    $add('Переклад', 'ключ API перекладу (config/translation.php)', cfgs_filled(is_string($tr) ? $tr : ($tr['api_key'] ?? null)) ? 'ok' : 'missing');

    // Еля
    $ai = cfgs_load('ai-assistant.php');
    $provider = is_array($ai) ? strtolower((string) ($ai['provider'] ?? 'gemini')) : '';
    $add('Еля', 'провайдер (config/ai-assistant.php)', $provider !== '' ? 'ok' : 'missing', $provider !== '' ? $provider : '');
    $add('Еля', 'ключ Gemini', is_array($ai) && cfgs_filled($ai['gemini_api_key'] ?? null) ? 'ok' : ($provider === 'gemini' ? 'missing' : 'off'));
    $add('Еля', 'ключ Anthropic (Claude)', is_array($ai) && cfgs_filled($ai['api_key'] ?? null) ? 'ok' : ($provider === 'claude' ? 'missing' : 'off'));

    // Пошта
    $mail = cfgs_load('mail.php');
    $transport = is_array($mail) ? strtolower((string) ($mail['transport'] ?? 'mail')) : '';
    $add('Пошта', 'config/mail.php', is_array($mail) ? 'ok' : 'missing', $transport !== '' ? 'transport: ' . $transport : '');
    if ($transport === 'smtp') {
        $add('Пошта', 'SMTP: сервер, користувач, пароль',
            cfgs_filled($mail['host'] ?? null) && cfgs_filled($mail['username'] ?? null) && cfgs_filled($mail['password'] ?? null) ? 'ok' : 'missing');
    } else {
        $add('Пошта', 'SMTP', 'off', 'transport не smtp');
    }

    // OAuth
    $oauth = cfgs_load('oauth.php');
    foreach (['google' => 'Google', 'facebook' => 'Facebook', 'apple' => 'Apple', 'linkedin' => 'LinkedIn', 'x' => 'X', 'discord' => 'Discord'] as $k => $label) {
        $p = is_array($oauth) ? ($oauth[$k] ?? null) : null;
        $both = is_array($p) && cfgs_filled($p['client_id'] ?? null) && cfgs_filled($p['client_secret'] ?? null);
        $add('Вхід через соцмережі', "OAuth {$label} (client id + secret)", $both ? 'ok' : 'off');
    }

    // Реклама, цифрові матеріали
    $promo = cfgs_load('promo.php');
    $add('Реклама', 'config/promo.php: секрет підпису й ключ cron',
        is_array($promo) && cfgs_filled($promo['secret'] ?? null) && cfgs_filled($promo['cron_key'] ?? null) ? 'ok' : 'missing');
    $st = cfgs_load('storage.php');
    $add('Цифрові матеріали', 'config/storage.php: секрет і теки', is_array($st) && cfgs_filled($st['secret'] ?? null) ? 'ok' : 'missing');

    // Marketplace
    if (!function_exists('mp_config')) {
        require_once __DIR__ . '/marketplace.php';
    }
    try {
        $mp = mp_config();
    } catch (Throwable $e) {
        $mp = [];
    }
    $flag = static fn (string $k): string => !empty($mp[$k]) ? 'увімкнено' : 'вимкнено';
    $add('Marketplace', 'site_url', cfgs_filled($mp['site_url'] ?? null) ? 'ok' : 'missing');
    $add('Marketplace', 'cron_token', cfgs_filled($mp['cron_token'] ?? null) ? 'ok' : 'missing');
    $add('Marketplace', 'rate_limit_salt', cfgs_filled($mp['rate_limit_salt'] ?? null) ? 'ok' : 'missing');
    foreach (['file_storage_dir' => 'тека файлів матеріалів', 'photo_dir' => 'тека фото оголошень'] as $k => $label) {
        $dir = (string) ($mp[$k] ?? '');
        $add('Marketplace', "{$k} ({$label})", $dir !== '' && is_dir($dir) && is_writable($dir) ? 'ok' : 'missing',
            $dir === '' ? 'не задано' : (!is_dir($dir) ? 'теки немає' : (!is_writable($dir) ? 'немає запису' : '')));
    }
    $add('Marketplace', 'прапори', 'ok', 'public ' . $flag('public_enabled') . ', posting ' . $flag('posting_enabled')
        . ', messaging ' . $flag('messaging_enabled'));
    $add('Marketplace', 'листи збережених пошуків', empty($mp['saved_search_email_enabled']) ? 'off'
        : (cfgs_filled($mp['saved_search_secret'] ?? null) ? 'ok' : 'missing'), 'потрібен saved_search_secret');
    $add('Marketplace', 'листи про повідомлення', empty($mp['messaging_email_enabled']) ? 'off'
        : (cfgs_filled($mp['messaging_secret'] ?? null) ? 'ok' : 'missing'), 'потрібен messaging_secret');

    // Геолокація
    $geo = cfgs_load('geo.php');
    $add('Геолокація', 'країна за IP (config/geo.php geo_ip_enabled)', is_array($geo) && !empty($geo['geo_ip_enabled']) ? 'ok' : 'off');

    // Донати (site_settings, лише ознаки)
    if ($pdo instanceof PDO) {
        try {
            require_once __DIR__ . '/donations.php';
            $d = donate_status($pdo);
            $add('Донати', 'сторінка донатів (Кабінет → Донати)', !empty($d['configured']) ? 'ok' : 'missing');
        } catch (Throwable $e) {
            $add('Донати', 'сторінка донатів', 'missing', 'не вдалося перевірити');
        }
    }

    // Соцмережі в підвалі (config/social.php)
    $soc = cfgs_load('social.php');
    $links = is_array($soc) ? array_filter((array) ($soc['social_links'] ?? []), 'cfgs_filled') : [];
    $add('Соцмережі', 'посилання в підвалі (config/social.php)', $links !== [] ? 'ok' : 'off', $links !== [] ? implode(', ', array_keys($links)) : 'жодного');

    return $rows;
}

function config_status_label(string $state): string
{
    return ['ok' => 'налаштовано', 'missing' => 'не налаштовано', 'off' => 'вимкнено'][$state] ?? $state;
}
