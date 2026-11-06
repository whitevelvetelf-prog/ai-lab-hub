<?php

declare(strict_types=1);

/**
 * AI LAB HUB — чернетки форм подачі оголошень (таблиця mp_form_drafts, міграція 2026-11-06).
 *
 * Форма автоматично зберігає введене на сервері (public/mp-draft.php, public/assets/js/mp-draft.js) —
 * дані не губляться при вході, підтвердженні пошти, закритті вкладки чи переході з іншого пристрою.
 * Одна чернетка на (користувач, форма); після успішної подачі чернетка видаляється.
 * Чернетки нових оголошень. Редагування наявного оголошення не потребує чернетки (дані вже в mp_listings).
 * Без міграції функції тихо повертають порожнє (форми працюють як раніше).
 */

const MPD_FORMS = ['listing:job', 'listing:course', 'listing:service', 'board'];
const MPD_MAX_BYTES = 60000;

function mpd_available(PDO $pdo): bool
{
    static $ok = null;
    if ($ok === null) {
        try {
            $pdo->query('SELECT 1 FROM mp_form_drafts LIMIT 0');
            $ok = true;
        } catch (Throwable $e) {
            $ok = false;
        }
    }

    return $ok;
}

function mpd_key_valid(string $key): bool
{
    return in_array($key, MPD_FORMS, true);
}

/** Адреса форми для чернетки. */
function mpd_form_url(string $key): string
{
    return $key === 'board' ? 'marketplace-post.php' : 'listing-post.php?type=' . substr($key, 8);
}

/** @return array{data:array<string,mixed>,title:string,updated_at:string}|null */
function mpd_get(PDO $pdo, int $userId, string $key): ?array
{
    if (!mpd_key_valid($key) || !mpd_available($pdo)) {
        return null;
    }
    $st = $pdo->prepare('SELECT title, data_json, updated_at FROM mp_form_drafts WHERE user_id = :u AND form_key = :k');
    $st->execute([':u' => $userId, ':k' => $key]);
    $r = $st->fetch(PDO::FETCH_ASSOC);
    if ($r === false) {
        return null;
    }
    $data = json_decode((string) $r['data_json'], true);

    return is_array($data) ? ['data' => $data, 'title' => (string) $r['title'], 'updated_at' => (string) $r['updated_at']] : null;
}

/**
 * Очищує дані форми: лише рядки й списки рядків, імена полів — латиниця/цифри/[]_; службові поля відкидаються.
 *
 * @return array<string,string|list<string>>
 */
function mpd_clean(array $data): array
{
    $out = [];
    foreach ($data as $name => $val) {
        $name = (string) $name;
        if (preg_match('/^[A-Za-z0-9_\[\]]{1,60}$/', $name) !== 1 || in_array($name, ['csrf', 'ft', 'website', 'form_key'], true)) {
            continue;
        }
        if (is_string($val)) {
            $out[$name] = mb_substr($val, 0, 10000);
        } elseif (is_array($val)) {
            $out[$name] = array_values(array_map(static fn($x): string => mb_substr((string) $x, 0, 500), array_filter($val, 'is_scalar')));
        }
        if (count($out) >= 80) {
            break;
        }
    }

    return $out;
}

function mpd_save(PDO $pdo, int $userId, string $key, array $data): bool
{
    if (!mpd_key_valid($key) || !mpd_available($pdo)) {
        return false;
    }
    $data = mpd_clean($data);
    $json = json_encode($data, JSON_UNESCAPED_UNICODE);
    if ($json === false || strlen($json) > MPD_MAX_BYTES) {
        return false;
    }
    $title = trim((string) ($data['title'] ?? ''));
    $st = $pdo->prepare(
        'INSERT INTO mp_form_drafts (user_id, form_key, title, data_json) VALUES (:u, :k, :t, :j)
         ON DUPLICATE KEY UPDATE title = VALUES(title), data_json = VALUES(data_json), updated_at = CURRENT_TIMESTAMP'
    );

    return $st->execute([':u' => $userId, ':k' => $key, ':t' => mb_substr($title, 0, 200), ':j' => $json]);
}

function mpd_delete(PDO $pdo, int $userId, string $key): void
{
    if (mpd_key_valid($key) && mpd_available($pdo)) {
        $pdo->prepare('DELETE FROM mp_form_drafts WHERE user_id = :u AND form_key = :k')->execute([':u' => $userId, ':k' => $key]);
    }
}

/** @return list<array{form_key:string,title:string,updated_at:string}> */
function mpd_list(PDO $pdo, int $userId): array
{
    if (!mpd_available($pdo)) {
        return [];
    }
    $st = $pdo->prepare('SELECT form_key, title, updated_at FROM mp_form_drafts WHERE user_id = :u ORDER BY updated_at DESC');
    $st->execute([':u' => $userId]);

    return array_values(array_filter($st->fetchAll(PDO::FETCH_ASSOC), static fn($r) => mpd_key_valid((string) $r['form_key'])));
}

/**
 * HTML для форми: атрибути автозбереження + JSON збереженої чернетки (відновлюється скриптом, якщо форма порожня).
 * $restore = false — форма вже має дані (POST з помилками або редагування) — чернетку не підставляємо.
 *
 * @return array{attrs:string,html:string}
 */
function mpd_form_bits(PDO $pdo, int $userId, string $key, bool $restore): array
{
    if (!mpd_available($pdo) || !mpd_key_valid($key)) {
        return ['attrs' => '', 'html' => ''];
    }
    $draft = $restore ? mpd_get($pdo, $userId, $key) : null;
    $attrs = ' data-draft-key="' . htmlspecialchars($key, ENT_QUOTES) . '" data-draft-url="mp-draft.php"'
        . ' data-draft-saved="' . htmlspecialchars(mpf_tr('draft_saved'), ENT_QUOTES) . '"'
        . ' data-draft-saving="' . htmlspecialchars(mpf_tr('draft_saving'), ENT_QUOTES) . '"';
    $html = '<p class="mp-hint mpd-status" data-draft-status aria-live="polite"></p>';
    if ($draft !== null) {
        $when = date('d.m.Y H:i', (int) strtotime($draft['updated_at']));
        $html .= '<script type="application/json" data-draft-json>' . json_encode($draft['data'], JSON_UNESCAPED_UNICODE | JSON_HEX_TAG | JSON_HEX_AMP | JSON_HEX_APOS | JSON_HEX_QUOT) . '</script>'
            . '<div class="mp-callout mpd-restored" data-draft-restored hidden>' . htmlspecialchars(mpf_tr('draft_restored', $when), ENT_QUOTES)
            . ' <button type="button" class="mp-btn mp-btn--small" data-draft-discard>' . htmlspecialchars(mpf_tr('draft_discard'), ENT_QUOTES) . '</button></div>';
    }

    return ['attrs' => $attrs, 'html' => $html];
}
