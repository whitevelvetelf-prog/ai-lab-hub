<?php

declare(strict_types=1);

/**
 * AI LAB HUB — сесія та авторизація.
 *
 * Підключати першим рядком (до будь-якого виводу):
 *   require_once __DIR__ . '/../app/auth.php';
 */

if (session_status() === PHP_SESSION_NONE) {
    // Кукі сесії: HttpOnly (JS не читає — XSS не краде сесію), SameSite=Lax (міжсайтові POST не несуть кукі —
    // додатковий захист від CSRF), Secure — коли запит по HTTPS.
    session_set_cookie_params([
        'lifetime' => 0,
        'path'     => '/',
        'secure'   => !empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off',
        'httponly' => true,
        'samesite' => 'Lax',
    ]);
    session_start();
}

// Джерело приходу з власної реклами (?ref=house-…) — для звіту «скільки кампаній/оголошень принесла».
require_once __DIR__ . '/acquisition.php';

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
    unset($_SESSION['after_login']);

    return $target === 'promo_create' ? 'account.php?promo_tab=create#acc-promo' : 'account.php';
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
