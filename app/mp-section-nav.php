<?php

declare(strict_types=1);

/**
 * AI LAB HUB — єдина навігація розділу Marketplace (вкладки + кнопка «Подати оголошення»).
 *
 * Виводиться на всіх публічних сторінках розділу одразу під шапкою сайту:
 *   <?= mp_section_nav('board') ?>   // board | solutions | my | favorites | rules | post | offer
 * Кнопка подачі є ЛИШЕ тут (поза Marketplace її немає). «Мої оголошення» і «Вибране» — лише залогіненим,
 * «Правила» — за mp_rules_link_visible(). Подачу відкрито — за mp_posting_enabled() або для employee/admin
 * (як mpb_posting_open(); сервер однаково перевіряє доступ на marketplace-post.php).
 * Стилі: .mp-section-nav у public/assets/css/mp-public.css.
 */

require_once __DIR__ . '/marketplace.php';

function mp_section_nav(string $active): string
{
    $tabs = [
        'board'     => ['marketplace.php', t('mp_nav_board')],
        'solutions' => ['marketplace-solutions.php', t('mp_nav_solutions')],
    ];
    if (auth_check()) {
        $tabs['my'] = ['marketplace-my.php', t('mpb_my_link')];
        $tabs['favorites'] = ['marketplace-favorites.php', t('mpb_fav_title')];
    }
    if (mp_rules_link_visible()) {
        $tabs['rules'] = ['marketplace-rules.php', t('mp_nav_rules')];
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
