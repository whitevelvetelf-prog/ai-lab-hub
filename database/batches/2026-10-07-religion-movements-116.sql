SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-10-07: 116 нових продуктів для нових підгруп категорії «Релігія» (Кабала й релігійні рухи).
-- Платні й безкоштовні застосунки, сервіси й онлайн-ресурси за підкатегоріями:
--   Кабала (kabbalah): 14
--   Свідки Єгови (jehovahs-witnesses): 10
--   Церква святих останніх днів (мормони) (latter-day-saints): 17
--   Адвентисти сьомого дня (seventh-day-adventists): 23
--   Харе Крішна (ISKCON) (hare-krishna): 12
--   Саєнтологія (scientology): 8
--   Брахма Кумаріс (brahma-kumaris): 7
--   Сока Гаккай (soka-gakkai): 11
--   Трансцендентальна медитація (transcendental-meditation): 7
--   Ошо (osho): 7
-- Лише справжні сервіси: сайти перевірено (відповідають, назва на сторінці). Відкинуто неробочі,
-- припарковані й захоплені домени, Cloudflare-перевірки, новинні сайти, благодійні фонди,
-- інвестиційні сервіси, астрологію, знайомства, продаж БАДів, сайти з медичними твердженнями. Тексти нейтральні й описові, без оцінок вірувань.
-- Тексти, функції й тарифи (UA + EN) — лише з офіційних сайтів, звірено 2026-10-07.
-- Потребує міграцій database/migration-2026-10-07-religion-category.sql і migration-2026-10-07-religion-movements.sql.
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт» (файл .sql або .sql.zip). Повторний запуск безпечний.
--   Ascent of Safed — Кабала
--   Daily Zohar — Кабала
--   Gal Einai (Inner.org) — Кабала
--   Kabacademy — Кабала
--   Kabbalah Centre — Кабала
--   Kabbalah Experience — Кабала
--   Kabbalah Media Archive — Кабала
--   Kabbalah Society — Кабала
--   Kabbalah4All — Кабала
--   Kli — Кабала
--   Laitman.ru — Кабала
--   Michael Laitman — Кабала
--   Zohar (Kabbalah Centre) — Кабала
--   ZoharApp — Кабала
--   Hourglass — Свідки Єгови
--   JW Broadcasting — Свідки Єгови
--   JW Conf — Свідки Єгови
--   JW Library — Свідки Єгови
--   JW.ORG — Свідки Єгови
--   Meeting Schedule Assistant — Свідки Єгови
--   NW Publisher — Свідки Єгови
--   NW Scheduler — Свідки Єгови
--   Territory Helper — Свідки Єгови
--   Watchtower Online Library — Свідки Єгови
--   Book of Mormon Videos — Церква святих останніх днів (мормони)
--   BYUtv — Церква святих останніх днів (мормони)
--   Church Media Library — Церква святих останніх днів (мормони)
--   Come Unto Christ — Церква святих останніх днів (мормони)
--   Deseret Book — Церква святих останніх днів (мормони)
--   Don't Miss This — Церква святих останніх днів (мормони)
--   FAIR — Церква святих останніх днів (мормони)
--   FamilySearch — Церква святих останніх днів (мормони)
--   followHIM Podcast — Церква святих останніх днів (мормони)
--   Gospel Doctrine — Церква святих останніх днів (мормони)
--   Gospel Library — Церква святих останніх днів (мормони)
--   Relative Finder — Церква святих останніх днів (мормони)
--   Saints Unscripted — Церква святих останніх днів (мормони)
--   Scripture Central — Церква святих останніх днів (мормони)
--   Scripture Citation Index — Церква святих останніх днів (мормони)
--   The Church of Jesus Christ of Latter-day Saints — Церква святих останніх днів (мормони)
--   The Tabernacle Choir — Церква святих останніх днів (мормони)
--   3ABN — Адвентисти сьомого дня
--   Adventist Archives — Адвентисти сьомого дня
--   Adventist Book Center — Адвентисти сьомого дня
--   Adventist Learning Community — Адвентисти сьомого дня
--   Adventist Mission — Адвентисти сьомого дня
--   Adventist World Radio — Адвентисти сьомого дня
--   Adventist Youth Ministries — Адвентисти сьомого дня
--   AdventistGiving — Адвентисти сьомого дня
--   Amazing Facts — Адвентисти сьомого дня
--   Club Ministries (NAD) — Адвентисти сьомого дня
--   Discover Bible Guides — Адвентисти сьомого дня
--   eAdventist — Адвентисти сьомого дня
--   EGW Writings — Адвентисти сьомого дня
--   Ellen G. White Estate — Адвентисти сьомого дня
--   Encyclopedia of Seventh-day Adventists — Адвентисти сьомого дня
--   Hope Channel Ukraine (Телеканал «Надія») — Адвентисти сьомого дня
--   It Is Written — Адвентисти сьомого дня
--   Light Bearers — Адвентисти сьомого дня
--   Sabbath School — Адвентисти сьомого дня
--   Sabbath School Net — Адвентисти сьомого дня
--   SDA Hymnal — Адвентисти сьомого дня
--   Seventh-day Adventist Church — Адвентисти сьомого дня
--   Церква адвентистів сьомого дня в Україні — Адвентисти сьомого дня
--   Back to Godhead — Харе Крішна (ISKCON)
--   Bhakti Courses — Харе Крішна (ISKCON)
--   Bhaktivedanta Book Trust — Харе Крішна (ISKCON)
--   ISKCON London — Харе Крішна (ISKCON)
--   ISKCON Vrindavan — Харе Крішна (ISKCON)
--   Krishna Store — Харе Крішна (ISKCON)
--   Krishna.ua — Харе Крішна (ISKCON)
--   Mayapur Institute — Харе Крішна (ISKCON)
--   Mayapur.com — Харе Крішна (ISKCON)
--   Prabhupada.io — Харе Крішна (ISKCON)
--   PrabhupadaBooks.com — Харе Крішна (ISKCON)
--   Vaisnava Calendar — Харе Крішна (ISKCON)
--   Bridge Publications — Саєнтологія
--   Church of Scientology — Саєнтологія
--   Dianetics — Саєнтологія
--   L. Ron Hubbard — Саєнтологія
--   New Era Publications — Саєнтологія
--   Scientology Network — Саєнтологія
--   Scientology Volunteer Ministers — Саєнтологія
--   The Way to Happiness — Саєнтологія
--   Brahma Kumaris Australia — Брахма Кумаріс
--   Brahma Kumaris Canada — Брахма Кумаріс
--   Brahma Kumaris India — Брахма Кумаріс
--   Brahma Kumaris UK — Брахма Кумаріс
--   Brahma Kumaris USA — Брахма Кумаріс
--   Learn Meditation Online — Брахма Кумаріс
--   Madhuban Murli — Брахма Кумаріс
--   Bharat Soka Gakkai — Сока Гаккай
--   BSGI (Brasil Soka Gakkai) — Сока Гаккай
--   Daisaku Ikeda Website — Сока Гаккай
--   Ikeda Center for Peace, Learning, and Dialogue — Сока Гаккай
--   Nichiren Buddhism Library — Сока Гаккай
--   SGI Canada — Сока Гаккай
--   SGI-UK — Сока Гаккай
--   SGI-USA — Сока Гаккай
--   Soka Gakkai Deutschland — Сока Гаккай
--   Soka Gakkai International — Сока Гаккай
--   Soka Gakkai Japan — Сока Гаккай
--   David Lynch Foundation — Трансцендентальна медитація
--   Maharishi Channel — Трансцендентальна медитація
--   Maharishi Technologies of Consciousness — Трансцендентальна медитація
--   TM Women — Трансцендентальна медитація
--   Transcendental Meditation — Трансцендентальна медитація
--   Transcendental Meditation Australia — Трансцендентальна медитація
--   Transcendental Meditation Canada — Трансцендентальна медитація
--   OSHO International — Ошо
--   Osho Nisarga — Ошо
--   OSHO Online Library — Ошо
--   Osho Risk Meditation Center — Ошо
--   Osho Tapoban — Ошо
--   OSHO World — Ошо
--   Sannyas Wiki — Ошо
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);

-- Ascent of Safed — Кабала
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ascentofsafed.com' OR LOWER(`name`) = LOWER('Ascent of Safed'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ascent of Safed', NULL, 'https://www.ascentofsafed.com', NULL, NULL, 'Ascent of Safed — освітній сайт про кабалу й єврейську містику з Цфата: тижневі глави, свята, вступ до кабали, медитація, молитва й хасидські історії.', 'Ascent of Safed is an educational site on Kabbalah and Jewish mysticism from Safed: weekly portions, holidays, introductory Kabbalah, meditation, prayer and Chassidic stories.', 'Сайт центру Ascent у Цфаті. Розділи: тижнева глава Тори з медитацією, свята, «Кабала: що це?», єврейська містика, книги, єврейський місяць, Шабат, Пірке Авот, Машіах, наука; поглиблені матеріали про медитацію, молитву й коди Тори; архів історій, аудіоісторії, гумор і огляди книг.', 'The site of the Ascent center in Safed. Sections include the weekly Torah reading with meditation, holidays, "Kabbalah: what is it?", Jewish mysticism, books, the Jewish month, Shabbat, Pirkei Avot, Moshiach and science; advanced material on meditation, prayer and Torah codes; a story archive, audio stories, humor and book reviews.', 'Вступ до кабали
Тижнева глава з медитацією
Архів хасидських історій
Аудіоісторії', 'Introduction to Kabbalah
Weekly portion with meditation
Chassidic story archive
Audio stories', 'Ті, хто знайомиться з кабалою та єврейською містикою.', 'People exploring Kabbalah and Jewish mysticism.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ascentofsafed.com' OR LOWER(`name`) = LOWER('Ascent of Safed')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'kabbalah' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ascent of Safed is an educational site on Kabbalah and Jewish mysticism from Safed: weekly portions, holidays, introductory Kabbalah, meditation, prayer and Chassidic stories.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of the Ascent center in Safed. Sections include the weekly Torah reading with meditation, holidays, "Kabbalah: what is it?", Jewish mysticism, books, the Jewish month, Shabbat, Pirkei Avot, Moshiach and science; advanced material on meditation, prayer and Torah codes; a story archive, audio stories, humor and book reviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Introduction to Kabbalah
Weekly portion with meditation
Chassidic story archive
Audio stories', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People exploring Kabbalah and Jewish mysticism.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Daily Zohar — Кабала
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dailyzohar.com' OR LOWER(`name`) = LOWER('Daily Zohar'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Daily Zohar', NULL, 'https://dailyzohar.com', NULL, NULL, 'Daily Zohar (Zion Nefesh) — щоденні тексти й пояснення Зогару за тижневими главами Тори, вивчення Дерева життя й букв івриту, безкоштовні застосунки.', 'Daily Zohar (Zion Nefesh) offers daily Zohar passages and commentary by weekly Torah portion, Tree of Life and Hebrew letter studies, and free apps.', 'Проєкт Зіона Нефеша з глибшого вивчення Зогару й кабали. Щоденні уривки Зогару впорядковано за книгами й главами Тори, є розділи «Тікуним», Дерево життя, букви івриту, молитви, свята й тексти Зогару для завантаження. Сайт має версії англійською, іспанською, французькою, італійською, португальською та турецькою. Проєкт пропонує безкоштовні застосунки Unity Zohar (повний текст Зогару) і Tzadikim (для молитов). Вивчення завжди безкоштовне, проєкт підтримують пожертви й членство.', 'Zion Nefesh''s project for deeper study of the Zohar and Kabbalah. Daily Zohar passages are organized by Torah book and portion, with sections on Tikunim, the Tree of Life, Hebrew letters, prayers, holidays and Zohar text downloads. The site has English, Spanish, French, Italian, Portuguese and Turkish versions. It offers free apps Unity Zohar (the complete Zohar text) and Tzadikim (for prayers). The studies are always free; the project is supported by donations and membership.', 'Щоденні уривки Зогару
Дерево життя й букви івриту
Застосунки Unity Zohar і Tzadikim
Шість мов', 'Daily Zohar passages
Tree of Life and Hebrew letters
Unity Zohar and Tzadikim apps
Six languages', 'Ті, хто щодня вивчає Зогар.', 'People who study the Zohar daily.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dailyzohar.com' OR LOWER(`name`) = LOWER('Daily Zohar')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'kabbalah' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Daily Zohar (Zion Nefesh) offers daily Zohar passages and commentary by weekly Torah portion, Tree of Life and Hebrew letter studies, and free apps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Zion Nefesh''s project for deeper study of the Zohar and Kabbalah. Daily Zohar passages are organized by Torah book and portion, with sections on Tikunim, the Tree of Life, Hebrew letters, prayers, holidays and Zohar text downloads. The site has English, Spanish, French, Italian, Portuguese and Turkish versions. It offers free apps Unity Zohar (the complete Zohar text) and Tzadikim (for prayers). The studies are always free; the project is supported by donations and membership.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Daily Zohar passages
Tree of Life and Hebrew letters
Unity Zohar and Tzadikim apps
Six languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who study the Zohar daily.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Вивчення й застосунки безкоштовні', 'Studies and apps are free' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Studies and apps are free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Gal Einai (Inner.org) — Кабала
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'inner.org' OR LOWER(`name`) = LOWER('Gal Einai (Inner.org)'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Gal Einai (Inner.org)', NULL, 'https://inner.org', NULL, NULL, 'Gal Einai (Inner.org) — інститут рабі Іцхака Гінзбурга: внутрішній вимір Тори, кабала й хасидизм, тижневі глави, «кабала для початківців», трансляції.', 'Gal Einai (Inner.org) is Rabbi Yitzchak Ginsburgh''s institute on the inner dimension of the Torah: Kabbalah and Chassidut, weekly portions, Kabbalah for beginners and broadcasts.', 'Головна мета Інституту Gal Einai — заохочувати вивчення Тори з погляду її внутрішнього виміру. На сайті — статті за тижневими главами Тори, розділ «Кабала для початківців», історії хасидських учителів, свята, живі трансляції й YouTube-канал, інформація про рабі Гінзбурга, вебкрамниця та сайт івритом.', 'The Gal Einai Institute''s central goal is to encourage the study of the Torah from the perspective of its inner dimension. The site has articles by weekly Torah portion, a Kabbalah for Beginners section, stories of Chassidic masters, holidays, live broadcasts and a YouTube channel, information about Rabbi Ginsburgh, a webstore and a Hebrew site.', 'Тижневі глави Тори
Кабала для початківців
Живі трансляції
Вебкрамниця', 'Weekly Torah portions
Kabbalah for beginners
Live broadcasts
Webstore', 'Ті, хто вивчає кабалу й хасидизм.', 'People studying Kabbalah and Chassidut.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'inner.org' OR LOWER(`name`) = LOWER('Gal Einai (Inner.org)')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'kabbalah' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Gal Einai (Inner.org) is Rabbi Yitzchak Ginsburgh''s institute on the inner dimension of the Torah: Kabbalah and Chassidut, weekly portions, Kabbalah for beginners and broadcasts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Gal Einai Institute''s central goal is to encourage the study of the Torah from the perspective of its inner dimension. The site has articles by weekly Torah portion, a Kabbalah for Beginners section, stories of Chassidic masters, holidays, live broadcasts and a YouTube channel, information about Rabbi Ginsburgh, a webstore and a Hebrew site.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Weekly Torah portions
Kabbalah for beginners
Live broadcasts
Webstore', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People studying Kabbalah and Chassidut.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Статті й трансляції', 'Articles and broadcasts' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Articles and broadcasts', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Kabacademy — Кабала
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kabacademy.com' OR LOWER(`name`) = LOWER('Kabacademy'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kabacademy', NULL, 'https://kabacademy.com', NULL, NULL, 'Kabacademy — Міжнародна академія кабали (рос.): онлайн-курси, вебінари, клуб і самонавчання, базовий курс «Класична кабала».', 'Kabacademy is the International Academy of Kabbalah (in Russian): online courses, webinars, a club and self-study, including the basic "Classical Kabbalah" course.', 'Російськомовна Міжнародна академія кабали. Пропонує онлайн-курси, онлайн-клуб і самонавчання, зокрема базовий академічний курс «Класична кабала» з регулярними наборами, а також відкриті вебінари. Вхід на сайт — за одноразовим посиланням на пошту, паролем або через Telegram. Є розділи «Як ми навчаємося», FAQ і фонд допомоги з добровільними внесками.', 'The Russian-language International Academy of Kabbalah. It offers online courses, an online club and self-study, including a basic academic course "Classical Kabbalah" with regular intakes, as well as open webinars. Sign-in is by a one-time email link, password or Telegram. There are sections on how studies work, an FAQ and a support fund accepting voluntary contributions.', 'Базовий курс «Класична кабала»
Відкриті вебінари
Онлайн-клуб
Вхід через Telegram', '"Classical Kabbalah" basic course
Open webinars
Online club
Telegram sign-in', 'Російськомовні слухачі, які хочуть систематично вивчати кабалу.', 'Russian speakers who want to study Kabbalah systematically.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kabacademy.com' OR LOWER(`name`) = LOWER('Kabacademy')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'kabbalah' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Kabacademy is the International Academy of Kabbalah (in Russian): online courses, webinars, a club and self-study, including the basic "Classical Kabbalah" course.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Russian-language International Academy of Kabbalah. It offers online courses, an online club and self-study, including a basic academic course "Classical Kabbalah" with regular intakes, as well as open webinars. Sign-in is by a one-time email link, password or Telegram. There are sections on how studies work, an FAQ and a support fund accepting voluntary contributions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '"Classical Kabbalah" basic course
Open webinars
Online club
Telegram sign-in', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Russian speakers who want to study Kabbalah systematically.', 'manual' FROM DUAL WHERE @new = 1;

-- Kabbalah Centre — Кабала
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kabbalah.com' OR LOWER(`name`) = LOWER('Kabbalah Centre'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kabbalah Centre', NULL, 'https://www.kabbalah.com', NULL, NULL, 'Kabbalah Centre (Kabbalah Master Classes) — онлайн-платформа Центру Кабали: курси, щоденні вчення й практики від викладачів центру кількома мовами.', 'Kabbalah Centre (Kabbalah Master Classes) is the Kabbalah Centre''s online platform with courses, daily teachings and practices from its teachers in several languages.', 'Kabbalah Master Classes — онлайн-платформа Kabbalah Centre, яка подає кабалу як духовну систему для розуміння власного життя. Є курси на теми достатку, стосунків, свідомості й вивчення Зогару, нові заняття й щоденні вчення, розділ практик, перелік викладачів і локацій центру, магазин і сторінка духовних консультацій. Сайт доступний англійською, іспанською, португальською, італійською, французькою та івритом. Повний доступ відкривається за внеском від 1 $ на місяць (рекомендований — 9,99 $ на місяць), скасувати можна будь-коли.', 'Kabbalah Master Classes is the Kabbalah Centre''s online platform presenting Kabbalah as a spiritual system for understanding your life. It offers courses on abundance, relationships, consciousness and the study of the Zohar, new classes and daily teachings, a practice section, teacher and location listings, a store and spiritual guidance. The site is available in English, Spanish, Portuguese, Italian, French and Hebrew. Full access is unlocked with a contribution from $1 a month (suggested $9.99 a month) and can be cancelled anytime.', 'Онлайн-курси з кабали
Щоденні вчення й практики
Курс вивчення Зогару
Шість мов
Доступ від 1 $ на місяць', 'Online Kabbalah courses
Daily teachings and practices
Zohar study course
Six languages
Access from $1 a month', 'Ті, хто цікавиться кабалою як духовною практикою.', 'People interested in Kabbalah as a spiritual practice.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kabbalah.com' OR LOWER(`name`) = LOWER('Kabbalah Centre')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'kabbalah' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Kabbalah Centre (Kabbalah Master Classes) is the Kabbalah Centre''s online platform with courses, daily teachings and practices from its teachers in several languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Kabbalah Master Classes is the Kabbalah Centre''s online platform presenting Kabbalah as a spiritual system for understanding your life. It offers courses on abundance, relationships, consciousness and the study of the Zohar, new classes and daily teachings, a practice section, teacher and location listings, a store and spiritual guidance. The site is available in English, Spanish, Portuguese, Italian, French and Hebrew. Full access is unlocked with a contribution from $1 a month (suggested $9.99 a month) and can be cancelled anytime.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Online Kabbalah courses
Daily teachings and practices
Zohar study course
Six languages
Access from $1 a month', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People interested in Kabbalah as a spiritual practice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Повний доступ', 'Full Access', 1.00, 'month', 'Внесок від 1 $; рекомендований 9,99 $ на місяць', 'Contribution from $1; suggested $9.99 a month' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Повний доступ' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Full Access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Contribution from $1; suggested $9.99 a month', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Kabbalah Experience — Кабала
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kabbalahexperience.com' OR LOWER(`name`) = LOWER('Kabbalah Experience'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kabbalah Experience', NULL, 'https://kabbalahexperience.com', NULL, NULL, 'Kabbalah Experience — навчальний центр єврейської кабали: класи чотирьох рівнів, інтенсиви, наставництво, самонавчання й спільнота; є безкоштовний пробний клас.', 'Kabbalah Experience is a Jewish Kabbalah learning center with four levels of classes, intensives, mentoring, self-study and community, plus a free sample class.', 'Освітня організація, що навчає кабали через класи й інтенсиви. Програма поділена на рівні 1–4, є спеціальні класи й курси за вибором, індивідуальний духовний коучинг і наставництво, самонавчання, курс «Embodying the Tree of Life» і стипендія New Jewish Story Fellowship. Оплата навчання — за ковзною шкалою. Є безкоштовні пробні класи, членство в спільноті, події, блог, навчальні ресурси й крамниця.', 'An educational organization teaching Kabbalah through classes and intensives. The program runs across Levels 1–4, with special classes and electives, one-on-one spiritual coaching and mentorship, self-study, the "Embodying the Tree of Life" course and the New Jewish Story Fellowship. Tuition uses a sliding scale. There are free sample classes, community membership, events, a blog, learning resources and a shop.', 'Класи рівнів 1–4
Індивідуальне наставництво
Самонавчання
Ковзна шкала оплати
Безкоштовний пробний клас', 'Level 1–4 classes
One-on-one mentorship
Self-study
Sliding-scale tuition
Free sample class', 'Дорослі, які хочуть системно вивчати єврейську кабалу.', 'Adults who want to study Jewish Kabbalah systematically.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kabbalahexperience.com' OR LOWER(`name`) = LOWER('Kabbalah Experience')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'kabbalah' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Kabbalah Experience is a Jewish Kabbalah learning center with four levels of classes, intensives, mentoring, self-study and community, plus a free sample class.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An educational organization teaching Kabbalah through classes and intensives. The program runs across Levels 1–4, with special classes and electives, one-on-one spiritual coaching and mentorship, self-study, the "Embodying the Tree of Life" course and the New Jewish Story Fellowship. Tuition uses a sliding scale. There are free sample classes, community membership, events, a blog, learning resources and a shop.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Level 1–4 classes
One-on-one mentorship
Self-study
Sliding-scale tuition
Free sample class', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Adults who want to study Jewish Kabbalah systematically.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Пробний клас', 'Sample Class', 0.00, 'free', 'Безкоштовне знайомство', 'Free introduction' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Пробний клас' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Sample Class', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free introduction', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Kabbalah Media Archive — Кабала
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kabbalahmedia.info' OR LOWER(`name`) = LOWER('Kabbalah Media Archive'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kabbalah Media Archive', NULL, 'https://kabbalahmedia.info', NULL, NULL, 'Kabbalah Media — медіаархів Бней Барух: уроки й лекції, програми й кліпи, бібліотека кабалістичних текстів, конгреси, музика й завантаження.', 'Kabbalah Media is Bnei Baruch''s media archive: lessons and lectures, programs and clips, a Kabbalah library, conventions, music and downloads.', 'Архів матеріалів організації Бней Барух. Розділи: уроки й лекції, програми й кліпи, бібліотека кабали, добірки уривків, конгреси й події, теми, публікації, музика, завантаження та скетчі. Можна шукати за датою, підписатися на RSS і подкаст, а в особистому кабінеті — лайкати, зберігати й стежити за відео. Сайт багатомовний.', 'The Bnei Baruch media archive. Sections include lessons and lectures, programs and clips, a Kabbalah library, assorted excerpts, conventions and events, topics, publications, music, downloads and sketches. You can search by date, subscribe via RSS and podcast, and in a personal area like, save and follow videos. The site is multilingual.', 'Уроки й лекції
Бібліотека кабали
Пошук за датою
RSS і подкаст
Особистий кабінет', 'Lessons and lectures
Kabbalah library
Search by date
RSS and podcast
Personal area', 'Слухачі уроків Бней Барух і ті, хто вивчає кабалу.', 'Bnei Baruch students and people studying Kabbalah.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kabbalahmedia.info' OR LOWER(`name`) = LOWER('Kabbalah Media Archive')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'kabbalah' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Kabbalah Media is Bnei Baruch''s media archive: lessons and lectures, programs and clips, a Kabbalah library, conventions, music and downloads.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Bnei Baruch media archive. Sections include lessons and lectures, programs and clips, a Kabbalah library, assorted excerpts, conventions and events, topics, publications, music, downloads and sketches. You can search by date, subscribe via RSS and podcast, and in a personal area like, save and follow videos. The site is multilingual.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Lessons and lectures
Kabbalah library
Search by date
RSS and podcast
Personal area', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Bnei Baruch students and people studying Kabbalah.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий архів', 'Open archive' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open archive', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Kabbalah Society — Кабала
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kabbalahsociety.org' OR LOWER(`name`) = LOWER('Kabbalah Society'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kabbalah Society', NULL, 'https://www.kabbalahsociety.org', NULL, NULL, 'Міжнародне товариство кабали — спадщина Зеева бен Шимона Галеві й толедської традиції: відеолекції, статті, книги, навчальні групи та онлайн-курси.', 'The International Kabbalah Society preserves the legacy of Z''ev ben Shimon Halevi and the Toledano tradition: video lectures, articles, books, study groups and online courses.', 'Товариство зберігає духовну спадщину Зеева бен Шимона Галеві та мудрість толедської традиції й заохочує вивчення кабали. На сайті — відеолекції, вступ до традиції, бібліографія, теми для споглядання (чотири світи, доля, Дерево життя, психіка тощо), архів статей, відео й аудіо, книги, навчальні групи в багатьох країнах та онлайн, літня школа й самостійний онлайн-курс «Kabbalah and the Psyche».', 'The Society preserves the spiritual legacy of Z''ev ben Shimon Halevi and the wisdom of the Toledano tradition and encourages the study of Kabbalah. The site has video lectures, an introduction to the tradition, a bibliography, contemplation themes (the four worlds, fate and destiny, the Tree of Life, the psyche and more), an archive of articles, video and audio, books, study groups in many countries and online, a summer school and the self-guided online course "Kabbalah and the Psyche".', 'Відеолекції
Архів статей і аудіо
Навчальні групи
Онлайн-курс «Kabbalah and the Psyche»', 'Video lectures
Article and audio archive
Study groups
"Kabbalah and the Psyche" online course', 'Ті, хто вивчає кабалу в толедській традиції.', 'People studying Kabbalah in the Toledano tradition.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kabbalahsociety.org' OR LOWER(`name`) = LOWER('Kabbalah Society')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'kabbalah' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The International Kabbalah Society preserves the legacy of Z''ev ben Shimon Halevi and the Toledano tradition: video lectures, articles, books, study groups and online courses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Society preserves the spiritual legacy of Z''ev ben Shimon Halevi and the wisdom of the Toledano tradition and encourages the study of Kabbalah. The site has video lectures, an introduction to the tradition, a bibliography, contemplation themes (the four worlds, fate and destiny, the Tree of Life, the psyche and more), an archive of articles, video and audio, books, study groups in many countries and online, a summer school and the self-guided online course "Kabbalah and the Psyche".', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Video lectures
Article and audio archive
Study groups
"Kabbalah and the Psyche" online course', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People studying Kabbalah in the Toledano tradition.', 'manual' FROM DUAL WHERE @new = 1;

-- Kabbalah4All — Кабала
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kabbalah4all.com' OR LOWER(`name`) = LOWER('Kabbalah4All'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kabbalah4All', NULL, 'https://www.kabbalah4all.com', NULL, NULL, 'Kabbalah4All — онлайн-сефардська громада з наголосом на кабалі: трансляції служб на Шабат і свята, навчання Сефер Єціра, молитовник і спільнота в Discord.', 'Kabbalah4All is an online Sephardic congregation focused on Kabbalah: live-streamed Shabbat and festival services, Sefer Yetzirah study, a siddur and a Discord community.', 'Онлайн-сефардська синагога з акцентом на кабалі (єврейській містиці). Запрошує на живі трансляції служб на Шабат і свята та на кабалістичні заняття. Ресурси: вивчення івриту й Сефер Єціра, каванот, наспіви Тори й гафтари, сидур, благословення, молитви, Теґілім, Перек Шира, махзори на свята. Є календар подій, членство, розсилка й Discord-спільнота.', 'An online Sephardic synagogue with an emphasis on Kabbalah (Jewish mysticism). It invites people to live-streamed Shabbat and festival services and Kabbalistic studies. Resources include Hebrew and Sefer Yetzirah study, kavanot, Torah and Haftarah cantillation, a siddur, blessings, prayers, Tehilim, Perek Shirah and holiday machzorim. There is an events calendar, membership, a newsletter and a Discord community.', 'Трансляції служб
Вивчення Сефер Єціра
Сидур і молитви
Спільнота в Discord', 'Live-streamed services
Sefer Yetzirah study
Siddur and prayers
Discord community', 'Ті, хто шукає онлайн-громаду з кабалістичним ухилом.', 'People looking for an online community with a Kabbalistic focus.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kabbalah4all.com' OR LOWER(`name`) = LOWER('Kabbalah4All')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'kabbalah' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Kabbalah4All is an online Sephardic congregation focused on Kabbalah: live-streamed Shabbat and festival services, Sefer Yetzirah study, a siddur and a Discord community.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An online Sephardic synagogue with an emphasis on Kabbalah (Jewish mysticism). It invites people to live-streamed Shabbat and festival services and Kabbalistic studies. Resources include Hebrew and Sefer Yetzirah study, kavanot, Torah and Haftarah cantillation, a siddur, blessings, prayers, Tehilim, Perek Shirah and holiday machzorim. There is an events calendar, membership, a newsletter and a Discord community.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Live-streamed services
Sefer Yetzirah study
Siddur and prayers
Discord community', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People looking for an online community with a Kabbalistic focus.', 'manual' FROM DUAL WHERE @new = 1;

-- Kli — Кабала
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kli.one' OR LOWER(`name`) = LOWER('Kli'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kli', NULL, 'https://kli.one', NULL, NULL, 'Kli — онлайн-платформа міжнародної спільноти кабали Бней Барух для щоденних уроків, зустрічей у «десятках», свят і спілкування друзів із 72 країн.', 'Kli is the online platform of Bnei Baruch''s global Kabbalah community for daily lessons, "Ten" meetings, holidays and connection among friends from 72 countries.', 'Платформа спільноти, що забезпечує зв''язок під час щоденних уроків кабали, зустрічей, свят і спільних трапез. Кожен учасник може взаємодіяти своєю мовою — і зі своєю «десяткою», і з усією світовою спільнотою з понад 72 країн. Розвиток функцій і продуктивності системи підтримують самі учасники. Вхід і реєстрація — на сайті.', 'A community platform that keeps people connected during daily Kabbalah lessons, gatherings, holidays and meals. Each friend can interact in their own language, both with their Ten and with the worldwide community from more than 72 countries. New features and performance work are supported by the members themselves. Login and sign-up are on the site.', 'Щоденні уроки онлайн
Зустрічі в «десятках»
Учасники з 72 країн
Різні мови', 'Daily online lessons
Ten meetings
Members from 72 countries
Multiple languages', 'Учасники спільноти Бней Барух.', 'Members of the Bnei Baruch community.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kli.one' OR LOWER(`name`) = LOWER('Kli')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'kabbalah' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Kli is the online platform of Bnei Baruch''s global Kabbalah community for daily lessons, "Ten" meetings, holidays and connection among friends from 72 countries.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A community platform that keeps people connected during daily Kabbalah lessons, gatherings, holidays and meals. Each friend can interact in their own language, both with their Ten and with the worldwide community from more than 72 countries. New features and performance work are supported by the members themselves. Login and sign-up are on the site.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Daily online lessons
Ten meetings
Members from 72 countries
Multiple languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Members of the Bnei Baruch community.', 'manual' FROM DUAL WHERE @new = 1;

-- Laitman.ru — Кабала
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'laitman.ru' OR LOWER(`name`) = LOWER('Laitman.ru'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Laitman.ru', NULL, 'https://www.laitman.ru', NULL, NULL, 'Персональний блог Михаеля Лайтмана російською: кабала, наука й сенс життя, ранкові уроки, відеовідповіді та запитання до автора.', 'Michael Laitman''s personal blog in Russian on Kabbalah, science and the meaning of life, with morning lessons, video answers and questions to the author.', 'Російськомовний блог Михаеля Лайтмана «Каббала, наука и смысл жизни». Записи впорядковано за темами: ранкові уроки, Бааль Сулам, Зогар, духовна робота в групі, «десятки», виховання дітей, сприйняття реальності, криза й глобалізація тощо. Є карта блогу, фотоальбом, розділ «Каббала в інтернеті», відеовідповіді й форма для запитання автору.', 'Michael Laitman''s Russian-language blog "Kabbalah, Science and the Meaning of Life". Posts are organized by topic: morning lessons, Baal HaSulam, the Zohar, spiritual work in a group, "tens", raising children, perception of reality, crisis and globalization and more. There is a blog map, a photo album, a "Kabbalah on the internet" section, video answers and a form to ask the author a question.', 'Записи за темами
Ранкові уроки
Відеовідповіді
Запитання автору', 'Posts by topic
Morning lessons
Video answers
Ask the author', 'Російськомовні читачі, що вивчають кабалу.', 'Russian-speaking readers studying Kabbalah.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'laitman.ru' OR LOWER(`name`) = LOWER('Laitman.ru')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'kabbalah' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Michael Laitman''s personal blog in Russian on Kabbalah, science and the meaning of life, with morning lessons, video answers and questions to the author.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Michael Laitman''s Russian-language blog "Kabbalah, Science and the Meaning of Life". Posts are organized by topic: morning lessons, Baal HaSulam, the Zohar, spiritual work in a group, "tens", raising children, perception of reality, crisis and globalization and more. There is a blog map, a photo album, a "Kabbalah on the internet" section, video answers and a form to ask the author a question.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Posts by topic
Morning lessons
Video answers
Ask the author', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Russian-speaking readers studying Kabbalah.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий блог', 'Open blog' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open blog', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Michael Laitman — Кабала
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'michaellaitman.com' OR LOWER(`name`) = LOWER('Michael Laitman'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Michael Laitman', NULL, 'https://www.michaellaitman.com', NULL, NULL, 'Офіційний сайт Михаеля Лайтмана, засновника Бней Барух: профіль, статті, книги й публікації, інтегральне виховання, матеріали в медіа.', 'The official site of Michael Laitman, founder of Bnei Baruch: profile, articles, books and publications, integral education and media appearances.', 'Персональний сайт Михаеля Лайтмана з гаслом «Щоб змінити світ — зміни людину». Розділи: профіль, інтегральне виховання, книги й публікації, виступи в медіа та статті на теми освіти, економіки, людських стосунків і глобальної взаємозалежності. Доступний багатьма мовами, зокрема англійською, івритом, російською, іспанською, німецькою, французькою та італійською.', 'Michael Laitman''s personal site with the motto "To change the world, change man". Sections include his profile, integral education, books and publications, media appearances and articles on education, economy, human relations and global interdependence. It is available in many languages, including English, Hebrew, Russian, Spanish, German, French and Italian.', 'Статті й книги
Інтегральне виховання
Матеріали в медіа
Багато мов', 'Articles and books
Integral education
Media appearances
Many languages', 'Читачі праць Михаеля Лайтмана.', 'Readers of Michael Laitman''s work.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'michaellaitman.com' OR LOWER(`name`) = LOWER('Michael Laitman')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'kabbalah' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The official site of Michael Laitman, founder of Bnei Baruch: profile, articles, books and publications, integral education and media appearances.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Michael Laitman''s personal site with the motto "To change the world, change man". Sections include his profile, integral education, books and publications, media appearances and articles on education, economy, human relations and global interdependence. It is available in many languages, including English, Hebrew, Russian, Spanish, German, French and Italian.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Articles and books
Integral education
Media appearances
Many languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Readers of Michael Laitman''s work.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Zohar (Kabbalah Centre) — Кабала
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'zohar.com' OR LOWER(`name`) = LOWER('Zohar (Kabbalah Centre)'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Zohar (Kabbalah Centre)', NULL, 'https://www.zohar.com', NULL, NULL, 'Zohar.com — сайт Kabbalah Centre про книгу Зогар: що це за текст, його історія та способи читання й вивчення.', 'Zohar.com is the Kabbalah Centre''s site about the Zohar: what the text is, its history and ways to read and study it.', 'Сайт Kabbalah Centre, присвячений Зогару — головному тексту кабали. Пояснює, що Зогар, за переказом, складений кабалістом рабі Шимоном бар Йохаєм і є набором із двадцяти трьох книг — коментарем до біблійних і духовних питань у формі бесід між духовними вчителями. Сайт розповідає про значення тексту в традиції Центру й пропонує матеріали для читання та вивчення.', 'A Kabbalah Centre site dedicated to the Zohar, the central text of Kabbalah. It explains that the Zohar, attributed to the kabbalist Rav Shimon bar Yochai, is a set of twenty-three books: a commentary on biblical and spiritual matters in the form of conversations among spiritual masters. The site describes the text''s role in the Centre''s tradition and offers material for reading and study.', 'Про книгу Зогар
Історія тексту
Матеріали для вивчення
Від Kabbalah Centre', 'About the Zohar
History of the text
Study materials
By the Kabbalah Centre', 'Ті, хто хоче познайомитися із Зогаром.', 'People who want to get to know the Zohar.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'zohar.com' OR LOWER(`name`) = LOWER('Zohar (Kabbalah Centre)')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'kabbalah' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Zohar.com is the Kabbalah Centre''s site about the Zohar: what the text is, its history and ways to read and study it.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A Kabbalah Centre site dedicated to the Zohar, the central text of Kabbalah. It explains that the Zohar, attributed to the kabbalist Rav Shimon bar Yochai, is a set of twenty-three books: a commentary on biblical and spiritual matters in the form of conversations among spiritual masters. The site describes the text''s role in the Centre''s tradition and offers material for reading and study.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'About the Zohar
History of the text
Study materials
By the Kabbalah Centre', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to get to know the Zohar.', 'manual' FROM DUAL WHERE @new = 1;

-- ZoharApp — Кабала
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'zoharapp.com' OR LOWER(`name`) = LOWER('ZoharApp'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ZoharApp', NULL, 'https://www.zoharapp.com', NULL, NULL, 'ZoharApp — щоденне читання Зогару арамейською (видання Мантуя 1558), AI-хавруса для пояснень, пошук по джерелах і закладки; інтерфейс івритом та англійською.', 'ZoharApp offers daily Zohar reading in the original Aramaic (Mantua 1558 edition), an AI study partner for explanations, source search and bookmarks, in Hebrew and English.', 'Вебзастосунок для щоденного вивчення Зогару. Текст — оригінальною арамейською за виданням Мантуя 1558 року (суспільне надбання). AI-хавруса пояснює уривки, шукає (RAG) у перевірених джерелах і наводить традиційні прочитання; застосунок наголошує, що це лише допомога в навчанні, а не галахічне рішення. Є щоденний уривок, повне читання, локальні закладки й інтерактивна «лабораторія Сефер Єціра» з графом 32 шляхів мудрості.', 'A web app for daily Zohar study. The text is the original Aramaic of the 1558 Mantua edition (public domain). An AI chavruta explains passages, searches approved sources (RAG) and presents traditional readings; the app notes it is a study aid only, not a halachic ruling. It has a daily passage, full reading, local bookmarks and an interactive Sefer Yetzirah lab with a graph of the 32 paths of wisdom.', 'Щоденний уривок Зогару
AI-хавруса
RAG-пошук по джерелах
Граф 32 шляхів Сефер Єціра
Локальні закладки', 'Daily Zohar passage
AI chavruta
RAG source search
Sefer Yetzirah 32-paths graph
Local bookmarks', 'Ті, хто читає Зогар в оригіналі.', 'People reading the Zohar in the original.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'zoharapp.com' OR LOWER(`name`) = LOWER('ZoharApp')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'kabbalah' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ZoharApp offers daily Zohar reading in the original Aramaic (Mantua 1558 edition), an AI study partner for explanations, source search and bookmarks, in Hebrew and English.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A web app for daily Zohar study. The text is the original Aramaic of the 1558 Mantua edition (public domain). An AI chavruta explains passages, searches approved sources (RAG) and presents traditional readings; the app notes it is a study aid only, not a halachic ruling. It has a daily passage, full reading, local bookmarks and an interactive Sefer Yetzirah lab with a graph of the 32 paths of wisdom.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Daily Zohar passage
AI chavruta
RAG source search
Sefer Yetzirah 32-paths graph
Local bookmarks', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People reading the Zohar in the original.', 'manual' FROM DUAL WHERE @new = 1;

-- Hourglass — Свідки Єгови
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hourglass-app.com' OR LOWER(`name`) = LOWER('Hourglass'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Hourglass', NULL, 'https://hourglass-app.com', NULL, NULL, 'Hourglass — вебзастосунок для зборів Свідків Єгови: вісники, групи служіння, відвідуваність, території, розклади зібрань, прибирання й публічного свідчення.', 'Hourglass is a web app for Jehovah''s Witnesses congregations: publishers, field service groups, meeting attendance, territories and schedules for meetings, cleaning and public witnessing.', 'Hourglass призначений для зборів Свідків Єгови. Допомагає впорядкувати вісників, групи проповідницького служіння, екстрені контакти, відвідуваність зібрань і території, а також складати розклади прибирання, служіння, публічного свідчення та зібрань середини тижня й вихідних. Інтерфейс перекладено багатьма мовами, зокрема українською; є розділи про безпеку й питання-відповіді. Проєкт існує на пожертви.', 'Hourglass is built for congregations of Jehovah''s Witnesses. It helps organize publishers, field service groups, emergency contacts, meeting attendance and territories, and schedule cleaning, field service, public witnessing and midweek and weekend meetings. The interface is translated into many languages, including Ukrainian, and there are security and Q&A sections. The project is donation-supported.', 'Облік вісників і груп
Відвідуваність
Території
Розклади зібрань
Українська мова', 'Publishers and groups
Attendance
Territories
Meeting schedules
Ukrainian language', 'Секретарі й старійшини зборів.', 'Congregation secretaries and elders.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hourglass-app.com' OR LOWER(`name`) = LOWER('Hourglass')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'jehovahs-witnesses' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Hourglass is a web app for Jehovah''s Witnesses congregations: publishers, field service groups, meeting attendance, territories and schedules for meetings, cleaning and public witnessing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Hourglass is built for congregations of Jehovah''s Witnesses. It helps organize publishers, field service groups, emergency contacts, meeting attendance and territories, and schedule cleaning, field service, public witnessing and midweek and weekend meetings. The interface is translated into many languages, including Ukrainian, and there are security and Q&A sections. The project is donation-supported.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Publishers and groups
Attendance
Territories
Meeting schedules
Ukrainian language', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Congregation secretaries and elders.', 'manual' FROM DUAL WHERE @new = 1;

-- JW Broadcasting — Свідки Єгови
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jw.org/en/library/videos' OR LOWER(`name`) = LOWER('JW Broadcasting'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'JW Broadcasting', NULL, 'https://www.jw.org/en/library/videos/', NULL, NULL, 'JW Broadcasting — відеобібліотека Свідків Єгови: біблійні відео для сімей, підлітків і дітей, документальні фільми, музика й аудіодрами для перегляду або завантаження.', 'JW Broadcasting is the Jehovah''s Witnesses video library: Bible-based videos for families, teens and children, documentaries, music and audio dramas to watch or download.', 'Онлайн-відеобібліотека на JW.ORG із програмами JW Broadcasting. Тут зібрано біблійні відео для сімей, підлітків і дітей, документальні фільми про Свідків Єгови, музику, аудіодрами й драматизовані читання Біблії. Відео можна дивитися онлайн або завантажувати, вони також доступні в застосунку JW Library. Безкоштовно.', 'The online video library on JW.ORG with JW Broadcasting programs. It collects Bible-based videos for families, teenagers and children, documentaries about Jehovah''s Witnesses, music, audio dramas and dramatic Bible readings. Videos can be watched online or downloaded and are also available in the JW Library app. Free.', 'Відео для сімей і дітей
Документальні фільми
Музика й аудіодрами
Завантаження відео', 'Videos for families and children
Documentaries
Music and audio dramas
Video downloads', 'Сім''ї та глядачі, які шукають біблійні відео.', 'Families and viewers looking for Bible-based videos.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jw.org/en/library/videos' OR LOWER(`name`) = LOWER('JW Broadcasting')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'jehovahs-witnesses' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'JW Broadcasting is the Jehovah''s Witnesses video library: Bible-based videos for families, teens and children, documentaries, music and audio dramas to watch or download.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The online video library on JW.ORG with JW Broadcasting programs. It collects Bible-based videos for families, teenagers and children, documentaries about Jehovah''s Witnesses, music, audio dramas and dramatic Bible readings. Videos can be watched online or downloaded and are also available in the JW Library app. Free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Videos for families and children
Documentaries
Music and audio dramas
Video downloads', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Families and viewers looking for Bible-based videos.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Перегляд і завантаження', 'Watch and download' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Watch and download', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- JW Conf — Свідки Єгови
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jwconf.com' OR LOWER(`name`) = LOWER('JW Conf'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'JW Conf', NULL, 'https://www.jwconf.com', NULL, NULL, 'JW Conf — система відеоконференцій для зібрань Свідків Єгови: двостороннє аудіо й відео для тих, хто не може бути присутнім особисто.', 'JW Conf is a video conferencing system for Jehovah''s Witnesses meetings with two-way audio and video for those who can''t attend in person.', 'Інтерактивна система відеоконференцій, розроблена для зібрань Свідків Єгови. Дає змогу тим, хто не може бути присутнім фізично, брати участь у зібранні з двостороннім звуком і відео. Застосунки є для Android, iPhone і iPad, Kindle, Windows, macOS і Roku; сайт пояснює, як підключитися окремому учаснику і як налаштувати сервіс для збору. Інтерфейс кількома мовами.', 'An interactive video conferencing system developed for the meetings of Jehovah''s Witnesses. It lets those who cannot be physically present take part with two-way audio and video. Apps are available for Android, iPhone and iPad, Kindle, Windows, macOS and Roku; the site explains how an individual connects and how a congregation sets up the service. Several interface languages.', 'Двостороннє аудіо й відео
Android, iOS, Windows, macOS
Roku і Kindle
Кілька мов', 'Two-way audio and video
Android, iOS, Windows, macOS
Roku and Kindle
Several languages', 'Збори й вісники, які приєднуються до зібрань дистанційно.', 'Congregations and publishers joining meetings remotely.', 'web,mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jwconf.com' OR LOWER(`name`) = LOWER('JW Conf')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'jehovahs-witnesses' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'JW Conf is a video conferencing system for Jehovah''s Witnesses meetings with two-way audio and video for those who can''t attend in person.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An interactive video conferencing system developed for the meetings of Jehovah''s Witnesses. It lets those who cannot be physically present take part with two-way audio and video. Apps are available for Android, iPhone and iPad, Kindle, Windows, macOS and Roku; the site explains how an individual connects and how a congregation sets up the service. Several interface languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Two-way audio and video
Android, iOS, Windows, macOS
Roku and Kindle
Several languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Congregations and publishers joining meetings remotely.', 'manual' FROM DUAL WHERE @new = 1;

-- JW Library — Свідки Єгови
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jw.org/en/online-help/jw-library' OR LOWER(`name`) = LOWER('JW Library'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'JW Library', NULL, 'https://www.jw.org/en/online-help/jw-library/', NULL, NULL, 'JW Library — офіційний застосунок Свідків Єгови: переклади Біблії, книги, брошури, журнали й відео офлайн, нотатки, позначки та матеріали для зібрань.', 'JW Library is the official Jehovah''s Witnesses app: Bible translations, books, brochures, magazines and videos offline, notes, highlights and meeting materials.', 'Офіційний застосунок організації для читання й вивчення. Можна завантажувати переклади Біблії й публікації для читання без інтернету, порівнювати переклади, виділяти текст, додавати нотатки й теги, використовувати закладки, переглядати відео й готуватися до зібрань. На JW.ORG є довідка з покроковими інструкціями та відповідями на часті запитання щодо функцій застосунку. Застосунок безкоштовний.', 'The organization''s official app for reading and study. You can download Bible translations and publications to read offline, compare translations, highlight text, add notes and tags, use bookmarks, watch videos and prepare for meetings. JW.ORG hosts a help section with step-by-step tutorials and answers to frequently asked questions about the app''s features. The app is free.', 'Біблія й публікації офлайн
Порівняння перекладів
Нотатки, позначки й теги
Матеріали для зібрань
Безкоштовно', 'Bible and publications offline
Compare translations
Notes, highlights and tags
Meeting materials
Free', 'Свідки Єгови, які читають і вивчають Біблію.', 'Jehovah''s Witnesses who read and study the Bible.', 'mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jw.org/en/online-help/jw-library' OR LOWER(`name`) = LOWER('JW Library')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'jehovahs-witnesses' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'JW Library is the official Jehovah''s Witnesses app: Bible translations, books, brochures, magazines and videos offline, notes, highlights and meeting materials.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The organization''s official app for reading and study. You can download Bible translations and publications to read offline, compare translations, highlight text, add notes and tags, use bookmarks, watch videos and prepare for meetings. JW.ORG hosts a help section with step-by-step tutorials and answers to frequently asked questions about the app''s features. The app is free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Bible and publications offline
Compare translations
Notes, highlights and tags
Meeting materials
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Jehovah''s Witnesses who read and study the Bible.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Повний функціонал', 'Full functionality' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Full functionality', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- JW.ORG — Свідки Єгови
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jw.org' OR LOWER(`name`) = LOWER('JW.ORG'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'JW.ORG', NULL, 'https://www.jw.org', NULL, NULL, 'JW.ORG — офіційний сайт Свідків Єгови: Біблія онлайн, публікації, відео, музика, курс вивчення Біблії й відомості про вірування та організацію.', 'JW.ORG is the official website of Jehovah''s Witnesses: the Bible online, publications, videos, music, a Bible study course and information about beliefs and the organization.', 'Офіційний сайт Свідків Єгови дає онлайн-доступ до Біблії, біблійних публікацій і новин та описує їхні вірування й організацію. Розділи «Біблійні вчення» (відповіді на запитання, пояснення віршів, курс вивчення Біблії, теми про сім''ю, молодь і дітей), «Бібліотека» (Біблії, книги, брошури, журнали, робочі зошити для зібрань, відео JW Broadcasting, музика, аудіодрами), новини й розділ «Про нас». Сайт доступний багатьма мовами, матеріали можна читати або завантажувати безкоштовно.', 'The official site of Jehovah''s Witnesses provides online access to the Bible, Bible-based publications and news, and describes their beliefs and organization. Sections include Bible Teachings (questions answered, verses explained, a Bible study course, topics for families, teens and children), the Library (Bibles, books, brochures, magazines, meeting workbooks, JW Broadcasting videos, music, audio dramas), news and About Us. The site is available in many languages and materials can be read or downloaded free.', 'Біблія онлайн
Публікації й журнали
Відео й музика
Курс вивчення Біблії
Багато мов', 'Bible online
Publications and magazines
Videos and music
Bible study course
Many languages', 'Свідки Єгови та всі, хто цікавиться їхніми віруваннями.', 'Jehovah''s Witnesses and anyone interested in their beliefs.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jw.org' OR LOWER(`name`) = LOWER('JW.ORG')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'jehovahs-witnesses' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'JW.ORG is the official website of Jehovah''s Witnesses: the Bible online, publications, videos, music, a Bible study course and information about beliefs and the organization.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The official site of Jehovah''s Witnesses provides online access to the Bible, Bible-based publications and news, and describes their beliefs and organization. Sections include Bible Teachings (questions answered, verses explained, a Bible study course, topics for families, teens and children), the Library (Bibles, books, brochures, magazines, meeting workbooks, JW Broadcasting videos, music, audio dramas), news and About Us. The site is available in many languages and materials can be read or downloaded free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Bible online
Publications and magazines
Videos and music
Bible study course
Many languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Jehovah''s Witnesses and anyone interested in their beliefs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Читання й завантаження', 'Reading and downloads' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Reading and downloads', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Meeting Schedule Assistant — Свідки Єгови
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'publictalksoftware.co.uk' OR LOWER(`name`) = LOWER('Meeting Schedule Assistant'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Meeting Schedule Assistant', NULL, 'https://www.publictalksoftware.co.uk', NULL, NULL, 'Meeting Schedule Assistant — програма для Windows від Theocratic Software для розкладів зібрань Свідків Єгови; є також програма публічних промов і графік візитів.', 'Meeting Schedule Assistant is Windows software from Theocratic Software for Jehovah''s Witnesses meeting schedules, alongside Public Talks and Visits Rota.', 'Theocratic Software створює програми для Свідків Єгови. Головна — Meeting Schedule Assistant для складання розкладів зібрань; також є програма планування публічних промов Public Talks і Visits Rota. На сайті — огляд можливостей, онлайн-довідка, пошук відеоінструкцій, трекер проблем для звітів і запитів функцій, розсилка й відгуки. Програми безкоштовні й існують завдяки пожертвам.', 'Theocratic Software makes programs for Jehovah''s Witnesses. The main one is Meeting Schedule Assistant for building meeting schedules; there is also the Public Talks scheduling program and Visits Rota. The site has a feature overview, online help, searchable video tutorials, an issue tracker for reports and feature requests, a newsletter and reviews. The programs are free and supported by donations.', 'Розклади зібрань
Планування публічних промов
Відеоінструкції
Трекер запитів', 'Meeting schedules
Public talk scheduling
Video tutorials
Issue tracker', 'Відповідальні за розклади у зборах.', 'Congregation schedulers.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'publictalksoftware.co.uk' OR LOWER(`name`) = LOWER('Meeting Schedule Assistant')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'jehovahs-witnesses' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Meeting Schedule Assistant is Windows software from Theocratic Software for Jehovah''s Witnesses meeting schedules, alongside Public Talks and Visits Rota.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Theocratic Software makes programs for Jehovah''s Witnesses. The main one is Meeting Schedule Assistant for building meeting schedules; there is also the Public Talks scheduling program and Visits Rota. The site has a feature overview, online help, searchable video tutorials, an issue tracker for reports and feature requests, a newsletter and reviews. The programs are free and supported by donations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Meeting schedules
Public talk scheduling
Video tutorials
Issue tracker', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Congregation schedulers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Підтримка пожертвами', 'Donation-supported' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Donation-supported', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- NW Publisher — Свідки Єгови
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nwpublisher.com' OR LOWER(`name`) = LOWER('NW Publisher'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'NW Publisher', NULL, 'https://nwpublisher.com', NULL, NULL, 'NW Publisher — безкоштовний застосунок для iOS і Android для вісників зборів: призначення на зібраннях, публічні промови й інформація про збір.', 'NW Publisher is a free iOS and Android app for congregation publishers: meeting assignments, public talk and weekend assignments and congregation information.', 'New World Publisher — безкоштовний застосунок для Apple iOS і Google Android, створений Свідками Єгови для Свідків Єгови. Вісники встановлюють його, щоб бути на зв''язку зі своїм збором: бачити призначення на зібранні «Християнське життя і служіння», публічні промови й призначення вихідних, інформацію про збір. Працює разом із NW Scheduler, має довідку й кілька мов інтерфейсу.', 'New World Publisher is a free Apple iOS and Google Android app created by Jehovah''s Witnesses for Jehovah''s Witnesses. Publishers install it to stay connected with their congregation: seeing Christian Life and Ministry Meeting assignments, public talk and weekend assignments and congregation information. It works with NW Scheduler, has help and support and several interface languages.', 'Призначення на зібраннях
Публічні промови
Інформація про збір
iOS і Android
Безкоштовно', 'Meeting assignments
Public talks
Congregation information
iOS and Android
Free', 'Вісники зборів, які користуються NW Scheduler.', 'Publishers in congregations using NW Scheduler.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nwpublisher.com' OR LOWER(`name`) = LOWER('NW Publisher')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'jehovahs-witnesses' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'NW Publisher is a free iOS and Android app for congregation publishers: meeting assignments, public talk and weekend assignments and congregation information.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'New World Publisher is a free Apple iOS and Google Android app created by Jehovah''s Witnesses for Jehovah''s Witnesses. Publishers install it to stay connected with their congregation: seeing Christian Life and Ministry Meeting assignments, public talk and weekend assignments and congregation information. It works with NW Scheduler, has help and support and several interface languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Meeting assignments
Public talks
Congregation information
iOS and Android
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Publishers in congregations using NW Scheduler.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'iOS і Android', 'iOS and Android' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'iOS and Android', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- NW Scheduler — Свідки Єгови
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nwscheduler.com' OR LOWER(`name`) = LOWER('NW Scheduler'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'NW Scheduler', NULL, 'https://nwscheduler.com', NULL, NULL, 'NW Scheduler — програма для зборів Свідків Єгови: розклад зібрання «Християнське життя і служіння», публічних промов, прибирання, служіння зі стендами, території й облік секретаря.', 'NW Scheduler is congregation software for Jehovah''s Witnesses: scheduling the Christian Life and Ministry Meeting, public talks, cleaning, cart witnessing, territories and secretary records.', 'New World Scheduler поєднує в одній програмі планування зібрання «Християнське життя і служіння», графік публічних промов, прибирання й обслуговування Залу Царства, публічного свідчення зі стендами та проповідницького служіння. Є програма для секретаря, керування територіями, планування візиту районного наглядача, автопризначення, шаблони звітів, обмін даними між зборами й кілька мов. Учасники отримують призначення в безкоштовному застосунку NW Publisher.', 'New World Scheduler combines in one program scheduling for the Christian Life and Ministry Meeting, public talks, Kingdom Hall cleaning and maintenance, public witnessing carts and field service. It includes a secretary program, territory management, circuit overseer visit planning, auto-assign, report templates, congregation sharing and multiple languages. Members receive assignments in the free NW Publisher app.', 'Розклад зібрань
Публічні промови
Стенди й служіння
Програма секретаря
Автопризначення', 'Meeting schedules
Public talks
Carts and field service
Secretary program
Auto-assign', 'Старійшини й відповідальні за розклади у зборах.', 'Elders and schedulers in congregations.', 'desktop,web', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nwscheduler.com' OR LOWER(`name`) = LOWER('NW Scheduler')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'jehovahs-witnesses' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'NW Scheduler is congregation software for Jehovah''s Witnesses: scheduling the Christian Life and Ministry Meeting, public talks, cleaning, cart witnessing, territories and secretary records.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'New World Scheduler combines in one program scheduling for the Christian Life and Ministry Meeting, public talks, Kingdom Hall cleaning and maintenance, public witnessing carts and field service. It includes a secretary program, territory management, circuit overseer visit planning, auto-assign, report templates, congregation sharing and multiple languages. Members receive assignments in the free NW Publisher app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Meeting schedules
Public talks
Carts and field service
Secretary program
Auto-assign', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Elders and schedulers in congregations.', 'manual' FROM DUAL WHERE @new = 1;

-- Territory Helper — Свідки Єгови
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'territoryhelper.com' OR LOWER(`name`) = LOWER('Territory Helper'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Territory Helper', NULL, 'https://territoryhelper.com', NULL, NULL, 'Territory Helper — вебсервіс картографування й керування територіями проповідницького служіння для зборів Свідків Єгови; 60 днів безкоштовно.', 'Territory Helper is a web service for mapping and managing field service territories for Jehovah''s Witnesses congregations; free for 60 days.', 'Вебсервіс для тих, хто відповідає за території у зборах. Дає змогу малювати й видавати території на карті, стежити за їх опрацюванням, проводити кампанії (зокрема імпорт кампаній із CSV або Excel), а вісникам — працювати з територією з телефона. Інтерфейс доступний десятками мов, зокрема українською. Є демо; сервіс безкоштовний перші 60 днів, далі підтримується пожертвами.', 'A web service for those responsible for congregation territories. It lets you draw and assign territories on a map, track their coverage and run campaigns (including importing campaigns from CSV or Excel), while publishers work their territory from a phone. The interface is available in dozens of languages, including Ukrainian. There is a demo; the service is free for the first 60 days and is supported by donations.', 'Території на карті
Видача й облік
Імпорт кампаній із CSV/Excel
Десятки мов
Демо', 'Territories on a map
Assignment and tracking
Campaign import from CSV/Excel
Dozens of languages
Demo', 'Служителі територій у зборах.', 'Territory servants in congregations.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'territoryhelper.com' OR LOWER(`name`) = LOWER('Territory Helper')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'jehovahs-witnesses' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Territory Helper is a web service for mapping and managing field service territories for Jehovah''s Witnesses congregations; free for 60 days.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A web service for those responsible for congregation territories. It lets you draw and assign territories on a map, track their coverage and run campaigns (including importing campaigns from CSV or Excel), while publishers work their territory from a phone. The interface is available in dozens of languages, including Ukrainian. There is a demo; the service is free for the first 60 days and is supported by donations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Territories on a map
Assignment and tracking
Campaign import from CSV/Excel
Dozens of languages
Demo', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Territory servants in congregations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Пробний період', 'Trial', 0.00, 'free', '60 днів безкоштовно', 'Free for 60 days' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Пробний період' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Trial', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for 60 days', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Watchtower Online Library — Свідки Єгови
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wol.jw.org' OR LOWER(`name`) = LOWER('Watchtower Online Library'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Watchtower Online Library', NULL, 'https://wol.jw.org', NULL, NULL, 'Онлайн-бібліотека «Вартової башти» — офіційний дослідницький інструмент для пошуку в Біблії та публікаціях Свідків Єгови різними мовами, з щоденним текстом.', 'Watchtower Online Library is the official research tool for searching the Bible and Jehovah''s Witnesses publications in many languages, with a daily text.', 'Авторизований сайт Свідків Єгови для пошуку в їхніх публікаціях різними мовами. Розділи: Біблія, публікації (англійською — за 1950–2027 роки), зібрання та щоденний біблійний текст із поясненням. Для завантаження публікацій бібліотека відсилає на jw.org. Доступ безкоштовний.', 'An authorized Jehovah''s Witnesses site for researching their publications in various languages. Sections cover the Bible, publications (in English from 1950 to 2027), meetings and a daily Bible text with commentary. For downloads, the library refers to jw.org. Access is free.', 'Пошук у публікаціях
Публікації з 1950 року
Щоденний текст
Багато мов', 'Publication search
Publications since 1950
Daily text
Many languages', 'Свідки Єгови, які готуються до зібрань і досліджують теми.', 'Jehovah''s Witnesses preparing for meetings and researching topics.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wol.jw.org' OR LOWER(`name`) = LOWER('Watchtower Online Library')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'jehovahs-witnesses' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Watchtower Online Library is the official research tool for searching the Bible and Jehovah''s Witnesses publications in many languages, with a daily text.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An authorized Jehovah''s Witnesses site for researching their publications in various languages. Sections cover the Bible, publications (in English from 1950 to 2027), meetings and a daily Bible text with commentary. For downloads, the library refers to jw.org. Access is free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Publication search
Publications since 1950
Daily text
Many languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Jehovah''s Witnesses preparing for meetings and researching topics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Book of Mormon Videos — Церква святих останніх днів (мормони)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'churchofjesuschrist.org/media/collection/book-of-mormon-videos' OR LOWER(`name`) = LOWER('Book of Mormon Videos'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Book of Mormon Videos', NULL, 'https://www.churchofjesuschrist.org/media/collection/book-of-mormon-videos', NULL, NULL, 'Book of Mormon Videos — офіційна відеоколекція Церкви: інсценізації ключових подій і пророків Книги Мормона для дітей і дорослих.', 'Book of Mormon Videos is the Church''s official video collection dramatizing key events and prophets of the Book of Mormon for children and adults.', 'Колекція відео, у якій значні частини Книги Мормона, її пророки, головні персонажі й загальний сюжет інсценізовані, проілюстровані та скорочені для дітей і дорослих. Відео впорядковані за главами (від 1 Нефій і далі), є вигляд сіткою чи списком. Доступно в медіабібліотеці Церкви та її застосунках безкоштовно.', 'A video collection in which significant portions of the Book of Mormon, its prophets, main characters and general narrative are dramatized, depicted and abridged for children and adults. Videos are organized by chapter (from 1 Nephi onward) with grid or list view. Available free in the Church''s media library and apps.', 'Інсценізації Книги Мормона
За главами
Для дітей і дорослих
Безкоштовно', 'Book of Mormon dramatizations
By chapter
For children and adults
Free', 'Сім''ї, вчителі та учні.', 'Families, teachers and students.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'churchofjesuschrist.org/media/collection/book-of-mormon-videos' OR LOWER(`name`) = LOWER('Book of Mormon Videos')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'latter-day-saints' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Book of Mormon Videos is the Church''s official video collection dramatizing key events and prophets of the Book of Mormon for children and adults.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A video collection in which significant portions of the Book of Mormon, its prophets, main characters and general narrative are dramatized, depicted and abridged for children and adults. Videos are organized by chapter (from 1 Nephi onward) with grid or list view. Available free in the Church''s media library and apps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Book of Mormon dramatizations
By chapter
For children and adults
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Families, teachers and students.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Перегляд онлайн', 'Watch online' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Watch online', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- BYUtv — Церква святих останніх днів (мормони)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'byutv.org' OR LOWER(`name`) = LOWER('BYUtv'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'BYUtv', NULL, 'https://www.byutv.org', NULL, NULL, 'BYUtv — безкоштовне сімейне телебачення Університету Бригама Янга: серіали, шоу, документальні фільми й спорт без реклами та контрактів.', 'BYUtv is Brigham Young University''s free family TV: series, shows, documentaries and sports with no commercials or contracts.', 'Телемовник BYU Broadcasting, пов''язаний з університетом Церкви святих останніх днів. Пропонує сімейні комедії, драми, реаліті-шоу (зокрема Relative Race), документальні серії, фільми й спортивний контент BYU; у каталозі є The Chosen, Heartland, Studio C та інші. Перегляд безкоштовний, без реклами, контрактів і кредитної картки; є прямий ефір і застосунки.', 'The broadcaster BYU Broadcasting, linked to the Latter-day Saint church''s university. It offers family comedies, dramas, reality shows (such as Relative Race), documentary series, films and BYU sports; the catalog includes The Chosen, Heartland, Studio C and more. Watching is free with no commercials, contracts or credit card; there is live TV and apps.', 'Сімейні серіали й шоу
Документальні серії
Прямий ефір
Без реклами
Безкоштовно', 'Family series and shows
Documentary series
Live TV
No commercials
Free', 'Сім''ї, які шукають сімейний відеоконтент.', 'Families looking for family-friendly video.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'byutv.org' OR LOWER(`name`) = LOWER('BYUtv')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'latter-day-saints' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'BYUtv is Brigham Young University''s free family TV: series, shows, documentaries and sports with no commercials or contracts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The broadcaster BYU Broadcasting, linked to the Latter-day Saint church''s university. It offers family comedies, dramas, reality shows (such as Relative Race), documentary series, films and BYU sports; the catalog includes The Chosen, Heartland, Studio C and more. Watching is free with no commercials, contracts or credit card; there is live TV and apps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Family series and shows
Documentary series
Live TV
No commercials
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Families looking for family-friendly video.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Без реклами', 'No commercials' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'No commercials', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Church Media Library — Церква святих останніх днів (мормони)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'churchofjesuschrist.org/media' OR LOWER(`name`) = LOWER('Church Media Library'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Church Media Library', NULL, 'https://www.churchofjesuschrist.org/media', NULL, NULL, 'Медіабібліотека Церкви святих останніх днів: відео, зображення й музика від Церкви для пошуку, завантаження й поширення.', 'The Latter-day Saint church''s media library: Church-produced video, images and music to find, download and share.', 'Каталог цифрових медіа, створених Церквою Ісуса Христа святих останніх днів. Можна шукати й завантажувати відео, зображення та музику, переглядати нові надходження (девоціонали, події для молоді, матеріали про конференції) і тематичні колекції, а також ділитися ними.', 'A catalog of digital media created by The Church of Jesus Christ of Latter-day Saints. You can search and download video, images and music, browse new additions (devotionals, youth events, conference material) and themed collections, and share them.', 'Відео, зображення й музика
Завантаження
Тематичні колекції
Нові надходження', 'Video, images and music
Downloads
Themed collections
New additions', 'Вчителі, лідери й члени Церкви.', 'Teachers, leaders and Church members.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'churchofjesuschrist.org/media' OR LOWER(`name`) = LOWER('Church Media Library')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'latter-day-saints' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Latter-day Saint church''s media library: Church-produced video, images and music to find, download and share.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A catalog of digital media created by The Church of Jesus Christ of Latter-day Saints. You can search and download video, images and music, browse new additions (devotionals, youth events, conference material) and themed collections, and share them.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Video, images and music
Downloads
Themed collections
New additions', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Teachers, leaders and Church members.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук і завантаження', 'Search and download' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Search and download', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Come Unto Christ — Церква святих останніх днів (мормони)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'comeuntochrist.org' OR LOWER(`name`) = LOWER('Come Unto Christ'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Come Unto Christ', NULL, 'https://www.comeuntochrist.org', NULL, NULL, 'ComeUntoChrist.org — сайт Церкви святих останніх днів для охочих познайомитися з нею: запит на візит місіонерів, пошук громади й пояснення вірувань.', 'ComeUntoChrist.org is the Latter-day Saint church''s site for newcomers: request a missionary visit, find a congregation and learn about beliefs.', 'Вітальний сайт Церкви Ісуса Христа святих останніх днів для тих, хто хоче з нею познайомитися. Можна попросити візит місіонерів, які пояснять, чого очікувати на зборах, і зустрінуть у церкві, знайти громаду поруч, переглянути відео й матеріали про Ісуса Христа та вчення Церкви.', 'A welcome site of The Church of Jesus Christ of Latter-day Saints for people who want to get to know it. You can request a visit from missionaries who will explain what to expect and greet you at church, find a congregation nearby, and watch videos and materials about Jesus Christ and the Church''s teachings.', 'Запит на візит місіонерів
Пошук громади
Відео про вчення
Для новачків', 'Request a missionary visit
Congregation finder
Videos on teachings
For newcomers', 'Ті, хто вперше цікавиться Церквою.', 'People new to the Church.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'comeuntochrist.org' OR LOWER(`name`) = LOWER('Come Unto Christ')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'latter-day-saints' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ComeUntoChrist.org is the Latter-day Saint church''s site for newcomers: request a missionary visit, find a congregation and learn about beliefs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A welcome site of The Church of Jesus Christ of Latter-day Saints for people who want to get to know it. You can request a visit from missionaries who will explain what to expect and greet you at church, find a congregation nearby, and watch videos and materials about Jesus Christ and the Church''s teachings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Request a missionary visit
Congregation finder
Videos on teachings
For newcomers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People new to the Church.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Deseret Book — Церква святих останніх днів (мормони)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'deseretbook.com' OR LOWER(`name`) = LOWER('Deseret Book'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Deseret Book', NULL, 'https://deseretbook.com', NULL, NULL, 'Deseret Book — інтернет-магазин книг, Писань, музики, фільмів і мистецтва для родин святих останніх днів; безкоштовна доставка від 49 $.', 'Deseret Book is an online store of books, scriptures, music, films and art for Latter-day Saint families; free shipping on orders over $49.', 'Магазин видавництва Deseret Book. Каталог: художня література (роман, історична проза, детективи, підліткова), книги провідників Церкви, натхненні й храмові видання, біографії, книги про сім''ю й виховання, історію та саморозвиток, Писання різними мовами й в обкладинках зі шкіри, щоденники для Писань і аксесуари, церковні ресурси, музика, фільми й мистецтво. Безкоштовна доставка замовлень від 49 $ (з винятками).', 'The Deseret Book publisher''s store. The catalog covers fiction (romance, historical, mystery, teen), books by General Authorities, inspirational and temple titles, biographies, family and parenting, history and self-improvement, scriptures in many languages and leather bindings, scripture journals and accessories, Church resources, music, films and art. Free shipping on orders of $49 or more (exclusions apply).', 'Книги й Писання
Музика й фільми
Мистецтво
Доставка від 49 $ безкоштовна', 'Books and scriptures
Music and films
Art
Free shipping over $49', 'Родини святих останніх днів.', 'Latter-day Saint families.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'deseretbook.com' OR LOWER(`name`) = LOWER('Deseret Book')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'latter-day-saints' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Deseret Book is an online store of books, scriptures, music, films and art for Latter-day Saint families; free shipping on orders over $49.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Deseret Book publisher''s store. The catalog covers fiction (romance, historical, mystery, teen), books by General Authorities, inspirational and temple titles, biographies, family and parenting, history and self-improvement, scriptures in many languages and leather bindings, scripture journals and accessories, Church resources, music, films and art. Free shipping on orders of $49 or more (exclusions apply).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Books and scriptures
Music and films
Art
Free shipping over $49', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Latter-day Saint families.', 'manual' FROM DUAL WHERE @new = 1;

-- Don't Miss This — Церква святих останніх днів (мормони)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dontmissthisstudy.com' OR LOWER(`name`) = LOWER('Don''t Miss This'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Don''t Miss This', NULL, 'https://www.dontmissthisstudy.com', NULL, NULL, 'Don''t Miss This — відео, курси, застосунок і роздруківки для щотижневого домашнього вивчення «Приходьте і слідуйте за Мною».', 'Don''t Miss This offers videos, courses, an app and printables for weekly home-centered Come, Follow Me study.', 'Проєкт для тих, хто шукає ідеї для щотижневого домашнього вивчення за програмою «Приходьте і слідуйте за Мною». Пропонує відео, курси, застосунок, матеріали для друку й події, а також крамницю. Розсилка щотижня надсилає навчальні інструменти й поради для особистого та сімейного вивчення.', 'A project for people looking for ideas for weekly home-centered Come, Follow Me study. It offers videos, courses, an app, printables and events, plus a shop. A weekly newsletter delivers study tools and teaching tips for personal and family study.', 'Щотижневі відео
Курси й застосунок
Матеріали для друку
Розсилка', 'Weekly videos
Courses and app
Printables
Newsletter', 'Сім''ї та вчителі, які вивчають «Приходьте і слідуйте за Мною».', 'Families and teachers studying Come, Follow Me.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dontmissthisstudy.com' OR LOWER(`name`) = LOWER('Don''t Miss This')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'latter-day-saints' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Don''t Miss This offers videos, courses, an app and printables for weekly home-centered Come, Follow Me study.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A project for people looking for ideas for weekly home-centered Come, Follow Me study. It offers videos, courses, an app, printables and events, plus a shop. A weekly newsletter delivers study tools and teaching tips for personal and family study.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Weekly videos
Courses and app
Printables
Newsletter', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Families and teachers studying Come, Follow Me.', 'manual' FROM DUAL WHERE @new = 1;

-- FAIR — Церква святих останніх днів (мормони)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fairlatterdaysaints.org' OR LOWER(`name`) = LOWER('FAIR'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'FAIR', NULL, 'https://www.fairlatterdaysaints.org', NULL, NULL, 'FAIR — некомерційна організація, що відповідає на критику Церкви святих останніх днів: база відповідей, вивчення Писань, блог, конференції, медіа й застосунки.', 'FAIR is a nonprofit answering criticisms of the Latter-day Saint church: an answers database, scripture study, blog, conferences, media and apps.', 'Некомерційна організація, яка надає задокументовані відповіді на критичні запитання про Церкву Ісуса Христа святих останніх днів. Має велику базу відповідей, розділ вивчення Писань, блог, щорічну конференцію FAIR і віртуальні конференції, книги, відео й аудіо на різних пристроях.', 'A nonprofit providing documented answers to critical questions about The Church of Jesus Christ of Latter-day Saints. It has a large answers database, a scripture study section, a blog, the annual FAIR Conference and virtual conferences, books, and video and audio across devices.', 'База відповідей
Вивчення Писань
Конференції
Відео й аудіо', 'Answers database
Scripture study
Conferences
Video and audio', 'Ті, хто шукає відповіді на складні запитання про Церкву.', 'People seeking answers to hard questions about the Church.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fairlatterdaysaints.org' OR LOWER(`name`) = LOWER('FAIR')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'latter-day-saints' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'FAIR is a nonprofit answering criticisms of the Latter-day Saint church: an answers database, scripture study, blog, conferences, media and apps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A nonprofit providing documented answers to critical questions about The Church of Jesus Christ of Latter-day Saints. It has a large answers database, a scripture study section, a blog, the annual FAIR Conference and virtual conferences, books, and video and audio across devices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Answers database
Scripture study
Conferences
Video and audio', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People seeking answers to hard questions about the Church.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- FamilySearch — Церква святих останніх днів (мормони)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'familysearch.org' OR LOWER(`name`) = LOWER('FamilySearch'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'FamilySearch', NULL, 'https://www.familysearch.org', NULL, NULL, 'FamilySearch — безкоштовна генеалогічна платформа Церкви святих останніх днів: спільне родинне дерево, пошук записів, архів зображень, спогади й вікі для досліджень.', 'FamilySearch is the Latter-day Saint church''s free genealogy platform: a shared family tree, record search, image archive, memories and a research wiki.', 'Генеалогічний сервіс Церкви Ісуса Христа святих останніх днів. Дає змогу будувати спільне родинне дерево, шукати історичні записи (включно з повнотекстовим пошуком і зображеннями документів), генеалогії, каталог, книги, кладовища й газети, зберігати спогади (фото, історії, аудіо) і стежити за родичами. Є індексування записів волонтерами, вікі для досліджень, ігрові активності на кшталт «Звідки я?» та застосунки для телефона. Реєстрація й користування безкоштовні.', 'The genealogy service of The Church of Jesus Christ of Latter-day Saints. It lets you build a shared family tree, search historical records (including full-text search and document images), genealogies, the catalog, books, cemeteries and newspapers, save memories (photos, stories, audio) and follow relatives. There is volunteer record indexing, a research wiki, activities such as "Where Am I From?" and mobile apps. Registration and use are free.', 'Спільне родинне дерево
Пошук історичних записів
Спогади
Вікі для досліджень
Безкоштовно', 'Shared family tree
Historical record search
Memories
Research wiki
Free', 'Усі, хто досліджує родовід.', 'Anyone researching family history.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'familysearch.org' OR LOWER(`name`) = LOWER('FamilySearch')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'latter-day-saints' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'FamilySearch is the Latter-day Saint church''s free genealogy platform: a shared family tree, record search, image archive, memories and a research wiki.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The genealogy service of The Church of Jesus Christ of Latter-day Saints. It lets you build a shared family tree, search historical records (including full-text search and document images), genealogies, the catalog, books, cemeteries and newspapers, save memories (photos, stories, audio) and follow relatives. There is volunteer record indexing, a research wiki, activities such as "Where Am I From?" and mobile apps. Registration and use are free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Shared family tree
Historical record search
Memories
Research wiki
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone researching family history.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Обліковий запис безкоштовний', 'Free account' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free account', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- followHIM Podcast — Церква святих останніх днів (мормони)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'followhim.co' OR LOWER(`name`) = LOWER('followHIM Podcast'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'followHIM Podcast', NULL, 'https://followhim.co', NULL, NULL, 'followHIM — щотижневий подкаст Генка Сміта та Джона Байтвея до програми «Приходьте і слідуйте за Мною» англійською та іспанською, з PDF і цитатниками.', 'followHIM is Hank Smith and John Bytheway''s weekly podcast for Come, Follow Me in English and Spanish, with PDFs and quote books.', 'Подкаст доктора Генрі «Генка» Сміта та Джона Байтвея, що щотижня розбирає глави Писань за програмою «Приходьте і слідуйте за Мною». Нові випуски виходять у середу; є архів за роками (Старий Завіт, Учення і Завіти тощо), версії англійською та іспанською, улюблені фрагменти епізодів, безкоштовні PDF-цитатники й розсилка.', 'A podcast by Dr. Henry "Hank" Smith and John Bytheway covering scripture chapters each week following Come, Follow Me. New episodes come out on Wednesdays; there is an archive by year (Old Testament, Doctrine and Covenants and more), English and Spanish versions, episode favorites, free PDF quote books and a newsletter.', 'Щотижневі випуски
Архів за роками
Англійська та іспанська
PDF-цитатники', 'Weekly episodes
Archive by year
English and Spanish
PDF quote books', 'Ті, хто вивчає Писання щотижня.', 'People studying scripture weekly.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'followhim.co' OR LOWER(`name`) = LOWER('followHIM Podcast')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'latter-day-saints' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'followHIM is Hank Smith and John Bytheway''s weekly podcast for Come, Follow Me in English and Spanish, with PDFs and quote books.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A podcast by Dr. Henry "Hank" Smith and John Bytheway covering scripture chapters each week following Come, Follow Me. New episodes come out on Wednesdays; there is an archive by year (Old Testament, Doctrine and Covenants and more), English and Spanish versions, episode favorites, free PDF quote books and a newsletter.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Weekly episodes
Archive by year
English and Spanish
PDF quote books', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People studying scripture weekly.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Подкаст і PDF', 'Podcast and PDFs' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Podcast and PDFs', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Gospel Doctrine — Церква святих останніх днів (мормони)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gospeldoctrine.com' OR LOWER(`name`) = LOWER('Gospel Doctrine'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Gospel Doctrine', NULL, 'https://www.gospeldoctrine.com', NULL, NULL, 'GospelDoctrine.com — Писання святих останніх днів онлайн із коментарями: Старий і Новий Завіт, Книга Мормона, Учення і Завіти, Дорогоцінна Перлина; є мобільний застосунок.', 'GospelDoctrine.com presents Latter-day Saint scriptures online with commentary: Old and New Testament, Book of Mormon, Doctrine and Covenants, Pearl of Great Price; with a mobile app.', 'Сайт для вивчення Писань за книгами: Старий Завіт, Новий Завіт, Книга Мормона, Учення і Завіти та Дорогоцінна Перлина. Є пошук, ресурси, мобільний застосунок, довідка, новини й архів.', 'A site for studying scripture by book: the Old Testament, New Testament, Book of Mormon, Doctrine and Covenants and Pearl of Great Price. It includes search, resources, a mobile app, help, news and archives.', 'Писання за книгами
Пошук
Мобільний застосунок
Ресурси', 'Scripture by book
Search
Mobile app
Resources', 'Ті, хто вивчає Писання святих останніх днів.', 'People studying Latter-day Saint scripture.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gospeldoctrine.com' OR LOWER(`name`) = LOWER('Gospel Doctrine')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'latter-day-saints' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'GospelDoctrine.com presents Latter-day Saint scriptures online with commentary: Old and New Testament, Book of Mormon, Doctrine and Covenants, Pearl of Great Price; with a mobile app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A site for studying scripture by book: the Old Testament, New Testament, Book of Mormon, Doctrine and Covenants and Pearl of Great Price. It includes search, resources, a mobile app, help, news and archives.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Scripture by book
Search
Mobile app
Resources', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People studying Latter-day Saint scripture.', 'manual' FROM DUAL WHERE @new = 1;

-- Gospel Library — Церква святих останніх днів (мормони)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'churchofjesuschrist.org/learn/mobile-applications/gospel-library' OR LOWER(`name`) = LOWER('Gospel Library'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Gospel Library', NULL, 'https://www.churchofjesuschrist.org/learn/mobile-applications/gospel-library', NULL, NULL, 'Gospel Library — офіційний застосунок Церкви Ісуса Христа святих останніх днів: Писання, промови генеральної конференції, навчальні посібники й нотатки.', 'Gospel Library is the official app of The Church of Jesus Christ of Latter-day Saints: scriptures, general conference talks, study manuals and notes.', 'Застосунок Церкви для вивчення Слова Божого та запису особистих одкровень. Містить Писання (Біблію, Книгу Мормона, Учення і Завіти, Дорогоцінну Перлину), промови генеральної конференції, журнали Церкви, посібники «Приходьте і слідуйте за Мною», музику й відео. Можна виділяти текст, додавати нотатки, теги й посилання, вести навчальні щоденники та синхронізувати їх між пристроями через обліковий запис Церкви. Безкоштовний, доступний багатьма мовами.', 'The Church''s app for studying God''s word and recording personal revelation. It contains the scriptures (the Bible, Book of Mormon, Doctrine and Covenants, Pearl of Great Price), general conference talks, Church magazines, Come, Follow Me manuals, music and videos. You can highlight, add notes, tags and links, keep study notebooks and sync them across devices with a Church account. Free and available in many languages.', 'Писання й конференції
Посібники «Приходьте і слідуйте за Мною»
Нотатки й теги
Синхронізація
Безкоштовно', 'Scriptures and conference talks
Come, Follow Me manuals
Notes and tags
Sync across devices
Free', 'Члени Церкви та всі, хто вивчає її Писання.', 'Church members and anyone studying its scriptures.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'churchofjesuschrist.org/learn/mobile-applications/gospel-library' OR LOWER(`name`) = LOWER('Gospel Library')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'latter-day-saints' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Gospel Library is the official app of The Church of Jesus Christ of Latter-day Saints: scriptures, general conference talks, study manuals and notes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Church''s app for studying God''s word and recording personal revelation. It contains the scriptures (the Bible, Book of Mormon, Doctrine and Covenants, Pearl of Great Price), general conference talks, Church magazines, Come, Follow Me manuals, music and videos. You can highlight, add notes, tags and links, keep study notebooks and sync them across devices with a Church account. Free and available in many languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Scriptures and conference talks
Come, Follow Me manuals
Notes and tags
Sync across devices
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Church members and anyone studying its scriptures.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Повний функціонал', 'Full functionality' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Full functionality', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Relative Finder — Церква святих останніх днів (мормони)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'relativefinder.org' OR LOWER(`name`) = LOWER('Relative Finder'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Relative Finder', NULL, 'https://www.relativefinder.org', NULL, NULL, 'Relative Finder — сервіс Family History Technology Lab, що через FamilySearch показує спорідненість із друзями, колегами й відомими людьми.', 'Relative Finder from the Family History Technology Lab uses FamilySearch to show how you are related to friends, co-workers and famous people.', 'Інструмент лабораторії Family History Technology Lab (BYU). Після входу через FamilySearch.org знаходить родичів у вбудованих групах і дає змогу створювати власні групи, щоб побачити спорідненість із друзями, колегами чи відомими людьми. Лабораторія також пропонує Virtual Pedigree, Descendancy Explorer, Tree Sweeper, Pedigree Pie, One Page Genealogy, Family Calendar і генеалогічні ігри.', 'A tool from the Family History Technology Lab (BYU). After signing in with FamilySearch.org it finds relatives in built-in groups and lets you create your own groups to see how you are related to friends, co-workers or famous people. The lab also offers Virtual Pedigree, Descendancy Explorer, Tree Sweeper, Pedigree Pie, One Page Genealogy, Family Calendar and genealogy games.', 'Вхід через FamilySearch
Групи родичів
Власні групи
Генеалогічні ігри', 'FamilySearch sign-in
Relative groups
Custom groups
Genealogy games', 'Користувачі FamilySearch.', 'FamilySearch users.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'relativefinder.org' OR LOWER(`name`) = LOWER('Relative Finder')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'latter-day-saints' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Relative Finder from the Family History Technology Lab uses FamilySearch to show how you are related to friends, co-workers and famous people.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A tool from the Family History Technology Lab (BYU). After signing in with FamilySearch.org it finds relatives in built-in groups and lets you create your own groups to see how you are related to friends, co-workers or famous people. The lab also offers Virtual Pedigree, Descendancy Explorer, Tree Sweeper, Pedigree Pie, One Page Genealogy, Family Calendar and genealogy games.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'FamilySearch sign-in
Relative groups
Custom groups
Genealogy games', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'FamilySearch users.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Потрібен акаунт FamilySearch', 'Requires a FamilySearch account' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Requires a FamilySearch account', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Saints Unscripted — Церква святих останніх днів (мормони)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'saintsunscripted.com' OR LOWER(`name`) = LOWER('Saints Unscripted'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Saints Unscripted', NULL, 'https://saintsunscripted.com', NULL, NULL, 'Saints Unscripted — відеопроєкт святих останніх днів про віру, вірування й особисті історії, з обговоренням актуальних питань.', 'Saints Unscripted is a Latter-day Saint video project on faith, beliefs and personal stories, discussing current questions.', 'Проєкт короткої відеоформи, у якому молоді святі останніх днів обговорюють питання віри, вірувань і актуальні теми, діляться особистими історіями та запрошують глядачів до обговорення в коментарях. На сайті — відео, розділ «Віра й вірування», історії глядачів і квест-активність.', 'A short-form video project in which young Latter-day Saints discuss questions of faith, beliefs and current topics, share personal stories and invite viewers to discuss in the comments. The site has videos, a Faith and Beliefs section, viewer stories and a scavenger hunt activity.', 'Короткі відео
Віра й вірування
Історії глядачів', 'Short videos
Faith and beliefs
Viewer stories', 'Молодь і ті, хто цікавиться вірою святих останніх днів.', 'Young people and those curious about Latter-day Saint faith.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'saintsunscripted.com' OR LOWER(`name`) = LOWER('Saints Unscripted')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'latter-day-saints' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Saints Unscripted is a Latter-day Saint video project on faith, beliefs and personal stories, discussing current questions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A short-form video project in which young Latter-day Saints discuss questions of faith, beliefs and current topics, share personal stories and invite viewers to discuss in the comments. The site has videos, a Faith and Beliefs section, viewer stories and a scavenger hunt activity.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Short videos
Faith and beliefs
Viewer stories', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Young people and those curious about Latter-day Saint faith.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Scripture Central — Церква святих останніх днів (мормони)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'scripturecentral.org' OR LOWER(`name`) = LOWER('Scripture Central'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Scripture Central', NULL, 'https://scripturecentral.org', NULL, NULL, 'Scripture Central — некомерційний ресурс про Книгу Мормона й інші Писання Відновлення: відео, подкасти, статті KnoWhy, матеріали до недільної школи й бібліотека.', 'Scripture Central is a nonprofit resource on the Book of Mormon and other Restoration scripture: videos, podcasts, KnoWhy articles, Sunday School material and a library.', 'Організація, що прагне зробити Книгу Мормона та інші Писання Відновлення доступнішими й зрозумілішими. Пропонує відео й подкасти, навчальні ресурси за програмою недільної школи, статті-пояснення KnoWhy, Evidence Central, архів і бібліотеку. Сюди переїжджає й контент Book of Mormon Central.', 'An organization aiming to make the Book of Mormon and other Restoration scripture more accessible and comprehensible. It offers videos and podcasts, study resources following the Sunday School curriculum, KnoWhy explainer articles, Evidence Central, an archive and a library. Book of Mormon Central content is moving here too.', 'Відео й подкасти
Статті KnoWhy
Матеріали до недільної школи
Бібліотека', 'Videos and podcasts
KnoWhy articles
Sunday School resources
Library', 'Ті, хто поглиблено вивчає Книгу Мормона.', 'People studying the Book of Mormon in depth.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'scripturecentral.org' OR LOWER(`name`) = LOWER('Scripture Central')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'latter-day-saints' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Scripture Central is a nonprofit resource on the Book of Mormon and other Restoration scripture: videos, podcasts, KnoWhy articles, Sunday School material and a library.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An organization aiming to make the Book of Mormon and other Restoration scripture more accessible and comprehensible. It offers videos and podcasts, study resources following the Sunday School curriculum, KnoWhy explainer articles, Evidence Central, an archive and a library. Book of Mormon Central content is moving here too.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Videos and podcasts
KnoWhy articles
Sunday School resources
Library', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People studying the Book of Mormon in depth.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Scripture Citation Index — Церква святих останніх днів (мормони)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'scriptures.byu.edu' OR LOWER(`name`) = LOWER('Scripture Citation Index'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Scripture Citation Index', NULL, 'https://scriptures.byu.edu', NULL, NULL, 'Scripture Citation Index (BYU) — покажчик, що для кожного вірша Писань показує, де його цитували провідники Церкви на конференціях та в інших промовах.', 'The Scripture Citation Index (BYU) shows, for every scripture verse, where Church leaders have cited it in general conference and other talks.', 'Покажчик від Університету Бригама Янга, який пов''язує вірші Старого й Нового Завіту, Книги Мормона, Учення і Завітів та Дорогоцінної Перлини з промовами генеральної конференції та іншими виступами провідників Церкви, де їх цитовано. Можна переглядати за книгами й главами та переходити до тексту промов.', 'An index from Brigham Young University linking verses of the Old and New Testament, Book of Mormon, Doctrine and Covenants and Pearl of Great Price to general conference talks and other leader addresses that cite them. You can browse by book and chapter and jump to the talk text.', 'Цитування за віршами
Промови конференцій
Перегляд за книгами
Від BYU', 'Citations by verse
Conference talks
Browse by book
By BYU', 'Вчителі й студенти Писань.', 'Scripture teachers and students.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'scriptures.byu.edu' OR LOWER(`name`) = LOWER('Scripture Citation Index')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'latter-day-saints' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Scripture Citation Index (BYU) shows, for every scripture verse, where Church leaders have cited it in general conference and other talks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An index from Brigham Young University linking verses of the Old and New Testament, Book of Mormon, Doctrine and Covenants and Pearl of Great Price to general conference talks and other leader addresses that cite them. You can browse by book and chapter and jump to the talk text.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Citations by verse
Conference talks
Browse by book
By BYU', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Scripture teachers and students.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- The Church of Jesus Christ of Latter-day Saints — Церква святих останніх днів (мормони)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'churchofjesuschrist.org' OR LOWER(`name`) = LOWER('The Church of Jesus Christ of Latter-day Saints'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'The Church of Jesus Christ of Latter-day Saints', NULL, 'https://www.churchofjesuschrist.org', NULL, NULL, 'Офіційний сайт Церкви Ісуса Христа святих останніх днів: вірування, генеральна конференція, храми, пошук найближчої громади й навчальні матеріали.', 'The official site of The Church of Jesus Christ of Latter-day Saints: beliefs, general conference, temples, finding a congregation and study resources.', 'Головний сайт Церкви, яка описує себе як християнську церкву, очолювану пророком. Тут — промови генеральної конференції в тексті, аудіо й відео, відео про храми й центри для відвідувачів, пошук найближчої громади, розділи «У що ми віримо», «Про Ісуса Христа» та допомога в життєвих труднощах. Звідси ведуть посилання на Gospel Library, медіабібліотеку, музику й ресурси для членів Церкви.', 'The main site of the Church, which describes itself as a Christian church led by a prophet. It has general conference talks in text, audio and video, videos about temples and visitors'' centers, a congregation finder, sections on what members believe and on Jesus Christ, and help with life''s challenges. It links to Gospel Library, the media library, music and member resources.', 'Генеральна конференція
Про храми
Пошук громади
Вірування Церкви', 'General conference
About temples
Congregation finder
Church beliefs', 'Члени Церкви та ті, хто хоче про неї дізнатися.', 'Church members and those wanting to learn about it.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'churchofjesuschrist.org' OR LOWER(`name`) = LOWER('The Church of Jesus Christ of Latter-day Saints')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'latter-day-saints' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The official site of The Church of Jesus Christ of Latter-day Saints: beliefs, general conference, temples, finding a congregation and study resources.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The main site of the Church, which describes itself as a Christian church led by a prophet. It has general conference talks in text, audio and video, videos about temples and visitors'' centers, a congregation finder, sections on what members believe and on Jesus Christ, and help with life''s challenges. It links to Gospel Library, the media library, music and member resources.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'General conference
About temples
Congregation finder
Church beliefs', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Church members and those wanting to learn about it.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- The Tabernacle Choir — Церква святих останніх днів (мормони)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thetabernaclechoir.org' OR LOWER(`name`) = LOWER('The Tabernacle Choir'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'The Tabernacle Choir', NULL, 'https://www.thetabernaclechoir.org', NULL, NULL, 'Хор Табернаклю на Храмовій площі: концерти й події, щотижнева програма «Music & the Spoken Word», репетиції, органні концерти, архів випусків і квитки.', 'The Tabernacle Choir at Temple Square: concerts and events, the weekly Music & the Spoken Word program, rehearsals, organ recitals, an episode archive and tickets.', 'Офіційний сайт хору Церкви Ісуса Христа святих останніх днів. Розповідає про концерти й глобальні події, щотижневі відкриті репетиції, щоденні органні концерти й осінній концерт оркестру. Тут транслюється й архівується програма «Music & the Spoken Word» (зокрема з текстом), продаються квитки, є статті, розділ про місію, хор, оркестр і дзвони та про глобальних учасників.', 'The official site of the choir of The Church of Jesus Christ of Latter-day Saints. It covers concerts and global events, weekly open rehearsals, daily organ recitals and the orchestra fall concert. It streams and archives Music & the Spoken Word (including text versions), sells tickets and has articles plus sections on the mission, choir, orchestra, bells and global members.', '«Music & the Spoken Word»
Архів випусків
Концерти й квитки
Органні концерти', 'Music & the Spoken Word
Episode archive
Concerts and tickets
Organ recitals', 'Шанувальники хорової й духовної музики.', 'Fans of choral and sacred music.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thetabernaclechoir.org' OR LOWER(`name`) = LOWER('The Tabernacle Choir')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'latter-day-saints' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Tabernacle Choir at Temple Square: concerts and events, the weekly Music & the Spoken Word program, rehearsals, organ recitals, an episode archive and tickets.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The official site of the choir of The Church of Jesus Christ of Latter-day Saints. It covers concerts and global events, weekly open rehearsals, daily organ recitals and the orchestra fall concert. It streams and archives Music & the Spoken Word (including text versions), sells tickets and has articles plus sections on the mission, choir, orchestra, bells and global members.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Music & the Spoken Word
Episode archive
Concerts and tickets
Organ recitals', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Fans of choral and sacred music.', 'manual' FROM DUAL WHERE @new = 1;

-- 3ABN — Адвентисти сьомого дня
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = '3abn.org' OR LOWER(`name`) = LOWER('3ABN'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT '3ABN', NULL, 'https://3abn.org', NULL, NULL, '3ABN (Three Angels Broadcasting Network) — адвентистська теле- й радіомережа: прямий ефір і відео на запит, радіо, подкасти, молитовні запити, рецепти й журнал.', '3ABN (Three Angels Broadcasting Network) is an Adventist TV and radio network: live and on-demand video, radio, podcasts, prayer requests, recipes and a magazine.', 'Медійна мережа з кількома телеканалами в прямому ефірі й на запит, розкладом, кабельними партнерами, радіо 3ABN і подкастами. Можна надіслати молитовний запит, отримати біблійні відповіді, рецепти, блог, журнал 3ABN World і ресурси FaithLight, дізнатися про табірні зібрання та події. Є застосунки для різних пристроїв.', 'A media network with several TV channels live and on demand, schedules, cable affiliates, 3ABN Radio and podcasts. You can submit prayer requests and find Bible answers, recipes, a blog, 3ABN World magazine and FaithLight resources, plus camp meetings and events. Apps are available for various devices.', 'Телеканали наживо
Радіо й подкасти
Молитовні запити
Застосунки', 'Live TV channels
Radio and podcasts
Prayer requests
Apps', 'Глядачі й слухачі адвентистських медіа.', 'Viewers and listeners of Adventist media.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = '3abn.org' OR LOWER(`name`) = LOWER('3ABN')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'seventh-day-adventists' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', '3ABN (Three Angels Broadcasting Network) is an Adventist TV and radio network: live and on-demand video, radio, podcasts, prayer requests, recipes and a magazine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A media network with several TV channels live and on demand, schedules, cable affiliates, 3ABN Radio and podcasts. You can submit prayer requests and find Bible answers, recipes, a blog, 3ABN World magazine and FaithLight resources, plus camp meetings and events. Apps are available for various devices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Live TV channels
Radio and podcasts
Prayer requests
Apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Viewers and listeners of Adventist media.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Перегляд і прослуховування', 'Watch and listen' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Watch and listen', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Adventist Archives — Адвентисти сьомого дня
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'adventistarchives.org' OR LOWER(`name`) = LOWER('Adventist Archives'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Adventist Archives', NULL, 'https://www.adventistarchives.org', NULL, NULL, 'Adventist Archives — архіви, статистика й дослідження Генеральної конференції адвентистів (ASTR): онлайн-архіви, щорічник, довідник і ресурси для істориків.', 'Adventist Archives is the General Conference Office of Archives, Statistics and Research (ASTR): online archives, the Yearbook, a directory and resources for historians.', 'Сайт Офісу архівів, статистики й досліджень Генеральної конференції. Пропонує онлайн-архіви, статистику Церкви, щорічник, довідник організацій, енциклопедію, розділи з керування документами та ресурси для наукових досліджень (історичних, історико-богословських і з участю людей).', 'The site of the General Conference Office of Archives, Statistics and Research. It offers online archives, Church statistics, the Yearbook, an organizations directory, the encyclopedia, records management guidance and resources for scholarship (historical, historical-theological and human-subject research).', 'Онлайн-архіви
Статистика Церкви
Щорічник і довідник
Ресурси для досліджень', 'Online archives
Church statistics
Yearbook and directory
Research resources', 'Історики, дослідники й церковні адміністратори.', 'Historians, researchers and church administrators.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'adventistarchives.org' OR LOWER(`name`) = LOWER('Adventist Archives')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'seventh-day-adventists' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Adventist Archives is the General Conference Office of Archives, Statistics and Research (ASTR): online archives, the Yearbook, a directory and resources for historians.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of the General Conference Office of Archives, Statistics and Research. It offers online archives, Church statistics, the Yearbook, an organizations directory, the encyclopedia, records management guidance and resources for scholarship (historical, historical-theological and human-subject research).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Online archives
Church statistics
Yearbook and directory
Research resources', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Historians, researchers and church administrators.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Adventist Book Center — Адвентисти сьомого дня
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'adventistbookcenter.com' OR LOWER(`name`) = LOWER('Adventist Book Center'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Adventist Book Center', NULL, 'https://adventistbookcenter.com', NULL, NULL, 'Adventist Book Center Online — магазин адвентистських книг, музики й медіа: посібники суботньої школи, книги Еллен Вайт, аудіокниги; безкоштовна доставка від 50 $.', 'Adventist Book Center Online sells Adventist books, music and media: Sabbath School guides, Ellen White books, audiobooks; free shipping over $50.', 'Інтернет-магазин адвентистської літератури англійською та іспанською з цінами в доларах США чи Канади. Асортимент: квартальні посібники суботньої школи (зокрема французькою), книги Еллен Г. Вайт і про неї, книги для поширення («Велика боротьба» коробками), аудіокниги, книги для суботнього читання, музика й медіа. Безкоштовна доставка відповідних товарів від 50 $.', 'An online store of Adventist literature in English and Spanish with prices in US or Canadian dollars. It stocks quarterly Sabbath School guides (including French), books by and about Ellen G. White, sharing books (The Great Controversy by the case), audiobooks, Sabbath reading, music and media. Free shipping over $50 on qualifying products.', 'Посібники суботньої школи
Книги Еллен Вайт
Аудіокниги
Доставка від 50 $ безкоштовна', 'Sabbath School guides
Ellen White books
Audiobooks
Free shipping over $50', 'Адвентисти й церкви в США та Канаді.', 'Adventists and churches in the US and Canada.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'adventistbookcenter.com' OR LOWER(`name`) = LOWER('Adventist Book Center')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'seventh-day-adventists' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Adventist Book Center Online sells Adventist books, music and media: Sabbath School guides, Ellen White books, audiobooks; free shipping over $50.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An online store of Adventist literature in English and Spanish with prices in US or Canadian dollars. It stocks quarterly Sabbath School guides (including French), books by and about Ellen G. White, sharing books (The Great Controversy by the case), audiobooks, Sabbath reading, music and media. Free shipping over $50 on qualifying products.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Sabbath School guides
Ellen White books
Audiobooks
Free shipping over $50', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Adventists and churches in the US and Canada.', 'manual' FROM DUAL WHERE @new = 1;

-- Adventist Learning Community — Адвентисти сьомого дня
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'adventistlearningcommunity.com' OR LOWER(`name`) = LOWER('Adventist Learning Community'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Adventist Learning Community', NULL, 'https://www.adventistlearningcommunity.com', NULL, NULL, 'Adventist Learning Community — освітня платформа Церкви адвентистів: онлайн-курси, ресурси й події для вчителів, пасторів і членів Церкви.', 'Adventist Learning Community is the Adventist Church''s learning platform: online courses, resources and events for teachers, pastors and church members.', 'Платформа онлайн-навчання з курсами, ресурсами, подіями та інструкціями. Пов''язана з мережами Adventist Teacher Connect для вчителів дошкільної та шкільної освіти, Higher Ed Adventist Society для викладачів вишів, дошкою вакансій, CIRCLE і програмами розвитку персоналу. Є вибір мови інтерфейсу.', 'An online learning platform with courses, resources, events and how-to guides. It connects to Adventist Teacher Connect for Pre-K–12 educators, the Higher Ed Adventist Society, a careers board, CIRCLE and workforce development programs. The interface language can be selected.', 'Онлайн-курси
Мережа вчителів
Ресурси й події
Вибір мови', 'Online courses
Teacher network
Resources and events
Language selection', 'Вчителі, пастори й служителі адвентистських установ.', 'Teachers, pastors and Adventist institution staff.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'adventistlearningcommunity.com' OR LOWER(`name`) = LOWER('Adventist Learning Community')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'seventh-day-adventists' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Adventist Learning Community is the Adventist Church''s learning platform: online courses, resources and events for teachers, pastors and church members.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An online learning platform with courses, resources, events and how-to guides. It connects to Adventist Teacher Connect for Pre-K–12 educators, the Higher Ed Adventist Society, a careers board, CIRCLE and workforce development programs. The interface language can be selected.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Online courses
Teacher network
Resources and events
Language selection', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Teachers, pastors and Adventist institution staff.', 'manual' FROM DUAL WHERE @new = 1;

-- Adventist Mission — Адвентисти сьомого дня
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'am.adventistmission.org' OR LOWER(`name`) = LOWER('Adventist Mission'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Adventist Mission', NULL, 'https://am.adventistmission.org', NULL, NULL, 'Adventist Mission — місіонерський відділ Церкви адвентистів: Global Mission, місіонерські історії, щоквартальник Mission для дорослих і молоді, відео Mission Spotlight.', 'Adventist Mission is the Adventist Church''s mission department: Global Mission, mission stories, the Mission quarterly for youth and adults and Mission Spotlight videos.', 'Сайт місіонерського служіння Церкви адвентистів. Розділ Global Mission описує заснування церков серед недосягнутих народів, Mission Awareness — місіонерські історії й медіа з журналів Mission, Mission Spotlight та Mission 360°. Є щоквартальник Mission для молоді й дорослих, ресурси «Молися, давай, іди», промоматеріали й навчання; сайт доступний англійською, французькою, португальською та іспанською.', 'The site of the Adventist Church''s mission ministry. Global Mission covers church planting among unreached people groups; Mission Awareness offers mission stories and media from Mission magazines, Mission Spotlight and Mission 360°. There is the Mission quarterly for youth and adults, Pray-Give-Go resources, promotion materials and training; the site is in English, French, Portuguese and Spanish.', 'Global Mission
Місіонерські історії
Щоквартальник Mission
Чотири мови', 'Global Mission
Mission stories
Mission quarterly
Four languages', 'Церкви, вчителі суботньої школи й волонтери місій.', 'Churches, Sabbath School teachers and mission volunteers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'am.adventistmission.org' OR LOWER(`name`) = LOWER('Adventist Mission')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'seventh-day-adventists' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Adventist Mission is the Adventist Church''s mission department: Global Mission, mission stories, the Mission quarterly for youth and adults and Mission Spotlight videos.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of the Adventist Church''s mission ministry. Global Mission covers church planting among unreached people groups; Mission Awareness offers mission stories and media from Mission magazines, Mission Spotlight and Mission 360°. There is the Mission quarterly for youth and adults, Pray-Give-Go resources, promotion materials and training; the site is in English, French, Portuguese and Spanish.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Global Mission
Mission stories
Mission quarterly
Four languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Churches, Sabbath School teachers and mission volunteers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Adventist World Radio — Адвентисти сьомого дня
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'awr.org' OR LOWER(`name`) = LOWER('Adventist World Radio'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Adventist World Radio', NULL, 'https://awr.org', NULL, NULL, 'Adventist World Radio — міжнародне радіо адвентистів: прямий ефір, застосунок, програми за мовами й країнами, розклади на короткій хвилі й FM, відео AWR360°.', 'Adventist World Radio is the Adventist international radio: live streams, an app, programs by language and location, shortwave and FM schedules and AWR360° videos.', 'Глобальне радіослужіння Церкви адвентистів. Можна слухати наживо онлайн або в застосунку, обирати програми за мовою чи країною, дивитися розклади короткохвильового й FM-мовлення. Є відео AWR360°, програми про здоров''я, навчання євангелізації через мобільний телефон, проєкти підтримки й завантаження.', 'The Adventist Church''s global radio ministry. You can listen live online or in the app, choose programs by language or location, and see shortwave and FM schedules. There are AWR360° videos, health programs, cell phone evangelism training, support projects and downloads.', 'Прямий ефір
Застосунок
Програми за мовами
Розклади КХ і FM', 'Live radio
App
Programs by language
Shortwave and FM schedules', 'Слухачі християнського радіо в різних країнах.', 'Christian radio listeners in many countries.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'awr.org' OR LOWER(`name`) = LOWER('Adventist World Radio')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'seventh-day-adventists' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Adventist World Radio is the Adventist international radio: live streams, an app, programs by language and location, shortwave and FM schedules and AWR360° videos.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Adventist Church''s global radio ministry. You can listen live online or in the app, choose programs by language or location, and see shortwave and FM schedules. There are AWR360° videos, health programs, cell phone evangelism training, support projects and downloads.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Live radio
App
Programs by language
Shortwave and FM schedules', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Christian radio listeners in many countries.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Прослуховування', 'Listening' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Listening', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Adventist Youth Ministries — Адвентисти сьомого дня
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'youth.adventist.org' OR LOWER(`name`) = LOWER('Adventist Youth Ministries'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Adventist Youth Ministries', NULL, 'https://youth.adventist.org', NULL, NULL, 'Адвентистське молодіжне служіння Генеральної конференції: клуби Adventurer і Pathfinder, посібники, нагороди, прогресивні класи й ресурси для лідерів.', 'The General Conference Adventist Youth Ministries: Adventurer and Pathfinder clubs, manuals, awards, progressive classes and resources for leaders.', 'Сайт молодіжного відділу Церкви адвентистів. Містить ресурси для клубу Adventurer (посібники для завантаження, нагороди, прогресивні класи Little Lamb, Early Bird, Busy Bee, Sunbeam, Builder, Helping Hand, обітниця, гімн, форма, логотипи) і клубу Pathfinder (як організувати клуб, вимоги до членства, мета й девіз), команду служіння й контакти регіональних керівників.', 'The site of the Adventist Church''s youth department. It has resources for the Adventurer Club (downloadable manuals, awards, progressive classes Little Lamb, Early Bird, Busy Bee, Sunbeam, Builder, Helping Hand, pledge, song, uniform, logos) and the Pathfinder Club (how to organize a club, membership requirements, aim and motto), the ministry team and division youth directors.', 'Клуб Adventurer
Клуб Pathfinder
Посібники для завантаження
Нагороди й класи', 'Adventurer Club
Pathfinder Club
Downloadable manuals
Awards and classes', 'Лідери дитячих і молодіжних клубів.', 'Leaders of children''s and youth clubs.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'youth.adventist.org' OR LOWER(`name`) = LOWER('Adventist Youth Ministries')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'seventh-day-adventists' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The General Conference Adventist Youth Ministries: Adventurer and Pathfinder clubs, manuals, awards, progressive classes and resources for leaders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of the Adventist Church''s youth department. It has resources for the Adventurer Club (downloadable manuals, awards, progressive classes Little Lamb, Early Bird, Busy Bee, Sunbeam, Builder, Helping Hand, pledge, song, uniform, logos) and the Pathfinder Club (how to organize a club, membership requirements, aim and motto), the ministry team and division youth directors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Adventurer Club
Pathfinder Club
Downloadable manuals
Awards and classes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Leaders of children''s and youth clubs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- AdventistGiving — Адвентисти сьомого дня
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'adventistgiving.org' OR LOWER(`name`) = LOWER('AdventistGiving'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'AdventistGiving', NULL, 'https://www.adventistgiving.org', NULL, NULL, 'AdventistGiving — сервіс для повернення десятини й пожертв у свою адвентистську церкву з комп''ютера чи телефона, з обліковим записом або як гість.', 'AdventistGiving lets you return tithe and give offerings to your local Adventist church from a computer or phone, with an account or as a guest.', 'Офіційний сервіс пожертв Церкви адвентистів. Дає змогу повертати десятину й робити пожертви на місцеву церкву з будь-якого комп''ютера чи мобільного пристрою: увійти в обліковий запис або пожертвувати як гість. На сайті показано пожертву тижня з описом проєкту, на який вона спрямована.', 'The Adventist Church''s official giving service. It lets you return tithe and give offerings to your local church from any computer or mobile device: sign in to an account or donate as a guest. The site shows the offering of the week with a description of the project it supports.', 'Десятина й пожертви
Вхід або гостьовий режим
Пожертва тижня
З телефона', 'Tithe and offerings
Account or guest giving
Offering of the week
From your phone', 'Члени адвентистських громад.', 'Members of Adventist congregations.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'adventistgiving.org' OR LOWER(`name`) = LOWER('AdventistGiving')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'seventh-day-adventists' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AdventistGiving lets you return tithe and give offerings to your local Adventist church from a computer or phone, with an account or as a guest.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Adventist Church''s official giving service. It lets you return tithe and give offerings to your local church from any computer or mobile device: sign in to an account or donate as a guest. The site shows the offering of the week with a description of the project it supports.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Tithe and offerings
Account or guest giving
Offering of the week
From your phone', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Members of Adventist congregations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сервіс без плати', 'No service fee' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'No service fee', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Amazing Facts — Адвентисти сьомого дня
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'amazingfacts.org' OR LOWER(`name`) = LOWER('Amazing Facts'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Amazing Facts', NULL, 'https://www.amazingfacts.org', NULL, NULL, 'Amazing Facts — адвентистське служіння: безкоштовні вивчення Біблії, проповіді, телепрограми, радіо, подкасти, щоденний девоціонал і онлайн-біблійна школа.', 'Amazing Facts is an Adventist ministry offering free Bible studies, sermons, TV, radio, podcasts, a daily devotional and an online Bible school.', 'Міжнародне медійне служіння, яке пропонує безкоштовні вивчення Біблії, проповіді й матеріали про пророцтва. Розділи: телепередачі, серії й документальні фільми, застосунки, радіо з відповідями на біблійні запитання, аудіокниги, подкасти, щоденний девоціонал, вірш дня, план читання Біблії, посібники для вивчення, безкоштовна онлайн-біблійна школа, навчання євангелізації й безкоштовна бібліотека книг.', 'An international media ministry offering free Bible studies, sermons and prophecy material. Sections include TV broadcasts, series and documentaries, apps, radio with Bible questions answered, audiobooks, podcasts, a daily devotional, verse of the day, a Bible reading plan, study guides, a free online Bible school, evangelism training and a free book library.', 'Безкоштовна біблійна школа
ТБ і радіо
Щоденний девоціонал
Застосунки
Бібліотека книг', 'Free Bible school
TV and radio
Daily devotional
Apps
Book library', 'Ті, хто вивчає Біблію з адвентистської перспективи.', 'People studying the Bible from an Adventist perspective.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'amazingfacts.org' OR LOWER(`name`) = LOWER('Amazing Facts')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'seventh-day-adventists' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Amazing Facts is an Adventist ministry offering free Bible studies, sermons, TV, radio, podcasts, a daily devotional and an online Bible school.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An international media ministry offering free Bible studies, sermons and prophecy material. Sections include TV broadcasts, series and documentaries, apps, radio with Bible questions answered, audiobooks, podcasts, a daily devotional, verse of the day, a Bible reading plan, study guides, a free online Bible school, evangelism training and a free book library.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free Bible school
TV and radio
Daily devotional
Apps
Book library', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People studying the Bible from an Adventist perspective.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Вивчення й медіа', 'Studies and media' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Studies and media', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Club Ministries (NAD) — Адвентисти сьомого дня
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'clubministries.org' OR LOWER(`name`) = LOWER('Club Ministries (NAD)'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Club Ministries (NAD)', NULL, 'https://www.clubministries.org', NULL, NULL, 'Club Ministries Північноамериканського відділення адвентистів: Adventurers, Pathfinders і Master Guides — стартові набори, навчальні програми, нагороди, форма й сертифікація.', 'Club Ministries of the North American Division of Adventists: Adventurers, Pathfinders and Master Guides — starter kits, curriculum, awards, uniforms and certification.', 'Ресурсний центр клубного служіння Північноамериканського відділення Церкви адвентистів. Для клубу Adventurer — стартовий набір, навчальна програма, зірки й нагороди, подання ідей нагород, обітниця й гімн, форма, логотипи, біблійна гра й навчання; також матеріали для Pathfinders і Master Guides, базова сертифікація персоналу й інструкторів.', 'The club ministry resource center of the North American Division of the Adventist Church. For the Adventurer Club there is a starter kit, curriculum, stars and awards, award idea submission, pledge and song, uniform, logos, a Bible game and training; plus materials for Pathfinders and Master Guides and basic staff and instructor certification.', 'Стартовий набір клубу
Навчальна програма
Нагороди
Сертифікація лідерів', 'Club starter kit
Curriculum
Awards
Leader certification', 'Керівники клубів Adventurer і Pathfinder.', 'Adventurer and Pathfinder club leaders.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'clubministries.org' OR LOWER(`name`) = LOWER('Club Ministries (NAD)')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'seventh-day-adventists' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Club Ministries of the North American Division of Adventists: Adventurers, Pathfinders and Master Guides — starter kits, curriculum, awards, uniforms and certification.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The club ministry resource center of the North American Division of the Adventist Church. For the Adventurer Club there is a starter kit, curriculum, stars and awards, award idea submission, pledge and song, uniform, logos, a Bible game and training; plus materials for Pathfinders and Master Guides and basic staff and instructor certification.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Club starter kit
Curriculum
Awards
Leader certification', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Adventurer and Pathfinder club leaders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Discover Bible Guides — Адвентисти сьомого дня
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bibleschools.com' OR LOWER(`name`) = LOWER('Discover Bible Guides'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Discover Bible Guides', NULL, 'https://www.bibleschools.com', NULL, NULL, 'Bibleschools.com — безкоштовні уроки Discover Bible Guides і Focus on Daniel для вивчення Біблії онлайн або в друкованому вигляді, кількома мовами.', 'Bibleschools.com offers free Discover Bible Guides and Focus on Daniel lessons to study the Bible online or in print, in several languages.', 'Сайт безкоштовних посібників для вивчення Біблії від адвентистської біблійної школи. Discover Bible Guides відповідають на життєві запитання (чому Бог допускає страждання, у чому секрет щасливого життя, чи є надія для світу); є також серія про пророцтва Даниїла. Уроки можна проходити онлайн після входу або замовити друковані. Сайт багатомовний.', 'A site of free Bible study guides from an Adventist Bible school. Discover Bible Guides answer life questions (why God permits suffering, the secret of a happy life, whether there is hope for the world); there is also a series on Daniel''s prophecies. Lessons can be taken online after signing in or ordered in print. The site is multilingual.', 'Безкоштовні уроки
Онлайн або друк
Серія про Даниїла
Кілька мов', 'Free lessons
Online or print
Daniel series
Several languages', 'Ті, хто вперше вивчає Біблію.', 'First-time Bible students.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bibleschools.com' OR LOWER(`name`) = LOWER('Discover Bible Guides')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'seventh-day-adventists' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Bibleschools.com offers free Discover Bible Guides and Focus on Daniel lessons to study the Bible online or in print, in several languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A site of free Bible study guides from an Adventist Bible school. Discover Bible Guides answer life questions (why God permits suffering, the secret of a happy life, whether there is hope for the world); there is also a series on Daniel''s prophecies. Lessons can be taken online after signing in or ordered in print. The site is multilingual.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free lessons
Online or print
Daniel series
Several languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'First-time Bible students.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Онлайн і друковані уроки', 'Online and printed lessons' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Online and printed lessons', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- eAdventist — Адвентисти сьомого дня
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eadventist.net' OR LOWER(`name`) = LOWER('eAdventist'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'eAdventist', NULL, 'https://www.eadventist.net', NULL, NULL, 'eAdventist — система обліку членства й керування церквою Північноамериканського відділення адвентистів: членство, розсилки email і SMS, застосунок myEADVENTIST.', 'eAdventist is the North American Division''s church membership and management system: membership records, email and SMS messaging and the myEADVENTIST app.', 'Платформа Північноамериканського відділення Церкви адвентистів для служіння з членства. Включає облік членства й керування церквою, розсилки електронною поштою та SMS, мобільний застосунок myEADVENTIST для членів, пошук організацій (за відстанню й розширений) і окремий вхід для пенсійних даних персоналу.', 'The North American Division platform for membership ministry. It includes church membership records and church management, email and SMS messaging, the mobile-friendly myEADVENTIST app for members, organization search (by distance and advanced) and a separate login for personnel retirement records.', 'Облік членства
Email і SMS-розсилки
Застосунок myEADVENTIST
Пошук організацій', 'Membership records
Email and SMS messaging
myEADVENTIST app
Organization search', 'Церковні секретарі та члени громад у Північній Америці.', 'Church clerks and members in North America.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eadventist.net' OR LOWER(`name`) = LOWER('eAdventist')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'seventh-day-adventists' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'eAdventist is the North American Division''s church membership and management system: membership records, email and SMS messaging and the myEADVENTIST app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The North American Division platform for membership ministry. It includes church membership records and church management, email and SMS messaging, the mobile-friendly myEADVENTIST app for members, organization search (by distance and advanced) and a separate login for personnel retirement records.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Membership records
Email and SMS messaging
myEADVENTIST app
Organization search', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Church clerks and members in North America.', 'manual' FROM DUAL WHERE @new = 1;

-- EGW Writings — Адвентисти сьомого дня
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'egwwritings.org' OR LOWER(`name`) = LOWER('EGW Writings'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'EGW Writings', NULL, 'https://egwwritings.org', NULL, NULL, 'EGW Writings — повне зібрання опублікованих книг Еллен Г. Вайт від Ellen G. White Estate: пошук, аудіокниги, бібліотека, робочі простори й навчальний центр.', 'EGW Writings is the complete published works of Ellen G. White from the Ellen G. White Estate: search, audiobooks, a library, workspaces and a study center.', 'Офіційна цифрова бібліотека праць Еллен Г. Вайт, однієї із засновниць Церкви адвентистів. Містить усі колекції, категорії й назви, аудіокниги, біографію, бібліографію, пошук, особисту бібліотеку, робочі простори для нотаток, навчальний центр, історію читання й підписки. Є застосунки для телефонів і комп''ютерів та електронні книги.', 'The official digital library of the writings of Ellen G. White, a co-founder of the Adventist Church. It includes all collections, categories and titles, audiobooks, a biography, bibliography, search, a personal library, workspaces for notes, a study center, reading history and subscriptions. There are mobile and desktop apps and eBooks.', 'Повне зібрання праць
Аудіокниги
Пошук
Робочі простори
Застосунки', 'Complete writings
Audiobooks
Search
Workspaces
Apps', 'Адвентисти й дослідники праць Еллен Вайт.', 'Adventists and researchers of Ellen White''s writings.', 'web,mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'egwwritings.org' OR LOWER(`name`) = LOWER('EGW Writings')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'seventh-day-adventists' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'EGW Writings is the complete published works of Ellen G. White from the Ellen G. White Estate: search, audiobooks, a library, workspaces and a study center.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The official digital library of the writings of Ellen G. White, a co-founder of the Adventist Church. It includes all collections, categories and titles, audiobooks, a biography, bibliography, search, a personal library, workspaces for notes, a study center, reading history and subscriptions. There are mobile and desktop apps and eBooks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Complete writings
Audiobooks
Search
Workspaces
Apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Adventists and researchers of Ellen White''s writings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Читання й пошук', 'Reading and search' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Reading and search', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Ellen G. White Estate — Адвентисти сьомого дня
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'whiteestate.org' OR LOWER(`name`) = LOWER('Ellen G. White Estate'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ellen G. White Estate', NULL, 'https://whiteestate.org', NULL, NULL, 'Ellen G. White Estate — офіційна організація, що зберігає спадщину Еллен Вайт: біографія, книги онлайн, сучасні видання, відповіді на запитання й дослідницькі центри.', 'The Ellen G. White Estate is the official custodian of Ellen White''s legacy: biography, books online, current publications, issues and answers and research centers.', 'Сайт організації, що опікується творчою спадщиною Еллен Г. Вайт. Розділи: біографія, про Estate, «Питання й відповіді», праці EGW (список книг, скорочення, поточні видання, електронні книги, девоціонали, «Свідчення для Церкви» сучасною англійською, серія «Конфлікт віків»). Є філії в Кенії, Мічигані й Каліфорнії та дослідницькі центри в різних країнах; сайт пов''язаний з EGWWritings.org та EllenWhite.org.', 'The site of the organization that stewards Ellen G. White''s writings. Sections include biography, about the Estate, Issues and Answers, EGW Writings (book list, abbreviations, current publications, eBooks, devotionals, Testimonies for the Church in modern English, the Conflict of the Ages series). There are branch offices in Kenya, Michigan and California and research centers in several countries; the site links to EGWWritings.org and EllenWhite.org.', 'Біографія Еллен Вайт
Список книг
Питання й відповіді
Дослідницькі центри', 'Ellen White biography
Book list
Issues and answers
Research centers', 'Читачі й дослідники праць Еллен Вайт.', 'Readers and researchers of Ellen White''s writings.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'whiteestate.org' OR LOWER(`name`) = LOWER('Ellen G. White Estate')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'seventh-day-adventists' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Ellen G. White Estate is the official custodian of Ellen White''s legacy: biography, books online, current publications, issues and answers and research centers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of the organization that stewards Ellen G. White''s writings. Sections include biography, about the Estate, Issues and Answers, EGW Writings (book list, abbreviations, current publications, eBooks, devotionals, Testimonies for the Church in modern English, the Conflict of the Ages series). There are branch offices in Kenya, Michigan and California and research centers in several countries; the site links to EGWWritings.org and EllenWhite.org.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Ellen White biography
Book list
Issues and answers
Research centers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Readers and researchers of Ellen White''s writings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Encyclopedia of Seventh-day Adventists — Адвентисти сьомого дня
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'encyclopedia.adventist.org' OR LOWER(`name`) = LOWER('Encyclopedia of Seventh-day Adventists'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Encyclopedia of Seventh-day Adventists', NULL, 'https://encyclopedia.adventist.org', NULL, NULL, 'Енциклопедія адвентистів сьомого дня (ESDA) — онлайн-енциклопедія про історію, людей і установи Церкви з розширеним пошуком і відео.', 'The Encyclopedia of Seventh-day Adventists (ESDA) is an online encyclopedia on the Church''s history, people and institutions with advanced search and videos.', 'Офіційна онлайн-енциклопедія Церкви адвентистів сьомого дня. Містить статті про людей, установи (лікарні, санаторії, школи) і події з усього світу, розширений пошук, перегляд статей, інструкції користування, відомості про авторів і редакторів, відео й можливість долучитися до проєкту.', 'The official online encyclopedia of the Seventh-day Adventist Church. It contains articles on people, institutions (hospitals, sanitariums, schools) and events worldwide, with advanced search, article browsing, how-to guides, author and editor information, videos and ways to get involved.', 'Статті про людей і установи
Розширений пошук
Відео
Автори й редактори', 'Articles on people and institutions
Advanced search
Videos
Authors and editors', 'Дослідники історії адвентизму.', 'Researchers of Adventist history.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'encyclopedia.adventist.org' OR LOWER(`name`) = LOWER('Encyclopedia of Seventh-day Adventists')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'seventh-day-adventists' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Encyclopedia of Seventh-day Adventists (ESDA) is an online encyclopedia on the Church''s history, people and institutions with advanced search and videos.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The official online encyclopedia of the Seventh-day Adventist Church. It contains articles on people, institutions (hospitals, sanitariums, schools) and events worldwide, with advanced search, article browsing, how-to guides, author and editor information, videos and ways to get involved.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Articles on people and institutions
Advanced search
Videos
Authors and editors', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Researchers of Adventist history.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Hope Channel Ukraine (Телеканал «Надія») — Адвентисти сьомого дня
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tv.hope.ua' OR LOWER(`name`) = LOWER('Hope Channel Ukraine (Телеканал «Надія»)'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Hope Channel Ukraine (Телеканал «Надія»)', NULL, 'https://tv.hope.ua', NULL, NULL, 'Телеканал «Надія» — український християнський телеканал медіагрупи «Надія» (Hope Channel): програми, телепрограма, онлайн-ефір і новини.', 'Nadiya TV (Hope Channel Ukraine) is a Ukrainian Christian TV channel of the Nadiya media group: programs, TV schedule, live online broadcast and news.', 'Телеканал медіагрупи «Надія», що працює з 2008 року й входить до мережі Hope Channel. На сайті — каталог програм (наприклад, «Запитання пастору», «Щасливої суботи», «Шлях відновлення»), телепрограма, онлайн-трансляція, новини, розділ підтримки й вакансії.', 'The channel of the Nadiya media group, operating since 2008 and part of the Hope Channel network. The site has a program catalog (for example, "Questions to the Pastor", "Happy Sabbath", "Path of Restoration"), a TV schedule, live streaming, news, a support section and vacancies.', 'Онлайн-ефір
Каталог програм
Телепрограма
Українською', 'Live stream
Program catalog
TV schedule
In Ukrainian', 'Українські глядачі християнських програм.', 'Ukrainian viewers of Christian programs.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tv.hope.ua' OR LOWER(`name`) = LOWER('Hope Channel Ukraine (Телеканал «Надія»)')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'seventh-day-adventists' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Nadiya TV (Hope Channel Ukraine) is a Ukrainian Christian TV channel of the Nadiya media group: programs, TV schedule, live online broadcast and news.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The channel of the Nadiya media group, operating since 2008 and part of the Hope Channel network. The site has a program catalog (for example, "Questions to the Pastor", "Happy Sabbath", "Path of Restoration"), a TV schedule, live streaming, news, a support section and vacancies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Live stream
Program catalog
TV schedule
In Ukrainian', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Ukrainian viewers of Christian programs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Онлайн-перегляд', 'Watch online' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Watch online', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- It Is Written — Адвентисти сьомого дня
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'itiswritten.com' OR LOWER(`name`) = LOWER('It Is Written'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'It Is Written', NULL, 'https://www.itiswritten.com', NULL, NULL, 'It Is Written — адвентистське телевізійне служіння: програми It Is Written, Line Upon Line, Every Word (зокрема мовою жестів ASL), вивчення Біблії й місіонерські поїздки.', 'It Is Written is an Adventist TV ministry: It Is Written, Line Upon Line, Every Word (including in ASL), Bible studies and mission trips.', 'Медійне служіння з програмами It Is Written, Line Upon Line, Hope Awakens, In The Word, щоденним Every Word (також американською мовою жестів) і класичними випусками. Пропонує вивчення Біблії, розклад виступів спікерів, блог, розсилку, місіонерські поїздки (Грузія, Домініканська Республіка, Сьєрра-Леоне, Малаві) і програму Eyes For India. Є версія іспанською та крамниця.', 'A media ministry with the programs It Is Written, Line Upon Line, Hope Awakens, In The Word, the daily Every Word (also in American Sign Language) and classic episodes. It offers Bible studies, speaker schedules, a blog, newsletter, mission trips (Georgia, Dominican Republic, Sierra Leone, Malawi) and the Eyes For India program. There is a Spanish version and a shop.', 'Телепрограми
Every Word мовою жестів
Вивчення Біблії
Місіонерські поїздки', 'TV programs
Every Word in ASL
Bible studies
Mission trips', 'Глядачі християнських програм і учасники місій.', 'Christian TV viewers and mission volunteers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'itiswritten.com' OR LOWER(`name`) = LOWER('It Is Written')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'seventh-day-adventists' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'It Is Written is an Adventist TV ministry: It Is Written, Line Upon Line, Every Word (including in ASL), Bible studies and mission trips.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A media ministry with the programs It Is Written, Line Upon Line, Hope Awakens, In The Word, the daily Every Word (also in American Sign Language) and classic episodes. It offers Bible studies, speaker schedules, a blog, newsletter, mission trips (Georgia, Dominican Republic, Sierra Leone, Malawi) and the Eyes For India program. There is a Spanish version and a shop.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'TV programs
Every Word in ASL
Bible studies
Mission trips', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Christian TV viewers and mission volunteers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Перегляд програм', 'Watch programs' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Watch programs', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Light Bearers — Адвентисти сьомого дня
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lightbearers.org' OR LOWER(`name`) = LOWER('Light Bearers'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Light Bearers', NULL, 'https://lightbearers.org', NULL, NULL, 'Light Bearers — адвентистське служіння: відеосерії, блог, ресурси, видавництво ARISE, програма учнівства Arise і подкаст Gospel Conversations.', 'Light Bearers is an Adventist ministry with video series, a blog, resources, ARISE Publishing, the Arise discipleship program and Gospel Conversations.', 'Служіння, місія якого — показувати красу Божого характеру. Публікує відеосерії (наприклад, дослідження Послання до ефесян із конвокації 2026), щотижневі нові епізоди, сезони Gospel Conversations на YouTube, блог, ресурси й події, видавництво ARISE Publishing і тримісячну програму учнівства Arise в Австралії. Є крамниця й способи підтримки.', 'A ministry whose mission is to vindicate the beauty of God''s character. It publishes video series (such as an exploration of Ephesians from Convocation 2026), weekly new episodes, Gospel Conversations seasons on YouTube, a blog, resources and events, ARISE Publishing and the three-month Arise discipleship program in Australia. There is a shop and ways to give.', 'Відеосерії
Gospel Conversations
Програма учнівства Arise
Блог і ресурси', 'Video series
Gospel Conversations
Arise discipleship program
Blog and resources', 'Християни, які поглиблюють вивчення Писання.', 'Christians going deeper in Scripture.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lightbearers.org' OR LOWER(`name`) = LOWER('Light Bearers')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'seventh-day-adventists' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Light Bearers is an Adventist ministry with video series, a blog, resources, ARISE Publishing, the Arise discipleship program and Gospel Conversations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A ministry whose mission is to vindicate the beauty of God''s character. It publishes video series (such as an exploration of Ephesians from Convocation 2026), weekly new episodes, Gospel Conversations seasons on YouTube, a blog, resources and events, ARISE Publishing and the three-month Arise discipleship program in Australia. There is a shop and ways to give.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Video series
Gospel Conversations
Arise discipleship program
Blog and resources', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Christians going deeper in Scripture.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відео й блог', 'Videos and blog' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Videos and blog', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sabbath School — Адвентисти сьомого дня
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sabbath.school' OR LOWER(`name`) = LOWER('Sabbath School'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sabbath School', NULL, 'https://www.sabbath.school', NULL, NULL, 'Sabbath.School — щотижневі й квартальні уроки суботньої школи адвентистів для вивчення Біблії: читання, відео, аудіо, PDF, PPT і місіонерська історія кількома мовами.', 'Sabbath.School provides the Adventist weekly and quarterly Sabbath School lessons for Bible study: reading, video, audio, PDF, PPT and mission story in several languages.', 'Сайт із поточним квартальним посібником суботньої школи (наприклад, 4-й квартал 2026 — «Дар пророцтва») та архівом попередніх років. До кожного уроку є текст для щоденного читання, відео, аудіо, PDF, презентації PPT, місіонерська історія й відео. Мови: англійська, іспанська, болгарська, хорватська, сербська.', 'A site with the current quarterly Sabbath School guide (for example, Q4 2026: "The Gift of Prophecy") and an archive of past years. Each lesson has daily reading text, video, audio, PDF, PPT slides, a mission story and video. Languages: English, Spanish, Bulgarian, Croatian and Serbian.', 'Поточний квартальний урок
Відео й аудіо
PDF і PPT
Архів уроків
П''ять мов', 'Current quarterly lesson
Video and audio
PDF and PPT
Lesson archive
Five languages', 'Учасники й вчителі суботньої школи.', 'Sabbath School members and teachers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sabbath.school' OR LOWER(`name`) = LOWER('Sabbath School')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'seventh-day-adventists' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Sabbath.School provides the Adventist weekly and quarterly Sabbath School lessons for Bible study: reading, video, audio, PDF, PPT and mission story in several languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A site with the current quarterly Sabbath School guide (for example, Q4 2026: "The Gift of Prophecy") and an archive of past years. Each lesson has daily reading text, video, audio, PDF, PPT slides, a mission story and video. Languages: English, Spanish, Bulgarian, Croatian and Serbian.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Current quarterly lesson
Video and audio
PDF and PPT
Lesson archive
Five languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Sabbath School members and teachers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sabbath School Net — Адвентисти сьомого дня
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ssnet.org' OR LOWER(`name`) = LOWER('Sabbath School Net'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sabbath School Net', NULL, 'https://ssnet.org', NULL, NULL, 'Sabbath School Net — щоденний блог-обговорення уроку суботньої школи адвентистів: тижневі уроки, посібники для вчителів, архів, місіонерські історії й матеріали для дітей.', 'Sabbath School Net is a daily discussion blog for the Adventist Sabbath School lesson: weekly lessons, teaching outlines, archive, mission stories and children''s resources.', 'Сайт для щоденного вивчення Біблії за уроком суботньої школи, де читачі з усього світу обговорюють текст у коментарях. Є тижневі й щоденні уроки поточного кварталу, плани для вчителів, архів уроків, міжнародні аудіо- й відеоматеріали, місіонерські історії та розділи для дітей, підлітків і молоді.', 'A site for daily Bible study following the Sabbath School lesson, where readers worldwide discuss the text in comments. It has weekly and daily lessons for the current quarter, teaching outlines, a lesson archive, international audio-visual features, mission stories and sections for kids, teens and young adults.', 'Щоденний урок
Обговорення в коментарях
Плани для вчителів
Матеріали для дітей', 'Daily lesson
Comment discussions
Teaching outlines
Kids'' resources', 'Адвентисти, що щодня вивчають урок.', 'Adventists studying the lesson daily.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ssnet.org' OR LOWER(`name`) = LOWER('Sabbath School Net')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'seventh-day-adventists' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Sabbath School Net is a daily discussion blog for the Adventist Sabbath School lesson: weekly lessons, teaching outlines, archive, mission stories and children''s resources.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A site for daily Bible study following the Sabbath School lesson, where readers worldwide discuss the text in comments. It has weekly and daily lessons for the current quarter, teaching outlines, a lesson archive, international audio-visual features, mission stories and sections for kids, teens and young adults.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Daily lesson
Comment discussions
Teaching outlines
Kids'' resources', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Adventists studying the lesson daily.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SDA Hymnal — Адвентисти сьомого дня
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sdahymnal.org' OR LOWER(`name`) = LOWER('SDA Hymnal'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SDA Hymnal', NULL, 'https://www.sdahymnal.org', NULL, NULL, 'SDA Hymnal — онлайн-гімнарій адвентистів: пошук гімнів за номером, назвою, словами чи категорією, топ-10 гімнів, інші збірки й мови.', 'SDA Hymnal is an online Adventist hymnal: search hymns by number, title, lyrics or category, top 10 hymns, other hymnals and languages.', 'Сайт для пошуку гімнів адвентистського гімнарію. Шукати можна за номером (цифрова клавіатура), словами чи категорією, переглядати топ-10. Можна обрати інший гімнарій, наприклад Church Hymnal 1940 року, а також сербські й хорватські збірки адвентистських гімнів.', 'A site for finding hymns in the Adventist hymnal. Search by number (with a number pad), lyrics or category, or browse the top 10. You can switch to other hymnals such as the 1940 Church Hymnal, as well as Serbian and Croatian Adventist hymnals.', 'Пошук за номером
Пошук за словами
Категорії
Інші гімнарії', 'Search by number
Search by lyrics
Categories
Other hymnals', 'Співаки, музиканти й керівники богослужінь.', 'Singers, musicians and worship leaders.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sdahymnal.org' OR LOWER(`name`) = LOWER('SDA Hymnal')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'seventh-day-adventists' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'SDA Hymnal is an online Adventist hymnal: search hymns by number, title, lyrics or category, top 10 hymns, other hymnals and languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A site for finding hymns in the Adventist hymnal. Search by number (with a number pad), lyrics or category, or browse the top 10. You can switch to other hymnals such as the 1940 Church Hymnal, as well as Serbian and Croatian Adventist hymnals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Search by number
Search by lyrics
Categories
Other hymnals', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Singers, musicians and worship leaders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Seventh-day Adventist Church — Адвентисти сьомого дня
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'adventist.org' OR LOWER(`name`) = LOWER('Seventh-day Adventist Church'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Seventh-day Adventist Church', NULL, 'https://www.adventist.org', NULL, NULL, 'Adventist.org — офіційний сайт всесвітньої Церкви адвентистів сьомого дня: вірування, історія, служіння, новини й посилання на регіональні відділення.', 'Adventist.org is the official site of the worldwide Seventh-day Adventist Church: beliefs, history, ministries, news and links to regional divisions.', 'Сайт Генеральної конференції Церкви адвентистів сьомого дня. Пояснює основні вірування Церкви, її історію, організацію та служіння (освіта, здоров''я, місія, молодь, сім''я), публікує новини й посилання на регіональні відділення, медіа й ресурси для вивчення Біблії.', 'The site of the General Conference of the Seventh-day Adventist Church. It explains the Church''s fundamental beliefs, history, organization and ministries (education, health, mission, youth, family) and publishes news and links to regional divisions, media and Bible study resources.', 'Вірування Церкви
Історія й організація
Служіння
Регіональні відділення', 'Church beliefs
History and organization
Ministries
Regional divisions', 'Адвентисти та ті, хто хоче дізнатися про Церкву.', 'Adventists and people wanting to learn about the Church.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'adventist.org' OR LOWER(`name`) = LOWER('Seventh-day Adventist Church')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'seventh-day-adventists' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Adventist.org is the official site of the worldwide Seventh-day Adventist Church: beliefs, history, ministries, news and links to regional divisions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of the General Conference of the Seventh-day Adventist Church. It explains the Church''s fundamental beliefs, history, organization and ministries (education, health, mission, youth, family) and publishes news and links to regional divisions, media and Bible study resources.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Church beliefs
History and organization
Ministries
Regional divisions', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Adventists and people wanting to learn about the Church.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Церква адвентистів сьомого дня в Україні — Адвентисти сьомого дня
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'adventist.ua' OR LOWER(`name`) = LOWER('Церква адвентистів сьомого дня в Україні'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Церква адвентистів сьомого дня в Україні', NULL, 'https://adventist.ua', NULL, NULL, 'Офіційний сайт Церкви адвентистів сьомого дня в Україні: хто ми, у що віримо, служіння, новини, аналітика, блоги, відео й періодика.', 'The official site of the Seventh-day Adventist Church in Ukraine: who we are, beliefs, ministries, news, analysis, blogs, videos and periodicals.', 'Сайт Української уніонної конференції Церкви адвентистів. Розділи «Хто ми» (історія, вірування, цінності), «Служіння» (свобода, розвиток, здоров''я, сім''я, віра в Бога), новини України й світу, аналітика, блоги, відеоновини, інтерв''ю, огляд ЗМІ, періодика й книги. Є можливість пожертвувати.', 'The site of the Ukrainian Union Conference of the Adventist Church. Sections cover who we are (history, beliefs, values), ministries (freedom, development, health, family, faith in God), Ukrainian and world news, analysis, blogs, video news, interviews, a media review, periodicals and books. Donations are possible.', 'Вірування й історія
Служіння
Новини й блоги
Періодика', 'Beliefs and history
Ministries
News and blogs
Periodicals', 'Адвентисти України та всі, хто цікавиться Церквою.', 'Adventists in Ukraine and anyone interested in the Church.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'adventist.ua' OR LOWER(`name`) = LOWER('Церква адвентистів сьомого дня в Україні')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'seventh-day-adventists' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The official site of the Seventh-day Adventist Church in Ukraine: who we are, beliefs, ministries, news, analysis, blogs, videos and periodicals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of the Ukrainian Union Conference of the Adventist Church. Sections cover who we are (history, beliefs, values), ministries (freedom, development, health, family, faith in God), Ukrainian and world news, analysis, blogs, video news, interviews, a media review, periodicals and books. Donations are possible.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Beliefs and history
Ministries
News and blogs
Periodicals', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Adventists in Ukraine and anyone interested in the Church.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Back to Godhead — Харе Крішна (ISKCON)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'btg.krishna.com' OR LOWER(`name`) = LOWER('Back to Godhead'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Back to Godhead', NULL, 'https://btg.krishna.com', NULL, NULL, 'Back to Godhead — журнал руху Харе Крішна, заснований Прабгупадою: статті про свідомість Крішни й ведичну філософію, архів номерів і підписка.', 'Back to Godhead is the Hare Krishna movement''s magazine founded by Prabhupada: articles on Krishna consciousness and Vedic philosophy, back issues and subscriptions.', 'Журнал BTG пропонує духовні роздуми й практичні поради для тих, хто цікавиться свідомістю Крішни та ведичною філософією. На сайті — статті, архів попередніх номерів, галереї, обслуговування передплатників і можливість стати меценатом друкованого видання.', 'BTG magazine offers spiritual insights and practical guidance for those interested in Krishna consciousness and Vedic philosophy. The site has articles, previous issues, galleries, subscriber services and a way to become a patron of the print edition.', 'Статті
Архів номерів
Підписка на друковану версію
Галереї', 'Articles
Back issues
Print subscription
Galleries', 'Читачі, які цікавляться свідомістю Крішни.', 'Readers interested in Krishna consciousness.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'btg.krishna.com' OR LOWER(`name`) = LOWER('Back to Godhead')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'hare-krishna' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Back to Godhead is the Hare Krishna movement''s magazine founded by Prabhupada: articles on Krishna consciousness and Vedic philosophy, back issues and subscriptions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'BTG magazine offers spiritual insights and practical guidance for those interested in Krishna consciousness and Vedic philosophy. The site has articles, previous issues, galleries, subscriber services and a way to become a patron of the print edition.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Articles
Back issues
Print subscription
Galleries', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Readers interested in Krishna consciousness.', 'manual' FROM DUAL WHERE @new = 1;

-- Bhakti Courses — Харе Крішна (ISKCON)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bhakticourses.com' OR LOWER(`name`) = LOWER('Bhakti Courses'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bhakti Courses', NULL, 'https://bhakticourses.com', NULL, NULL, 'Bhakti Courses — онлайн-курси поглибленого вивчення книг Прабгупади чотирьох рівнів: JOSD, IDC, Бгакті Шастрі, «Персонажі Магабгарати»; англійською, гінді й маратхі.', 'Bhakti Courses offers in-depth online study of Prabhupada''s books at four levels: JOSD, IDC, Bhakti Shastri and Mahabharata Characters, in English, Hindi and Marathi.', 'Платформа онлайн-навчання за книгами Шріли Прабгупади. Курси поділено на рівні: початковий, ISKCON, брахманський і поглиблений. Доступні Joy of Spiritual Discovery (JOSD), ISKCON Disciple Course (IDC), Бгакті Шастрі, «Персонажі Магабгарати» та «Шрі Чайтанья-чарітамріта»; частина курсів — гінді й маратхі. Є особистий кабінет, FAQ, новини й прийом заявок.', 'An online learning platform built on Srila Prabhupada''s books. Courses are split into levels: beginner, ISKCON, brahmana and advanced. Offerings include Joy of Spiritual Discovery (JOSD), the ISKCON Disciple Course (IDC), Bhakti Shastri, Mahabharata Characters and Sri Chaitanya Charitamrita; some courses are in Hindi and Marathi. There is a personal account, FAQs, news and admissions.', 'Чотири рівні
Бгакті Шастрі
ISKCON Disciple Course
Англійська, гінді, маратхі', 'Four levels
Bhakti Shastri
ISKCON Disciple Course
English, Hindi, Marathi', 'Віддані, які хочуть системно вивчати писання.', 'Devotees who want to study scripture systematically.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bhakticourses.com' OR LOWER(`name`) = LOWER('Bhakti Courses')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'hare-krishna' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Bhakti Courses offers in-depth online study of Prabhupada''s books at four levels: JOSD, IDC, Bhakti Shastri and Mahabharata Characters, in English, Hindi and Marathi.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An online learning platform built on Srila Prabhupada''s books. Courses are split into levels: beginner, ISKCON, brahmana and advanced. Offerings include Joy of Spiritual Discovery (JOSD), the ISKCON Disciple Course (IDC), Bhakti Shastri, Mahabharata Characters and Sri Chaitanya Charitamrita; some courses are in Hindi and Marathi. There is a personal account, FAQs, news and admissions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Four levels
Bhakti Shastri
ISKCON Disciple Course
English, Hindi, Marathi', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Devotees who want to study scripture systematically.', 'manual' FROM DUAL WHERE @new = 1;

-- Bhaktivedanta Book Trust — Харе Крішна (ISKCON)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bbt.org' OR LOWER(`name`) = LOWER('Bhaktivedanta Book Trust'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bhaktivedanta Book Trust', NULL, 'https://www.bbt.org', NULL, NULL, 'Bhaktivedanta Book Trust (BBT) — видавець класичних вайшнавських текстів і праць про бгакті-йогу: Писання 87 мовами, аудіокниги й електронні книги.', 'The Bhaktivedanta Book Trust (BBT) publishes classic Vaishnava texts and works on bhakti-yoga: scriptures in 87 languages, audiobooks and eBooks.', 'Видавництво, засноване Прабгупадою, яке називає себе найбільшим у світі видавцем класичних вайшнавських текстів і сучасних праць з філософії, богослов''я й культури бгакті-йоги. Публікує традиційні писання в перекладах 87 мовами та книги з їх поясненнями, аудіокниги й електронні книги. На сайті — про засновника, каталог книг, новини й способи долучитися.', 'A publisher founded by Prabhupada that describes itself as the world''s largest publisher of classic Vaishnava texts and contemporary works on the philosophy, theology and culture of bhakti-yoga. It publishes traditional scriptures translated into 87 languages, books explaining them, audiobooks and eBooks. The site covers the founder, a book catalog, news and ways to get involved.', 'Писання 87 мовами
Аудіокниги
Електронні книги
Каталог видань', 'Scriptures in 87 languages
Audiobooks
eBooks
Publication catalog', 'Читачі вайшнавської літератури.', 'Readers of Vaishnava literature.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bbt.org' OR LOWER(`name`) = LOWER('Bhaktivedanta Book Trust')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'hare-krishna' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Bhaktivedanta Book Trust (BBT) publishes classic Vaishnava texts and works on bhakti-yoga: scriptures in 87 languages, audiobooks and eBooks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A publisher founded by Prabhupada that describes itself as the world''s largest publisher of classic Vaishnava texts and contemporary works on the philosophy, theology and culture of bhakti-yoga. It publishes traditional scriptures translated into 87 languages, books explaining them, audiobooks and eBooks. The site covers the founder, a book catalog, news and ways to get involved.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Scriptures in 87 languages
Audiobooks
eBooks
Publication catalog', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Readers of Vaishnava literature.', 'manual' FROM DUAL WHERE @new = 1;

-- ISKCON London — Харе Крішна (ISKCON)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'iskcon.london' OR LOWER(`name`) = LOWER('ISKCON London'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ISKCON London', NULL, 'https://iskcon.london', NULL, NULL, 'ISKCON London — сайт храму Радга-Крішна в Лондоні: даршан, розклад подій, філософія, Food For Life, коледж ведичних студій і Krishna Club.', 'ISKCON London is the site of the Radha-Krishna Temple in London: darshan, event schedule, philosophy, Food For Life, a college of Vedic studies and Krishna Club.', 'Лондонський храм Радга-Крішна — давній духовний осередок у центрі міста. Сайт розповідає про історію ISKCON у Лондоні, засновника й Божества, філософію (оспівування, танець і бенкет), щоденний даршан, фотоархів, розклад подій і розсилку. Є посилання на Mayapur.tv, Лондонський коледж ведичних студій, Krishna Club, підтримку російськомовних і пожертви.', 'London''s Radha-Krishna Temple is a long-standing spiritual space in the city centre. The site covers ISKCON''s history in London, the founder and deities, the philosophy (chanting, dancing and feasting), daily darshan, a photo archive, event schedule and newsletter. It links to Mayapur.tv, the London College of Vedic Studies, Krishna Club, Russian-speaker support and donations.', 'Щоденний даршан
Розклад подій
Коледж ведичних студій
Розсилка', 'Daily darshan
Event schedule
College of Vedic studies
Newsletter', 'Відвідувачі храму та зацікавлені бгакті-йогою в Лондоні.', 'Temple visitors and people interested in bhakti-yoga in London.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'iskcon.london' OR LOWER(`name`) = LOWER('ISKCON London')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'hare-krishna' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ISKCON London is the site of the Radha-Krishna Temple in London: darshan, event schedule, philosophy, Food For Life, a college of Vedic studies and Krishna Club.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'London''s Radha-Krishna Temple is a long-standing spiritual space in the city centre. The site covers ISKCON''s history in London, the founder and deities, the philosophy (chanting, dancing and feasting), daily darshan, a photo archive, event schedule and newsletter. It links to Mayapur.tv, the London College of Vedic Studies, Krishna Club, Russian-speaker support and donations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Daily darshan
Event schedule
College of Vedic studies
Newsletter', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Temple visitors and people interested in bhakti-yoga in London.', 'manual' FROM DUAL WHERE @new = 1;

-- ISKCON Vrindavan — Харе Крішна (ISKCON)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'iskconvrindavan.com' OR LOWER(`name`) = LOWER('ISKCON Vrindavan'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ISKCON Vrindavan', NULL, 'https://iskconvrindavan.com', NULL, NULL, 'ISKCON Vrindavan — сайт храму Крішна-Баларам у Вріндавані: живий даршан, бронювання пудж і ягій, вайшнавський календар, пісні, застосунок і курси.', 'ISKCON Vrindavan is the site of the Krishna-Balaram temple in Vrindavan: live darshan, puja and yagya booking, Vaishnava calendar, songs, an app and courses.', 'Сайт храму ISKCON у Вріндавані. Дає змогу переглядати даршан наживо, бронювати пуджі та ягʼї, дізнатися розклад і зручності храму, переглянути вайшнавський календар і пісні, прочитати про засновника-ачар''ю й історію храму. В особистому кабінеті — пожертви, замовлені пуджі й курси. Є мобільний застосунок.', 'The site of the ISKCON temple in Vrindavan. It offers live darshan, puja and yagya booking, temple timings and facilities, a Vaishnava calendar and songs, and pages about the founder-acharya and the temple''s history. A personal account shows donations, booked pujas and courses. There is a mobile app.', 'Живий даршан
Бронювання пудж
Вайшнавський календар
Мобільний застосунок', 'Live darshan
Puja booking
Vaishnava calendar
Mobile app', 'Паломники й віддані, які стежать за храмом.', 'Pilgrims and devotees following the temple.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'iskconvrindavan.com' OR LOWER(`name`) = LOWER('ISKCON Vrindavan')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'hare-krishna' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ISKCON Vrindavan is the site of the Krishna-Balaram temple in Vrindavan: live darshan, puja and yagya booking, Vaishnava calendar, songs, an app and courses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of the ISKCON temple in Vrindavan. It offers live darshan, puja and yagya booking, temple timings and facilities, a Vaishnava calendar and songs, and pages about the founder-acharya and the temple''s history. A personal account shows donations, booked pujas and courses. There is a mobile app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Live darshan
Puja booking
Vaishnava calendar
Mobile app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Pilgrims and devotees following the temple.', 'manual' FROM DUAL WHERE @new = 1;

-- Krishna Store — Харе Крішна (ISKCON)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'krishnastore.com' OR LOWER(`name`) = LOWER('Krishna Store'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Krishna Store', NULL, 'https://www.krishnastore.com', NULL, NULL, 'Krishna Store — інтернет-магазин книг, відео й аудіо Прабгупади та речей для практики свідомості Крішни вдома: Бгаґавад-ґіта, вегетаріанська кухня, санскрит, мурті.', 'Krishna Store sells Prabhupada''s books, video and audio and supplies for practicing Krishna consciousness at home: Bhagavad-gita, vegetarian cooking, Sanskrit and deities.', 'Магазин усіх книг, відео й аудіо А. Ч. Бгактіведанти Свамі Прабгупади, засновника ISKCON. Категорії: Бгаґавад-ґіта, електронні книги, йога й медитація, вегетаріанська кухня, вивчення санскриту й гінді, дитячі книги, переклади іншими мовами, фільми на USB-накопичувачах, анімація, а також одяг, мурті й предмети поклоніння. Ціни в доларах США, є оптові замовлення.', 'A store for all books, video and audio of A.C. Bhaktivedanta Swami Prabhupada, ISKCON''s founder. Categories include Bhagavad-gita, eBooks, yoga and meditation, vegetarian cooking, learning Sanskrit and Hindi, children''s books, other languages, films on USB sticks, animation, plus clothing, deities and worship items. Prices in US dollars; wholesale is available.', 'Книги Прабгупади
Відео й аудіо
Предмети поклоніння
Оптові замовлення', 'Prabhupada''s books
Video and audio
Worship items
Wholesale', 'Віддані й храми.', 'Devotees and temples.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'krishnastore.com' OR LOWER(`name`) = LOWER('Krishna Store')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'hare-krishna' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Krishna Store sells Prabhupada''s books, video and audio and supplies for practicing Krishna consciousness at home: Bhagavad-gita, vegetarian cooking, Sanskrit and deities.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A store for all books, video and audio of A.C. Bhaktivedanta Swami Prabhupada, ISKCON''s founder. Categories include Bhagavad-gita, eBooks, yoga and meditation, vegetarian cooking, learning Sanskrit and Hindi, children''s books, other languages, films on USB sticks, animation, plus clothing, deities and worship items. Prices in US dollars; wholesale is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Prabhupada''s books
Video and audio
Worship items
Wholesale', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Devotees and temples.', 'manual' FROM DUAL WHERE @new = 1;

-- Krishna.ua — Харе Крішна (ISKCON)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'krishna.ua' OR LOWER(`name`) = LOWER('Krishna.ua'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Krishna.ua', NULL, 'https://krishna.ua', NULL, NULL, 'Krishna.ua — сайт Товариства свідомості Крішни в Україні: храм, даршан, розклад, трансляції, Ведична академія, онлайн-навчання, новини й календар свят.', 'Krishna.ua is the site of the International Society for Krishna Consciousness in Ukraine: temple, darshan, schedule, broadcasts, Vedic Academy, online learning, news and festival calendar.', 'Сайт українського ISKCON. Розділи: храм (даршан Божеств, розклад, трансляція, як дістатися), навчання (Ведична академія, онлайн-освіта для відданих, матаджі-ашрам), новини, блог, «Прабгупада», «Словами садгу», кухня, календар свят (екадаші, кіртани, фестивалі) і проєкти. Сайт українською з частиною матеріалів російською.', 'The site of ISKCON Ukraine. Sections cover the temple (deity darshan, schedule, broadcasts, directions), learning (Vedic Academy, online education for devotees, matajis'' ashram), news, a blog, Prabhupada, sadhu quotes, cooking, a festival calendar (Ekadashi, kirtans, festivals) and projects. The site is in Ukrainian with some content in Russian.', 'Даршан і трансляції
Ведична академія
Календар свят
Українською', 'Darshan and broadcasts
Vedic Academy
Festival calendar
In Ukrainian', 'Віддані й зацікавлені в Україні.', 'Devotees and interested people in Ukraine.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'krishna.ua' OR LOWER(`name`) = LOWER('Krishna.ua')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'hare-krishna' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Krishna.ua is the site of the International Society for Krishna Consciousness in Ukraine: temple, darshan, schedule, broadcasts, Vedic Academy, online learning, news and festival calendar.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of ISKCON Ukraine. Sections cover the temple (deity darshan, schedule, broadcasts, directions), learning (Vedic Academy, online education for devotees, matajis'' ashram), news, a blog, Prabhupada, sadhu quotes, cooking, a festival calendar (Ekadashi, kirtans, festivals) and projects. The site is in Ukrainian with some content in Russian.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Darshan and broadcasts
Vedic Academy
Festival calendar
In Ukrainian', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Devotees and interested people in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Mayapur Institute — Харе Крішна (ISKCON)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mayapurinstitute.org' OR LOWER(`name`) = LOWER('Mayapur Institute'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mayapur Institute', NULL, 'https://mayapurinstitute.org', NULL, NULL, 'Mayapur Institute — навчальний проєкт фонду розвитку Шрідгам Маяпура: курси Бгакті Шастрі, підготовка викладачів, онлайн, очні й безкоштовні курси.', 'Mayapur Institute is an education project of the Sridham Mayapur Development Foundation: Bhakti Shastri courses, teacher training, online, onsite and free courses.', 'Освітній проєкт у Маяпурі для поглибленого вивчення Бгаґавад-ґіти та інших писань. Пропонує курс Бгакті Шастрі, підготовку викладачів (VTE Teacher Training, Bhakti-sastri Teacher Training), онлайн-, очні, живі й безкоштовні курси, статті та крамницю. На сайті є правила, політика повернення коштів і особистий кабінет.', 'An education project in Mayapur for in-depth study of the Bhagavad-gita and other scriptures. It offers the Bhakti Shastri course, teacher training (VTE Teacher Training, Bhakti-sastri Teacher Training), online, onsite, live and free courses, articles and a shop. The site has terms, a refund policy and a personal account.', 'Курс Бгакті Шастрі
Підготовка викладачів
Онлайн та очно
Безкоштовні курси', 'Bhakti Shastri course
Teacher training
Online and onsite
Free courses', 'Віддані й майбутні викладачі.', 'Devotees and future teachers.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mayapurinstitute.org' OR LOWER(`name`) = LOWER('Mayapur Institute')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'hare-krishna' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Mayapur Institute is an education project of the Sridham Mayapur Development Foundation: Bhakti Shastri courses, teacher training, online, onsite and free courses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An education project in Mayapur for in-depth study of the Bhagavad-gita and other scriptures. It offers the Bhakti Shastri course, teacher training (VTE Teacher Training, Bhakti-sastri Teacher Training), online, onsite, live and free courses, articles and a shop. The site has terms, a refund policy and a personal account.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Bhakti Shastri course
Teacher training
Online and onsite
Free courses', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Devotees and future teachers.', 'manual' FROM DUAL WHERE @new = 1;

-- Mayapur.com — Харе Крішна (ISKCON)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mayapur.com' OR LOWER(`name`) = LOWER('Mayapur.com'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mayapur.com', NULL, 'https://www.mayapur.com', NULL, NULL, 'Mayapur.com — сайт центру ISKCON у Маяпурі: спільнота, медіа, бронювання житла й турів, онлайн-пуджі, пожертви та календар свят.', 'Mayapur.com is the site of ISKCON''s Mayapur center: community, media, accommodation and tour bookings, online pujas, donations and a festival calendar.', 'Сайт Шрідгам Маяпура — світового центру ISKCON. Розповідає про спільноту, медіа й відвідування; дає змогу забронювати житло й тури, замовити пуджу онлайн, зробити пожертву та стежити за святами (Васанта Панчамі, Нітьянанда Трайодаші, Акшая-трітія, Нрісімха Чатурдаші, Снана-ятра тощо).', 'The site of Sridham Mayapur, ISKCON''s world center. It covers the community, media and visiting; lets you book accommodation and tours, order a puja online, donate and follow festivals (Vasanta Pancami, Nityananda Trayodasi, Akshaya-tritiya, Narasimha Caturdasi, Snana Yatra and more).', 'Бронювання житла й турів
Онлайн-пуджі
Календар свят
Медіа', 'Accommodation and tour booking
Online pujas
Festival calendar
Media', 'Паломники й віддані ISKCON.', 'Pilgrims and ISKCON devotees.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mayapur.com' OR LOWER(`name`) = LOWER('Mayapur.com')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'hare-krishna' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Mayapur.com is the site of ISKCON''s Mayapur center: community, media, accommodation and tour bookings, online pujas, donations and a festival calendar.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of Sridham Mayapur, ISKCON''s world center. It covers the community, media and visiting; lets you book accommodation and tours, order a puja online, donate and follow festivals (Vasanta Pancami, Nityananda Trayodasi, Akshaya-tritiya, Narasimha Caturdasi, Snana Yatra and more).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Accommodation and tour booking
Online pujas
Festival calendar
Media', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Pilgrims and ISKCON devotees.', 'manual' FROM DUAL WHERE @new = 1;

-- Prabhupada.io — Харе Крішна (ISKCON)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prabhupada.io' OR LOWER(`name`) = LOWER('Prabhupada.io'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Prabhupada.io', NULL, 'https://prabhupada.io', NULL, NULL, 'Prabhupada.io — цифровий архів повного вчення Прабгупади: оригінальні книги (34 400+ сторінок), 3 770 аудіозаписів, 6 585 листів, пісні, покажчик і вікі.', 'Prabhupada.io is a digital archive of Prabhupada''s complete teachings: original books (34,400+ pages), 3,770 recordings, 6,585 letters, songs, an index and a wiki.', '«Священний цифровий архів» повних повчань А. Ч. Бгактіведанти Свамі Прабгупади. Містить кожне оригінальне видання книг дослівно (Бгаґавад-ґіта, Шрімад-Бгаґаватам, Чайтанья-чарітамріта, «Нектар настанов», «Шрі Ішопанішада» тощо) — понад 34 400 сторінок, 3 770 записів лекцій і бесід, 6 585 листів, пісні, покажчик, вікі й галерею, з пошуком по всьому архіву.', 'A "sacred digital archive" of the complete teachings of A.C. Bhaktivedanta Swami Prabhupada. It has every original book edition verbatim (Bhagavad-gita, Srimad-Bhagavatam, Caitanya-caritamrta, Nectar of Instruction, Sri Isopanisad and more) — over 34,400 pages — plus 3,770 recordings of lectures and conversations, 6,585 letters, songs, an index, a wiki and a gallery, with search across the archive.', '34 400+ сторінок книг
3 770 записів
6 585 листів
Пошук по архіву', '34,400+ book pages
3,770 recordings
6,585 letters
Archive-wide search', 'Дослідники й читачі Прабгупади.', 'Prabhupada researchers and readers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prabhupada.io' OR LOWER(`name`) = LOWER('Prabhupada.io')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'hare-krishna' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Prabhupada.io is a digital archive of Prabhupada''s complete teachings: original books (34,400+ pages), 3,770 recordings, 6,585 letters, songs, an index and a wiki.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A "sacred digital archive" of the complete teachings of A.C. Bhaktivedanta Swami Prabhupada. It has every original book edition verbatim (Bhagavad-gita, Srimad-Bhagavatam, Caitanya-caritamrta, Nectar of Instruction, Sri Isopanisad and more) — over 34,400 pages — plus 3,770 recordings of lectures and conversations, 6,585 letters, songs, an index, a wiki and a gallery, with search across the archive.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '34,400+ book pages
3,770 recordings
6,585 letters
Archive-wide search', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Prabhupada researchers and readers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- PrabhupadaBooks.com — Харе Крішна (ISKCON)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prabhupadabooks.com' OR LOWER(`name`) = LOWER('PrabhupadaBooks.com'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PrabhupadaBooks.com', NULL, 'https://prabhupadabooks.com', NULL, NULL, 'PrabhupadaBooks.com — оригінальні книги, лекції, бесіди й листи Прабгупади онлайн: зміст, синоніми, переклади, коментарі, деванаґарі й налаштування тексту.', 'PrabhupadaBooks.com offers Prabhupada''s original books, lectures, conversations and letters online with synonyms, translations, purports, Devanagari and text settings.', 'Онлайн-бібліотека оригінальних видань книг А. Ч. Бгактіведанти Свамі Прабгупади, а також його лекцій, бесід, листів та інших повчань. Зміст ліворуч дає змогу відкрити будь-яку назву; можна вмикати й вимикати вірші, синоніми, переклади, коментарі та деванаґарі, обирати діакритику (Unicode тощо), розмір тексту й словникові посилання. Є реєстрація та вхід.', 'An online library of the original editions of A.C. Bhaktivedanta Swami Prabhupada''s books, plus his lectures, conversations, letters and other teachings. A table of contents opens any title; you can toggle verses, synonyms, translations, purports and Devanagari, choose diacritics (Unicode and others), text size and dictionary links. Registration and login are available.', 'Оригінальні видання
Лекції й листи
Деванаґарі й синоніми
Налаштування тексту', 'Original editions
Lectures and letters
Devanagari and synonyms
Text settings', 'Віддані й дослідники праць Прабгупади.', 'Devotees and researchers of Prabhupada''s works.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prabhupadabooks.com' OR LOWER(`name`) = LOWER('PrabhupadaBooks.com')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'hare-krishna' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'PrabhupadaBooks.com offers Prabhupada''s original books, lectures, conversations and letters online with synonyms, translations, purports, Devanagari and text settings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An online library of the original editions of A.C. Bhaktivedanta Swami Prabhupada''s books, plus his lectures, conversations, letters and other teachings. A table of contents opens any title; you can toggle verses, synonyms, translations, purports and Devanagari, choose diacritics (Unicode and others), text size and dictionary links. Registration and login are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Original editions
Lectures and letters
Devanagari and synonyms
Text settings', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Devotees and researchers of Prabhupada''s works.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Vaisnava Calendar — Харе Крішна (ISKCON)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vaisnavacalendar.info' OR LOWER(`name`) = LOWER('Vaisnava Calendar'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Vaisnava Calendar', NULL, 'https://www.vaisnavacalendar.info', NULL, NULL, 'ISKCON / Vaisnava Calendar — нагадування поштою про екадаші, свята й дні явлення та відходу святих, плюс календарні файли ICS, TXT і CSV.', 'ISKCON / Vaisnava Calendar sends email reminders for Ekadasi, festivals and saints'' appearance and disappearance days, plus ICS, TXT and CSV calendar files.', 'Сервіс нагадувань за вайшнавським календарем ISKCON. Після підписки надсилає листи про екадаші й двадаші, Чатурмасью, головні свята, дні явлення й відходу святих і ачар''їв та інші події. Календарі можна завантажити у форматах ICAL (ics), TXT і CSV на 2026 і 2027 роки та додати у свій календар.', 'A reminder service based on the ISKCON Vaisnava calendar. After signing up it emails you about Ekadasi and Dwadasi, Caturmasya, major festivals, appearance and disappearance days of saints and acaryas and other observances. Calendars can be downloaded as ICAL (ics), TXT and CSV files for 2026 and 2027 and added to your own calendar.', 'Нагадування поштою
Екадаші й свята
Файли ICS, TXT, CSV
На 2026–2027 роки', 'Email reminders
Ekadasi and festivals
ICS, TXT, CSV files
For 2026–2027', 'Віддані, які дотримуються вайшнавського календаря.', 'Devotees following the Vaishnava calendar.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vaisnavacalendar.info' OR LOWER(`name`) = LOWER('Vaisnava Calendar')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'hare-krishna' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ISKCON / Vaisnava Calendar sends email reminders for Ekadasi, festivals and saints'' appearance and disappearance days, plus ICS, TXT and CSV calendar files.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A reminder service based on the ISKCON Vaisnava calendar. After signing up it emails you about Ekadasi and Dwadasi, Caturmasya, major festivals, appearance and disappearance days of saints and acaryas and other observances. Calendars can be downloaded as ICAL (ics), TXT and CSV files for 2026 and 2027 and added to your own calendar.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Email reminders
Ekadasi and festivals
ICS, TXT, CSV files
For 2026–2027', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Devotees following the Vaishnava calendar.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Підписка й файли', 'Sign-up and files' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Sign-up and files', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Bridge Publications — Саєнтологія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bridgepub.com' OR LOWER(`name`) = LOWER('Bridge Publications'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bridge Publications', NULL, 'https://www.bridgepub.com', NULL, NULL, 'Bridge Publications — видавець матеріалів діанетики й саєнтології: книги, класичні лекції, серія «The Basics», конгреси й пакети, багато мов.', 'Bridge Publications publishes Dianetics and Scientology materials: books, classic lectures, The Basics series, congresses and packages in many languages.', 'Офіційне видавництво матеріалів діанетики й саєнтології для Америки. Каталог: вступні книги, класичні лекції, серія «The Basics», конгреси, поглиблені клінічні курси та пакети. Більшість книг у м''якій обкладинці коштують близько 20–25 $, пакети — від 175 $. Сайт і каталог доступні понад десятком мов.', 'The official publisher of Dianetics and Scientology materials for the Americas. The catalog includes beginning books, classic lectures, The Basics series, congresses, advanced clinical courses and packages. Most paperbacks cost about $20–25, packages from $175. The site and catalog are available in more than a dozen languages.', 'Книги й лекції
Серія «The Basics»
Пакети
Понад 10 мов', 'Books and lectures
The Basics series
Packages
Over 10 languages', 'Читачі й учні саєнтології.', 'Readers and students of Scientology.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bridgepub.com' OR LOWER(`name`) = LOWER('Bridge Publications')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'scientology' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Bridge Publications publishes Dianetics and Scientology materials: books, classic lectures, The Basics series, congresses and packages in many languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The official publisher of Dianetics and Scientology materials for the Americas. The catalog includes beginning books, classic lectures, The Basics series, congresses, advanced clinical courses and packages. Most paperbacks cost about $20–25, packages from $175. The site and catalog are available in more than a dozen languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Books and lectures
The Basics series
Packages
Over 10 languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Readers and students of Scientology.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Книга в м''якій обкладинці', 'Paperback', 20.00, 'one_time', 'Типова ціна книги', 'Typical book price' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Книга в м''якій обкладинці' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paperback', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Typical book price', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Church of Scientology — Саєнтологія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'scientology.org' OR LOWER(`name`) = LOWER('Church of Scientology'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Church of Scientology', NULL, 'https://www.scientology.org', NULL, NULL, 'Офіційний сайт Церкви саєнтології: що таке саєнтологія, у що вірять саєнтологи, засновник Л. Рон Габбард, діанетика, книги, відео й новини.', 'The official Church of Scientology site: what Scientology is, what Scientologists believe, founder L. Ron Hubbard, Dianetics, books, videos and news.', 'Головний сайт Церкви саєнтології. Розповідає про вірування й практики саєнтологів, засновника Л. Рона Габбарда, діанетику, церкви по світу та соціальні програми організації. Містить відео, фото, книги, новини й посилання на телеканал Scientology Network. Доступний понад десятком мов, зокрема російською.', 'The main Church of Scientology website. It describes Scientologists'' beliefs and practices, founder L. Ron Hubbard, Dianetics, churches around the world and the organization''s social programs. It includes videos, photos, books, news and links to the Scientology Network channel. Available in more than a dozen languages, including Russian.', 'Вірування й практики
Про Л. Рона Габбарда
Відео й книги
Понад 10 мов', 'Beliefs and practices
About L. Ron Hubbard
Videos and books
Over 10 languages', 'Ті, хто хоче дізнатися про саєнтологію з першоджерела.', 'People who want to learn about Scientology from the source.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'scientology.org' OR LOWER(`name`) = LOWER('Church of Scientology')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'scientology' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The official Church of Scientology site: what Scientology is, what Scientologists believe, founder L. Ron Hubbard, Dianetics, books, videos and news.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The main Church of Scientology website. It describes Scientologists'' beliefs and practices, founder L. Ron Hubbard, Dianetics, churches around the world and the organization''s social programs. It includes videos, photos, books, news and links to the Scientology Network channel. Available in more than a dozen languages, including Russian.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Beliefs and practices
About L. Ron Hubbard
Videos and books
Over 10 languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to learn about Scientology from the source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Dianetics — Саєнтологія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dianetics.org' OR LOWER(`name`) = LOWER('Dianetics'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Dianetics', NULL, 'https://www.dianetics.org', NULL, NULL, 'Офіційний сайт книги Л. Рона Габбарда «Діанетика» (1950): про книгу та автора, замовлення друкованої й аудіоверсії, набір «How-To Kit», семінари й центри.', 'The official site of L. Ron Hubbard''s 1950 book Dianetics: about the book and author, ordering print and audio editions, a How-To Kit, seminars and centers.', 'Сайт книги «Діанетика: сучасна наука душевного здоров''я» — базового тексту, на якому ґрунтується саєнтологія. Розповідає про автора, що таке діанетика за визначенням організації, історії читачів, семінари й центри по світу (Африка, Азія, Європа, Америка) та FAQ. Книгу в твердій, м''якій обкладинці чи аудіоформаті можна замовити напряму або в книгарнях; є набір «Book How-To Kit». Ціна книги — від 25 $ (на сайті, з безкоштовною доставкою).', 'The site of "Dianetics: The Modern Science of Mental Health", the foundational text Scientology is based on. It covers the author, what Dianetics is in the organization''s own terms, reader stories, seminars and centers worldwide (Africa, Asia, Europe, the Americas) and an FAQ. The book can be ordered in hardcover, paperback or audio directly or from booksellers; there is also a Book How-To Kit. The book costs from $25 on the site with free shipping.', 'Про книгу й автора
Друкована й аудіоверсія
Набір How-To Kit
Семінари й центри', 'About the book and author
Print and audio editions
How-To Kit
Seminars and centers', 'Читачі, які цікавляться діанетикою.', 'Readers interested in Dianetics.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dianetics.org' OR LOWER(`name`) = LOWER('Dianetics')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'scientology' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The official site of L. Ron Hubbard''s 1950 book Dianetics: about the book and author, ordering print and audio editions, a How-To Kit, seminars and centers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of "Dianetics: The Modern Science of Mental Health", the foundational text Scientology is based on. It covers the author, what Dianetics is in the organization''s own terms, reader stories, seminars and centers worldwide (Africa, Asia, Europe, the Americas) and an FAQ. The book can be ordered in hardcover, paperback or audio directly or from booksellers; there is also a Book How-To Kit. The book costs from $25 on the site with free shipping.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'About the book and author
Print and audio editions
How-To Kit
Seminars and centers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Readers interested in Dianetics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Книга', 'Book', 25.00, 'one_time', '«Діанетика», безкоштовна доставка', 'Dianetics, free shipping' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Книга' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Book', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Dianetics, free shipping', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- L. Ron Hubbard — Саєнтологія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lronhubbard.org' OR LOWER(`name`) = LOWER('L. Ron Hubbard'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'L. Ron Hubbard', NULL, 'https://www.lronhubbard.org', NULL, NULL, 'LRonHubbard.org — офіційний сайт про Л. Рона Габбарда, засновника діанетики й саєнтології: біографія, твори, відео, цитати й книги.', 'LRonHubbard.org is the official site about L. Ron Hubbard, founder of Dianetics and Scientology: biography, works, videos, quotes and books.', 'Сайт про життя й творчість Л. Рона Габбарда: профіль і вступна біографія, огляд його праць у сферах діанетики, саєнтології, літератури й інших напрямів, відео, цитати та посилання на придбання книг. Доступний багатьма мовами.', 'A site about the life and works of L. Ron Hubbard: a profile and introductory biography, an overview of his work in Dianetics, Scientology, literature and other fields, videos, quotes and links to buy books. Available in many languages.', 'Біографія
Огляд праць
Відео й цитати
Багато мов', 'Biography
Overview of works
Videos and quotes
Many languages', 'Ті, хто цікавиться засновником саєнтології.', 'People interested in Scientology''s founder.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lronhubbard.org' OR LOWER(`name`) = LOWER('L. Ron Hubbard')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'scientology' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'LRonHubbard.org is the official site about L. Ron Hubbard, founder of Dianetics and Scientology: biography, works, videos, quotes and books.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A site about the life and works of L. Ron Hubbard: a profile and introductory biography, an overview of his work in Dianetics, Scientology, literature and other fields, videos, quotes and links to buy books. Available in many languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Biography
Overview of works
Videos and quotes
Many languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People interested in Scientology''s founder.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- New Era Publications — Саєнтологія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'newerapublications.com' OR LOWER(`name`) = LOWER('New Era Publications'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'New Era Publications', NULL, 'https://www.newerapublications.com', NULL, NULL, 'New Era Publications — європейське видавництво матеріалів діанетики й саєнтології (Данія): книги, лекції, «The Basics», ціни в євро.', 'New Era Publications is the European publisher of Dianetics and Scientology materials (Denmark): books, lectures, The Basics, prices in euros.', 'Видавництво New Era Publications International ApS із Данії випускає та продає матеріали діанетики й саєнтології для Європи та інших регіонів. Каталог аналогічний Bridge Publications: вступні книги, класичні лекції, серія «The Basics», конгреси, клінічні курси та пакети. Книги в м''якій обкладинці — від 17 €, пакети — від 150 €. Сайт багатомовний.', 'New Era Publications International ApS in Denmark publishes and sells Dianetics and Scientology materials for Europe and other regions. The catalog mirrors Bridge Publications: beginning books, classic lectures, The Basics series, congresses, clinical courses and packages. Paperbacks start at €17, packages at €150. The site is multilingual.', 'Книги й лекції
Серія «The Basics»
Ціни в євро
Багато мов', 'Books and lectures
The Basics series
Prices in euros
Many languages', 'Читачі саєнтології в Європі.', 'Scientology readers in Europe.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'newerapublications.com' OR LOWER(`name`) = LOWER('New Era Publications')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'scientology' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'New Era Publications is the European publisher of Dianetics and Scientology materials (Denmark): books, lectures, The Basics, prices in euros.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'New Era Publications International ApS in Denmark publishes and sells Dianetics and Scientology materials for Europe and other regions. The catalog mirrors Bridge Publications: beginning books, classic lectures, The Basics series, congresses, clinical courses and packages. Paperbacks start at €17, packages at €150. The site is multilingual.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Books and lectures
The Basics series
Prices in euros
Many languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Scientology readers in Europe.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Книга в м''якій обкладинці', 'Paperback', 17.00, 'one_time', 'Від 17 €', 'From €17' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Книга в м''якій обкладинці' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paperback', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'From €17', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Scientology Network — Саєнтологія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'scientology.tv' OR LOWER(`name`) = LOWER('Scientology Network'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Scientology Network', NULL, 'https://www.scientology.tv', NULL, NULL, 'Scientology Network — телеканал і відео на запит Церкви саєнтології: цілодобові власні програми онлайн, на DIRECTV, Apple TV, Roku, fireTV і в застосунках.', 'Scientology Network is the Church of Scientology''s TV channel and video on demand: 24/7 original programming online, on DIRECTV, Apple TV, Roku, fireTV and apps.', 'Телеканал Церкви саєнтології з власними програмами, доступний цілодобово на Scientology.tv, DIRECTV (канал 320), DIRECTV STREAM, AT&T U-verse, Apple TV, Roku, fireTV, Chromecast, YouTube і в мобільних застосунках. Можна дивитися ефір і відео на запит, створити безкоштовний обліковий запис (зокрема через Google чи Facebook) і вбудовувати відео.', 'The Church of Scientology''s channel with original programming, available 24/7 on Scientology.tv, DIRECTV channel 320, DIRECTV STREAM, AT&T U-verse, Apple TV, Roku, fireTV, Chromecast, YouTube and mobile apps. You can watch live and on demand, create a free account (including with Google or Facebook) and embed videos.', 'Цілодобовий ефір
Відео на запит
Apple TV, Roku, fireTV
Безкоштовний акаунт', '24/7 channel
Video on demand
Apple TV, Roku, fireTV
Free account', 'Глядачі, які цікавляться саєнтологією.', 'Viewers interested in Scientology.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'scientology.tv' OR LOWER(`name`) = LOWER('Scientology Network')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'scientology' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Scientology Network is the Church of Scientology''s TV channel and video on demand: 24/7 original programming online, on DIRECTV, Apple TV, Roku, fireTV and apps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Church of Scientology''s channel with original programming, available 24/7 on Scientology.tv, DIRECTV channel 320, DIRECTV STREAM, AT&T U-verse, Apple TV, Roku, fireTV, Chromecast, YouTube and mobile apps. You can watch live and on demand, create a free account (including with Google or Facebook) and embed videos.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '24/7 channel
Video on demand
Apple TV, Roku, fireTV
Free account', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Viewers interested in Scientology.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Перегляд і акаунт', 'Viewing and account' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Viewing and account', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Scientology Volunteer Ministers — Саєнтологія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'volunteerministers.org' OR LOWER(`name`) = LOWER('Scientology Volunteer Ministers'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Scientology Volunteer Ministers', NULL, 'https://www.volunteerministers.org', NULL, NULL, 'Scientology Volunteer Ministers — сайт волонтерської програми Церкви саєнтології: допомога під час катастроф, безкоштовні онлайн-курси й посібники.', 'Scientology Volunteer Ministers is the Church of Scientology''s volunteer program site: disaster response, free online courses and handbooks.', 'Сайт волонтерської програми, заснованої Церквою саєнтології. Розповідає про участь волонтерів у реагуванні на катастрофи й громадські проєкти та пропонує безкоштовні онлайн-курси за «Довідником саєнтології» з практичних тем (спілкування, вирішення конфліктів, навчання тощо) і пошук найближчої групи волонтерів.', 'The site of the volunteer program founded by the Church of Scientology. It describes volunteers'' disaster response and community projects and offers free online courses based on the Scientology Handbook on practical topics (communication, conflict resolution, study and more) and a finder for local volunteer groups.', 'Безкоштовні онлайн-курси
Допомога під час катастроф
Пошук груп волонтерів', 'Free online courses
Disaster response
Volunteer group finder', 'Ті, хто цікавиться волонтерськими програмами саєнтології.', 'People interested in Scientology''s volunteer programs.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'volunteerministers.org' OR LOWER(`name`) = LOWER('Scientology Volunteer Ministers')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'scientology' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Scientology Volunteer Ministers is the Church of Scientology''s volunteer program site: disaster response, free online courses and handbooks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of the volunteer program founded by the Church of Scientology. It describes volunteers'' disaster response and community projects and offers free online courses based on the Scientology Handbook on practical topics (communication, conflict resolution, study and more) and a finder for local volunteer groups.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free online courses
Disaster response
Volunteer group finder', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People interested in Scientology''s volunteer programs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Онлайн-курси', 'Online courses', 0.00, 'free', 'Безкоштовно', 'Free' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Онлайн-курси' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Online courses', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- The Way to Happiness — Саєнтологія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thewaytohappiness.org' OR LOWER(`name`) = LOWER('The Way to Happiness'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'The Way to Happiness', NULL, 'https://www.thewaytohappiness.org', NULL, NULL, 'The Way to Happiness — сайт фонду, що поширює брошуру Л. Рона Габбарда «Шлях до щастя» з 21 моральним принципом: текст, відео й матеріали для поширення.', 'The Way to Happiness is the foundation site distributing L. Ron Hubbard''s booklet The Way to Happiness with 21 moral precepts: text, videos and distribution materials.', 'Сайт Міжнародного фонду «Шлях до щастя», підтримуваного саєнтологами. Публікує моральний кодекс Л. Рона Габбарда з 21 принципу, який позиціюється як нерелігійний; кожен принцип має текст і короткий відеоролик. Є матеріали для вчителів і волонтерів, замовлення брошур і багатомовні версії.', 'The site of The Way to Happiness Foundation International, supported by Scientologists. It publishes L. Ron Hubbard''s moral code of 21 precepts, presented as non-religious; each precept has text and a short video. There are materials for teachers and volunteers, booklet ordering and multilingual versions.', '21 моральний принцип
Відео до кожного принципу
Матеріали для вчителів
Багато мов', '21 moral precepts
A video per precept
Teacher materials
Many languages', 'Ті, хто цікавиться соціальними програмами саєнтології.', 'People interested in Scientology''s social programs.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thewaytohappiness.org' OR LOWER(`name`) = LOWER('The Way to Happiness')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'scientology' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Way to Happiness is the foundation site distributing L. Ron Hubbard''s booklet The Way to Happiness with 21 moral precepts: text, videos and distribution materials.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of The Way to Happiness Foundation International, supported by Scientologists. It publishes L. Ron Hubbard''s moral code of 21 precepts, presented as non-religious; each precept has text and a short video. There are materials for teachers and volunteers, booklet ordering and multilingual versions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '21 moral precepts
A video per precept
Teacher materials
Many languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People interested in Scientology''s social programs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Онлайн-текст і відео', 'Online text and videos' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Online text and videos', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Brahma Kumaris Australia — Брахма Кумаріс
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'brahmakumaris.org.au' OR LOWER(`name`) = LOWER('Brahma Kumaris Australia'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Brahma Kumaris Australia', NULL, 'https://brahmakumaris.org.au', NULL, NULL, 'Brahma Kumaris Australia — курси, класи й медитації, ретритні центри (Блакитні гори, Іллаварра, Ярра-Веллі), 7-денний курс поштою й книгарня.', 'Brahma Kumaris Australia offers courses, classes and meditations, retreat centres (Blue Mountains, Illawarra, Yarra Valley), a 7-day email course and a bookstore.', 'Австралійське відділення Брахма Кумаріс. Пропонує курси, класи й медитації (зокрема iMeditate Sydney, кімнату медитації, хвилинні медитації «Just a Minute», альбом Awakening), 7-денний курс електронною поштою, поглиблені класи, програми для дітей, ретритні центри в Блакитних горах, Іллаваррі, на півострові та в долині Ярра, мережу центрів і книгарню.', 'The Australian branch of Brahma Kumaris. It offers courses, classes and meditations (including iMeditate Sydney, a meditation room, Just a Minute meditations and the Awakening album), a 7-day email course, advanced classes, programs for children, retreat centres in the Blue Mountains, Illawarra, the Peninsula and Yarra Valley, a network of centres and a bookstore.', '7-денний курс поштою
Хвилинні медитації
Ретритні центри
Програми для дітей', '7-day email course
One-minute meditations
Retreat centres
Programs for children', 'Практики медитації в Австралії.', 'Meditation practitioners in Australia.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'brahmakumaris.org.au' OR LOWER(`name`) = LOWER('Brahma Kumaris Australia')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'brahma-kumaris' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Brahma Kumaris Australia offers courses, classes and meditations, retreat centres (Blue Mountains, Illawarra, Yarra Valley), a 7-day email course and a bookstore.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Australian branch of Brahma Kumaris. It offers courses, classes and meditations (including iMeditate Sydney, a meditation room, Just a Minute meditations and the Awakening album), a 7-day email course, advanced classes, programs for children, retreat centres in the Blue Mountains, Illawarra, the Peninsula and Yarra Valley, a network of centres and a bookstore.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '7-day email course
One-minute meditations
Retreat centres
Programs for children', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Meditation practitioners in Australia.', 'manual' FROM DUAL WHERE @new = 1;

-- Brahma Kumaris Canada — Брахма Кумаріс
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'brahmakumaris.ca' OR LOWER(`name`) = LOWER('Brahma Kumaris Canada'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Brahma Kumaris Canada', NULL, 'https://brahmakumaris.ca', NULL, NULL, 'Brahma Kumaris Canada — щоденні безкоштовні медитації раджа-йоги з коментарем і мовчазним спогляданням, онлайн-події й центри по всій Канаді.', 'Brahma Kumaris Canada offers free daily Raja Yoga meditations with guided commentary and silent contemplation, online events and centres across Canada.', 'Канадське відділення Брахма Кумаріс англійською та французькою. Пропонує щоденні безкоштовні медитації (з коментарем і мовчазним спогляданням) на теми спокою, чеснот і цінностей, онлайн-події, національні заходи, віртуальний центр і перелік центрів у Калгарі, Едмонтоні, Монреалі, Оттаві, Торонто, Ванкувері, Вінніпезі та інших містах.', 'The Canadian branch of Brahma Kumaris in English and French. It offers free daily meditations (guided commentary and silent contemplation) on peace, virtues and values, online events, national events, a virtual centre and a list of centres in Calgary, Edmonton, Montreal, Ottawa, Toronto, Vancouver, Winnipeg and other cities.', 'Щоденні медитації
Віртуальний центр
Англійська й французька
Центри по Канаді', 'Daily meditations
Virtual centre
English and French
Centres across Canada', 'Практики медитації в Канаді.', 'Meditation practitioners in Canada.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'brahmakumaris.ca' OR LOWER(`name`) = LOWER('Brahma Kumaris Canada')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'brahma-kumaris' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Brahma Kumaris Canada offers free daily Raja Yoga meditations with guided commentary and silent contemplation, online events and centres across Canada.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Canadian branch of Brahma Kumaris in English and French. It offers free daily meditations (guided commentary and silent contemplation) on peace, virtues and values, online events, national events, a virtual centre and a list of centres in Calgary, Edmonton, Montreal, Ottawa, Toronto, Vancouver, Winnipeg and other cities.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Daily meditations
Virtual centre
English and French
Centres across Canada', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Meditation practitioners in Canada.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Щоденні медитації', 'Daily meditations' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Daily meditations', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Brahma Kumaris India — Брахма Кумаріс
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'brahmakumaris.com' OR LOWER(`name`) = LOWER('Brahma Kumaris India'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Brahma Kumaris India', NULL, 'https://www.brahmakumaris.com', NULL, NULL, 'Офіційний сайт Брахма Кумаріс в Індії: медитація раджа-йоги, 7-денний курс духовного знання, пошук центрів, штаб-квартира Мадгубан, блоги й заходи.', 'The official Brahma Kumaris site in India: Rajyoga meditation, a 7-day spiritual knowledge course, centre locator, Madhuban headquarters, blogs and events.', 'Brahma Kumaris — всесвітній духовний рух, очолюваний жінками, присвячений особистій трансформації через медитацію раджа-йоги. Заснований в Індії 1937 року, представлений у понад 110 країнах і має статус міжнародної НУО. Сайт пропонує інформацію про медитацію, 7-денний курс, пошук центрів у штатах Індії й за кордоном, Мадгубан і ретритні центри, блоги «Soul Sustenance», ігри й історії, заходи, новини та соціальні проєкти.', 'Brahma Kumaris is a worldwide spiritual movement led by women, dedicated to personal transformation through Rajyoga meditation. Founded in India in 1937, it is present in over 110 countries and is an international NGO. The site covers meditation, the 7-day course, a centre locator across Indian states and abroad, Madhuban and retreat centres, Soul Sustenance blogs, games and stories, events, news and social projects.', 'Медитація раджа-йоги
7-денний курс
Пошук центрів
Понад 110 країн', 'Rajyoga meditation
7-day course
Centre locator
Over 110 countries', 'Ті, хто хоче навчитися медитації раджа-йоги.', 'People who want to learn Rajyoga meditation.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'brahmakumaris.com' OR LOWER(`name`) = LOWER('Brahma Kumaris India')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'brahma-kumaris' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The official Brahma Kumaris site in India: Rajyoga meditation, a 7-day spiritual knowledge course, centre locator, Madhuban headquarters, blogs and events.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Brahma Kumaris is a worldwide spiritual movement led by women, dedicated to personal transformation through Rajyoga meditation. Founded in India in 1937, it is present in over 110 countries and is an international NGO. The site covers meditation, the 7-day course, a centre locator across Indian states and abroad, Madhuban and retreat centres, Soul Sustenance blogs, games and stories, events, news and social projects.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Rajyoga meditation
7-day course
Centre locator
Over 110 countries', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to learn Rajyoga meditation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Курси безкоштовні', 'Courses are free' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Courses are free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Brahma Kumaris UK — Брахма Кумаріс
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'brahmakumaris.uk' OR LOWER(`name`) = LOWER('Brahma Kumaris UK'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Brahma Kumaris UK', NULL, 'https://brahmakumaris.uk', NULL, NULL, 'Brahma Kumaris UK (Всесвітній духовний університет) — медитація раджа-йоги: як і коли медитувати, події, курси, застосунки, прямі трансляції й e-learning.', 'Brahma Kumaris UK (World Spiritual University) teaches Raja Yoga meditation: how and when to meditate, events, courses, apps, live streams and e-learning.', 'Британське відділення Брахма Кумаріс. Пояснює, що таке раджа-йога, навіщо, як і коли медитувати, відповідає на часті запитання. Пропонує події й курси, спільноту, ресурси, застосунки, аудіо для прослуховування, відео й прямі трансляції, e-learning і блог.', 'The UK branch of Brahma Kumaris. It explains Raja Yoga and why, how and when to meditate, with a meditation FAQ. It offers events and courses, community, resources, apps, audio to listen to, video and live streams, e-learning and a blog.', 'Як медитувати
Курси й події
Застосунки
Прямі трансляції
E-learning', 'How to meditate
Courses and events
Apps
Live streams
E-learning', 'Початківці й практики медитації у Великій Британії.', 'Meditation beginners and practitioners in the UK.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'brahmakumaris.uk' OR LOWER(`name`) = LOWER('Brahma Kumaris UK')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'brahma-kumaris' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Brahma Kumaris UK (World Spiritual University) teaches Raja Yoga meditation: how and when to meditate, events, courses, apps, live streams and e-learning.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The UK branch of Brahma Kumaris. It explains Raja Yoga and why, how and when to meditate, with a meditation FAQ. It offers events and courses, community, resources, apps, audio to listen to, video and live streams, e-learning and a blog.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'How to meditate
Courses and events
Apps
Live streams
E-learning', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Meditation beginners and practitioners in the UK.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Курси й медитації', 'Courses and meditations' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Courses and meditations', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Brahma Kumaris USA — Брахма Кумаріс
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'brahmakumaris.us' OR LOWER(`name`) = LOWER('Brahma Kumaris USA'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Brahma Kumaris USA', NULL, 'https://brahmakumaris.us', NULL, NULL, 'Brahma Kumaris USA — медитація й рефлексія: події, медитації й музика, відео й подкасти, e-learning, рецепти, книги, застосунки та адреси центрів.', 'Brahma Kumaris USA offers meditation and reflection: events, meditation and music, videos and podcasts, e-learning, recipes, books, apps and centre locations.', 'Сайт Брахма Кумаріс у США. Ресурси: медитації й музика, відео й подкасти, e-learning, екологічна розсилка, статті й блоги, рецепти, книги й публікації, застосунки та адреси центрів. Розділ «Про нас» розповідає про рух у світі, штаб-квартиру, історію, роботу в ООН, ініціативи й партнерства.', 'The Brahma Kumaris site in the USA. Resources include meditation and music, videos and podcasts, e-learning, an environmental newsletter, articles and blogs, recipes, books and publications, apps and centre locations. The About section covers the worldwide movement, headquarters, history, UN work, initiatives and partnerships.', 'Медитації й музика
Відео й подкасти
E-learning
Застосунки', 'Meditation and music
Videos and podcasts
E-learning
Apps', 'Ті, хто практикує медитацію в США.', 'Meditation practitioners in the USA.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'brahmakumaris.us' OR LOWER(`name`) = LOWER('Brahma Kumaris USA')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'brahma-kumaris' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Brahma Kumaris USA offers meditation and reflection: events, meditation and music, videos and podcasts, e-learning, recipes, books, apps and centre locations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Brahma Kumaris site in the USA. Resources include meditation and music, videos and podcasts, e-learning, an environmental newsletter, articles and blogs, recipes, books and publications, apps and centre locations. The About section covers the worldwide movement, headquarters, history, UN work, initiatives and partnerships.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Meditation and music
Videos and podcasts
E-learning
Apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Meditation practitioners in the USA.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Learn Meditation Online — Брахма Кумаріс
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'learnmeditationonline.org' OR LOWER(`name`) = LOWER('Learn Meditation Online'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Learn Meditation Online', NULL, 'https://www.learnmeditationonline.org', NULL, NULL, 'Learn Meditation Online — безкоштовний курс медитації Брахма Кумаріс із 7 уроків: тексти, аудіо, відео, друк і завантаження кількома мовами.', 'Learn Meditation Online is a free 7-lesson Brahma Kumaris meditation course with text, audio, video, printing and downloads in several languages.', 'Сайт безкоштовного курсу медитації BK із семи уроків для тих, хто пробує медитацію вперше, і для досвідчених практиків. Уроки можна читати онлайн, завантажити, роздрукувати, слухати в аудіо або дивитися відео; є розділ «Медитувати зараз» і FAQ. Мови: англійська, корейська, японська, німецька, французька, шведська, лаоська.', 'A site with a free seven-lesson BK meditation course for first-timers and regular meditators alike. Lessons can be read online, downloaded, printed, listened to as audio or watched as video; there is a Meditate Now section and FAQs. Languages: English, Korean, Japanese, German, French, Swedish and Lao.', '7 уроків
Аудіо й відео
Друк і завантаження
Сім мов', '7 lessons
Audio and video
Print and download
Seven languages', 'Початківці в медитації.', 'Meditation beginners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'learnmeditationonline.org' OR LOWER(`name`) = LOWER('Learn Meditation Online')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'brahma-kumaris' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Learn Meditation Online is a free 7-lesson Brahma Kumaris meditation course with text, audio, video, printing and downloads in several languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A site with a free seven-lesson BK meditation course for first-timers and regular meditators alike. Lessons can be read online, downloaded, printed, listened to as audio or watched as video; there is a Meditate Now section and FAQs. Languages: English, Korean, Japanese, German, French, Swedish and Lao.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '7 lessons
Audio and video
Print and download
Seven languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Meditation beginners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Повний курс', 'Full course' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Full course', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Madhuban Murli — Брахма Кумаріс
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'madhubanmurli.org' OR LOWER(`name`) = LOWER('Madhuban Murli'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Madhuban Murli', NULL, 'https://www.madhubanmurli.org', NULL, NULL, 'Madhuban Murli — офіційна щоденна мурлі Брахма Кумаріс: текст ранкової мурлі, PDF, аудіо, стислий зміст і кілька мов.', 'Madhuban Murli is the official Brahma Kumaris daily murli: morning murli text, PDF, audio, an essence summary and several languages.', 'Офіційне джерело щоденної мурлі (повчання) Брахма Кумаріс із Мадгубана. Щодня публікується текст ранкової мурлі, його можна завантажити в PDF, прослухати чи завантажити аудіо гінді (зокрема мадгубанську версію), стислий зміст (essence) і практичне завдання. Доступні кілька мов.', 'The official source of the Brahma Kumaris daily murli (teaching) from Madhuban. The morning murli text is published daily and can be downloaded as PDF; Hindi audio (including the Madhuban version), an essence summary and a practical exercise can be played or downloaded. Several languages are available.', 'Щоденна мурлі
PDF і аудіо
Стислий зміст
Кілька мов', 'Daily murli
PDF and audio
Essence summary
Several languages', 'Учні Брахма Кумаріс.', 'Brahma Kumaris students.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'madhubanmurli.org' OR LOWER(`name`) = LOWER('Madhuban Murli')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'brahma-kumaris' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Madhuban Murli is the official Brahma Kumaris daily murli: morning murli text, PDF, audio, an essence summary and several languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The official source of the Brahma Kumaris daily murli (teaching) from Madhuban. The morning murli text is published daily and can be downloaded as PDF; Hindi audio (including the Madhuban version), an essence summary and a practical exercise can be played or downloaded. Several languages are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Daily murli
PDF and audio
Essence summary
Several languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Brahma Kumaris students.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Текст і аудіо', 'Text and audio' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Text and audio', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Bharat Soka Gakkai — Сока Гаккай
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bharatsokagakkai.org' OR LOWER(`name`) = LOWER('Bharat Soka Gakkai'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bharat Soka Gakkai', NULL, 'https://www.bharatsokagakkai.org', NULL, NULL, 'Bharat Soka Gakkai — індійська організація Сока Гаккай: мир, культура й освіта, культурні центри, виставки Seeds of Hope, застосунок BSG for SDG.', 'Bharat Soka Gakkai is the Indian Soka Gakkai organization: peace, culture and education, culture centres, Seeds of Hope exhibitions and the BSG for SDG app.', 'Організація, що займається миром, культурою й освітою на основі гуманістичної філософії буддизму. Сайт розповідає про BSG, сад Сока Бодгі, культурні центри, діяльність для кожної людини й суспільства, діалоги й події, виставки Seeds of Hope & Action, гуманітарні ініціативи, культурні виступи та освітні програми. Пропонує застосунок BSG for SDG і SDG-клуби.', 'An organization engaged in peace, culture and education based on the humanistic philosophy of Buddhism. The site covers BSG, the Soka Bodhi Tree Garden, culture centres, work for individuals and society, dialogues and events, Seeds of Hope & Action exhibitions, humanitarian activities, cultural performances and education. It offers the BSG for SDG app and SDG clubs.', 'Застосунок BSG for SDG
Виставки Seeds of Hope
Культурні центри
Діалоги й події', 'BSG for SDG app
Seeds of Hope exhibitions
Culture centres
Dialogues and events', 'Члени й зацікавлені в Індії.', 'Members and interested people in India.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bharatsokagakkai.org' OR LOWER(`name`) = LOWER('Bharat Soka Gakkai')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'soka-gakkai' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Bharat Soka Gakkai is the Indian Soka Gakkai organization: peace, culture and education, culture centres, Seeds of Hope exhibitions and the BSG for SDG app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An organization engaged in peace, culture and education based on the humanistic philosophy of Buddhism. The site covers BSG, the Soka Bodhi Tree Garden, culture centres, work for individuals and society, dialogues and events, Seeds of Hope & Action exhibitions, humanitarian activities, cultural performances and education. It offers the BSG for SDG app and SDG clubs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'BSG for SDG app
Seeds of Hope exhibitions
Culture centres
Dialogues and events', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Members and interested people in India.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- BSGI (Brasil Soka Gakkai) — Сока Гаккай
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bsgi.org.br' OR LOWER(`name`) = LOWER('BSGI (Brasil Soka Gakkai)'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'BSGI (Brasil Soka Gakkai)', NULL, 'https://www.bsgi.org.br', NULL, NULL, 'BSGI — асоціація Сока Гаккай у Бразилії (з 1960 р.): філософія, мистецтво й культура, освіта Сока, сталий розвиток, молодь, публікації й пошук центрів.', 'BSGI is the Soka Gakkai association in Brazil (since 1960): philosophy, arts and culture, Soka education, sustainability, youth, publications and a centre finder.', 'Associação Brasil SGI з 1960 року сприяє розвитку людини задля культури миру. Сайт португальською: «Почніть тут», про асоціацію, філософія, мистецтво й культура, освіта Сока, сталий розвиток, молодь, новини, публікації, пошук центрів, екстранет для членів і режими доступності (збільшення шрифту, висока контрастність).', 'Associação Brasil SGI has promoted human development toward a culture of peace since 1960. The Portuguese site includes Start Here, about the association, philosophy, arts and culture, Soka education, sustainability, youth, news, publications, a centre finder, a member extranet and accessibility modes (larger font, high contrast).', 'Філософія й культура
Освіта Сока
Пошук центрів
Режими доступності', 'Philosophy and culture
Soka education
Centre finder
Accessibility modes', 'Португаломовні члени й зацікавлені.', 'Portuguese-speaking members and newcomers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bsgi.org.br' OR LOWER(`name`) = LOWER('BSGI (Brasil Soka Gakkai)')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'soka-gakkai' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'BSGI is the Soka Gakkai association in Brazil (since 1960): philosophy, arts and culture, Soka education, sustainability, youth, publications and a centre finder.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Associação Brasil SGI has promoted human development toward a culture of peace since 1960. The Portuguese site includes Start Here, about the association, philosophy, arts and culture, Soka education, sustainability, youth, news, publications, a centre finder, a member extranet and accessibility modes (larger font, high contrast).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Philosophy and culture
Soka education
Centre finder
Accessibility modes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Portuguese-speaking members and newcomers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Daisaku Ikeda Website — Сока Гаккай
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'daisakuikeda.org' OR LOWER(`name`) = LOWER('Daisaku Ikeda Website'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Daisaku Ikeda Website', NULL, 'https://www.daisakuikeda.org', NULL, NULL, 'Офіційний сайт Дайсаку Ікеди, буддійського філософа й третього президента Сока Гаккай: біографія, праці, мирні пропозиції та діалоги.', 'The official site of Daisaku Ikeda, Buddhist philosopher and third president of Soka Gakkai: biography, writings, peace proposals and dialogues.', 'Сайт про Дайсаку Ікеду, який присвятив життя миробудуванню через діалог. Містить детальну біографію (раннє життя, зустріч із наставником, президентство, глобальне бачення, діалоги по десятиліттях), праці, мирні пропозиції й розмови з діячами світу. Мови: англійська, іспанська, китайська (традиційна й спрощена).', 'A site about Daisaku Ikeda, who devoted his life to building peace through dialogue. It has a detailed biography (early life, meeting his mentor, presidency, global vision, dialogues by decade), writings, peace proposals and conversations with world figures. Languages: English, Spanish and Chinese (traditional and simplified).', 'Детальна біографія
Мирні пропозиції
Діалоги
Чотири мовні версії', 'Detailed biography
Peace proposals
Dialogues
Four language versions', 'Читачі праць Ікеди та члени SGI.', 'Readers of Ikeda''s works and SGI members.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'daisakuikeda.org' OR LOWER(`name`) = LOWER('Daisaku Ikeda Website')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'soka-gakkai' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The official site of Daisaku Ikeda, Buddhist philosopher and third president of Soka Gakkai: biography, writings, peace proposals and dialogues.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A site about Daisaku Ikeda, who devoted his life to building peace through dialogue. It has a detailed biography (early life, meeting his mentor, presidency, global vision, dialogues by decade), writings, peace proposals and conversations with world figures. Languages: English, Spanish and Chinese (traditional and simplified).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Detailed biography
Peace proposals
Dialogues
Four language versions', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Readers of Ikeda''s works and SGI members.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Ikeda Center for Peace, Learning, and Dialogue — Сока Гаккай
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ikedacenter.org' OR LOWER(`name`) = LOWER('Ikeda Center for Peace, Learning, and Dialogue'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ikeda Center for Peace, Learning, and Dialogue', NULL, 'https://www.ikedacenter.org', NULL, NULL, 'Ikeda Center — центр миру, навчання й діалогу, заснований Дайсаку Ікедою: Ikeda Forum, вечори діалогу, семінари, освітні конференції й книги.', 'The Ikeda Center for Peace, Learning, and Dialogue, founded by Daisaku Ikeda, runs the Ikeda Forum, Dialogue Nights, seminars, education conferences and books.', 'Центр, натхненний переконаннями засновника Дайсаку Ікеди, вважає діалог на основі буддійського гуманізму шляхом до миру. Програми: Ikeda Forum, Dialogue Nights і Dialogue Nights Lite, Indigo Talks, семінари Global Citizens, конференція Educating for Peace, молодіжний комітет і стипендіати. Ресурси: лекції засновника, дослідження освіти Ікеди/Сока, бібліографія, книги та книжковий клуб.', 'Inspired by founder Daisaku Ikeda''s convictions, the center sees dialogue grounded in Buddhist humanism as a path to peace. Programs include the Ikeda Forum, Dialogue Nights and Dialogue Nights Lite, Indigo Talks, the Global Citizens Seminar Series, the Educating for Peace conference, a youth committee and education fellows. Resources include the founder''s lectures, Ikeda/Soka studies in education, a bibliography, books and a book club.', 'Ikeda Forum
Вечори діалогу
Освітня конференція
Книги й бібліографія', 'Ikeda Forum
Dialogue Nights
Education conference
Books and bibliography', 'Науковці, педагоги й миротворці.', 'Scholars, educators and peacebuilders.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ikedacenter.org' OR LOWER(`name`) = LOWER('Ikeda Center for Peace, Learning, and Dialogue')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'soka-gakkai' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Ikeda Center for Peace, Learning, and Dialogue, founded by Daisaku Ikeda, runs the Ikeda Forum, Dialogue Nights, seminars, education conferences and books.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Inspired by founder Daisaku Ikeda''s convictions, the center sees dialogue grounded in Buddhist humanism as a path to peace. Programs include the Ikeda Forum, Dialogue Nights and Dialogue Nights Lite, Indigo Talks, the Global Citizens Seminar Series, the Educating for Peace conference, a youth committee and education fellows. Resources include the founder''s lectures, Ikeda/Soka studies in education, a bibliography, books and a book club.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Ikeda Forum
Dialogue Nights
Education conference
Books and bibliography', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Scholars, educators and peacebuilders.', 'manual' FROM DUAL WHERE @new = 1;

-- Nichiren Buddhism Library — Сока Гаккай
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nichirenlibrary.org' OR LOWER(`name`) = LOWER('Nichiren Buddhism Library'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Nichiren Buddhism Library', NULL, 'https://www.nichirenlibrary.org', NULL, NULL, 'Nichiren Buddhism Library (Сока Гаккай) — пошукова онлайн-бібліотека англійських перекладів писань Нітірена, Лотосової сутри та коментарів.', 'The Nichiren Buddhism Library (Soka Gakkai) is a searchable online library of English translations of Nichiren''s writings, the Lotus Sutra and commentaries.', 'Бібліотека Сока Гаккай відкрито надає в пошуковому вигляді основні англомовні переклади текстів буддизму Нітірена: «Писання Нітірена Дайсьоніна» (томи 1 і 2), «Лотосову сутру з вступною та заключною сутрами» та коментар до Лотосової сутри, а також словник. Сайт адаптований для смартфонів.', 'The Soka Gakkai library makes the key English translations of Nichiren Buddhist texts available in searchable form: The Writings of Nichiren Daishonin (volumes 1 and 2), The Lotus Sutra and Its Opening and Closing Sutras and the Lotus Sutra commentary, plus a dictionary. The site is smartphone-friendly.', 'Писання Нітірена
Лотосова сутра
Повнотекстовий пошук
Для смартфонів', 'Writings of Nichiren
Lotus Sutra
Full-text search
Smartphone-friendly', 'Ті, хто вивчає буддизм Нітірена.', 'People studying Nichiren Buddhism.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nichirenlibrary.org' OR LOWER(`name`) = LOWER('Nichiren Buddhism Library')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'soka-gakkai' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Nichiren Buddhism Library (Soka Gakkai) is a searchable online library of English translations of Nichiren''s writings, the Lotus Sutra and commentaries.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Soka Gakkai library makes the key English translations of Nichiren Buddhist texts available in searchable form: The Writings of Nichiren Daishonin (volumes 1 and 2), The Lotus Sutra and Its Opening and Closing Sutras and the Lotus Sutra commentary, plus a dictionary. The site is smartphone-friendly.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Writings of Nichiren
Lotus Sutra
Full-text search
Smartphone-friendly', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People studying Nichiren Buddhism.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SGI Canada — Сока Гаккай
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sgicanada.org' OR LOWER(`name`) = LOWER('SGI Canada'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SGI Canada', NULL, 'https://www.sgicanada.org', NULL, NULL, 'SGI Canada — Сока Гаккай Інтернешнл у Канаді: про SGI, центри, вступні матеріали, історія буддизму, писання Нітірена й особисті історії; англійська й французька.', 'SGI Canada is Soka Gakkai International in Canada: about SGI, centres, introductory materials, history of Buddhism, Nichiren''s writings and personal experiences; English and French.', 'Сайт Асоціації Сока Гаккай Інтернешнл Канади з гаслом «Буддійський гуманізм: мир, культура й освіта». Містить інформацію про SGI й SGI Canada, центри, поширені запитання, вступні матеріали, історію буддизму, писання Нітірена Дайсьоніна, «Єдність через різноманіття» та особисті історії. Є онлайн-портал для членів і французька версія.', 'The site of the Soka Gakkai International Association of Canada with the motto "Buddhist Humanism: Peace, Culture & Education". It covers SGI and SGI Canada, centres, common questions, introductory materials, the history of Buddhism, the writings of Nichiren Daishonin, Unity Through Diversity and personal experiences. There is an online member portal and a French version.', 'Вступні матеріали
Центри по Канаді
Онлайн-портал
Англійська й французька', 'Introductory materials
Centres across Canada
Online portal
English and French', 'Зацікавлені буддизмом у Канаді.', 'People interested in Buddhism in Canada.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sgicanada.org' OR LOWER(`name`) = LOWER('SGI Canada')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'soka-gakkai' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'SGI Canada is Soka Gakkai International in Canada: about SGI, centres, introductory materials, history of Buddhism, Nichiren''s writings and personal experiences; English and French.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of the Soka Gakkai International Association of Canada with the motto "Buddhist Humanism: Peace, Culture & Education". It covers SGI and SGI Canada, centres, common questions, introductory materials, the history of Buddhism, the writings of Nichiren Daishonin, Unity Through Diversity and personal experiences. There is an online member portal and a French version.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Introductory materials
Centres across Canada
Online portal
English and French', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People interested in Buddhism in Canada.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SGI-UK — Сока Гаккай
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sgi-uk.org' OR LOWER(`name`) = LOWER('SGI-UK'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SGI-UK', NULL, 'https://sgi-uk.org', NULL, NULL, 'SGI-UK — буддизм Нітірена у Великій Британії: філософія, пошук місцевих зустрічей, громадські проєкти, участь у COP, крамниця та центр Taplow Court.', 'SGI-UK presents Nichiren Buddhism in the UK: philosophy, a local meeting finder, community projects, COP participation, a shop and the Taplow Court centre.', 'Сайт британського відділення Сока Гаккай із гаслом «Буддизм у дії заради миру». Пояснює філософію й практику оспівування, допомагає знайти місцеву зустріч, розповідає про громадські проєкти, участь SGI у кліматичних конференціях COP, крамницю та центр Taplow Court.', 'The site of Soka Gakkai''s UK branch with the motto "Buddhism in action for peace". It explains the philosophy and practice of chanting, helps you find a local meeting and covers community projects, SGI''s participation in COP climate conferences, the shop and the Taplow Court centre.', 'Пошук місцевих зустрічей
Філософія практики
Громадські проєкти
Taplow Court', 'Local meeting finder
Practice philosophy
Community projects
Taplow Court', 'Зацікавлені буддизмом у Великій Британії.', 'People interested in Buddhism in the UK.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sgi-uk.org' OR LOWER(`name`) = LOWER('SGI-UK')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'soka-gakkai' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'SGI-UK presents Nichiren Buddhism in the UK: philosophy, a local meeting finder, community projects, COP participation, a shop and the Taplow Court centre.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of Soka Gakkai''s UK branch with the motto "Buddhism in action for peace". It explains the philosophy and practice of chanting, helps you find a local meeting and covers community projects, SGI''s participation in COP climate conferences, the shop and the Taplow Court centre.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Local meeting finder
Practice philosophy
Community projects
Taplow Court', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People interested in Buddhism in the UK.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SGI-USA — Сока Гаккай
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sgi-usa.org' OR LOWER(`name`) = LOWER('SGI-USA'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SGI-USA', NULL, 'https://www.sgi-usa.org', NULL, NULL, 'SGI-USA — американська громада буддизму Нітірена: основи практики, життєві історії, подкаст Buddhability, публікації й ресурси для членів.', 'SGI-USA is the US Nichiren Buddhist community: basics of practice, life stories, the Buddhability podcast, publications and member resources.', 'Сайт Сока Гаккай Інтернешнл у США, що описує себе як найрізноманітнішу буддійську громаду країни. Розділи: буддизм у повсякденні (основи практики, спільнота, життєві історії), буддійський гуманізм і Лотосова сутра, глобальне громадянство й мирні пропозиції. Є щотижневий подкаст Buddhability, публікації SGI-USA і ресурси для членів.', 'The site of Soka Gakkai International in the USA, which describes itself as the country''s most diverse Buddhist community. Sections cover Buddhism for daily life (basics of practice, community, life stories), Buddhist humanism and the Lotus Sutra, global citizenship and peace proposals. There is the weekly Buddhability podcast, SGI-USA publications and member resources.', 'Основи практики
Подкаст Buddhability
Життєві історії
Ресурси для членів', 'Basics of practice
Buddhability podcast
Life stories
Member resources', 'Практики буддизму Нітірена в США.', 'Nichiren Buddhist practitioners in the USA.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sgi-usa.org' OR LOWER(`name`) = LOWER('SGI-USA')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'soka-gakkai' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'SGI-USA is the US Nichiren Buddhist community: basics of practice, life stories, the Buddhability podcast, publications and member resources.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of Soka Gakkai International in the USA, which describes itself as the country''s most diverse Buddhist community. Sections cover Buddhism for daily life (basics of practice, community, life stories), Buddhist humanism and the Lotus Sutra, global citizenship and peace proposals. There is the weekly Buddhability podcast, SGI-USA publications and member resources.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Basics of practice
Buddhability podcast
Life stories
Member resources', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Nichiren Buddhist practitioners in the USA.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Soka Gakkai Deutschland — Сока Гаккай
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sokagakkai.de' OR LOWER(`name`) = LOWER('Soka Gakkai Deutschland'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Soka Gakkai Deutschland', NULL, 'https://www.sokagakkai.de', NULL, NULL, 'Soka Gakkai in Deutschland — буддійська спільнота в Німеччині: коріння, історія, президенти-засновники, буддійська практика й філософія, новини та вхід для членів.', 'Soka Gakkai in Deutschland is the Buddhist community in Germany: roots, history, founding presidents, Buddhist practice and philosophy, news and a member login.', 'Німецький сайт Сока Гаккай, буддійської спільноти, що працює заради миру, культури й освіти та, за її даними, налічує близько 12 млн членів у світі; як НУО пов''язана з ООН. Розділи: про нас (коріння, історія, президенти-засновники, спільнота сьогодні), буддизм (практика, філософія, досвід), актуальне, буддизм у повсякденні та особистий кабінет для членів.', 'The German site of Soka Gakkai, a Buddhist community working for peace, culture and education with, by its own count, about 12 million members worldwide; as an NGO it is affiliated with the UN. Sections cover about us (roots, history, founding presidents, the community today), Buddhism (practice, philosophy, experiences), news, Buddhism in daily life and a member area.', 'Буддійська практика
Філософія
Новини спільноти
Кабінет для членів', 'Buddhist practice
Philosophy
Community news
Member area', 'Німецькомовні члени й зацікавлені.', 'German-speaking members and newcomers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sokagakkai.de' OR LOWER(`name`) = LOWER('Soka Gakkai Deutschland')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'soka-gakkai' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Soka Gakkai in Deutschland is the Buddhist community in Germany: roots, history, founding presidents, Buddhist practice and philosophy, news and a member login.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The German site of Soka Gakkai, a Buddhist community working for peace, culture and education with, by its own count, about 12 million members worldwide; as an NGO it is affiliated with the UN. Sections cover about us (roots, history, founding presidents, the community today), Buddhism (practice, philosophy, experiences), news, Buddhism in daily life and a member area.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Buddhist practice
Philosophy
Community news
Member area', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'German-speaking members and newcomers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Soka Gakkai International — Сока Гаккай
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sokaglobal.org' OR LOWER(`name`) = LOWER('Soka Gakkai International'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Soka Gakkai International', NULL, 'https://www.sokaglobal.org', NULL, NULL, 'Офіційний сайт Сока Гаккай — глобальної буддійської організації (буддизм Нітірена): історія, засновники, щоденна практика, Нам-мьохо-ренге-кьо та мир.', 'The official site of Soka Gakkai, a global community-based Buddhist organization (Nichiren Buddhism): history, founders, daily practice, Nam-myoho-renge-kyo and peace.', 'Головний сайт Сока Гаккай, яка пропагує мир на основі поваги до гідності життя. Розповідає про організацію, буддійську лінію (Шак''ямуні, Лотосова сутра, Нітірен), трьох засновників-президентів (Макіґуті, Тода, Ікеда), історію й статут, щоденну практику, Нам-мьохо-ренге-кьо, Ґохондзон і як читати мантру. Мови: англійська, іспанська, китайська, японська, французька.', 'The main site of Soka Gakkai, which promotes peace based on respect for the dignity of life. It covers the organization, its Buddhist lineage (Shakyamuni, the Lotus Sutra, Nichiren), the three founding presidents (Makiguchi, Toda, Ikeda), history and charter, daily practice, Nam-myoho-renge-kyo, the Gohonzon and how to chant. Languages: English, Spanish, Chinese, Japanese and French.', 'Про буддизм Нітірена
Щоденна практика
Історія й засновники
П''ять мов', 'About Nichiren Buddhism
Daily practice
History and founders
Five languages', 'Ті, хто цікавиться буддизмом Сока Гаккай.', 'People interested in Soka Gakkai Buddhism.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sokaglobal.org' OR LOWER(`name`) = LOWER('Soka Gakkai International')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'soka-gakkai' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The official site of Soka Gakkai, a global community-based Buddhist organization (Nichiren Buddhism): history, founders, daily practice, Nam-myoho-renge-kyo and peace.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The main site of Soka Gakkai, which promotes peace based on respect for the dignity of life. It covers the organization, its Buddhist lineage (Shakyamuni, the Lotus Sutra, Nichiren), the three founding presidents (Makiguchi, Toda, Ikeda), history and charter, daily practice, Nam-myoho-renge-kyo, the Gohonzon and how to chant. Languages: English, Spanish, Chinese, Japanese and French.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'About Nichiren Buddhism
Daily practice
History and founders
Five languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People interested in Soka Gakkai Buddhism.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Soka Gakkai Japan — Сока Гаккай
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sokagakkai.jp' OR LOWER(`name`) = LOWER('Soka Gakkai Japan'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Soka Gakkai Japan', NULL, 'https://www.sokagakkai.jp', NULL, NULL, 'Офіційний японський сайт Сока Гаккай: вчення й основи, щоденна практика (ґонґьо, дайтоку), три президенти, мир, культура й освіта, пошук у Ґосьо.', 'The official Japanese Soka Gakkai site: teachings and basics, daily practice (gongyo, daimoku), the three presidents, peace, culture and education, and Gosho search.', 'Сайт Сока Гаккай японською. Розповідає про вчення (людська революція, молитва, Ґохондзон, писання, вступ до буддизму Нітірена), трьох президентів, щоденну практику (ранкова й вечірня ґонґьо, зібрання, вивчення), діяльність у сферах миру, прав людини, ЦСР, гуманітарної допомоги, музики й освіти, організацію в 192 країнах. Для членів — підтримка, онлайн-лекції Ґосьо, романи «Нова людська революція» й пошук по Ґосьо.', 'The Soka Gakkai site in Japanese. It covers teachings (human revolution, prayer, the Gohonzon, scriptures, an introduction to Nichiren Buddhism), the three presidents, daily practice (morning and evening gongyo, discussion meetings, study), work on peace, human rights, SDGs, humanitarian aid, music and education, and the organization in 192 countries. Members get support, online Gosho lectures, The New Human Revolution novels and Gosho search.', 'Вчення й практика
Пошук по Ґосьо
Онлайн-лекції
Японською', 'Teachings and practice
Gosho search
Online lectures
In Japanese', 'Члени Сока Гаккай та японськомовні читачі.', 'Soka Gakkai members and Japanese-speaking readers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sokagakkai.jp' OR LOWER(`name`) = LOWER('Soka Gakkai Japan')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'soka-gakkai' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The official Japanese Soka Gakkai site: teachings and basics, daily practice (gongyo, daimoku), the three presidents, peace, culture and education, and Gosho search.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Soka Gakkai site in Japanese. It covers teachings (human revolution, prayer, the Gohonzon, scriptures, an introduction to Nichiren Buddhism), the three presidents, daily practice (morning and evening gongyo, discussion meetings, study), work on peace, human rights, SDGs, humanitarian aid, music and education, and the organization in 192 countries. Members get support, online Gosho lectures, The New Human Revolution novels and Gosho search.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Teachings and practice
Gosho search
Online lectures
In Japanese', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Soka Gakkai members and Japanese-speaking readers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- David Lynch Foundation — Трансцендентальна медитація
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'davidlynchfoundation.org' OR LOWER(`name`) = LOWER('David Lynch Foundation'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'David Lynch Foundation', NULL, 'https://www.davidlynchfoundation.org', NULL, NULL, 'Фонд Девіда Лінча — благодійна програма навчання Трансцендентальної медитації для школярів, ветеранів, родин і громад, стипендії на курс ТМ.', 'The David Lynch Foundation funds Transcendental Meditation instruction for students, veterans, families and communities, including TM scholarships.', 'Фонд створено, щоб кожна дитина в Америці, яка хоче навчитися Трансцендентальної медитації, мала таку змогу. Програми охоплюють школи, ветеранів (21 to None), здорові сім''ї й громади, Центр стійкості; фонд пропонує стипендії на курс ТМ (зокрема постраждалим від пожеж у Лос-Анджелесі). На сайті — відео, події, дослідження, преса й способи підтримки.', 'The foundation was set up so any child in America who wants to learn Transcendental Meditation can do so. Programs cover schools, veterans (21 to None), healthy families and communities and a Center for Resilience; the foundation offers TM course scholarships (including for those affected by the LA fires). The site has videos, events, research, press and ways to give.', 'Стипендії на курс ТМ
Програми для шкіл
Програми для ветеранів
Відео й події', 'TM course scholarships
School programs
Veteran programs
Videos and events', 'Школи, ветерани й громади, що шукають фінансування навчання ТМ.', 'Schools, veterans and communities seeking TM funding.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'davidlynchfoundation.org' OR LOWER(`name`) = LOWER('David Lynch Foundation')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'transcendental-meditation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The David Lynch Foundation funds Transcendental Meditation instruction for students, veterans, families and communities, including TM scholarships.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The foundation was set up so any child in America who wants to learn Transcendental Meditation can do so. Programs cover schools, veterans (21 to None), healthy families and communities and a Center for Resilience; the foundation offers TM course scholarships (including for those affected by the LA fires). The site has videos, events, research, press and ways to give.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'TM course scholarships
School programs
Veteran programs
Videos and events', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Schools, veterans and communities seeking TM funding.', 'manual' FROM DUAL WHERE @new = 1;

-- Maharishi Channel — Трансцендентальна медитація
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'maharishichannel.in' OR LOWER(`name`) = LOWER('Maharishi Channel'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Maharishi Channel', NULL, 'https://maharishichannel.in', NULL, NULL, 'Maharishi Channel India — телеканали руху Махаріші: розклади каналів 3 і 5, ведичний календар, відеоархів, урочисті події й розсилка.', 'Maharishi Channel India runs the Maharishi movement''s channels: schedules for channels 3 and 5, a Vedic calendar, a video archive, celebrations and a newsletter.', 'Канал пропонує знання й програми, засновані на вченні Махаріші. На сайті — розклади каналів 3 і 5, дні ведичного календаря, відеоархіви обох каналів, особливі святкування, розсилки, чат «Maharishi Global Family» і можливість підтримати канал.', 'The channel offers knowledge and programs based on Maharishi''s teaching. The site has schedules for channels 3 and 5, Vedic calendar days, video archives of both channels, special celebrations, newsletters, a Maharishi Global Family chat and a way to contribute.', 'Розклади каналів
Ведичний календар
Відеоархів
Розсилка', 'Channel schedules
Vedic calendar
Video archive
Newsletter', 'Послідовники руху Махаріші.', 'Followers of the Maharishi movement.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'maharishichannel.in' OR LOWER(`name`) = LOWER('Maharishi Channel')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'transcendental-meditation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Maharishi Channel India runs the Maharishi movement''s channels: schedules for channels 3 and 5, a Vedic calendar, a video archive, celebrations and a newsletter.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The channel offers knowledge and programs based on Maharishi''s teaching. The site has schedules for channels 3 and 5, Vedic calendar days, video archives of both channels, special celebrations, newsletters, a Maharishi Global Family chat and a way to contribute.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Channel schedules
Vedic calendar
Video archive
Newsletter', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Followers of the Maharishi movement.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Перегляд онлайн', 'Watch online' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Watch online', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Maharishi Technologies of Consciousness — Трансцендентальна медитація
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'maharishi.org' OR LOWER(`name`) = LOWER('Maharishi Technologies of Consciousness'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Maharishi Technologies of Consciousness', NULL, 'https://www.maharishi.org', NULL, NULL, 'Maharishi Technologies of Consciousness — сайт про вчення й практики Махаріші Махеш Йоґі у сферах добробуту, науки, духовності й освіти.', 'Maharishi Technologies of Consciousness presents Maharishi Mahesh Yogi''s teachings and practices across wellness, science, spirituality and education.', 'Організація описує «технології свідомості» Махаріші як низку вчень і прикладних практик у сферах здоров''я й добробуту, науки, духовності та освіти, що поєднують сучасну науку й давнє знання. На сайті — історія, пояснення поняття свідомості, огляд практик і рада радників.', 'The organization describes Maharishi''s Technologies of Consciousness as a range of teachings and applied practices in health and wellness, science, spirituality and education, combining modern science and timeless knowledge. The site has its history, an explanation of consciousness, an overview of the practices and its advisors.', 'Огляд практик
Історія
Про свідомість
Радники', 'Practice overview
History
About consciousness
Advisors', 'Ті, хто цікавиться спадщиною Махаріші.', 'People interested in Maharishi''s legacy.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'maharishi.org' OR LOWER(`name`) = LOWER('Maharishi Technologies of Consciousness')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'transcendental-meditation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Maharishi Technologies of Consciousness presents Maharishi Mahesh Yogi''s teachings and practices across wellness, science, spirituality and education.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The organization describes Maharishi''s Technologies of Consciousness as a range of teachings and applied practices in health and wellness, science, spirituality and education, combining modern science and timeless knowledge. The site has its history, an explanation of consciousness, an overview of the practices and its advisors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Practice overview
History
About consciousness
Advisors', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People interested in Maharishi''s legacy.', 'manual' FROM DUAL WHERE @new = 1;

-- TM Women — Трансцендентальна медитація
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tm-women.org' OR LOWER(`name`) = LOWER('TM Women'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TM Women', NULL, 'https://tm-women.org', NULL, NULL, 'TM Women — жіноча організація, яка навчає Трансцендентальної медитації виключно жінок: про ТМ, структура й вартість курсу, ініціативи й пошук учительки.', 'TM Women is the women''s organization teaching Transcendental Meditation exclusively to women: about TM, course structure and fee, initiatives and a teacher finder.', 'Глобальна спільнота медитації «жінки для жінок». Пояснює, що таке ТМ і чим вона відрізняється, описує структуру курсу й вартість, ініціативи, причини, чому жінкам варто медитувати, пропонує пошук учительки, блог, відео й контакти.', 'A global meditation community "by women, for women". It explains what TM is and how it differs, describes the course structure and fee, initiatives and why women should meditate, and offers a teacher finder, blog, videos and contacts.', 'Навчання лише для жінок
Структура курсу
Пошук учительки
Блог і відео', 'Women-only instruction
Course structure
Teacher finder
Blog and videos', 'Жінки, які хочуть навчитися ТМ.', 'Women who want to learn TM.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tm-women.org' OR LOWER(`name`) = LOWER('TM Women')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'transcendental-meditation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'TM Women is the women''s organization teaching Transcendental Meditation exclusively to women: about TM, course structure and fee, initiatives and a teacher finder.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A global meditation community "by women, for women". It explains what TM is and how it differs, describes the course structure and fee, initiatives and why women should meditate, and offers a teacher finder, blog, videos and contacts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Women-only instruction
Course structure
Teacher finder
Blog and videos', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Women who want to learn TM.', 'manual' FROM DUAL WHERE @new = 1;

-- Transcendental Meditation — Трансцендентальна медитація
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tm.org' OR LOWER(`name`) = LOWER('Transcendental Meditation'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Transcendental Meditation', NULL, 'https://www.tm.org', NULL, NULL, 'TM.org — офіційний сайт техніки Трансцендентальної медитації: що таке ТМ, безкоштовна вступна лекція, курс із сертифікованим учителем, пошук учителя й подкаст.', 'TM.org is the official Transcendental Meditation site: what TM is, a free intro talk, a course with a certified teacher, a teacher finder and a podcast.', 'Офіційний сайт Трансцендентальної медитації. ТМ навчають індивідуально сертифіковані вчителі некомерційної організації; курс має фіксовану плату й супровід після навчання. Сайт пояснює, що таке ТМ, пропонує безкоштовну вступну лекцію наживо чи у відео, пошук учителя поруч, бронювання курсу, подкаст The Inner Well, блог, відгуки й FAQ.', 'The official Transcendental Meditation site. TM is taught one-on-one by certified teachers of a nonprofit organization; the course has a set fee and follow-up support. The site explains what TM is and offers a free intro talk live or on video, a local teacher finder, course booking, The Inner Well podcast, a blog, reviews and an FAQ.', 'Безкоштовна вступна лекція
Індивідуальне навчання
Пошук учителя
Супровід після курсу
Подкаст', 'Free intro talk
One-on-one instruction
Teacher finder
Follow-up support
Podcast', 'Ті, хто хоче опанувати ТМ.', 'People who want to learn TM.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tm.org' OR LOWER(`name`) = LOWER('Transcendental Meditation')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'transcendental-meditation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'TM.org is the official Transcendental Meditation site: what TM is, a free intro talk, a course with a certified teacher, a teacher finder and a podcast.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The official Transcendental Meditation site. TM is taught one-on-one by certified teachers of a nonprofit organization; the course has a set fee and follow-up support. The site explains what TM is and offers a free intro talk live or on video, a local teacher finder, course booking, The Inner Well podcast, a blog, reviews and an FAQ.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free intro talk
One-on-one instruction
Teacher finder
Follow-up support
Podcast', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to learn TM.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Вступна лекція', 'Intro Talk', 0.00, 'free', 'Безкоштовно наживо чи у відео', 'Free, live or on video' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Вступна лекція' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Intro Talk', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free, live or on video', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Transcendental Meditation Australia — Трансцендентальна медитація
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tm.org.au' OR LOWER(`name`) = LOWER('Transcendental Meditation Australia'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Transcendental Meditation Australia', NULL, 'https://tm.org.au', NULL, NULL, 'TM Australia — Трансцендентальна медитація в Австралії: безкоштовна інформаційна сесія, бронювання курсу, вартість, супровід і пошук місця навчання.', 'TM Australia covers Transcendental Meditation in Australia: a free info session, course booking, fees, follow-up and where to learn.', 'Австралійський сайт Трансцендентальної медитації. Розділи: що таке ТМ, безкоштовна інформаційна сесія наживо чи відео, фонд, блог, як навчитися, бронювання курсу, вартість, подальший супровід, розповіді про можливі переваги практики за даними організації та де навчатися.', 'The Australian Transcendental Meditation site. Sections cover what TM is, a free info session live or on video, the foundation, a blog, how to learn, course booking, fees, follow-up support, the benefits the organization describes and where to learn.', 'Безкоштовна інфосесія
Бронювання курсу
Супровід
Місця навчання', 'Free info session
Course booking
Follow-up
Places to learn', 'Мешканці Австралії, які хочуть вивчити ТМ.', 'People in Australia who want to learn TM.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tm.org.au' OR LOWER(`name`) = LOWER('Transcendental Meditation Australia')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'transcendental-meditation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'TM Australia covers Transcendental Meditation in Australia: a free info session, course booking, fees, follow-up and where to learn.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Australian Transcendental Meditation site. Sections cover what TM is, a free info session live or on video, the foundation, a blog, how to learn, course booking, fees, follow-up support, the benefits the organization describes and where to learn.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free info session
Course booking
Follow-up
Places to learn', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People in Australia who want to learn TM.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Інформаційна сесія', 'Info Session', 0.00, 'free', 'Безкоштовно', 'Free' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Інформаційна сесія' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Info Session', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Transcendental Meditation Canada — Трансцендентальна медитація
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tmcanada.org' OR LOWER(`name`) = LOWER('Transcendental Meditation Canada'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Transcendental Meditation Canada', NULL, 'https://www.tmcanada.org', NULL, NULL, 'Transcendental Meditation Canada — офіційний канадський сайт ТМ: про техніку, вступні лекції, курси й учителі по всій Канаді.', 'Transcendental Meditation Canada is the official Canadian TM site: about the technique, intro talks, courses and teachers across Canada.', 'Канадський сайт Трансцендентальної медитації. Розповідає про техніку, запрошує на вступні лекції, допомагає знайти вчителя й записатися на курс у різних містах Канади.', 'The Canadian Transcendental Meditation site. It describes the technique, invites people to intro talks and helps them find a teacher and enrol in a course in cities across Canada.', 'Про техніку ТМ
Вступні лекції
Пошук учителя
Курси в Канаді', 'About TM
Intro talks
Teacher finder
Courses in Canada', 'Мешканці Канади, які хочуть вивчити ТМ.', 'People in Canada who want to learn TM.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tmcanada.org' OR LOWER(`name`) = LOWER('Transcendental Meditation Canada')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'transcendental-meditation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Transcendental Meditation Canada is the official Canadian TM site: about the technique, intro talks, courses and teachers across Canada.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Canadian Transcendental Meditation site. It describes the technique, invites people to intro talks and helps them find a teacher and enrol in a course in cities across Canada.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'About TM
Intro talks
Teacher finder
Courses in Canada', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People in Canada who want to learn TM.', 'manual' FROM DUAL WHERE @new = 1;

-- OSHO International — Ошо
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'osho.com' OR LOWER(`name`) = LOWER('OSHO International'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'OSHO International', NULL, 'https://www.osho.com', NULL, NULL, 'OSHO.com — офіційний сайт OSHO International: медитації Ошо, онлайн-курси й сесії, міжнародний курорт медитації в Пуні, бібліотека й аудіо; 13 мов.', 'OSHO.com is the official OSHO International site: Osho meditations, online courses and sessions, the meditation resort in Pune, a library and audio; 13 languages.', 'Сайт OSHO International із читанням, переглядом і прослуховуванням матеріалів та практикою медитацій Ошо. Пропонує онлайн-курси, класи, сесії, дні медитації й безкоштовні «дегустації», бронювання програм і проживання на OSHO International Meditation Resort (гостьовий будинок, програми Living In), бібліотеку, аудіо й відео. Для бронювання потрібна безкоштовна реєстрація. Мови: англійська, іспанська, португальська, італійська, німецька, японська, грецька, французька, російська, китайська, нідерландська, корейська, гінді.', 'The OSHO International site for reading, watching and listening to Osho''s material and practicing his meditations. It offers online courses, classes, sessions, meditation days and free tasters, bookings for programs and stays at the OSHO International Meditation Resort (guesthouse, Living In programs), a library, audio and video. Booking requires free registration. Languages: English, Spanish, Portuguese, Italian, German, Japanese, Greek, French, Russian, Chinese, Dutch, Korean and Hindi.', 'Медитації Ошо
Онлайн-курси й сесії
Безкоштовні «дегустації»
Курорт медитації
13 мов', 'Osho meditations
Online courses and sessions
Free tasters
Meditation resort
13 languages', 'Ті, хто практикує медитації Ошо.', 'People practicing Osho meditations.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'osho.com' OR LOWER(`name`) = LOWER('OSHO International')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'osho' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'OSHO.com is the official OSHO International site: Osho meditations, online courses and sessions, the meditation resort in Pune, a library and audio; 13 languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The OSHO International site for reading, watching and listening to Osho''s material and practicing his meditations. It offers online courses, classes, sessions, meditation days and free tasters, bookings for programs and stays at the OSHO International Meditation Resort (guesthouse, Living In programs), a library, audio and video. Booking requires free registration. Languages: English, Spanish, Portuguese, Italian, German, Japanese, Greek, French, Russian, Chinese, Dutch, Korean and Hindi.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Osho meditations
Online courses and sessions
Free tasters
Meditation resort
13 languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People practicing Osho meditations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Реєстрація', 'Registration', 0.00, 'free', 'Безкоштовний акаунт і «дегустації»', 'Free account and tasters' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Реєстрація' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Registration', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free account and tasters', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Osho Nisarga — Ошо
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'oshonisarga.com' OR LOWER(`name`) = LOWER('Osho Nisarga'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Osho Nisarga', NULL, 'https://oshonisarga.com', NULL, NULL, 'Osho Nisarga — центр медитації й ашрам Ошо в Гімалаях (з 2006 р.): ретрити, воркшопи, медитативні терапії (Mystic Rose, Born Again, No Mind) і подкасти.', 'Osho Nisarga is an Osho meditation centre and ashram in the Himalayas (since 2006): retreats, workshops, meditative therapies (Mystic Rose, Born Again, No Mind) and podcasts.', 'Центр медитації Ошо в Гімалаях, що працює з 2006 року. Організовує ретрити, воркшопи, терапії й табори; медитативні терапії Mystic Rose, Born Again і No Mind. На сайті — про Ошо й нео-санньясу, значущі дні, галерея фото й відео, медитації, відгуки, подкасти й інтерв''ю, календар програм, ведучі й контакти з годинами відвідування.', 'An Osho meditation centre in the Himalayas operating since 2006. It runs retreats, workshops, therapies and camps, including the meditative therapies Mystic Rose, Born Again and No Mind. The site covers Osho and neo-sannyas, significant days, a photo and video gallery, meditations, testimonials, podcasts and interviews, a program calendar, facilitators and contact details with visiting hours.', 'Ретрити й табори
Медитативні терапії
Календар програм
Подкасти', 'Retreats and camps
Meditative therapies
Program calendar
Podcasts', 'Ті, хто шукає ретрит медитації Ошо.', 'People looking for an Osho meditation retreat.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'oshonisarga.com' OR LOWER(`name`) = LOWER('Osho Nisarga')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'osho' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Osho Nisarga is an Osho meditation centre and ashram in the Himalayas (since 2006): retreats, workshops, meditative therapies (Mystic Rose, Born Again, No Mind) and podcasts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An Osho meditation centre in the Himalayas operating since 2006. It runs retreats, workshops, therapies and camps, including the meditative therapies Mystic Rose, Born Again and No Mind. The site covers Osho and neo-sannyas, significant days, a photo and video gallery, meditations, testimonials, podcasts and interviews, a program calendar, facilitators and contact details with visiting hours.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Retreats and camps
Meditative therapies
Program calendar
Podcasts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People looking for an Osho meditation retreat.', 'manual' FROM DUAL WHERE @new = 1;

-- OSHO Online Library — Ошо
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'osho.com/osho-online-library/the-books' OR LOWER(`name`) = LOWER('OSHO Online Library'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'OSHO Online Library', NULL, 'https://www.osho.com/osho-online-library/the-books', NULL, NULL, 'OSHO Online Library — понад 200 книг Ошо онлайн з повнотекстовим пошуком, від «Прив''язаності» до «Заратустри» й від «Анархії» до «Дзену».', 'OSHO Online Library offers over 200 Osho books online with full-text search, "from Attachment to Zarathustra, from Anarchy to Zen".', 'Онлайн-бібліотека OSHO International, де можна читати й шукати понад 200 книг Ошо на широке коло тем. Інтерфейс доступний тими самими 13 мовами, що й OSHO.com; для повного доступу може знадобитися безкоштовна реєстрація.', 'OSHO International''s online library where you can read and search over 200 Osho books on a wide range of topics. The interface is available in the same 13 languages as OSHO.com; full access may require free registration.', 'Понад 200 книг
Повнотекстовий пошук
13 мов інтерфейсу', 'Over 200 books
Full-text search
13 interface languages', 'Читачі Ошо.', 'Osho readers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'osho.com/osho-online-library/the-books' OR LOWER(`name`) = LOWER('OSHO Online Library')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'osho' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'OSHO Online Library offers over 200 Osho books online with full-text search, "from Attachment to Zarathustra, from Anarchy to Zen".', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'OSHO International''s online library where you can read and search over 200 Osho books on a wide range of topics. The interface is available in the same 13 languages as OSHO.com; full access may require free registration.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Over 200 books
Full-text search
13 interface languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Osho readers.', 'manual' FROM DUAL WHERE @new = 1;

-- Osho Risk Meditation Center — Ошо
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'oshorisk.com' OR LOWER(`name`) = LOWER('Osho Risk Meditation Center'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Osho Risk Meditation Center', NULL, 'https://www.oshorisk.com', NULL, NULL, 'Osho Risk — центр медитації Ошо в Данії: тренінги трансформації, воркшопи, індивідуальні сесії, фестивалі, проживання й щоденна програма.', 'Osho Risk is an Osho meditation centre in Denmark: transformation training, workshops, individual sessions, festivals, accommodation and a daily program.', 'Спільнота для зростання й трансформації в Данії, яка пропонує безпечний простір для самодослідження. Програми: Training for Transformation, воркшопи, тренінги, індивідуальні сесії, фестивалі. Можна приїхати на день, зупинитися як гість чи працювати як медитацію; на сайті — щоденна програма, ведучі, FAQ, проживання, харчування, оренда приміщень і данська версія.', 'A community for growth and transformation in Denmark offering a safe space for self-exploration. Programs include Training for Transformation, workshops, trainings, individual sessions and festivals. You can visit for a day, stay as a guest or do work as meditation; the site covers the daily program, facilitators, FAQs, accommodation, food, venue rental and a Danish version.', 'Тренінги трансформації
Воркшопи й фестивалі
Проживання гостей
Щоденна програма', 'Transformation training
Workshops and festivals
Guest stays
Daily program', 'Ті, хто шукає ретрит у Європі.', 'People seeking a retreat in Europe.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'oshorisk.com' OR LOWER(`name`) = LOWER('Osho Risk Meditation Center')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'osho' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Osho Risk is an Osho meditation centre in Denmark: transformation training, workshops, individual sessions, festivals, accommodation and a daily program.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A community for growth and transformation in Denmark offering a safe space for self-exploration. Programs include Training for Transformation, workshops, trainings, individual sessions and festivals. You can visit for a day, stay as a guest or do work as meditation; the site covers the daily program, facilitators, FAQs, accommodation, food, venue rental and a Danish version.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Transformation training
Workshops and festivals
Guest stays
Daily program', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People seeking a retreat in Europe.', 'manual' FROM DUAL WHERE @new = 1;

-- Osho Tapoban — Ошо
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tapoban.com' OR LOWER(`name`) = LOWER('Osho Tapoban'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Osho Tapoban', NULL, 'https://www.tapoban.com', NULL, NULL, 'Osho Tapoban — міжнародна комуна медитації в лісі Наґарджун над Катманду (Непал): ретрити трансформації, терапії No-Mind і Mystic-Rose.', 'Osho Tapoban is an international meditation commune in the Nagarjun forest above Kathmandu, Nepal: transformation retreats, No-Mind and Mystic-Rose therapies.', 'Міжнародна комуна медитації в лісі Наґарджун над Катманду, де понад три десятиліття практикують техніки медитації Ошо. На сайті — про ашрам, Ошо й Свамі Ананд Аруна, календар подій (ретрити трансформації та самопізнання, терапії No-Mind і Mystic-Rose), інформація для відвідування, контакти й пожертви.', 'An international meditation commune in the Nagarjun forest above Kathmandu, practicing Osho''s meditation techniques for over three decades. The site covers the ashram, Osho and Swami Anand Arun, an events calendar (transformation and inner-discovery retreats, No-Mind and Mystic-Rose therapies), visiting information, contacts and donations.', 'Ретрити
Терапії No-Mind і Mystic-Rose
Календар подій
Відвідування ашраму', 'Retreats
No-Mind and Mystic-Rose therapies
Events calendar
Ashram visits', 'Ті, хто планує ретрит у Непалі.', 'People planning a retreat in Nepal.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tapoban.com' OR LOWER(`name`) = LOWER('Osho Tapoban')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'osho' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Osho Tapoban is an international meditation commune in the Nagarjun forest above Kathmandu, Nepal: transformation retreats, No-Mind and Mystic-Rose therapies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An international meditation commune in the Nagarjun forest above Kathmandu, practicing Osho''s meditation techniques for over three decades. The site covers the ashram, Osho and Swami Anand Arun, an events calendar (transformation and inner-discovery retreats, No-Mind and Mystic-Rose therapies), visiting information, contacts and donations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Retreats
No-Mind and Mystic-Rose therapies
Events calendar
Ashram visits', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People planning a retreat in Nepal.', 'manual' FROM DUAL WHERE @new = 1;

-- OSHO World — Ошо
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'oshoworld.com' OR LOWER(`name`) = LOWER('OSHO World'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'OSHO World', NULL, 'https://www.oshoworld.com', NULL, NULL, 'OSHO World — сайт Osho Dham (Делі): життя Ошо, медитаційні ретрити й групи (Born Again, No Mind), відео, «перлини» Ошо й крамниця.', 'OSHO World is the site of Osho Dham (Delhi): Osho''s life, meditation retreats and groups (Born Again, No Mind), videos, Osho pearls and a store.', 'Сайт OSHO World і центру Oshodham. Розповідає про життя Ошо й медитацію, анонсує програми — ретрити медитації, групи Born Again і No Mind, йога-ретрити, святкування Ґуру Пурніми — з датами й реєстрацією. Є відео й фотозвіти, «перлини» Ошо та крамниця.', 'The site of OSHO World and the Oshodham centre. It covers Osho''s life and meditation and announces programs — meditation retreats, Born Again and No Mind groups, yoga retreats, Guru Purnima celebrations — with dates and registration. There are videos and photo reports, Osho pearls and a store.', 'Медитаційні ретрити
Групи Born Again і No Mind
Відео
Крамниця', 'Meditation retreats
Born Again and No Mind groups
Videos
Store', 'Практики медитацій Ошо в Індії.', 'Osho meditation practitioners in India.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'oshoworld.com' OR LOWER(`name`) = LOWER('OSHO World')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'osho' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'OSHO World is the site of Osho Dham (Delhi): Osho''s life, meditation retreats and groups (Born Again, No Mind), videos, Osho pearls and a store.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of OSHO World and the Oshodham centre. It covers Osho''s life and meditation and announces programs — meditation retreats, Born Again and No Mind groups, yoga retreats, Guru Purnima celebrations — with dates and registration. There are videos and photo reports, Osho pearls and a store.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Meditation retreats
Born Again and No Mind groups
Videos
Store', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Osho meditation practitioners in India.', 'manual' FROM DUAL WHERE @new = 1;

-- Sannyas Wiki — Ошо
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sannyas.wiki' OR LOWER(`name`) = LOWER('Sannyas Wiki'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sannyas Wiki', NULL, 'https://www.sannyas.wiki', NULL, NULL, 'Sannyas Wiki — вікі з понад 70 000 сторінок про Ошо (Бгаґван Шрі Раджніш) і санньясу: дискурси, книги, листи, музика й історичні документи.', 'Sannyas Wiki is a wiki of 70,000+ pages about Osho (Bhagwan Shree Rajneesh) and sannyas: discourses, books, letters, music and historical documents.', 'Вікі з перевіреною й вичерпною інформацією про роботу Ошо, його дискурси й книги, зокрема всю музику, створену навколо нього. Регулярно додаються знайдені листи, тексти й бесіди, книги й аудіо гінді, історичні документи (наприклад, планувальні документи міста Раджнішпурам).', 'A wiki with verified and exhaustive information about Osho''s work, his discourses and books, including all the music made around him. Newly found letters, writings and talks, Hindi books and audio and historical documents (such as the planning documents of the City of Rajneeshpuram) are added regularly.', '70 000+ сторінок
Дискурси й книги
Листи й аудіо
Історичні документи', '70,000+ pages
Discourses and books
Letters and audio
Historical documents', 'Дослідники й читачі Ошо.', 'Osho researchers and readers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sannyas.wiki' OR LOWER(`name`) = LOWER('Sannyas Wiki')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'osho' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Sannyas Wiki is a wiki of 70,000+ pages about Osho (Bhagwan Shree Rajneesh) and sannyas: discourses, books, letters, music and historical documents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A wiki with verified and exhaustive information about Osho''s work, his discourses and books, including all the music made around him. Newly found letters, writings and talks, Hindi books and audio and historical documents (such as the planning documents of the City of Rajneeshpuram) are added regularly.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '70,000+ pages
Discourses and books
Letters and audio
Historical documents', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Osho researchers and readers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
