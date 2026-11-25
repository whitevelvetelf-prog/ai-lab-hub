<?php

declare(strict_types=1);

/**
 * Багвіль — налаштування, допустимі значення VARCHAR-полів (замість ENUM), час UTC, детермінований RNG.
 */

const BV_VARIANT_MODES = ['generator', 'pool', 'mixed'];
const BV_VARIANT_STATUSES = ['draft', 'active', 'off'];
const BV_ATTEMPT_KINDS = ['mission', 'exam', 'daily'];
const BV_LANGS = ['uk'];   // англійська — пізніше (лише додати сюди й рядки в bv_strings / варіанти з lang = 'en')

/** Значення з config/bugville.php + config/bugville.local.php (+ підміни з тестів). */
function bv_cfg(string $key): mixed
{
    return bv_cfg_all()[$key] ?? null;
}

/** @return array<string,mixed> */
function bv_cfg_all(): array
{
    static $cfg = null;
    if ($cfg === null) {
        $root = dirname(__DIR__, 2) . '/config/';
        $cfg = is_file($root . 'bugville.php') ? (array) require $root . 'bugville.php' : [];
        if (is_file($root . 'bugville.local.php')) {
            $cfg = array_merge($cfg, (array) require $root . 'bugville.local.php');
        }
    }

    return array_merge($cfg, $GLOBALS['bv_cfg_override'] ?? []);
}

function bv_valid_mode(string $mode): bool
{
    return in_array($mode, BV_VARIANT_MODES, true);
}

function bv_valid_status(string $status): bool
{
    return in_array($status, BV_VARIANT_STATUSES, true);
}

function bv_valid_kind(string $kind): bool
{
    return in_array($kind, BV_ATTEMPT_KINDS, true);
}

function bv_lang(?string $lang): string
{
    $lang = (string) $lang;

    return in_array($lang, BV_LANGS, true) ? $lang : (string) (bv_cfg('bugville_default_lang') ?: 'uk');
}

/** Поточний час UTC для полів bv_* (веб і cron однаково). */
function bv_now(int $offsetSeconds = 0): string
{
    return gmdate('Y-m-d H:i:s', time() + $offsetSeconds);
}

/** HMAC IP із сіллю; без солі — null (IP не зберігається й не рахується). */
function bv_ip_hash(string $ip): ?string
{
    $salt = (string) bv_cfg('bugville_ip_salt');
    if (strlen($salt) < 16 || $ip === '') {
        return null;
    }

    return hash_hmac('sha256', $ip, $salt);
}

/**
 * Детермінований генератор випадкових чисел від seed: той самий seed → та сама поломка.
 * Без глобального стану (mt_srand не чіпаємо).
 */
final class BvRng
{
    private int $n = 0;

    public function __construct(private readonly string $seed)
    {
    }

    public function next32(): int
    {
        return unpack('N', hash('sha256', $this->seed . ':' . $this->n++, true))[1];
    }

    public function int(int $min, int $max): int
    {
        if ($max <= $min) {
            return $min;
        }

        return $min + ($this->next32() % ($max - $min + 1));
    }

    /** @template T @param array<T> $items @return T */
    public function pick(array $items): mixed
    {
        $items = array_values($items);

        return $items[$this->int(0, count($items) - 1)];
    }

    /** @template T @param array<T> $items @return list<T> */
    public function shuffle(array $items): array
    {
        $items = array_values($items);
        for ($i = count($items) - 1; $i > 0; $i--) {
            $j = $this->int(0, $i);
            [$items[$i], $items[$j]] = [$items[$j], $items[$i]];
        }

        return $items;
    }
}
