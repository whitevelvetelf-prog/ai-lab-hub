-- MySQL dump 10.13  Distrib 8.4.3, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: ailabhub_db
-- ------------------------------------------------------
-- Server version	8.4.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_categories_slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Мультимедіа','multimedia'),(2,'Текст та Чат-боти','text-chatbots'),(3,'Розробка та IT','development-it'),(4,'Бізнес та маркетинг','business-marketing'),(5,'Дані та аналітика','data-analytics'),(6,'Продуктивність','productivity'),(7,'SEO та контент','seo-content'),(8,'Дизайн та креатив','design-creative'),(9,'Освіта та знання','education-knowledge'),(10,'Переклад та мови','translation-languages'),(11,'Фінанси та юридичні','finance-legal'),(12,'Здоров\'я та краса','health-beauty'),(13,'Інструменти та автоматизація','tools-automation');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_requests`
--

DROP TABLE IF EXISTS `employee_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee_requests` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `reviewed_by` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_employee_requests_user` (`user_id`),
  KEY `idx_employee_requests_status` (`status`),
  KEY `fk_employee_requests_reviewed_by` (`reviewed_by`),
  CONSTRAINT `fk_employee_requests_reviewed_by` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_employee_requests_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_requests`
--

LOCK TABLES `employee_requests` WRITE;
/*!40000 ALTER TABLE `employee_requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pricing_plans`
--

DROP TABLE IF EXISTS `pricing_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pricing_plans` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int unsigned NOT NULL,
  `plan_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `period` enum('free','week','month','year','one_time') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'free',
  `description` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `idx_pricing_plans_product` (`product_id`),
  CONSTRAINT `fk_pricing_plans_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pricing_plans`
--

LOCK TABLES `pricing_plans` WRITE;
/*!40000 ALTER TABLE `pricing_plans` DISABLE KEYS */;
INSERT INTO `pricing_plans` VALUES (5,3,'Free',0.00,'free','Базовий доступ з денними лімітами (безкоштовно назавжди)'),(6,3,'Pro',20.00,'month','Розширені можливості, необмежені проєкти'),(7,3,'Max',100.00,'month','Суттєво більший ліміт використання'),(8,3,'Team',25.00,'month','Для командної роботи (ціна за місце, річна оплата)'),(9,4,'Free',0.00,'free','Базовий доступ з обмеженнями і рекламою'),(10,4,'Go',8.00,'month','Більше повідомлень і завантажень'),(11,4,'Plus',20.00,'month','Повний набір функцій, без реклами'),(12,4,'Pro',200.00,'month','Розширені ліміти для потужної роботи'),(13,5,'Basic',10.00,'month','Обмежений час швидкої генерації'),(14,5,'Standard',30.00,'month','Більше часу генерації, необмежений повільний режим'),(15,5,'Pro',60.00,'month','Ще більше часу генерації, приватний режим'),(16,5,'Mega',120.00,'month','Максимальний обсяг генерації'),(17,6,'Free',0.00,'free','Базовий Notion без повного AI (обмежене пробне використання AI)'),(18,6,'Plus',10.00,'month','Командна співпраця, без повного AI'),(19,6,'Business',20.00,'month','Повний доступ до Notion AI та AI-агентів'),(20,6,'Enterprise',0.00,'one_time','Індивідуальна ціна для великих організацій'),(21,7,'Free',0.00,'free','Базовий дизайн з обмеженою кількістю AI-дій на місяць'),(22,7,'Pro',15.00,'month','Розширені AI-можливості, преміум-шаблони, брендовий набір'),(23,8,'Free',0.00,'free','Обмежена денна кількість генерацій'),(24,8,'Basic',12.00,'month','Більше генерацій на місяць'),(25,8,'Premium',30.00,'month','Необмежена генерація в \"розслабленому\" режимі'),(26,8,'Ultimate',60.00,'month','Максимальний обсяг, включно з відео'),(27,9,'Free',0.00,'free','Обмежена кількість підказок і повідомлень на місяць'),(28,9,'Pro',10.00,'month','Розширені ліміти, доступ до кращих моделей'),(29,9,'Pro+',39.00,'month','Ще більші ліміти'),(30,9,'Business',19.00,'month','Для команд, адміністрування'),(31,10,'Free',0.00,'free','Публічні моделі й датасети, обмежені обчислювальні ресурси'),(32,10,'Pro',9.00,'month','Більше приватних репозиторіїв, розширені можливості'),(33,10,'Enterprise',0.00,'one_time','Індивідуальна ціна для організацій'),(34,11,'Free',0.00,'free','Базовий функціонал для невеликих команд'),(35,11,'Basic',19.00,'month','Більше запитів і колекцій'),(36,11,'Professional',49.00,'month','Розширена командна співпраця'),(37,12,'Free',0.00,'free','Базові функції з обмеженнями'),(38,12,'Pro',19.00,'month','Розширені ліміти й функції для команд'),(39,13,'Free',0.00,'free','Обмежена денна квота'),(40,13,'Pro',20.00,'month','Стандартні квоти, доступ до власної моделі SWE-1.5'),(41,13,'Max',200.00,'month','Найвищі квоти'),(42,13,'Teams',40.00,'month','Централізований облік для команд');
/*!40000 ALTER TABLE `pricing_plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_categories`
--

DROP TABLE IF EXISTS `product_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_categories` (
  `product_id` int unsigned NOT NULL,
  `category_id` int unsigned NOT NULL,
  PRIMARY KEY (`product_id`,`category_id`),
  KEY `idx_pc_category` (`category_id`),
  CONSTRAINT `fk_pc_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_pc_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_categories`
--

LOCK TABLES `product_categories` WRITE;
/*!40000 ALTER TABLE `product_categories` DISABLE KEYS */;
INSERT INTO `product_categories` VALUES (5,1),(8,1),(3,2),(4,2),(3,3),(9,3),(10,3),(11,3),(12,3),(13,3),(6,6),(7,8);
/*!40000 ALTER TABLE `product_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_subcategories`
--

DROP TABLE IF EXISTS `product_subcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_subcategories` (
  `product_id` int unsigned NOT NULL,
  `subcategory_id` int unsigned NOT NULL,
  PRIMARY KEY (`product_id`,`subcategory_id`),
  KEY `idx_psc_subcategory` (`subcategory_id`),
  CONSTRAINT `fk_psc_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_psc_subcategory` FOREIGN KEY (`subcategory_id`) REFERENCES `subcategories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_subcategories`
--

LOCK TABLES `product_subcategories` WRITE;
/*!40000 ALTER TABLE `product_subcategories` DISABLE KEYS */;
INSERT INTO `product_subcategories` VALUES (8,1),(5,2),(8,2),(3,5),(4,5),(6,22),(6,26),(9,33),(12,33),(13,33),(9,34),(13,34),(10,36),(12,36),(11,37),(3,38),(10,38),(11,38),(7,43);
/*!40000 ALTER TABLE `product_subcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo_url` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `official_url` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `internal_registration_url` text COLLATE utf8mb4_unicode_ci,
  `affiliate_url` text COLLATE utf8mb4_unicode_ci,
  `short_description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `full_description` text COLLATE utf8mb4_unicode_ci,
  `main_features` text COLLATE utf8mb4_unicode_ci,
  `target_audience` text COLLATE utf8mb4_unicode_ci,
  `platform` set('web','mobile','desktop') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `skill_level` enum('none','basic','course') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none',
  `status` enum('none','in_progress','published') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none',
  `partnership_status` enum('found','pending_registration','partner_connected','no_partnership') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'found',
  `created_by` int unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_products_created_by` (`created_by`),
  KEY `idx_products_status` (`status`),
  CONSTRAINT `fk_products_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (3,'Claude',NULL,'https://claude.com',NULL,NULL,'AI-асистент від Anthropic для спілкування, аналізу тексту, написання коду та роботи з документами. Доступний безкоштовно з денними лімітами, або без обмежень на платних тарифах.','Claude — це AI-асистент, з яким можна спілкуватися звичайною мовою: ставити запитання, просити написати текст, розібратись у документі чи навіть написати програмний код. Розуміє великі обсяги інформації одразу — можна завантажити цілу книгу чи великий звіт і попросити його проаналізувати. На платних тарифах вміє сам писати й запускати код, шукати актуальну інформацію в інтернеті, створювати файли (документи, таблиці, презентації). Підходить і для повсякденних питань, і для серйозної робочої задачі.','Відповідає на запитання й веде діалог природною мовою\nПише й аналізує програмний код\nАналізує документи, зображення, великі обсяги тексту\nШукає актуальну інформацію в інтернеті\nСтворює й редагує файли (документи, таблиці, презентації)','Розробники, дослідники, автори контенту, бізнес-користувачі — від персонального використання до командної роботи в організаціях','web,mobile,desktop','none','published','no_partnership',3,'2026-09-02 07:27:55','2026-09-02 07:27:55'),(4,'ChatGPT',NULL,'https://chatgpt.com',NULL,NULL,'AI-чат-бот від OpenAI для спілкування, написання текстів, аналізу даних і генерації зображень. Безкоштовний тариф з обмеженнями, платні плани для регулярного й професійного використання.','ChatGPT — це AI-асистент, з яким можна вести діалог звичайною мовою: ставити запитання, писати й редагувати тексти, аналізувати файли й зображення, шукати актуальну інформацію в інтернеті. Вміє створювати зображення, аналізувати дані, писати й виконувати програмний код. Підходить як для повсякденних запитів, так і для складної професійної роботи.','Відповідає на запитання й веде діалог\nПише та редагує тексти\nАналізує документи й зображення\nГенерує зображення\nШукає інформацію в інтернеті\nПише програмний код','Широка аудиторія — від повсякденних питань до професійної роботи розробників, письменників, аналітиків','web,mobile,desktop','none','published','no_partnership',3,'2026-09-02 07:49:51','2026-09-02 07:53:47'),(5,'Midjourney',NULL,'https://midjourney.com',NULL,NULL,'Генерує зображення та ілюстрації за текстовим описом. Немає безкоштовного тарифу, роботу з програмою організовано через Discord.','Midjourney — інструмент для створення зображень, ілюстрацій та концепт-арту на основі текстового опису. Відомий високою художньою якістю результатів. Робота відбувається через Discord: користувач пише текстовий запит і отримує кілька варіантів зображення за кілька секунд. Усі платні тарифи включають право комерційного використання згенерованих зображень.','Генерує зображення за текстовим описом\nДозволяє редагувати й варіювати вже згенеровані зображення\nКомерційна ліцензія на результати\nПриватний режим генерації (на старших тарифах)','Дизайнери, ілюстратори, маркетологи, студії, що потребують якісного візуального контенту','web','basic','published','no_partnership',3,'2026-09-02 07:49:51','2026-09-02 07:49:51'),(6,'Notion AI',NULL,'https://notion.com',NULL,NULL,'AI-функції всередині робочого простору Notion — допомагає писати, підсумовувати нотатки та автоматизувати багатоетапні задачі. Доступний лише на платному тарифі Business.','Notion AI вбудований у платформу Notion (нотатки, бази даних, документи) і допомагає писати та редагувати текст, підсумовувати великі нотатки, відповідати на запитання по вмісту робочого простору й виконувати багатоетапні задачі через AI-агента. Повний доступ до AI-функцій наразі доступний тільки на тарифі Business — окремого дешевого AI-додатку більше немає.','Пише й редагує текст всередині нотаток\nПідсумовує великі документи\nВідповідає на запитання по вмісту робочого простору\nВиконує багатоетапні задачі через AI-агента','Команди й окремі користувачі, що ведуть нотатки, документацію та проєкти в Notion','web,mobile,desktop','basic','published','no_partnership',3,'2026-09-02 07:49:51','2026-09-02 07:49:51'),(7,'Canva',NULL,'https://canva.com',NULL,NULL,'Платформа для дизайну з вбудованими AI-інструментами (Magic Studio) — генерація зображень, авторедагування, зміна розміру макетів. Є безкоштовний тариф з обмеженою кількістю AI-дій.','Canva — платформа для створення дизайну (соцмережі, презентації, друковані матеріали) з вбудованим набором AI-функцій під назвою Magic Studio: генерація зображень і текстів, автоматичне видалення фону, розумна зміна розміру макетів під різні формати. Безкоштовний тариф дає обмежену кількість AI-дій на місяць, платний Pro — суттєво більше можливостей і преміум-шаблони.','Генерує зображення й тексти для дизайну\nВидаляє фон із зображень\nАвтоматично адаптує макет під різні розміри\nПреміум-шаблони й брендові набори (на платному тарифі)','Дизайнери-початківці, маркетологи, невеликий бізнес, творці соцмережевого контенту','web,mobile,desktop','none','published','no_partnership',3,'2026-09-02 07:49:51','2026-09-02 07:49:51'),(8,'Leonardo AI',NULL,'https://leonardo.ai',NULL,NULL,'Генерує зображення та короткі відео за текстовим описом. Має безкоштовний тариф з денним лімітом генерацій.','Leonardo AI — інструмент для створення зображень і відео на основі текстового опису, з підтримкою кількох власних AI-моделей і можливістю тонкого налаштування стилю. На відміну від деяких конкурентів, має безкоштовний тариф, що дозволяє спробувати основний функціонал без оплати.','Генерує зображення за текстовим описом\nГенерує короткі відео\nДозволяє тонко налаштовувати стиль і модель генерації\nРедактор зображень','Дизайнери, творці контенту, невеликі студії, що потребують і зображень, і відео в одному інструменті','web','basic','published','no_partnership',3,'2026-09-02 07:49:51','2026-09-02 07:49:51'),(9,'GitHub Copilot',NULL,'https://github.com/features/copilot',NULL,NULL,'AI-асистент для програмування прямо в редакторі коду — підказує рядки коду, пояснює логіку, допомагає виправляти помилки. Інтегрується з популярними редакторами (VS Code, JetBrains та інші).','GitHub Copilot допомагає писати код швидше: підказує наступні рядки під час набору тексту, пояснює незрозумілі фрагменти чужого коду, знаходить і виправляє помилки, а також може самостійно виконувати задачі з опису (наприклад \"додай перевірку email\") у режимі агента. Працює прямо всередині звичного редактора коду, не вимагає окремого застосунку.','Підказує код під час набору тексту\nПояснює логіку існуючого коду\nЗнаходить і виправляє помилки\nВиконує задачі з текстового опису в режимі агента','Розробники будь-якого рівня — від початківців до професіоналів, що працюють у звичних редакторах коду','web,desktop','course','published','no_partnership',3,'2026-09-02 08:03:08','2026-09-02 08:03:08'),(10,'Hugging Face',NULL,'https://huggingface.co',NULL,NULL,'Платформа для пошуку, використання та розміщення готових AI-моделей і наборів даних. Популярна серед розробників, що створюють власні AI-рішення.','Hugging Face — це майданчик, де розробники й дослідники публікують готові AI-моделі, набори даних для навчання AI, а також невеликі демонстраційні застосунки. Можна знайти готову модель під конкретну задачу (наприклад розпізнавання мови чи генерація тексту) і використати її у власному проєкті, не навчаючи модель з нуля. Має і безкоштовний, і платний рівень для розміщення власних приватних моделей.','Пошук готових AI-моделей за задачею\nРозміщення власних моделей і наборів даних\nДемонстраційні застосунки без встановлення\nХмарний запуск моделей через API','Розробники та дослідники, що створюють власні AI-рішення на основі готових моделей','web','course','published','no_partnership',3,'2026-09-02 08:03:08','2026-09-02 08:03:08'),(11,'Postman',NULL,'https://postman.com',NULL,NULL,'Платформа для тестування й розробки API з вбудованими AI-функціями — генерує тестові сценарії, документацію та допомагає налагоджувати запити.','Postman — інструмент для розробки, тестування й документування API (з\'єднань між програмами). AI-функції всередині Postman допомагають автоматично згенерувати тестові сценарії, написати документацію по API, і пояснити помилки під час налагодження запитів. Має безкоштовний тариф, достатній для особистих проєктів і невеликих команд.','Генерує тестові сценарії для API\nАвтоматично створює документацію\nДопомагає налагоджувати запити й пояснює помилки\nКомандна співпраця над колекціями запитів','Розробники та QA-інженери, що працюють з API','web,desktop','course','published','no_partnership',3,'2026-09-02 08:03:08','2026-09-02 08:03:08'),(12,'Amazon Q Developer',NULL,'https://aws.amazon.com/q/developer',NULL,NULL,'AI-асистент для розробників від AWS — пише код, пояснює хмарну інфраструктуру та допомагає з міграцією проєктів.','Amazon Q Developer — AI-помічник, вбудований у редактори коду й хмарну консоль AWS. Допомагає писати й пояснювати код, автоматизує рутинні задачі (наприклад оновлення застарілих бібліотек), і відповідає на запитання про хмарну інфраструктуру компанії. Особливо корисний для команд, що вже працюють з хмарними сервісами Amazon.','Пише й пояснює програмний код\nАвтоматизує оновлення застарілих бібліотек\nВідповідає на запитання про хмарну інфраструктуру\nІнтегрується з редакторами коду','Розробники й команди, що працюють з хмарною інфраструктурою AWS','web,desktop','course','published','no_partnership',3,'2026-09-02 08:03:08','2026-09-02 08:03:08'),(13,'Windsurf',NULL,'https://windsurf.com',NULL,NULL,'AI-редактор коду з інтеграцією кількох потужних AI-моделей — розуміє весь проєкт цілком і може самостійно виконувати задачі розробки у фоновому режимі.','Windsurf — редактор коду, побудований навколо AI-агента \"Cascade\", який розуміє структуру всього проєкту, а не тільки поточний файл. Може виконувати задачі у фоновому режимі (наприклад написати новий модуль, поки розробник займається іншим завданням), підтримує кілька AI-моделей на вибір (Claude, GPT, Gemini) в одному інтерфейсі.','Розуміє структуру всього проєкту\nВиконує задачі у фоновому режимі\nПідтримує кілька AI-моделей на вибір\nАвтодоповнення коду','Розробники, що хочуть делегувати частину рутинної роботи AI-агенту','desktop','course','published','found',3,'2026-09-02 08:03:08','2026-09-02 08:03:08');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subcategories`
--

DROP TABLE IF EXISTS `subcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subcategories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_subcategories_cat_slug` (`category_id`,`slug`),
  KEY `idx_subcategories_category` (`category_id`),
  CONSTRAINT `fk_subcategories_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subcategories`
--

LOCK TABLES `subcategories` WRITE;
/*!40000 ALTER TABLE `subcategories` DISABLE KEYS */;
INSERT INTO `subcategories` VALUES (1,1,'Генерація відео','video-generation'),(2,1,'Генерація зображень','image-generation'),(3,1,'Озвучення','voiceover'),(4,2,'Нотатки та організація','notes'),(5,2,'Чат-боти','chatbots'),(6,2,'Копірайтинг','copywriting'),(7,3,'Асистенти коду','code-assistants'),(8,3,'Рефакторинг','refactoring'),(9,3,'Автодоповнення коду','code-autocomplete'),(10,4,'Реклама','advertising'),(11,4,'Резюме зустрічей','meeting-summaries'),(12,4,'SMM','smm'),(13,5,'SQL-запити','sql-queries'),(14,5,'Візуалізація даних','data-visualization'),(15,5,'Звіти','reports'),(16,1,'Аудіо','audio'),(17,1,'Фотографія','photography'),(18,1,'Відеомонтаж','video-editing'),(19,1,'Музика','music'),(20,1,'3D та анімація','3d-animation'),(21,2,'Публікації','publications'),(22,6,'Планування','planning'),(23,6,'Управління цілями','goal-management'),(24,6,'Зберігання','storage'),(25,6,'Календар','calendar'),(26,6,'Нотатки','notes'),(27,6,'Тайм-менеджмент','time-management'),(28,4,'Аналітика','analytics'),(29,4,'Лідогенерація','lead-generation'),(30,4,'Email-маркетинг','email-marketing'),(31,4,'E-commerce','e-commerce'),(32,4,'CRM','crm'),(33,3,'Веб-розробка','web-development'),(34,3,'Мобільна розробка','mobile-development'),(35,3,'Бази даних','databases'),(36,3,'Хмарні сервіси','cloud-services'),(37,3,'Тестування','testing'),(38,3,'API','api'),(39,7,'SEO','seo'),(40,7,'Хештеги','hashtags'),(41,7,'Лінкбілдинг','link-building'),(42,7,'Тренди','trends'),(43,8,'Графічний дизайн','graphic-design'),(44,8,'UI/UX','ui-ux'),(45,8,'Типографіка','typography'),(46,8,'Кольори','colors'),(47,8,'Візуалізація даних','data-visualization'),(48,8,'Аналіз даних','data-analysis'),(49,8,'Звіти','reports'),(50,9,'Курси','courses'),(51,9,'Сертифікати','certificates'),(52,9,'Менторство','mentorship'),(53,9,'Бібліотека','library'),(54,9,'Тести','tests'),(55,10,'Переклад','translation'),(56,10,'Словник','dictionary'),(57,10,'Розпізнавання мови','speech-recognition'),(58,10,'Субтитри','subtitles'),(59,11,'Фінанси','finance'),(60,11,'Інвестиції','investments'),(61,11,'Платежі','payments'),(62,11,'Юридичні послуги','legal-services'),(63,11,'Документи','documents'),(64,11,'Безпека даних','data-security'),(65,12,'Медицина','medicine'),(66,12,'Краса та стиль','beauty-style'),(67,12,'Спорт та фітнес','sports-fitness'),(68,13,'Плагіни','plugins'),(69,13,'Автоматизація','automation'),(70,13,'Інтеграції','integrations'),(71,13,'Навігація','navigation');
/*!40000 ALTER TABLE `subcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('user','employee','admin') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employee_number` int unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_users_email` (`email`),
  UNIQUE KEY `uq_users_employee_number` (`employee_number`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (2,'Employee Test','employee@test.com','$2y$10$FSscwarrFGh4Qzz53J1a0O.NVNftGssR5C9u2EQQx/Bfu0B.TXYcq','employee',NULL,NULL,NULL,'2026-08-30 17:31:52'),(3,'Серена','whitevelvetelf@gmail.com','$2y$10$tI4ZmrNuI9pyTQUMiTjyG.WNubgfXB0/TzyHtOpr/lce7w9g7eQy.','admin',NULL,NULL,NULL,'2026-09-01 10:49:38');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-02 13:17:25

--
-- ---------------------------------------------------------------------
-- roles / user_roles: у локальній базі ailabhub_db цих таблиць НЕМАЄ
-- (ролі зберігаються в ENUM `users`.`role`). Додано тут як мінімальний
-- каркас + довідник ролей, щоб цільова база містила всі очікувані
-- таблиці. Код застосунку наразі їх не використовує.
-- ---------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_roles_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `roles` (`id`,`name`) VALUES (1,'user'),(2,'employee'),(3,'admin');

DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE `user_roles` (
  `user_id` int unsigned NOT NULL,
  `role_id` int unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `idx_user_roles_role` (`role_id`),
  CONSTRAINT `fk_user_roles_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_roles_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS=1;
