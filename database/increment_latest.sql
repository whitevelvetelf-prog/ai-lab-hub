SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-10-29: картки із застарілими сайтами.
--   Перевірено сайти всіх карток (≈4300): переадресації на інший домен, неіснуючі домени, 404, перехоплені домени.
--   1) 66 карток — нова адреса сайту (той самий продукт);
--   2) 9 карток — продукт перейменовано: нова назва (стара в дужках), адреса, примітка в описі UA/EN;
--   3) 1 картка — примітка про купівлю (Tabnine);
--   4) 14 карток знято з публікації (status = none): продукт закрито / домен перехоплено чи не існує.
-- Картки шукаються за назвою + старим доменом, без фіксованих id. Повторний запуск безпечний.
-- Застосування: phpMyAdmin → БД → «Импорт».
-- =====================================================================

-- 1) Нові адреси
UPDATE `products` SET `official_url` = 'https://macrofactor.com', `updated_at` = NOW() WHERE `name` = 'MacroFactor' AND `official_url` LIKE '%macrofactorapp.com%' AND `official_url` <> 'https://macrofactor.com';
UPDATE `products` SET `official_url` = 'https://lensa.app', `updated_at` = NOW() WHERE `name` = 'Lensa' AND `official_url` LIKE '%lensa-ai.com%' AND `official_url` <> 'https://lensa.app';
UPDATE `products` SET `official_url` = 'https://riverside.com', `updated_at` = NOW() WHERE `name` = 'Riverside.fm' AND `official_url` LIKE '%riverside.fm%' AND `official_url` <> 'https://riverside.com';
UPDATE `products` SET `official_url` = 'https://mixitup.bot', `updated_at` = NOW() WHERE `name` = 'Mix It Up' AND `official_url` LIKE '%mixitupapp.com%' AND `official_url` <> 'https://mixitup.bot';
UPDATE `products` SET `official_url` = 'https://abide.com', `updated_at` = NOW() WHERE `name` = 'Abide' AND `official_url` LIKE '%abide.co%' AND `official_url` <> 'https://abide.com';
UPDATE `products` SET `official_url` = 'https://crosstalk.ai', `updated_at` = NOW() WHERE `name` = 'CrossTalk: Bible Chat' AND `official_url` LIKE '%biblechat.ai%' AND `official_url` <> 'https://crosstalk.ai';
UPDATE `products` SET `official_url` = 'https://www.wellsaid.io', `updated_at` = NOW() WHERE `name` = 'WellSaid Labs' AND `official_url` LIKE '%wellsaidlabs.com%' AND `official_url` <> 'https://www.wellsaid.io';
UPDATE `products` SET `official_url` = 'https://www.glorify.global/app', `updated_at` = NOW() WHERE `name` = 'Glorify' AND `official_url` LIKE '%glorify-app.com%' AND `official_url` <> 'https://www.glorify.global/app';
UPDATE `products` SET `official_url` = 'https://lectio365.com', `updated_at` = NOW() WHERE `name` = 'Lectio 365' AND `official_url` LIKE '%24-7prayer.com%' AND `official_url` <> 'https://lectio365.com';
UPDATE `products` SET `official_url` = 'https://proclaim.logos.com', `updated_at` = NOW() WHERE `name` = 'Proclaim' AND `official_url` LIKE '%faithlife.com%' AND `official_url` <> 'https://proclaim.logos.com';
UPDATE `products` SET `official_url` = 'https://ayahapp.com', `updated_at` = NOW() WHERE `name` = 'Ayah' AND `official_url` LIKE '%ayah.app%' AND `official_url` <> 'https://ayahapp.com';
UPDATE `products` SET `official_url` = 'https://mymasjidal.com', `updated_at` = NOW() WHERE `name` = 'Masjidal' AND `official_url` LIKE '%masjidal.com%' AND `official_url` <> 'https://mymasjidal.com';
UPDATE `products` SET `official_url` = 'https://quran-pro.com', `updated_at` = NOW() WHERE `name` = 'Quran Pro' AND `official_url` LIKE '%quranpro.co%' AND `official_url` <> 'https://quran-pro.com';
UPDATE `products` SET `official_url` = 'https://sketchup.trimble.com', `updated_at` = NOW() WHERE `name` = 'SketchUp' AND `official_url` LIKE '%sketchup.com%' AND `official_url` <> 'https://sketchup.trimble.com';
UPDATE `products` SET `official_url` = 'https://store.kehotonline.com', `updated_at` = NOW() WHERE `name` = 'Kehot Publication Society' AND `official_url` LIKE '%kehot.com%' AND `official_url` <> 'https://store.kehotonline.com';
UPDATE `products` SET `official_url` = 'https://shreeramsharnam.com', `updated_at` = NOW() WHERE `name` = 'Shree Ram Sharnam' AND `official_url` LIKE '%shriramsharnam.org%' AND `official_url` <> 'https://shreeramsharnam.com';
UPDATE `products` SET `official_url` = 'https://www.gururamana.org', `updated_at` = NOW() WHERE `name` = 'Sri Ramanasramam' AND `official_url` LIKE '%sriramanamaharshi.org%' AND `official_url` <> 'https://www.gururamana.org';
UPDATE `products` SET `official_url` = 'https://bfl.ai', `updated_at` = NOW() WHERE `name` = 'FLUX.1' AND `official_url` LIKE '%blackforestlabs.ai%' AND `official_url` <> 'https://bfl.ai';
UPDATE `products` SET `official_url` = 'https://sravastiabbey.org', `updated_at` = NOW() WHERE `name` = 'Sravasti Abbey' AND `official_url` LIKE '%sravasti.org%' AND `official_url` <> 'https://sravastiabbey.org';
UPDATE `products` SET `official_url` = 'https://www.parallax.org/mindfulnessbell/', `updated_at` = NOW() WHERE `name` = 'The Mindfulness Bell' AND `official_url` LIKE '%mindfulnessbell.org%' AND `official_url` <> 'https://www.parallax.org/mindfulnessbell/';
UPDATE `products` SET `official_url` = 'https://neon.com', `updated_at` = NOW() WHERE `name` = 'Neon' AND `official_url` LIKE '%neon.tech%' AND `official_url` <> 'https://neon.com';
UPDATE `products` SET `official_url` = 'https://ca.tm.org/en', `updated_at` = NOW() WHERE `name` = 'Transcendental Meditation Canada' AND `official_url` LIKE '%tmcanada.org%' AND `official_url` <> 'https://ca.tm.org/en';
UPDATE `products` SET `official_url` = 'https://railway.com', `updated_at` = NOW() WHERE `name` = 'Railway' AND `official_url` LIKE '%railway.app%' AND `official_url` <> 'https://railway.com';
UPDATE `products` SET `official_url` = 'https://www.samsung.com/us/smartthings/', `updated_at` = NOW() WHERE `name` = 'SmartThings' AND `official_url` LIKE '%smartthings.com%' AND `official_url` <> 'https://www.samsung.com/us/smartthings/';
UPDATE `products` SET `official_url` = 'https://myskylight.com', `updated_at` = NOW() WHERE `name` = 'Skylight' AND `official_url` LIKE '%skylightframe.com%' AND `official_url` <> 'https://myskylight.com';
UPDATE `products` SET `official_url` = 'https://www.ollie.com', `updated_at` = NOW() WHERE `name` = 'Ollie' AND `official_url` LIKE '%myollie.com%' AND `official_url` <> 'https://www.ollie.com';
UPDATE `products` SET `official_url` = 'https://www.garmin.com/en-US/c/marine-cartography/third-party-marine-maps/', `updated_at` = NOW() WHERE `name` = 'Navionics' AND `official_url` LIKE '%navionics.com%' AND `official_url` <> 'https://www.garmin.com/en-US/c/marine-cartography/third-party-marine-maps/';
UPDATE `products` SET `official_url` = 'https://www.twilio.com/en-us/sendgrid', `updated_at` = NOW() WHERE `name` = 'SendGrid' AND `official_url` LIKE '%sendgrid.com%' AND `official_url` <> 'https://www.twilio.com/en-us/sendgrid';
UPDATE `products` SET `official_url` = 'https://www.khanmigo.ai', `updated_at` = NOW() WHERE `name` = 'Khanmigo' AND `official_url` LIKE '%khanacademy.org%' AND `official_url` <> 'https://www.khanmigo.ai';
UPDATE `products` SET `official_url` = 'https://typica.coffee', `updated_at` = NOW() WHERE `name` = 'TYPICA' AND `official_url` LIKE '%typica.jp%' AND `official_url` <> 'https://typica.coffee';
UPDATE `products` SET `official_url` = 'https://www.encompasstech.com/vintrace', `updated_at` = NOW() WHERE `name` = 'vintrace' AND `official_url` LIKE '%vintrace.com%' AND `official_url` <> 'https://www.encompasstech.com/vintrace';
UPDATE `products` SET `official_url` = 'https://vinebox.com', `updated_at` = NOW() WHERE `name` = 'Vinebox' AND `official_url` LIKE '%getvinebox.com%' AND `official_url` <> 'https://vinebox.com';
UPDATE `products` SET `official_url` = 'https://plaato.ai', `updated_at` = NOW() WHERE `name` = 'PLAATO' AND `official_url` LIKE '%plaato.io%' AND `official_url` <> 'https://plaato.ai';
UPDATE `products` SET `official_url` = 'https://peaceofmind.tv', `updated_at` = NOW() WHERE `name` = 'Peace of Mind TV' AND `official_url` LIKE '%pmtv.in%' AND `official_url` <> 'https://peaceofmind.tv';
UPDATE `products` SET `official_url` = 'https://www.delphi.co', `updated_at` = NOW() WHERE `name` = 'Delphi' AND `official_url` LIKE '%delphi.ai%' AND `official_url` <> 'https://www.delphi.co';
UPDATE `products` SET `official_url` = 'https://www.lovelanyadoo.com', `updated_at` = NOW() WHERE `name` = 'Jessica Lanyadoo' AND `official_url` LIKE '%jessicalanyadoo.com%' AND `official_url` <> 'https://www.lovelanyadoo.com';
UPDATE `products` SET `official_url` = 'https://spellbook.com', `updated_at` = NOW() WHERE `name` = 'Spellbook' AND `official_url` LIKE '%spellbook.legal%' AND `official_url` <> 'https://spellbook.com';
UPDATE `products` SET `official_url` = 'https://www.hogd.org.uk', `updated_at` = NOW() WHERE `name` = 'Hermetic Order of the Golden Dawn in Britain' AND `official_url` LIKE '%hogd.co.uk%' AND `official_url` <> 'https://www.hogd.org.uk';
UPDATE `products` SET `official_url` = 'https://flow.google.com', `updated_at` = NOW() WHERE `name` = 'Google Flow' AND `official_url` LIKE '%labs.google%' AND `official_url` <> 'https://flow.google.com';
UPDATE `products` SET `official_url` = 'https://www.fathom.ai', `updated_at` = NOW() WHERE `name` = 'Fathom' AND `official_url` LIKE '%fathom.video%' AND `official_url` <> 'https://www.fathom.ai';
UPDATE `products` SET `official_url` = 'https://reflectlyapp.com', `updated_at` = NOW() WHERE `name` = 'Reflectly' AND `official_url` LIKE '%reflectly.app%' AND `official_url` <> 'https://reflectlyapp.com';
UPDATE `products` SET `official_url` = 'https://verify.contentauthenticity.org', `updated_at` = NOW() WHERE `name` = 'Content Credentials Verify' AND `official_url` LIKE '%contentcredentials.org%' AND `official_url` <> 'https://verify.contentauthenticity.org';
UPDATE `products` SET `official_url` = 'https://h24.ua', `updated_at` = NOW() WHERE `name` = 'Health24' AND `official_url` LIKE '%health24.ua%' AND `official_url` <> 'https://h24.ua';
UPDATE `products` SET `official_url` = 'https://apteka911.ua', `updated_at` = NOW() WHERE `name` = 'Аптека 9-1-1' AND `official_url` LIKE '%apteka911.com.ua%' AND `official_url` <> 'https://apteka911.ua';
UPDATE `products` SET `official_url` = 'https://vodokanal.kyiv.ua', `updated_at` = NOW() WHERE `name` = 'Київводоканал Цифровий' AND `official_url` LIKE '%vodokanal.kiev.ua%' AND `official_url` <> 'https://vodokanal.kyiv.ua';
UPDATE `products` SET `official_url` = 'https://oblenergo.kharkiv.ua', `updated_at` = NOW() WHERE `name` = 'Харківобленерго мобайл' AND `official_url` LIKE '%oblenergo.kharkov.ua%' AND `official_url` <> 'https://oblenergo.kharkiv.ua';
UPDATE `products` SET `official_url` = 'https://citrus.ua', `updated_at` = NOW() WHERE `name` = 'Цитрус' AND `official_url` LIKE '%ctrs.com.ua%' AND `official_url` <> 'https://citrus.ua';
UPDATE `products` SET `official_url` = 'https://yasno.ua/e-mobility-b2c', `updated_at` = NOW() WHERE `name` = 'E-mobility YASNO' AND `official_url` LIKE '%yasno.com.ua%' AND `official_url` <> 'https://yasno.ua/e-mobility-b2c';
UPDATE `products` SET `official_url` = 'https://www.perfectcorp.com/consumer/apps/ymk', `updated_at` = NOW() WHERE `name` = 'YouCam Makeup' AND `official_url` LIKE '%youcamapps.com%' AND `official_url` <> 'https://www.perfectcorp.com/consumer/apps/ymk';
UPDATE `products` SET `official_url` = 'https://ifttt.ai', `updated_at` = NOW() WHERE `name` = 'IFTTT' AND `official_url` LIKE '%ifttt.com%' AND `official_url` <> 'https://ifttt.ai';
UPDATE `products` SET `official_url` = 'https://www.monarch.com', `updated_at` = NOW() WHERE `name` = 'Monarch' AND `official_url` LIKE '%monarchmoney.com%' AND `official_url` <> 'https://www.monarch.com';
UPDATE `products` SET `official_url` = 'https://surfer.ai', `updated_at` = NOW() WHERE `name` = 'Surfer SEO' AND `official_url` LIKE '%surferseo.com%' AND `official_url` <> 'https://surfer.ai';
UPDATE `products` SET `official_url` = 'https://runway.com', `updated_at` = NOW() WHERE `name` = 'Runway' AND `official_url` LIKE '%runwayml.com%' AND `official_url` <> 'https://runway.com';
UPDATE `products` SET `official_url` = 'https://www.spryhealth.ai', `updated_at` = NOW() WHERE `name` = 'SPRY' AND `official_url` LIKE '%sprypt.com%' AND `official_url` <> 'https://www.spryhealth.ai';
UPDATE `products` SET `official_url` = 'https://kling.ai', `updated_at` = NOW() WHERE `name` = 'Kling AI' AND `official_url` LIKE '%klingai.com%' AND `official_url` <> 'https://kling.ai';
UPDATE `products` SET `official_url` = 'https://lightfield.com', `updated_at` = NOW() WHERE `name` = 'Lightfield' AND `official_url` LIKE '%lightfield.app%' AND `official_url` <> 'https://lightfield.com';
UPDATE `products` SET `official_url` = 'https://coopah.com', `updated_at` = NOW() WHERE `name` = 'Coopah' AND `official_url` LIKE '%www.coopah.com%' AND `official_url` <> 'https://coopah.com';
UPDATE `products` SET `official_url` = 'https://www.mixamo.com', `updated_at` = NOW() WHERE `name` = 'Mixamo' AND `official_url` LIKE '%//mixamo.com%' AND `official_url` <> 'https://www.mixamo.com';
UPDATE `products` SET `official_url` = 'https://www.freqtrade.io/en/stable/', `updated_at` = NOW() WHERE `name` = 'Freqtrade' AND `official_url` LIKE '%freqtrade.io%' AND `official_url` <> 'https://www.freqtrade.io/en/stable/';
UPDATE `products` SET `official_url` = 'https://support.apple.com/guide/shortcuts/welcome/ios', `updated_at` = NOW() WHERE `name` = 'Apple Shortcuts' AND `official_url` LIKE '%apple.com/shortcuts%' AND `official_url` <> 'https://support.apple.com/guide/shortcuts/welcome/ios';
UPDATE `products` SET `official_url` = 'https://www.worx.com/en-us/landroid', `updated_at` = NOW() WHERE `name` = 'Worx Landroid' AND `official_url` LIKE '%worx.com%' AND `official_url` <> 'https://www.worx.com/en-us/landroid';
UPDATE `products` SET `official_url` = 'https://www.picturethisai.com', `updated_at` = NOW() WHERE `name` = 'PictureThis' AND `official_url` LIKE '%picturethis.ai%' AND `official_url` <> 'https://www.picturethisai.com';
UPDATE `products` SET `official_url` = 'https://play.google.com/store/apps/details?id=com.niksoftware.snapseed', `updated_at` = NOW() WHERE `name` = 'Snapseed' AND `official_url` LIKE '%snapseed.online%' AND `official_url` <> 'https://play.google.com/store/apps/details?id=com.niksoftware.snapseed';
UPDATE `products` SET `official_url` = 'https://www.questionai.com', `updated_at` = NOW() WHERE `name` = 'Question.AI' AND `official_url` LIKE '%question.ai%' AND `official_url` <> 'https://www.questionai.com';
UPDATE `products` SET `official_url` = 'https://www.facetuneapp.com', `updated_at` = NOW() WHERE `name` = 'Facetune' AND `official_url` LIKE '%facetune.com%' AND `official_url` <> 'https://www.facetuneapp.com';
UPDATE `products` SET `official_url` = 'https://www.facetuneapp.com/products/video-editor', `updated_at` = NOW() WHERE `name` = 'FaceTune Video' AND `official_url` LIKE '%facetune.com%' AND `official_url` <> 'https://www.facetuneapp.com/products/video-editor';

-- 2) Перейменування
UPDATE `products` SET `name` = 'Devin Desktop (Windsurf)', `official_url` = 'https://devin.ai/desktop', `full_description` = CONCAT(`full_description`, ' ', 'У червні 2026 Cognition перейменувала Windsurf на Devin Desktop і додала панель для керування кількома агентами; тарифи для наявних користувачів не змінилися.'), `updated_at` = NOW() WHERE `name` = 'Windsurf' AND `official_url` LIKE '%windsurf.com%';
UPDATE `product_translations` t JOIN `products` p ON p.`id` = t.`product_id` SET t.`translated_text` = CONCAT(t.`translated_text`, ' ', 'In June 2026 Cognition renamed Windsurf to Devin Desktop and added a panel for managing several agents; pricing for existing users stayed the same.') WHERE p.`name` = 'Devin Desktop (Windsurf)' AND p.`official_url` = 'https://devin.ai/desktop' AND t.`field_name` = 'full_description' AND t.`lang` = 'en' AND t.`translated_text` NOT LIKE '%In June 2026 Cognition renamed Windsurf %';
UPDATE `products` SET `name` = 'Async (Podcastle)', `official_url` = 'https://async.com', `full_description` = CONCAT(`full_description`, ' ', 'На початку 2026 року Podcastle перейменувався на Async: облікові записи, проєкти й тарифи збереглися.'), `updated_at` = NOW() WHERE `name` = 'Podcastle' AND `official_url` LIKE '%podcastle.ai%';
UPDATE `product_translations` t JOIN `products` p ON p.`id` = t.`product_id` SET t.`translated_text` = CONCAT(t.`translated_text`, ' ', 'In early 2026 Podcastle was renamed Async: accounts, projects and pricing carried over.') WHERE p.`name` = 'Async (Podcastle)' AND p.`official_url` = 'https://async.com' AND t.`field_name` = 'full_description' AND t.`lang` = 'en' AND t.`translated_text` NOT LIKE '%In early 2026 Podcastle was renamed Asyn%';
UPDATE `products` SET `name` = 'Treblo (Sonauto)', `official_url` = 'https://treblo.com', `full_description` = CONCAT(`full_description`, ' ', 'Сервіс перейменовано на Treblo, адреса sonauto.ai тепер веде на treblo.com.'), `updated_at` = NOW() WHERE `name` = 'Sonauto' AND `official_url` LIKE '%sonauto.ai%';
UPDATE `product_translations` t JOIN `products` p ON p.`id` = t.`product_id` SET t.`translated_text` = CONCAT(t.`translated_text`, ' ', 'The service was renamed Treblo; sonauto.ai now redirects to treblo.com.') WHERE p.`name` = 'Treblo (Sonauto)' AND p.`official_url` = 'https://treblo.com' AND t.`field_name` = 'full_description' AND t.`lang` = 'en' AND t.`translated_text` NOT LIKE '%The service was renamed Treblo; sonauto.%';
UPDATE `products` SET `name` = 'TestMu AI (LambdaTest)', `official_url` = 'https://www.testmuai.com', `full_description` = CONCAT(`full_description`, ' ', 'LambdaTest перейменувався на TestMu AI, адреса lambdatest.com тепер веде на testmuai.com.'), `updated_at` = NOW() WHERE `name` = 'LambdaTest' AND `official_url` LIKE '%lambdatest.com%';
UPDATE `product_translations` t JOIN `products` p ON p.`id` = t.`product_id` SET t.`translated_text` = CONCAT(t.`translated_text`, ' ', 'LambdaTest was renamed TestMu AI; lambdatest.com now redirects to testmuai.com.') WHERE p.`name` = 'TestMu AI (LambdaTest)' AND p.`official_url` = 'https://www.testmuai.com' AND t.`field_name` = 'full_description' AND t.`lang` = 'en' AND t.`translated_text` NOT LIKE '%LambdaTest was renamed TestMu AI; lambda%';
UPDATE `products` SET `name` = 'Weights & Biases (CoreWeave Forge)', `official_url` = 'https://forge.coreweave.com/wandb', `full_description` = CONCAT(`full_description`, ' ', 'З вересня 2026 Weights & Biases входить до платформи CoreWeave Forge; наявні облікові записи W&B працюють там з тими самими даними для входу.'), `updated_at` = NOW() WHERE `name` = 'Weights & Biases' AND `official_url` LIKE '%wandb.ai%';
UPDATE `product_translations` t JOIN `products` p ON p.`id` = t.`product_id` SET t.`translated_text` = CONCAT(t.`translated_text`, ' ', 'Since September 2026 Weights & Biases is part of the CoreWeave Forge platform; existing W&B accounts sign in there with the same credentials.') WHERE p.`name` = 'Weights & Biases (CoreWeave Forge)' AND p.`official_url` = 'https://forge.coreweave.com/wandb' AND t.`field_name` = 'full_description' AND t.`lang` = 'en' AND t.`translated_text` NOT LIKE '%Since September 2026 Weights & Biases is%';
UPDATE `products` SET `name` = 'Hosanna (Bible.is)', `official_url` = 'https://www.faithcomesbyhearing.com/audio-bible-resources/bible-is', `full_description` = CONCAT(`full_description`, ' ', 'Застосунок тепер називається Hosanna, адреса bible.is веде на його сторінку на сайті Faith Comes By Hearing.'), `updated_at` = NOW() WHERE `name` = 'Bible.is' AND `official_url` LIKE '%bible.is%';
UPDATE `product_translations` t JOIN `products` p ON p.`id` = t.`product_id` SET t.`translated_text` = CONCAT(t.`translated_text`, ' ', 'The app is now called Hosanna; bible.is redirects to its page on the Faith Comes By Hearing website.') WHERE p.`name` = 'Hosanna (Bible.is)' AND p.`official_url` = 'https://www.faithcomesbyhearing.com/audio-bible-resources/bible-is' AND t.`field_name` = 'full_description' AND t.`lang` = 'en' AND t.`translated_text` NOT LIKE '%The app is now called Hosanna; bible.is %';
UPDATE `products` SET `name` = 'Microsoft Dragon Copilot (Nuance DAX)', `official_url` = 'https://www.microsoft.com/en-us/health-solutions/clinical-workflow/dragon-copilot', `full_description` = CONCAT(`full_description`, ' ', 'У 2025 році Microsoft об\'єднала DAX Copilot і Dragon Medical One в один продукт — Microsoft Dragon Copilot.'), `updated_at` = NOW() WHERE `name` = 'Nuance DAX' AND `official_url` LIKE '%nuance.com%';
UPDATE `product_translations` t JOIN `products` p ON p.`id` = t.`product_id` SET t.`translated_text` = CONCAT(t.`translated_text`, ' ', 'In 2025 Microsoft merged DAX Copilot and Dragon Medical One into a single product, Microsoft Dragon Copilot.') WHERE p.`name` = 'Microsoft Dragon Copilot (Nuance DAX)' AND p.`official_url` = 'https://www.microsoft.com/en-us/health-solutions/clinical-workflow/dragon-copilot' AND t.`field_name` = 'full_description' AND t.`lang` = 'en' AND t.`translated_text` NOT LIKE '%In 2025 Microsoft merged DAX Copilot and%';
UPDATE `products` SET `name` = 'Alo Wellness Club (Alo Moves)', `official_url` = 'https://wellnessclub.aloyoga.com', `full_description` = CONCAT(`full_description`, ' ', 'Сервіс тепер називається Alo Wellness Club, адреса alomoves.com веде туди.'), `updated_at` = NOW() WHERE `name` = 'Alo Moves' AND `official_url` LIKE '%alomoves.com%';
UPDATE `product_translations` t JOIN `products` p ON p.`id` = t.`product_id` SET t.`translated_text` = CONCAT(t.`translated_text`, ' ', 'The service is now called Alo Wellness Club; alomoves.com redirects there.') WHERE p.`name` = 'Alo Wellness Club (Alo Moves)' AND p.`official_url` = 'https://wellnessclub.aloyoga.com' AND t.`field_name` = 'full_description' AND t.`lang` = 'en' AND t.`translated_text` NOT LIKE '%The service is now called Alo Wellness C%';
UPDATE `products` SET `name` = 'Hudl StatsBomb', `official_url` = 'https://www.hudl.com/en_gb/products/statsbomb', `full_description` = CONCAT(`full_description`, ' ', 'StatsBomb тепер входить до Hudl, адреса statsbomb.com веде на сторінку Hudl StatsBomb.'), `updated_at` = NOW() WHERE `name` = 'StatsBomb' AND `official_url` LIKE '%statsbomb.com%';
UPDATE `product_translations` t JOIN `products` p ON p.`id` = t.`product_id` SET t.`translated_text` = CONCAT(t.`translated_text`, ' ', 'StatsBomb is now part of Hudl; statsbomb.com redirects to the Hudl StatsBomb page.') WHERE p.`name` = 'Hudl StatsBomb' AND p.`official_url` = 'https://www.hudl.com/en_gb/products/statsbomb' AND t.`field_name` = 'full_description' AND t.`lang` = 'en' AND t.`translated_text` NOT LIKE '%StatsBomb is now part of Hudl; statsbomb%';

-- 3) Примітки
UPDATE `products` SET `full_description` = CONCAT(`full_description`, ' ', 'У липні 2026 Tabnine купила Tricentis; сайт tabnine.com тепер веде на сторінку продуктів Tricentis, тож актуальні умови уточнюйте там.'), `updated_at` = NOW() WHERE `name` = 'Tabnine' AND `official_url` LIKE '%tabnine.com%' AND `full_description` NOT LIKE '%Tricentis%';
UPDATE `product_translations` t JOIN `products` p ON p.`id` = t.`product_id` SET t.`translated_text` = CONCAT(t.`translated_text`, ' ', 'In July 2026 Tricentis acquired Tabnine; tabnine.com now redirects to the Tricentis products page, so check current terms there.') WHERE p.`name` = 'Tabnine' AND p.`official_url` LIKE '%tabnine.com%' AND t.`field_name` = 'full_description' AND t.`lang` = 'en' AND t.`translated_text` NOT LIKE '%Tricentis%';

-- 4) Зняття з публікації
-- K-Motion: домени k-motion.com і k-vest.com тепер ведуть на сторонній сайт азартних ігор
UPDATE `products` SET `status` = 'none', `updated_at` = NOW() WHERE `name` = 'K-Motion' AND `official_url` LIKE '%k-motion.com%' AND `status` = 'published';
-- Teamer: сервіс закрився («Teamer has closed»)
UPDATE `products` SET `status` = 'none', `updated_at` = NOW() WHERE `name` = 'Teamer' AND `official_url` LIKE '%teamer.net%' AND `status` = 'published';
-- Drift: Salesloft згортає Drift (березень 2026), drift.com веде на сторінку партнера 1mind
UPDATE `products` SET `status` = 'none', `updated_at` = NOW() WHERE `name` = 'Drift' AND `official_url` LIKE '%drift.com%' AND `status` = 'published';
-- Socratic: Google закрила Socratic, функції перенесено в Google Lens (є окрема картка)
UPDATE `products` SET `status` = 'none', `updated_at` = NOW() WHERE `name` = 'Socratic' AND `official_url` LIKE '%socratic.org%' AND `status` = 'published';
-- Continue.dev: Cursor купив Continue у червні 2026, хмарний сервіс закрито
UPDATE `products` SET `status` = 'none', `updated_at` = NOW() WHERE `name` = 'Continue.dev' AND `official_url` LIKE '%continue.dev%' AND `status` = 'published';
-- HitFilm: Artlist припинила HitFilm 15.01.2025, сайт fxhome.com не працює
UPDATE `products` SET `status` = 'none', `updated_at` = NOW() WHERE `name` = 'HitFilm' AND `official_url` LIKE '%fxhome.com%' AND `status` = 'published';
-- RateBeer: сайт закрито в лютому 2025
UPDATE `products` SET `status` = 'none', `updated_at` = NOW() WHERE `name` = 'RateBeer' AND `official_url` LIKE '%ratebeer.com%' AND `status` = 'published';
-- Replica Studios: компанія закрилася, домен не існує
UPDATE `products` SET `status` = 'none', `updated_at` = NOW() WHERE `name` = 'Replica Studios' AND `official_url` LIKE '%replicastudios.com%' AND `status` = 'published';
-- Facelab: домен не існує
UPDATE `products` SET `status` = 'none', `updated_at` = NOW() WHERE `name` = 'Facelab' AND `official_url` LIKE '%facelabapp.com%' AND `status` = 'published';
-- Hair App: домен не існує
UPDATE `products` SET `status` = 'none', `updated_at` = NOW() WHERE `name` = 'Hair App' AND `official_url` LIKE '%hairapp.io%' AND `status` = 'published';
-- L'Oréal Perso: домен не існує
UPDATE `products` SET `status` = 'none', `updated_at` = NOW() WHERE `name` = 'L\'Oréal Perso' AND `official_url` LIKE '%lorealperso.com%' AND `status` = 'published';
-- Crochet Patterns AI: застосунок видалено з App Store
UPDATE `products` SET `status` = 'none', `updated_at` = NOW() WHERE `name` = 'Crochet Patterns AI' AND `official_url` LIKE '%apps.apple.com%' AND `status` = 'published';
-- Mixology - Bartender App: застосунок видалено з App Store
UPDATE `products` SET `status` = 'none', `updated_at` = NOW() WHERE `name` = 'Mixology - Bartender App' AND `official_url` LIKE '%apps.apple.com%' AND `status` = 'published';
-- Skylum Photo AI: окремого продукту більше немає (сторінка 404); є картка Luminar Neo
UPDATE `products` SET `status` = 'none', `updated_at` = NOW() WHERE `name` = 'Skylum Photo AI' AND `official_url` LIKE '%skylum.com/photo-ai%' AND `status` = 'published';
