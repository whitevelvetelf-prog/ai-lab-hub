-- =====================================================================
-- AI LAB HUB — міграція 2026-11-06 (Marketplace, № 18): єдине дерево категорій (блоки → підкатегорії).
--
-- Блок = рядок mp_categories з parent_id NULL; підкатегорія — рядок з parent_id блока й тим самим section.
-- section блоків: job, course, service, solution, goods, other (назви в інтерфейсі — mp_category_translations).
--   1) mp_listings.post_form — яка форма створила рядок: 'ad' — оголошення користувача (marketplace-post.php),
--      '' — вакансії/курси/послуги компаній (listing-post.php), матеріали платформи (solution), цифрові матеріали.
--      Колишній розділ 'board' зникає: post_form = 'ad', section = блок категорії.
--   2) mp_categories.is_draft — нові категорії з'являються «чернеткою списку» (видимі; admin затверджує в mp-categories.php).
--   3) Блоки й підкатегорії за списком від 2026-11-06; категорії дошки переїжджають у дерево зі збереженням id
--      (прив'язки оголошень не змінюються); prompts-templates зливається з prompts (прив'язки копіюються, стара — неактивна).
--   4) Оголошення без жодної підкатегорії свого блока отримують підкатегорію «Інше» цього блока (додається прив'язка).
-- 8 тематичних категорій section='focus' не змінюються (додатковий фільтр у блоках вакансій/курсів/послуг).
--
-- Лише ALTER TABLE mp_* ADD COLUMN за перевіркою, INSERT IGNORE / INSERT … WHERE NOT EXISTS і UPDATE за (section, slug).
-- Жодних DROP / DELETE / TRUNCATE. Повторний запуск безпечний (MySQL 5.7+ / MariaDB 10.3+).
-- phpMyAdmin → Імпорт цього файлу (у вкладці «SQL» PREPARE з кількох рядків може не спрацювати).
-- =====================================================================

SET NAMES utf8mb4;

-- 1) Колонки
SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_listings ADD COLUMN post_form VARCHAR(10) NOT NULL DEFAULT ''''',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'post_form');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_categories ADD COLUMN is_draft TINYINT(1) NOT NULL DEFAULT 0',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_categories' AND COLUMN_NAME = 'is_draft');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- 2) Блоки (нові — чернетка списку)
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) VALUES ('job', NULL, 'jobs', 'briefcase', 1, 1, 1);
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Вакансії', 0 FROM mp_categories WHERE section = 'job' AND slug = 'jobs' AND parent_id IS NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Jobs', 0 FROM mp_categories WHERE section = 'job' AND slug = 'jobs' AND parent_id IS NULL;
SET @b_job = (SELECT id FROM mp_categories WHERE section = 'job' AND slug = 'jobs' AND parent_id IS NULL LIMIT 1);
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) VALUES ('course', NULL, 'courses', 'graduation-cap', 2, 1, 1);
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Курси та навчання', 0 FROM mp_categories WHERE section = 'course' AND slug = 'courses' AND parent_id IS NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Courses & learning', 0 FROM mp_categories WHERE section = 'course' AND slug = 'courses' AND parent_id IS NULL;
SET @b_course = (SELECT id FROM mp_categories WHERE section = 'course' AND slug = 'courses' AND parent_id IS NULL LIMIT 1);
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) VALUES ('service', NULL, 'services', 'handshake', 3, 1, 1);
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Послуги', 0 FROM mp_categories WHERE section = 'service' AND slug = 'services' AND parent_id IS NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Services', 0 FROM mp_categories WHERE section = 'service' AND slug = 'services' AND parent_id IS NULL;
SET @b_service = (SELECT id FROM mp_categories WHERE section = 'service' AND slug = 'services' AND parent_id IS NULL LIMIT 1);
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) VALUES ('solution', NULL, 'solutions', 'sparkles', 4, 1, 1);
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Готові рішення', 0 FROM mp_categories WHERE section = 'solution' AND slug = 'solutions' AND parent_id IS NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Ready-made solutions', 0 FROM mp_categories WHERE section = 'solution' AND slug = 'solutions' AND parent_id IS NULL;
SET @b_solution = (SELECT id FROM mp_categories WHERE section = 'solution' AND slug = 'solutions' AND parent_id IS NULL LIMIT 1);
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) VALUES ('goods', NULL, 'goods', 'monitor', 5, 1, 1);
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Обладнання та техніка', 0 FROM mp_categories WHERE section = 'goods' AND slug = 'goods' AND parent_id IS NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Hardware & devices', 0 FROM mp_categories WHERE section = 'goods' AND slug = 'goods' AND parent_id IS NULL;
SET @b_goods = (SELECT id FROM mp_categories WHERE section = 'goods' AND slug = 'goods' AND parent_id IS NULL LIMIT 1);

-- Блок «Інше»: наявна категорія дошки 'other' (id зберігається); якщо її немає — новий рядок
UPDATE mp_categories SET section = 'other', parent_id = NULL, icon = 'shapes', sort_order = 7 WHERE section = 'board' AND slug = 'other';
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) VALUES ('other', NULL, 'other', 'shapes', 7, 1, 1);
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Інше', 0 FROM mp_categories WHERE section = 'other' AND slug = 'other';
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Other', 0 FROM mp_categories WHERE section = 'other' AND slug = 'other';

-- 3) Готові рішення: 7 наявних підкатегорій стають дочірніми до блока (slug не змінюються — імпорт manifest.json працює)
UPDATE mp_categories SET parent_id = @b_solution, icon = COALESCE(icon, 'message-square-text') WHERE section = 'solution' AND slug = 'prompts' AND parent_id IS NULL AND @b_solution IS NOT NULL AND id <> @b_solution;
UPDATE mp_categories SET parent_id = @b_solution, icon = COALESCE(icon, 'workflow') WHERE section = 'solution' AND slug = 'workflows' AND parent_id IS NULL AND @b_solution IS NOT NULL AND id <> @b_solution;
UPDATE mp_categories SET parent_id = @b_solution, icon = COALESCE(icon, 'bot') WHERE section = 'solution' AND slug = 'custom-assistants' AND parent_id IS NULL AND @b_solution IS NOT NULL AND id <> @b_solution;
UPDATE mp_categories SET parent_id = @b_solution, icon = COALESCE(icon, 'code') WHERE section = 'solution' AND slug = 'scripts' AND parent_id IS NULL AND @b_solution IS NOT NULL AND id <> @b_solution;
UPDATE mp_categories SET parent_id = @b_solution, icon = COALESCE(icon, 'book-open') WHERE section = 'solution' AND slug = 'guides' AND parent_id IS NULL AND @b_solution IS NOT NULL AND id <> @b_solution;
UPDATE mp_categories SET parent_id = @b_solution, icon = COALESCE(icon, 'palette') WHERE section = 'solution' AND slug = 'design-resources' AND parent_id IS NULL AND @b_solution IS NOT NULL AND id <> @b_solution;
UPDATE mp_categories SET parent_id = @b_solution, icon = COALESCE(icon, 'database') WHERE section = 'solution' AND slug = 'datasets' AND parent_id IS NULL AND @b_solution IS NOT NULL AND id <> @b_solution;
-- prompts-templates (дошка) → зливається з prompts: прив'язки копіюються до prompts, сама категорія неактивна (не видаляється)
UPDATE mp_categories SET section = 'solution', parent_id = @b_solution, is_active = 0, sort_order = 99 WHERE section = 'board' AND slug = 'prompts-templates';
INSERT IGNORE INTO mp_listing_categories (listing_id, category_id)
  SELECT lc.listing_id, p.id FROM mp_listing_categories lc
  JOIN mp_categories c ON c.id = lc.category_id AND c.section = 'solution' AND c.slug = 'prompts-templates'
  JOIN mp_categories p ON p.section = 'solution' AND p.slug = 'prompts';

-- 4) Підкатегорії блоків. Наявні категорії дошки: спершу нова назва (лише поки рядок ще в 'board'), потім переїзд у блок.

-- Вакансії (job)
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'job', @b_job, 'ai-data', 'brain', 1, 1, 1 FROM DUAL WHERE @b_job IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'AI та дані', 0 FROM mp_categories WHERE section = 'job' AND slug = 'ai-data' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'AI & data', 0 FROM mp_categories WHERE section = 'job' AND slug = 'ai-data' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'job', @b_job, 'development', 'code', 2, 1, 1 FROM DUAL WHERE @b_job IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Розробка', 0 FROM mp_categories WHERE section = 'job' AND slug = 'development' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Development', 0 FROM mp_categories WHERE section = 'job' AND slug = 'development' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'job', @b_job, 'qa-testing', 'bug', 3, 1, 1 FROM DUAL WHERE @b_job IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Тестування та якість', 0 FROM mp_categories WHERE section = 'job' AND slug = 'qa-testing' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Testing & QA', 0 FROM mp_categories WHERE section = 'job' AND slug = 'qa-testing' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'job', @b_job, 'design-creative', 'palette', 4, 1, 1 FROM DUAL WHERE @b_job IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Дизайн і креатив', 0 FROM mp_categories WHERE section = 'job' AND slug = 'design-creative' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Design & creative', 0 FROM mp_categories WHERE section = 'job' AND slug = 'design-creative' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'job', @b_job, 'marketing-content', 'megaphone', 5, 1, 1 FROM DUAL WHERE @b_job IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Маркетинг і контент', 0 FROM mp_categories WHERE section = 'job' AND slug = 'marketing-content' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Marketing & content', 0 FROM mp_categories WHERE section = 'job' AND slug = 'marketing-content' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'job', @b_job, 'sales-support', 'headphones', 6, 1, 1 FROM DUAL WHERE @b_job IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Продажі та підтримка клієнтів', 0 FROM mp_categories WHERE section = 'job' AND slug = 'sales-support' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Sales & customer support', 0 FROM mp_categories WHERE section = 'job' AND slug = 'sales-support' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'job', @b_job, 'education-mentoring', 'graduation-cap', 7, 1, 1 FROM DUAL WHERE @b_job IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Освіта та менторство', 0 FROM mp_categories WHERE section = 'job' AND slug = 'education-mentoring' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Education & mentoring', 0 FROM mp_categories WHERE section = 'job' AND slug = 'education-mentoring' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'job', @b_job, 'management-ops', 'clipboard-list', 8, 1, 1 FROM DUAL WHERE @b_job IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Менеджмент і операції', 0 FROM mp_categories WHERE section = 'job' AND slug = 'management-ops' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Management & operations', 0 FROM mp_categories WHERE section = 'job' AND slug = 'management-ops' AND parent_id IS NOT NULL;
UPDATE mp_category_translations t JOIN mp_categories c ON c.id = t.category_id SET t.name = 'Підробітки та разові завдання' WHERE c.section = 'board' AND c.slug IN ('jobs-gigs') AND t.lang = 'uk';
UPDATE mp_category_translations t JOIN mp_categories c ON c.id = t.category_id SET t.name = 'Gigs & one-off tasks' WHERE c.section = 'board' AND c.slug IN ('jobs-gigs') AND t.lang = 'en';
UPDATE mp_categories SET section = 'job', parent_id = @b_job, icon = 'timer', sort_order = 9 WHERE section = 'board' AND slug IN ('jobs-gigs') AND @b_job IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'job', @b_job, 'jobs-gigs', 'timer', 9, 1, 1 FROM DUAL WHERE @b_job IS NOT NULL AND NOT EXISTS (SELECT 1 FROM mp_categories x WHERE x.section = 'job' AND x.slug IN ('jobs-gigs'));
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Підробітки та разові завдання', 0 FROM mp_categories WHERE section = 'job' AND slug IN ('jobs-gigs');
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Gigs & one-off tasks', 0 FROM mp_categories WHERE section = 'job' AND slug IN ('jobs-gigs');
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'job', @b_job, 'internships', 'sprout', 10, 1, 1 FROM DUAL WHERE @b_job IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Стажування', 0 FROM mp_categories WHERE section = 'job' AND slug = 'internships' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Internships', 0 FROM mp_categories WHERE section = 'job' AND slug = 'internships' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'job', @b_job, 'other', 'shapes', 11, 1, 1 FROM DUAL WHERE @b_job IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Інше', 0 FROM mp_categories WHERE section = 'job' AND slug = 'other' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Other', 0 FROM mp_categories WHERE section = 'job' AND slug = 'other' AND parent_id IS NOT NULL;

-- Курси та навчання (course)
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'course', @b_course, 'ai-beginners', 'sparkles', 1, 1, 1 FROM DUAL WHERE @b_course IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'AI для початківців', 0 FROM mp_categories WHERE section = 'course' AND slug = 'ai-beginners' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'AI for beginners', 0 FROM mp_categories WHERE section = 'course' AND slug = 'ai-beginners' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'course', @b_course, 'prompts-ai', 'message-square-text', 2, 1, 1 FROM DUAL WHERE @b_course IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Промпти та робота з AI', 0 FROM mp_categories WHERE section = 'course' AND slug = 'prompts-ai' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Prompting & working with AI', 0 FROM mp_categories WHERE section = 'course' AND slug = 'prompts-ai' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'course', @b_course, 'programming-data', 'code', 3, 1, 1 FROM DUAL WHERE @b_course IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Програмування та дані', 0 FROM mp_categories WHERE section = 'course' AND slug = 'programming-data' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Programming & data', 0 FROM mp_categories WHERE section = 'course' AND slug = 'programming-data' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'course', @b_course, 'qa-testing', 'bug', 4, 1, 1 FROM DUAL WHERE @b_course IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Тестування (QA)', 0 FROM mp_categories WHERE section = 'course' AND slug = 'qa-testing' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Software testing (QA)', 0 FROM mp_categories WHERE section = 'course' AND slug = 'qa-testing' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'course', @b_course, 'design-video', 'clapperboard', 5, 1, 1 FROM DUAL WHERE @b_course IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Дизайн і відео', 0 FROM mp_categories WHERE section = 'course' AND slug = 'design-video' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Design & video', 0 FROM mp_categories WHERE section = 'course' AND slug = 'design-video' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'course', @b_course, 'marketing-business', 'trending-up', 6, 1, 1 FROM DUAL WHERE @b_course IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Маркетинг і бізнес', 0 FROM mp_categories WHERE section = 'course' AND slug = 'marketing-business' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Marketing & business', 0 FROM mp_categories WHERE section = 'course' AND slug = 'marketing-business' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'course', @b_course, 'languages', 'languages', 7, 1, 1 FROM DUAL WHERE @b_course IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Мови', 0 FROM mp_categories WHERE section = 'course' AND slug = 'languages' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Languages', 0 FROM mp_categories WHERE section = 'course' AND slug = 'languages' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'course', @b_course, 'kids-teens', 'smile', 8, 1, 1 FROM DUAL WHERE @b_course IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Для дітей і підлітків', 0 FROM mp_categories WHERE section = 'course' AND slug = 'kids-teens' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'For kids & teens', 0 FROM mp_categories WHERE section = 'course' AND slug = 'kids-teens' AND parent_id IS NOT NULL;
UPDATE mp_category_translations t JOIN mp_categories c ON c.id = t.category_id SET t.name = 'Репетитори та менторство' WHERE c.section = 'board' AND c.slug IN ('training-lessons') AND t.lang = 'uk';
UPDATE mp_category_translations t JOIN mp_categories c ON c.id = t.category_id SET t.name = 'Tutors & mentoring' WHERE c.section = 'board' AND c.slug IN ('training-lessons') AND t.lang = 'en';
UPDATE mp_categories SET section = 'course', parent_id = @b_course, icon = 'users', sort_order = 9 WHERE section = 'board' AND slug IN ('training-lessons') AND @b_course IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'course', @b_course, 'training-lessons', 'users', 9, 1, 1 FROM DUAL WHERE @b_course IS NOT NULL AND NOT EXISTS (SELECT 1 FROM mp_categories x WHERE x.section = 'course' AND x.slug IN ('training-lessons'));
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Репетитори та менторство', 0 FROM mp_categories WHERE section = 'course' AND slug IN ('training-lessons');
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Tutors & mentoring', 0 FROM mp_categories WHERE section = 'course' AND slug IN ('training-lessons');
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'course', @b_course, 'webinars-events', 'calendar', 10, 1, 1 FROM DUAL WHERE @b_course IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Вебінари та події', 0 FROM mp_categories WHERE section = 'course' AND slug = 'webinars-events' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Webinars & events', 0 FROM mp_categories WHERE section = 'course' AND slug = 'webinars-events' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'course', @b_course, 'other', 'shapes', 11, 1, 1 FROM DUAL WHERE @b_course IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Інше', 0 FROM mp_categories WHERE section = 'course' AND slug = 'other' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Other', 0 FROM mp_categories WHERE section = 'course' AND slug = 'other' AND parent_id IS NOT NULL;

-- Послуги (service)
UPDATE mp_category_translations t JOIN mp_categories c ON c.id = t.category_id SET t.name = 'AI-консультації та впровадження' WHERE c.section = 'board' AND c.slug IN ('ai-services') AND t.lang = 'uk';
UPDATE mp_category_translations t JOIN mp_categories c ON c.id = t.category_id SET t.name = 'AI consulting & implementation' WHERE c.section = 'board' AND c.slug IN ('ai-services') AND t.lang = 'en';
UPDATE mp_categories SET section = 'service', parent_id = @b_service, icon = 'lightbulb', sort_order = 1 WHERE section = 'board' AND slug IN ('ai-services') AND @b_service IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'service', @b_service, 'ai-services', 'lightbulb', 1, 1, 1 FROM DUAL WHERE @b_service IS NOT NULL AND NOT EXISTS (SELECT 1 FROM mp_categories x WHERE x.section = 'service' AND x.slug IN ('ai-services'));
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'AI-консультації та впровадження', 0 FROM mp_categories WHERE section = 'service' AND slug IN ('ai-services');
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'AI consulting & implementation', 0 FROM mp_categories WHERE section = 'service' AND slug IN ('ai-services');
UPDATE mp_category_translations t JOIN mp_categories c ON c.id = t.category_id SET t.name = 'Автоматизація, боти й інтеграції' WHERE c.section = 'board' AND c.slug IN ('automation-setup') AND t.lang = 'uk';
UPDATE mp_category_translations t JOIN mp_categories c ON c.id = t.category_id SET t.name = 'Automation, bots & integrations' WHERE c.section = 'board' AND c.slug IN ('automation-setup') AND t.lang = 'en';
UPDATE mp_categories SET section = 'service', parent_id = @b_service, icon = 'bot', sort_order = 2 WHERE section = 'board' AND slug IN ('automation-setup') AND @b_service IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'service', @b_service, 'automation-setup', 'bot', 2, 1, 1 FROM DUAL WHERE @b_service IS NOT NULL AND NOT EXISTS (SELECT 1 FROM mp_categories x WHERE x.section = 'service' AND x.slug IN ('automation-setup'));
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Автоматизація, боти й інтеграції', 0 FROM mp_categories WHERE section = 'service' AND slug IN ('automation-setup');
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Automation, bots & integrations', 0 FROM mp_categories WHERE section = 'service' AND slug IN ('automation-setup');
UPDATE mp_category_translations t JOIN mp_categories c ON c.id = t.category_id SET t.name = 'Розробка сайтів і застосунків' WHERE c.section = 'board' AND c.slug IN ('development') AND t.lang = 'uk';
UPDATE mp_category_translations t JOIN mp_categories c ON c.id = t.category_id SET t.name = 'Website & app development' WHERE c.section = 'board' AND c.slug IN ('development') AND t.lang = 'en';
UPDATE mp_categories SET section = 'service', parent_id = @b_service, icon = 'code', sort_order = 3 WHERE section = 'board' AND slug IN ('development') AND @b_service IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'service', @b_service, 'development', 'code', 3, 1, 1 FROM DUAL WHERE @b_service IS NOT NULL AND NOT EXISTS (SELECT 1 FROM mp_categories x WHERE x.section = 'service' AND x.slug IN ('development'));
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Розробка сайтів і застосунків', 0 FROM mp_categories WHERE section = 'service' AND slug IN ('development');
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Website & app development', 0 FROM mp_categories WHERE section = 'service' AND slug IN ('development');
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'service', @b_service, 'testing', 'bug', 4, 1, 1 FROM DUAL WHERE @b_service IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Тестування сайтів і застосунків', 0 FROM mp_categories WHERE section = 'service' AND slug = 'testing' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Website & app testing', 0 FROM mp_categories WHERE section = 'service' AND slug = 'testing' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'service', @b_service, 'texts-translation', 'languages', 5, 1, 1 FROM DUAL WHERE @b_service IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Тексти, переклад і локалізація', 0 FROM mp_categories WHERE section = 'service' AND slug = 'texts-translation' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Copywriting, translation & localization', 0 FROM mp_categories WHERE section = 'service' AND slug = 'texts-translation' AND parent_id IS NOT NULL;
UPDATE mp_category_translations t JOIN mp_categories c ON c.id = t.category_id SET t.name = 'Дизайн, зображення й відео' WHERE c.section = 'board' AND c.slug IN ('content-design') AND t.lang = 'uk';
UPDATE mp_category_translations t JOIN mp_categories c ON c.id = t.category_id SET t.name = 'Design, images & video' WHERE c.section = 'board' AND c.slug IN ('content-design') AND t.lang = 'en';
UPDATE mp_categories SET section = 'service', parent_id = @b_service, icon = 'image', sort_order = 6 WHERE section = 'board' AND slug IN ('content-design') AND @b_service IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'service', @b_service, 'content-design', 'image', 6, 1, 1 FROM DUAL WHERE @b_service IS NOT NULL AND NOT EXISTS (SELECT 1 FROM mp_categories x WHERE x.section = 'service' AND x.slug IN ('content-design'));
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Дизайн, зображення й відео', 0 FROM mp_categories WHERE section = 'service' AND slug IN ('content-design');
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Design, images & video', 0 FROM mp_categories WHERE section = 'service' AND slug IN ('content-design');
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'service', @b_service, 'ads-promotion', 'megaphone', 7, 1, 1 FROM DUAL WHERE @b_service IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Реклама та просування', 0 FROM mp_categories WHERE section = 'service' AND slug = 'ads-promotion' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Advertising & promotion', 0 FROM mp_categories WHERE section = 'service' AND slug = 'ads-promotion' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'service', @b_service, 'other', 'shapes', 8, 1, 1 FROM DUAL WHERE @b_service IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Інше', 0 FROM mp_categories WHERE section = 'service' AND slug = 'other' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Other', 0 FROM mp_categories WHERE section = 'service' AND slug = 'other' AND parent_id IS NOT NULL;

-- Обладнання та техніка (goods)
UPDATE mp_category_translations t JOIN mp_categories c ON c.id = t.category_id SET t.name = 'Комп''ютери та відеокарти' WHERE c.section = 'board' AND c.slug IN ('hardware', 'accounts-equipment') AND t.lang = 'uk';
UPDATE mp_category_translations t JOIN mp_categories c ON c.id = t.category_id SET t.name = 'Computers & graphics cards' WHERE c.section = 'board' AND c.slug IN ('hardware', 'accounts-equipment') AND t.lang = 'en';
UPDATE mp_categories SET section = 'goods', parent_id = @b_goods, icon = 'cpu', sort_order = 1 WHERE section = 'board' AND slug IN ('hardware', 'accounts-equipment') AND @b_goods IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'goods', @b_goods, 'hardware', 'cpu', 1, 1, 1 FROM DUAL WHERE @b_goods IS NOT NULL AND NOT EXISTS (SELECT 1 FROM mp_categories x WHERE x.section = 'goods' AND x.slug IN ('hardware', 'accounts-equipment'));
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Комп''ютери та відеокарти', 0 FROM mp_categories WHERE section = 'goods' AND slug IN ('hardware', 'accounts-equipment');
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Computers & graphics cards', 0 FROM mp_categories WHERE section = 'goods' AND slug IN ('hardware', 'accounts-equipment');
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'goods', @b_goods, 'peripherals', 'keyboard', 2, 1, 1 FROM DUAL WHERE @b_goods IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Периферія та аксесуари', 0 FROM mp_categories WHERE section = 'goods' AND slug = 'peripherals' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Peripherals & accessories', 0 FROM mp_categories WHERE section = 'goods' AND slug = 'peripherals' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'goods', @b_goods, 'phones-tablets', 'smartphone', 3, 1, 1 FROM DUAL WHERE @b_goods IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Смартфони та планшети', 0 FROM mp_categories WHERE section = 'goods' AND slug = 'phones-tablets' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Smartphones & tablets', 0 FROM mp_categories WHERE section = 'goods' AND slug = 'phones-tablets' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'goods', @b_goods, 'smart-home', 'house', 4, 1, 1 FROM DUAL WHERE @b_goods IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Розумний дім', 0 FROM mp_categories WHERE section = 'goods' AND slug = 'smart-home' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Smart home', 0 FROM mp_categories WHERE section = 'goods' AND slug = 'smart-home' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_categories (section, parent_id, slug, icon, sort_order, is_active, is_draft) SELECT 'goods', @b_goods, 'other', 'shapes', 5, 1, 1 FROM DUAL WHERE @b_goods IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'uk', 'Інше', 0 FROM mp_categories WHERE section = 'goods' AND slug = 'other' AND parent_id IS NOT NULL;
INSERT IGNORE INTO mp_category_translations (category_id, lang, name, is_auto) SELECT id, 'en', 'Other', 0 FROM mp_categories WHERE section = 'goods' AND slug = 'other' AND parent_id IS NOT NULL;

-- 5) Оголошення колишнього розділу 'board' → post_form = 'ad', section = блок першої категорії (без категорії — «Інше»)
UPDATE mp_listings SET post_form = 'ad' WHERE section = 'board' AND post_form = '';
UPDATE mp_listings l SET l.section = COALESCE((
    SELECT c.section FROM mp_listing_categories lc JOIN mp_categories c ON c.id = lc.category_id
    WHERE lc.listing_id = l.id AND c.section IN ('job', 'course', 'service', 'solution', 'goods', 'other')
    ORDER BY c.is_active DESC, c.id LIMIT 1), 'other')
WHERE l.section = 'board' AND l.post_form = 'ad';

-- 6) Оголошення без підкатегорії свого блока → «Інше» цього блока (для блока «Інше» — сам блок). Лише додавання прив'язок.
INSERT IGNORE INTO mp_listing_categories (listing_id, category_id)
  SELECT l.id, c.id FROM mp_listings l
  JOIN mp_categories c ON c.section = l.section AND c.slug = 'other' AND (c.parent_id IS NOT NULL OR c.section = 'other')
  WHERE l.section IN ('job', 'course', 'service', 'goods', 'other')
    AND NOT EXISTS (SELECT 1 FROM mp_listing_categories x JOIN mp_categories y ON y.id = x.category_id AND y.section = l.section
                    WHERE x.listing_id = l.id);

-- Контроль: 0 рядків у 'board'; блоки з кількістю підкатегорій
SELECT COUNT(*) AS board_listings_left FROM mp_listings WHERE section = 'board';
SELECT COUNT(*) AS board_categories_left FROM mp_categories WHERE section = 'board';
SELECT b.section, b.slug, COUNT(c.id) AS subcategories FROM mp_categories b LEFT JOIN mp_categories c ON c.parent_id = b.id
  WHERE b.parent_id IS NULL AND b.section <> 'focus' GROUP BY b.id ORDER BY b.sort_order;
