SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-10-11: нові підкатегорії в категорії «Розробка та IT» / «Development & IT» (slug development-it)
-- з підкатегоріями:
--   * Локальні LLM / Local LLMs (slug local-llm)
--   * Інференс і GPU-хмари / LLM Inference & GPU Cloud (slug llm-inference)
--   * Фреймворки для LLM-застосунків / LLM App Frameworks (slug llm-frameworks)
--   * Моніторинг і оцінка LLM / LLMOps & Evaluation (slug llmops)
--   * Векторні бази даних / Vector Databases (slug vector-databases)
-- + 44 нових продуктів + прив'язка наявних.
-- Тексти, функції й тарифи (UA + EN) — лише з офіційних сайтів, звірено 2026-10-11. Невідомі ціни — NULL з поясненням,
-- ціни не в USD — NULL, точна сума в описі плану.
-- Не включено свідомо: Flowise (автори оголосили закриття), AutoGen (режим підтримки, без нових функцій), SambaNova (сторінка цін недоступна).
-- Назви-кандидати взято з відкритих списків і каталогів; тексти написано заново з офіційних сайтів, без копіювання чужих описів.
-- Прив'язуються наявні (тексти не змінюються): OpenRouter, Replicate, LangChain, CrewAI
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт» (файл .sql або .sql.zip). Повторний запуск безпечний.
--   Ollama — Локальні LLM
--   LM Studio — Локальні LLM
--   GPT4All — Локальні LLM
--   Jan — Локальні LLM
--   AnythingLLM — Локальні LLM
--   Open WebUI — Локальні LLM
--   LocalAI — Локальні LLM
--   Msty — Локальні LLM
--   llama.cpp — Локальні LLM
--   vLLM — Локальні LLM
--   llamafile — Локальні LLM
--   KoboldCpp — Локальні LLM
--   TextGen (oobabooga) — Локальні LLM
--   Pinokio — Локальні LLM
--   Groq — Інференс і GPU-хмари
--   Together AI — Інференс і GPU-хмари
--   Fireworks AI — Інференс і GPU-хмари
--   DeepInfra — Інференс і GPU-хмари
--   Cerebras — Інференс і GPU-хмари
--   Modal — Інференс і GPU-хмари
--   Runpod — Інференс і GPU-хмари
--   Lambda — Інференс і GPU-хмари
--   Baseten — Інференс і GPU-хмари
--   Novita AI — Інференс і GPU-хмари
--   LlamaIndex — Фреймворки для LLM-застосунків
--   Haystack — Фреймворки для LLM-застосунків
--   Dify — Фреймворки для LLM-застосунків
--   Langflow — Фреймворки для LLM-застосунків
--   LiteLLM — Фреймворки для LLM-застосунків
--   Unsloth — Фреймворки для LLM-застосунків
--   Axolotl — Фреймворки для LLM-застосунків
--   Langfuse — Моніторинг і оцінка LLM
--   LangSmith — Моніторинг і оцінка LLM
--   Weights & Biases — Моніторинг і оцінка LLM
--   Helicone — Моніторинг і оцінка LLM
--   Arize Phoenix — Моніторинг і оцінка LLM
--   Braintrust — Моніторинг і оцінка LLM
--   Promptfoo — Моніторинг і оцінка LLM
--   Portkey — Моніторинг і оцінка LLM
--   Pinecone — Векторні бази даних
--   Weaviate — Векторні бази даних
--   Qdrant — Векторні бази даних
--   Chroma — Векторні бази даних
--   Milvus — Векторні бази даних
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
INSERT INTO `categories` (`name`, `name_en`, `slug`) SELECT 'Розробка та IT', 'Development & IT', 'development-it' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `categories` WHERE `slug` = 'development-it');
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'development-it' LIMIT 1);
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Локальні LLM', 'Local LLMs', 'local-llm' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'local-llm');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Інференс і GPU-хмари', 'LLM Inference & GPU Cloud', 'llm-inference' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'llm-inference');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Фреймворки для LLM-застосунків', 'LLM App Frameworks', 'llm-frameworks' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'llm-frameworks');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Моніторинг і оцінка LLM', 'LLMOps & Evaluation', 'llmops' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'llmops');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Векторні бази даних', 'Vector Databases', 'vector-databases' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'vector-databases');

-- =================== Локальні LLM / Local LLMs ===================
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'local-llm' LIMIT 1);

-- Ollama — Локальні LLM
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ollama.com' OR LOWER(`name`) = 'ollama')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ollama', NULL, 'https://ollama.com', NULL, NULL, 'Запуск відкритих AI-моделей на своєму комп''ютері (macOS, Windows, Linux) або в хмарі Ollama однією командою.', 'Run open AI models on your own computer (macOS, Windows, Linux) or in the Ollama cloud with a single command.', 'Ollama завантажує й запускає відкриті мовні моделі локально: одна команда — і модель працює на вашому комп''ютері з API, сумісним з OpenAI. Для великих моделей є хмарний режим, у якому запити не зберігаються й не використовуються для навчання. Локальний запуск безкоштовний, хмарні плани Pro і Max додають кредити на використання, доступ до більших моделей і паралельні запити; для команд є Team і Enterprise.', 'Ollama downloads and runs open language models locally: one command and the model runs on your computer with an OpenAI-compatible API. For large models there is a cloud mode in which prompts are not stored or used for training. Local use is free; the Pro and Max cloud plans add usage credits, larger models and concurrent requests, and teams get Team and Enterprise plans.', 'Локальний запуск відкритих моделей
API, сумісний з OpenAI
Хмарні моделі без зберігання запитів
Бібліотека моделей', 'Run open models locally
OpenAI-compatible API
Cloud models without prompt storage
Model library', 'Розробникам і всім, хто хоче працювати з AI-моделями приватно на своєму залізі.', 'Developers and anyone who wants to use AI models privately on their own hardware.', 'desktop,web', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ollama.com' OR LOWER(`name`) = 'ollama') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Run open AI models on your own computer (macOS, Windows, Linux) or in the Ollama cloud with a single command.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Ollama downloads and runs open language models locally: one command and the model runs on your computer with an OpenAI-compatible API. For large models there is a cloud mode in which prompts are not stored or used for training. Local use is free; the Pro and Max cloud plans add usage credits, larger models and concurrent requests, and teams get Team and Enterprise plans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Run open models locally
OpenAI-compatible API
Cloud models without prompt storage
Model library', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers and anyone who wants to use AI models privately on their own hardware.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Локальний запуск і стартові хмарні кредити.', 'Local use and starter cloud credits.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Local use and starter cloud credits.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro', 'Pro', 20.00, 'month', '$60 кредитів на місяць, більші моделі; $200 на рік.', '$60 of usage credits per month, larger models; $200 per year.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$60 of usage credits per month, larger models; $200 per year.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Max', 'Max', 100.00, 'month', '$300 кредитів на місяць, 10 паралельних запитів.', '$300 of usage credits per month, 10 concurrent requests.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Max' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Max', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$300 of usage credits per month, 10 concurrent requests.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Team', 'Team', 500.00, 'month', 'Необмежено користувачів, $1000 кредитів на команду.', 'Unlimited users, $1,000 of credits shared by the team.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Team' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Team', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Unlimited users, $1,000 of credits shared by the team.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- LM Studio — Локальні LLM
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lmstudio.ai' OR LOWER(`name`) = 'lm studio')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'LM Studio', NULL, 'https://lmstudio.ai', NULL, NULL, 'Застосунок для запуску локальних LLM з агентом Bionic: чат, документи, код і голосовий ввід на вашому комп''ютері.', 'An app for running local LLMs with the Bionic agent: chat, documents, code and voice input on your computer.', 'LM Studio дає змогу завантажувати відкриті моделі прямо в застосунку й запускати їх через llama.cpp і MLX. Агент Bionic створює й редагує документи, слайди та PDF, допомагає з кодом і автоматизацією, а голос розпізнає локально. Безкоштовний план охоплює локальні моделі; платні Bionic+ і Pro додають хмарні відкриті моделі в США без зберігання даних. Для розробників є CLI, SDK для JavaScript і Python.', 'LM Studio lets you download open models right in the app and run them via llama.cpp and MLX. The Bionic agent creates and edits documents, slides and PDFs, helps with code and automation, and transcribes voice locally. The free plan covers local models; paid Bionic+ and Pro add US-hosted open cloud models with zero data retention. Developers get a CLI and JavaScript and Python SDKs.', 'Завантаження моделей у застосунку
Агент для документів і коду
Локальне розпізнавання голосу
CLI та SDK для розробників', 'In-app model downloads
Agent for documents and code
Local voice transcription
CLI and SDKs for developers', 'Користувачам і розробникам, які хочуть локальний AI з простим інтерфейсом.', 'Users and developers who want local AI with a simple interface.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lmstudio.ai' OR LOWER(`name`) = 'lm studio') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An app for running local LLMs with the Bionic agent: chat, documents, code and voice input on your computer.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'LM Studio lets you download open models right in the app and run them via llama.cpp and MLX. The Bionic agent creates and edits documents, slides and PDFs, helps with code and automation, and transcribes voice locally. The free plan covers local models; paid Bionic+ and Pro add US-hosted open cloud models with zero data retention. Developers get a CLI and JavaScript and Python SDKs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'In-app model downloads
Agent for documents and code
Local voice transcription
CLI and SDKs for developers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Users and developers who want local AI with a simple interface.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Агент Bionic і локальні моделі.', 'Bionic agent and local models.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Bionic agent and local models.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Bionic+ / Pro', 'Bionic+ / Pro', NULL, 'month', 'Хмарні відкриті моделі й більші ліміти; ціни на сайті.', 'Cloud open models and higher limits; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Bionic+ / Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Bionic+ / Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Cloud open models and higher limits; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- GPT4All — Локальні LLM
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nomic.ai/gpt4all' OR LOWER(`name`) = 'gpt4all')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'GPT4All', NULL, 'https://www.nomic.ai/gpt4all', NULL, NULL, 'Безкоштовний локальний чат-бот від Nomic: відкриті моделі на Windows, macOS і Linux та чат із власними документами.', 'A free local chatbot from Nomic: open models on Windows, macOS and Linux, plus chat with your own documents.', 'GPT4All запускає відкриті мовні моделі прямо на вашому пристрої без хмари, тож дані не залишають комп''ютер. Функція LocalDocs дає змогу ставити запитання до власних файлів. Застосунок безкоштовний і з відкритим кодом, працює на Windows, macOS і Linux.', 'GPT4All runs open language models directly on your device without the cloud, so data never leaves your computer. The LocalDocs feature lets you ask questions about your own files. The app is free and open source and runs on Windows, macOS and Linux.', 'Локальні моделі без хмари
Чат із документами (LocalDocs)
Windows, macOS, Linux
Відкритий код', 'Local models without the cloud
Chat with documents (LocalDocs)
Windows, macOS, Linux
Open source', 'Користувачам, які хочуть приватний AI-чат без підписок.', 'Users who want a private AI chat without subscriptions.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nomic.ai/gpt4all' OR LOWER(`name`) = 'gpt4all') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free local chatbot from Nomic: open models on Windows, macOS and Linux, plus chat with your own documents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'GPT4All runs open language models directly on your device without the cloud, so data never leaves your computer. The LocalDocs feature lets you ask questions about your own files. The app is free and open source and runs on Windows, macOS and Linux.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Local models without the cloud
Chat with documents (LocalDocs)
Windows, macOS, Linux
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Users who want a private AI chat without subscriptions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Open source', 'Open source', 0.00, 'free', 'Безкоштовно, відкритий код.', 'Free, open source.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Open source' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free, open source.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Jan — Локальні LLM
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jan.ai' OR LOWER(`name`) = 'jan')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Jan', NULL, 'https://jan.ai', NULL, NULL, 'Відкрита альтернатива ChatGPT для комп''ютера: локальні моделі або підключення до хмарних GPT, Claude, Gemini.', 'An open-source ChatGPT alternative for your computer: local models or connections to cloud GPT, Claude and Gemini.', 'Jan — безкоштовний застосунок із відкритим кодом від Menlo Research. Можна завантажити відкриті моделі (Llama, Qwen, Gemma, DeepSeek, Mistral) і працювати офлайн або підключити власні ключі до OpenAI, Anthropic, Google. Проєкт розробляється публічно на GitHub, має мільйони завантажень і власні моделі на Hugging Face.', 'Jan is a free open-source app from Menlo Research. You can download open models (Llama, Qwen, Gemma, DeepSeek, Mistral) and work offline, or plug in your own keys for OpenAI, Anthropic and Google. The project is built in public on GitHub, has millions of downloads and its own models on Hugging Face.', 'Локальні відкриті моделі
Підключення хмарних моделей
Робота офлайн
Відкритий код', 'Local open models
Cloud model connections
Works offline
Open source', 'Тим, хто хоче один застосунок для локальних і хмарних моделей.', 'People who want one app for local and cloud models.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jan.ai' OR LOWER(`name`) = 'jan') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An open-source ChatGPT alternative for your computer: local models or connections to cloud GPT, Claude and Gemini.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Jan is a free open-source app from Menlo Research. You can download open models (Llama, Qwen, Gemma, DeepSeek, Mistral) and work offline, or plug in your own keys for OpenAI, Anthropic and Google. The project is built in public on GitHub, has millions of downloads and its own models on Hugging Face.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Local open models
Cloud model connections
Works offline
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want one app for local and cloud models.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Open source', 'Open source', 0.00, 'free', 'Безкоштовно, відкритий код.', 'Free, open source.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Open source' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free, open source.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- AnythingLLM — Локальні LLM
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'anythingllm.com' OR LOWER(`name`) = 'anythingllm')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'AnythingLLM', NULL, 'https://anythingllm.com', NULL, NULL, 'Приватний AI-асистент на вашому пристрої: чат із документами, агенти, нотатки зустрічей — без акаунтів і API-ключів.', 'A private AI assistant on your device: chat with documents, agents and meeting notes, with no accounts or API keys.', 'AnythingLLM працює повністю на комп''ютері: документи стають базою знань агента, є вебпошук, власні навички агентів і локальна транскрипція та підсумки зустрічей без ботів у дзвінку. Десктопна версія безкоштовна, є застосунок для Android і самостійне розгортання через Docker. Для команд — хмарний багатокористувацький простір.', 'AnythingLLM runs entirely on your computer: documents become the agent''s knowledge base, and there is web search, custom agent skills and local meeting transcription and summaries with no bots joining your call. The desktop app is free, with an Android app and self-hosting via Docker. Teams get a hosted multi-user workspace.', 'Чат із документами (RAG)
AI-агенти з навичками
Локальні нотатки зустрічей
Self-hosting через Docker', 'Chat with documents (RAG)
AI agents with skills
Local meeting notes
Self-hosting via Docker', 'Користувачам і командам, яким потрібен приватний AI для документів.', 'Users and teams who need private AI for their documents.', 'desktop,mobile,web', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'anythingllm.com' OR LOWER(`name`) = 'anythingllm') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A private AI assistant on your device: chat with documents, agents and meeting notes, with no accounts or API keys.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'AnythingLLM runs entirely on your computer: documents become the agent''s knowledge base, and there is web search, custom agent skills and local meeting transcription and summaries with no bots joining your call. The desktop app is free, with an Android app and self-hosting via Docker. Teams get a hosted multi-user workspace.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Chat with documents (RAG)
AI agents with skills
Local meeting notes
Self-hosting via Docker', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Users and teams who need private AI for their documents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Desktop', 'Desktop', 0.00, 'free', 'Десктопний застосунок і Docker-версія безкоштовні.', 'The desktop app and Docker version are free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Desktop' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Desktop', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The desktop app and Docker version are free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Cloud Basic', 'Cloud Basic', 50.00, 'month', 'Приватний хмарний екземпляр для невеликих команд.', 'Private hosted instance for small teams.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Cloud Basic' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Cloud Basic', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Private hosted instance for small teams.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Cloud Pro', 'Cloud Pro', 99.00, 'month', 'Пріоритетні ресурси, SLA підтримки 72 години.', 'Priority resources, 72-hour support SLA.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Cloud Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Cloud Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Priority resources, 72-hour support SLA.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Open WebUI — Локальні LLM
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'openwebui.com' OR LOWER(`name`) = 'open webui')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Open WebUI', NULL, 'https://openwebui.com', NULL, NULL, 'Self-hosted платформа з вебінтерфейсом для будь-яких моделей: Ollama, OpenAI-сумісні API, розширення на Python.', 'A self-hosted platform with a web interface for any model: Ollama, OpenAI-compatible APIs and Python extensions.', 'Open WebUI — вебінтерфейс для AI, який ви розгортаєте самі (Docker, pip або десктоп) і який може працювати повністю офлайн. Підключається до Ollama, OpenAI, Anthropic та будь-яких сумісних API, підтримує бази знань, інструменти й плагіни на Python, обмін напрацюваннями в спільноті. Для організацій є SSO, ролі, журнали аудиту й розгортання в ізольованих мережах.', 'Open WebUI is an AI web interface you deploy yourself (Docker, pip or desktop) that can run entirely offline. It connects to Ollama, OpenAI, Anthropic and any compatible API, supports knowledge bases, Python tools and plugins, and community sharing. Organizations get SSO, roles, audit logs and air-gapped deployment.', 'Підключення локальних і хмарних моделей
Робота офлайн
Плагіни й інструменти на Python
SSO та ролі для компаній', 'Local and cloud model connections
Works offline
Python plugins and tools
SSO and roles for companies', 'Розробникам, адміністраторам і компаніям, які розгортають AI у себе.', 'Developers, admins and companies that host AI themselves.', 'web,desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'openwebui.com' OR LOWER(`name`) = 'open webui') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A self-hosted platform with a web interface for any model: Ollama, OpenAI-compatible APIs and Python extensions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Open WebUI is an AI web interface you deploy yourself (Docker, pip or desktop) that can run entirely offline. It connects to Ollama, OpenAI, Anthropic and any compatible API, supports knowledge bases, Python tools and plugins, and community sharing. Organizations get SSO, roles, audit logs and air-gapped deployment.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Local and cloud model connections
Works offline
Python plugins and tools
SSO and roles for companies', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers, admins and companies that host AI themselves.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Open source', 'Open source', 0.00, 'free', 'Безкоштовне self-hosted розгортання.', 'Free self-hosted deployment.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Open source' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free self-hosted deployment.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Enterprise', 'Enterprise', NULL, 'year', 'Корпоративні функції й підтримка; ціна за запитом.', 'Enterprise features and support; price on request.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Enterprise' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Enterprise features and support; price on request.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- LocalAI — Локальні LLM
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'localai.io' OR LOWER(`name`) = 'localai')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'LocalAI', NULL, 'https://localai.io', NULL, NULL, 'Відкритий runtime для тексту, голосу, зображень і відео на власному залізі з API, сумісним з OpenAI.', 'An open-source runtime for text, voice, images and video on your own hardware with an OpenAI-compatible API.', 'LocalAI — один застосунок з API, сумісним з OpenAI, Anthropic, Ollama й ElevenLabs: наявні клієнти працюють, достатньо змінити адресу. Під капотом можна перемикати рушії (llama.cpp, vLLM, SGLang, MLX), а моделі встановлюються в один клік. Працює навіть на CPU без відеокарти й масштабується до кількох GPU. Ліцензія MIT.', 'LocalAI is a single binary with an API compatible with OpenAI, Anthropic, Ollama and ElevenLabs: existing clients keep working after a URL change. Engines can be swapped underneath (llama.cpp, vLLM, SGLang, MLX), and models install in one click. It runs even on CPU without a GPU and scales to multiple GPUs. MIT licensed.', 'API, сумісний з OpenAI й Anthropic
Текст, голос, зображення, відео
Працює на CPU
Змінні рушії інференсу', 'OpenAI- and Anthropic-compatible API
Text, voice, images, video
Runs on CPU
Swappable inference engines', 'Розробникам, які замінюють хмарні API локальними моделями.', 'Developers replacing cloud APIs with local models.', 'desktop', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'localai.io' OR LOWER(`name`) = 'localai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An open-source runtime for text, voice, images and video on your own hardware with an OpenAI-compatible API.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'LocalAI is a single binary with an API compatible with OpenAI, Anthropic, Ollama and ElevenLabs: existing clients keep working after a URL change. Engines can be swapped underneath (llama.cpp, vLLM, SGLang, MLX), and models install in one click. It runs even on CPU without a GPU and scales to multiple GPUs. MIT licensed.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'OpenAI- and Anthropic-compatible API
Text, voice, images, video
Runs on CPU
Swappable inference engines', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers replacing cloud APIs with local models.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Open source', 'Open source', 0.00, 'free', 'Безкоштовно, відкритий код.', 'Free, open source.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Open source' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free, open source.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Msty — Локальні LLM
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'msty.ai' OR LOWER(`name`) = 'msty')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Msty', NULL, 'https://msty.ai', NULL, NULL, 'Приватний AI-простір Msty Studio: локальні й онлайн-моделі, агенти та бази знань для людей і команд.', 'Msty Studio private AI workspace: local and online models, agents and knowledge bases for individuals and teams.', 'Msty Studio об''єднує чати з локальними та хмарними моделями, базу знань і агентів у єдиному робочому просторі з акцентом на приватність. Окремі продукти — Go для агентних сценаріїв, Nexus для керування моделями в організації й Stack для керованої бази знань. Studio має безкоштовний план; Aurum додає вебверсію та розширені функції, є довічна ліцензія.', 'Msty Studio brings chats with local and cloud models, a knowledge base and agents into one privacy-focused workspace. Separate products are Go for agent workflows, Nexus for model governance in organizations and Stack for a governed knowledge layer. Studio has a free plan; Aurum adds the web version and advanced features, and a lifetime license is available.', 'Локальні й онлайн-моделі
Бази знань
Агенти Msty Go
Довічна ліцензія', 'Local and online models
Knowledge bases
Msty Go agents
Lifetime license', 'Фахівцям і командам, яким важлива приватність роботи з AI.', 'Professionals and teams who care about private AI work.', 'desktop,web', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'msty.ai' OR LOWER(`name`) = 'msty') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Msty Studio private AI workspace: local and online models, agents and knowledge bases for individuals and teams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Msty Studio brings chats with local and cloud models, a knowledge base and agents into one privacy-focused workspace. Separate products are Go for agent workflows, Nexus for model governance in organizations and Stack for a governed knowledge layer. Studio has a free plan; Aurum adds the web version and advanced features, and a lifetime license is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Local and online models
Knowledge bases
Msty Go agents
Lifetime license', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Professionals and teams who care about private AI work.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Studio безкоштовно назавжди.', 'Studio free forever.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Studio free forever.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Aurum', 'Aurum', 149.00, 'year', 'За користувача на рік; вебверсія й розширені функції.', 'Per user per year; web version and advanced features.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Aurum' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Aurum', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Per user per year; web version and advanced features.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Aurum Lifetime', 'Aurum Lifetime', 349.00, 'one_time', 'Довічний доступ до функцій Aurum.', 'Lifetime access to Aurum features.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Aurum Lifetime' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Aurum Lifetime', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Lifetime access to Aurum features.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- llama.cpp — Локальні LLM
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/ggml-org/llama.cpp' OR LOWER(`name`) = 'llama.cpp')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'llama.cpp', NULL, 'https://github.com/ggml-org/llama.cpp', NULL, NULL, 'Бібліотека й набір утиліт на C/C++ для швидкого локального запуску LLM на CPU та GPU, з OpenAI-сумісним сервером.', 'A C/C++ library and toolset for fast local LLM inference on CPU and GPU, with an OpenAI-compatible server.', 'llama.cpp — відкритий проєкт ggml-org, на якому побудовано багато локальних AI-застосунків. Він запускає моделі у форматі GGUF на звичайних комп''ютерах, підтримує квантизацію, багато типів відеокарт і мультимодальні моделі. Можна завантажити модель з Hugging Face однією командою, спілкуватися в терміналі або підняти сервер з API, сумісним з OpenAI. Встановлення — скриптом, Docker або готовими збірками.', 'llama.cpp is an open-source ggml-org project that many local AI apps are built on. It runs GGUF models on ordinary computers, supports quantization, many GPU types and multimodal models. You can pull a model from Hugging Face with one command, chat in the terminal or start a server with an OpenAI-compatible API. Install via script, Docker or prebuilt binaries.', 'Моделі GGUF на CPU і GPU
Квантизація
OpenAI-сумісний сервер
Завантаження з Hugging Face', 'GGUF models on CPU and GPU
Quantization
OpenAI-compatible server
Hugging Face downloads', 'Розробникам і ентузіастам, які запускають моделі локально.', 'Developers and enthusiasts running models locally.', 'desktop', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/ggml-org/llama.cpp' OR LOWER(`name`) = 'llama.cpp') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A C/C++ library and toolset for fast local LLM inference on CPU and GPU, with an OpenAI-compatible server.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'llama.cpp is an open-source ggml-org project that many local AI apps are built on. It runs GGUF models on ordinary computers, supports quantization, many GPU types and multimodal models. You can pull a model from Hugging Face with one command, chat in the terminal or start a server with an OpenAI-compatible API. Install via script, Docker or prebuilt binaries.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'GGUF models on CPU and GPU
Quantization
OpenAI-compatible server
Hugging Face downloads', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers and enthusiasts running models locally.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Open source', 'Open source', 0.00, 'free', 'Безкоштовно, відкритий код.', 'Free, open source.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Open source' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free, open source.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- vLLM — Локальні LLM
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vllm.ai' OR LOWER(`name`) = 'vllm')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'vLLM', NULL, 'https://vllm.ai', NULL, NULL, 'Відкрита бібліотека для швидкого інференсу й обслуговування LLM на серверах з GPU з високою пропускною здатністю.', 'An open-source library for fast LLM inference and serving on GPU servers with high throughput.', 'vLLM створено в Sky Computing Lab Каліфорнійського університету в Берклі, тепер його розвиває велика спільнота. Технологія PagedAttention ефективно керує пам''яттю, а безперервне батчування, кешування префіксів, спекулятивне декодування й квантизація (FP8, INT4, GPTQ, AWQ, GGUF) дають високу пропускну здатність. Інтегрується з моделями Hugging Face і має сервер з API, сумісним з OpenAI.', 'vLLM was created at UC Berkeley''s Sky Computing Lab and is now developed by a large community. PagedAttention manages memory efficiently, while continuous batching, prefix caching, speculative decoding and quantization (FP8, INT4, GPTQ, AWQ, GGUF) deliver high throughput. It integrates with Hugging Face models and ships an OpenAI-compatible API server.', 'PagedAttention
Безперервне батчування
Квантизація моделей
OpenAI-сумісний сервер', 'PagedAttention
Continuous batching
Model quantization
OpenAI-compatible server', 'ML-інженерам, які обслуговують моделі в продакшні.', 'ML engineers serving models in production.', 'desktop', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vllm.ai' OR LOWER(`name`) = 'vllm') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An open-source library for fast LLM inference and serving on GPU servers with high throughput.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'vLLM was created at UC Berkeley''s Sky Computing Lab and is now developed by a large community. PagedAttention manages memory efficiently, while continuous batching, prefix caching, speculative decoding and quantization (FP8, INT4, GPTQ, AWQ, GGUF) deliver high throughput. It integrates with Hugging Face models and ships an OpenAI-compatible API server.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'PagedAttention
Continuous batching
Model quantization
OpenAI-compatible server', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'ML engineers serving models in production.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Open source', 'Open source', 0.00, 'free', 'Безкоштовно, відкритий код.', 'Free, open source.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Open source' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free, open source.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- llamafile — Локальні LLM
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/mozilla-ai/llamafile' OR LOWER(`name`) = 'llamafile')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'llamafile', NULL, 'https://github.com/mozilla-ai/llamafile', NULL, NULL, 'Проєкт Mozilla.ai: LLM в одному виконуваному файлі, що запускається на більшості ОС без встановлення.', 'A Mozilla.ai project: an LLM in a single executable file that runs on most operating systems without installation.', 'llamafile поєднує llama.cpp і Cosmopolitan Libc, щоб упакувати модель і все потрібне для її запуску в один файл. Його можна завантажити й запустити на Windows, macOS і Linux без встановлення. У комплекті є whisperfile — розпізнавання мовлення в одному файлі на основі whisper.cpp. Проєкт безкоштовний і з відкритим кодом.', 'llamafile combines llama.cpp and Cosmopolitan Libc to pack a model and everything needed to run it into one file. You can download and run it on Windows, macOS and Linux without installation. It also includes whisperfile, single-file speech-to-text based on whisper.cpp. The project is free and open source.', 'Модель в одному файлі
Без встановлення
Windows, macOS, Linux
Розпізнавання мовлення whisperfile', 'Model in a single file
No installation
Windows, macOS, Linux
whisperfile speech-to-text', 'Розробникам і користувачам, яким потрібен найпростіший спосіб поширити модель.', 'Developers and users who want a simple way to distribute a model.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/mozilla-ai/llamafile' OR LOWER(`name`) = 'llamafile') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A Mozilla.ai project: an LLM in a single executable file that runs on most operating systems without installation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'llamafile combines llama.cpp and Cosmopolitan Libc to pack a model and everything needed to run it into one file. You can download and run it on Windows, macOS and Linux without installation. It also includes whisperfile, single-file speech-to-text based on whisper.cpp. The project is free and open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Model in a single file
No installation
Windows, macOS, Linux
whisperfile speech-to-text', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers and users who want a simple way to distribute a model.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Open source', 'Open source', 0.00, 'free', 'Безкоштовно, відкритий код.', 'Free, open source.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Open source' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free, open source.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- KoboldCpp — Локальні LLM
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/lostruins/koboldcpp' OR LOWER(`name`) = 'koboldcpp')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'KoboldCpp', NULL, 'https://github.com/LostRuins/koboldcpp', NULL, NULL, 'Один файл без встановлення для локальних моделей GGUF з вебінтерфейсом: чат, історії, зображення, голос і API.', 'A single no-install file for local GGUF models with a web UI: chat, stories, images, voice and APIs.', 'KoboldCpp побудовано на llama.cpp з інтерфейсом KoboldAI Lite. Крім тексту в режимах чату, інструкцій і історій, він генерує зображення (Stable Diffusion, Flux), відео, мовлення й музику та розпізнає голос через Whisper. Має агента, інструменти MCP, RAG і сумісні API для OpenAI, Ollama, ComfyUI та інших. Працює на Windows, Linux і macOS, на CPU або GPU.', 'KoboldCpp is built on llama.cpp with the KoboldAI Lite interface. Besides text in chat, instruct and story modes, it generates images (Stable Diffusion, Flux), video, speech and music and transcribes voice with Whisper. It has an agent, MCP tools, RAG and compatible APIs for OpenAI, Ollama, ComfyUI and more. Runs on Windows, Linux and macOS, on CPU or GPU.', 'Один файл без встановлення
Текст, зображення, голос
Режими для історій і рольових ігор
Сумісні API', 'Single file, no install
Text, images, voice
Story and roleplay modes
Compatible APIs', 'Ентузіастам локального AI, письменникам і розробникам.', 'Local AI enthusiasts, writers and developers.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/lostruins/koboldcpp' OR LOWER(`name`) = 'koboldcpp') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A single no-install file for local GGUF models with a web UI: chat, stories, images, voice and APIs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'KoboldCpp is built on llama.cpp with the KoboldAI Lite interface. Besides text in chat, instruct and story modes, it generates images (Stable Diffusion, Flux), video, speech and music and transcribes voice with Whisper. It has an agent, MCP tools, RAG and compatible APIs for OpenAI, Ollama, ComfyUI and more. Runs on Windows, Linux and macOS, on CPU or GPU.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Single file, no install
Text, images, voice
Story and roleplay modes
Compatible APIs', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Local AI enthusiasts, writers and developers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Open source', 'Open source', 0.00, 'free', 'Безкоштовно, відкритий код.', 'Free, open source.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Open source' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free, open source.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- TextGen (oobabooga) — Локальні LLM
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/oobabooga/textgen' OR LOWER(`name`) = 'textgen (oobabooga)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TextGen (oobabooga)', NULL, 'https://github.com/oobabooga/textgen', NULL, NULL, 'Відкритий десктопний застосунок для локальних LLM без телеметрії: чат, зображення, інструменти, навчання LoRA й API.', 'An open-source desktop app for local LLMs with no telemetry: chat, vision, tools, LoRA training and an API.', 'TextGen (раніше text-generation-webui) — портативний застосунок: розпакуйте й запустіть, залежності вже всередині. Підтримує рушії llama.cpp, Transformers і ExLlamaV3, вкладення PDF і DOCX, виклик інструментів і MCP, навчання LoRA та генерацію зображень. Має API, сумісний з OpenAI й Anthropic, і працює повністю офлайн без телеметрії.', 'TextGen (formerly text-generation-webui) is a portable app: unzip and run, with dependencies included. It supports llama.cpp, Transformers and ExLlamaV3 backends, PDF and DOCX attachments, tool calling and MCP, LoRA training and image generation. It offers an OpenAI- and Anthropic-compatible API and runs fully offline with no telemetry.', 'Кілька рушіїв інференсу
Навчання LoRA
Виклик інструментів і MCP
Без телеметрії', 'Multiple inference backends
LoRA training
Tool calling and MCP
No telemetry', 'Досвідченим користувачам і розробникам локальних моделей.', 'Advanced users and developers of local models.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/oobabooga/textgen' OR LOWER(`name`) = 'textgen (oobabooga)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An open-source desktop app for local LLMs with no telemetry: chat, vision, tools, LoRA training and an API.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'TextGen (formerly text-generation-webui) is a portable app: unzip and run, with dependencies included. It supports llama.cpp, Transformers and ExLlamaV3 backends, PDF and DOCX attachments, tool calling and MCP, LoRA training and image generation. It offers an OpenAI- and Anthropic-compatible API and runs fully offline with no telemetry.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Multiple inference backends
LoRA training
Tool calling and MCP
No telemetry', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Advanced users and developers of local models.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Open source', 'Open source', 0.00, 'free', 'Безкоштовно, відкритий код.', 'Free, open source.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Open source' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free, open source.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Pinokio — Локальні LLM
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pinokio.co' OR LOWER(`name`) = 'pinokio')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Pinokio', NULL, 'https://pinokio.co', NULL, NULL, 'Браузер-лаунчер, що встановлює й запускає відкриті AI-застосунки на вашому комп''ютері в один клік.', 'A browser-style launcher that installs and runs open-source AI apps on your computer in one click.', 'Pinokio автоматизує встановлення відкритих AI-проєктів: генераторів зображень і відео, голосових моделей, локальних LLM. Замість ручного налаштування середовища достатньо обрати застосунок у каталозі й натиснути запуск. Є стрічка оновлень від авторів застосунків і спільнота. Pinokio безкоштовний.', 'Pinokio automates installing open-source AI projects: image and video generators, voice models and local LLMs. Instead of setting up environments by hand, you pick an app from the catalog and launch it. There is a feed of updates from app maintainers and a community. Pinokio is free.', 'Встановлення в один клік
Каталог відкритих AI-застосунків
Оновлення від авторів
Безкоштовно', 'One-click install
Catalog of open-source AI apps
Updates from maintainers
Free', 'Користувачам, які хочуть пробувати відкриті AI-проєкти без командного рядка.', 'Users who want to try open-source AI projects without the command line.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pinokio.co' OR LOWER(`name`) = 'pinokio') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A browser-style launcher that installs and runs open-source AI apps on your computer in one click.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Pinokio automates installing open-source AI projects: image and video generators, voice models and local LLMs. Instead of setting up environments by hand, you pick an app from the catalog and launch it. There is a feed of updates from app maintainers and a community. Pinokio is free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'One-click install
Catalog of open-source AI apps
Updates from maintainers
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Users who want to try open-source AI projects without the command line.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно.', 'Free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;


-- =================== Інференс і GPU-хмари / LLM Inference & GPU Cloud ===================
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'llm-inference' LIMIT 1);

-- Groq — Інференс і GPU-хмари
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'groq.com' OR LOWER(`name`) = 'groq')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Groq', NULL, 'https://groq.com', NULL, NULL, 'Хмара швидкого інференсу на власних чипах LPU: відкриті моделі, розпізнавання мовлення й TTS через API GroqCloud.', 'A fast inference cloud on its own LPU chips: open models, speech recognition and TTS through the GroqCloud API.', 'Groq розробив процесор LPU для інференсу й надає доступ до моделей через GroqCloud з API, сумісним з OpenAI. Доступні відкриті LLM (наприклад gpt-oss, Qwen), Whisper для розпізнавання мовлення, синтез мовлення й моделі модерації, а також вбудовані інструменти, пакетна обробка й кешування промптів. Оплата за токени, ціни для кожної моделі — в документації.', 'Groq designed the LPU processor for inference and offers models through GroqCloud with an OpenAI-compatible API. Available are open LLMs (e.g. gpt-oss, Qwen), Whisper speech recognition, text-to-speech and moderation models, plus built-in tools, batch processing and prompt caching. Billing is per token, with per-model prices in the docs.', 'Чипи LPU для інференсу
OpenAI-сумісний API
Whisper і TTS
Пакетна обробка', 'LPU chips for inference
OpenAI-compatible API
Whisper and TTS
Batch processing', 'Розробникам, яким потрібна низька затримка відповіді моделей.', 'Developers who need low-latency model responses.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'groq.com' OR LOWER(`name`) = 'groq') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A fast inference cloud on its own LPU chips: open models, speech recognition and TTS through the GroqCloud API.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Groq designed the LPU processor for inference and offers models through GroqCloud with an OpenAI-compatible API. Available are open LLMs (e.g. gpt-oss, Qwen), Whisper speech recognition, text-to-speech and moderation models, plus built-in tools, batch processing and prompt caching. Billing is per token, with per-model prices in the docs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'LPU chips for inference
OpenAI-compatible API
Whisper and TTS
Batch processing', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers who need low-latency model responses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Оплата за токени', 'Pay per token', NULL, 'month', 'Наприклад, gpt-oss-120b: $0.15 за 1 млн вхідних і $0.60 за 1 млн вихідних токенів.', 'For example, gpt-oss-120b: $0.15 per 1M input and $0.60 per 1M output tokens.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Оплата за токени' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pay per token', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For example, gpt-oss-120b: $0.15 per 1M input and $0.60 per 1M output tokens.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Together AI — Інференс і GPU-хмари
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'together.ai' OR LOWER(`name`) = 'together ai')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Together AI', NULL, 'https://www.together.ai', NULL, NULL, 'AI-хмара для відкритих моделей: serverless-інференс, виділені ендпоінти, донавчання й GPU-кластери.', 'An AI cloud for open models: serverless inference, dedicated endpoints, fine-tuning and GPU clusters.', 'Together AI надає API до сотень відкритих моделей для тексту, коду, зображень, відео й мовлення. Є пакетний інференс, виділені ендпоінти з гарантованою пропускною здатністю, запуск власних моделей у контейнерах, донавчання та кластери GPU на вимогу. Оплата за токени або за використання GPU.', 'Together AI provides APIs to hundreds of open models for text, code, images, video and speech. There is batch inference, dedicated endpoints with provisioned throughput, custom model containers, fine-tuning and on-demand GPU clusters. Billing is per token or per GPU usage.', 'Serverless API до відкритих моделей
Виділені ендпоінти
Донавчання моделей
GPU-кластери', 'Serverless API for open models
Dedicated endpoints
Model fine-tuning
GPU clusters', 'Стартапам і командам, що будують продукти на відкритих моделях.', 'Startups and teams building products on open models.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'together.ai' OR LOWER(`name`) = 'together ai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI cloud for open models: serverless inference, dedicated endpoints, fine-tuning and GPU clusters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Together AI provides APIs to hundreds of open models for text, code, images, video and speech. There is batch inference, dedicated endpoints with provisioned throughput, custom model containers, fine-tuning and on-demand GPU clusters. Billing is per token or per GPU usage.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Serverless API for open models
Dedicated endpoints
Model fine-tuning
GPU clusters', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Startups and teams building products on open models.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Оплата за токени', 'Pay per token', NULL, 'month', 'Ціна залежить від моделі; таблиця на сайті.', 'Price depends on the model; table on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Оплата за токени' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pay per token', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Price depends on the model; table on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Fireworks AI — Інференс і GPU-хмари
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fireworks.ai' OR LOWER(`name`) = 'fireworks ai')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Fireworks AI', NULL, 'https://fireworks.ai', NULL, NULL, 'Платформа інференсу й донавчання відкритих моделей: serverless-API, розгортання на GPU з посекундною оплатою.', 'An inference and fine-tuning platform for open models: serverless APIs and GPU deployments billed per second.', 'Fireworks AI від творців PyTorch дає змогу викликати відкриті моделі через API з оплатою за токени, розгортати їх на виділених GPU з посекундною оплатою та донавчати на власних даних (SFT, DPO). Сервіс Nexus маршрутизує запити між відкритими й закритими моделями, щоб знизити витрати на AI-кодинг. Для бізнесу є корпоративні розгортання.', 'Fireworks AI, from the creators of PyTorch, lets you call open models via a per-token API, deploy them on dedicated GPUs billed per second and fine-tune them on your own data (SFT, DPO). The Nexus service routes requests between open and closed models to cut AI coding costs. Enterprise deployments are available.', 'Serverless-інференс
GPU з посекундною оплатою
Донавчання моделей
Маршрутизація Nexus', 'Serverless inference
GPUs billed per second
Model fine-tuning
Nexus routing', 'Розробникам і компаніям, що адаптують відкриті моделі під себе.', 'Developers and companies customizing open models.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fireworks.ai' OR LOWER(`name`) = 'fireworks ai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An inference and fine-tuning platform for open models: serverless APIs and GPU deployments billed per second.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Fireworks AI, from the creators of PyTorch, lets you call open models via a per-token API, deploy them on dedicated GPUs billed per second and fine-tune them on your own data (SFT, DPO). The Nexus service routes requests between open and closed models to cut AI coding costs. Enterprise deployments are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Serverless inference
GPUs billed per second
Model fine-tuning
Nexus routing', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers and companies customizing open models.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Оплата за токени', 'Pay per token', NULL, 'month', 'Передоплачені кредити; ціна залежить від моделі.', 'Prepaid credits; price depends on the model.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Оплата за токени' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pay per token', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Prepaid credits; price depends on the model.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- DeepInfra — Інференс і GPU-хмари
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'deepinfra.com' OR LOWER(`name`) = 'deepinfra')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'DeepInfra', NULL, 'https://deepinfra.com', NULL, NULL, 'Хмара інференсу з API до відкритих моделей: текст, ембеддинги, зображення, мовлення та оренда GPU.', 'An inference cloud with APIs for open models: text, embeddings, images, speech and GPU rental.', 'DeepInfra надає API до популярних відкритих моделей (DeepSeek, Qwen, Llama, GLM, Kimi та інших) для генерації тексту, ембеддингів, ререйкінгу, зображень, відео й мовлення. Мовні моделі оплачуються за токени, інші — за час виконання; довгострокових контрактів немає. Також можна орендувати GPU на вимогу.', 'DeepInfra offers APIs for popular open models (DeepSeek, Qwen, Llama, GLM, Kimi and others) for text generation, embeddings, reranking, images, video and speech. Language models are billed per token, others by execution time, with no long-term contracts. On-demand GPUs are also available.', 'API до відкритих моделей
Ембеддинги й ререйкінг
Оренда GPU
Без довгострокових контрактів', 'APIs for open models
Embeddings and reranking
GPU rental
No long-term contracts', 'Розробникам, які шукають недорогий доступ до відкритих моделей.', 'Developers looking for affordable access to open models.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'deepinfra.com' OR LOWER(`name`) = 'deepinfra') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An inference cloud with APIs for open models: text, embeddings, images, speech and GPU rental.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'DeepInfra offers APIs for popular open models (DeepSeek, Qwen, Llama, GLM, Kimi and others) for text generation, embeddings, reranking, images, video and speech. Language models are billed per token, others by execution time, with no long-term contracts. On-demand GPUs are also available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'APIs for open models
Embeddings and reranking
GPU rental
No long-term contracts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers looking for affordable access to open models.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Оплата за токени', 'Pay per token', NULL, 'month', 'Оплата лише за використання; ціни моделей на сайті.', 'Pay only for usage; model prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Оплата за токени' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pay per token', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Pay only for usage; model prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Cerebras — Інференс і GPU-хмари
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cerebras.ai' OR LOWER(`name`) = 'cerebras')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Cerebras', NULL, 'https://www.cerebras.ai', NULL, NULL, 'Швидкий інференс на процесорі розміром з пластину: API Cerebras Inference з безкоштовним рівнем для розробки.', 'Fast inference on a wafer-scale chip: the Cerebras Inference API with a free tier for development.', 'Cerebras створює процесори на цілій кремнієвій пластині й надає через хмару Cerebras Inference доступ до відкритих моделей з високою швидкістю генерації. Є безкоштовний рівень для розробки й експериментів, оплата за токени для розробників і корпоративні плани за домовленістю. Сервіс також доступний через партнерів.', 'Cerebras builds wafer-scale processors and offers fast access to open models through the Cerebras Inference cloud. There is a free tier for development and experimentation, pay-per-token for developers and enterprise plans by agreement. The service is also available through partners.', 'Процесор на цілій пластині
Висока швидкість генерації
Безкоштовний рівень
Корпоративні плани', 'Wafer-scale processor
High generation speed
Free tier
Enterprise plans', 'Розробникам агентів і застосунків, де важлива швидкість.', 'Developers of agents and apps where speed matters.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cerebras.ai' OR LOWER(`name`) = 'cerebras') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Fast inference on a wafer-scale chip: the Cerebras Inference API with a free tier for development.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Cerebras builds wafer-scale processors and offers fast access to open models through the Cerebras Inference cloud. There is a free tier for development and experimentation, pay-per-token for developers and enterprise plans by agreement. The service is also available through partners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Wafer-scale processor
High generation speed
Free tier
Enterprise plans', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers of agents and apps where speed matters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Для розробки й експериментів, не для продакшну.', 'For development and experimentation, not production.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For development and experimentation, not production.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Оплата за токени', 'Pay per token', NULL, 'month', 'Тарифи розробника й Enterprise; ціни на сайті.', 'Developer and Enterprise tiers; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Оплата за токени' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pay per token', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Developer and Enterprise tiers; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Modal — Інференс і GPU-хмари
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'modal.com' OR LOWER(`name`) = 'modal')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Modal', NULL, 'https://modal.com', NULL, NULL, 'Серверна хмара для AI: інференс, навчання й пісочниці на GPU з посекундною оплатою і $30 безкоштовно щомісяця.', 'A serverless cloud for AI: inference, training and sandboxes on GPUs billed per second, with $30 free each month.', 'Modal запускає Python-код на GPU і CPU без керування серверами: контейнери стартують за секунди, а оплата йде посекундно без плати за простій. Платформа підходить для інференсу LLM, зображень і аудіо, навчання й RL, а також ізольованих пісочниць для агентів. План Starter включає $30 обчислень щомісяця; науковці можуть отримати до $10 тис. кредитів.', 'Modal runs Python code on GPUs and CPUs without managing servers: containers start in seconds and billing is per second with nothing charged for idle time. It fits LLM, image and audio inference, training and RL, and isolated sandboxes for agents. The Starter plan includes $30 of compute per month; academics can get up to $10k in credits.', 'GPU з посекундною оплатою
Швидкий старт контейнерів
Пісочниці для агентів
Навчання й донавчання', 'GPUs billed per second
Fast container starts
Sandboxes for agents
Training and fine-tuning', 'ML-інженерам і стартапам, які не хочуть керувати інфраструктурою.', 'ML engineers and startups who do not want to manage infrastructure.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'modal.com' OR LOWER(`name`) = 'modal') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A serverless cloud for AI: inference, training and sandboxes on GPUs billed per second, with $30 free each month.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Modal runs Python code on GPUs and CPUs without managing servers: containers start in seconds and billing is per second with nothing charged for idle time. It fits LLM, image and audio inference, training and RL, and isolated sandboxes for agents. The Starter plan includes $30 of compute per month; academics can get up to $10k in credits.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'GPUs billed per second
Fast container starts
Sandboxes for agents
Training and fine-tuning', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'ML engineers and startups who do not want to manage infrastructure.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Starter', 'Starter', 0.00, 'month', '$30 обчислень щомісяця безкоштовно, далі оплата за використання.', '$30 of free compute per month, then pay for usage.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Starter' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Starter', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$30 of free compute per month, then pay for usage.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Team', 'Team', 250.00, 'month', '$100 кредитів щомісяця, необмежено місць, плюс обчислення.', '$100 monthly credits, unlimited seats, plus compute.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Team' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Team', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$100 monthly credits, unlimited seats, plus compute.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Runpod — Інференс і GPU-хмари
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'runpod.io' OR LOWER(`name`) = 'runpod')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Runpod', NULL, 'https://www.runpod.io', NULL, NULL, 'GPU-хмара для AI-розробників: поди на вимогу в 31 регіоні, serverless-ендпоінти й кластери з посекундною оплатою.', 'A GPU cloud for AI developers: on-demand pods in 31 regions, serverless endpoints and clusters billed per second.', 'Runpod пропонує GPU на вимогу (від споживчих RTX до H100 і B200), serverless-ендпоінти для API-навантажень, багатовузлові кластери та Hub із готовими шаблонами відкритих моделей. Оплата посекундна, сховище — окремо за гігабайт. Є публічні ендпоінти популярних моделей зображень, відео й мовлення з оплатою за запит.', 'Runpod offers on-demand GPUs (from consumer RTX to H100 and B200), serverless endpoints for API workloads, multi-node clusters and a Hub of ready-made open model templates. Billing is per second, with storage priced per gigabyte. Public endpoints for popular image, video and speech models are billed per request.', 'GPU на вимогу
Serverless-ендпоінти
Багатовузлові кластери
Шаблони моделей', 'On-demand GPUs
Serverless endpoints
Multi-node clusters
Model templates', 'Розробникам і дослідникам, яким потрібні GPU без довгих контрактів.', 'Developers and researchers who need GPUs without long contracts.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'runpod.io' OR LOWER(`name`) = 'runpod') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A GPU cloud for AI developers: on-demand pods in 31 regions, serverless endpoints and clusters billed per second.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Runpod offers on-demand GPUs (from consumer RTX to H100 and B200), serverless endpoints for API workloads, multi-node clusters and a Hub of ready-made open model templates. Billing is per second, with storage priced per gigabyte. Public endpoints for popular image, video and speech models are billed per request.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'On-demand GPUs
Serverless endpoints
Multi-node clusters
Model templates', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers and researchers who need GPUs without long contracts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Оплата за використання', 'Pay as you go', NULL, 'month', 'Посекундна оплата GPU; ціна залежить від моделі відеокарти.', 'GPUs billed per second; price depends on the GPU model.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Оплата за використання' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pay as you go', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'GPUs billed per second; price depends on the GPU model.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Lambda — Інференс і GPU-хмари
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lambda.ai' OR LOWER(`name`) = 'lambda')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Lambda', NULL, 'https://lambda.ai', NULL, NULL, 'Хмара GPU від NVIDIA H100 до B200: інстанси на вимогу, кластери в один клік і зарезервовані потужності.', 'A GPU cloud from NVIDIA H100 to B200: on-demand instances, 1-Click Clusters and reserved capacity.', 'Lambda надає хмарні GPU для навчання й інференсу: інстанси на вимогу з погодинною оплатою, 1-Click Clusters на кілька тижнів чи місяців і великі зарезервовані суперкластери. Плата за вихідний трафік відсутня. Для розробників є Lambda Stack із готовими драйверами й ML-фреймворками.', 'Lambda provides cloud GPUs for training and inference: hourly on-demand instances, 1-Click Clusters for weeks or months and large reserved superclusters. There are no egress fees. Developers get Lambda Stack with drivers and ML frameworks preinstalled.', 'Інстанси GPU на вимогу
Кластери в один клік
Без плати за трафік
Lambda Stack', 'On-demand GPU instances
1-Click Clusters
No egress fees
Lambda Stack', 'Командам, що навчають і запускають великі моделі.', 'Teams training and running large models.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lambda.ai' OR LOWER(`name`) = 'lambda') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A GPU cloud from NVIDIA H100 to B200: on-demand instances, 1-Click Clusters and reserved capacity.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Lambda provides cloud GPUs for training and inference: hourly on-demand instances, 1-Click Clusters for weeks or months and large reserved superclusters. There are no egress fees. Developers get Lambda Stack with drivers and ML frameworks preinstalled.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'On-demand GPU instances
1-Click Clusters
No egress fees
Lambda Stack', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Teams training and running large models.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Інстанси на вимогу', 'On-demand instances', NULL, 'month', 'Погодинна оплата, наприклад A100 SXM від $1.99 за годину; ціни на сайті.', 'Hourly billing, e.g. A100 SXM from $1.99 per hour; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Інстанси на вимогу' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'On-demand instances', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Hourly billing, e.g. A100 SXM from $1.99 per hour; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Baseten — Інференс і GPU-хмари
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'baseten.co' OR LOWER(`name`) = 'baseten')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Baseten', NULL, 'https://www.baseten.co', NULL, NULL, 'Платформа продакшн-інференсу: виділені розгортання власних і відкритих моделей, Model API та навчання.', 'A production inference platform: dedicated deployments of custom and open models, Model APIs and training.', 'Baseten розгортає відкриті, власні й донавчені моделі на виділеній інфраструктурі з автомасштабуванням, швидким холодним стартом і високою доступністю між хмарами. Є Model API з оплатою за токени для популярних відкритих моделей і навчання. Платформа відповідає SOC 2 Type II і HIPAA; план Basic без абонплати, Pro і Enterprise — для більших навантажень.', 'Baseten deploys open, custom and fine-tuned models on dedicated infrastructure with autoscaling, fast cold starts and cross-cloud high availability. Model APIs bill per token for popular open models, and training is available. The platform is SOC 2 Type II and HIPAA compliant; the Basic plan has no monthly fee, with Pro and Enterprise for bigger workloads.', 'Виділені розгортання
Model API
Автомасштабування
SOC 2 та HIPAA', 'Dedicated deployments
Model APIs
Autoscaling
SOC 2 and HIPAA', 'Компаніям, що запускають AI-моделі в продакшні.', 'Companies running AI models in production.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'baseten.co' OR LOWER(`name`) = 'baseten') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A production inference platform: dedicated deployments of custom and open models, Model APIs and training.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Baseten deploys open, custom and fine-tuned models on dedicated infrastructure with autoscaling, fast cold starts and cross-cloud high availability. Model APIs bill per token for popular open models, and training is available. The platform is SOC 2 Type II and HIPAA compliant; the Basic plan has no monthly fee, with Pro and Enterprise for bigger workloads.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Dedicated deployments
Model APIs
Autoscaling
SOC 2 and HIPAA', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Companies running AI models in production.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Basic', 'Basic', 0.00, 'month', '$0 на місяць, оплата за використання.', '$0 per month, pay as you go.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Basic' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Basic', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$0 per month, pay as you go.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro / Enterprise', 'Pro / Enterprise', NULL, 'month', 'Пріоритетні обчислення й корпоративні функції; ціна за запитом.', 'Priority compute and enterprise features; price on request.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro / Enterprise' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro / Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Priority compute and enterprise features; price on request.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Novita AI — Інференс і GPU-хмари
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'novita.ai' OR LOWER(`name`) = 'novita ai')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Novita AI', NULL, 'https://novita.ai', NULL, NULL, 'AI-хмара для розробників: понад 200 моделей через один API, GPU-інстанси й пісочниці для агентів.', 'An AI cloud for developers: 200+ models through one API, GPU instances and agent sandboxes.', 'Novita AI об''єднує serverless-API до понад 200 моделей (LLM, зображення, аудіо, відео), виділені ендпоінти, GPU-інстанси й ізольовані пісочниці для AI-агентів. Пакетний інференс доступний зі знижкою на токени для підтримуваних моделей. Оплата за використання без прихованих платежів.', 'Novita AI combines serverless APIs to 200+ models (LLMs, image, audio, video), dedicated endpoints, GPU instances and isolated sandboxes for AI agents. Batch inference is available at a token discount for supported models. Pay-as-you-go pricing with no hidden fees.', '200+ моделей через один API
GPU-інстанси
Пісочниці для агентів
Пакетний інференс', '200+ models through one API
GPU instances
Agent sandboxes
Batch inference', 'Розробникам і стартапам, що будують AI-продукти.', 'Developers and startups building AI products.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'novita.ai' OR LOWER(`name`) = 'novita ai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI cloud for developers: 200+ models through one API, GPU instances and agent sandboxes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Novita AI combines serverless APIs to 200+ models (LLMs, image, audio, video), dedicated endpoints, GPU instances and isolated sandboxes for AI agents. Batch inference is available at a token discount for supported models. Pay-as-you-go pricing with no hidden fees.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '200+ models through one API
GPU instances
Agent sandboxes
Batch inference', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers and startups building AI products.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Оплата за токени', 'Pay per token', NULL, 'month', 'Ціни для кожної моделі на сайті.', 'Per-model prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Оплата за токени' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pay per token', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Per-model prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- OpenRouter — додатково в «Інференс і GPU-хмари»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('OpenRouter') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Replicate — додатково в «Інференс і GPU-хмари»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Replicate') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;


-- =================== Фреймворки для LLM-застосунків / LLM App Frameworks ===================
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'llm-frameworks' LIMIT 1);

-- LlamaIndex — Фреймворки для LLM-застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'llamaindex.ai' OR LOWER(`name`) = 'llamaindex')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'LlamaIndex', NULL, 'https://www.llamaindex.ai', NULL, NULL, 'Відкритий фреймворк для RAG і агентів над документами та хмарний LlamaParse для розбору й видобування даних із файлів.', 'An open-source framework for RAG and document agents, plus LlamaParse cloud for parsing and extracting data from files.', 'LlamaIndex відомий як фреймворк для підключення LLM до власних даних: індексування, пошук і агентні сценарії над документами. Хмарна платформа LlamaParse розбирає складні PDF, таблиці й креслення з урахуванням макета, видобуває структуровані дані та індексує їх для пошуку. Є відкрита локальна бібліотека LiteParse. Безкоштовний план включає 10 000 кредитів на місяць (~1000 сторінок).', 'LlamaIndex is known as a framework for connecting LLMs to your own data: indexing, retrieval and agent workflows over documents. The LlamaParse cloud platform parses complex PDFs, tables and drawings with layout awareness, extracts structured data and indexes it for search. There is also LiteParse, an open-source local library. The free plan includes 10,000 credits per month (~1,000 pages).', 'Фреймворк для RAG
Розбір документів LlamaParse
Видобування структурованих даних
Агенти над документами', 'RAG framework
LlamaParse document parsing
Structured data extraction
Document agents', 'Розробникам, які будують AI над корпоративними документами.', 'Developers building AI on top of company documents.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'llamaindex.ai' OR LOWER(`name`) = 'llamaindex') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An open-source framework for RAG and document agents, plus LlamaParse cloud for parsing and extracting data from files.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'LlamaIndex is known as a framework for connecting LLMs to your own data: indexing, retrieval and agent workflows over documents. The LlamaParse cloud platform parses complex PDFs, tables and drawings with layout awareness, extracts structured data and indexes it for search. There is also LiteParse, an open-source local library. The free plan includes 10,000 credits per month (~1,000 pages).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'RAG framework
LlamaParse document parsing
Structured data extraction
Document agents', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers building AI on top of company documents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'month', '10 000 кредитів на місяць.', '10,000 credits per month.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '10,000 credits per month.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Starter', 'Starter', 50.00, 'month', '40 000 кредитів.', '40K credits.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Starter' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Starter', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '40K credits.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro', 'Pro', 500.00, 'month', '400 000 кредитів.', '400K credits.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '400K credits.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Haystack — Фреймворки для LLM-застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'haystack.deepset.ai' OR LOWER(`name`) = 'haystack')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Haystack', NULL, 'https://haystack.deepset.ai', NULL, NULL, 'Відкритий Python-фреймворк від deepset для продакшн-агентів, RAG і пошуку з модульних компонентів.', 'An open-source Python framework from deepset for production agents, RAG and search built from modular components.', 'Haystack дає змогу збирати AI-системи з компонентів: ретриверів, генераторів, агентів і пайплайнів, з інтеграціями з десятками моделей і векторних баз. Встановлюється через pip, має докладні туторіали й кулінарну книгу прикладів. Для компаній deepset пропонує Haystack Enterprise з підтримкою та платформою.', 'Haystack lets you build AI systems from components: retrievers, generators, agents and pipelines, with integrations for dozens of models and vector databases. It installs via pip and has detailed tutorials and a cookbook. For companies, deepset offers Haystack Enterprise with support and a platform.', 'Модульні пайплайни
Агенти й RAG
Інтеграції з моделями та базами
Корпоративна підтримка', 'Modular pipelines
Agents and RAG
Model and database integrations
Enterprise support', 'Python-розробникам і ML-інженерам.', 'Python developers and ML engineers.', 'desktop', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'haystack.deepset.ai' OR LOWER(`name`) = 'haystack') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An open-source Python framework from deepset for production agents, RAG and search built from modular components.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Haystack lets you build AI systems from components: retrievers, generators, agents and pipelines, with integrations for dozens of models and vector databases. It installs via pip and has detailed tutorials and a cookbook. For companies, deepset offers Haystack Enterprise with support and a platform.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Modular pipelines
Agents and RAG
Model and database integrations
Enterprise support', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Python developers and ML engineers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Open source', 'Open source', 0.00, 'free', 'Безкоштовно, відкритий код.', 'Free, open source.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Open source' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free, open source.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Enterprise', 'Enterprise', NULL, 'year', 'Підтримка й платформа deepset; ціна за запитом.', 'deepset support and platform; price on request.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Enterprise' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'deepset support and platform; price on request.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Dify — Фреймворки для LLM-застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dify.ai' OR LOWER(`name`) = 'dify')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Dify', NULL, 'https://dify.ai', NULL, NULL, 'Платформа для агентних робочих процесів: візуальний конструктор агентів, бази знань і інструменти — в хмарі чи у себе.', 'A platform for agentic workflows: a visual builder for agents, knowledge bases and tools, in the cloud or self-hosted.', 'Dify дає змогу будувати агентів і робочі процеси на одному полотні: підключати моделі, готувати бази знань, додавати інструменти з маркетплейсу й публікувати застосунки через API. Розгортається в Dify Cloud, у вашому VPC або самостійно через Docker (Community Edition з відкритим кодом). Хмарний план Sandbox безкоштовний, Professional і Team оплачуються за робочий простір.', 'Dify lets you build agents and workflows on one canvas: connect models, prepare knowledge bases, add marketplace tools and publish apps via API. It deploys on Dify Cloud, in your VPC or self-hosted with Docker (the open-source Community Edition). The Sandbox cloud plan is free; Professional and Team are billed per workspace.', 'Візуальний конструктор агентів
Бази знань
Маркетплейс інструментів
Self-hosting', 'Visual agent builder
Knowledge bases
Tool marketplace
Self-hosting', 'Розробникам і бізнес-командам, що створюють AI-застосунки.', 'Developers and business teams creating AI apps.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dify.ai' OR LOWER(`name`) = 'dify') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A platform for agentic workflows: a visual builder for agents, knowledge bases and tools, in the cloud or self-hosted.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Dify lets you build agents and workflows on one canvas: connect models, prepare knowledge bases, add marketplace tools and publish apps via API. It deploys on Dify Cloud, in your VPC or self-hosted with Docker (the open-source Community Edition). The Sandbox cloud plan is free; Professional and Team are billed per workspace.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Visual agent builder
Knowledge bases
Tool marketplace
Self-hosting', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers and business teams creating AI apps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Sandbox', 'Sandbox', 0.00, 'free', '200 кредитів повідомлень.', '200 message credits.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Sandbox' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Sandbox', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '200 message credits.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Professional', 'Professional', 590.00, 'year', 'За робочий простір; 5000 кредитів повідомлень на місяць.', 'Per workspace; 5,000 message credits per month.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Professional' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Professional', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Per workspace; 5,000 message credits per month.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Team', 'Team', 1590.00, 'year', '10 000 кредитів на місяць, 50 учасників.', '10,000 credits per month, 50 members.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Team' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Team', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '10,000 credits per month, 50 members.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Langflow — Фреймворки для LLM-застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'langflow.org' OR LOWER(`name`) = 'langflow')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Langflow', NULL, 'https://www.langflow.org', NULL, NULL, 'Відкритий low-code конструктор AI-агентів, RAG-застосунків і MCP-серверів з підтримкою основних LLM і векторних баз.', 'An open-source low-code builder for AI agents, RAG apps and MCP servers, supporting major LLMs and vector databases.', 'Langflow — візуальний редактор, у якому агентів і RAG-пайплайни збирають із блоків, а кожен компонент можна відкрити й змінити на Python. Підтримує основні мовні моделі, векторні бази й бібліотеку інструментів, а готовий потік можна розгорнути як API або MCP-сервер. Доступний як десктопний застосунок і самостійне розгортання з відкритим кодом.', 'Langflow is a visual editor where agents and RAG pipelines are built from blocks, and every component can be opened and changed in Python. It supports major language models, vector databases and a tool library, and a finished flow can be deployed as an API or an MCP server. It is available as a desktop app and as open-source self-hosting.', 'Візуальні потоки
Редагування компонентів на Python
Розгортання як API чи MCP
Відкритий код', 'Visual flows
Python-editable components
Deploy as API or MCP
Open source', 'Розробникам, які хочуть швидко прототипувати агентів.', 'Developers who want to prototype agents quickly.', 'desktop,web', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'langflow.org' OR LOWER(`name`) = 'langflow') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An open-source low-code builder for AI agents, RAG apps and MCP servers, supporting major LLMs and vector databases.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Langflow is a visual editor where agents and RAG pipelines are built from blocks, and every component can be opened and changed in Python. It supports major language models, vector databases and a tool library, and a finished flow can be deployed as an API or an MCP server. It is available as a desktop app and as open-source self-hosting.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Visual flows
Python-editable components
Deploy as API or MCP
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers who want to prototype agents quickly.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Open source', 'Open source', 0.00, 'free', 'Безкоштовно, відкритий код.', 'Free, open source.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Open source' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free, open source.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- LiteLLM — Фреймворки для LLM-застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'litellm.ai' OR LOWER(`name`) = 'litellm')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'LiteLLM', NULL, 'https://www.litellm.ai', NULL, NULL, 'Відкритий AI-шлюз і Python SDK: виклик понад 100 LLM у форматі OpenAI, облік витрат, ліміти й маршрутизація.', 'An open-source AI gateway and Python SDK: call 100+ LLMs in the OpenAI format with spend tracking, limits and routing.', 'LiteLLM ставить усі моделі за єдиний ключ і API у форматі OpenAI. Шлюз показує витрати за командами, обмежує бюджети, логує запити, керує доступом до MCP-інструментів і агентів та маршрутизує запити до відповідних моделей. Розгортається самостійно за кілька хвилин; для компаній є Enterprise із підтримкою.', 'LiteLLM puts all models behind one key and an OpenAI-format API. The gateway shows spend by team, caps budgets, logs requests, governs access to MCP tools and agents and routes requests to the right models. It self-hosts in minutes; companies can get Enterprise with support.', '100+ LLM через один API
Облік і ліміти витрат
Шлюз для MCP і агентів
Маршрутизація запитів', '100+ LLMs through one API
Spend tracking and limits
MCP and agent gateway
Request routing', 'Платформним командам і розробникам, що працюють з кількома моделями.', 'Platform teams and developers working with several models.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'litellm.ai' OR LOWER(`name`) = 'litellm') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An open-source AI gateway and Python SDK: call 100+ LLMs in the OpenAI format with spend tracking, limits and routing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'LiteLLM puts all models behind one key and an OpenAI-format API. The gateway shows spend by team, caps budgets, logs requests, governs access to MCP tools and agents and routes requests to the right models. It self-hosts in minutes; companies can get Enterprise with support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '100+ LLMs through one API
Spend tracking and limits
MCP and agent gateway
Request routing', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Platform teams and developers working with several models.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Open source', 'Open source', 0.00, 'free', 'Безкоштовно, відкритий код.', 'Free, open source.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Open source' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free, open source.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Enterprise', 'Enterprise', NULL, 'year', 'Корпоративні функції й підтримка; ціна за запитом.', 'Enterprise features and support; price on request.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Enterprise' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Enterprise features and support; price on request.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Unsloth — Фреймворки для LLM-застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'unsloth.ai' OR LOWER(`name`) = 'unsloth')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Unsloth', NULL, 'https://unsloth.ai', NULL, NULL, 'Відкритий інструмент і десктопний застосунок для швидкого донавчання й запуску моделей на власному залізі.', 'An open-source tool and desktop app for fast fine-tuning and running models on your own hardware.', 'Unsloth прискорює донавчання LLM (LoRA, 4- і 16-бітне) і зменшує використання відеопам''яті. Unsloth Desktop — безкоштовний застосунок без коду для Mac, Windows і Linux, у якому можна запускати й навчати текстові, графічні, відео- та аудіомоделі локально. Платні Pro та Enterprise додають ще швидше навчання й підтримку кількох GPU.', 'Unsloth speeds up LLM fine-tuning (LoRA, 4-bit and 16-bit) and reduces VRAM use. Unsloth Desktop is a free no-code app for Mac, Windows and Linux where you can run and train text, image, video and audio models locally. Paid Pro and Enterprise add even faster training and multi-GPU support.', 'Швидке донавчання LoRA
Менше відеопам''яті
Десктопний застосунок без коду
Підтримка кількох GPU', 'Fast LoRA fine-tuning
Lower VRAM use
No-code desktop app
Multi-GPU support', 'ML-інженерам і ентузіастам, що адаптують моделі під свої дані.', 'ML engineers and enthusiasts adapting models to their data.', 'desktop', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'unsloth.ai' OR LOWER(`name`) = 'unsloth') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An open-source tool and desktop app for fast fine-tuning and running models on your own hardware.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Unsloth speeds up LLM fine-tuning (LoRA, 4-bit and 16-bit) and reduces VRAM use. Unsloth Desktop is a free no-code app for Mac, Windows and Linux where you can run and train text, image, video and audio models locally. Paid Pro and Enterprise add even faster training and multi-GPU support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Fast LoRA fine-tuning
Lower VRAM use
No-code desktop app
Multi-GPU support', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'ML engineers and enthusiasts adapting models to their data.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Відкрита версія й Unsloth Desktop.', 'Open-source version and Unsloth Desktop.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open-source version and Unsloth Desktop.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro / Enterprise', 'Pro / Enterprise', NULL, 'month', 'Швидше навчання й кілька GPU; ціна за запитом.', 'Faster training and multi-GPU; price on request.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro / Enterprise' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro / Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Faster training and multi-GPU; price on request.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Axolotl — Фреймворки для LLM-застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'axolotl.ai' OR LOWER(`name`) = 'axolotl')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Axolotl', NULL, 'https://axolotl.ai', NULL, NULL, 'Безкоштовний фреймворк із відкритим кодом для донавчання LLM: конфіги YAML, кілька GPU, готові рецепти.', 'A free open-source framework for LLM fine-tuning: YAML configs, multi-GPU training and ready-made recipes.', 'Axolotl спрощує донавчання мовних моделей: налаштування описується в YAML, а фреймворк підтримує LoRA, QLoRA, повне навчання, DPO та інші методи. Працює з багатьма моделями (Llama, Qwen, Gemma, Mistral, GPT-OSS) і масштабується на кілька GPU та вузлів. Є кулінарні книги й ноутбуки для старту.', 'Axolotl simplifies fine-tuning language models: configuration lives in YAML, and the framework supports LoRA, QLoRA, full fine-tuning, DPO and other methods. It works with many models (Llama, Qwen, Gemma, Mistral, GPT-OSS) and scales across multiple GPUs and nodes. Cookbooks and notebooks help you get started.', 'Конфігурація в YAML
LoRA, QLoRA, DPO
Кілька GPU і вузлів
Готові рецепти', 'YAML configuration
LoRA, QLoRA, DPO
Multi-GPU and multi-node
Ready-made recipes', 'ML-інженерам і дослідникам.', 'ML engineers and researchers.', 'desktop', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'axolotl.ai' OR LOWER(`name`) = 'axolotl') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free open-source framework for LLM fine-tuning: YAML configs, multi-GPU training and ready-made recipes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Axolotl simplifies fine-tuning language models: configuration lives in YAML, and the framework supports LoRA, QLoRA, full fine-tuning, DPO and other methods. It works with many models (Llama, Qwen, Gemma, Mistral, GPT-OSS) and scales across multiple GPUs and nodes. Cookbooks and notebooks help you get started.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'YAML configuration
LoRA, QLoRA, DPO
Multi-GPU and multi-node
Ready-made recipes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'ML engineers and researchers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Open source', 'Open source', 0.00, 'free', 'Безкоштовно, відкритий код.', 'Free, open source.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Open source' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free, open source.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- LangChain — додатково в «Фреймворки для LLM-застосунків»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('LangChain') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- CrewAI — додатково в «Фреймворки для LLM-застосунків»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('CrewAI') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;


-- =================== Моніторинг і оцінка LLM / LLMOps & Evaluation ===================
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'llmops' LIMIT 1);

-- Langfuse — Моніторинг і оцінка LLM
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'langfuse.com' OR LOWER(`name`) = 'langfuse')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Langfuse', NULL, 'https://langfuse.com', NULL, NULL, 'Відкрита платформа для трасування, оцінки й покращення AI-агентів: спостережуваність, керування промптами, метрики.', 'An open-source platform for tracing, evaluating and improving AI agents: observability, prompt management and metrics.', 'Langfuse збирає трасування запитів до LLM і агентів, дає змогу оцінювати відповіді (автоматично й вручну), керувати версіями промптів і стежити за вартістю та затримками. Інтегрується з OpenAI, LangChain та SDK для Python і JS, може розгортатися самостійно. Хмарний план Hobby безкоштовний без картки; Core і Pro — для продакшну.', 'Langfuse collects traces of LLM and agent calls, lets you evaluate outputs (automatically and manually), version prompts and track cost and latency. It integrates with OpenAI, LangChain and Python and JS SDKs, and can be self-hosted. The Hobby cloud plan is free with no card; Core and Pro are for production.', 'Трасування LLM і агентів
Оцінка відповідей
Керування промптами
Self-hosting', 'LLM and agent tracing
Output evaluation
Prompt management
Self-hosting', 'Командам, що запускають LLM-застосунки в продакшн.', 'Teams shipping LLM apps to production.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'langfuse.com' OR LOWER(`name`) = 'langfuse') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An open-source platform for tracing, evaluating and improving AI agents: observability, prompt management and metrics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Langfuse collects traces of LLM and agent calls, lets you evaluate outputs (automatically and manually), version prompts and track cost and latency. It integrates with OpenAI, LangChain and Python and JS SDKs, and can be self-hosted. The Hobby cloud plan is free with no card; Core and Pro are for production.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'LLM and agent tracing
Output evaluation
Prompt management
Self-hosting', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Teams shipping LLM apps to production.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Hobby', 'Hobby', 0.00, 'free', 'Для хобі-проєктів і пілотів.', 'For hobby projects and POCs.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Hobby' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Hobby', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For hobby projects and POCs.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Core', 'Core', 29.00, 'month', '100 тис. одиниць на місяць, далі $8 за 100 тис.', '100k units per month, then $8 per 100k.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Core' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Core', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '100k units per month, then $8 per 100k.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro', 'Pro', 199.00, 'month', 'Необмежена історія, високі ліміти.', 'Unlimited history, high rate limits.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Unlimited history, high rate limits.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- LangSmith — Моніторинг і оцінка LLM
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'langchain.com/langsmith' OR LOWER(`name`) = 'langsmith')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'LangSmith', NULL, 'https://www.langchain.com/langsmith', NULL, NULL, 'Платформа LangChain для спостережуваності, оцінки й розгортання агентів, сумісна з будь-яким фреймворком.', 'LangChain''s platform for observability, evaluation and deployment of agents, compatible with any framework.', 'LangSmith показує, що саме роблять агенти: трасування кожного кроку, оцінки якості, експерименти з промптами. Окремі модулі відповідають за розгортання агентів, пісочниці для виконання коду та шлюз для викликів моделей. План Developer — одне безкоштовне місце з 5 тис. базових трасувань на місяць; Plus — для команд.', 'LangSmith shows exactly what your agents do: step-by-step tracing, quality evaluations and prompt experiments. Separate modules handle agent deployment, sandboxes for running code and a gateway for model calls. The Developer plan is one free seat with 5k base traces per month; Plus is for teams.', 'Трасування агентів
Оцінки якості
Розгортання агентів
Шлюз для моделей', 'Agent tracing
Quality evaluations
Agent deployment
Model gateway', 'Розробникам агентів на LangChain та інших фреймворках.', 'Agent developers on LangChain and other frameworks.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'langchain.com/langsmith' OR LOWER(`name`) = 'langsmith') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'LangChain''s platform for observability, evaluation and deployment of agents, compatible with any framework.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'LangSmith shows exactly what your agents do: step-by-step tracing, quality evaluations and prompt experiments. Separate modules handle agent deployment, sandboxes for running code and a gateway for model calls. The Developer plan is one free seat with 5k base traces per month; Plus is for teams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Agent tracing
Quality evaluations
Agent deployment
Model gateway', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Agent developers on LangChain and other frameworks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Developer', 'Developer', 0.00, 'month', '1 місце, 5 тис. трасувань на місяць, далі оплата за використання.', '1 seat, 5k traces per month, then pay as you go.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Developer' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Developer', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '1 seat, 5k traces per month, then pay as you go.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Plus', 'Plus', 39.00, 'month', 'За місце на місяць.', 'Per seat per month.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Plus' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Plus', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Per seat per month.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Weights & Biases — Моніторинг і оцінка LLM
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wandb.ai' OR LOWER(`name`) = 'weights & biases')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Weights & Biases', NULL, 'https://wandb.ai', NULL, NULL, 'Платформа для AI-розробників: відстеження експериментів навчання моделей і Weave для трасування й оцінки LLM-застосунків.', 'An AI developer platform: experiment tracking for model training and Weave for tracing and evaluating LLM apps.', 'Weights & Biases (тепер частина CoreWeave) відстежує експерименти машинного навчання, версії даних і моделей, а модуль Weave трасує LLM-застосунки, запускає оцінки й моніторить їх у продакшні. Використовується для навчання й донавчання LLM, RAG, комп''ютерного зору. Безкоштовний план для особистих проєктів, Pro для професіоналів і безкоштовний доступ для академічних досліджень.', 'Weights & Biases (now part of CoreWeave) tracks machine learning experiments, data and model versions, while Weave traces LLM apps, runs evaluations and monitors them in production. It is used for training and fine-tuning LLMs, RAG and computer vision. There is a free plan for personal projects, Pro for professionals and free access for academic research.', 'Відстеження експериментів
Трасування Weave
Оцінки LLM
Версії даних і моделей', 'Experiment tracking
Weave tracing
LLM evaluations
Data and model versioning', 'ML-інженерам, дослідникам і командам AI-розробки.', 'ML engineers, researchers and AI development teams.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wandb.ai' OR LOWER(`name`) = 'weights & biases') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI developer platform: experiment tracking for model training and Weave for tracing and evaluating LLM apps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Weights & Biases (now part of CoreWeave) tracks machine learning experiments, data and model versions, while Weave traces LLM apps, runs evaluations and monitors them in production. It is used for training and fine-tuning LLMs, RAG and computer vision. There is a free plan for personal projects, Pro for professionals and free access for academic research.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Experiment tracking
Weave tracing
LLM evaluations
Data and model versioning', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'ML engineers, researchers and AI development teams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Для особистих проєктів.', 'For personal projects.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For personal projects.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro', 'Pro', 60.00, 'month', 'Від $60 на місяць, 30 днів пробного періоду.', 'From $60 per month, 30-day free trial.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'From $60 per month, 30-day free trial.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Helicone — Моніторинг і оцінка LLM
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'helicone.ai' OR LOWER(`name`) = 'helicone')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Helicone', NULL, 'https://www.helicone.ai', NULL, NULL, 'Відкрита LLMOps-платформа для маршрутизації й моніторингу AI-застосунків: логи запитів, сесії, промпти, алерти.', 'An open-source LLMOps platform for routing and monitoring AI apps: request logs, sessions, prompts and alerts.', 'Helicone підключається як шлюз між застосунком і моделями: логує запити, показує вартість, затримки й сесії користувачів, дає змогу керувати промптами, датасетами й алертами. Є власна мова запитів HQL для аналітики. План Hobby безкоштовний (10 тис. запитів), Pro і Team — для зростаючих команд; стартапам і неприбутковим організаціям надаються знижки.', 'Helicone connects as a gateway between your app and models: it logs requests, shows cost, latency and user sessions, and manages prompts, datasets and alerts. It has its own HQL query language for analytics. The Hobby plan is free (10k requests), with Pro and Team for growing teams; startups and non-profits get discounts.', 'Шлюз і маршрутизація
Логи й вартість запитів
Керування промптами
Алерти та звіти', 'Gateway and routing
Request logs and cost
Prompt management
Alerts and reports', 'Командам, що стежать за якістю й вартістю LLM-застосунків.', 'Teams tracking the quality and cost of LLM apps.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'helicone.ai' OR LOWER(`name`) = 'helicone') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An open-source LLMOps platform for routing and monitoring AI apps: request logs, sessions, prompts and alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Helicone connects as a gateway between your app and models: it logs requests, shows cost, latency and user sessions, and manages prompts, datasets and alerts. It has its own HQL query language for analytics. The Hobby plan is free (10k requests), with Pro and Team for growing teams; startups and non-profits get discounts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Gateway and routing
Request logs and cost
Prompt management
Alerts and reports', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Teams tracking the quality and cost of LLM apps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Hobby', 'Hobby', 0.00, 'free', '10 тис. запитів, 1 ГБ сховища.', '10k requests, 1 GB storage.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Hobby' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Hobby', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '10k requests, 1 GB storage.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro', 'Pro', 79.00, 'month', 'Необмежено місць, алерти й звіти.', 'Unlimited seats, alerts and reports.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Unlimited seats, alerts and reports.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Team', 'Team', 799.00, 'month', 'Для компаній, що масштабуються.', 'For scaling companies.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Team' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Team', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For scaling companies.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Arize Phoenix — Моніторинг і оцінка LLM
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'phoenix.arize.com' OR LOWER(`name`) = 'arize phoenix')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Arize Phoenix', NULL, 'https://phoenix.arize.com', NULL, NULL, 'Відкритий інструмент Arize для трасування, оцінки й налагодження агентів і LLM-застосунків з self-hosting.', 'An open-source Arize tool for tracing, evaluating and debugging agents and LLM apps, with self-hosting.', 'Phoenix трасує виклики LLM і агентів на основі OpenTelemetry, запускає оцінки й експерименти та порівнює результати. Його можна розгорнути у власному середовищі безкоштовно. Хмарна платформа Arize AX додає моніторинг продакшну й командну роботу: AX Free для розробників і AX Pro для команд.', 'Phoenix traces LLM and agent calls based on OpenTelemetry, runs evaluations and experiments and compares results. It can be self-hosted for free. The Arize AX cloud platform adds production monitoring and collaboration: AX Free for builders and AX Pro for teams.', 'Трасування на OpenTelemetry
Оцінки й експерименти
Self-hosting
Хмара Arize AX', 'OpenTelemetry tracing
Evaluations and experiments
Self-hosting
Arize AX cloud', 'AI-інженерам, що налагоджують агентів.', 'AI engineers debugging agents.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'phoenix.arize.com' OR LOWER(`name`) = 'arize phoenix') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An open-source Arize tool for tracing, evaluating and debugging agents and LLM apps, with self-hosting.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Phoenix traces LLM and agent calls based on OpenTelemetry, runs evaluations and experiments and compares results. It can be self-hosted for free. The Arize AX cloud platform adds production monitoring and collaboration: AX Free for builders and AX Pro for teams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'OpenTelemetry tracing
Evaluations and experiments
Self-hosting
Arize AX cloud', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'AI engineers debugging agents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Open source / AX Free', 'Open source / AX Free', 0.00, 'free', 'Phoenix з відкритим кодом і хмарний AX Free (25 тис. спанів на місяць).', 'Open-source Phoenix and AX Free cloud (25k spans per month).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Open source / AX Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Open source / AX Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open-source Phoenix and AX Free cloud (25k spans per month).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'AX Pro', 'AX Pro', 50.00, 'month', '50 тис. спанів, 10 ГБ на місяць.', '50k spans, 10 GB per month.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'AX Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'AX Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '50k spans, 10 GB per month.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Braintrust — Моніторинг і оцінка LLM
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'braintrust.dev' OR LOWER(`name`) = 'braintrust')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Braintrust', NULL, 'https://www.braintrust.dev', NULL, NULL, 'Платформа спостережуваності й оцінок для AI-агентів: трасування продакшну, евали й виявлення регресій.', 'An observability and evaluation platform for AI agents: production tracing, evals and regression detection.', 'Braintrust трасує роботу агентів у продакшні, запускає евали на наборах даних і показує регресії до того, як їх побачать користувачі. Є інструменти для пошуку закономірностей у поведінці, порівняння промптів і моделей та командна робота. Безкоштовний план включає трасування й евали для всієї команди; Pro додає більші обсяги й довше зберігання.', 'Braintrust traces agents in production, runs evals on datasets and surfaces regressions before users notice them. It includes tools for finding behavior patterns, comparing prompts and models, and team collaboration. The free plan includes tracing and evals for your whole team; Pro adds higher volumes and longer retention.', 'Трасування продакшну
Евали на датасетах
Виявлення регресій
Порівняння промптів', 'Production tracing
Dataset evals
Regression detection
Prompt comparison', 'Командам, що будують AI-продукти й контролюють їхню якість.', 'Teams building AI products and controlling their quality.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'braintrust.dev' OR LOWER(`name`) = 'braintrust') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An observability and evaluation platform for AI agents: production tracing, evals and regression detection.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Braintrust traces agents in production, runs evals on datasets and surfaces regressions before users notice them. It includes tools for finding behavior patterns, comparing prompts and models, and team collaboration. The free plan includes tracing and evals for your whole team; Pro adds higher volumes and longer retention.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Production tracing
Dataset evals
Regression detection
Prompt comparison', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Teams building AI products and controlling their quality.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'month', '$10 кредитів, 1 ГБ даних, 14 днів зберігання.', '$10 credits, 1 GB data, 14-day retention.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$10 credits, 1 GB data, 14-day retention.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro', 'Pro', 249.00, 'month', '$100 кредитів, 5 ГБ даних, 30 днів зберігання.', '$100 credits, 5 GB data, 30-day retention.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$100 credits, 5 GB data, 30-day retention.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Promptfoo — Моніторинг і оцінка LLM
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'promptfoo.dev' OR LOWER(`name`) = 'promptfoo')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Promptfoo', NULL, 'https://www.promptfoo.dev', NULL, NULL, 'Відкритий інструмент для тестування й червоної команди LLM-застосунків: евали, пошук вразливостей, guardrails.', 'An open-source tool for testing and red teaming LLM apps: evals, vulnerability scanning and guardrails.', 'Promptfoo дає змогу описати тести для промптів і моделей та порівнювати результати, а модуль red teaming автоматично шукає вразливості: jailbreak, витоки даних, prompt injection. Є сканування коду в IDE і CI/CD, guardrails у реальному часі та проксі для MCP. Версія Community безкоштовна з відкритим кодом; для компаній є Enterprise.', 'Promptfoo lets you define tests for prompts and models and compare results, while the red teaming module automatically looks for vulnerabilities: jailbreaks, data leaks and prompt injection. It offers code scanning in the IDE and CI/CD, real-time guardrails and an MCP proxy. The Community version is free and open source; companies can use Enterprise.', 'Евали промптів і моделей
Red teaming
Сканування коду в CI/CD
Guardrails', 'Prompt and model evals
Red teaming
Code scanning in CI/CD
Guardrails', 'Розробникам і командам безпеки AI-застосунків.', 'Developers and security teams of AI apps.', 'web,desktop', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'promptfoo.dev' OR LOWER(`name`) = 'promptfoo') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An open-source tool for testing and red teaming LLM apps: evals, vulnerability scanning and guardrails.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Promptfoo lets you define tests for prompts and models and compare results, while the red teaming module automatically looks for vulnerabilities: jailbreaks, data leaks and prompt injection. It offers code scanning in the IDE and CI/CD, real-time guardrails and an MCP proxy. The Community version is free and open source; companies can use Enterprise.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Prompt and model evals
Red teaming
Code scanning in CI/CD
Guardrails', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers and security teams of AI apps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Community', 'Community', 0.00, 'free', 'Відкритий код, red teaming до 10 тис. проб на місяць.', 'Open source, red teaming up to 10k probes per month.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Community' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Community', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open source, red teaming up to 10k probes per month.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Enterprise', 'Enterprise', NULL, 'year', 'Ціна за запитом.', 'Price on request.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Enterprise' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Price on request.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Portkey — Моніторинг і оцінка LLM
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'portkey.ai' OR LOWER(`name`) = 'portkey')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Portkey', NULL, 'https://portkey.ai', NULL, NULL, 'AI-шлюз для продакшну: єдиний API до моделей, спостережуваність, керування промптами й ключами, маршрутизація.', 'A production AI gateway: one API to models, observability, prompt and key management and routing.', 'Portkey дає командам єдиний API для багатьох провайдерів моделей, логи й метрики кожного запиту, керування промптами, віртуальні ключі, резервні маршрути й балансування навантаження. Тепер продукт також доступний як Prisma AIRS AI Gateway від Palo Alto Networks для корпоративних клієнтів. План Developer безкоштовний (10 тис. логів на місяць), Production — для продакшн-навантажень.', 'Portkey gives teams one API for many model providers, logs and metrics for every request, prompt management, virtual keys, fallbacks and load balancing. The product is now also offered to enterprises as Prisma AIRS AI Gateway by Palo Alto Networks. The Developer plan is free (10k logs per month); Production is for production workloads.', 'Єдиний API до моделей
Логи й метрики
Віртуальні ключі
Резервні маршрути', 'One API to models
Logs and metrics
Virtual keys
Fallback routes', 'Командам, що виводять LLM-застосунки в продакшн.', 'Teams taking LLM apps to production.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'portkey.ai' OR LOWER(`name`) = 'portkey') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A production AI gateway: one API to models, observability, prompt and key management and routing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Portkey gives teams one API for many model providers, logs and metrics for every request, prompt management, virtual keys, fallbacks and load balancing. The product is now also offered to enterprises as Prisma AIRS AI Gateway by Palo Alto Networks. The Developer plan is free (10k logs per month); Production is for production workloads.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'One API to models
Logs and metrics
Virtual keys
Fallback routes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Teams taking LLM apps to production.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Developer', 'Developer', 0.00, 'free', '10 тис. записаних логів на місяць.', '10k recorded logs per month.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Developer' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Developer', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '10k recorded logs per month.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Production', 'Production', 49.00, 'month', '100 тис. логів, далі $9 за кожні 100 тис.', '100k logs, then $9 per additional 100k.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Production' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Production', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '100k logs, then $9 per additional 100k.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;


-- =================== Векторні бази даних / Vector Databases ===================
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'vector-databases' LIMIT 1);

-- Pinecone — Векторні бази даних
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pinecone.io' OR LOWER(`name`) = 'pinecone')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Pinecone', NULL, 'https://www.pinecone.io', NULL, NULL, 'Керована векторна база даних для пошуку й RAG: serverless-масштабування, безкоштовний план і варіант у вашій хмарі.', 'A managed vector database for search and RAG: serverless scaling, a free plan and a bring-your-own-cloud option.', 'Pinecone — повністю керована векторна база, яка дає агентам і застосункам швидкий і точний пошук по знаннях без адміністрування серверів. Підтримує гібридний пошук, простори імен і моніторинг через Prometheus і Datadog, доступна на хмарних маркетплейсах і у вашій власній хмарі (BYOC). Є безкоштовний план Starter і платні з мінімальним щомісячним обсягом використання.', 'Pinecone is a fully managed vector database that gives agents and apps fast, accurate knowledge retrieval without managing servers. It supports hybrid search, namespaces and monitoring via Prometheus and Datadog, and is available on cloud marketplaces and in your own cloud (BYOC). There is a free Starter plan and paid plans with a monthly usage minimum.', 'Serverless-масштабування
Гібридний пошук
Bring Your Own Cloud
Моніторинг', 'Serverless scaling
Hybrid search
Bring Your Own Cloud
Monitoring', 'Розробникам RAG і пошукових застосунків.', 'Developers of RAG and search apps.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pinecone.io' OR LOWER(`name`) = 'pinecone') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A managed vector database for search and RAG: serverless scaling, a free plan and a bring-your-own-cloud option.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Pinecone is a fully managed vector database that gives agents and apps fast, accurate knowledge retrieval without managing servers. It supports hybrid search, namespaces and monitoring via Prometheus and Datadog, and is available on cloud marketplaces and in your own cloud (BYOC). There is a free Starter plan and paid plans with a monthly usage minimum.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Serverless scaling
Hybrid search
Bring Your Own Cloud
Monitoring', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers of RAG and search apps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Starter', 'Starter', 0.00, 'free', 'Для пробних і невеликих застосунків.', 'For trying out and small applications.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Starter' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Starter', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For trying out and small applications.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Builder', 'Builder', 20.00, 'month', 'Фіксована ціна для розробників і малих команд.', 'Flat price for solo developers and small teams.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Builder' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Builder', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Flat price for solo developers and small teams.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Standard', 'Standard', 50.00, 'month', 'Мінімум $50 використання на місяць; 3 тижні пробного періоду з $300 кредитів.', '$50 monthly usage minimum; 3-week trial with $300 credits.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Standard' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Standard', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$50 monthly usage minimum; 3-week trial with $300 credits.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Enterprise', 'Enterprise', 500.00, 'month', 'Мінімум $500 на місяць.', '$500 monthly minimum.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Enterprise' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$500 monthly minimum.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Weaviate — Векторні бази даних
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'weaviate.io' OR LOWER(`name`) = 'weaviate')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Weaviate', NULL, 'https://weaviate.io', NULL, NULL, 'Відкрита AI-база даних: векторний і гібридний пошук, RAG і пам''ять для агентів — у хмарі чи у себе.', 'An open-source AI database: vector and hybrid search, RAG and agent memory, in the cloud or self-hosted.', 'Weaviate поєднує векторний пошук, RAG і пам''ять в одній платформі з відкритим кодом. Weaviate Cloud має назавжди безкоштовний кластер (100 тис. об''єктів) і план Flex з оплатою за використання, вбудовані ембеддинг-моделі та Query Agent, що перетворює запитання природною мовою на запити до бази. Engram додає персоналізовану пам''ять для AI-застосунків.', 'Weaviate combines vector search, RAG and memory in one open-source platform. Weaviate Cloud has a forever-free cluster (100k objects) and a pay-as-you-go Flex plan, hosted embedding models and Query Agent, which turns natural-language questions into database operations. Engram adds personalized memory for AI apps.', 'Векторний і гібридний пошук
Вбудовані ембеддинги
Query Agent
Відкритий код', 'Vector and hybrid search
Hosted embeddings
Query Agent
Open source', 'Розробникам AI-застосунків з пошуком і пам''яттю.', 'Developers of AI apps with search and memory.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'weaviate.io' OR LOWER(`name`) = 'weaviate') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An open-source AI database: vector and hybrid search, RAG and agent memory, in the cloud or self-hosted.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Weaviate combines vector search, RAG and memory in one open-source platform. Weaviate Cloud has a forever-free cluster (100k objects) and a pay-as-you-go Flex plan, hosted embedding models and Query Agent, which turns natural-language questions into database operations. Engram adds personalized memory for AI apps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Vector and hybrid search
Hosted embeddings
Query Agent
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers of AI apps with search and memory.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', '1 кластер, 100 тис. об''єктів, без картки.', '1 cluster, 100k objects, no credit card.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '1 cluster, 100k objects, no credit card.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Flex', 'Flex', 45.00, 'month', 'Від $45, оплата за використання.', 'From $45, pay as you go.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Flex' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Flex', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'From $45, pay as you go.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Qdrant — Векторні бази даних
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'qdrant.tech' OR LOWER(`name`) = 'qdrant')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Qdrant', NULL, 'https://qdrant.tech', NULL, NULL, 'Відкритий векторний пошуковий рушій на Rust: хмара Qdrant Cloud з безкоштовним рівнем, гібридна й on-premise версії.', 'An open-source vector search engine in Rust: Qdrant Cloud with a free tier, plus hybrid and on-premise options.', 'Qdrant — високопродуктивний векторний пошук для RAG, рекомендацій і гібридного пошуку. Можна запускати з відкритим кодом самостійно, користуватися керованим Qdrant Cloud (безкоштовний кластер 1 ГБ RAM і 4 ГБ диска), гібридною хмарою у вашій інфраструктурі або корпоративним рішенням. Є вбудований хмарний інференс ембеддингів і Qdrant Edge для пристроїв.', 'Qdrant is high-performance vector search for RAG, recommendations and hybrid search. You can self-host the open-source version, use managed Qdrant Cloud (a free cluster with 1 GB RAM and 4 GB disk), Hybrid Cloud in your own infrastructure or an enterprise solution. It includes cloud embedding inference and Qdrant Edge for devices.', 'Векторний і гібридний пошук
Безкоштовний хмарний кластер
Hybrid Cloud
Інференс ембеддингів', 'Vector and hybrid search
Free cloud cluster
Hybrid Cloud
Embedding inference', 'Розробникам і компаніям, що будують RAG і рекомендації.', 'Developers and companies building RAG and recommendations.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'qdrant.tech' OR LOWER(`name`) = 'qdrant') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An open-source vector search engine in Rust: Qdrant Cloud with a free tier, plus hybrid and on-premise options.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Qdrant is high-performance vector search for RAG, recommendations and hybrid search. You can self-host the open-source version, use managed Qdrant Cloud (a free cluster with 1 GB RAM and 4 GB disk), Hybrid Cloud in your own infrastructure or an enterprise solution. It includes cloud embedding inference and Qdrant Edge for devices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Vector and hybrid search
Free cloud cluster
Hybrid Cloud
Embedding inference', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers and companies building RAG and recommendations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Кластер 0.5 vCPU, 1 ГБ RAM, 4 ГБ диска.', 'Cluster with 0.5 vCPU, 1 GB RAM, 4 GB disk.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Cluster with 0.5 vCPU, 1 GB RAM, 4 GB disk.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Standard', 'Standard', NULL, 'month', 'Оплата за ресурси кластера; ціни в калькуляторі на сайті.', 'Billed by cluster resources; prices in the calculator on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Standard' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Standard', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Billed by cluster resources; prices in the calculator on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Chroma — Векторні бази даних
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'trychroma.com' OR LOWER(`name`) = 'chroma')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Chroma', NULL, 'https://www.trychroma.com', NULL, NULL, 'Відкрита пошукова інфраструктура для AI: векторний, повнотекстовий і metadata-пошук та serverless Chroma Cloud.', 'Open-source search infrastructure for AI: vector, full-text and metadata search, plus serverless Chroma Cloud.', 'Chroma — популярна відкрита векторна база, яку легко запустити локально в Python чи JS. Chroma Cloud працює serverless на об''єктному сховищі з автоматичним кешуванням і підтримує векторний, повнотекстовий, regex- і metadata-пошук по терабайтах даних. Оплата за запис, зберігання й запити; план Starter включає $5 безкоштовних кредитів.', 'Chroma is a popular open-source vector database that is easy to run locally in Python or JS. Chroma Cloud runs serverless on object storage with automatic caching and supports vector, full-text, regex and metadata search over terabytes of data. Billing is for writes, storage and queries; the Starter plan includes $5 of free credits.', 'Векторний і повнотекстовий пошук
Локальний запуск
Serverless Chroma Cloud
Відкритий код', 'Vector and full-text search
Runs locally
Serverless Chroma Cloud
Open source', 'Розробникам, що додають пошук і пам''ять у AI-застосунки.', 'Developers adding search and memory to AI apps.', 'web,desktop', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'trychroma.com' OR LOWER(`name`) = 'chroma') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Open-source search infrastructure for AI: vector, full-text and metadata search, plus serverless Chroma Cloud.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Chroma is a popular open-source vector database that is easy to run locally in Python or JS. Chroma Cloud runs serverless on object storage with automatic caching and supports vector, full-text, regex and metadata search over terabytes of data. Billing is for writes, storage and queries; the Starter plan includes $5 of free credits.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Vector and full-text search
Runs locally
Serverless Chroma Cloud
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers adding search and memory to AI apps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Open source', 'Open source', 0.00, 'free', 'Безкоштовно для самостійного запуску.', 'Free to self-host.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Open source' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free to self-host.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Cloud Starter', 'Cloud Starter', 0.00, 'month', '$5 кредитів; запис $2.50 за ГіБ, зберігання $0.33 за ГіБ на місяць.', '$5 credits; writes $2.50 per GiB, storage $0.33 per GiB per month.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Cloud Starter' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Cloud Starter', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$5 credits; writes $2.50 per GiB, storage $0.33 per GiB per month.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Milvus — Векторні бази даних
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'milvus.io' OR LOWER(`name`) = 'milvus')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Milvus', NULL, 'https://milvus.io', NULL, NULL, 'Відкрита векторна база для пошуку подібності в мільярдах векторів: від Milvus Lite до розподіленого кластера й Zilliz Cloud.', 'An open-source vector database for similarity search over billions of vectors: from Milvus Lite to distributed clusters and Zilliz Cloud.', 'Milvus має три варіанти розгортання: Milvus Lite як бібліотеку для ноутбуків і прототипів, Standalone для однієї машини та Distributed для масштабу в десятки мільярдів векторів. Підтримує фільтрацію за метаданими, гібридний і мультивекторний пошук, Graph RAG. Повністю керовану версію пропонує Zilliz Cloud з безкоштовним рівнем.', 'Milvus has three deployment options: Milvus Lite as a library for notebooks and prototypes, Standalone for a single machine and Distributed for scale up to tens of billions of vectors. It supports metadata filtering, hybrid and multi-vector search and Graph RAG. A fully managed version is offered by Zilliz Cloud with a free tier.', 'Milvus Lite, Standalone, Distributed
Гібридний пошук
Фільтрація за метаданими
Керована Zilliz Cloud', 'Milvus Lite, Standalone, Distributed
Hybrid search
Metadata filtering
Managed Zilliz Cloud', 'Інженерам, що працюють із великими обсягами векторів.', 'Engineers working with large vector volumes.', 'web,desktop', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'milvus.io' OR LOWER(`name`) = 'milvus') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An open-source vector database for similarity search over billions of vectors: from Milvus Lite to distributed clusters and Zilliz Cloud.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Milvus has three deployment options: Milvus Lite as a library for notebooks and prototypes, Standalone for a single machine and Distributed for scale up to tens of billions of vectors. It supports metadata filtering, hybrid and multi-vector search and Graph RAG. A fully managed version is offered by Zilliz Cloud with a free tier.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Milvus Lite, Standalone, Distributed
Hybrid search
Metadata filtering
Managed Zilliz Cloud', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Engineers working with large vector volumes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Open source', 'Open source', 0.00, 'free', 'Безкоштовно, відкритий код.', 'Free, open source.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Open source' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free, open source.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Zilliz Cloud', 'Zilliz Cloud', NULL, 'month', 'Є безкоштовний рівень (5 ГБ); платні — serverless або виділені кластери, ціни на сайті Zilliz.', 'Free tier available (5 GB); paid serverless or dedicated clusters, prices on the Zilliz site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Zilliz Cloud' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Zilliz Cloud', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier available (5 GB); paid serverless or dedicated clusters, prices on the Zilliz site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

