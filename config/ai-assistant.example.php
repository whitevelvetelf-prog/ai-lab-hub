<?php

declare(strict_types=1);

/**
 * AI LAB HUB — приклад налаштувань AI-асистентки Елі (Claude API).
 *
 * Скопіюйте цей файл у config/ai-assistant.php та підставте свій ключ:
 *   cp config/ai-assistant.example.php config/ai-assistant.php
 *
 * Використання:
 *   $ai = require __DIR__ . '/../config/ai-assistant.php';
 *   $ai['api_key'];  $ai['model'];  $ai['max_tokens'];  $ai['timeout'];
 */

// Ключ Claude API (console.anthropic.com → Settings → API Keys). Формат: sk-ant-...
$claude_api_key = 'YOUR_CLAUDE_API_KEY_HERE';

// Модель Claude для підбору продуктів (актуальний ідентифікатор без суфікса дати).
$claude_model = 'claude-sonnet-4-6';

// Верхня межа токенів відповіді Claude.
$claude_max_tokens = 1200;

// Таймаут запиту до Claude API, секунд.
$claude_timeout = 45;

return [
    'api_key'    => $claude_api_key,
    'model'      => $claude_model,
    'max_tokens' => $claude_max_tokens,
    'timeout'    => $claude_timeout,
];
