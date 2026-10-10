-- =====================================================================
-- AI LAB HUB — міграція: переклад банерів старого слота homepage_banner (таблиця campaigns)
--
-- campaign_translations — переклад title/description кампаній (за зразком ad_translations;
-- рушій app/translation-cache.php: localized_field / cached_translation). Без ручного перекладу
-- текст перекладається автоматично й кешується (source='auto'); ручний (source='manual') не перезаписується.
-- Для трьох наявних кампаній — ручний EN (кампанії знаходимо за target_url, без фіксованих id).
-- Нічого не видаляє. Безпечно повторювати.
-- =====================================================================

SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS campaign_translations (
    id              INT UNSIGNED NOT NULL AUTO_INCREMENT,
    campaign_id     INT UNSIGNED NOT NULL,
    field_name      VARCHAR(50) NOT NULL,
    lang            VARCHAR(5) NOT NULL,
    translated_text MEDIUMTEXT NOT NULL,
    source          ENUM('auto', 'manual') NOT NULL DEFAULT 'auto',
    updated_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uniq_campaign_field_lang (campaign_id, field_name, lang),
    CONSTRAINT fk_campaign_translations_campaign
        FOREIGN KEY (campaign_id) REFERENCES campaigns (id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

INSERT INTO campaign_translations (campaign_id, field_name, lang, translated_text, source)
SELECT c.id, f.field_name, 'en', f.txt, 'manual'
FROM campaigns c
JOIN (
    SELECT 'category.php?id=12' AS url, 'title' AS field_name, 'Health & Beauty — a new section!' AS txt
    UNION ALL SELECT 'category.php?id=12', 'description', 'We have just filled the section with AI tools for health and beauty. Take a look while it is brand new.'
    UNION ALL SELECT '/marketplace.php?category=solutions&price_type=free', 'title', 'Free ready-made AI solutions'
    UNION ALL SELECT '/marketplace.php?category=solutions&price_type=free', 'description', 'Prompts, automation templates, guides and scripts from AI LAB HUB — in the Marketplace.'
    UNION ALL SELECT 'donate.php', 'title', 'Support AI LAB HUB'
    UNION ALL SELECT 'donate.php', 'description', 'The project grows thanks to your support. Every contribution brings new features and tools closer.'
) f ON BINARY c.target_url = BINARY f.url
ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = 'manual';

SELECT COUNT(*) AS campaign_translations_en FROM campaign_translations WHERE lang = 'en';
