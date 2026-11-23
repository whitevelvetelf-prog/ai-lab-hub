<?php

/**
 * AI LAB HUB — налаштування гри «Багвіль» (app/bugville/). Файл у git, секретів немає.
 * Сіль для хешу IP — лише в config/bugville.local.php (не в git): ['bugville_ip_salt' => '<64 hex>'].
 * Без солі гра IP не записує (ip_hash = NULL) і ліміт перевірок на IP вимкнено.
 */

return [
    // Акаунт гри (збереження прогресу, іспити, грамоти) — лише від цього віку; підтвердження — чекбокс / разово в грі.
    'bugville_min_age_for_account' => 16,
    // Перевірок відповіді за хвилину: на гравця або сесію гостя, і на IP (значно більше — клас школи за одним IP).
    'bugville_checks_per_min_player' => 30,
    'bugville_checks_per_min_ip' => 600,
    // Зарахування гостьових спроб після входу: не більше за один вхід і на акаунт за добу.
    'bugville_credit_max_per_login' => 20,
    'bugville_credit_max_per_day' => 50,
    // Запусків місій за хвилину (кожен запуск створює спробу): на гравця / сесію і на IP.
    'bugville_starts_per_min_player' => 60,
    'bugville_starts_per_min_ip' => 1200,
    // Нагорода за правильну відповідь — ПОПЕРЕДНЬО, до правил з основного завдання (XP, монети; зірки — з перевірки).
    'bugville_reward_xp' => 30,
    'bugville_reward_coins' => 0,
    // Демо-місія 900001 (зразковий генератор) для локальної перевірки API; на хостингу — false.
    'bugville_demo' => false,
    // Строк дії токена спроби (хв) і скільки годин зберігати незараховані спроби гостей (не менше 24).
    'bugville_attempt_ttl_minutes' => 120,
    'bugville_guest_attempt_keep_hours' => 24,
    // Мова за замовчуванням (поки лише uk).
    'bugville_default_lang' => 'uk',
    'bugville_ip_salt' => '',
];
