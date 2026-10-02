-- AI LAB HUB — 2026-10-02: вхід/реєстрація через соцмережі (OAuth).
--
-- social_accounts — прив'язки акаунтів провайдерів до users. Один user може мати
-- кілька рядків (по одному на провайдера). Пара (provider, provider_user_id)
-- унікальна: один акаунт Google не можна прив'язати до двох користувачів.
-- Код: app/oauth.php, public/auth-google.php, public/auth-google-callback.php, public/account.php.
--
-- Користувачі, створені через Google, мають password_hash = '' (порожній рядок):
-- password_verify() для нього завжди false, тож вхід паролем для них неможливий,
-- доки вони не встановлять пароль. Схему users не змінюємо.
--
-- Застосування: phpMyAdmin → SQL → вставити → Вперёд. Повторний запуск безпечний.
SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS social_accounts (
    id               INT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id          INT UNSIGNED NOT NULL,
    provider         ENUM('google','facebook','apple','linkedin','x','discord') NOT NULL,
    provider_user_id VARCHAR(255) NOT NULL,
    email            VARCHAR(255) NULL,
    connected_at     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_social_provider_user (provider, provider_user_id),
    UNIQUE KEY uq_social_user_provider (user_id, provider),
    KEY idx_social_user (user_id),
    CONSTRAINT fk_social_accounts_user
        FOREIGN KEY (user_id) REFERENCES users (id)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT IGNORE INTO `ui_translations` (`key_name`, `lang`, `translated_text`, `source`) VALUES
('social_or_login', 'en', 'Or sign in with', 'manual'),
('social_or_register', 'en', 'Or sign up with', 'manual'),
('social_soon', 'en', 'Coming soon', 'manual'),
('social_error_generic', 'en', 'Could not sign in with %s. Please try again.', 'manual'),
('social_error_unverified', 'en', '%s has not verified this email address, so we cannot link it to an account.', 'manual'),
('social_error_taken', 'en', 'This %s account is already linked to another user.', 'manual'),
('social_error_disabled', 'en', 'Sign-in with %s is not available yet.', 'manual'),
('account_social_title', 'en', 'Sign-in methods', 'manual'),
('account_social_password', 'en', 'Password', 'manual'),
('account_social_password_set', 'en', 'Set', 'manual'),
('account_social_password_none', 'en', 'Not set', 'manual'),
('account_social_connected', 'en', 'Linked %s', 'manual'),
('account_social_not_connected', 'en', 'Not linked', 'manual'),
('account_social_unlink', 'en', 'Unlink', 'manual'),
('account_social_link', 'en', 'Link', 'manual'),
('account_social_last_method', 'en', 'This is your only sign-in method, so it cannot be unlinked.', 'manual'),
('account_social_email_hint', 'en', 'You can also always sign in with a link sent to your email (“Forgot password?”).', 'manual'),
('account_social_linked_flash', 'en', '%s is now linked to your account.', 'manual'),
('account_social_unlinked_flash', 'en', '%s has been unlinked from your account.', 'manual');
