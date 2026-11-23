<?php

declare(strict_types=1);

/**
 * Багвіль — місії. Таблиці місій ще немає (з основного завдання, docs/bugville/MAIN_TASK.md), тому поки:
 *   * демо-місія 900001 (зразковий генератор vending_boundary) — лише коли 'bugville_demo' => true (локально);
 *   * справжні місії тут з'являться разом із bv_missions.
 */

require_once __DIR__ . '/bv-variants.php';

const BV_DEMO_MISSION = 900001;

function bv_load_missions(): void
{
    static $done = false;
    if ($done) {
        return;
    }
    $done = true;
    if (bv_cfg('bugville_demo') === true) {
        bv_register_mission(['id' => BV_DEMO_MISSION, 'variant_mode' => 'generator', 'generator_key' => 'vending_boundary',
            'generator_json' => ['min_from' => 1, 'min_to' => 10, 'max_from' => 20, 'max_to' => 100]]);
    }
}
