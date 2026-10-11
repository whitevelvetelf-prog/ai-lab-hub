<?php

declare(strict_types=1);

/**
 * AI LAB HUB — загальні налаштування сайту (таблиця site_settings: ключ → значення).
 *
 * Для налаштувань, які адмін змінює в кабінеті й які не мають належати коду
 * чи git (напр. реквізити донатів). Реклама має власну таблицю ad_settings.
 * Схема — database/migration-2026-10-11-site-settings.sql. Якщо таблиці ще
 * немає (міграцію не застосовано) — читання повертає порожньо, сайт не падає.
 */

/** @return array<string,string> */
function site_settings(PDO $pdo, bool $refresh = false): array
{
    static $cache = null;
    if ($cache !== null && !$refresh) {
        return $cache;
    }
    try {
        $cache = array_map('strval', $pdo->query('SELECT setting_key, setting_value FROM site_settings')->fetchAll(PDO::FETCH_KEY_PAIR));
    } catch (Throwable $e) {
        error_log('[site_settings] ' . $e->getMessage());
        $cache = [];
    }

    return $cache;
}

function site_setting(PDO $pdo, string $key, string $default = ''): string
{
    return site_settings($pdo)[$key] ?? $default;
}

/** @param array<string,string> $values */
function site_settings_save(PDO $pdo, array $values): void
{
    // Усі значення разом або жодне (транзакція): форма не зберігається наполовину.
    $pdo->beginTransaction();
    try {
        $st = $pdo->prepare(
            'INSERT INTO site_settings (setting_key, setting_value) VALUES (:k, :v)
             ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value)'
        );
        foreach ($values as $k => $v) {
            $st->execute([':k' => $k, ':v' => $v]);
        }
        $pdo->commit();
    } catch (Throwable $e) {
        $pdo->rollBack();
        throw $e;
    }
    site_settings($pdo, true);
}
