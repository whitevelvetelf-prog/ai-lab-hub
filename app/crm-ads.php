<?php

declare(strict_types=1);

/**
 * AI LAB HUB — спільні хелпери CRM реклами (crm-ads-list.php,
 * crm-add-campaign.php, crm-edit-campaign.php). Таблиці — ad_campaigns,
 * ads, ad_zones (database/increment_latest.sql).
 */

const CRM_ADS_UPLOAD_DIR = __DIR__ . '/../public/assets/images/ads/uploads';
const CRM_ADS_UPLOAD_URL = '/assets/images/ads/uploads/';

/** Екранування для HTML. */
function crm_ads_e(mixed $value): string
{
    return htmlspecialchars((string) $value, ENT_QUOTES);
}

/** Доступ до CRM реклами — лише admin (інакше в кабінет). */
function crm_ads_require_admin(): void
{
    if (auth_role() !== 'admin') {
        header('Location: account.php');
        exit;
    }
}

/** Коректна дата Y-m-d або null. */
function crm_ads_parse_date(string $value): ?string
{
    $d = DateTime::createFromFormat('!Y-m-d', $value);
    return ($d !== false && $d->format('Y-m-d') === $value) ? $value : null;
}

/**
 * Валідація полів кампанії з форми.
 *
 * Внутрішня: email / дата завершення необов'язкові, суми немає.
 * Платна: email, дата завершення та сума обов'язкові.
 *
 * @return array{0:list<string>,1:array<string,mixed>} [помилки, дані для БД]
 */
function crm_ads_parse_campaign(array $in, bool $withStatus): array
{
    $errors = [];

    $type = (string) ($in['campaign_type'] ?? 'paid');
    if (!in_array($type, ['paid', 'internal'], true)) {
        $type = 'paid';
    }
    $isPaid = $type === 'paid';

    $advertiser = trim((string) ($in['advertiser_name'] ?? ''));
    if ($advertiser === '') {
        $errors[] = 'Вкажіть назву рекламодавця.';
    } elseif (mb_strlen($advertiser) > 255) {
        $errors[] = 'Назва рекламодавця задовга (максимум 255 символів).';
    }

    $email = trim((string) ($in['contact_email'] ?? ''));
    if ($email === '') {
        if ($isPaid) {
            $errors[] = 'Вкажіть email рекламодавця.';
        }
    } elseif (filter_var($email, FILTER_VALIDATE_EMAIL) === false || mb_strlen($email) > 255) {
        $errors[] = 'Email рекламодавця некоректний.';
    }

    $start = crm_ads_parse_date(trim((string) ($in['start_date'] ?? '')));
    if ($start === null) {
        $errors[] = 'Вкажіть коректну дату початку.';
    }

    $endRaw = trim((string) ($in['end_date'] ?? ''));
    $end = null;
    if ($endRaw !== '') {
        $end = crm_ads_parse_date($endRaw);
        if ($end === null) {
            $errors[] = 'Дата завершення некоректна.';
        } elseif ($start !== null && $end < $start) {
            $errors[] = 'Дата завершення не може бути раніше дати початку.';
        }
    } elseif ($isPaid) {
        $errors[] = 'Для платної кампанії вкажіть дату завершення.';
    }

    $amount = null;
    if ($isPaid) {
        $amountRaw = str_replace([' ', ','], ['', '.'], trim((string) ($in['paid_amount'] ?? '')));
        if ($amountRaw === '' || !is_numeric($amountRaw) || (float) $amountRaw < 0 || (float) $amountRaw > 99999999.99) {
            $errors[] = 'Вкажіть коректну суму оплати (число від 0).';
        } else {
            $amount = number_format((float) $amountRaw, 2, '.', '');
        }
    }

    $status = 'active';
    if ($withStatus) {
        $status = (string) ($in['status'] ?? 'active');
        if (!in_array($status, ['active', 'paused', 'expired'], true)) {
            $status = 'active';
        }
    }

    $notes = trim((string) ($in['notes'] ?? ''));

    return [$errors, [
        'campaign_type'   => $type,
        'advertiser_name' => $advertiser,
        'contact_email'   => $email !== '' ? $email : null,
        'payment_type'    => $isPaid ? 'fixed_period' : null,
        'paid_amount'     => $amount,
        'status'          => $status,
        'start_date'      => $start,
        'end_date'        => $end,
        'notes'           => $notes !== '' ? $notes : null,
    ]];
}

/** Лише http(s) або відносний шлях (без javascript:/data: тощо). */
function crm_ads_is_safe_url(string $url): bool
{
    if ($url === '' || mb_strlen($url) > 500 || preg_match('/\s/', $url) === 1) {
        return false;
    }
    if (preg_match('#^https?://[^/]+#i', $url) === 1) {
        return true;
    }
    return preg_match('#^[a-z][a-z0-9+.-]*:#i', $url) !== 1 && !str_starts_with($url, '//');
}

/**
 * Завантаження зображення оголошення (PNG/JPG/WEBP/GIF/SVG, до 2 МБ).
 * Повертає публічний URL або null (помилки додаються в $errors).
 * Якщо файл не обрано — null без помилки.
 */
function crm_ads_store_image(array $file, array &$errors): ?string
{
    $code = (int) ($file['error'] ?? UPLOAD_ERR_NO_FILE);
    if ($code === UPLOAD_ERR_NO_FILE) {
        return null;
    }
    if ($code === UPLOAD_ERR_INI_SIZE || $code === UPLOAD_ERR_FORM_SIZE || ($file['size'] ?? 0) > 2 * 1024 * 1024) {
        $errors[] = 'Файл зображення завеликий: максимум 2 МБ.';
        return null;
    }
    if ($code !== UPLOAD_ERR_OK || !is_uploaded_file((string) $file['tmp_name'])) {
        $errors[] = 'Не вдалося завантажити зображення (код ' . $code . ').';
        return null;
    }

    $ext = strtolower(pathinfo((string) $file['name'], PATHINFO_EXTENSION));
    if (!in_array($ext, ['png', 'jpg', 'jpeg', 'webp', 'gif', 'svg'], true)) {
        $errors[] = 'Дозволені формати зображення: PNG, JPG, WEBP, GIF, SVG.';
        return null;
    }

    if (!is_dir(CRM_ADS_UPLOAD_DIR) && !mkdir(CRM_ADS_UPLOAD_DIR, 0775, true) && !is_dir(CRM_ADS_UPLOAD_DIR)) {
        $errors[] = 'Не вдалося створити теку для зображень.';
        return null;
    }

    $name = 'ad-' . date('Ymd-His') . '-' . bin2hex(random_bytes(4)) . '.' . $ext;
    if (!move_uploaded_file((string) $file['tmp_name'], CRM_ADS_UPLOAD_DIR . '/' . $name)) {
        $errors[] = 'Не вдалося зберегти зображення на сервері.';
        return null;
    }

    return CRM_ADS_UPLOAD_URL . $name;
}

function crm_ads_type_label(string $type): string
{
    return $type === 'internal' ? 'Внутрішня' : 'Платна';
}

/**
 * Ефективний статус для показу: активна кампанія, чий end_date уже
 * минув, фактично не показується (getAdForZone) — виводимо як «Завершена».
 */
function crm_ads_effective_status(array $campaign): string
{
    $status = (string) $campaign['status'];
    if ($status === 'active' && $campaign['end_date'] !== null && (string) $campaign['end_date'] < date('Y-m-d')) {
        return 'expired';
    }
    return $status;
}

function crm_ads_status_label(string $status): string
{
    return ['active' => 'Активна', 'paused' => 'На паузі', 'expired' => 'Завершена'][$status] ?? $status;
}

/** Дата d.m.Y або «—». */
function crm_ads_date_cell(?string $date): string
{
    $ts = $date !== null ? strtotime($date) : false;
    return $ts ? date('d.m.Y', $ts) : '—';
}

/** HTML полів кампанії (спільно для add/edit) + перемикач платна/внутрішня. */
function crm_ads_campaign_fields(array $v, bool $withStatus): void
{
    $type = (string) ($v['campaign_type'] ?? 'paid');
    ?>
        <div class="field">
            <span class="field__label">Тип кампанії</span>
            <div class="seg" role="radiogroup">
                <label class="seg__item"><input type="radio" name="campaign_type" value="paid"<?= $type === 'paid' ? ' checked' : '' ?>> Платна</label>
                <label class="seg__item"><input type="radio" name="campaign_type" value="internal"<?= $type === 'internal' ? ' checked' : '' ?>> Внутрішня</label>
            </div>
            <p class="field__hint">Внутрішня — власне промо AI LAB HUB: без суми, email і дати завершення. Платні кампанії мають пріоритет над внутрішніми.</p>
        </div>

        <div class="field">
            <label class="field__label" for="advertiser_name">Назва рекламодавця <span class="req">*</span></label>
            <input class="input" type="text" id="advertiser_name" name="advertiser_name" maxlength="255" value="<?= crm_ads_e($v['advertiser_name'] ?? '') ?>" required>
        </div>

        <div class="field">
            <label class="field__label" for="contact_email">Email <span class="req js-paid-req">*</span></label>
            <input class="input" type="email" id="contact_email" name="contact_email" maxlength="255" value="<?= crm_ads_e($v['contact_email'] ?? '') ?>">
        </div>

        <div class="field-row">
            <div class="field">
                <label class="field__label" for="start_date">Дата початку <span class="req">*</span></label>
                <input class="input" type="date" id="start_date" name="start_date" value="<?= crm_ads_e($v['start_date'] ?? date('Y-m-d')) ?>" required>
            </div>
            <div class="field">
                <label class="field__label" for="end_date">Дата завершення <span class="req js-paid-req">*</span></label>
                <input class="input" type="date" id="end_date" name="end_date" value="<?= crm_ads_e($v['end_date'] ?? '') ?>">
            </div>
        </div>

        <div class="field" id="amountField">
            <label class="field__label" for="paid_amount">Сума оплати <span class="req">*</span></label>
            <input class="input" type="text" inputmode="decimal" id="paid_amount" name="paid_amount" value="<?= crm_ads_e($v['paid_amount'] ?? '') ?>" placeholder="0.00">
        </div>

        <?php if ($withStatus): ?>
        <div class="field">
            <label class="field__label" for="status">Статус</label>
            <select class="select" id="status" name="status">
                <?php foreach (['active', 'paused', 'expired'] as $st): ?>
                <option value="<?= $st ?>"<?= ($v['status'] ?? 'active') === $st ? ' selected' : '' ?>><?= crm_ads_e(crm_ads_status_label($st)) ?></option>
                <?php endforeach; ?>
            </select>
        </div>
        <?php endif; ?>

        <div class="field">
            <label class="field__label" for="notes">Нотатки</label>
            <textarea class="textarea" id="notes" name="notes"><?= crm_ads_e($v['notes'] ?? '') ?></textarea>
        </div>

        <script>
        (function () {
            var radios = document.querySelectorAll('input[name="campaign_type"]');
            var amountField = document.getElementById('amountField');
            var amountInput = document.getElementById('paid_amount');
            var paidReq = document.querySelectorAll('.js-paid-req');
            function sync() {
                var paid = document.querySelector('input[name="campaign_type"]:checked').value === 'paid';
                amountField.hidden = !paid;
                amountInput.disabled = !paid; // disabled-поле не надсилається
                paidReq.forEach(function (el) { el.hidden = !paid; });
            }
            radios.forEach(function (r) { r.addEventListener('change', sync); });
            sync();
        })();
        </script>
    <?php
}
