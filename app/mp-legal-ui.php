<?php

declare(strict_types=1);

/**
 * AI LAB HUB — частини інтерфейсу Правил Marketplace: форма скарги (розділи 10–11) і блок кабінету автора
 * (повідомлення, рішення модерації, скарги правовласників із запереченням, оскарження — п. 7.5, 10.3).
 * Логіка — app/mp-legal.php; тексти — app/mp-legal-i18n.php.
 */

require_once __DIR__ . '/mp-legal.php';

/**
 * Форма «Поскаржитися». Відправляється на mp-complaint.php (multipart: файл доказів).
 * Гостю — обов'язковий email (або вхід). Причина «Порушення авторських прав» відкриває обов'язкові поля п. 10.1.
 * $v — попередні значення (після помилки), $errors — ключі MPL_I18N.
 */
function mpl_complaint_form_html(int $listingId, ?int $userId, array $v = [], array $errors = [], bool $open = false): string
{
    $val = static fn(string $k): string => mp_e((string) ($v[$k] ?? ''));
    $reason = (string) ($v['reason'] ?? '');
    $isCr = $reason === 'copyright';
    $h = '<details class="mp-report" id="complaint"' . ($open || $errors !== [] ? ' open' : '') . '><summary>' . mp_e(mpl_tr('c_btn')) . '</summary>';
    if ($errors !== []) {
        $h .= '<div class="mp-alert mp-alert--error" role="alert"><ul class="mp-alert__list">';
        foreach ($errors as $e) {
            $h .= '<li>' . mp_e(in_array($e, ['c_err_limit', 'c_err_save'], true) ? mpl_tr($e, MP_ABUSE_EMAIL) : mpl_tr($e)) . '</li>';
        }
        $h .= '</ul></div>';
    }
    $h .= '<form method="post" action="mp-complaint.php" class="mp-form mpl-complaint" enctype="multipart/form-data">'
        . mp_csrf_field() . '<input type="hidden" name="id" value="' . $listingId . '">'
        . '<div class="mp-hp" aria-hidden="true"><label>Website <input type="text" name="website" value="" tabindex="-1" autocomplete="off"></label></div>';
    if ($userId === null) {
        $login = '<a href="' . mp_e(function_exists('auth_login_url') ? auth_login_url(auth_current_next()) : 'login.php') . '">' . mp_e(mpl_tr('c_login')) . '</a>';
        $h .= '<p class="mp-hint">' . sprintf(mp_e(mpl_tr('c_guest_hint')), $login) . '</p>'
            . '<div class="mp-field"><label class="mp-label" for="c_email">' . mp_e(mpl_tr('c_email')) . ' <span class="mpf-req">*</span></label>'
            . '<input class="mp-input" type="email" id="c_email" name="email" maxlength="190" required value="' . $val('email') . '" autocomplete="email"></div>';
    }
    $h .= '<div class="mp-field"><label class="mp-label" for="c_reason">' . mp_e(mpl_tr('c_reason')) . ' <span class="mpf-req">*</span></label>'
        . '<select class="mp-input" id="c_reason" name="reason" required><option value="">—</option>';
    foreach (MPL_COMPLAINT_REASONS as $r) {
        $h .= '<option value="' . $r . '"' . ($reason === $r ? ' selected' : '') . '>' . mp_e(mpl_tr('c_reason_' . $r)) . '</option>';
    }
    $h .= '</select></div>'
        . '<div class="mp-field"><label class="mp-label" for="c_note">' . mp_e(mpl_tr('c_note')) . '</label>'
        . '<textarea class="mp-input" id="c_note" name="note" rows="3" maxlength="2000">' . $val('note') . '</textarea></div>';

    // Поля правовласника (п. 10.1) — без JS видно завжди; з JS — лише для «Порушення авторських прав».
    $req = ' <span class="mpf-req">*</span>';
    $h .= '<fieldset class="mp-field mp-fieldset mpl-cr-fields" data-mpl-cr' . ($isCr ? '' : ' data-mpl-cr-hidden') . '>'
        . '<legend class="mp-label">' . mp_e(mpl_tr('c_cr_intro')) . '</legend>'
        . '<div class="mp-field"><label class="mp-label" for="c_cn">' . mp_e(mpl_tr('c_cr_name')) . $req . '</label><input class="mp-input" type="text" id="c_cn" name="claimant_name" maxlength="200" value="' . $val('claimant_name') . '" data-mpl-cr-req></div>'
        . '<div class="mp-field"><label class="mp-label" for="c_cc">' . mp_e(mpl_tr('c_cr_contact')) . $req . '</label><input class="mp-input" type="text" id="c_cc" name="claimant_contact" maxlength="300" value="' . $val('claimant_contact') . '" data-mpl-cr-req></div>'
        . '<div class="mp-field"><label class="mp-label" for="c_w">' . mp_e(mpl_tr('c_cr_work')) . $req . '</label><textarea class="mp-input" id="c_w" name="infringed_work" rows="3" maxlength="3000" data-mpl-cr-req>' . $val('infringed_work') . '</textarea></div>'
        . '<div class="mp-field"><label class="mp-label" for="c_eu">' . mp_e(mpl_tr('c_cr_evidence_url')) . $req . '</label><input class="mp-input" type="url" id="c_eu" name="evidence_url" maxlength="500" placeholder="https://" value="' . $val('evidence_url') . '"></div>'
        . '<div class="mp-field"><label class="mp-label" for="c_ef">' . mp_e(mpl_tr('c_cr_evidence_file')) . '</label><input class="mp-input" type="file" id="c_ef" name="evidence_file" accept="application/pdf,image/jpeg,image/png"></div>'
        . '<label class="mp-check mp-check--block"><input type="checkbox" name="good_faith" value="1"' . (($v['good_faith'] ?? '') === '1' ? ' checked' : '') . ' data-mpl-cr-req> <span>' . mp_e(mpl_tr('c_cr_good_faith')) . $req . '</span></label>'
        . '</fieldset>'
        . '<button class="mp-btn" type="submit">' . mp_e(mpl_tr('c_send')) . '</button>'
        . '<p class="mp-hint">' . mp_e(mpl_tr('c_alt_email', MP_ABUSE_EMAIL)) . ' <a href="marketplace-rules.php#section-10">' . mp_e(mpl_tr('rules_link')) . '</a></p>'
        . '</form></details>'
        . "<script>(function(){var f=document.querySelector('form.mpl-complaint');if(!f){return;}var s=f.querySelector('select[name=reason]'),box=f.querySelector('[data-mpl-cr]');"
        . "function sync(){var on=s.value==='copyright';box.hidden=!on;box.querySelectorAll('[data-mpl-cr-req]').forEach(function(el){el.required=on;});}"
        . "s.addEventListener('change',sync);sync();"
        . "f.addEventListener('submit',function(e){if(s.value!=='copyright'){return;}var u=f.querySelector('[name=evidence_url]'),fl=f.querySelector('[name=evidence_file]');"
        . "if(!u.value&&!(fl.files&&fl.files.length)){e.preventDefault();u.setCustomValidity(" . json_encode(mpl_tr('c_err_cr_evidence'), JSON_UNESCAPED_UNICODE | JSON_HEX_TAG) . ");u.reportValidity();}else{u.setCustomValidity('');}});"
        . "f.querySelector('[name=evidence_url]').addEventListener('input',function(){this.setCustomValidity('');});})();</script>";

    return $h;
}

/**
 * Блок кабінету автора: повідомлення, скарги правовласників (з формою заперечення), оголошення з рішеннями,
 * які можна оскаржити (з формою оскарження), і стан поданих оскаржень. Для всіх оголошень користувача
 * (і користувацьких, і вакансій/курсів/послуг).
 */
function mpl_cabinet_html(PDO $pdo, int $userId): string
{
    $h = '';
    // Повідомлення
    $notes = mpl_notifications($pdo, $userId, 15);
    $unread = count(array_filter($notes, static fn(array $n): bool => !$n['read']));
    $h .= '<section class="mp-panel" id="notifications"><h2 class="mp-panel__title">' . mp_e(mpl_tr('my_notifications')) . ($unread > 0 ? ' (' . $unread . ')' : '') . '</h2>';
    if ($notes === []) {
        $h .= '<p class="mp-hint">' . mp_e(mpl_tr('my_notifications_empty')) . '</p>';
    } else {
        $h .= '<ul class="mpl-notes">';
        foreach ($notes as $n) {
            $h .= '<li' . ($n['read'] ? '' : ' class="is-new"') . '><time>' . mp_e(mpl_date($n['created_at'])) . '</time>' . mp_e($n['text']) . '</li>';
        }
        $h .= '</ul>';
        if ($unread > 0) {
            $h .= '<form method="post" action="mp-legal-action.php" class="mp-inline-form">' . mp_csrf_field()
                . '<input type="hidden" name="action" value="read"><button class="mp-btn" type="submit">' . mp_e(mpl_tr('my_mark_read')) . '</button></form>';
        }
    }
    $h .= '</section>';

    // Скарги правовласників (п. 10.3) — без даних заявника.
    $complaints = mpl_owner_copyright_complaints($pdo, $userId);
    // Оголошення з рішеннями, які можна оскаржити (п. 7.5), і відкриті оскарження.
    $decided = [];
    try {
        $st = $pdo->prepare(
            "SELECT l.id, l.status, l.section, l.post_form, l.slug, l.reject_code, l.reject_reason, l.status_changed_at, l.moderated_at, l.updated_at,
                    COALESCE(t.title, '') AS title
             FROM mp_listings l JOIN mp_sellers s ON s.id = l.seller_id
             LEFT JOIN mp_listing_translations t ON t.listing_id = l.id AND t.lang = l.source_lang
             WHERE s.user_id = :u AND l.status IN ('rejected', 'removed', 'hidden') AND " . mpl_target_sql() . '
             ORDER BY COALESCE(l.status_changed_at, l.moderated_at, l.updated_at) DESC LIMIT 30'
        );
        $st->execute([':u' => $userId]);
        $decided = $st->fetchAll(PDO::FETCH_ASSOC);
    } catch (Throwable) {
        $decided = [];
    }
    if ($complaints === [] && $decided === []) {
        return $h;
    }
    $h .= '<section class="mp-panel" id="decisions"><h2 class="mp-panel__title">' . mp_e(mpl_tr('my_decisions_title')) . '</h2>';
    $titles = [];
    foreach ($complaints as $c) {
        $b = mpl_listing_brief($pdo, (int) $c['listing_id']);
        $titles[(int) $c['listing_id']] = (string) ($b['title'] ?? '#' . $c['listing_id']);
        $deadline = mpl_counter_deadline((string) $c['created_at']);
        $h .= '<div class="mpl-box" id="complaint-' . (int) $c['id'] . '"><h3 class="mp-block__title">' . mp_e(mpl_tr('my_complaint_title')) . ': '
            . mp_e($titles[(int) $c['listing_id']]) . '</h3>'
            . '<p class="mp-text">' . mp_e(mpl_tr('my_complaint_text')) . '</p>'
            . '<p class="mp-text"><strong>' . mp_e(mpl_tr('my_complaint_work')) . ':</strong> ' . mp_e((string) $c['infringed_work']) . '</p>';
        if (!empty($c['note'])) {
            $h .= '<p class="mp-text mp-text--pre">' . mp_e((string) $c['note']) . '</p>';
        }
        if ($c['counter_at'] !== null) {
            $h .= '<p class="mp-note">' . mp_e(mpl_tr('my_counter_done', mpl_date((string) $c['counter_at']))) . '</p>';
        } elseif (strtotime($deadline) < time()) {
            $h .= '<p class="mp-note">' . mp_e(mpl_tr('my_counter_closed')) . '</p>';
        } else {
            $h .= '<p class="mp-note">' . mp_e(mpl_tr('my_counter_until', mpl_date($deadline))) . '</p>'
                . '<form method="post" action="mp-legal-action.php" class="mp-form">' . mp_csrf_field()
                . '<input type="hidden" name="action" value="counter"><input type="hidden" name="complaint_id" value="' . (int) $c['id'] . '">'
                . '<div class="mp-field"><label class="mp-label" for="ct' . (int) $c['id'] . '">' . mp_e(mpl_tr('my_counter_text')) . ' <span class="mpf-req">*</span></label>'
                . '<textarea class="mp-input" id="ct' . (int) $c['id'] . '" name="text" rows="4" minlength="10" maxlength="3000" required></textarea></div>'
                . '<div class="mp-field"><label class="mp-label" for="cu' . (int) $c['id'] . '">' . mp_e(mpl_tr('my_counter_url')) . ' <span class="mpf-req">*</span></label>'
                . '<input class="mp-input" type="url" id="cu' . (int) $c['id'] . '" name="url" maxlength="500" placeholder="https://" required></div>'
                . '<button class="mp-btn mp-btn--primary" type="submit">' . mp_e(mpl_tr('my_counter_send')) . '</button></form>';
        }
        $h .= '</div>';
    }
    foreach ($decided as $d) {
        $last = mpl_last_appeal($pdo, $d);
        $deadline = mpl_appeal_deadline($d);
        $why = mpl_reason_text($d['reject_code'], $d['reject_reason']);
        $h .= '<div class="mpl-box" id="appeal-' . (int) $d['id'] . '"><h3 class="mp-block__title">' . mp_e($d['title'] !== '' ? $d['title'] : '#' . $d['id'])
            . ' — ' . mp_e(mpl_status_label((string) $d['status'])) . '</h3>'
            . ($why !== '' ? '<p class="mp-text"><strong>' . mp_e(mpl_tr('my_reason')) . ':</strong> ' . mp_e($why) . '</p>' : '');
        if ($last !== null) {
            $h .= '<p class="mp-note">' . mp_e(match ((string) $last['status']) {
                'restored' => mpl_tr('my_appeal_restored'),
                'upheld' => mpl_tr('my_appeal_upheld'),
                default => mpl_tr('my_appeal_open', (int) MP_APPEAL_ANSWER_DAYS),
            }) . (!empty($last['admin_comment']) ? ' ' . mp_e((string) $last['admin_comment']) : '') . '</p>';
        } elseif (strtotime($deadline) >= time()) {
            $h .= '<p class="mp-note">' . mp_e(mpl_tr('my_appeal_until', mpl_date($deadline))) . '</p>'
                . '<details><summary class="mp-btn">' . mp_e(mpl_tr('my_appeal_btn')) . '</summary>'
                . '<form method="post" action="mp-legal-action.php" class="mp-form">' . mp_csrf_field()
                . '<input type="hidden" name="action" value="appeal"><input type="hidden" name="listing_id" value="' . (int) $d['id'] . '">'
                . '<div class="mp-field"><label class="mp-label" for="ap' . (int) $d['id'] . '">' . mp_e(mpl_tr('my_appeal_text')) . ' <span class="mpf-req">*</span></label>'
                . '<textarea class="mp-input" id="ap' . (int) $d['id'] . '" name="text" rows="4" minlength="10" maxlength="3000" required></textarea></div>'
                . '<button class="mp-btn mp-btn--primary" type="submit">' . mp_e(mpl_tr('my_appeal_send')) . '</button></form></details>';
        } else {
            $h .= '<p class="mp-note">' . mp_e(mpl_tr('my_appeal_closed', (int) MP_APPEAL_WINDOW_DAYS, MP_ABUSE_EMAIL)) . '</p>';
        }
        $h .= '</div>';
    }

    return $h . '</section>';
}
