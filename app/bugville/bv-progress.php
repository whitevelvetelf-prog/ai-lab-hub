<?php

declare(strict_types=1);

/**
 * Багвіль — звання, значки, щоденна серія (MAIN_TASK, розділ 6). Лише для акаунтів із підтвердженим віком; рахує сервер.
 *
 * Звання: bv_ranks (назва й поріг XP редагуються в CRM), звання гравця — найбільший min_xp ≤ XP.
 * Значки: умова — у коді за badge_key (bv_badge_conditions), поріг — bv_badges.param; видаються один раз (bv_user_badges).
 * Серія (мʼяка): день зараховує лише здана «Поломка дня» (app/bugville/bv-daily.php), дата — за bugville_daily_timezone;
 * пропуск одного дня на ISO-тиждень не обриває серію (вихідний; grace_week — тиждень, де його вже використано;
 * config bugville_streak_rest_per_week), інакше серія починається знову з 1; рекорд (best_days) не зменшується.
 * Початкові назви й пороги — bv_ranks_content() / bv_badges_content(), у БД їх пише сид tools/bugville-seed.php.
 */

require_once __DIR__ . '/bv-exam.php';

/** Звання за замовчуванням (MAIN_TASK, розділ 6). @return list<array{key:string, title:string, min_xp:int}> */
function bv_ranks_content(): array
{
    return [
        ['key' => 'seeker', 'title' => 'Учень-шукач', 'min_xp' => 0],
        ['key' => 'helper', 'title' => 'Помічник майстра', 'min_xp' => 100],
        ['key' => 'master', 'title' => 'Майстер дрібниць', 'min_xp' => 300],
        ['key' => 'senior', 'title' => 'Старший майстер', 'min_xp' => 600],
        ['key' => 'chief', 'title' => 'Головний майстер Багвіля', 'min_xp' => 1000],
    ];
}

/** Значки за замовчуванням: key, назва, опис ({n} — поріг), поріг. @return list<array> */
function bv_badges_content(): array
{
    return [
        ['key' => 'first_bug', 'title' => 'Перша поломка', 'description' => 'Знайдено першу поломку.', 'param' => null],
        ['key' => 'three_stars', 'title' => 'Три зірки', 'description' => 'Місію пройдено на три зірки.', 'param' => null],
        ['key' => 'streak', 'title' => 'Серія {n} дні', 'description' => 'Грати {n} дні поспіль.', 'param' => 3],
        ['key' => 'streak_7', 'title' => 'Тиждень пошуків', 'description' => 'Поломка дня — {n} днів поспіль. Так тримати!', 'param' => 7],
        ['key' => 'streak_14', 'title' => 'Два тижні уважності', 'description' => 'Поломка дня — {n} днів поспіль. Чудова звичка!', 'param' => 14],
        ['key' => 'streak_30', 'title' => 'Місяць майстра', 'description' => 'Поломка дня — {n} днів поспіль. Справжній майстер Багвіля!', 'param' => 30],
        ['key' => 'words_beginner', 'title' => 'Слова-початківець', 'description' => 'Вивчено {n} чарівних слів.', 'param' => 5],
        ['key' => 'level_words', 'title' => 'Усі слова рівня', 'description' => 'Вивчено всі чарівні слова одного рівня.', 'param' => null],
        ['key' => 'level_1', 'title' => 'Автоматник', 'description' => 'Пройдено всі місії рівня «Автомат».', 'param' => null],
        ['key' => 'level_2', 'title' => 'Поштар', 'description' => 'Пройдено всі місії рівня «Пошта».', 'param' => null],
        ['key' => 'level_3', 'title' => 'Бібліотекар', 'description' => 'Пройдено всі місії рівня «Бібліотека».', 'param' => null],
        ['key' => 'no_hints', 'title' => 'Без підказок', 'description' => 'Усі місії рівня пройдено без підказок.', 'param' => null],
        ['key' => 'exam_1', 'title' => 'Іспит: Автомат', 'description' => 'Складено іспит рівня «Автомат».', 'param' => null],
        ['key' => 'exam_2', 'title' => 'Іспит: Пошта', 'description' => 'Складено іспит рівня «Пошта».', 'param' => null],
        ['key' => 'exam_3', 'title' => 'Іспит: Бібліотека', 'description' => 'Складено іспит рівня «Бібліотека».', 'param' => null],
    ];
}

/** Часовий пояс дня гри (config bugville_daily_timezone, за замовчуванням Europe/Kyiv). */
function bv_day_tz(): DateTimeZone
{
    try {
        return new DateTimeZone((string) (bv_cfg('bugville_daily_timezone') ?: 'Europe/Kyiv'));
    } catch (Throwable) {
        return new DateTimeZone('Europe/Kyiv');
    }
}

/** День гри ('Y-m-d') для моменту $at (час UTC, як у bv_now(), або 'now'). */
function bv_day_at(string $at = 'now'): string
{
    return (new DateTimeImmutable($at, new DateTimeZone('UTC')))->setTimezone(bv_day_tz())->format('Y-m-d');
}

/** Сьогодні за bugville_daily_timezone ('Y-m-d'); тести підміняють через $GLOBALS['bv_today']. */
function bv_today(): string
{
    return (string) ($GLOBALS['bv_today'] ?? bv_day_at());
}

/** Скільки пропущених днів на ISO-тиждень не обривають серію (0 або 1). */
function bv_streak_rest_per_week(): int
{
    $v = bv_cfg('bugville_streak_rest_per_week');

    return is_int($v) ? max(0, min(1, $v)) : 1;
}

// ---------- Звання -----------------------------------------------------------------------------------------------

/** Активні звання за зростанням порогу (з БД; якщо таблиці чи рядків немає — значення за замовчуванням). */
function bv_ranks(PDO $pdo, string $lang = 'uk'): array
{
    try {
        $st = $pdo->prepare("SELECT rank_key AS `key`, title, min_xp FROM bv_ranks WHERE lang = :l AND status = 'active' ORDER BY min_xp, rank_key");
        $st->execute([':l' => bv_lang($lang)]);
        $rows = $st->fetchAll(PDO::FETCH_ASSOC);
    } catch (Throwable) {
        $rows = [];
    }
    $rows = $rows !== [] ? $rows : bv_ranks_content();

    return array_map(static fn($r) => ['key' => (string) $r['key'], 'title' => (string) $r['title'], 'min_xp' => (int) $r['min_xp']], $rows);
}

/** Звання для XP: ['rank' => поточне, 'next' => наступне або null, 'to_next' => скільки XP до нього]. */
function bv_rank_for(array $ranks, int $xp): array
{
    $cur = $ranks[0] ?? ['key' => '', 'title' => '', 'min_xp' => 0];
    $next = null;
    foreach ($ranks as $r) {
        if ($r['min_xp'] <= $xp) {
            $cur = $r;
        } elseif ($next === null) {
            $next = $r;
        }
    }

    return ['rank' => $cur, 'next' => $next, 'to_next' => $next === null ? 0 : $next['min_xp'] - $xp];
}

// ---------- Серія ------------------------------------------------------------------------------------------------

/**
 * Зарахувати день серії: здана «Поломка дня» за день $day (за замовчуванням сьогодні). День, не пізніший за останній
 * зарахований, нічого не змінює (повтор того ж дня, здача вчорашньої спроби після опівночі).
 * @return array{current:int, best:int, changed:bool, rested:bool, restarted:bool}
 */
function bv_streak_touch(PDO $pdo, int $userId, ?string $day = null): array
{
    $today = $day ?? bv_today();
    $st = $pdo->prepare('SELECT * FROM bv_streaks WHERE user_id = :u');
    $st->execute([':u' => $userId]);
    $row = $st->fetch(PDO::FETCH_ASSOC) ?: null;
    $cur = (int) ($row['current_days'] ?? 0);
    $best = (int) ($row['best_days'] ?? 0);
    $last = $row['last_day'] ?? null;
    $grace = $row['grace_week'] ?? null;
    if ($last !== null && (string) $last >= $today) {
        return ['current' => $cur, 'best' => $best, 'changed' => false, 'rested' => false, 'restarted' => false];
    }
    $t = new DateTimeImmutable($today);
    $week = $t->format('o-\WW');
    $gap = $last === null ? null : (int) (new DateTimeImmutable((string) $last))->diff($t)->days;
    $rested = false;
    if ($gap === 1) {
        $cur++;
    } elseif ($gap === 2 && $grace !== $week && bv_streak_rest_per_week() > 0) {
        $cur++;            // вихідний: один пропущений день на тиждень серію не обриває
        $grace = $week;
        $rested = true;
    } else {
        $cur = 1;          // нова серія починається сьогодні; рекорд лишається; вихідний цього тижня не повертається
    }
    $restarted = $cur === 1 && $last !== null;
    $best = max($best, $cur);
    $pdo->prepare('INSERT INTO bv_streaks (user_id, current_days, best_days, last_day, grace_week, updated_at)
                   VALUES (:u, :c, :b, :d, :g, :t)
                   ON DUPLICATE KEY UPDATE current_days = VALUES(current_days), best_days = VALUES(best_days),
                       last_day = VALUES(last_day), grace_week = VALUES(grace_week), updated_at = VALUES(updated_at)')
        ->execute([':u' => $userId, ':c' => $cur, ':b' => $best, ':d' => $today, ':g' => $grace, ':t' => bv_now()]);

    return ['current' => $cur, 'best' => $best, 'changed' => true, 'rested' => $rested, 'restarted' => $restarted];
}

/**
 * Серія для показу: якщо останній день був давніше вчора (і вихідний не рятує) — 0. rest_left — чи лишився вихідний
 * цього тижня; today — чи сьогоднішній день уже зараховано.
 */
function bv_streak_view(PDO $pdo, int $userId): array
{
    $st = $pdo->prepare('SELECT current_days, best_days, last_day, grace_week FROM bv_streaks WHERE user_id = :u');
    $st->execute([':u' => $userId]);
    $row = $st->fetch(PDO::FETCH_ASSOC);
    $t = new DateTimeImmutable(bv_today());
    $restLeft = bv_streak_rest_per_week() > 0 && (!$row || $row['grace_week'] !== $t->format('o-\WW'));
    if (!$row || $row['last_day'] === null) {
        return ['current' => 0, 'best' => (int) ($row['best_days'] ?? 0), 'rest_left' => $restLeft, 'today' => false];
    }
    $gap = (int) (new DateTimeImmutable((string) $row['last_day']))->diff($t)->days;
    $alive = $gap <= 1 || ($gap === 2 && $restLeft);

    return ['current' => $alive ? (int) $row['current_days'] : 0, 'best' => (int) $row['best_days'], 'rest_left' => $restLeft,
        'today' => (string) $row['last_day'] === bv_today()];
}

// ---------- Значки -----------------------------------------------------------------------------------------------

/** Значки з БД (з порогами), інакше за замовчуванням. @return array<string, array{key,title,description,param,status}> */
function bv_badges(PDO $pdo, string $lang = 'uk'): array
{
    $rows = [];
    try {
        $st = $pdo->prepare('SELECT badge_key AS `key`, title, description, param, status FROM bv_badges WHERE lang = :l ORDER BY sort, badge_key');
        $st->execute([':l' => bv_lang($lang)]);
        $rows = $st->fetchAll(PDO::FETCH_ASSOC);
    } catch (Throwable) {
        $rows = [];
    }
    if ($rows === []) {
        $rows = array_map(static fn($b) => $b + ['status' => 'active'], bv_badges_content());
    }
    $out = [];
    foreach ($rows as $r) {
        $param = $r['param'] === null ? null : (int) $r['param'];
        $fill = static fn(string $s) => $param === null ? $s : str_replace('{n}', (string) $param, $s);
        $out[(string) $r['key']] = ['key' => (string) $r['key'], 'title' => $fill((string) $r['title']),
            'description' => $fill((string) $r['description']), 'param' => $param, 'status' => (string) $r['status']];
    }

    return $out;
}

/** Факти гравця для умов значків. */
function bv_badge_facts(PDO $pdo, int $userId): array
{
    $st = $pdo->prepare("SELECT mission_id, SUM(stars) FROM bv_xp_log WHERE user_id = :u AND source <> 'exam' AND mission_id < :b GROUP BY mission_id");
    $st->execute([':u' => $userId, ':b' => BV_EXAM_BASE]);
    $stars = array_map('intval', $st->fetchAll(PDO::FETCH_KEY_PAIR) ?: []);
    $st = $pdo->prepare("SELECT DISTINCT mission_id FROM bv_attempts WHERE user_id = :u AND kind = 'mission' AND used = 1 AND score > 0 AND hint_used = 0");
    $st->execute([':u' => $userId]);
    $noHint = array_map('intval', $st->fetchAll(PDO::FETCH_COLUMN) ?: []);
    $words = [];
    try {
        $st = $pdo->prepare('SELECT word_key FROM bv_user_words WHERE user_id = :u');
        $st->execute([':u' => $userId]);
        $words = $st->fetchAll(PDO::FETCH_COLUMN) ?: [];
    } catch (Throwable) {
        $words = [];   // книги слів ще немає
    }

    return ['stars' => $stars, 'no_hint' => $noHint, 'words' => array_map('strval', $words),
        'streak_best' => (int) ($pdo->query('SELECT best_days FROM bv_streaks WHERE user_id = ' . $userId)->fetchColumn() ?: 0)];
}

/** Чи виконано умову значка. */
function bv_badge_met(string $key, ?int $param, array $f, PDO $pdo, int $userId): bool
{
    $levels = [];
    foreach (bv_world() as $ch) {
        foreach ($ch['levels'] as $lv) {
            $levels[(int) $lv['id']] = ['missions' => array_column($lv['missions'], 'id'), 'words' => array_column($lv['missions'], 'word')];
        }
    }
    $solved = static fn(array $ids) => array_filter($ids, static fn($id) => ($f['stars'][$id] ?? 0) > 0) === $ids;

    return match (true) {
        $key === 'first_bug' => array_filter($f['stars']) !== [],
        $key === 'three_stars' => in_array(3, $f['stars'], true) || max([0, ...$f['stars']]) >= 3,
        $key === 'streak', str_starts_with($key, 'streak_') => $f['streak_best'] >= max(1, (int) ($param ?? substr($key, 7))),
        $key === 'words_beginner' => count($f['words']) >= max(1, (int) $param),
        $key === 'level_words' => array_filter($levels, static fn($l) => array_diff($l['words'], $f['words']) === []) !== [],
        str_starts_with($key, 'level_') => isset($levels[(int) substr($key, 6)]) && $solved($levels[(int) substr($key, 6)]['missions']),
        $key === 'no_hints' => array_filter($levels, static fn($l) => array_diff($l['missions'], $f['no_hint']) === []) !== [],
        str_starts_with($key, 'exam_') => bv_exam_passed($pdo, $userId, bv_exam_id((int) substr($key, 5))),
        default => false,
    };
}

/** Видає нові значки, умови яких виконано. @return list<array> щойно отримані */
function bv_badges_check(PDO $pdo, int $userId): array
{
    $st = $pdo->prepare('SELECT badge_key FROM bv_user_badges WHERE user_id = :u');
    $st->execute([':u' => $userId]);
    $have = array_flip($st->fetchAll(PDO::FETCH_COLUMN) ?: []);
    $facts = bv_badge_facts($pdo, $userId);
    $new = [];
    $ins = $pdo->prepare('INSERT IGNORE INTO bv_user_badges (user_id, badge_key, earned_at) VALUES (:u, :k, :t)');
    foreach (bv_badges($pdo) as $b) {
        if (isset($have[$b['key']]) || $b['status'] !== 'active' || !bv_badge_met($b['key'], $b['param'], $facts, $pdo, $userId)) {
            continue;
        }
        $ins->execute([':u' => $userId, ':k' => $b['key'], ':t' => bv_now()]);
        if ($ins->rowCount() === 1) {
            $new[] = ['key' => $b['key'], 'title' => $b['title'], 'description' => $b['description']];
        }
    }

    return $new;
}

// ---------- Після дії гравця --------------------------------------------------------------------------------------

/**
 * Після перевірки місії / іспиту / слова / Поломки дня: серія (лише коли $active — здана Поломка дня за день $day),
 * нові значки, звання (рівень піднявся?).
 * @return array{rank: array, next: ?array, to_next: int, rank_up: bool, new_badges: list<array>, streak: array}
 */
function bv_progress_update(PDO $pdo, int $userId, int $xpBefore, bool $active, ?string $day = null): array
{
    $streak = $active ? bv_streak_touch($pdo, $userId, $day) : bv_streak_view($pdo, $userId);
    $new = bv_badges_check($pdo, $userId);
    $ranks = bv_ranks($pdo);
    $xp = bv_totals($pdo, $userId)['xp'];
    $now = bv_rank_for($ranks, $xp);
    $before = bv_rank_for($ranks, $xpBefore);

    return $now + ['rank_up' => $now['rank']['key'] !== $before['rank']['key'], 'new_badges' => $new,
        'streak' => ['current' => $streak['current'], 'best' => $streak['best'], 'rested' => !empty($streak['rested']),
            'restarted' => !empty($streak['restarted'])]];
}

/** Усе для карти: XP, звання, серія, значки (з позначкою «отримано»). */
function bv_progress_summary(PDO $pdo, int $userId): array
{
    $xp = bv_totals($pdo, $userId)['xp'];
    $st = $pdo->prepare('SELECT badge_key, earned_at FROM bv_user_badges WHERE user_id = :u');
    $st->execute([':u' => $userId]);
    $earned = $st->fetchAll(PDO::FETCH_KEY_PAIR) ?: [];
    $badges = [];
    foreach (bv_badges($pdo) as $b) {
        if ($b['status'] === 'active' || isset($earned[$b['key']])) {
            $badges[] = $b + ['earned' => isset($earned[$b['key']])];
        }
    }

    return bv_rank_for(bv_ranks($pdo), $xp) + ['xp' => $xp, 'streak' => bv_streak_view($pdo, $userId), 'badges' => $badges];
}
