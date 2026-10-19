-- =====================================================================
-- AI LAB HUB — міграція 2026-10-21: керований аутріч (блок M3). КОЖЕН лист схвалює людина.
--
--   outreach_templates   — шаблони листів (UA/EN): запрошення й одне нагадування; редагуються в адмінці.
--   outreach_messages    — чернетки й листи: draft → queued (після схвалення людиною) → sent / sent_manual / failed / cancelled.
--   outreach_suppression — список заборон (адреса або домен; причини: відписка, відмова, відскок, скарга, ручне
--                          блокування, видалення на прохання). Перевіряється перед КОЖНОЮ відправкою.
--   outreach_tokens      — токени відписки (одноразові, з терміном дії) і запрошення (marketplace-join.php), лише хеші.
--   outreach_log         — журнал: хто схвалив, коли відправлено, зміни статусів.
--   outreach_leads       — + listing_id (оголошення, створене за запрошенням), replied_at.
--   mail_queue           — + headers_json (List-Unsubscribe, Reply-To, From для листів аутрічу), channel.
--   site_settings        — outreach_enabled = 0 (вимкнено) і решта налаштувань аутрічу (порожні — заповнює власник).
--
-- Лише CREATE TABLE IF NOT EXISTS / безпечні ALTER ... ADD COLUMN (за перевіркою) / INSERT IGNORE.
-- Жодних DROP / DELETE / TRUNCATE. Повторний запуск безпечний.
-- =====================================================================

SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS outreach_templates (
  id           INT UNSIGNED NOT NULL AUTO_INCREMENT,
  template_key VARCHAR(30)  NOT NULL,
  lang         CHAR(2)      NOT NULL,
  subject      VARCHAR(200) NOT NULL,
  body         TEXT         NOT NULL,
  updated_by   INT UNSIGNED NULL,
  updated_at   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_key_lang (template_key, lang)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS outreach_messages (
  id            INT UNSIGNED NOT NULL AUTO_INCREMENT,
  lead_id       INT UNSIGNED NOT NULL,
  kind          VARCHAR(20)  NOT NULL DEFAULT 'initial',
  template_key  VARCHAR(30)  NOT NULL DEFAULT 'invite',
  lang          CHAR(2)      NOT NULL DEFAULT 'en',
  to_email      VARCHAR(190) NULL,
  subject       VARCHAR(200) NOT NULL,
  body          TEXT         NOT NULL,
  paraphrased   TINYINT(1)   NOT NULL DEFAULT 0,
  status        VARCHAR(20)  NOT NULL DEFAULT 'draft',
  created_by    INT UNSIGNED NULL,
  approved_by   INT UNSIGNED NULL,
  approved_at   DATETIME     NULL,
  sent_at       DATETIME     NULL,
  mail_queue_id INT UNSIGNED NULL,
  error         VARCHAR(500) NULL,
  created_at    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_lead (lead_id, kind),
  KEY idx_status (status, approved_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS outreach_suppression (
  id         INT UNSIGNED NOT NULL AUTO_INCREMENT,
  kind       VARCHAR(10)  NOT NULL,
  value      VARCHAR(190) NOT NULL,
  reason     VARCHAR(20)  NOT NULL,
  note       VARCHAR(500) NULL,
  created_by INT UNSIGNED NULL,
  created_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_kind_value (kind, value)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS outreach_tokens (
  id         INT UNSIGNED NOT NULL AUTO_INCREMENT,
  token_hash CHAR(64)     NOT NULL,
  purpose    VARCHAR(10)  NOT NULL,
  lead_id    INT UNSIGNED NOT NULL,
  message_id INT UNSIGNED NULL,
  expires_at DATETIME     NOT NULL,
  used_at    DATETIME     NULL,
  created_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_hash (token_hash),
  KEY idx_lead (lead_id, purpose)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS outreach_log (
  id         BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  lead_id    INT UNSIGNED NULL,
  message_id INT UNSIGNED NULL,
  actor_id   INT UNSIGNED NULL,
  action     VARCHAR(30)  NOT NULL,
  note       VARCHAR(500) NULL,
  created_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_lead (lead_id),
  KEY idx_action (action, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Нові колонки (кожна — лише якщо ще не існує)
SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE outreach_leads ADD COLUMN listing_id INT UNSIGNED NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'outreach_leads' AND COLUMN_NAME = 'listing_id');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE outreach_leads ADD COLUMN replied_at DATETIME NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'outreach_leads' AND COLUMN_NAME = 'replied_at');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE mail_queue ADD COLUMN headers_json TEXT NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mail_queue' AND COLUMN_NAME = 'headers_json');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE mail_queue ADD COLUMN channel VARCHAR(20) NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mail_queue' AND COLUMN_NAME = 'channel');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- Початкові шаблони (нейтральні, без цифр аудиторії й обіцянок результату). Наявні не перезаписуються.
INSERT IGNORE INTO outreach_templates (template_key, lang, subject, body) VALUES
('invite', 'uk', 'Безкоштовне розміщення на AI LAB HUB',
'Добрий день!

Мене звати {sender_name}, я представляю AI LAB HUB ({site_url}), каталог AI-інструментів. Ми запускаємо розділ, де компанії можуть безкоштовно публікувати вакансії, курси й послуги у сфері AI.

{context_sentence}

Якщо це вам цікаво, ви можете розмістити оголошення безкоштовно до {free_until}: {join_url}. Через 30 днів ми надішлемо вам звіт про перегляди й переходи за вашим оголошенням.

Якщо це не цікаво, просто проігноруйте лист або відпишіться: {unsubscribe_url}, і ми більше не писатимемо.

З повагою,
{sender_name}, {sender_role}
{legal_address}'),
('invite', 'en', 'Free listing on AI LAB HUB',
'Hello,

My name is {sender_name} and I represent AI LAB HUB ({site_url}), a directory of AI tools. We are launching a section where companies can post AI-related jobs, courses and services for free.

{context_sentence}

If this is of interest, you can post a listing for free until {free_until}: {join_url}. After 30 days we will send you a report on the views and clicks your listing received.

If it is not of interest, simply ignore this email or unsubscribe: {unsubscribe_url}, and we will not write again.

Best regards,
{sender_name}, {sender_role}
{legal_address}'),
('followup', 'uk', 'Нагадування: безкоштовне розміщення на AI LAB HUB',
'Добрий день!

Коротко нагадую про мій попередній лист: на AI LAB HUB ({site_url}) можна безкоштовно розмістити вакансію, курс чи послугу у сфері AI до {free_until}: {join_url}.

Це останній лист від нас на цю тему. Відписатися: {unsubscribe_url}

З повагою,
{sender_name}, {sender_role}
{legal_address}'),
('followup', 'en', 'Reminder: free listing on AI LAB HUB',
'Hello,

A short reminder about my previous email: on AI LAB HUB ({site_url}) you can post an AI-related job, course or service for free until {free_until}: {join_url}.

This is our last email on this topic. Unsubscribe: {unsubscribe_url}

Best regards,
{sender_name}, {sender_role}
{legal_address}');

INSERT IGNORE INTO site_settings (setting_key, setting_value) VALUES
('outreach_enabled', '0'),
('outreach_sender_name', ''),
('outreach_sender_role', ''),
('outreach_legal_address', ''),
('outreach_unsubscribe_email', ''),
('outreach_reply_to', 'partners@ailabhub-directory.com'),
('outreach_from_email', 'partners@ailabhub-directory.com'),
('outreach_rules_ack', ''),
('outreach_daily_cap', '10'),
('outreach_rampup', '10,15,20,30,40'),
('outreach_ramp_start', ''),
('outreach_pause_min', '3'),
('outreach_pause_max', '9'),
('outreach_window_start', '9'),
('outreach_window_end', '18'),
('outreach_followup_days', '7'),
('outreach_paraphrase', '0'),
('outreach_next_send_at', '');
