-- =====================================================================
-- AI LAB HUB — міграція 2026-11-26 (Багвіль, № 41): назви й описи рівнів та місій Глави 1 у базі.
-- Перша сторінка гри (Етап 0) бере назви звідси, а не з коду; без таблиці чи рядка — запасний текст із
-- app/bugville/bv-world.php (той самий, що нижче).
-- Лише НОВА таблиця (CREATE TABLE IF NOT EXISTS) і ідемпотентні INSERT … WHERE NOT EXISTS.
-- Без FOREIGN KEY, ENUM, DROP, DELETE, TRUNCATE, ALTER, USE. Наявні таблиці не змінюються.
-- На живій базі — лише після «так» власниці.
-- =====================================================================

SET NAMES utf8mb4;

-- text_kind: 'level' (ref_id = id рівня) або 'mission' (ref_id = id місії). subtitle — підпис на табличці будинку.
CREATE TABLE IF NOT EXISTS bv_world_texts (
    text_kind     VARCHAR(8)   NOT NULL,
    ref_id        INT UNSIGNED NOT NULL,
    lang          VARCHAR(5)   NOT NULL DEFAULT 'uk',
    title         VARCHAR(120) NOT NULL,
    subtitle      VARCHAR(120) NULL,
    intro         VARCHAR(400) NULL,
    status        VARCHAR(10)  NOT NULL DEFAULT 'active',
    updated_at    DATETIME     NOT NULL,
    PRIMARY KEY (text_kind, ref_id, lang)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Рівні
INSERT INTO bv_world_texts (text_kind, ref_id, lang, title, subtitle, intro, status, updated_at)
SELECT 'level', 1, 'uk', 'Автомат', 'числа й межі', 'Торговий автомат приймає монети, рахує решту й видає смаколики. Іноді він помиляється. Знайдіть, де.', 'active', UTC_TIMESTAMP()
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM bv_world_texts WHERE text_kind = 'level' AND ref_id = 1 AND lang = 'uk');
INSERT INTO bv_world_texts (text_kind, ref_id, lang, title, subtitle, intro, status, updated_at)
SELECT 'level', 2, 'uk', 'Пошта', 'форми й поля', 'На пошті заповнюють бланки: імʼя, адресу, телефон. Бланк має помічати, коли щось не так.', 'active', UTC_TIMESTAMP()
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM bv_world_texts WHERE text_kind = 'level' AND ref_id = 2 AND lang = 'uk');
INSERT INTO bv_world_texts (text_kind, ref_id, lang, title, subtitle, intro, status, updated_at)
SELECT 'level', 3, 'uk', 'Бібліотека', 'таблиці й дані', 'У бібліотеці все записано в таблиці: книжки, дати, читачі. Знайдіть, де таблиця збилася.', 'active', UTC_TIMESTAMP()
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM bv_world_texts WHERE text_kind = 'level' AND ref_id = 3 AND lang = 'uk');

-- Місії (назви — затверджені, як у app/bugville/bv-world.php)
INSERT INTO bv_world_texts (text_kind, ref_id, lang, title, status, updated_at)
SELECT 'mission', t.id, 'uk', t.title, 'active', UTC_TIMESTAMP()
FROM (
    SELECT 101 AS id, 'Скільки монет?' AS title UNION ALL SELECT 102, 'Нуль' UNION ALL SELECT 103, 'Забагато'
    UNION ALL SELECT 104, 'Мінус' UNION ALL SELECT 105, 'Остання монета'
    UNION ALL SELECT 201, 'Порожнє поле' UNION ALL SELECT 202, 'Дивна адреса' UNION ALL SELECT 203, 'Літери замість цифр'
    UNION ALL SELECT 204, 'Задовге імʼя' UNION ALL SELECT 205, 'Двічі натиснули'
    UNION ALL SELECT 301, 'Не та дата' UNION ALL SELECT 302, 'Двійник' UNION ALL SELECT 303, 'Порожня клітинка'
    UNION ALL SELECT 304, 'Переплутані стовпці' UNION ALL SELECT 305, 'Історія бібліотекаря'
) t
WHERE NOT EXISTS (SELECT 1 FROM bv_world_texts w WHERE w.text_kind = 'mission' AND w.ref_id = t.id AND w.lang = 'uk');

-- Контроль (очікується 1 і 18):
--   SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = '<назва бази>' AND TABLE_NAME = 'bv_world_texts';
--   SELECT COUNT(*) FROM bv_world_texts WHERE lang = 'uk' AND status = 'active';
