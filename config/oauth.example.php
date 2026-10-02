<?php

declare(strict_types=1);

/**
 * AI LAB HUB — налаштування входу через соцмережі (OAuth 2.0).
 *
 * Скопіюйте цей файл у config/oauth.php та підставте свої значення:
 *   cp config/oauth.example.php config/oauth.php
 * config/oauth.php — у .gitignore (містить секрети), на хостинг заливається вручну.
 *
 * Провайдер вважається підключеним, коли в нього заповнені client_id і client_secret
 * І для нього є реалізація потоку (app/oauth.php → OAUTH_PROVIDERS['…']['implemented']).
 * Зараз реалізовано лише Google; решта кнопок показуються неактивними («Скоро»).
 *
 * redirect_uri має ТОЧНО збігатися з «Authorized redirect URIs» у консолі провайдера.
 * Для локальної розробки — напр. http://ai-lab-hub.test/auth-google-callback.php
 * (додайте його в консолі Google окремим рядком).
 *
 * Google: https://console.cloud.google.com/apis/credentials → Create credentials →
 *   OAuth client ID → Web application. Scopes: openid, email, profile.
 */

return [
    'google' => [
        'client_id'     => '',
        'client_secret' => '',
        'redirect_uri'  => 'https://ailabhub-directory.com/auth-google-callback.php',
    ],
    'facebook' => [
        'client_id'     => '',
        'client_secret' => '',
        'redirect_uri'  => '',
    ],
    'apple' => [
        'client_id'     => '',
        'client_secret' => '',
        'redirect_uri'  => '',
    ],
    'linkedin' => [
        'client_id'     => '',
        'client_secret' => '',
        'redirect_uri'  => '',
    ],
    'x' => [
        'client_id'     => '',
        'client_secret' => '',
        'redirect_uri'  => '',
    ],
    'discord' => [
        'client_id'     => '',
        'client_secret' => '',
        'redirect_uri'  => '',
    ],
];
