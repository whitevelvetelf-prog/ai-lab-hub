<?php

declare(strict_types=1);

/**
 * AI LAB HUB — вхід/реєстрація через соцмережі (OAuth 2.0).
 *
 * Розраховано на кілька провайдерів (OAUTH_PROVIDERS), повністю реалізовано
 * лише Google (public/auth-google.php → public/auth-google-callback.php).
 * Щоб додати провайдера: заповнити його ключі в config/oauth.php, написати
 * пару auth-<provider>.php / auth-<provider>-callback.php за зразком Google
 * і поставити 'implemented' => true — кнопки й кабінет підхоплять його самі.
 *
 * Прив'язки зберігаються в social_accounts (database/migration-2026-10-02-social-accounts.sql).
 * Користувачі, створені через соцмережу, мають users.password_hash = '' —
 * password_verify() для нього завжди false (входу паролем немає, доки його не задано).
 *
 * Потребує app/auth.php (сесія) і app/translations.php (t()) підключеними раніше.
 */

/**
 * Реєстр провайдерів: назва, колір плашки-іконки, символ на ній,
 * чи реалізовано потік у коді. Порядок = порядок кнопок.
 */
const OAUTH_PROVIDERS = [
    'google'   => ['label' => 'Google',    'color' => '#ffffff', 'ink' => '#4285f4', 'glyph' => 'G',  'implemented' => true],
    'facebook' => ['label' => 'Facebook',  'color' => '#1877f2', 'ink' => '#ffffff', 'glyph' => 'f',  'implemented' => false],
    'apple'    => ['label' => 'Apple',     'color' => '#000000', 'ink' => '#ffffff', 'glyph' => 'A',  'implemented' => false],
    'linkedin' => ['label' => 'LinkedIn',  'color' => '#0a66c2', 'ink' => '#ffffff', 'glyph' => 'in', 'implemented' => false],
    'x'        => ['label' => 'X',         'color' => '#000000', 'ink' => '#ffffff', 'glyph' => 'X',  'implemented' => false],
    'discord'  => ['label' => 'Discord',   'color' => '#5865f2', 'ink' => '#ffffff', 'glyph' => 'D',  'implemented' => false],
];

/** Скільки секунд чекаємо повернення від провайдера (state у сесії). */
const OAUTH_STATE_TTL = 600;

/** Налаштування провайдера з config/oauth.php (порожній масив, якщо файлу чи провайдера немає). */
function oauth_config(string $provider): array
{
    static $config = null;
    if ($config === null) {
        $file = __DIR__ . '/../config/oauth.php';
        $config = is_file($file) ? (array) require $file : [];
    }

    return (array) ($config[$provider] ?? []);
}

/** Провайдер готовий до використання: є реалізація й заповнені ключі. */
function oauth_provider_enabled(string $provider): bool
{
    if (!(OAUTH_PROVIDERS[$provider]['implemented'] ?? false)) {
        return false;
    }
    $cfg = oauth_config($provider);

    return trim((string) ($cfg['client_id'] ?? '')) !== ''
        && trim((string) ($cfg['client_secret'] ?? '')) !== ''
        && trim((string) ($cfg['redirect_uri'] ?? '')) !== '';
}

/** Людська назва провайдера. */
function oauth_provider_label(string $provider): string
{
    return OAUTH_PROVIDERS[$provider]['label'] ?? $provider;
}

/** base64url без «=». */
function oauth_b64url(string $bytes): string
{
    return rtrim(strtr(base64_encode($bytes), '+/', '-_'), '=');
}

/**
 * Починає OAuth-потік: запам'ятовує в сесії state, PKCE-verifier і режим
 * ('login' — вхід/реєстрація, 'link' — прив'язка до вже відкритої сесії).
 *
 * @return array{state: string, code_challenge: string}
 */
function oauth_begin(string $provider, string $mode): array
{
    $state = bin2hex(random_bytes(16));
    $verifier = oauth_b64url(random_bytes(48));

    $_SESSION['oauth'][$provider] = [
        'state'    => $state,
        'verifier' => $verifier,
        'mode'     => $mode === 'link' ? 'link' : 'login',
        'started'  => time(),
    ];

    return [
        'state'          => $state,
        'code_challenge' => oauth_b64url(hash('sha256', $verifier, true)),
    ];
}

/**
 * Перевіряє state з повернення провайдера й одноразово «забирає» збережений
 * у сесії контекст потоку. null — state не збігся, прострочений або відсутній.
 *
 * @return array{verifier: string, mode: string}|null
 */
function oauth_finish(string $provider, string $state): ?array
{
    $saved = $_SESSION['oauth'][$provider] ?? null;
    unset($_SESSION['oauth'][$provider]);

    if (!is_array($saved) || $state === '' || !hash_equals((string) $saved['state'], $state)) {
        return null;
    }
    if (time() - (int) $saved['started'] > OAUTH_STATE_TTL) {
        return null;
    }

    return ['verifier' => (string) $saved['verifier'], 'mode' => (string) $saved['mode']];
}

/**
 * HTTP-запит до провайдера (POST форми або GET з Bearer-токеном).
 * Повертає розібраний JSON або null при мережевій помилці / не-2xx / не-JSON.
 */
function oauth_http_json(string $url, ?array $postFields = null, ?string $bearer = null): ?array
{
    $ch = curl_init($url);
    $headers = ['Accept: application/json'];
    if ($bearer !== null) {
        $headers[] = 'Authorization: Bearer ' . $bearer;
    }
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT        => 15,
        CURLOPT_HTTPHEADER     => $headers,
    ]);
    if ($postFields !== null) {
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($postFields));
    }

    $body = curl_exec($ch);
    $status = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    curl_close($ch);

    if (!is_string($body) || $status < 200 || $status >= 300) {
        return null;
    }
    $data = json_decode($body, true);

    return is_array($data) ? $data : null;
}

// ---------------------------------------------------------------------
// Google
// ---------------------------------------------------------------------

/** URL сторінки згоди Google (scope: openid email profile; PKCE S256). */
function oauth_google_auth_url(string $state, string $codeChallenge): string
{
    $cfg = oauth_config('google');

    return 'https://accounts.google.com/o/oauth2/v2/auth?' . http_build_query([
        'client_id'             => (string) $cfg['client_id'],
        'redirect_uri'          => (string) $cfg['redirect_uri'],
        'response_type'         => 'code',
        'scope'                 => 'openid email profile',
        'state'                 => $state,
        'code_challenge'        => $codeChallenge,
        'code_challenge_method' => 'S256',
        'prompt'                => 'select_account',
    ]);
}

/**
 * Обмінює код авторизації на access token і повертає профіль користувача Google.
 *
 * @return array{id: string, email: string, email_verified: bool, name: string}|null
 */
function oauth_google_fetch_profile(string $code, string $verifier): ?array
{
    $cfg = oauth_config('google');

    $token = oauth_http_json('https://oauth2.googleapis.com/token', [
        'code'          => $code,
        'client_id'     => (string) $cfg['client_id'],
        'client_secret' => (string) $cfg['client_secret'],
        'redirect_uri'  => (string) $cfg['redirect_uri'],
        'grant_type'    => 'authorization_code',
        'code_verifier' => $verifier,
    ]);
    $accessToken = (string) ($token['access_token'] ?? '');
    if ($accessToken === '') {
        return null;
    }

    $info = oauth_http_json('https://openidconnect.googleapis.com/v1/userinfo', null, $accessToken);
    $sub = (string) ($info['sub'] ?? '');
    $email = strtolower(trim((string) ($info['email'] ?? '')));
    if ($sub === '' || $email === '' || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
        return null;
    }

    return [
        'id'             => $sub,
        'email'          => $email,
        // Google віддає true/false; деякі відповіді — рядок "true".
        'email_verified' => ($info['email_verified'] ?? false) === true || ($info['email_verified'] ?? '') === 'true',
        'name'           => trim((string) ($info['name'] ?? '')),
    ];
}

// ---------------------------------------------------------------------
// social_accounts
// ---------------------------------------------------------------------

/** user_id, до якого вже прив'язано цей акаунт провайдера, або null. */
function social_find_user_id(PDO $pdo, string $provider, string $providerUserId): ?int
{
    $stmt = $pdo->prepare(
        'SELECT user_id FROM social_accounts WHERE provider = :p AND provider_user_id = :pid'
    );
    $stmt->execute([':p' => $provider, ':pid' => $providerUserId]);
    $id = $stmt->fetchColumn();

    return $id === false ? null : (int) $id;
}

/** Прив'язує акаунт провайдера до користувача (повторна прив'язка того самого — без помилки). */
function social_link(PDO $pdo, int $userId, string $provider, string $providerUserId, ?string $email): void
{
    $stmt = $pdo->prepare(
        'INSERT INTO social_accounts (user_id, provider, provider_user_id, email)
         VALUES (:uid, :p, :pid, :email)
         ON DUPLICATE KEY UPDATE email = VALUES(email)'
    );
    $stmt->execute([':uid' => $userId, ':p' => $provider, ':pid' => $providerUserId, ':email' => $email]);
}

/**
 * Прив'язані до користувача провайдери.
 *
 * @return list<array{provider: string, email: ?string, connected_at: string}>
 */
function social_accounts_for_user(PDO $pdo, int $userId): array
{
    $stmt = $pdo->prepare(
        'SELECT provider, email, connected_at FROM social_accounts WHERE user_id = :uid ORDER BY connected_at'
    );
    $stmt->execute([':uid' => $userId]);

    return $stmt->fetchAll();
}

/** Чи має користувач пароль (users.password_hash не порожній). */
function social_user_has_password(PDO $pdo, int $userId): bool
{
    $stmt = $pdo->prepare('SELECT password_hash FROM users WHERE id = :id');
    $stmt->execute([':id' => $userId]);

    return (string) $stmt->fetchColumn() !== '';
}

/**
 * Скільки способів входу має користувач: пароль (якщо заданий) + прив'язані соцмережі.
 * Вхід посиланням на email («Забули пароль?») доступний усім і тут не рахується —
 * правило «не відв'язати останній спосіб» стосується саме пароля й соцмереж.
 */
function social_login_methods_count(PDO $pdo, int $userId): int
{
    return (social_user_has_password($pdo, $userId) ? 1 : 0) + count(social_accounts_for_user($pdo, $userId));
}

/**
 * Відв'язує провайдера, якщо це не останній спосіб входу.
 * true — відв'язано; false — заборонено (останній спосіб) або прив'язки немає.
 */
function social_unlink(PDO $pdo, int $userId, string $provider): bool
{
    $pdo->beginTransaction();
    try {
        // Блокуємо рядки користувача, щоб два паралельні «Відв'язати» не зняли обидва способи.
        $lock = $pdo->prepare('SELECT id FROM social_accounts WHERE user_id = :uid FOR UPDATE');
        $lock->execute([':uid' => $userId]);

        if (social_login_methods_count($pdo, $userId) <= 1) {
            $pdo->rollBack();

            return false;
        }

        $del = $pdo->prepare('DELETE FROM social_accounts WHERE user_id = :uid AND provider = :p');
        $del->execute([':uid' => $userId, ':p' => $provider]);
        $pdo->commit();

        return $del->rowCount() === 1;
    } catch (Throwable $ex) {
        $pdo->rollBack();
        throw $ex;
    }
}

/**
 * Знаходить або створює користувача для профілю провайдера й повертає
 * ['id' => …, 'role' => …] для auth_login(). Порядок:
 *   1) акаунт провайдера вже прив'язаний → його користувач;
 *   2) email уже є в users → прив'язка до нього (лише якщо провайдер підтвердив email!);
 *   3) інакше — новий users (роль user, password_hash = '') + прив'язка.
 * Помилка — рядок-ключ перекладу ('social_error_unverified' тощо).
 *
 * @param array{id: string, email: string, email_verified: bool, name: string} $profile
 * @return array{id: int, role: string}|string
 */
function social_resolve_login(PDO $pdo, string $provider, array $profile): array|string
{
    $existingId = social_find_user_id($pdo, $provider, $profile['id']);
    if ($existingId !== null) {
        $stmt = $pdo->prepare('SELECT id, role FROM users WHERE id = :id');
        $stmt->execute([':id' => $existingId]);
        $user = $stmt->fetch();

        return $user === false ? 'social_error_generic' : ['id' => (int) $user['id'], 'role' => (string) $user['role']];
    }

    // Без підтвердженого email не прив'язуємо й не створюємо: інакше чужий
    // акаунт провайдера з неперевіреною адресою міг би «увійти» в наш акаунт.
    if (!$profile['email_verified']) {
        return 'social_error_unverified';
    }

    $stmt = $pdo->prepare('SELECT id, role FROM users WHERE email = :email');
    $stmt->execute([':email' => $profile['email']]);
    $user = $stmt->fetch();

    if ($user !== false) {
        social_link($pdo, (int) $user['id'], $provider, $profile['id'], $profile['email']);

        return ['id' => (int) $user['id'], 'role' => (string) $user['role']];
    }

    $name = $profile['name'] !== '' ? $profile['name'] : strstr($profile['email'], '@', true);
    $name = mb_substr((string) $name, 0, 255);

    $pdo->beginTransaction();
    try {
        $insert = $pdo->prepare(
            "INSERT INTO users (name, email, password_hash, role) VALUES (:name, :email, '', 'user')"
        );
        $insert->execute([':name' => $name, ':email' => $profile['email']]);
        $newId = (int) $pdo->lastInsertId();
        social_link($pdo, $newId, $provider, $profile['id'], $profile['email']);
        $pdo->commit();
    } catch (PDOException $ex) {
        $pdo->rollBack();
        if ($ex->getCode() === '23000') {
            // Паралельний запит щойно створив того самого користувача — повторюємо пошук.
            return social_resolve_login($pdo, $provider, $profile);
        }
        throw $ex;
    }

    return ['id' => $newId, 'role' => 'user'];
}

// ---------------------------------------------------------------------
// CSRF для дій у кабінеті (відв'язка)
// ---------------------------------------------------------------------

function social_csrf_token(): string
{
    if (empty($_SESSION['social_csrf'])) {
        $_SESSION['social_csrf'] = bin2hex(random_bytes(16));
    }

    return (string) $_SESSION['social_csrf'];
}

function social_csrf_valid(mixed $sent): bool
{
    return is_string($sent) && $sent !== '' && hash_equals(social_csrf_token(), $sent);
}

// ---------------------------------------------------------------------
// Відображення
// ---------------------------------------------------------------------

/** Кругла плашка-іконка провайдера (без зовнішніх ресурсів). */
function oauth_icon_html(string $provider): string
{
    $p = OAUTH_PROVIDERS[$provider] ?? null;
    if ($p === null) {
        return '';
    }

    return '<span class="social-btn__icon" style="background:' . $p['color'] . ';color:' . $p['ink'] . '" aria-hidden="true">'
        . htmlspecialchars($p['glyph'], ENT_QUOTES) . '</span>';
}

/**
 * Блок «Або увійдіть через» з кнопками всіх провайдерів.
 * Підключені — посилання на auth-<provider>.php; решта — неактивні кнопки з підказкою «Скоро».
 */
function oauth_buttons_html(string $headingKey): string
{
    $html = '<div class="social-login">'
        . '<p class="social-login__divider"><span>' . htmlspecialchars(t($headingKey), ENT_QUOTES) . '</span></p>'
        . '<div class="social-login__grid">';

    foreach (OAUTH_PROVIDERS as $key => $p) {
        $label = htmlspecialchars($p['label'], ENT_QUOTES);
        if (oauth_provider_enabled($key)) {
            $html .= '<a class="social-btn" href="auth-' . $key . '.php">' . oauth_icon_html($key)
                . '<span class="social-btn__label">' . $label . '</span></a>';
        } else {
            $soon = htmlspecialchars(t('social_soon'), ENT_QUOTES);
            $html .= '<button type="button" class="social-btn" disabled title="' . $soon . '">' . oauth_icon_html($key)
                . '<span class="social-btn__label">' . $label . '</span>'
                . '<span class="social-btn__soon">' . $soon . '</span></button>';
        }
    }

    return $html . '</div></div>';
}

/** CSS для блоку кнопок (вставляється в <style> сторінок входу/реєстрації). */
const OAUTH_BUTTONS_CSS = <<<'CSS'
        .social-login {
            margin-top: 22px;
        }

        .social-login__divider {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 0 0 14px;
            color: var(--text-muted);
            font-size: 0.85rem;
        }

        .social-login__divider::before,
        .social-login__divider::after {
            content: "";
            flex: 1;
            height: 1px;
            background: var(--card-border);
        }

        .social-login__grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 10px;
        }

        .social-btn {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 12px;
            border-radius: 12px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            background: rgba(255, 255, 255, 0.08);
            color: #ffffff;
            font: inherit;
            font-size: 0.92rem;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            transition: background 0.15s ease, border-color 0.15s ease;
        }

        a.social-btn:hover {
            background: rgba(255, 255, 255, 0.14);
            border-color: var(--accent);
        }

        .social-btn[disabled] {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .social-btn__icon {
            flex: 0 0 26px;
            width: 26px;
            height: 26px;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            font-size: 0.85rem;
            border: 1px solid rgba(255, 255, 255, 0.25);
        }

        .social-btn__label {
            flex: 1;
            text-align: left;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .social-btn__soon {
            font-size: 0.72rem;
            font-weight: 600;
            color: var(--text-muted);
        }
CSS;
