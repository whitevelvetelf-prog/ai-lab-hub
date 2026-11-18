<?php

declare(strict_types=1);

require_once __DIR__ . '/mp-legal-i18n.php';

/**
 * AI LAB HUB — єдина навігація розділу Marketplace (вкладки + кнопка «Подати оголошення»).
 *
 * Виводиться на всіх публічних сторінках розділу одразу під шапкою сайту:
 *   <?= mp_section_nav('home') ?>   // home | my | favorites | rules | post | offer
 * Розділи (вакансії, курси, послуги, готові рішення, обладнання, інше, цифрові матеріали) — блоки на головній
 * marketplace.php (app/mp-tree.php), тож окремих вкладок для них немає; старі ключі (board, solutions, lst_*, assets)
 * означають «Marketplace». «Мої оголошення» і «Вибране» — лише залогіненим, «Правила» — за mp_rules_link_visible().
 * Кнопка подачі — за mp_posting_enabled() або для employee/admin (сервер однаково перевіряє доступ у формі).
 * Стилі: .mp-section-nav у public/assets/css/mp-public.css.
 */

require_once __DIR__ . '/marketplace.php';

function mp_section_nav(string $active): string
{
    if (in_array($active, ['board', 'solutions', 'assets', 'lst_job', 'lst_course', 'lst_service'], true)) {
        $active = 'home';
    }
    $tabs = ['home' => ['marketplace.php', t('mp_heading')]];
    if (auth_check()) {
        $tabs['my'] = ['marketplace-my.php', t('mpb_my_link')];
        $tabs['favorites'] = ['marketplace-favorites.php', t('mpb_fav_title')];
        // «Повідомлення» з лічильником непрочитаних — лише коли функцію ввімкнено (config messaging_enabled + public_enabled).
        if (mp_config()['messaging_enabled'] === true) {
            require_once __DIR__ . '/mp-messages.php';
            if (msg_enabled()) {
                $n = msg_unread_total(translation_pdo(), (int) auth_user_id());
                $tabs['messages'] = ['mp-messages.php', t('msg_title') . ($n > 0 ? ' (' . ($n > 99 ? '99+' : $n) . ')' : '')];
            }
        }
    }
    if (mp_rules_link_visible()) {
        $tabs['rules'] = ['marketplace-rules.php', mpl_tr('rules_link')];
    }

    $html = '<nav class="mp-section-nav" aria-label="' . mp_e(t('mp_nav_label')) . '"><div class="mp-section-nav__tabs">';
    foreach ($tabs as $key => [$href, $label]) {
        $current = $key === $active;
        $html .= '<a class="mp-tab' . ($current ? ' is-active' : '') . '" href="' . mp_e($href) . '"'
            . ($current ? ' aria-current="page"' : '') . '>' . mp_e($label) . '</a>';
    }
    $html .= '</div>';
    if (mp_posting_enabled() || mp_is_staff()) {
        $html .= '<a class="mp-btn mp-btn--primary mp-section-nav__post' . ($active === 'post' ? ' is-active' : '') . '" href="marketplace-post.php">'
            . mp_e(t('mpb_post_btn')) . '</a>';
    }

    return $html . '</nav>';
}
