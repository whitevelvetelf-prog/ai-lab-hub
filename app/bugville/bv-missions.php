<?php

declare(strict_types=1);

/**
 * Багвіль — місії. Таблиці місій ще немає (крок «Контент», docs/bugville/MAIN_TASK.md), тому реєстр у памʼяті:
 *   * місії світу (app/bugville/bv-world.php), для яких є генератор;
 *   * демо-місія 900001 (зразковий генератор vending_boundary) — лише коли 'bugville_demo' => true (локально, для тестів API).
 */

require_once __DIR__ . '/bv-world.php';

const BV_DEMO_MISSION = 900001;

/** $pdo — щоб зареєструвати місії з пулом (pool / mixed); без нього — лише генератори. */
function bv_load_missions(?PDO $pdo = null): void
{
    static $done = false;
    if ($done) {
        return;
    }
    $done = true;
    bv_register_world_missions($pdo);
    if (bv_cfg('bugville_demo') === true) {
        bv_register_mission(['id' => BV_DEMO_MISSION, 'variant_mode' => 'generator', 'generator_key' => 'vending_boundary',
            'generator_json' => ['min_from' => 1, 'min_to' => 10, 'max_from' => 20, 'max_to' => 100]]);
    }
}
