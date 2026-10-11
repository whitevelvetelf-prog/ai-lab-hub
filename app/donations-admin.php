<?php

declare(strict_types=1);

/**
 * AI LAB HUB — розділ-акордеон «Донати» в кабінеті (лише role='admin').
 * Форма відправляється на public/donations-admin-action.php.
 * Значення реквізитів живуть лише в БД (site_settings), не в коді.
 */

require_once __DIR__ . '/donations.php';

function donations_admin_render(PDO $pdo, array $user): void
{
    if (!donate_is_admin($pdo, (int) $user['id'])) {
        return;
    }
    $flash = $_SESSION['donate_flash'] ?? null;
    $old = $_SESSION['donate_old'] ?? null;
    unset($_SESSION['donate_flash'], $_SESSION['donate_old']);

    $tableOk = true;
    try {
        $pdo->query('SELECT 1 FROM site_settings LIMIT 1');
    } catch (Throwable $e) {
        $tableOk = false;
    }
    $cfg = donate_config($pdo);
    if (is_array($old)) {
        foreach ($cfg as $k => $v) {
            $cfg[$k] = is_string($old[$k] ?? null) ? $old[$k] : (DONATE_FIELDS[$k] === 'flag' ? (!empty($old[$k]) ? '1' : '0') : '');
        }
    }
    $labels = donate_field_labels();
    $e = static fn(mixed $v): string => htmlspecialchars((string) $v, ENT_QUOTES);
    $field = static function (string $key, string $hint = '', string $placeholder = '', bool $textarea = false) use ($cfg, $labels, $e): string {
        $control = $textarea
            ? '<textarea name="' . $key . '" rows="4">' . $e($cfg[$key]) . '</textarea>'
            : '<input type="text" name="' . $key . '" value="' . $e($cfg[$key]) . '" placeholder="' . $e($placeholder) . '" autocomplete="off" spellcheck="false">';

        return '<label class="dn-field"><span>' . $e($labels[$key]) . ($hint !== '' ? ' <small>' . $e($hint) . '</small>' : '') . '</span>' . $control . '</label>';
    };
    ?>
            <div class="accordion" id="acc-donate">
                <button type="button" class="accordion__header" aria-expanded="false" aria-controls="acc-donate-panel">
                    <span class="accordion__title">Донати<?= $cfg['donate_enabled'] === '1' ? '' : ' · сторінку вимкнено' ?></span>
                    <span class="accordion__chevron" aria-hidden="true">&#9662;</span>
                </button>
                <div class="accordion__panel" id="acc-donate-panel">
                    <div class="accordion__panel-inner dn-admin">
                        <?php if (!$tableOk): ?>
                        <p class="dn-flash dn-flash--error">Таблиці site_settings ще немає — застосуйте міграцію database/migration-2026-10-11-site-settings.sql.</p>
                        <?php endif; ?>
                        <?php if (is_array($flash) && !empty($flash['msgs'])): ?>
                        <div class="dn-flash <?= !empty($flash['ok']) ? 'dn-flash--ok' : 'dn-flash--error' ?>" role="status">
                            <?php foreach ($flash['msgs'] as $m): ?><p><?= $e($m) ?></p><?php endforeach; ?>
                        </div>
                        <?php endif; ?>
                        <p class="dn-muted">Усі поля необов'язкові: на сторінці <a href="donate.php" target="_blank" rel="noopener">donate.php</a> показуються лише заповнені. Поки сторінку вимкнено, кнопка «Підтримати проєкт» у підвалі веде на неї, але там лише нейтральний текст «Скоро».</p>

                        <form method="post" action="donations-admin-action.php" class="dn-form" autocomplete="off">
                            <input type="hidden" name="csrf" value="<?= $e(donate_csrf_token()) ?>">
                            <label class="dn-check"><input type="checkbox" name="donate_enabled" value="1"<?= $cfg['donate_enabled'] === '1' ? ' checked' : '' ?>> <strong><?= $e($labels['donate_enabled']) ?></strong></label>

                            <h3 class="dn-h3">Для донатів з України</h3>
                            <?= $field('donate_jar_url', 'лише https://', 'https://') ?>
                            <label class="dn-check"><input type="checkbox" name="donate_show_qr" value="1"<?= $cfg['donate_show_qr'] === '1' ? ' checked' : '' ?>> <?= $e($labels['donate_show_qr']) ?></label>
                            <div class="dn-grid">
                                <?= $field('donate_card_number', 'перевіряється алгоритмом Луна') ?>
                                <?= $field('donate_card_holder', 'показується й для IBAN') ?>
                            </div>
                            <?= $field('donate_iban_uah', 'UA + 27 цифр', 'UA…') ?>

                            <h3 class="dn-h3">Для міжнародних переказів</h3>
                            <div class="dn-grid">
                                <?= $field('donate_iban_usd') ?>
                                <?= $field('donate_iban_eur') ?>
                                <?= $field('donate_swift', '8 або 11 символів') ?>
                                <?= $field('donate_bank_name') ?>
                            </div>

                            <h3 class="dn-h3">Тексти</h3>
                            <?= $field('donate_purpose', 'порожньо — «' . DONATE_DEFAULT_PURPOSE . '»', DONATE_DEFAULT_PURPOSE) ?>
                            <?= $field('donate_text_uk', 'показується під вступом українською', '', true) ?>
                            <?= $field('donate_text_en', 'показується під вступом англійською', '', true) ?>

                            <button type="submit" class="dn-btn">Зберегти</button>
                        </form>
                    </div>
                </div>
            </div>
            <style>
                .dn-admin { color: #ffffff; }
                .dn-admin a { color: #bcd0ff; }
                .dn-admin a:hover { color: #ffffff; }
                .dn-muted, .dn-admin small { color: #c9d3f2; font-size: 0.85rem; }
                .dn-h3 { margin: 22px 0 10px; font-size: 1.02rem; }
                .dn-grid { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 0 16px; }
                .dn-field { display: block; margin: 0 0 14px; min-width: 0; }
                .dn-field > span { display: block; margin-bottom: 6px; font-size: 0.88rem; font-weight: 600; }
                .dn-field small { font-weight: 400; }
                .dn-field input, .dn-field textarea {
                    box-sizing: border-box; width: 100%; max-width: 100%; padding: 9px 11px; border-radius: 10px;
                    border: 1px solid rgba(255, 255, 255, 0.25); background: #11163f; color: #ffffff; font: inherit; font-size: 0.92rem;
                }
                .dn-field input:focus, .dn-field textarea:focus { outline: 2px solid #5b8cff; outline-offset: 0; }
                .dn-check { display: flex; gap: 8px; align-items: center; margin: 0 0 14px; cursor: pointer; }
                .dn-btn {
                    padding: 10px 20px; border-radius: 999px; border: 0; background: #5b8cff; color: #ffffff;
                    font: inherit; font-weight: 600; cursor: pointer;
                }
                .dn-btn:hover { background: #7aa2ff; }
                .dn-flash { margin: 0 0 14px; padding: 10px 14px; border-radius: 10px; }
                .dn-flash p { margin: 4px 0; }
                .dn-flash--ok { background: rgba(52, 211, 153, 0.15); border: 1px solid rgba(52, 211, 153, 0.5); }
                .dn-flash--error { background: rgba(248, 113, 113, 0.15); border: 1px solid rgba(248, 113, 113, 0.55); }
                @media (max-width: 640px) { .dn-grid { grid-template-columns: minmax(0, 1fr); } }
            </style>
    <?php
}
