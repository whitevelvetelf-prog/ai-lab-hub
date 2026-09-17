<?php

declare(strict_types=1);

/**
 * AI LAB HUB — мовонезалежний рушій кешування перекладу.
 *
 * Тут немає жодного хардкоду 'uk' / 'en' — лише читання
 * config/languages.php. Використовується і для контенту з БД
 * (product_translations, pricing_plan_translations), і для статичних
 * написів інтерфейсу (ui_translations, через app/translations.php).
 *
 * Правило кешування, однакове для всіх трьох таблиць:
 *   1. Мова = мова оригіналу (translation_source_lang()) → переклад не
 *      шукається й не кешується взагалі, повертається сам оригінал.
 *   2. Є рядок у таблиці перекладів для (сутність, поле, мова) →
 *      повертається він, байдуже — auto чи manual.
 *   3. Нема рядка → переклад через Google Translation API, кешується
 *      з source='auto'.
 *   4. Рядок із source='manual' (вручну вичитаний у CRM) — автопереклад
 *      НІКОЛИ не перезаписує його повторно (INSERT ... ON DUPLICATE KEY
 *      UPDATE нижче лишає manual-рядки недоторканими).
 */

require_once __DIR__ . '/../config/languages.php';

/** Конфіг мов (config/languages.php), прочитаний один раз за запит. */
function languages_config(): array
{
    static $config = null;
    if ($config === null) {
        $config = require __DIR__ . '/../config/languages.php';
    }

    return $config;
}

/** Мова оригіналу контенту (наразі 'uk') — єдине місце, що це знає. */
function translation_source_lang(): string
{
    return languages_config()['source'];
}

/** Активні мови інтерфейсу: код => підпис перемикача, у порядку показу. */
function active_languages(): array
{
    return languages_config()['active'];
}

/** Коди активних мов (без підписів) — для перевірки/валідації вибору. */
function active_lang_codes(): array
{
    return array_keys(active_languages());
}

/** Ключ Google Cloud Translation API (config/translation.php), прочитаний один раз. */
function translation_api_key(): string
{
    static $apiKey = null;
    if ($apiKey === null) {
        $apiKey = (string) require __DIR__ . '/../config/translation.php';
    }

    return $apiKey;
}

/**
 * Переклад кількох текстів ОДНИМ запитом до Google Cloud Translation API
 * (v2 приймає масив у 'q') — для батч-прогріву кешу, щоб не робити по
 * одному HTTP-запиту на кожне поле. null — весь запит не вдався (мережа,
 * ключ, порожня/невалідна відповідь); викликач має самостійно розв'язати,
 * що робити з цим блоком (за замовчуванням — не кешувати й не показувати
 * помилку користувачу, лишити оригінал).
 *
 * @param list<string> $texts
 * @return list<string>|null Переклади в тому самому порядку, що й $texts.
 */
function google_translate_batch(array $texts, string $targetLang, string $sourceLang): ?array
{
    if ($texts === []) {
        return [];
    }

    $apiKey = translation_api_key();
    if ($apiKey === '' || $apiKey === 'YOUR_API_KEY_HERE') {
        return null;
    }

    $payload = json_encode([
        'q' => array_values($texts),
        'source' => $sourceLang,
        'target' => $targetLang,
        'format' => 'text',
    ], JSON_UNESCAPED_UNICODE);

    if ($payload === false) {
        return null;
    }

    $ch = curl_init('https://translation.googleapis.com/language/translate/v2?key=' . urlencode($apiKey));
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_HTTPHEADER => ['Content-Type: application/json; charset=utf-8'],
        CURLOPT_POSTFIELDS => $payload,
        CURLOPT_CONNECTTIMEOUT => 5,
        CURLOPT_TIMEOUT => 30,
    ]);
    $body = curl_exec($ch);
    $code = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    curl_close($ch);

    if (!is_string($body) || $body === '' || $code >= 400) {
        return null;
    }

    $data = json_decode($body, true);
    $translations = $data['data']['translations'] ?? null;
    if (!is_array($translations) || count($translations) !== count($texts)) {
        return null;
    }

    $result = [];
    foreach ($translations as $item) {
        $text = $item['translatedText'] ?? null;
        if (!is_string($text)) {
            return null;
        }
        $result[] = $text;
    }

    return $result;
}

/**
 * Переклад одного тексту через Google Cloud Translation API. null —
 * переклад не вдався (мережа, ключ, порожня відповідь); викликач має
 * показати оригінал, а не порожній текст.
 */
function google_translate_text(string $text, string $targetLang, string $sourceLang): ?string
{
    if (trim($text) === '') {
        return null;
    }

    $batch = google_translate_batch([$text], $targetLang, $sourceLang);
    if ($batch === null || !isset($batch[0]) || $batch[0] === '') {
        return null;
    }

    return $batch[0];
}

/**
 * Пошук закешованого перекладу в одній з трьох таблиць перекладу.
 *
 * @param array<string, int|string> $keyColumns Стовпці, що ідентифікують
 *        сутність — напр. ['product_id' => 5, 'field_name' => 'short_description']
 *        або ['key_name' => 'nav_home'] для ui_translations.
 * @return array{translated_text: string, source: string}|null
 */
function translation_lookup(PDO $pdo, string $table, array $keyColumns, string $lang): ?array
{
    $conditions = ['lang = :lang'];
    $params = [':lang' => $lang];
    foreach ($keyColumns as $column => $value) {
        $conditions[] = "{$column} = :{$column}";
        $params[":{$column}"] = $value;
    }

    $stmt = $pdo->prepare(
        "SELECT translated_text, source FROM {$table} WHERE " . implode(' AND ', $conditions) . ' LIMIT 1'
    );
    $stmt->execute($params);
    $row = $stmt->fetch(PDO::FETCH_ASSOC);

    return $row !== false ? $row : null;
}

/**
 * Кешує переклад. manual-рядки (вичитані вручну в CRM) ніколи не
 * перезаписуються повторним викликом із source='auto' — саме тому
 * автопереклад надалі не затирає вручну виправлений текст.
 *
 * @param array<string, int|string> $keyColumns Те саме, що й у translation_lookup().
 */
function translation_store(PDO $pdo, string $table, array $keyColumns, string $lang, string $text, string $source): void
{
    $columns = $keyColumns;
    $columns['lang'] = $lang;
    $columns['translated_text'] = $text;
    $columns['source'] = $source;

    $names = array_keys($columns);
    $placeholders = array_map(static fn (string $name): string => ":{$name}", $names);

    $sql = "INSERT INTO {$table} (" . implode(', ', $names) . ') VALUES (' . implode(', ', $placeholders) . ') '
        . "ON DUPLICATE KEY UPDATE "
        . "translated_text = IF(source = 'manual', translated_text, VALUES(translated_text)), "
        . "source = IF(source = 'manual', source, VALUES(source))";

    $params = [];
    foreach ($columns as $name => $value) {
        $params[":{$name}"] = $value;
    }

    $pdo->prepare($sql)->execute($params);
}

/**
 * Головна функція: переклад тексту сутності поточною мовою з кешуванням.
 *
 * Мова = мова оригіналу → повертає $sourceText без звернення до таблиці.
 * Інакше: кеш → якщо нема, Google Translate й кешування (source='auto').
 * Помилка перекладу (мережа/ключ) — повертає оригінал, нічого не кешує,
 * щоб наступний запит спробував ще раз.
 */
function cached_translation(PDO $pdo, string $table, array $keyColumns, string $lang, string $sourceText): string
{
    if ($lang === translation_source_lang() || trim($sourceText) === '') {
        return $sourceText;
    }

    $cached = translation_lookup($pdo, $table, $keyColumns, $lang);
    if ($cached !== null && trim($cached['translated_text']) !== '') {
        return $cached['translated_text'];
    }

    $translated = google_translate_text($sourceText, $lang, translation_source_lang());
    if ($translated === null) {
        return $sourceText;
    }

    translation_store($pdo, $table, $keyColumns, $lang, $translated, 'auto');

    return $translated;
}
