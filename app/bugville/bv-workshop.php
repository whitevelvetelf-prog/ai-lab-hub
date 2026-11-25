<?php

declare(strict_types=1);

/**
 * Багвіль — Майстерня (MAIN_TASK, розділ 7; міграція № 39). Лише для акаунтів із підтвердженим віком.
 *
 * Предмети лише косметичні: рамки аватара, наклейки, фони карти. Купуються тільки за монети гри, ніколи за реальні
 * гроші; на гру не впливають (жодного «pay-to-win»). Аватар — безкоштовно, з наявного набору (без фото й тексту).
 * Усі малюнки — власні SVG/CSS у цьому файлі; у БД (bv_workshop_items) лише тексти й ціни, каталог — сид.
 * Баланс монет = зароблене (bv_xp_log.coins) − витрачене (bv_user_items.price_paid). Купівля — у транзакції з
 * блокуванням рядка гравця (bv_players … FOR UPDATE), тож два швидкі натискання не витратять ті самі монети двічі.
 */

require_once __DIR__ . '/bv-player.php';

const BV_WS_KINDS = ['frame' => 'Рамки аватара', 'sticker' => 'Наклейки', 'background' => 'Фони карти'];

/** Безкоштовні аватари (ключ → назва). */
const BV_WS_AVATARS = ['robot' => 'Робот Гвинтик', 'owl' => 'Сова Лупа', 'cat' => 'Кіт Шнурок', 'snail' => 'Равлик Повільно-Точно',
    'fox' => 'Лисичка Іскра', 'cloud' => 'Хмаринка Біт'];

const BV_WS_DEFAULT_AVATAR = 'robot';

/** Початковий каталог (12 предметів) для сиду й запасного показу. */
function bv_ws_items_content(): array
{
    $i = 0;
    $it = static function (string $key, string $kind, string $title, string $desc, int $price) use (&$i): array {
        return ['key' => $key, 'kind' => $kind, 'title' => $title, 'description' => $desc, 'price' => $price, 'sort' => ++$i * 10];
    };

    return [
        $it('frame_gear', 'frame', 'Шестерня', 'Рамка із зубчиків — як у справжнього майстра.', 30),
        $it('frame_stars', 'frame', 'Зоряне коло', 'Пʼять зірок навколо аватара.', 30),
        $it('frame_leaf', 'frame', 'Вінок', 'Зелений вінок для того, хто не здається.', 40),
        $it('frame_neon', 'frame', 'Неонове кільце', 'Подвійне світне кільце вечірнього Багвіля.', 60),
        $it('sticker_glass', 'sticker', 'Лупа', 'Наклейка «Я шукаю поломки».', 20),
        $it('sticker_star', 'sticker', 'Зірочка', 'Маленька зірка за старанність.', 20),
        $it('sticker_nut', 'sticker', 'Гайка', 'Наклейка-гайка з майстерні.', 30),
        $it('sticker_book', 'sticker', 'Книжечка', 'Для знавців чарівних слів.', 40),
        $it('bg_sunset', 'background', 'Захід сонця', 'Теплий вечір над містом.', 40),
        $it('bg_night', 'background', 'Зоряна ніч', 'Темне небо з зорями.', 40),
        $it('bg_meadow', 'background', 'Галявина', 'Зелена галявина за містом.', 50),
        $it('bg_city', 'background', 'Вогні Багвіля', 'Будиночки з вікнами, що світяться.', 60),
    ];
}

// ---------- Малюнки (власні SVG; жодних даних користувача в розмітці) ----------------------------------------------

/** Аватар 64×64 (усередині 100×100 прев'ю). */
function bv_ws_avatar_svg(string $key): string
{
    $body = match ($key) {
        'owl' => '<ellipse cx="50" cy="56" rx="24" ry="26" fill="#8a5a00"/><circle cx="40" cy="48" r="9" fill="#fff"/><circle cx="60" cy="48" r="9" fill="#fff"/>'
            . '<circle cx="40" cy="49" r="4" fill="#1b2559"/><circle cx="60" cy="49" r="4" fill="#1b2559"/><path d="M47 58 L53 58 L50 64 Z" fill="#ffd23f"/>'
            . '<path d="M30 34 L38 42 M70 34 L62 42" stroke="#8a5a00" stroke-width="5" stroke-linecap="round"/>',
        'cat' => '<path d="M28 40 L32 22 L44 34 M72 40 L68 22 L56 34" fill="#ff9f43" stroke="#ff9f43" stroke-width="2" stroke-linejoin="round"/>'
            . '<circle cx="50" cy="54" r="24" fill="#ff9f43"/><circle cx="41" cy="50" r="3.5" fill="#1b2559"/><circle cx="59" cy="50" r="3.5" fill="#1b2559"/>'
            . '<path d="M46 60 Q50 64 54 60" fill="none" stroke="#1b2559" stroke-width="2.5" stroke-linecap="round"/>'
            . '<path d="M30 58 H40 M60 58 H70" stroke="#1b2559" stroke-width="1.5"/>',
        'snail' => '<path d="M22 72 H72 Q80 72 80 64" fill="none" stroke="#9be15d" stroke-width="8" stroke-linecap="round"/>'
            . '<circle cx="50" cy="52" r="20" fill="#ff6b5b"/><path d="M50 52 m-10 0 a10 10 0 1 0 10 -10 a6 6 0 1 0 6 6" fill="none" stroke="#fff" stroke-width="3"/>'
            . '<path d="M76 62 L80 46 M80 62 L86 48" stroke="#9be15d" stroke-width="3" stroke-linecap="round"/><circle cx="80" cy="45" r="3" fill="#1b2559"/>',
        'fox' => '<path d="M26 30 L40 44 L50 38 L60 44 L74 30 L70 62 Q50 82 30 62 Z" fill="#ff6b5b"/><path d="M38 62 Q50 74 62 62 L50 70 Z" fill="#fff"/>'
            . '<circle cx="42" cy="52" r="3.5" fill="#1b2559"/><circle cx="58" cy="52" r="3.5" fill="#1b2559"/><circle cx="50" cy="66" r="3" fill="#1b2559"/>',
        'cloud' => '<path d="M28 66 Q16 66 18 54 Q20 44 32 46 Q34 30 50 32 Q64 30 68 44 Q82 42 82 56 Q82 66 70 66 Z" fill="#e9fff7" stroke="#4fe0b6" stroke-width="3"/>'
            . '<circle cx="42" cy="52" r="3.5" fill="#1b2559"/><circle cx="58" cy="52" r="3.5" fill="#1b2559"/>'
            . '<path d="M45 59 Q50 63 55 59" fill="none" stroke="#1b2559" stroke-width="2.5" stroke-linecap="round"/><path d="M50 70 L46 80 L52 78 L49 88" fill="none" stroke="#ffd23f" stroke-width="3"/>',
        default => '<line x1="50" y1="18" x2="50" y2="28" stroke="#2116ad" stroke-width="3"/><circle cx="50" cy="16" r="5" fill="#ff6b5b"/>'
            . '<rect x="28" y="28" width="44" height="40" rx="12" fill="#4fe0b6" stroke="#0d6b55" stroke-width="3"/>'
            . '<circle cx="41" cy="46" r="6" fill="#fff"/><circle cx="59" cy="46" r="6" fill="#fff"/><circle cx="41" cy="47" r="3" fill="#1b2559"/>'
            . '<circle cx="59" cy="47" r="3" fill="#1b2559"/><rect x="42" y="57" width="16" height="4" rx="2" fill="#0d6b55"/>'
            . '<rect x="38" y="70" width="24" height="12" rx="4" fill="#2116ad"/>',
    };

    return $body;
}

/** Рамка навколо аватара (координати 100×100). */
function bv_ws_frame_svg(string $key): string
{
    return match ($key) {
        'frame_gear' => (static function (): string {
            $t = '';
            for ($a = 0; $a < 360; $a += 30) {
                $t .= '<rect x="47" y="1" width="6" height="8" rx="1.5" fill="#8a96d6" transform="rotate(' . $a . ' 50 50)"/>';
            }

            return $t . '<circle cx="50" cy="50" r="43" fill="none" stroke="#8a96d6" stroke-width="5"/>';
        })(),
        'frame_stars' => (static function (): string {
            $t = '<circle cx="50" cy="50" r="44" fill="none" stroke="#ffd23f" stroke-width="2" stroke-dasharray="3 5"/>';
            for ($a = 0; $a < 360; $a += 72) {
                $t .= '<path d="M50 0 L52.4 5.6 L58 6 L53.8 9.8 L55 15.5 L50 12.5 L45 15.5 L46.2 9.8 L42 6 L47.6 5.6 Z" fill="#ffd23f" transform="rotate(' . $a . ' 50 50)"/>';
            }

            return $t;
        })(),
        'frame_leaf' => (static function (): string {
            $t = '<circle cx="50" cy="50" r="44" fill="none" stroke="#17a583" stroke-width="2"/>';
            for ($a = 0; $a < 360; $a += 24) {
                $t .= '<ellipse cx="50" cy="6" rx="3.5" ry="7" fill="#9be15d" transform="rotate(' . $a . ' 50 50) rotate(30 50 6)"/>';
            }

            return $t;
        })(),
        'frame_neon' => '<circle cx="50" cy="50" r="46" fill="none" stroke="#ff6b5b" stroke-width="3"/><circle cx="50" cy="50" r="41" fill="none" stroke="#4fe0b6" stroke-width="3"/>',
        default => '',
    };
}

/** Наклейка (у правому нижньому куті, координати 100×100). */
function bv_ws_sticker_svg(string $key): string
{
    $g = match ($key) {
        'sticker_glass' => '<circle cx="0" cy="0" r="9" fill="#fff" stroke="#1b2559" stroke-width="3"/><line x1="6" y1="6" x2="13" y2="13" stroke="#1b2559" stroke-width="4" stroke-linecap="round"/>',
        'sticker_star' => '<path d="M0 -12 L3.5 -4 L12 -3.5 L5.5 2 L7.5 10.5 L0 6 L-7.5 10.5 L-5.5 2 L-12 -3.5 L-3.5 -4 Z" fill="#ffd23f" stroke="#3a2a00" stroke-width="1.5"/>',
        'sticker_nut' => '<path d="M-11 0 L-5.5 -9.5 L5.5 -9.5 L11 0 L5.5 9.5 L-5.5 9.5 Z" fill="#b4bdf0" stroke="#1b2559" stroke-width="2"/><circle cx="0" cy="0" r="4.5" fill="#fff" stroke="#1b2559" stroke-width="2"/>',
        'sticker_book' => '<rect x="-11" y="-9" width="22" height="18" rx="2" fill="#ff6b5b" stroke="#3a2a00" stroke-width="1.5"/><line x1="0" y1="-9" x2="0" y2="9" stroke="#3a2a00" stroke-width="1.5"/><path d="M-7 -4 H-3 M3 -4 H7" stroke="#fff" stroke-width="1.5"/>',
        default => '',
    };

    return $g === '' ? '' : '<g transform="translate(82 82)"><circle r="15" fill="#fff" opacity=".85"/>' . $g . '</g>';
}

/** Прев'ю вигляду: фон (CSS-клас) + аватар + рамка + наклейка. $label — текст для екранних читачів. */
function bv_ws_look_svg(array $look, int $size = 100, string $label = 'Ваш вигляд у Багвілі'): string
{
    $avatar = isset(BV_WS_AVATARS[$look['avatar'] ?? '']) ? (string) $look['avatar'] : BV_WS_DEFAULT_AVATAR;

    return '<svg class="bvw-look__svg" viewBox="0 0 100 100" width="' . $size . '" height="' . $size . '" role="img" aria-label="'
        . htmlspecialchars($label, ENT_QUOTES) . '"><circle cx="50" cy="50" r="38" fill="#fff" opacity=".9"/>'
        . bv_ws_avatar_svg($avatar) . bv_ws_frame_svg((string) ($look['frame'] ?? '')) . bv_ws_sticker_svg((string) ($look['sticker'] ?? '')) . '</svg>';
}

/** Мініатюра предмета для каталогу (без фону — фон показує CSS-клас картки). */
function bv_ws_item_svg(array $item): string
{
    $look = ['avatar' => BV_WS_DEFAULT_AVATAR, 'frame' => $item['kind'] === 'frame' ? $item['key'] : null,
        'sticker' => $item['kind'] === 'sticker' ? $item['key'] : null];

    return bv_ws_look_svg($look, 72, $item['title']);
}

/** Чи є в коді малюнок для предмета (без малюнка предмет не показується й не продається). */
function bv_ws_has_art(array $item): bool
{
    return match ($item['kind']) {
        'frame' => bv_ws_frame_svg($item['key']) !== '',
        'sticker' => bv_ws_sticker_svg($item['key']) !== '',
        'background' => in_array($item['key'], ['bg_sunset', 'bg_night', 'bg_meadow', 'bg_city'], true),
        default => false,
    };
}

// ---------- Дані ----------------------------------------------------------------------------------------------------

/** Активний каталог (з БД, без таблиці чи рядків — запасний). @return array<string, array> item_key => предмет */
function bv_ws_catalog(PDO $pdo, string $lang = 'uk'): array
{
    $rows = [];
    try {
        $st = $pdo->prepare("SELECT item_key AS `key`, kind, title, description, price, sort FROM bv_workshop_items
                             WHERE lang = :l AND status = 'active' ORDER BY sort, item_key");
        $st->execute([':l' => bv_lang($lang)]);
        $rows = $st->fetchAll(PDO::FETCH_ASSOC);
    } catch (Throwable) {
        $rows = [];
    }
    $rows = $rows !== [] ? $rows : bv_ws_items_content();
    $out = [];
    foreach ($rows as $r) {
        $it = ['key' => (string) $r['key'], 'kind' => (string) $r['kind'], 'title' => (string) $r['title'],
            'description' => (string) $r['description'], 'price' => (int) $r['price']];
        if (isset(BV_WS_KINDS[$it['kind']]) && $it['price'] > 0 && bv_ws_has_art($it)) {
            $out[$it['key']] = $it;
        }
    }

    return $out;
}

/** @return array<string,int> item_key => price_paid */
function bv_ws_owned(PDO $pdo, int $userId): array
{
    $st = $pdo->prepare('SELECT item_key, price_paid FROM bv_user_items WHERE user_id = :u');
    $st->execute([':u' => $userId]);

    return array_map('intval', $st->fetchAll(PDO::FETCH_KEY_PAIR) ?: []);
}

/** Монети: зароблено, витрачено, лишилось. */
function bv_ws_balance(PDO $pdo, int $userId): array
{
    $earned = bv_totals($pdo, $userId)['coins'];
    $st = $pdo->prepare('SELECT COALESCE(SUM(price_paid), 0) FROM bv_user_items WHERE user_id = :u');
    $st->execute([':u' => $userId]);
    $spent = (int) $st->fetchColumn();

    return ['earned' => $earned, 'spent' => $spent, 'coins' => max(0, $earned - $spent)];
}

/** Вигляд гравця (без запису — аватар за замовчуванням, нічого не вдягнуто). Вдягнуте, але вимкнене в каталозі, не показується. */
function bv_ws_look(PDO $pdo, int $userId): array
{
    $look = ['avatar' => BV_WS_DEFAULT_AVATAR, 'frame' => null, 'sticker' => null, 'background' => null];
    try {
        $st = $pdo->prepare('SELECT avatar, frame, sticker, background FROM bv_user_look WHERE user_id = :u');
        $st->execute([':u' => $userId]);
        $row = $st->fetch(PDO::FETCH_ASSOC);
    } catch (Throwable) {
        $row = false;
    }
    if ($row) {
        $cat = bv_ws_catalog($pdo);
        $look['avatar'] = isset(BV_WS_AVATARS[(string) $row['avatar']]) ? (string) $row['avatar'] : BV_WS_DEFAULT_AVATAR;
        foreach (array_keys(BV_WS_KINDS) as $k) {
            $v = (string) ($row[$k] ?? '');
            $look[$k] = $v !== '' && isset($cat[$v]) && $cat[$v]['kind'] === $k ? $v : null;
        }
    }

    return $look;
}

function bv_ws_save_look(PDO $pdo, int $userId, array $look): void
{
    $pdo->prepare('INSERT INTO bv_user_look (user_id, avatar, frame, sticker, background, updated_at) VALUES (:u, :a, :f, :s, :b, :t)
                   ON DUPLICATE KEY UPDATE avatar = VALUES(avatar), frame = VALUES(frame), sticker = VALUES(sticker),
                       background = VALUES(background), updated_at = VALUES(updated_at)')
        ->execute([':u' => $userId, ':a' => $look['avatar'], ':f' => $look['frame'], ':s' => $look['sticker'], ':b' => $look['background'],
            ':t' => bv_now()]);
}

/**
 * Купівля за монети гри. Одна транзакція з блокуванням рядка гравця: баланс рахується всередині, тож паралельні
 * купівлі не витратять ті самі монети двічі; повторна купівля того самого предмета неможлива (PRIMARY KEY).
 * @return array{ok:bool, error?:string, item?:array, balance?:array}
 */
function bv_ws_buy(PDO $pdo, int $userId, string $key): array
{
    $item = bv_ws_catalog($pdo)[$key] ?? null;
    if ($item === null) {
        return ['ok' => false, 'error' => 'not_found'];
    }
    $pdo->beginTransaction();
    try {
        $lock = $pdo->prepare('SELECT user_id FROM bv_players WHERE user_id = :u AND age_confirmed_at IS NOT NULL FOR UPDATE');
        $lock->execute([':u' => $userId]);
        if ($lock->fetchColumn() === false) {
            $pdo->rollBack();

            return ['ok' => false, 'error' => 'auth_required'];
        }
        if (isset(bv_ws_owned($pdo, $userId)[$key])) {
            $pdo->rollBack();

            return ['ok' => false, 'error' => 'owned'];
        }
        $bal = bv_ws_balance($pdo, $userId);
        if ($bal['coins'] < $item['price']) {
            $pdo->rollBack();

            return ['ok' => false, 'error' => 'not_enough', 'balance' => $bal, 'price' => $item['price']];
        }
        $pdo->prepare('INSERT INTO bv_user_items (user_id, item_key, price_paid, bought_at) VALUES (:u, :k, :p, :t)')
            ->execute([':u' => $userId, ':k' => $key, ':p' => $item['price'], ':t' => bv_now()]);
        $pdo->commit();
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }
        if ($e instanceof PDOException && (string) $e->getCode() === '23000') {
            return ['ok' => false, 'error' => 'owned'];
        }
        throw $e;
    }

    return ['ok' => true, 'item' => $item, 'balance' => bv_ws_balance($pdo, $userId)];
}

/** Вдягнути куплений предмет свого виду або зняти ($key = ''). */
function bv_ws_equip(PDO $pdo, int $userId, string $kind, string $key): array
{
    if (!isset(BV_WS_KINDS[$kind])) {
        return ['ok' => false, 'error' => 'bad_request'];
    }
    $look = bv_ws_look($pdo, $userId);
    if ($key === '') {
        $look[$kind] = null;
    } else {
        $item = bv_ws_catalog($pdo)[$key] ?? null;
        if ($item === null || $item['kind'] !== $kind) {
            return ['ok' => false, 'error' => 'not_found'];
        }
        if (!isset(bv_ws_owned($pdo, $userId)[$key])) {
            return ['ok' => false, 'error' => 'not_owned'];
        }
        $look[$kind] = $key;
    }
    bv_ws_save_look($pdo, $userId, $look);

    return ['ok' => true, 'look' => $look];
}

/** Аватар — лише з набору BV_WS_AVATARS (безкоштовно). */
function bv_ws_set_avatar(PDO $pdo, int $userId, string $avatar): array
{
    if (!isset(BV_WS_AVATARS[$avatar])) {
        return ['ok' => false, 'error' => 'not_found'];
    }
    $look = bv_ws_look($pdo, $userId);
    $look['avatar'] = $avatar;
    bv_ws_save_look($pdo, $userId, $look);

    return ['ok' => true, 'look' => $look];
}
