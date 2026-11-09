<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace, Хвиля 1: фільтри вакансій (і дешеві фільтри курсів / послуг) — єдиний шар для
 * сторінки блока / підкатегорії (app/mp-tree.php → mpt_search), загального пошуку (app/marketplace-board.php →
 * mpb_search), збережених пошуків (app/mp-saved.php) і лічильника «Показати N результатів» (public/mp-count.php).
 *
 * Джерело даних одне — mp_listings (вакансії/курси/послуги — section job|course|service, post_form = '', поля типу
 * в JSON details; міграція 2026-10-19). Нічого не зливаємо: лише читаємо details / work_format / is_remote і нові
 * колонки salary_min_usd / salary_max_usd (міграція 2026-11-09, № 20) та таблицю mp_listing_tags.
 *
 * Параметри GET (білі списки; некоректні значення мовчки відкидаються, списки — через кому або name[]):
 *   вакансії: emp (тип зайнятості, мульти), sched (графік, мульти), exp (досвід, мульти), fit (позначки «Підходить»,
 *             мульти, перелік — config 'suitable_for'), wf (формат: offline|online|hybrid), sal (зарплата «від»),
 *             scur (UAH|USD|EUR), sper (MONTH|HOUR|PROJECT, типово MONTH), sort new|salary_desc|salary_asc;
 *   курси:    cf (формат online|offline|hybrid), ptype (free|paid);
 *   послуги:  stype (тип послуги, мульти);
 *   будь-який блок: region (id області з geo_places — блок «Вакансії за областями»).
 * Зарплата порівнюється лише з тим самим періодом (періоди не конвертуються) і лише в USD за поточним курсом
 * (колонки *_usd); оголошення без зарплати чи без курсу у фільтр зарплати не потрапляють, але без нього показуються.
 */

require_once __DIR__ . '/listing.php';

const MPJ_EMPLOYMENT = ['full_time', 'part_time', 'temporary', 'internship', 'side_job'];
const MPJ_SCHEDULE = ['full_day', 'part_day', 'shift', 'rotation', 'flexible'];
const MPJ_EXPERIENCE = ['no_experience', 'junior', 'middle', 'senior'];
const MPJ_WORK_FORMATS = ['offline', 'online', 'hybrid'];
const MPJ_SAL_CURRENCIES = ['UAH', 'USD', 'EUR'];
const MPJ_SAL_PERIODS = ['MONTH', 'HOUR', 'PROJECT'];
const MPJ_JOB_SORTS = ['new', 'salary_desc', 'salary_asc'];
const MPJ_COURSE_FORMATS = ['online', 'offline', 'hybrid'];
const MPJ_PRICE_TYPES = ['free', 'paid'];
const MPJ_SAL_MAX = 999999999;
/** Ключі GET цього шару (для білих списків сторінок і збережених пошуків). */
const MPJ_KEYS = ['emp', 'sched', 'exp', 'fit', 'wf', 'sal', 'scur', 'sper', 'cf', 'ptype', 'stype', 'region'];

/** Чи застосовано міграцію № 20 (колонки зарплати в USD і таблиця позначок). */
function mpj_ready(PDO $pdo): bool
{
    static $ready = null;
    if ($ready === null) {
        try {
            $st = $pdo->query("SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE()
                               AND ((TABLE_NAME = 'mp_listings' AND COLUMN_NAME IN ('salary_min_usd', 'salary_max_usd'))
                                 OR (TABLE_NAME = 'mp_listing_tags' AND COLUMN_NAME = 'is_active'))");
            $ready = (int) $st->fetchColumn() === 3;
        } catch (Throwable $e) {
            $ready = false;
        }
    }

    return $ready;
}

/**
 * Дозволені позначки «Підходить» з конфігу. Значення з цифрами або словами про вік відкидаються завжди
 * (захист від вікових діапазонів навіть при помилці в конфігу). @return list<string>
 */
function mpj_suitable_values(): array
{
    $raw = mp_config()['suitable_for'] ?? [];
    $out = [];
    foreach (is_array($raw) ? $raw : [] as $v) {
        $v = is_string($v) ? strtolower(trim($v)) : '';
        if ($v === '' || preg_match('/^[a-z_]{2,40}$/', $v) !== 1 || mpj_is_age_like($v)) {
            continue;
        }
        $out[] = $v;
    }

    return array_values(array_unique($out));
}

/** Чи схоже значення на вікову ознаку (відхиляється на сервері). */
function mpj_is_age_like(string $v): bool
{
    return preg_match('/\d|age|aged|old|young|year|вік|років|рок|пенс|retire|senior_citizen|teen|youth|молод|старш/iu', $v) === 1;
}

/** Підпис позначки «Підходить». */
function mpj_fit_label(string $tag): string
{
    $key = 'mpj_fit_' . $tag;
    $txt = t($key);

    return $txt !== $key ? $txt : str_replace('_', ' ', $tag);
}

// =========================================================================
// Розбір GET
// =========================================================================

/** Список значень із GET (масив name[] або рядок через кому) за білим списком. @return list<string> */
function mpj_list(array $get, string $key, array $allowed): array
{
    $raw = $get[$key] ?? null;
    $vals = is_array($raw) ? $raw : (is_string($raw) ? explode(',', $raw) : []);
    $out = [];
    foreach (array_slice($vals, 0, 20) as $v) {
        if (is_string($v) && in_array(trim($v), $allowed, true)) {
            $out[] = trim($v);
        }
    }
    // Порядок — як у білому списку (стабільні посилання й хеш збереженого пошуку).
    return array_values(array_intersect($allowed, $out));
}

/** Одне значення з білого списку або ''. */
function mpj_one(array $get, string $key, array $allowed): string
{
    $v = is_string($get[$key] ?? null) ? trim((string) $get[$key]) : '';

    return in_array($v, $allowed, true) ? $v : '';
}

/**
 * Нормалізовані фільтри шару для блока $section ('' — загальний пошук без блока: лише region).
 *
 * @return array<string,mixed>
 */
function mpj_parse(array $get, string $section): array
{
    // Збережені пошуки передають числа (json_decode) — приводимо скаляри до рядків.
    $get = array_map(static fn($v) => is_int($v) || is_float($v) ? (string) $v : $v, $get);
    $f = ['section' => $section];
    if ($section === 'job') {
        $f['emp'] = mpj_list($get, 'emp', MPJ_EMPLOYMENT);
        $f['sched'] = mpj_list($get, 'sched', MPJ_SCHEDULE);
        $f['exp'] = mpj_list($get, 'exp', MPJ_EXPERIENCE);
        $f['fit'] = mpj_list($get, 'fit', mpj_suitable_values());
        $f['wf'] = mpj_one($get, 'wf', MPJ_WORK_FORMATS);
        $sal = is_string($get['sal'] ?? null) ? str_replace([' ', "\u{00A0}", ','], '', (string) $get['sal']) : '';
        $f['sal'] = preg_match('/^\d{1,9}$/', $sal) === 1 && (int) $sal > 0 ? (int) $sal : null;
        $f['scur'] = mpj_one($get, 'scur', MPJ_SAL_CURRENCIES) ?: 'UAH';
        $f['sper'] = mpj_one($get, 'sper', MPJ_SAL_PERIODS) ?: 'MONTH';
    } elseif ($section === 'course') {
        $f['cf'] = mpj_one($get, 'cf', MPJ_COURSE_FORMATS);
        $f['ptype'] = mpj_one($get, 'ptype', MPJ_PRICE_TYPES);
    } elseif ($section === 'service') {
        $f['stype'] = mpj_list($get, 'stype', LST_DETAILS['service']['service_type']);
    }
    $region = is_string($get['region'] ?? null) && preg_match('/^\d{1,9}$/', (string) $get['region']) === 1 ? (int) $get['region'] : 0;
    $f['region'] = $region;

    return $f;
}

/** Канонічні параметри посилання (лише задані; списки — через кому). @return array<string,string|int> */
function mpj_url_params(array $f): array
{
    $out = [];
    foreach (['emp', 'sched', 'exp', 'fit', 'stype'] as $k) {
        if (!empty($f[$k])) {
            $out[$k] = implode(',', $f[$k]);
        }
    }
    foreach (['wf', 'cf', 'ptype'] as $k) {
        if (($f[$k] ?? '') !== '') {
            $out[$k] = (string) $f[$k];
        }
    }
    if (($f['sal'] ?? null) !== null) {
        $out['sal'] = (int) $f['sal'];
        $out['scur'] = (string) $f['scur'];
        $out['sper'] = (string) $f['sper'];
    } elseif (($f['section'] ?? '') === 'job' && ($f['sper'] ?? 'MONTH') !== 'MONTH') {
        $out['sper'] = (string) $f['sper'];   // період для сортування за зарплатою
    }
    if ((int) ($f['region'] ?? 0) > 0) {
        $out['region'] = (int) $f['region'];
    }

    return $out;
}

/** Чи задано хоч один фільтр шару. */
function mpj_has_filters(array $f): bool
{
    $p = mpj_url_params($f);
    unset($p['scur']);
    if (!isset($p['sal'])) {
        unset($p['sper']);
    }

    return $p !== [];
}

// =========================================================================
// SQL
// =========================================================================

/** JSON-поле details (alias l). */
function mpj_j(string $key): string
{
    return "JSON_UNQUOTE(JSON_EXTRACT(l.details, '$." . preg_replace('/[^a-z_]/', '', $key) . "'))";
}

/** IN (...) з іменованими плейсхолдерами. */
function mpj_in(string $expr, array $vals, string $ph, array &$params): string
{
    $names = [];
    foreach (array_values($vals) as $i => $v) {
        $names[] = ":{$ph}{$i}";
        $params[":{$ph}{$i}"] = $v;
    }

    return "$expr IN (" . implode(', ', $names) . ')';
}

/** Курс валюти до USD з кешем у межах запиту (недоступний курс не запитується повторно). */
function mpj_rate_ok(PDO $pdo, string $currency): bool
{
    static $ok = [];
    if (!array_key_exists($currency, $ok)) {
        require_once __DIR__ . '/mp-geo.php';
        $ok[$currency] = mpg_usd_rate($pdo, $currency) !== null;
    }

    return $ok[$currency];
}

/** Сума в USD (рядок) або null, якщо курсу немає. */
function mpj_amount_usd(PDO $pdo, int $amount, string $currency): ?string
{
    return mpj_rate_ok($pdo, $currency) ? mpg_price_usd($pdo, (string) $amount, $currency) : null;
}

/** Зарплата «від» у USD (рядок) або null, якщо курсу немає. */
function mpj_to_usd(PDO $pdo, int $amount, string $currency): ?string
{
    return mpj_amount_usd($pdo, $amount, $currency);
}

/**
 * Умови WHERE шару (alias l) і, за потреби, позначка $notes['sal_unavailable'] (курсу немає — фільтр зарплати
 * не застосовано). Фільтри блока застосовуються лише до рядків вакансій/курсів/послуг компаній.
 *
 * @return list<string>
 */
function mpj_where(PDO $pdo, array $f, array &$params, array &$notes = []): array
{
    $w = [];
    $section = (string) ($f['section'] ?? '');
    $isLst = "(l.post_form = '' AND l.section = '$section')";
    if ($section === 'job') {
        if (!empty($f['emp'])) {
            $w[] = $isLst . ' AND ' . mpj_in(mpj_j('employment'), $f['emp'], 'jemp', $params);
        }
        if (!empty($f['sched'])) {
            $w[] = $isLst . ' AND ' . mpj_in(mpj_j('schedule'), $f['sched'], 'jsch', $params);
        }
        if (!empty($f['exp'])) {
            // «Будь-який рівень» (level = any) підходить під будь-який вибір досвіду.
            $w[] = $isLst . ' AND (' . mpj_in(mpj_j('level'), $f['exp'], 'jexp', $params) . ' OR ' . mpj_j('level') . " = 'any')";
        }
        if (!empty($f['fit']) && mpj_ready($pdo)) {
            $w[] = 'EXISTS (SELECT 1 FROM mp_listing_tags tg WHERE tg.listing_id = l.id AND tg.is_active = 1 AND '
                . mpj_in('tg.tag', $f['fit'], 'jfit', $params) . ')';
        }
        $wf = (string) ($f['wf'] ?? '');
        if ($wf === 'online') {
            $w[] = "(l.work_format = 'online' OR (l.work_format IS NULL AND l.is_remote = 1))";
        } elseif ($wf === 'offline') {
            $w[] = "(l.work_format = 'offline' OR (l.work_format IS NULL AND l.is_remote = 0))";
        } elseif ($wf === 'hybrid') {
            $w[] = "l.work_format = 'hybrid'";
        }
        if (($f['sal'] ?? null) !== null) {
            $usd = mpj_ready($pdo) ? mpj_to_usd($pdo, (int) $f['sal'], (string) $f['scur']) : null;
            if ($usd === null) {
                $notes['sal_unavailable'] = true;
            } else {
                $w[] = $isLst . ' AND ' . mpj_j('salary_period') . ' = :jsper AND COALESCE(l.salary_max_usd, l.salary_min_usd) >= :jsusd';
                $params[':jsper'] = (string) $f['sper'];
                $params[':jsusd'] = $usd;
            }
        }
    } elseif ($section === 'course') {
        if (($f['cf'] ?? '') !== '') {
            $w[] = $isLst . ' AND ' . mpj_j('format') . ' = :jcf';
            $params[':jcf'] = (string) $f['cf'];
        }
        if (($f['ptype'] ?? '') === 'free') {
            $w[] = $isLst . ' AND ' . mpj_j('is_free') . " = '1'";
        } elseif (($f['ptype'] ?? '') === 'paid') {
            $w[] = $isLst . ' AND COALESCE(' . mpj_j('is_free') . ", '0') <> '1'";
        }
    } elseif ($section === 'service') {
        if (!empty($f['stype'])) {
            $w[] = $isLst . ' AND ' . mpj_in(mpj_j('service_type'), $f['stype'], 'jst', $params);
        }
    }
    $region = (int) ($f['region'] ?? 0);
    if ($region > 0 && mpt_table_exists($pdo, 'geo_places')) {
        $w[] = '(l.primary_place_id = :jreg1 OR l.primary_place_id IN (SELECT gp.id FROM geo_places gp WHERE gp.parent_id = :jreg2))';
        $params[':jreg1'] = $region;
        $params[':jreg2'] = $region;
    }
    if (is_string($f['after'] ?? null) && preg_match('/^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/', (string) $f['after']) === 1) {
        $w[] = 'l.published_at > :jafter';
        $params[':jafter'] = (string) $f['after'];
    }

    return $w;
}

/**
 * ORDER BY для сортування за зарплатою або null. Спершу — вакансії вибраного періоду (за замовчуванням місяць),
 * потім інші періоди, наприкінці — без зарплати / без курсу. Період — з білого списку (вставляється літералом).
 */
function mpj_order(PDO $pdo, string $sort, array $f): ?string
{
    if (!in_array($sort, ['salary_desc', 'salary_asc'], true) || !mpj_ready($pdo)) {
        return null;
    }
    $per = in_array($f['sper'] ?? '', MPJ_SAL_PERIODS, true) ? (string) $f['sper'] : 'MONTH';
    $val = $sort === 'salary_desc' ? 'COALESCE(l.salary_max_usd, l.salary_min_usd)' : 'COALESCE(l.salary_min_usd, l.salary_max_usd)';

    return '(' . $val . ' IS NULL) ASC, (' . mpj_j('salary_period') . " = '$per') DESC, $val " . ($sort === 'salary_desc' ? 'DESC' : 'ASC')
        . ', l.published_at DESC, l.id DESC';
}

// =========================================================================
// Збереження оголошення: зарплата в USD, формат, місце, позначки
// =========================================================================

/** Зарплата вакансії в USD: [min, max] (рядки або null). */
function mpj_salary_usd(PDO $pdo, array $details): array
{
    $cur = (string) ($details['salary_currency'] ?? 'USD');
    $min = isset($details['salary_min']) ? mpj_amount_usd($pdo, (int) $details['salary_min'], $cur) : null;
    $max = isset($details['salary_max']) ? mpj_amount_usd($pdo, (int) $details['salary_max'], $cur) : null;

    return [$min, $max];
}

/**
 * Після lst_save(): колонки, яких немає в lst_save (work_format, зарплата в USD, місто з геодовідника), і позначки.
 * Позначки: увімкнені — is_active = 1, зняті — is_active = 0 (рядки не видаляються). Помилки — лише в лог.
 *
 * @param list<string> $tags
 */
function mpj_after_save(PDO $pdo, int $id, string $type, array $details, string $workFormat, array $tags, string $country): void
{
    require_once __DIR__ . '/mp-geo.php';
    try {
        $sets = [];
        $p = [':id' => $id];
        if (in_array($workFormat, MPJ_WORK_FORMATS, true)) {
            $sets[] = 'work_format = :wf';
            $p[':wf'] = $workFormat;
        }
        if ($type === 'job' && mpj_ready($pdo)) {
            [$min, $max] = mpj_salary_usd($pdo, $details);
            $sets[] = 'salary_min_usd = :smin';
            $sets[] = 'salary_max_usd = :smax';
            $p[':smin'] = $min;
            $p[':smax'] = $max;
        }
        if ($type === 'job' && mpg_ready($pdo)) {
            $place = mpj_resolve_city($pdo, (string) ($details['city'] ?? ''), $country);
            $sets[] = 'primary_place_id = :pp';
            $p[':pp'] = $place;
        }
        if ($sets !== []) {
            $pdo->prepare('UPDATE mp_listings SET ' . implode(', ', $sets) . ' WHERE id = :id')->execute($p);
        }
        if ($type === 'job' && mpj_ready($pdo)) {
            mpj_save_tags($pdo, $id, $tags);
        }
    } catch (Throwable $e) {
        error_log('[mp-jobs] after save #' . $id . ': ' . $e->getMessage());
    }
}

/** Позначки оголошення: лише дозволені значення; зняті — is_active = 0. @param list<string> $tags */
function mpj_save_tags(PDO $pdo, int $id, array $tags): void
{
    $allowed = mpj_suitable_values();
    $tags = array_values(array_intersect($allowed, $tags));
    $pdo->prepare('UPDATE mp_listing_tags SET is_active = 0 WHERE listing_id = :id')->execute([':id' => $id]);
    $ins = $pdo->prepare('INSERT INTO mp_listing_tags (listing_id, tag, is_active) VALUES (:id, :t, 1) ON DUPLICATE KEY UPDATE is_active = 1');
    foreach ($tags as $t) {
        $ins->execute([':id' => $id, ':t' => $t]);
    }
}

/** Позначки «Підходить» (лише дозволені й активні) для рядків. @param list<int> $ids @return array<int,list<string>> */
function mpj_tags(PDO $pdo, array $ids): array
{
    $ids = array_values(array_unique(array_filter(array_map('intval', $ids))));
    if ($ids === [] || !mpj_ready($pdo)) {
        return [];
    }
    $st = $pdo->query('SELECT listing_id, tag FROM mp_listing_tags WHERE is_active = 1 AND listing_id IN (' . implode(',', $ids) . ')');
    $allowed = mpj_suitable_values();
    $out = [];
    foreach ($st->fetchAll(PDO::FETCH_ASSOC) as $r) {
        if (in_array($r['tag'], $allowed, true)) {
            $out[(int) $r['listing_id']][] = (string) $r['tag'];
        }
    }

    return $out;
}

/** Місто вакансії (текст) → id міста з геодовідника в межах країни оголошення (найбільше за населенням) або null. */
function mpj_resolve_city(PDO $pdo, string $city, string $country): ?int
{
    $city = trim($city);
    if ($city === '' || preg_match('/^[A-Z]{2}$/', $country) !== 1 || $country === 'XX') {
        return null;
    }
    $st = $pdo->prepare(
        "SELECT p.id FROM geo_place_names n JOIN geo_places p ON p.id = n.place_id
         WHERE n.name = :n AND p.type = 'city' AND p.country_code = :cc
         ORDER BY p.population DESC, p.id LIMIT 1"
    );
    $st->execute([':n' => mb_substr($city, 0, 120), ':cc' => $country]);
    $id = $st->fetchColumn();

    return $id !== false ? (int) $id : null;
}

/**
 * Щоденне оновлення (cron/marketplace-daily.php): зарплата в USD за поточним курсом і місто з геодовідника для
 * живих вакансій. Повертає кількість оновлених рядків.
 */
function mpj_refresh(PDO $pdo): int
{
    if (!mpj_ready($pdo)) {
        return 0;
    }
    require_once __DIR__ . '/mp-geo.php';
    $n = 0;
    $rows = $pdo->query("SELECT id, details, country, primary_place_id, salary_min_usd, salary_max_usd FROM mp_listings
                         WHERE section = 'job' AND post_form = '' AND status IN ('published', 'pending')")->fetchAll(PDO::FETCH_ASSOC);
    $upd = $pdo->prepare('UPDATE mp_listings SET salary_min_usd = :a, salary_max_usd = :b, primary_place_id = :p WHERE id = :id');
    $geo = mpg_ready($pdo);
    foreach ($rows as $r) {
        $d = lst_details($r);
        [$min, $max] = mpj_salary_usd($pdo, $d);
        $place = $r['primary_place_id'] !== null ? (int) $r['primary_place_id'] : ($geo ? mpj_resolve_city($pdo, (string) ($d['city'] ?? ''), (string) $r['country']) : null);
        if ($min !== $r['salary_min_usd'] || $max !== $r['salary_max_usd'] || $place !== ($r['primary_place_id'] !== null ? (int) $r['primary_place_id'] : null)) {
            $upd->execute([':a' => $min, ':b' => $max, ':p' => $place, ':id' => (int) $r['id']]);
            $n += $upd->rowCount();
        }
    }

    return $n;
}

// =========================================================================
// Вивід
// =========================================================================

/** Рядок картки вакансії: «зарплата · тип зайнятості · графік · досвід» (зарплати немає — «за домовленістю»). */
function mpj_card_line(array $row): string
{
    if ((string) ($row['section'] ?? '') !== 'job') {
        return '';
    }
    $d = $row['detail'] ?? lst_details($row);
    $parts = [lst_price_label($row) ?: t('mpj_salary_negotiable')];
    foreach (['employment', 'schedule', 'level'] as $k) {
        if (!empty($d[$k]) && $d[$k] !== 'any') {
            $parts[] = lst_v((string) $d[$k]);
        }
    }

    return implode(' · ', $parts);
}

/** Підпис формату роботи вакансії. */
function mpj_work_format_label(array $row): string
{
    $wf = (string) ($row['work_format'] ?? '');
    if (!in_array($wf, MPJ_WORK_FORMATS, true)) {
        $wf = (int) ($row['is_remote'] ?? 0) === 1 ? 'online' : 'offline';
    }

    return t('mpj_wf_' . $wf);
}

/**
 * Активні фільтри шару як чипи: list<[підпис, параметри без цього значення]>. $base — поточні параметри сторінки
 * (разом із фільтрами шару), з яких знімається одне значення.
 *
 * @return list<array{0:string,1:array<string,mixed>}>
 */
function mpj_chips(array $f, array $base): array
{
    $chips = [];
    $drop = static function (array $base, string $key, ?string $value = null): array {
        if ($value === null || !isset($base[$key])) {
            unset($base[$key]);
        } else {
            $vals = array_values(array_diff(explode(',', (string) $base[$key]), [$value]));
            if ($vals === []) {
                unset($base[$key]);
            } else {
                $base[$key] = implode(',', $vals);
            }
        }
        unset($base['page']);

        return $base;
    };
    foreach (['emp', 'sched', 'exp', 'stype'] as $k) {
        foreach ($f[$k] ?? [] as $v) {
            $chips[] = [lst_v($v), $drop($base, $k, $v)];
        }
    }
    foreach ($f['fit'] ?? [] as $v) {
        $chips[] = [t('mpj_fit_prefix') . ' ' . mpj_fit_label($v), $drop($base, 'fit', $v)];
    }
    if (($f['wf'] ?? '') !== '') {
        $chips[] = [t('mpj_wf_' . $f['wf']), $drop($base, 'wf')];
    }
    if (($f['cf'] ?? '') !== '') {
        $chips[] = [lst_v((string) $f['cf']), $drop($base, 'cf')];
    }
    if (($f['ptype'] ?? '') !== '') {
        $chips[] = [t('mpj_ptype_' . $f['ptype']), $drop($base, 'ptype')];
    }
    if (($f['sal'] ?? null) !== null) {
        $b = $drop($drop($drop($base, 'sal'), 'scur'), 'sper');
        $chips[] = [sprintf(t('mpj_chip_salary'), number_format((int) $f['sal'], 0, ',', "\u{00A0}"), t('mpj_cur_' . $f['scur']), t('mpj_per_' . $f['sper'])), $b];
    }

    return $chips;
}

/** HTML чипів активних фільтрів + «Скинути все». $chips: list<[підпис, адреса]>. */
function mpj_chips_html(array $chips, string $resetUrl): string
{
    if ($chips === []) {
        return '';
    }
    $html = '<div class="mpf-chips" aria-label="' . mp_e(t('mpj_active_filters')) . '">';
    foreach ($chips as [$label, $href]) {
        $html .= '<a class="mpf-chip" href="' . mp_e($href) . '" aria-label="' . mp_e(sprintf(t('mpj_remove_filter'), $label)) . '">'
            . '<span>' . mp_e($label) . '</span><span class="mpf-chip__x" aria-hidden="true">✕</span></a>';
    }

    return $html . '<a class="mpf-chip mpf-chip--reset" href="' . mp_e($resetUrl) . '">' . mp_e(t('mpj_reset_all')) . '</a></div>';
}

/** Група чекбоксів фільтра (мультивибір). */
function mpj_checks_html(string $name, string $legend, array $options, array $selected): string
{
    $html = '<fieldset class="mp-field mpf-group"><legend class="mp-label">' . mp_e($legend) . '</legend><div class="mpf-checks">';
    foreach ($options as $value => $label) {
        $html .= '<label class="mp-check mpf-check"><input type="checkbox" name="' . mp_e($name) . '[]" value="' . mp_e($value) . '"'
            . (in_array((string) $value, $selected, true) ? ' checked' : '') . '> <span>' . mp_e($label) . '</span></label>';
    }

    return $html . '</div></fieldset>';
}

/** Вибір одного значення (select). */
function mpj_select_html(string $name, string $id, string $label, array $options, string $current, string $anyLabel): string
{
    $html = '<div class="mp-field"><label class="mp-label" for="' . mp_e($id) . '">' . mp_e($label) . '</label>'
        . '<select class="mp-input" id="' . mp_e($id) . '" name="' . mp_e($name) . '"><option value="">' . mp_e($anyLabel) . '</option>';
    foreach ($options as $value => $text) {
        $html .= '<option value="' . mp_e($value) . '"' . ((string) $value === $current ? ' selected' : '') . '>' . mp_e($text) . '</option>';
    }

    return $html . '</select></div>';
}

/** Поля фільтрів блока (усередині форми сторінки). */
function mpj_fields_html(array $f): string
{
    $section = (string) ($f['section'] ?? '');
    $vals = static function (array $keys): array {
        $o = [];
        foreach ($keys as $k) {
            $o[$k] = lst_v($k);
        }

        return $o;
    };
    $html = '';
    if ($section === 'job') {
        $html .= mpj_checks_html('emp', t('mpj_f_employment'), $vals(MPJ_EMPLOYMENT), $f['emp'] ?? []);
        $html .= mpj_checks_html('sched', t('mpj_f_schedule'), $vals(MPJ_SCHEDULE), $f['sched'] ?? []);
        $html .= mpj_checks_html('exp', t('mpj_f_experience'), $vals(MPJ_EXPERIENCE), $f['exp'] ?? []);
        $wf = [];
        foreach (MPJ_WORK_FORMATS as $k) {
            $wf[$k] = t('mpj_wf_' . $k);
        }
        $html .= mpj_select_html('wf', 'f_wf', t('mpj_f_work_format'), $wf, (string) ($f['wf'] ?? ''), t('mpg_fmt_any'));
        $cur = '';
        foreach (MPJ_SAL_CURRENCIES as $c) {
            $cur .= '<option value="' . $c . '"' . (($f['scur'] ?? 'UAH') === $c ? ' selected' : '') . '>' . mp_e(t('mpj_cur_' . $c)) . '</option>';
        }
        $per = '';
        foreach (MPJ_SAL_PERIODS as $p) {
            $per .= '<option value="' . $p . '"' . (($f['sper'] ?? 'MONTH') === $p ? ' selected' : '') . '>' . mp_e(t('mpj_per_' . $p)) . '</option>';
        }
        $html .= '<div class="mp-field mpf-salary"><label class="mp-label" for="f_sal">' . mp_e(t('mpj_f_salary_from')) . '</label>'
            . '<div class="mp-inline"><input class="mp-input mp-input--num" type="text" inputmode="numeric" id="f_sal" name="sal" maxlength="11" value="'
            . (($f['sal'] ?? null) !== null ? (int) $f['sal'] : '') . '" placeholder="' . mp_e(t('mpb_from')) . '">'
            . '<select class="mp-input mp-input--short" name="scur" aria-label="' . mp_e(t('mpj_f_currency')) . '">' . $cur . '</select>'
            . '<select class="mp-input mp-input--short" name="sper" aria-label="' . mp_e(t('mpj_f_period')) . '">' . $per . '</select></div>'
            . '<p class="mp-hint">' . mp_e(t('mpj_salary_hint')) . '</p></div>';
        $fit = [];
        foreach (mpj_suitable_values() as $v) {
            $fit[$v] = mpj_fit_label($v);
        }
        if ($fit !== []) {
            $html .= mpj_checks_html('fit', t('mpj_f_fit'), $fit, $f['fit'] ?? []);
        }
    } elseif ($section === 'course') {
        $html .= mpj_select_html('cf', 'f_cf', t('mpj_f_course_format'), $vals(MPJ_COURSE_FORMATS), (string) ($f['cf'] ?? ''), t('mpg_fmt_any'));
        $html .= mpj_select_html('ptype', 'f_ptype', t('mpj_f_price_type'), ['free' => t('mpj_ptype_free'), 'paid' => t('mpj_ptype_paid')], (string) ($f['ptype'] ?? ''), t('mpg_fmt_any'));
    } elseif ($section === 'service') {
        $html .= mpj_checks_html('stype', lst_tr('d_service_type'), $vals(LST_DETAILS['service']['service_type']), $f['stype'] ?? []);
    }
    if ((int) ($f['region'] ?? 0) > 0) {
        $html .= '<input type="hidden" name="region" value="' . (int) $f['region'] . '">';
    }

    return $html;
}

/**
 * «Вакансії за областями»: ненульові області (geo_places type='region') з кількістю живих вакансій блока.
 * Порожньо, якщо геодовідника немає. @return list<array{id:int,name:string,count:int}>
 */
function mpj_region_counts(PDO $pdo, string $section, string $lang): array
{
    if (!mpt_table_exists($pdo, 'geo_places') || !function_exists('mpg_ready') || !mpg_ready($pdo)) {
        return [];
    }
    $st = $pdo->prepare(
        "SELECT r.id, COUNT(DISTINCT l.id) AS n
         FROM mp_listings l
         JOIN geo_places c ON c.id = l.primary_place_id
         JOIN geo_places r ON r.id = IF(c.type = 'region', c.id, c.parent_id) AND r.type = 'region'
         WHERE " . mpt_live_sql() . ' AND l.section = :s
         GROUP BY r.id ORDER BY n DESC, r.id LIMIT 30'
    );
    $st->execute([':s' => $section]);
    $rows = $st->fetchAll(PDO::FETCH_ASSOC);
    $names = mpg_names($pdo, array_map(static fn($r) => (int) $r['id'], $rows), $lang);
    $out = [];
    foreach ($rows as $r) {
        $out[] = ['id' => (int) $r['id'], 'name' => $names[(int) $r['id']] ?? ('#' . $r['id']), 'count' => (int) $r['n']];
    }

    return $out;
}

/** Назва області за id (для чипа) або ''. */
function mpj_region_name(PDO $pdo, int $id, string $lang): string
{
    if ($id <= 0 || !function_exists('mpg_names') || !mpt_table_exists($pdo, 'geo_places')) {
        return '';
    }

    return mpg_names($pdo, [$id], $lang)[$id] ?? '';
}

// =========================================================================
// Фільтри сторінки блока / підкатегорії (marketplace-category.php, mp-count.php, збережені пошуки)
// =========================================================================

/**
 * Розбір GET сторінки блока $block (підкатегорії $sub) за білими списками.
 *
 * @return array{f:array<string,mixed>,params:array<string,mixed>,filtered:bool,page:int,focusTags:list<array<string,mixed>>}
 */
function mpj_block_filters(PDO $pdo, array $block, ?array $sub, array $get): array
{
    $section = (string) $block['section'];
    $s = static fn(string $k, int $max = 100): string => is_string($get[$k] ?? null) ? mb_substr(trim((string) $get[$k]), 0, $max) : '';
    $num = static function (string $k) use ($s): ?float {
        $raw = str_replace([' ', ','], ['', '.'], $s($k, 14));

        return preg_match('/^\d{1,9}(\.\d{1,2})?$/', $raw) === 1 ? (float) $raw : null;
    };
    $focusTags = in_array($section, MPT_LST_SECTIONS, true) ? lst_focus_tags($pdo) : [];
    $focus = (int) $s('focus', 10);
    $focus = in_array($focus, array_column($focusTags, 'id'), true) ? $focus : 0;
    $sorts = $section === 'job' ? MPJ_JOB_SORTS : MPT_SORTS;
    $jf = mpj_parse($get, $section);
    $isJob = $section === 'job';
    $f = [
        'section' => $section, 'cat' => $sub['id'] ?? 0, 'focus' => $focus,
        'q' => $s('q'), 'sort' => in_array($s('sort', 12), $sorts, true) ? $s('sort', 12) : 'new',
        // Вакансії: формат — wf (офіс / онлайн / змішано), ціна — зарплата «від»; курси: формат — cf.
        'format' => !$isJob && $section !== 'course' && in_array($s('format', 10), MPT_FORMATS, true) ? $s('format', 10) : '',
        'city' => $s('city', 80),
        'price_min' => $isJob ? null : $num('price_min'), 'price_max' => $isJob ? null : $num('price_max'),
        'jf' => $jf,
    ];
    $page = max(1, min(10000, (int) $s('page', 6)));
    $params = array_filter([
        'q' => $f['q'], 'sort' => $f['sort'] !== 'new' ? $f['sort'] : '', 'format' => $f['format'], 'city' => $f['city'],
        'price_min' => $f['price_min'], 'price_max' => $f['price_max'], 'focus' => $focus ?: '',
    ] + mpj_url_params($jf), static fn($v): bool => $v !== null && $v !== '');
    $filtered = array_diff_key($params, ['sort' => 1, 'sper' => 1]) !== [];

    return ['f' => $f, 'params' => $params, 'filtered' => $filtered, 'page' => $page, 'focusTags' => $focusTags];
}
