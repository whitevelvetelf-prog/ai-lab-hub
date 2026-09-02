<?php

declare(strict_types=1);

/**
 * AI LAB HUB — приклад налаштувань AI-асистентки Елі.
 *
 * Скопіюйте цей файл у config/ai-assistant.php та підставте свої ключі:
 *   cp config/ai-assistant.example.php config/ai-assistant.php
 *
 * Використання:
 *   $ai = require __DIR__ . '/../config/ai-assistant.php';
 *   $ai['provider'];        // 'gemini' | 'claude' — активний провайдер
 *   $ai['gemini_api_key'];  $ai['gemini_model'];
 *   $ai['api_key'];  $ai['workspace_id'];  $ai['model'];   // Claude
 *   $ai['max_tokens'];  $ai['timeout'];
 */

// Активний провайдер AI для Елі: 'gemini' або 'claude'.
$ai_provider = 'gemini';

// --- Google Gemini API (aistudio.google.com/apikey) -----------------------
// Ключ AI Studio (зазвичай формат AIzaSy...). Передається параметром
// URL ?key=..., без заголовків авторизації.
$gemini_api_key = 'YOUR_GEMINI_API_KEY_HERE';
$gemini_model   = 'gemini-3.6-flash';

// --- Anthropic Claude API (console.anthropic.com → Settings → API Keys) ---
// Формат ключа: sk-ant-... workspace_id обов'язковий для identity-linked
// ключів (формат wrkspc_...), інакше порожній рядок.
$claude_api_key      = 'YOUR_CLAUDE_API_KEY_HERE';
$claude_workspace_id = '';
$claude_model        = 'claude-sonnet-4-6';

// --- Спільні параметри запиту -------------------------------------------
$ai_max_tokens = 4096;   // верхня межа токенів відповіді
$ai_timeout    = 45;     // таймаут запиту, секунд

return [
    'provider'       => $ai_provider,

    'gemini_api_key' => $gemini_api_key,
    'gemini_model'   => $gemini_model,

    'api_key'        => $claude_api_key,
    'workspace_id'   => $claude_workspace_id,
    'model'          => $claude_model,

    'max_tokens'     => $ai_max_tokens,
    'timeout'        => $ai_timeout,
];
