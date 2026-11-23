<?php

/**
 * AI LAB HUB — соцмережі в підвалі й зображення для превʼю посилань (Open Graph / Twitter Card). Без секретів.
 *
 * Файл у git, але в архів коду НЕ входить (як config/geo.php, config/promo-internal.php): на хостингу його кладуть
 * вручну в www/config/social.php. Немає файла — кнопок соцмереж немає, превʼю з логотипом.
 *
 * social_links — посилання на сторінки AI LAB HUB. Порожнє (або заглушка в [ ]) — кнопку приховано.
 *   Приймаються лише https-адреси самої мережі (facebook.com, instagram.com, t.me, youtube.com, linkedin.com,
 *   x.com / twitter.com, tiktok.com) — app/social.php. Порядок ключів = порядок кнопок.
 * og_image — шлях від public/ до зображення 1200×630 (PNG/JPG) для превʼю, напр. '/assets/images/og-default.png'.
 *   Порожньо або файла немає — /logo.png (512×512) і картка «summary». Зараз такого зображення на сайті НЕМАЄ.
 */

return [
    'social_links' => [
        'facebook'  => 'https://www.facebook.com/groups/1676395060737562',   // група AI LAB HUB
        'instagram' => '',
        'telegram'  => '',
        'youtube'   => '',
        'linkedin'  => '',
        'x'         => '',
        'tiktok'    => '',
    ],
    'og_image' => '',
];
