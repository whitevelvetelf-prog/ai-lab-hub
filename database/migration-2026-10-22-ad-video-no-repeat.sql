SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — реклама: відео не повторюється після завершення, кінцева картка.
-- Лише переклад кнопки «Переглянути ще раз» (ключ ad_popup_replay) англійською.
-- Нових подій чи колонок немає: повтор за кнопкою нічого не надсилає в облік.
-- INSERT … ON DUPLICATE KEY UPDATE. Без DROP / DELETE. Повторний запуск безпечний.
-- =====================================================================

INSERT INTO ui_translations (key_name, lang, translated_text, source) VALUES ('ad_popup_replay', 'en', '↻ Watch again', 'manual')
ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = 'manual';
