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
    // Нагороди (docs/bugville/MAIN_TASK.md, розділ 6). Зірки: 3 — з першої спроби без підказки, 2 — з підказкою або з
    // другої спроби, 1 — пізніше. XP місії = base + per_extra_star × (зірки − 1). Монети — лише акаунтам.
    'bugville_xp_mission_base' => 10,
    'bugville_xp_per_extra_star' => 5,
    'bugville_coins_mission' => 5,
    'bugville_coins_three_stars_bonus' => 5,
    // Повтор місії: нагорода лише за покращення найкращого результату (різниця), щоб повтори не стали «фермою балів».
    'bugville_reward_improvement_only' => true,
    // Іспит рівня (крок «Іспити»): прохідний бал, %; повтор не раніше ніж через N хвилин; нагорода.
    'bugville_exam_tasks' => 5,   // завдань в іспиті; пул за вагою — не менше 3 × цього числа
    'bugville_exam_pass_percent' => 70,
    'bugville_exam_retry_minutes' => 60,
    'bugville_exam_xp' => 50,
    'bugville_exam_coins' => 30,
    // Сторінки гри (bugville*.php) для всіх; false — лише для admin (на хостингу, доки місії не наповнені кроком «Контент»).
    'bugville_public' => false,
    // Демо-місія 900001 (зразковий генератор) для локальної перевірки API; на хостингу — false.
    // Локально також грається як місія 1.5 «Остання монета» на карті (app/bugville/bv-world.php).
    'bugville_demo' => false,
    // Строк дії токена спроби (хв) і скільки годин зберігати незараховані спроби гостей (не менше 24).
    'bugville_attempt_ttl_minutes' => 120,
    'bugville_guest_attempt_keep_hours' => 24,
    // Мова за замовчуванням (поки лише uk).
    'bugville_default_lang' => 'uk',
    'bugville_ip_salt' => '',
];
