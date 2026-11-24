<?php

declare(strict_types=1);

/**
 * AI LAB HUB — сесія та авторизація.
 *
 * Підключати першим рядком (до будь-якого виводу):
 *   require_once __DIR__ . '/../app/auth.php';
 */

require_once __DIR__ . '/canonical.php';

// www./http-варіант адреси → 301 на канонічну (site_url): одна адреса — одна сесія (див. app/canonical.php).
app_canonical_redirect();

/** Скільки живе вхід без активності (секунди): кукі й файл сесії. */
const AUTH_SESSION_LIFETIME = 30 * 86400;

if (session_status() === PHP_SESSION_NONE) {
    // Кукі сесії: HttpOnly (JS не читає — XSS не краде сесію), SameSite=Lax (посилання з листа чи іншого сайту
    // несе кукі, міжсайтові POST — ні), Secure — коли запит по HTTPS. Домен не задаємо: кукі лише канонічного хоста.
    // Кукі постійна (30 днів), а не «до закриття браузера»: на iPhone застосунок з екрана «Додому» втрачає
    // сесійні кукі, щойно система його вивантажує (перехід у Пошту) — і вхід «злітав» посеред підтвердження пошти.
    // Файли сесій — у власній теці storage/sessions (поза webroot): спільна тека хостингу чиститься за чужим
    // gc_maxlifetime (типово 24 хв). Тека недоступна для запису — лишаються налаштування PHP за замовчуванням.
    if (PHP_SAPI !== 'cli') {
        $authSessDir = dirname(__DIR__) . '/storage/sessions';
        if (!is_dir($authSessDir)) {
            @mkdir($authSessDir, 0700, true);
        }
        if (is_dir($authSessDir) && is_writable($authSessDir)) {
            ini_set('session.save_path', $authSessDir);
            ini_set('session.gc_maxlifetime', (string) AUTH_SESSION_LIFETIME);
            ini_set('session.gc_probability', '1');
            ini_set('session.gc_divisor', '200');
        }
        ini_set('session.use_strict_mode', '1');
    }
    session_set_cookie_params([
        'lifetime' => AUTH_SESSION_LIFETIME,
        'path'     => '/',
        'secure'   => app_request_is_https(),
        'httponly' => true,
        'samesite' => 'Lax',
    ]);
    session_start();
}

// Джерело приходу з власної реклами (?ref=house-…) — для звіту «скільки кампаній/оголошень принесла».
require_once __DIR__ . '/acquisition.php';

// Превʼю посилань (Open Graph / Twitter Card): буфер виводу, теги дописуються перед </head> (app/social.php).
require_once __DIR__ . '/social.php';
social_meta_begin();

/** ID поточного користувача або null. */
function auth_user_id(): ?int
{
    return isset($_SESSION['user_id']) ? (int) $_SESSION['user_id'] : null;
}

/** Роль поточного користувача (user/employee/admin) або null. */
function auth_role(): ?string
{
    return isset($_SESSION['role']) ? (string) $_SESSION['role'] : null;
}

/** Чи є активна сесія користувача. */
function auth_check(): bool
{
    return auth_user_id() !== null;
}

/** Чи має користувач одну з переданих ролей. */
function auth_has_role(string ...$roles): bool
{
    $role = auth_role();

    return $role !== null && in_array($role, $roles, true);
}

/**
 * Повний запис поточного користувача з БД або null.
 * Якщо сесія вказує на неіснуючий акаунт — сесія скидається.
 */
function auth_current_user(PDO $pdo): ?array
{
    $id = auth_user_id();
    if ($id === null) {
        return null;
    }

    $stmt = $pdo->prepare('SELECT id, name, email, role, created_at FROM users WHERE id = :id');
    $stmt->execute([':id' => $id]);
    $user = $stmt->fetch();

    if ($user === false) {
        auth_logout();

        return null;
    }

    // Тримаємо роль у сесії актуальною.
    $_SESSION['role'] = $user['role'];

    return $user;
}

/** Створює сесію користувача після успішного входу/реєстрації. */
function auth_login(array $user): void
{
    session_regenerate_id(true);
    $_SESSION['user_id'] = (int) $user['id'];
    $_SESSION['role'] = (string) $user['role'];
    auth_promo_quiet_mark();
}

/**
 * Подія автентифікації (вхід, реєстрація, вихід, підтвердження пошти): кілька хвилин після неї
 * реклами немає — app/promo-quiet.php рахує promo_suppress_until з цієї мітки.
 */
function auth_promo_quiet_mark(): void
{
    if (session_status() === PHP_SESSION_ACTIVE) {
        $_SESSION['promo_auth_at'] = time();
    }
}

/**
 * Куди вести після входу/реєстрації. За замовчуванням — кабінет; якщо вхід почато
 * з кнопки «Створити кампанію» (public/advertise.php ставить after_login=promo_create) —
 * одразу в майстер реклами. Лише фіксовані адреси (без відкритого редиректу).
 */
function auth_after_login_url(): string
{
    $target = $_SESSION['after_login'] ?? null;
    $next = auth_safe_next((string) ($_SESSION['after_login_next'] ?? ''));
    unset($_SESSION['after_login'], $_SESSION['after_login_next']);

    if ($target === 'promo_create') {
        return 'account.php?promo_tab=create#acc-promo';
    }

    return $next ?? 'account.php';
}

/**
 * Сторінки, на які можна повернути після входу/підтвердження пошти (параметр next). Лише внутрішні.
 * Решта адрес → null (відкритого редиректу немає).
 */
const AUTH_NEXT_PAGES = [
    'account.php', 'listing-post.php', 'listings.php', 'listing.php', 'marketplace-post.php', 'marketplace.php',
    'marketplace-my.php', 'marketplace-offer.php', 'offer.php', 'asset-post.php', 'asset.php', 'assets.php',
    'mp-verify-email.php', 'advertise.php', 'saved.php', 'mp-favorites.php', 'marketplace-favorites.php',
    'mp-thread.php', 'mp-messages.php', 'mp-notify-settings.php',
    'bugville.php', 'bugville-mission.php', 'bugville-exam.php',   // гра «Багвіль»: після входу — назад у ту саму місію / іспит
];

/**
 * Перевіряє next: «сторінка.php[?параметри][#якір]» зі списку AUTH_NEXT_PAGES (провідний «/» дозволено).
 * Повертає нормалізований відносний шлях або null.
 */
function auth_safe_next(string $next): ?string
{
    $next = ltrim(trim($next), '/');
    if ($next === '' || strlen($next) > 300) {
        return null;
    }
    if (preg_match('~^([A-Za-z0-9_\-]+\.php)(\?[A-Za-z0-9_=&%\-.\[\]+]*)?(#[A-Za-z0-9_\-]*)?$~', $next, $m) !== 1) {
        return null;
    }

    return in_array($m[1], AUTH_NEXT_PAGES, true) ? $next : null;
}

/** Поточна сторінка як next (для «увійдіть і повертайтеся сюди»); null, якщо її немає в списку. */
function auth_current_next(): ?string
{
    $uri = (string) ($_SERVER['REQUEST_URI'] ?? '');
    $path = (string) parse_url($uri, PHP_URL_PATH);
    $query = (string) parse_url($uri, PHP_URL_QUERY);

    return auth_safe_next(basename($path) . ($query !== '' ? '?' . $query : ''));
}

/** Запам'ятовує next із GET (login.php, register.php, auth-google.php) — повернення після входу. */
function auth_remember_next_from_request(): void
{
    $next = auth_safe_next(is_string($_GET['next'] ?? null) ? (string) $_GET['next'] : '');
    if ($next !== null) {
        $_SESSION['after_login_next'] = $next;
    }
}

/** URL сторінки входу (чи реєстрації) з поверненням на $next. */
function auth_login_url(?string $next, string $page = 'login.php'): string
{
    $next = $next !== null ? auth_safe_next($next) : null;

    return $page . ($next !== null ? '?next=' . rawurlencode($next) : '');
}

/** Повністю знищує сесію користувача. */
function auth_logout(): void
{
    $_SESSION = [];

    // Нова порожня сесія з новим ID лише з міткою «тиші реклами» (app/promo-quiet.php) —
    // інакше наступна сторінка після виходу була б «другою сторінкою візиту» для спливаючого вікна.
    if (!headers_sent() && ini_get('session.use_cookies')) {
        session_destroy();
        $newId = session_create_id();
        if ($newId !== false) {
            session_id($newId);
        }
        session_start();
        auth_promo_quiet_mark();

        return;
    }

    if (ini_get('session.use_cookies')) {
        $params = session_get_cookie_params();
        setcookie(
            session_name(),
            '',
            time() - 42000,
            $params['path'],
            $params['domain'],
            $params['secure'],
            $params['httponly']
        );
    }

    session_destroy();
}
