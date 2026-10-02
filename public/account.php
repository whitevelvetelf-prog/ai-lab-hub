<?php

declare(strict_types=1);

/**
 * AI LAB HUB — кабінет користувача.
 *
 * Гість (немає сесії)  -> запрошення увійти / зареєструватися.
 * Авторизований        -> дані акаунта з таблиці users + вихід.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/mailer.php';   // mail_site_url()
require_once __DIR__ . '/../app/oauth.php';    // способи входу (соцмережі)

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$user = auth_current_user($pdo);

function e(mixed $value): string
{
    return htmlspecialchars((string) $value, ENT_QUOTES);
}

/**
 * Власниця проєкту — єдина, хто підтверджує заявки на посади директорів
 * (окремо від загальної перевірки «чинний admin»). Звіряємо за email.
 */
const OWNER_EMAIL = 'whitevelvetelf@gmail.com';

function account_is_owner(?array $user): bool
{
    return $user !== null
        && strcasecmp(trim((string) ($user['email'] ?? '')), OWNER_EMAIL) === 0;
}

/**
 * Чи всі позиції на цю посаду вже зайняті (з урахуванням ліміту capacity:
 * Генеральний — 1, Виконавчий — 2). Джерело істини — users.position
 * (звільнена позиція = position знову NULL). Кандидата $exceptUserId
 * не рахуємо (щоб повторне підтвердження тієї самої заявки не «блокувало
 * саме себе»).
 */
function account_director_slots_full(PDO $pdo, string $positionKey, int $exceptUserId): bool
{
    $label = director_position_label($positionKey);
    $capacity = director_position_capacity($positionKey);
    if ($label === null || $capacity <= 0) {
        return true; // невідома посада — підтверджувати не можна
    }

    $stmt = $pdo->prepare(
        "SELECT COUNT(*) FROM users WHERE `position` = :pos AND id <> :uid"
    );
    $stmt->execute([':pos' => $label, ':uid' => $exceptUserId]);

    return (int) $stmt->fetchColumn() >= $capacity;
}

/** Ініціали з імені для аватарки. */
function user_initials(string $name): string
{
    $parts = preg_split('/\s+/u', trim($name), -1, PREG_SPLIT_NO_EMPTY) ?: [];
    if (count($parts) >= 2) {
        return mb_strtoupper(mb_substr($parts[0], 0, 1) . mb_substr($parts[1], 0, 1));
    }

    return mb_strtoupper(mb_substr($name, 0, 2));
}

$roleLabels = [
    'user' => t('role_user'),
    'employee' => t('role_employee'),
    'admin' => t('role_admin'),
];

// Керівна посада поточного користувача (людський підпис у users.position).
// Окремий запит, а не поле auth_current_user() — щоб міграція posadа
// зачіпала лише кабінет, а не авторизацію на всьому сайті.
$userPosition = null;
if ($user !== null) {
    $posStmt = $pdo->prepare('SELECT `position` FROM users WHERE id = :id');
    $posStmt->execute([':id' => $user['id']]);
    $userPosition = ($posStmt->fetchColumn() ?: null);
}

// Скільки продуктів у добірці — для секції «Моя добірка» в кабінеті.
$savedCount = 0;
if ($user !== null) {
    $scStmt = $pdo->prepare(
        "SELECT COUNT(*) FROM saved_products sp
           JOIN products p ON p.id = sp.product_id
          WHERE sp.user_id = :uid AND p.status = 'published'"
    );
    $scStmt->execute([':uid' => $user['id']]);
    $savedCount = (int) $scStmt->fetchColumn();
}

// ---------------------------------------------------------------------
// POST: подача заявки «Стати працівником» (роль user) та схвалення
// заявки адміністратором. PRG — після успіху редірект на account.php,
// повідомлення переноситься через сесію ($_SESSION['account_flash']).
// ---------------------------------------------------------------------
$requestErrors = [];
$oldRequest = ['last_name' => '', 'first_name' => ''];

if ($_SERVER['REQUEST_METHOD'] === 'POST' && $user !== null) {
    $action = (string) ($_POST['action'] ?? '');

    // Відв'язка соцмережі (секція «Способи входу»). Останній спосіб входу
    // (пароль + соцмережі) відв'язати не можна — app/oauth.php → social_unlink().
    if ($action === 'unlink_social') {
        $provider = (string) ($_POST['provider'] ?? '');
        if (social_csrf_valid($_POST['csrf'] ?? null) && isset(OAUTH_PROVIDERS[$provider])) {
            if (social_unlink($pdo, (int) $user['id'], $provider)) {
                $_SESSION['account_flash'] = sprintf(t('account_social_unlinked_flash'), oauth_provider_label($provider));
            } else {
                $_SESSION['oauth_error'] = t('account_social_last_method');
            }
        }
        header('Location: account.php');
        exit;
    }

    // ТЕРМІНОВО вимкнено: подача заявки "Стати працівником" (і UI, і бекенд).
    // Не видалено — лише умова false, щоб легко повернути.
    if (false && $action === 'employee_request' && $user['role'] === 'user') {
        $oldRequest['last_name'] = trim((string) ($_POST['last_name'] ?? ''));
        $oldRequest['first_name'] = trim((string) ($_POST['first_name'] ?? ''));

        if ($oldRequest['last_name'] === '') {
            $requestErrors[] = 'Вкажіть прізвище.';
        } elseif (mb_strlen($oldRequest['last_name']) > 255) {
            $requestErrors[] = 'Прізвище задовге (максимум 255 символів).';
        }
        if ($oldRequest['first_name'] === '') {
            $requestErrors[] = 'Вкажіть ім’я.';
        } elseif (mb_strlen($oldRequest['first_name']) > 255) {
            $requestErrors[] = 'Ім’я задовге (максимум 255 символів).';
        }

        if ($requestErrors === []) {
            $dup = $pdo->prepare(
                "SELECT id FROM employee_requests
                  WHERE user_id = :uid AND status = 'pending'"
            );
            $dup->execute([':uid' => $user['id']]);
            if ($dup->fetch() !== false) {
                $requestErrors[] = 'Ваша заявка вже на розгляді.';
            }
        }

        if ($requestErrors === []) {
            $ins = $pdo->prepare(
                "INSERT INTO employee_requests (user_id, last_name, first_name)
                 VALUES (:uid, :last, :first)"
            );
            $ins->execute([
                ':uid' => $user['id'],
                ':last' => $oldRequest['last_name'],
                ':first' => $oldRequest['first_name'],
            ]);
            $_SESSION['account_flash'] = 'Заявку надіслано. Очікуйте рішення адміністратора.';
            header('Location: account.php');
            exit;
        }
    }

    if ($action === 'approve_request' && $user['role'] === 'admin') {
        $reqId = (int) ($_POST['request_id'] ?? 0);
        try {
            $pdo->beginTransaction();

            $stmt = $pdo->prepare(
                "SELECT id, user_id, last_name, first_name
                   FROM employee_requests
                  WHERE id = :id AND status = 'pending'
                  FOR UPDATE"
            );
            $stmt->execute([':id' => $reqId]);
            $req = $stmt->fetch();

            if ($req === false) {
                $pdo->rollBack();
                $_SESSION['account_flash'] = t('flash_request_not_found');
            } else {
                // Наступний послідовний номер: MAX + 1, або 1 для першого працівника.
                $nextNumber = (int) $pdo->query(
                    'SELECT COALESCE(MAX(employee_number), 0) + 1 FROM users'
                )->fetchColumn();

                $upd = $pdo->prepare(
                    "UPDATE users
                        SET role = 'employee',
                            employee_number = :num,
                            last_name = :last,
                            first_name = :first
                      WHERE id = :uid"
                );
                $upd->execute([
                    ':num' => $nextNumber,
                    ':last' => $req['last_name'],
                    ':first' => $req['first_name'],
                    ':uid' => $req['user_id'],
                ]);

                $done = $pdo->prepare(
                    "UPDATE employee_requests
                        SET status = 'approved', reviewed_at = NOW(), reviewed_by = :admin
                      WHERE id = :id"
                );
                $done->execute([':admin' => $user['id'], ':id' => $req['id']]);

                $pdo->commit();
                $_SESSION['account_flash'] = sprintf(
                    t('flash_request_approved'),
                    $nextNumber
                );
            }
        } catch (PDOException $ex) {
            if ($pdo->inTransaction()) {
                $pdo->rollBack();
            }
            $_SESSION['account_flash'] = t('flash_request_approve_failed');
        }

        header('Location: account.php');
        exit;
    }

    // Приватні заявки з admin_requests (три незалежні форми):
    //   * position = NULL          — заявка на роль Адміністратора (apply-admin.php);
    //                                підтверджує будь-який чинний admin (стара поведінка);
    //   * position = 'ceo'/'exec_director' — заявка на посаду директора;
    //                                підтверджує ВИКЛЮЧНО власниця; при approve
    //                                перевіряється ліміт позицій (1 / 2); контакт
    //                                із заявки копіюється в users.
    if (($action === 'approve_admin_request' || $action === 'reject_admin_request') && $user['role'] === 'admin') {
        $reqId = (int) ($_POST['request_id'] ?? 0);
        $newStatus = $action === 'approve_admin_request' ? 'approved' : 'rejected';

        try {
            $pdo->beginTransaction();

            $stmt = $pdo->prepare(
                "SELECT id, user_id, `position`, first_name, last_name, phone
                   FROM admin_requests
                  WHERE id = :id AND status = 'pending'
                  FOR UPDATE"
            );
            $stmt->execute([':id' => $reqId]);
            $req = $stmt->fetch();

            $positionKey = ($req !== false) ? ($req['position'] ?? null) : null;
            $positionLabel = director_position_label($positionKey);

            if ($req === false) {
                $pdo->rollBack();
                $_SESSION['account_flash'] = t('flash_request_not_found');
            } elseif ($positionKey !== null && !account_is_owner($user)) {
                // Заявку на посаду директора вирішує лише власниця.
                $pdo->rollBack();
                $_SESSION['account_flash'] = t('flash_admin_request_owner_only');
            } elseif (
                $newStatus === 'approved'
                && $positionKey !== null
                && account_director_slots_full($pdo, $positionKey, (int) $req['user_id'])
            ) {
                // Немає вільних позицій — не підтверджуємо, лишаємо на розгляді.
                $pdo->rollBack();
                $_SESSION['account_flash'] = sprintf(
                    t('flash_admin_position_taken'),
                    $positionLabel ?? $positionKey
                );
            } else {
                if ($newStatus === 'approved') {
                    if ($positionLabel !== null) {
                        // Директор: роль admin (доступ до CRM) + посада + контакт у профіль.
                        $upd = $pdo->prepare(
                            "UPDATE users
                                SET role = 'admin',
                                    `position` = :pos,
                                    first_name = :first,
                                    last_name = :last,
                                    phone = :phone
                              WHERE id = :uid"
                        );
                        $upd->execute([
                            ':pos'   => $positionLabel,
                            ':first' => $req['first_name'],
                            ':last'  => $req['last_name'],
                            ':phone' => $req['phone'],
                            ':uid'   => (int) $req['user_id'],
                        ]);
                    } else {
                        $upd = $pdo->prepare("UPDATE users SET role = 'admin' WHERE id = :uid");
                        $upd->execute([':uid' => (int) $req['user_id']]);
                    }
                }

                $done = $pdo->prepare(
                    "UPDATE admin_requests
                        SET status = :status, reviewed_at = NOW(), reviewed_by = :admin
                      WHERE id = :id"
                );
                $done->execute([':status' => $newStatus, ':admin' => $user['id'], ':id' => $req['id']]);

                $pdo->commit();

                if ($newStatus === 'rejected') {
                    $_SESSION['account_flash'] = t('flash_admin_request_rejected');
                } elseif ($positionLabel !== null) {
                    $_SESSION['account_flash'] = sprintf(t('flash_admin_director_approved'), $positionLabel);
                } else {
                    $_SESSION['account_flash'] = t('flash_admin_request_approved');
                }
            }
        } catch (PDOException $ex) {
            if ($pdo->inTransaction()) {
                $pdo->rollBack();
            }
            $_SESSION['account_flash'] = t('flash_admin_request_failed');
        }

        header('Location: account.php');
        exit;
    }

    // ------------------------------------------------------------------
    // Універсальна система заявок на посаду (position_applications) —
    // заміна окремих apply-ceo.php/apply-exec-director.php для нових
    // заявок. Створення посилання — лише власниця; підтвердження —
    // будь-який admin (як і решта заявок у цьому кабінеті).
    // ------------------------------------------------------------------
    if ($action === 'create_position_application' && account_is_owner($user)) {
        $positionTitle = trim((string) ($_POST['position_title'] ?? ''));

        if ($positionTitle === '' || mb_strlen($positionTitle) > 255) {
            $_SESSION['account_flash'] = t('err_position_title_required');
        } else {
            try {
                $token = bin2hex(random_bytes(32));
                $insert = $pdo->prepare(
                    "INSERT INTO position_applications (position_title, token, status, created_by)
                     VALUES (:title, :token, 'pending', :uid)"
                );
                $insert->execute([':title' => $positionTitle, ':token' => $token, ':uid' => $user['id']]);

                $link = mail_site_url() . '/apply-position.php?token=' . $token;

                // Посилання має бути клікабельним (не голим текстом) — тому окремий
                // "довірений" HTML-прапор замість звичайного plain-text flash.
                $_SESSION['account_flash_html'] = sprintf(
                    t('flash_position_link_created'),
                    '<a href="' . e($link) . '">' . e($link) . '</a>'
                );
            } catch (PDOException $ex) {
                $_SESSION['account_flash'] = t('flash_admin_request_failed');
            }
        }

        header('Location: account.php');
        exit;
    }

    if ($action === 'confirm_position_application' && $user['role'] === 'admin') {
        $appId = (int) ($_POST['application_id'] ?? 0);

        try {
            $pdo->beginTransaction();

            $stmt = $pdo->prepare(
                "SELECT id, position_title, email
                   FROM position_applications
                  WHERE id = :id AND status = 'submitted'
                  FOR UPDATE"
            );
            $stmt->execute([':id' => $appId]);
            $app = $stmt->fetch();

            if ($app === false) {
                $pdo->rollBack();
                $_SESSION['account_flash'] = t('flash_request_not_found');
            } else {
                $candidateStmt = $pdo->prepare('SELECT id FROM users WHERE email = :email');
                $candidateStmt->execute([':email' => $app['email']]);
                $candidate = $candidateStmt->fetch();

                if ($candidate === false) {
                    $pdo->rollBack();
                    $_SESSION['account_flash'] = sprintf(t('flash_position_app_no_user'), (string) $app['email']);
                } else {
                    $updUser = $pdo->prepare(
                        "UPDATE users SET role = 'admin', `position` = :pos WHERE id = :uid"
                    );
                    $updUser->execute([':pos' => $app['position_title'], ':uid' => (int) $candidate['id']]);

                    $updApp = $pdo->prepare(
                        "UPDATE position_applications SET status = 'confirmed', confirmed_at = NOW() WHERE id = :id"
                    );
                    $updApp->execute([':id' => (int) $app['id']]);

                    $pdo->commit();
                    $_SESSION['account_flash'] = sprintf(t('flash_position_app_confirmed'), (string) $app['position_title']);
                }
            }
        } catch (PDOException $ex) {
            if ($pdo->inTransaction()) {
                $pdo->rollBack();
            }
            $_SESSION['account_flash'] = t('flash_admin_request_failed');
        }

        header('Location: account.php');
        exit;
    }
}

$flash = $_SESSION['account_flash'] ?? null;
$flashHtml = $_SESSION['account_flash_html'] ?? null;
unset($_SESSION['account_flash'], $_SESSION['account_flash_html']);

// Способи входу: пароль + прив'язані соцмережі (social_accounts). Помилка прив'язки/відв'язки — oauth_error.
$oauthError = $_SESSION['oauth_error'] ?? null;
unset($_SESSION['oauth_error']);
$socialLinked = [];
$hasPassword = false;
$loginMethods = 0;
if ($user !== null) {
    foreach (social_accounts_for_user($pdo, (int) $user['id']) as $row) {
        $socialLinked[$row['provider']] = $row;
    }
    $hasPassword = social_user_has_password($pdo, (int) $user['id']);
    $loginMethods = ($hasPassword ? 1 : 0) + count($socialLinked);
}

// Заявка «на розгляді» для поточного user; список заявок для admin.
$pendingRequest = null;
$pendingRequests = [];
// Статистика користувачів за ролями — лише для admin.
$userStats = ['total' => 0, 'users' => 0, 'employees' => 0, 'admins' => 0];
$staffEmployees = [];
$staffAdmins = [];
// Заявки на роль Адміністратора (приватна система, окремо від employee_requests).
$adminRequests = [];
// Заявки на посаду (універсальна система, окремо від admin_requests).
$positionApplications = [];
if ($user !== null && $user['role'] === 'user') {
    $stmt = $pdo->prepare(
        "SELECT last_name, first_name, created_at
           FROM employee_requests
          WHERE user_id = :uid AND status = 'pending'
          ORDER BY id DESC
          LIMIT 1"
    );
    $stmt->execute([':uid' => $user['id']]);
    $pendingRequest = $stmt->fetch() ?: null;
} elseif ($user !== null && $user['role'] === 'admin') {
    $pendingRequests = $pdo->query(
        "SELECT r.id, r.last_name, r.first_name, r.created_at,
                u.name AS user_name, u.email AS user_email
           FROM employee_requests r
           JOIN users u ON u.id = r.user_id
          WHERE r.status = 'pending'
          ORDER BY r.created_at ASC, r.id ASC"
    )->fetchAll();

    $statsRow = $pdo->query(
        "SELECT COUNT(*)                       AS total,
                SUM(role = 'user')             AS users,
                SUM(role = 'employee')         AS employees,
                SUM(role = 'admin')            AS admins
           FROM users"
    )->fetch() ?: [];
    $userStats = [
        'total'     => (int) ($statsRow['total'] ?? 0),
        'users'     => (int) ($statsRow['users'] ?? 0),
        'employees' => (int) ($statsRow['employees'] ?? 0),
        'admins'    => (int) ($statsRow['admins'] ?? 0),
    ];

    // Працівники: номер, ПІБ, email, дата отримання ролі (reviewed_at
    // останньої схваленої заявки).
    $staffEmployees = $pdo->query(
        "SELECT u.employee_number, u.name, u.first_name, u.last_name, u.email,
                (SELECT r.reviewed_at
                   FROM employee_requests r
                  WHERE r.user_id = u.id AND r.status = 'approved'
                  ORDER BY r.reviewed_at DESC, r.id DESC
                  LIMIT 1) AS role_since
           FROM users u
          WHERE u.role = 'employee'
          ORDER BY u.employee_number IS NULL, u.employee_number ASC, u.id ASC"
    )->fetchAll();

    $staffAdmins = $pdo->query(
        "SELECT name, email FROM users WHERE role = 'admin' ORDER BY name, id"
    )->fetchAll();

    $adminRequests = $pdo->query(
        "SELECT r.id, r.user_id, r.requested_at, r.`position`,
                r.first_name, r.last_name, r.phone, r.email,
                u.name AS user_name, u.email AS user_email
           FROM admin_requests r
           JOIN users u ON u.id = r.user_id
          WHERE r.status = 'pending'
          ORDER BY r.requested_at ASC, r.id ASC"
    )->fetchAll();

    $positionApplications = $pdo->query(
        "SELECT id, position_title, last_name, first_name, email, phone, status, created_at, submitted_at
           FROM position_applications
          ORDER BY created_at DESC
          LIMIT 100"
    )->fetchAll();
}

// -----------------------------------------------------------------------
// Об'єднаний список заявок для акордеону «Заявки»: працівники (employee_
// requests) + адміністратор/директори (admin_requests) — один вхідний
// пункт замість кількох окремих секцій. Кожен елемент позначений типом.
// -----------------------------------------------------------------------
$mergedRequests = [];
// ТЕРМІНОВО приховано: заявки на роль Працівника ($pendingRequests) не
// потрапляють у об'єднаний список — лишаються лише адмін/директори.
foreach ($adminRequests as $req) {
    $reqPositionKey = $req['position'] ?? null;
    $reqPositionLabel = director_position_label($reqPositionKey);
    $isDirectorReq = $reqPositionKey !== null;
    $reqApplicantName = trim((string) ($req['last_name'] ?? '') . ' ' . (string) ($req['first_name'] ?? ''));

    $mergedRequests[] = [
        'kind'         => $isDirectorReq ? 'director' : 'admin_role',
        'sort_at'      => (string) $req['requested_at'],
        'type_label'   => $isDirectorReq ? ($reqPositionLabel ?? (string) $reqPositionKey) : $roleLabels['admin'],
        'title'        => (string) $req['user_name'],
        'meta_name'    => $isDirectorReq ? $reqApplicantName : '',
        'meta_email'   => (string) $req['user_email'],
        'meta_phone'   => ($isDirectorReq && !empty($req['phone'])) ? (string) $req['phone'] : null,
        'requested_at' => (string) $req['requested_at'],
        'request_id'   => (int) $req['id'],
        'can_decide'   => !$isDirectorReq || account_is_owner($user),
        'slots_full'   => $isDirectorReq
            && account_director_slots_full($pdo, (string) $reqPositionKey, (int) $req['user_id']),
    ];
}
usort($mergedRequests, static fn(array $a, array $b): int => strtotime($a['sort_at']) <=> strtotime($b['sort_at']));

?>
<!DOCTYPE html>
<html lang="<?= htmlspecialchars(current_lang(), ENT_QUOTES) ?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AI LAB HUB — <?= htmlspecialchars(t('nav_account'), ENT_QUOTES) ?></title>
    <style>
        *,
        *::before,
        *::after {
            box-sizing: border-box;
        }

        :root {
            --bg-start: #00032c;
            --bg-end: #2116ad;
            --card-bg: rgba(255, 255, 255, 0.05);
            --card-border: rgba(255, 255, 255, 0.14);
            --text-muted: rgba(255, 255, 255, 0.75);
            --accent: #5b8cff;
        }

        html,
        body {
            margin: 0;
            padding: 0;
        }

        body {
            min-height: 100vh;
            font-family: "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            color: #ffffff;
            background: linear-gradient(160deg, var(--bg-start) 0%, var(--bg-end) 100%);
            background-attachment: fixed;
            line-height: 1.6;
        }

        .site-header {
            display: flex;
            align-items: center;
            padding: 20px 32px;
        }

        .site-header__brand {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
            color: #ffffff;
        }

        .site-header__logo {
            height: 42px;
            width: auto;
            display: block;
            border-radius: 10px;
        }

        .site-nav {
            margin-left: auto;
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
        }

        .site-nav__link {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 9px 16px;
            border-radius: 999px;
            font-size: 0.9rem;
            font-weight: 600;
            text-decoration: none;
            color: var(--text-muted);
            transition: color 0.15s ease, background 0.15s ease;
        }

        .site-nav__link:hover {
            color: #ffffff;
            background: rgba(255, 255, 255, 0.08);
        }

        /* Заклик до дії — виділений пункт меню «Викликати Асистента» */
        .site-nav__link--cta {
            color: #00032c;
            background: linear-gradient(135deg, #5b8cff, #a5c0ff);
            box-shadow: 0 6px 18px rgba(91, 140, 255, 0.4);
        }

        .site-nav__link--cta:hover {
            color: #00032c;
            background: linear-gradient(135deg, #6f9bff, #b8ceff);
        }

        .site-nav__link--cta svg {
            width: 16px;
            height: 16px;
        }

        .page {
            max-width: 720px;
            margin: 0 auto;
            padding: 24px 24px 72px;
        }

        .account-panel {
            padding: 32px;
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .account-panel__title {
            margin: 0 0 12px;
            font-size: clamp(1.5rem, 4vw, 2rem);
            font-weight: 800;
            letter-spacing: 0.02em;
        }

        .account-panel__text {
            margin: 0 0 24px;
            font-size: 1.02rem;
            color: var(--text-muted);
            max-width: 46ch;
        }

        .btn-row {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
        }

        .btn {
            display: inline-block;
            padding: 12px 24px;
            border-radius: 999px;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            border: 1px solid transparent;
            transition: transform 0.15s ease, background 0.15s ease, border-color 0.15s ease;
        }

        .btn:active {
            transform: translateY(1px);
        }

        .btn--primary {
            background: #ffffff;
            color: #00032c;
        }

        .btn--primary:hover {
            background: rgba(255, 255, 255, 0.88);
        }

        .btn--ghost {
            background: transparent;
            color: #ffffff;
            border-color: rgba(255, 255, 255, 0.4);
        }

        .btn--ghost:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        /* Способи входу (пароль + соцмережі, app/oauth.php) */
        .login-methods {
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .login-methods__item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 10px 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .login-methods__item:last-child {
            border-bottom: 0;
        }

        .login-methods__name {
            flex: 1;
            min-width: 0;
        }

        .login-methods__name strong {
            display: block;
        }

        .login-methods__meta {
            display: block;
            font-size: 0.85rem;
            color: rgba(255, 255, 255, 0.7);
            overflow-wrap: anywhere;
        }

        .login-methods__form {
            margin: 0;
        }

        .btn--small {
            padding: 6px 14px;
            font-size: 0.85rem;
            font-family: inherit;
        }

        .btn[disabled] {
            opacity: 0.45;
            cursor: not-allowed;
        }

        .login-methods__hint {
            margin: 12px 0 0;
            font-size: 0.85rem;
            color: rgba(255, 255, 255, 0.7);
        }

        .social-btn__icon {
            flex: 0 0 28px;
            width: 28px;
            height: 28px;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            font-size: 0.85rem;
            border: 1px solid rgba(255, 255, 255, 0.25);
        }

        /* Шапка авторизованого користувача */
        .account-user {
            display: flex;
            align-items: center;
            gap: 18px;
            margin-bottom: 24px;
        }

        .account-user__avatar {
            width: 64px;
            height: 64px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.35rem;
            font-weight: 800;
            letter-spacing: 0.02em;
            background: linear-gradient(135deg, #d97706, #fbbf24);
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.35);
            flex-shrink: 0;
        }

        .account-user__title {
            margin: 0 0 4px;
            font-size: clamp(1.4rem, 4vw, 1.9rem);
            font-weight: 800;
            letter-spacing: 0.02em;
        }

        .account-user__meta {
            margin: 0;
            font-size: 0.9rem;
            color: var(--text-muted);
        }

        .role-badge {
            display: inline-block;
            margin-left: 8px;
            padding: 2px 10px;
            border-radius: 999px;
            font-size: 0.72rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            background: rgba(91, 140, 255, 0.2);
            border: 1px solid rgba(91, 140, 255, 0.5);
            vertical-align: middle;
        }

        .section {
            margin: 28px 0;
        }

        .section__title {
            margin: 0 0 12px;
            font-size: 1.15rem;
            font-weight: 700;
        }

        .empty-state {
            padding: 20px;
            border: 1px dashed var(--card-border);
            border-radius: 12px;
            color: var(--text-muted);
            font-size: 0.95rem;
        }

        .empty-state a {
            color: #bcd0ff;
        }

        .staff-note {
            margin: 28px 0;
            padding: 16px 18px;
            border-radius: 12px;
            border: 1px solid rgba(52, 211, 153, 0.5);
            background: rgba(52, 211, 153, 0.12);
            font-size: 0.95rem;
        }

        .staff-note a {
            color: #bbf7d0;
            font-weight: 600;
        }

        .section__hint {
            margin: 0 0 14px;
            font-size: 0.92rem;
            color: var(--text-muted);
        }

        .section__subtitle {
            margin: 18px 0 10px;
            font-size: 0.95rem;
            font-weight: 700;
            color: var(--text-muted);
        }

        /* Картки-лічильники (консистентно з .summary у crm-list.php) */
        .summary {
            display: flex;
            flex-wrap: wrap;
            gap: 8px 22px;
            margin: 0 0 16px;
            padding: 14px 18px;
            border: 1px solid var(--card-border);
            border-radius: 12px;
            background: var(--card-bg);
            font-size: 0.95rem;
        }

        .summary strong {
            font-weight: 800;
        }

        .summary a {
            color: #bcd0ff;
        }

        .field {
            margin-bottom: 16px;
        }

        .field__label {
            display: block;
            margin-bottom: 6px;
            font-size: 0.9rem;
            font-weight: 700;
        }

        .input {
            width: 100%;
            padding: 11px 14px;
            border-radius: 10px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            background: rgba(255, 255, 255, 0.08);
            color: #ffffff;
            font-size: 1rem;
            font-family: inherit;
        }

        .input:focus {
            outline: none;
            border-color: var(--accent);
            background: rgba(255, 255, 255, 0.12);
        }

        .form-row {
            display: flex;
            gap: 14px;
            flex-wrap: wrap;
        }

        .form-row .field {
            flex: 1 1 180px;
        }

        .notice {
            margin: 0 0 18px;
            padding: 13px 16px;
            border-radius: 12px;
            font-size: 0.92rem;
            border: 1px solid rgba(252, 165, 165, 0.6);
            background: rgba(252, 165, 165, 0.12);
        }

        .notice ul {
            margin: 0;
            padding-left: 20px;
        }

        .notice--ok {
            border-color: rgba(52, 211, 153, 0.5);
            background: rgba(52, 211, 153, 0.12);
        }

        .notice a {
            color: #ffffff;
            font-weight: 700;
            text-decoration: underline;
        }

        .notice a:hover {
            color: #bcd0ff;
        }

        .section__link {
            color: #bcd0ff;
            font-weight: 600;
            text-decoration: none;
        }

        .section__link:hover {
            color: #ffffff;
            text-decoration: underline;
        }

        .request-type-badge {
            display: inline-block;
            margin-left: 8px;
            padding: 1px 9px;
            border-radius: 999px;
            font-size: 0.68rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: #bcd0ff;
            background: rgba(91, 140, 255, 0.16);
            border: 1px solid rgba(91, 140, 255, 0.4);
            vertical-align: middle;
        }

        .request-list {
            list-style: none;
            margin: 0;
            padding: 0;
            display: grid;
            gap: 12px;
        }

        .request-card {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 14px;
            flex-wrap: wrap;
            padding: 14px 16px;
            border: 1px solid var(--card-border);
            border-radius: 12px;
            background: rgba(255, 255, 255, 0.04);
        }

        .request-card__meta {
            display: block;
            margin-top: 2px;
            font-size: 0.82rem;
            color: var(--text-muted);
        }

        .btn--approve {
            padding: 9px 18px;
            font-size: 0.9rem;
            background: #34d399;
            color: #00201a;
        }

        .btn--approve:hover {
            background: #4ade9f;
        }

        /* Акордеон розділів кабінету */
        .accordion {
            margin: 16px 0;
            border: 1px solid var(--card-border);
            border-radius: 14px;
            background: rgba(255, 255, 255, 0.03);
            overflow: hidden;
        }

        .accordion__header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            width: 100%;
            padding: 18px 20px;
            border: none;
            background: transparent;
            color: #ffffff;
            font: inherit;
            font-weight: 700;
            font-size: 1.1rem;
            text-align: left;
            cursor: pointer;
            transition: background 0.15s ease;
        }

        .accordion__header:hover {
            background: rgba(255, 255, 255, 0.05);
        }

        .accordion__header:focus-visible {
            outline: 2px solid var(--accent);
            outline-offset: -2px;
        }

        .accordion__chevron {
            flex-shrink: 0;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 22px;
            height: 22px;
            font-size: 0.85rem;
            color: var(--text-muted);
            transition: transform 0.25s ease;
        }

        .accordion.is-open > .accordion__header .accordion__chevron {
            transform: rotate(180deg);
            color: #ffffff;
        }

        .accordion__panel {
            display: grid;
            grid-template-rows: 0fr;
            transition: grid-template-rows 0.28s ease;
        }

        .accordion.is-open > .accordion__panel {
            grid-template-rows: 1fr;
        }

        .accordion__panel-inner {
            min-height: 0;
            overflow: hidden;
            padding: 0 20px 20px;
        }

        /* Закріплена кнопка «згорнути назад» — фіксована відносно вікна
           перегляду, лишається доступною незалежно від прокрутки довгого
           вмісту розгорнутого розділу. */
        .accordion-back {
            position: fixed;
            right: 20px;
            bottom: calc(var(--footer-h, 0px) + 16px);
            z-index: 90; /* нижче за шапку/підвал (100), вище за контент */
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 18px;
            border-radius: 999px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            background: #2116ad;
            color: #ffffff;
            font-size: 0.9rem;
            font-weight: 700;
            cursor: pointer;
            box-shadow: 0 10px 28px rgba(0, 0, 0, 0.45);
            transition: background 0.15s ease, transform 0.15s ease;
        }

        .accordion-back:hover {
            background: #3226c9;
            transform: translateY(-1px);
        }

        .accordion-back[hidden] {
            display: none;
        }

        .accordion-back__chevron {
            font-size: 0.85rem;
        }

        @media (max-width: 600px) {
            .site-header {
                justify-content: center;
                padding: 16px;
                flex-wrap: wrap;
                gap: 12px;
            }

            .account-panel {
                padding: 24px;
            }

            .accordion__header {
                padding: 15px 16px;
                font-size: 1.02rem;
            }

            .accordion__panel-inner {
                padding: 0 16px 16px;
            }

            .accordion-back {
                right: 12px;
                bottom: 12px;
                padding: 11px 14px;
                font-size: 0.85rem;
            }

            .accordion-back__label {
                max-width: 40vw;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }
        }
    </style>
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <?php include __DIR__ . '/../app/site-header.php'; ?>

    <div class="page">
<?php if ($user === null): ?>
        <section class="account-panel">
            <h1 class="account-panel__title"><?= htmlspecialchars(t('account_title_guest'), ENT_QUOTES) ?></h1>
            <p class="account-panel__text">
                <?= htmlspecialchars(t('account_text_guest'), ENT_QUOTES) ?>
            </p>
            <div class="btn-row">
                <a class="btn btn--primary" href="login.php"><?= htmlspecialchars(t('nav_login'), ENT_QUOTES) ?></a>
                <a class="btn btn--ghost" href="register.php"><?= htmlspecialchars(t('account_create'), ENT_QUOTES) ?></a>
            </div>
        </section>
<?php else: ?>
        <section class="account-panel">
            <div class="account-user">
                <div class="account-user__avatar"><?= e(user_initials((string) $user['name'])) ?></div>
                <div>
                    <h1 class="account-user__title">
                        <?php $accountBadge = ($userPosition !== null && $userPosition !== '')
                            ? $userPosition
                            : ($roleLabels[$user['role']] ?? $user['role']); ?>
                        <?= htmlspecialchars(t('account_welcome_prefix'), ENT_QUOTES) ?> <?= e($user['name']) ?><span class="role-badge"><?= e($accountBadge) ?></span>
                    </h1>
                    <p class="account-user__meta"><?= e($user['email']) ?></p>
                </div>
            </div>

            <?php if ($flashHtml !== null): ?>
                <div class="notice notice--ok"><?= $flashHtml /* безпечний HTML: побудований сервером із e()-екранованих частин, див. create_position_application */ ?></div>
            <?php elseif ($flash !== null): ?>
                <div class="notice notice--ok"><?= e($flash) ?></div>
            <?php endif; ?>
            <?php if ($oauthError !== null): ?>
                <div class="notice notice--error"><?= e($oauthError) ?></div>
            <?php endif; ?>

            <div class="accordion" id="acc-saved">
                <button type="button" class="accordion__header" aria-expanded="false" aria-controls="acc-saved-panel">
                    <span class="accordion__title"><?= htmlspecialchars(t('account_saved_title'), ENT_QUOTES) ?></span>
                    <span class="accordion__chevron" aria-hidden="true">&#9662;</span>
                </button>
                <div class="accordion__panel" id="acc-saved-panel">
                    <div class="accordion__panel-inner">
                        <?php if ($savedCount > 0): ?>
                        <div class="empty-state">
                            <?= htmlspecialchars(sprintf(t('account_saved_count'), $savedCount), ENT_QUOTES) ?>
                            <a class="section__link" href="saved.php"><?= htmlspecialchars(t('account_saved_open_link'), ENT_QUOTES) ?></a>
                        </div>
                        <?php else: ?>
                        <div class="empty-state">
                            <?= htmlspecialchars(t('account_saved_empty_prefix'), ENT_QUOTES) ?> <a class="section__link" href="catalog.php"><?= htmlspecialchars(t('saved_empty_link'), ENT_QUOTES) ?></a>.
                        </div>
                        <?php endif; ?>
                    </div>
                </div>
            </div>

            <div class="accordion" id="acc-login-methods">
                <button type="button" class="accordion__header" aria-expanded="false" aria-controls="acc-login-methods-panel">
                    <span class="accordion__title"><?= htmlspecialchars(t('account_social_title'), ENT_QUOTES) ?></span>
                    <span class="accordion__chevron" aria-hidden="true">&#9662;</span>
                </button>
                <div class="accordion__panel" id="acc-login-methods-panel">
                    <div class="accordion__panel-inner">
                        <ul class="login-methods">
                            <li class="login-methods__item">
                                <span class="social-btn__icon" style="background:#ffffff;color:#00032c" aria-hidden="true">***</span>
                                <span class="login-methods__name">
                                    <strong><?= htmlspecialchars(t('account_social_password'), ENT_QUOTES) ?></strong>
                                    <span class="login-methods__meta"><?= htmlspecialchars(t($hasPassword ? 'account_social_password_set' : 'account_social_password_none'), ENT_QUOTES) ?></span>
                                </span>
                            </li>
                            <?php foreach (OAUTH_PROVIDERS as $providerKey => $providerInfo):
                                $linked = $socialLinked[$providerKey] ?? null;
                                if ($linked === null && !oauth_provider_enabled($providerKey)) {
                                    continue; // ще не підключений на сайті й не прив'язаний — не показуємо
                                } ?>
                            <li class="login-methods__item">
                                <?= oauth_icon_html($providerKey) ?>
                                <span class="login-methods__name">
                                    <strong><?= e($providerInfo['label']) ?></strong>
                                    <span class="login-methods__meta">
                                        <?php if ($linked !== null): ?>
                                            <?= e(sprintf(t('account_social_connected'), date('d.m.Y', strtotime((string) $linked['connected_at'])))) ?><?= $linked['email'] ? ' · ' . e($linked['email']) : '' ?>
                                        <?php else: ?>
                                            <?= htmlspecialchars(t('account_social_not_connected'), ENT_QUOTES) ?>
                                        <?php endif; ?>
                                    </span>
                                </span>
                                <?php if ($linked !== null): ?>
                                    <form class="login-methods__form" method="post" action="account.php">
                                        <input type="hidden" name="action" value="unlink_social">
                                        <input type="hidden" name="provider" value="<?= e($providerKey) ?>">
                                        <input type="hidden" name="csrf" value="<?= e(social_csrf_token()) ?>">
                                        <button type="submit" class="btn btn--ghost btn--small"<?= $loginMethods <= 1 ? ' disabled title="' . e(t('account_social_last_method')) . '"' : '' ?>><?= htmlspecialchars(t('account_social_unlink'), ENT_QUOTES) ?></button>
                                    </form>
                                <?php else: ?>
                                    <a class="btn btn--ghost btn--small" href="auth-<?= e($providerKey) ?>.php?mode=link"><?= htmlspecialchars(t('account_social_link'), ENT_QUOTES) ?></a>
                                <?php endif; ?>
                            </li>
                            <?php endforeach; ?>
                        </ul>
                        <?php if ($loginMethods <= 1 && $socialLinked !== []): ?>
                            <p class="login-methods__hint"><?= htmlspecialchars(t('account_social_last_method'), ENT_QUOTES) ?></p>
                        <?php endif; ?>
                        <p class="login-methods__hint"><?= htmlspecialchars(t('account_social_email_hint'), ENT_QUOTES) ?></p>
                    </div>
                </div>
            </div>

            <?php // ТЕРМІНОВО приховано: подача заявки "Стати працівником" для user.
            // Секцію не видалено — лише вимкнено умовою, щоб легко повернути.
            if (false && $user['role'] === 'user'): ?>
                <div class="section">
                    <h2 class="section__title">Стати працівником</h2>
                    <?php if ($pendingRequest !== null): ?>
                        <div class="empty-state">
                            Ваша заявка на розгляді (подана
                            <?= e(date('d.m.Y', (int) strtotime((string) $pendingRequest['created_at']))) ?>).
                            Ми повідомимо про рішення адміністратора.
                        </div>
                    <?php else: ?>
                        <?php if ($requestErrors !== []): ?>
                            <div class="notice">
                                <ul>
                                    <?php foreach ($requestErrors as $err): ?>
                                        <li><?= e($err) ?></li>
                                    <?php endforeach; ?>
                                </ul>
                            </div>
                        <?php endif; ?>
                        <p class="section__hint">
                            Заповніть прізвище та ім’я — заявку розгляне адміністратор.
                        </p>
                        <form method="post" action="account.php" novalidate>
                            <input type="hidden" name="action" value="employee_request">
                            <div class="form-row">
                                <div class="field">
                                    <label class="field__label" for="last_name">Прізвище</label>
                                    <input class="input" type="text" id="last_name" name="last_name" value="<?= e($oldRequest['last_name']) ?>" maxlength="255" required>
                                </div>
                                <div class="field">
                                    <label class="field__label" for="first_name">Ім’я</label>
                                    <input class="input" type="text" id="first_name" name="first_name" value="<?= e($oldRequest['first_name']) ?>" maxlength="255" required>
                                </div>
                            </div>
                            <button type="submit" class="btn btn--primary">Подати заявку</button>
                        </form>
                    <?php endif; ?>
                </div>
            <?php endif; ?>

            <?php if ($user['role'] === 'admin'): ?>
                <div class="accordion" id="acc-stats">
                    <button type="button" class="accordion__header" aria-expanded="false" aria-controls="acc-stats-panel">
                        <span class="accordion__title"><?= htmlspecialchars(t('account_stats_accordion_title'), ENT_QUOTES) ?></span>
                        <span class="accordion__chevron" aria-hidden="true">&#9662;</span>
                    </button>
                    <div class="accordion__panel" id="acc-stats-panel">
                        <div class="accordion__panel-inner">
                            <p><a class="section__link" href="admin-stats.php"><?= htmlspecialchars(t('account_site_stats_link'), ENT_QUOTES) ?></a></p>
                            <div class="summary">
                                <span><?= htmlspecialchars(t('stats_total_label'), ENT_QUOTES) ?>: <strong><?= (int) $userStats['total'] ?></strong></span>
                                <span><?= htmlspecialchars(t('stats_users_label'), ENT_QUOTES) ?> (user): <strong><?= (int) $userStats['users'] ?></strong></span>
                                <span><?= htmlspecialchars(t('stats_employees_label'), ENT_QUOTES) ?> (employee): <strong><?= (int) $userStats['employees'] ?></strong></span>
                                <span><?= htmlspecialchars(t('stats_admins_label'), ENT_QUOTES) ?> (admin): <strong><?= (int) $userStats['admins'] ?></strong></span>
                                <span><?= htmlspecialchars(t('stats_pending_label'), ENT_QUOTES) ?>
                                    <strong><a class="section__link" href="#requests" data-accordion-jump="requests"><?= count($mergedRequests) ?></a></strong>
                                </span>
                            </div>

                            <?php if ($staffEmployees !== []): ?>
                                <h3 class="section__subtitle"><?= htmlspecialchars(t('account_staff_employees_title'), ENT_QUOTES) ?></h3>
                                <ul class="request-list">
                                    <?php foreach ($staffEmployees as $emp): ?>
                                        <?php
                                        $empName = trim((string) ($emp['last_name'] ?? '') . ' ' . (string) ($emp['first_name'] ?? ''));
                                        if ($empName === '') {
                                            $empName = (string) $emp['name'];
                                        }
                                        ?>
                                        <li class="request-card">
                                            <div>
                                                <strong>
                                                    <?php if ($emp['employee_number'] !== null): ?>№<?= (int) $emp['employee_number'] ?> · <?php endif; ?><?= e($empName) ?>
                                                </strong>
                                                <span class="request-card__meta">
                                                    <?= e($emp['email']) ?>
                                                    <?php if (!empty($emp['role_since'])): ?>
                                                        <?= htmlspecialchars(t('account_role_since_prefix'), ENT_QUOTES) ?> <?= e(date('d.m.Y', (int) strtotime((string) $emp['role_since']))) ?>
                                                    <?php endif; ?>
                                                </span>
                                            </div>
                                        </li>
                                    <?php endforeach; ?>
                                </ul>
                            <?php endif; ?>

                            <?php if ($staffAdmins !== []): ?>
                                <h3 class="section__subtitle"><?= htmlspecialchars(t('account_staff_admins_title'), ENT_QUOTES) ?></h3>
                                <ul class="request-list">
                                    <?php foreach ($staffAdmins as $adm): ?>
                                        <li class="request-card">
                                            <div>
                                                <strong><?= e($adm['name']) ?></strong>
                                                <span class="request-card__meta"><?= e($adm['email']) ?></span>
                                            </div>
                                        </li>
                                    <?php endforeach; ?>
                                </ul>
                            <?php endif; ?>
                        </div>
                    </div>
                </div>

                <div class="accordion" id="requests">
                    <button type="button" class="accordion__header" aria-expanded="false" aria-controls="requests-panel">
                        <span class="accordion__title"><?= htmlspecialchars(t('account_requests_title'), ENT_QUOTES) ?></span>
                        <span class="accordion__chevron" aria-hidden="true">&#9662;</span>
                    </button>
                    <div class="accordion__panel" id="requests-panel">
                        <div class="accordion__panel-inner">
                            <?php if ($mergedRequests === []): ?>
                                <div class="empty-state"><?= htmlspecialchars(t('account_admin_requests_empty'), ENT_QUOTES) ?></div>
                            <?php else: ?>
                                <ul class="request-list">
                                    <?php foreach ($mergedRequests as $req): ?>
                                        <li class="request-card">
                                            <div>
                                                <strong>
                                                    <?= e($req['title']) ?><span class="request-type-badge"><?= e($req['type_label']) ?></span>
                                                </strong>
                                                <span class="request-card__meta">
                                                    <?php if ($req['meta_name'] !== ''): ?>
                                                        <?= e($req['meta_name']) ?> ·
                                                    <?php endif; ?>
                                                    <?= e($req['meta_email']) ?>
                                                    <?php if ($req['meta_phone'] !== null): ?>
                                                        · <?= e($req['meta_phone']) ?>
                                                    <?php endif; ?>
                                                    <?= htmlspecialchars(t('account_requested_prefix'), ENT_QUOTES) ?> <?= e(date('d.m.Y', (int) strtotime($req['requested_at']))) ?>
                                                </span>
                                            </div>
                                            <?php if ($req['kind'] === 'employee'): ?>
                                                <form method="post" action="account.php">
                                                    <input type="hidden" name="action" value="approve_request">
                                                    <input type="hidden" name="request_id" value="<?= (int) $req['request_id'] ?>">
                                                    <button type="submit" class="btn btn--approve"><?= htmlspecialchars(t('action_approve'), ENT_QUOTES) ?></button>
                                                </form>
                                            <?php elseif ($req['can_decide']): ?>
                                                <div class="btn-row">
                                                    <?php if (!$req['slots_full']): ?>
                                                        <form method="post" action="account.php">
                                                            <input type="hidden" name="action" value="approve_admin_request">
                                                            <input type="hidden" name="request_id" value="<?= (int) $req['request_id'] ?>">
                                                            <button type="submit" class="btn btn--approve"><?= htmlspecialchars(t('action_approve'), ENT_QUOTES) ?></button>
                                                        </form>
                                                    <?php else: ?>
                                                        <span class="request-card__meta"><?= htmlspecialchars(t('account_admin_position_full_note'), ENT_QUOTES) ?></span>
                                                    <?php endif; ?>
                                                    <form method="post" action="account.php">
                                                        <input type="hidden" name="action" value="reject_admin_request">
                                                        <input type="hidden" name="request_id" value="<?= (int) $req['request_id'] ?>">
                                                        <button type="submit" class="btn btn--ghost"><?= htmlspecialchars(t('action_reject'), ENT_QUOTES) ?></button>
                                                    </form>
                                                </div>
                                            <?php else: ?>
                                                <span class="request-card__meta"><?= htmlspecialchars(t('account_admin_request_owner_only_note'), ENT_QUOTES) ?></span>
                                            <?php endif; ?>
                                        </li>
                                    <?php endforeach; ?>
                                </ul>
                            <?php endif; ?>
                        </div>
                    </div>
                </div>

                <div class="accordion" id="acc-position">
                    <button type="button" class="accordion__header" aria-expanded="false" aria-controls="acc-position-panel">
                        <span class="accordion__title"><?= htmlspecialchars(t('account_position_apps_title'), ENT_QUOTES) ?></span>
                        <span class="accordion__chevron" aria-hidden="true">&#9662;</span>
                    </button>
                    <div class="accordion__panel" id="acc-position-panel">
                        <div class="accordion__panel-inner">
                            <?php if (account_is_owner($user)): ?>
                                <h3 class="section__subtitle"><?= htmlspecialchars(t('account_create_position_link_title'), ENT_QUOTES) ?></h3>
                                <form method="post" action="account.php" novalidate>
                                    <input type="hidden" name="action" value="create_position_application">
                                    <div class="field">
                                        <label class="field__label" for="position_title"><?= htmlspecialchars(t('position_title_field'), ENT_QUOTES) ?></label>
                                        <input class="input" type="text" id="position_title" name="position_title" maxlength="255" required>
                                    </div>
                                    <button type="submit" class="btn btn--primary"><?= htmlspecialchars(t('create_position_link_submit'), ENT_QUOTES) ?></button>
                                </form>
                            <?php endif; ?>

                            <?php if ($positionApplications === []): ?>
                                <div class="empty-state"><?= htmlspecialchars(t('account_position_apps_empty'), ENT_QUOTES) ?></div>
                            <?php else: ?>
                                <?php
                                $positionStatusLabels = [
                                    'pending' => t('position_apps_status_pending'),
                                    'submitted' => t('position_apps_status_submitted'),
                                    'confirmed' => t('position_apps_status_confirmed'),
                                ];
                                ?>
                                <ul class="request-list">
                                    <?php foreach ($positionApplications as $app): ?>
                                        <?php
                                        $appCandidate = trim((string) ($app['last_name'] ?? '') . ' ' . (string) ($app['first_name'] ?? ''));
                                        $appStatusLabel = $positionStatusLabels[$app['status']] ?? $app['status'];
                                        ?>
                                        <li class="request-card">
                                            <div>
                                                <strong><?= e($app['position_title']) ?> — <?= e($appStatusLabel) ?></strong>
                                                <span class="request-card__meta">
                                                    <?php if ($appCandidate !== ''): ?>
                                                        <?= e($appCandidate) ?> ·
                                                    <?php endif; ?>
                                                    <?php if (!empty($app['email'])): ?>
                                                        <?= e($app['email']) ?>
                                                        <?php if (!empty($app['phone'])): ?> · <?= e($app['phone']) ?><?php endif; ?> ·
                                                    <?php endif; ?>
                                                    <?php if (!empty($app['submitted_at'])): ?>
                                                        <?= htmlspecialchars(t('position_apps_col_submitted'), ENT_QUOTES) ?> <?= e(date('d.m.Y', (int) strtotime((string) $app['submitted_at']))) ?>
                                                    <?php else: ?>
                                                        <?= e(date('d.m.Y', (int) strtotime((string) $app['created_at']))) ?>
                                                    <?php endif; ?>
                                                </span>
                                            </div>
                                            <?php if ($app['status'] === 'submitted'): ?>
                                                <form method="post" action="account.php">
                                                    <input type="hidden" name="action" value="confirm_position_application">
                                                    <input type="hidden" name="application_id" value="<?= (int) $app['id'] ?>">
                                                    <button type="submit" class="btn btn--approve"><?= htmlspecialchars(t('action_confirm_application'), ENT_QUOTES) ?></button>
                                                </form>
                                            <?php endif; ?>
                                        </li>
                                    <?php endforeach; ?>
                                </ul>
                            <?php endif; ?>
                        </div>
                    </div>
                </div>

                <?php // ТЕРМІНОВО приховано: секція перегляду/схвалення заявок на працівника.
                // Не видалено — лише умова false, щоб легко повернути.
                if (false): ?>
                <div class="section" id="employee-requests">
                    <h2 class="section__title">Заявки на працівника</h2>
                    <?php if ($pendingRequests === []): ?>
                        <div class="empty-state">Немає заявок на розгляді.</div>
                    <?php else: ?>
                        <ul class="request-list">
                            <?php foreach ($pendingRequests as $req): ?>
                                <li class="request-card">
                                    <div>
                                        <strong><?= e($req['last_name'] . ' ' . $req['first_name']) ?></strong>
                                        <span class="request-card__meta">
                                            <?= e($req['user_name']) ?> · <?= e($req['user_email']) ?>
                                            · подано <?= e(date('d.m.Y', (int) strtotime((string) $req['created_at']))) ?>
                                        </span>
                                    </div>
                                    <form method="post" action="account.php">
                                        <input type="hidden" name="action" value="approve_request">
                                        <input type="hidden" name="request_id" value="<?= (int) $req['id'] ?>">
                                        <button type="submit" class="btn btn--approve">Схвалити</button>
                                    </form>
                                </li>
                            <?php endforeach; ?>
                        </ul>
                    <?php endif; ?>
                </div>
                <?php endif; ?>
            <?php endif; ?>

            <?php if (auth_has_role('employee', 'admin')): ?>
                <div class="accordion" id="acc-crm">
                    <button type="button" class="accordion__header" aria-expanded="false" aria-controls="acc-crm-panel">
                        <span class="accordion__title"><?= htmlspecialchars(t('account_crm_section_title'), ENT_QUOTES) ?></span>
                        <span class="accordion__chevron" aria-hidden="true">&#9662;</span>
                    </button>
                    <div class="accordion__panel" id="acc-crm-panel">
                        <div class="accordion__panel-inner">
                            <div class="staff-note">
                                <?= htmlspecialchars(t('account_crm_access_prefix'), ENT_QUOTES) ?> <a href="crm-list.php"><?= htmlspecialchars(t('account_crm_list_link'), ENT_QUOTES) ?></a>
                                · <a href="crm-add-product.php"><?= htmlspecialchars(t('account_crm_add_link'), ENT_QUOTES) ?></a><?php if (auth_role() === 'admin'): ?>
                                · <a href="crm-ads-list.php"><?= htmlspecialchars(t('account_crm_ads_link'), ENT_QUOTES) ?></a><?php endif; ?>.
                            </div>
                        </div>
                    </div>
                </div>
            <?php endif; ?>

            <div class="btn-row">
                <a class="btn btn--ghost" href="logout.php"><?= htmlspecialchars(t('account_logout'), ENT_QUOTES) ?></a>
            </div>
        </section>

        <button type="button" id="accordionBackBtn" class="accordion-back" hidden>
            <span class="accordion-back__chevron" aria-hidden="true">&#9652;</span>
            <span class="accordion-back__label"><?= htmlspecialchars(t('account_accordion_collapse'), ENT_QUOTES) ?></span>
        </button>

        <script>
        (function () {
            var accordions = Array.prototype.slice.call(document.querySelectorAll('.accordion'));
            var backBtn = document.getElementById('accordionBackBtn');
            if (accordions.length === 0 || !backBtn) {
                return;
            }
            var backLabelBase = backBtn.querySelector('.accordion-back__label').textContent;

            function setExpanded(acc, isOpen) {
                var header = acc.querySelector('.accordion__header');
                acc.classList.toggle('is-open', isOpen);
                if (header) {
                    header.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
                }
            }

            function updateBackBtn(openAcc) {
                if (openAcc) {
                    var titleEl = openAcc.querySelector('.accordion__title');
                    var label = titleEl ? titleEl.textContent : '';
                    backBtn.querySelector('.accordion-back__label').textContent = label
                        ? backLabelBase + ' — ' + label
                        : backLabelBase;
                    backBtn.dataset.target = openAcc.id;
                    backBtn.hidden = false;
                } else {
                    backBtn.hidden = true;
                    delete backBtn.dataset.target;
                }
            }

            function closeAll(except) {
                accordions.forEach(function (acc) {
                    if (acc !== except) {
                        setExpanded(acc, false);
                    }
                });
            }

            function openAccordion(acc) {
                closeAll(acc);
                setExpanded(acc, true);
                updateBackBtn(acc);
            }

            accordions.forEach(function (acc) {
                var header = acc.querySelector('.accordion__header');
                if (!header) {
                    return;
                }
                header.addEventListener('click', function () {
                    if (acc.classList.contains('is-open')) {
                        setExpanded(acc, false);
                        updateBackBtn(null);
                    } else {
                        openAccordion(acc);
                    }
                });
            });

            backBtn.addEventListener('click', function () {
                var id = backBtn.dataset.target;
                var acc = id ? document.getElementById(id) : null;
                if (acc) {
                    setExpanded(acc, false);
                    acc.scrollIntoView({ behavior: 'smooth', block: 'start' });
                }
                updateBackBtn(null);
            });

            function openFromHash() {
                var hash = window.location.hash.replace('#', '');
                if (!hash) {
                    return;
                }
                var target = document.getElementById(hash);
                if (target && target.classList.contains('accordion')) {
                    openAccordion(target);
                    window.setTimeout(function () {
                        target.scrollIntoView({ behavior: 'smooth', block: 'start' });
                    }, 50);
                }
            }

            document.querySelectorAll('[data-accordion-jump]').forEach(function (link) {
                link.addEventListener('click', function (event) {
                    var id = link.getAttribute('data-accordion-jump');
                    var target = id ? document.getElementById(id) : null;
                    if (target) {
                        event.preventDefault();
                        openAccordion(target);
                        target.scrollIntoView({ behavior: 'smooth', block: 'start' });
                    }
                });
            });

            window.addEventListener('hashchange', openFromHash);
            openFromHash();
        })();
        </script>
<?php endif; ?>
    </div>
    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
