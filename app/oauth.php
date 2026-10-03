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
    'google'   => ['label' => 'Google',    'color' => '#ffffff', 'ink' => '#1f1f1f', 'implemented' => true],
    'facebook' => ['label' => 'Facebook',  'color' => '#1877f2', 'ink' => '#ffffff', 'implemented' => false],
    'apple'    => ['label' => 'Apple',     'color' => '#000000', 'ink' => '#ffffff', 'implemented' => false],
    'linkedin' => ['label' => 'LinkedIn',  'color' => '#0a66c2', 'ink' => '#ffffff', 'implemented' => false],
    'x'        => ['label' => 'X',         'color' => '#000000', 'ink' => '#ffffff', 'implemented' => false],
    'discord'  => ['label' => 'Discord',   'color' => '#5865f2', 'ink' => '#ffffff', 'implemented' => false],
];

/**
 * Фірмові логотипи (SVG, viewBox 24×24; Google — офіційна чотирикольорова «G», 48×48).
 * Монохромні заливаються currentColor, тобто кольором тексту кнопки ('ink').
 * Джерело монохромних — simple-icons (CC0).
 */
const OAUTH_LOGOS = [
    'google'   => '<svg viewBox="0 0 48 48"><path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"/><path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"/><path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"/><path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"/></svg>',
    'facebook' => '<svg viewBox="0 0 24 24"><path fill="currentColor" d="M9.101 23.691v-7.98H6.627v-3.667h2.474v-1.58c0-4.085 1.848-5.978 5.858-5.978.401 0 .955.042 1.468.103a8.68 8.68 0 0 1 1.141.195v3.325a8.623 8.623 0 0 0-.653-.036 26.805 26.805 0 0 0-.733-.009c-.707 0-1.259.096-1.675.309a1.686 1.686 0 0 0-.679.622c-.258.42-.374.995-.374 1.752v1.297h3.919l-.386 2.103-.287 1.564h-3.246v8.245C19.396 23.238 24 18.179 24 12.044c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.628 3.874 10.35 9.101 11.647Z"/></svg>',
    'apple'    => '<svg viewBox="0 0 24 24"><path fill="currentColor" d="M12.152 6.896c-.948 0-2.415-1.078-3.96-1.04-2.04.027-3.91 1.183-4.961 3.014-2.117 3.675-.546 9.103 1.519 12.09 1.013 1.454 2.208 3.09 3.792 3.039 1.52-.065 2.09-.987 3.935-.987 1.831 0 2.35.987 3.96.948 1.637-.026 2.676-1.48 3.676-2.948 1.156-1.688 1.636-3.325 1.662-3.415-.039-.013-3.182-1.221-3.22-4.857-.026-3.04 2.48-4.494 2.597-4.559-1.429-2.09-3.623-2.324-4.39-2.376-2-.156-3.675 1.09-4.61 1.09zM15.53 3.83c.843-1.012 1.4-2.427 1.245-3.83-1.207.052-2.662.805-3.532 1.818-.78.896-1.454 2.338-1.273 3.714 1.338.104 2.715-.688 3.559-1.701"/></svg>',
    'linkedin' => '<svg viewBox="0 0 24 24"><path fill="currentColor" d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/></svg>',
    'x'        => '<svg viewBox="0 0 24 24"><path fill="currentColor" d="M18.901 1.153h3.68l-8.04 9.19L24 22.846h-7.406l-5.8-7.584-6.638 7.584H.474l8.6-9.83L0 1.154h7.594l5.243 6.932ZM17.61 20.644h2.039L6.486 3.24H4.298Z"/></svg>',
    'discord'  => '<svg viewBox="0 0 24 24"><path fill="currentColor" d="M20.317 4.3698a19.7913 19.7913 0 00-4.8851-1.5152.0741.0741 0 00-.0785.0371c-.211.3753-.4447.8648-.6083 1.2495-1.8447-.2762-3.68-.2762-5.4868 0-.1636-.3933-.4058-.8742-.6177-1.2495a.077.077 0 00-.0785-.037 19.7363 19.7363 0 00-4.8852 1.515.0699.0699 0 00-.0321.0277C.5334 9.0458-.319 13.5799.0992 18.0578a.0824.0824 0 00.0312.0561c2.0528 1.5076 4.0413 2.4228 5.9929 3.0294a.0777.0777 0 00.0842-.0276c.4616-.6304.8731-1.2952 1.226-1.9942a.076.076 0 00-.0416-.1057c-.6528-.2476-1.2743-.5495-1.8722-.8923a.077.077 0 01-.0076-.1277c.1258-.0943.2517-.1923.3718-.2914a.0743.0743 0 01.0776-.0105c3.9278 1.7933 8.18 1.7933 12.0614 0a.0739.0739 0 01.0785.0095c.1202.099.246.1981.3728.2924a.077.077 0 01-.0066.1276 12.2986 12.2986 0 01-1.873.8914.0766.0766 0 00-.0407.1067c.3604.698.7719 1.3628 1.225 1.9932a.076.076 0 00.0842.0286c1.961-.6067 3.9495-1.5219 6.0023-3.0294a.077.077 0 00.0313-.0552c.5004-5.177-.8382-9.6739-3.5485-13.6604a.061.061 0 00-.0312-.0286zM8.02 15.3312c-1.1825 0-2.1569-1.0857-2.1569-2.419 0-1.3332.9555-2.4189 2.157-2.4189 1.2108 0 2.1757 1.0952 2.1568 2.419 0 1.3332-.9555 2.4189-2.1569 2.4189zm7.9748 0c-1.1825 0-2.1569-1.0857-2.1569-2.419 0-1.3332.9554-2.4189 2.1569-2.4189 1.2108 0 2.1757 1.0952 2.1568 2.419 0 1.3332-.946 2.4189-2.1568 2.4189Z"/></svg>',
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

/** Фірмовий логотип провайдера заданого розміру (px). */
function oauth_logo_svg(string $provider, int $size = 18): string
{
    $svg = OAUTH_LOGOS[$provider] ?? '';

    return $svg === '' ? '' : str_replace('<svg ', '<svg width="' . $size . '" height="' . $size . '" aria-hidden="true" focusable="false" ', $svg);
}

/** Кругла плашка-іконка провайдера у фірмовому кольорі (кабінет, «Способи входу»). */
function oauth_icon_html(string $provider): string
{
    $p = OAUTH_PROVIDERS[$provider] ?? null;
    if ($p === null) {
        return '';
    }

    return '<span class="social-btn__icon" style="background:' . $p['color'] . ';color:' . $p['ink'] . '" aria-hidden="true">'
        . oauth_logo_svg($provider, 15) . '</span>';
}

/**
 * Блок «Або увійдіть через» з кнопками всіх провайдерів у фірмових кольорах.
 * Підключені — посилання на auth-<provider>.php (першими, на всю ширину);
 * решта — неактивні кнопки з позначкою «Скоро».
 */
function oauth_buttons_html(string $headingKey): string
{
    $enabled = '';
    $soonButtons = [];
    $soon = htmlspecialchars(t('social_soon'), ENT_QUOTES);

    foreach (OAUTH_PROVIDERS as $key => $p) {
        $label = htmlspecialchars($p['label'], ENT_QUOTES);
        $style = 'background:' . $p['color'] . ';color:' . $p['ink'];
        $logo = '<span class="social-btn__logo">' . oauth_logo_svg($key) . '</span>';
        if (oauth_provider_enabled($key)) {
            $enabled .= '<a class="social-btn social-btn--' . $key . ' social-btn--wide" style="' . $style . '" href="auth-' . $key . '.php">'
                . $logo . '<span class="social-btn__label">' . $label . '</span></a>';
        } else {
            $soonButtons[] = '<button type="button" class="social-btn social-btn--' . $key . '" style="' . $style . '" disabled title="' . $soon . '">'
                . $logo . '<span class="social-btn__label">' . $label . '</span>'
                . '<span class="social-btn__soon">' . $soon . '</span></button>';
        }
    }

    // Непарна остання кнопка в сітці на 2 колонки — на всю ширину, щоб не висіла сама.
    if (count($soonButtons) % 2 === 1) {
        $last = array_pop($soonButtons);
        $soonButtons[] = preg_replace('/class="social-btn /', 'class="social-btn social-btn--wide ', $last, 1);
    }

    return '<div class="social-login">'
        . '<p class="social-login__divider"><span>' . htmlspecialchars(t($headingKey), ENT_QUOTES) . '</span></p>'
        . '<div class="social-login__grid">' . $enabled . implode('', $soonButtons) . '</div></div>';
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
            gap: 12px;
        }

        /* Кнопки у фірмових кольорах провайдерів (фон і колір тексту — inline з OAUTH_PROVIDERS). */
        .social-btn {
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            min-height: 46px;
            padding: 10px 14px;
            border-radius: 12px;
            border: 1px solid transparent;
            font: inherit;
            font-size: 0.95rem;
            font-weight: 600;
            line-height: 1.2;
            text-decoration: none;
            cursor: pointer;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.25);
            transition: transform 0.15s ease, box-shadow 0.15s ease, filter 0.15s ease;
        }

        .social-btn--wide {
            grid-column: 1 / -1;
        }

        a.social-btn--wide {
            font-size: 1rem;
            min-height: 50px;
        }

        /* Google: біла кнопка з тонкою сірою рамкою, як у офіційному стилі. */
        .social-btn--google {
            border-color: #dadce0;
        }

        /* Чорні кнопки на темному фоні сайту — зі світлою рамкою, щоб не зливались. */
        .social-btn--apple,
        .social-btn--x {
            border-color: rgba(255, 255, 255, 0.45);
        }

        a.social-btn:hover,
        a.social-btn:focus-visible {
            transform: translateY(-1px);
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.35);
            filter: brightness(1.05);
        }

        a.social-btn:focus-visible {
            outline: 3px solid var(--accent);
            outline-offset: 2px;
        }

        .social-btn[disabled] {
            cursor: not-allowed;
        }

        .social-btn__logo {
            flex: 0 0 auto;
            display: inline-flex;
        }

        .social-btn__logo svg {
            display: block;
        }

        .social-btn__label {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .social-btn__soon {
            position: absolute;
            top: -8px;
            right: 8px;
            padding: 1px 7px;
            border-radius: 999px;
            background: #ffd54a;
            color: #1f1f1f;
            font-size: 0.66rem;
            font-weight: 700;
            letter-spacing: 0.02em;
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.3);
        }

        @media (max-width: 360px) {
            .social-login__grid {
                grid-template-columns: 1fr;
            }
        }
CSS;
