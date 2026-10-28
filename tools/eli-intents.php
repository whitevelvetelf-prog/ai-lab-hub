<?php

declare(strict_types=1);

/**
 * AI LAB HUB — початкові інтенти запасного пошуку Елі (таблиця search_intents).
 *
 *   php tools/eli-intents.php sql   > database/migration-…-intents.sql   — SQL без фіксованих id (за slug)
 *   php tools/eli-intents.php list                                        — таблиця для перевірки
 *
 * Формат рядка: [слова через кому, 'cat-slug', 'sub-slug' або null, вага]. Слова усікаються тим самим
 * стемером, що й запит (app/eli-search.php), тож писати їх можна у звичайній формі.
 * Лише CLI.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

require_once __DIR__ . '/../app/eli-search.php';

const ELI_INTENTS = [
    // --- Освіта та знання
    ['вивчити, вивчати, навчитися, навчання, освіта, урок, уроки, школа, університет, студент, learn, study, education, lesson, school, student', 'education-knowledge', null, 1.0],
    ['курс, курси, course, courses', 'education-knowledge', 'courses', 1.0],
    ['історія, історичний, history, historical', 'education-knowledge', 'courses', 1.0],
    ['історія, history, бібліотека, книга, книги, читати, book, books, library', 'education-knowledge', 'library', 1.0],
    ['домашнє, домашка, завдання, homework, assignment, репетитор, tutor, tutoring, математика, math, maths, фізика, physics, хімія, chemistry', 'education-knowledge', 'tutoring', 1.0],
    ['тест, тести, екзамен, іспит, нмт, зно, exam, test, quiz', 'education-knowledge', 'tests', 1.0],
    ['сертифікат, certificate, certification', 'education-knowledge', 'certificates', 1.0],
    ['наука, наукова, дослідження, research, science, scientific, paper', 'education-knowledge', 'research-search', 1.0],
    ['вчитель, вчителя, учитель, викладач, teacher, teaching', 'education-knowledge', 'teacher-tools', 1.0],
    ['плагіат, plagiarism, детектор, detector', 'education-knowledge', 'detectors', 1.0],
    ['наставник, ментор, mentor, mentorship', 'education-knowledge', 'mentorship', 1.0],

    // --- Переклад та мови
    ['переклад, перекласти, перекладач, translate, translation, translator', 'translation-languages', 'translation', 1.0],
    ['мова, мову, мови, англійська, англійську, німецька, німецької, французька, польська, language, english, german, french, spanish', 'translation-languages', null, 1.0],
    ['розпізнавання, диктування, диктувати, speech, dictation', 'translation-languages', 'speech-recognition', 0.8],

    // --- Мультимедіа
    ['відео, ролик, ролики, video, videos', 'multimedia', 'video-editing', 1.0],
    ['відео, video', 'multimedia', 'video-generation', 0.9],
    ['монтаж, змонтувати, стиснути, обрізати, кліп, edit, editing, compress, trim, clip, youtube, tiktok, reels, shorts', 'multimedia', 'video-editing', 1.0],
    ['фото, фотографія, світлина, photo, photos, photography', 'multimedia', 'photography', 1.0],
    ['зображення, картинка, картинки, малюнок, намалювати, ілюстрація, image, images, picture, illustration, draw, drawing', 'multimedia', 'image-generation', 1.0],
    ['музика, музику, пісня, пісню, мелодія, music, song, melody, soundtrack', 'multimedia', 'music', 1.0],
    ['звук, аудіо, подкаст, подкасти, audio, sound, podcast', 'multimedia', 'audio', 1.0],
    ['озвучка, озвучення, озвучити, голос, диктор, voiceover, voice, narration, narrator, tts', 'multimedia', 'voiceover', 1.0],
    ['транскрипція, транскрибувати, субтитри, розшифровка, transcribe, transcription, subtitles, captions', 'multimedia', 'transcription', 1.0],
    ['аватар, avatar', 'multimedia', 'ai-avatars', 1.0],
    ['фон, тло, background', 'multimedia', 'background-removal', 0.8],
    ['анімація, анімацію, 3d, animation, animate', 'multimedia', '3d-animation', 1.0],
    ['гра, ігри, ігор, гравець, геймер, game, games, gaming, gamer', 'multimedia', 'gaming', 1.0],

    // --- Текст та чат-боти
    ['текст, тексти, написати, писати, копірайтинг, text, write, writing, copywriting', 'text-chatbots', 'copywriting', 1.0],
    ['стаття, статтю, блог, публікація, article, blog, post', 'text-chatbots', 'publications', 0.9],
    ['чат, чатбот, бот, chatbot, chat, bot', 'text-chatbots', 'chatbots', 1.0],
    ['коротко, стисло, підсумувати, підсумок, стислий, summary, summarize, summarise, tldr', 'text-chatbots', 'summarizers', 1.0],
    ['граматика, перефразувати, переписати, помилки, grammar, paraphrase, rewrite, proofread', 'text-chatbots', 'paraphrasing-grammar', 1.0],
    ['промпт, промпти, prompt, prompts', 'text-chatbots', 'prompt-generators', 1.0],
    ['співрозмовник, компаньйон, companion, friend', 'text-chatbots', 'ai-companions', 0.8],

    // --- Розробка та IT
    ['код, кодувати, програмування, програмувати, програміст, розробник, code, coding, programming, developer, python, javascript, java, php, typescript', 'development-it', 'code-assistants', 1.0],
    ['рефакторинг, refactor, refactoring', 'development-it', 'refactoring', 1.0],
    ['сайт, вебсайт, лендинг, website, site', 'development-it', 'website-builders', 1.0],
    ['веброзробка, frontend, backend, html, css, react', 'development-it', 'web-development', 1.0],
    ['мобільний, android, ios', 'development-it', 'mobile-development', 0.8],
    ['база, бази, sql, database, databases', 'development-it', 'databases', 1.0],
    ['тестування, testing, qa', 'development-it', 'testing', 1.0],
    ['api', 'development-it', 'api', 1.0],
    ['nocode, lowcode, конструктор', 'development-it', 'no-code-low-code', 1.0],
    ['розробка, гру, unity, unreal', 'development-it', 'game-development', 0.6],
    ['llm, локальна, модель, ollama', 'development-it', 'local-llm', 0.8],
    ['хмара, хмарний, cloud, хостинг, hosting', 'development-it', 'cloud-services', 0.8],

    // --- Бізнес та маркетинг
    ['маркетинг, реклама, просуван, marketing, advertising, promotion', 'business-marketing', null, 1.0],
    ['smm, інстаграм, instagram, facebook, соцмережі, соцмереж, social', 'business-marketing', 'smm', 1.0],
    ['бізнес, бізнесплан, стартап, business, startup', 'business-marketing', null, 1.0],
    ['продажі, продаж, sales, sell', 'business-marketing', 'sales', 1.0],
    ['клієнти, клієнтів, підтримка, customer, support', 'business-marketing', 'customer-support', 0.9],
    ['crm', 'business-marketing', 'crm', 1.0],
    ['розсилка, розсилку, newsletter', 'business-marketing', 'email-marketing', 1.0],
    ['аналітика, статистика, analytics', 'business-marketing', 'analytics', 1.0],
    ['рекрутинг, найм, кандидатів, recruiting, hiring, hr', 'business-marketing', 'hr-recruiting', 1.0],
    ['ліди, лідогенерація, leads', 'business-marketing', 'lead-generation', 1.0],

    // --- Продуктивність
    ['план, планування, спланувати, plan, planning, planner', 'productivity', 'planning', 1.0],
    ['розклад, календар, schedule, calendar', 'productivity', 'time-management', 0.9],
    ['нотатки, конспект, нотатку, notes, note', 'productivity', 'notes', 1.0],
    ['презентація, презентацію, слайди, presentation, slides, deck, pitch', 'productivity', 'presentations', 1.0],
    ['таблиця, таблиці, excel, spreadsheet, sheets', 'productivity', 'spreadsheets', 1.0],
    ['проєкт, проект, проєкти, задачі, project, projects, tasks', 'productivity', 'project-management', 0.9],
    ['подорож, поїздка, поїздку, мандрівка, відпустка, туризм, маршрут, trip, travel, vacation, itinerary', 'productivity', 'travel', 1.0],
    ['пошта, лист, листи, email, mail, inbox', 'productivity', 'email-assistants', 0.9],
    ['асистент, помічник, assistant', 'productivity', 'ai-assistants', 0.7],
    ['браузер, browser', 'productivity', 'ai-browsers', 1.0],

    // --- SEO та контент
    ['seo, пошукова, оптимізація, ключові, трафік, traffic, keywords', 'seo-content', 'seo', 1.0],
    ['тренди, тренд, trends, trending', 'seo-content', 'trends', 1.0],

    // --- Дизайн та креатив
    ['дизайн, design, designer', 'design-creative', null, 1.0],
    ['логотип, лого, банер, листівка, постер, logo, banner, poster, flyer, graphic', 'design-creative', 'graphic-design', 1.0],
    ['інтерфейс, макет, прототип, ui, ux, figma, mockup, prototype', 'design-creative', 'ui-ux', 1.0],
    ['колір, кольори, палітра, color, colour, palette', 'design-creative', 'colors', 1.0],
    ['графік, діаграма, інфографіка, chart, graph, infographic, visualization', 'design-creative', 'data-visualization', 1.0],
    ['дані, даних, аналіз, data, analysis', 'design-creative', 'data-analysis', 0.9],
    ['звіт, звіти, report, reports', 'design-creative', 'reports', 0.8],
    ['тату, татуювання, tattoo', 'design-creative', 'tattoo-design', 1.0],

    // --- Фінанси та юридичні
    ['фінанси, гроші, бюджет, витрати, податки, бухгалтерія, finance, money, budget, tax, bookkeeping', 'finance-legal', 'finance', 1.0],
    ['інвестиції, інвестувати, invest, investing, investment', 'finance-legal', 'investments', 1.0],
    ['акції, біржа, трейдинг, stock, stocks, trading', 'finance-legal', 'stock-trading', 1.0],
    ['крипта, криптовалюта, біткоїн, crypto, bitcoin, blockchain', 'finance-legal', 'crypto-web3', 1.0],
    ['юрист, юридичний, закон, позов, legal, lawyer, law', 'finance-legal', 'legal-services', 1.0],
    ['документ, документи, договір, контракт, pdf, document, documents, contract', 'finance-legal', 'documents', 0.9],

    // --- Здоров'я та краса (чутливий розділ: лише за прямими словами)
    ['здоров, здоровя, лікар, медицина, медичний, хвороба, ліки, health, doctor, medical, medicine', 'health-beauty', 'medicine', 1.0],
    ['симптом, симптоми, symptom, symptoms', 'health-beauty', 'symptom-checkers', 1.0],
    ['сон, безсоння, sleep, insomnia', 'health-beauty', 'sleep', 1.0],
    ['харчування, дієта, раціон, схуднути, схуднення, калорії, nutrition, diet, calories', 'health-beauty', 'nutrition', 1.0],
    ['психолог, тривога, депресія, стрес, mental, anxiety, depression, stress, therapy', 'health-beauty', 'mental-health', 1.0],
    ['шкіра, шкіри, skin, skincare, acne', 'health-beauty', 'skin-care', 1.0],
    ['макіяж, краса, зачіска, стиль, makeup, beauty, hairstyle, style', 'health-beauty', 'beauty-style', 1.0],
    ['масаж, massage', 'health-beauty', 'massage-recovery', 1.0],
    ['реабілітація, фізіотерапія, rehabilitation, physiotherapy', 'health-beauty', 'rehabilitation-physiotherapy', 1.0],

    // --- Інструменти та автоматизація
    ['автоматизація, автоматизувати, automation, automate, workflow, zapier', 'tools-automation', 'automation', 1.0],
    ['інтеграція, integration, integrations', 'tools-automation', 'integrations', 1.0],
    ['агент, агенти, agent, agents', 'tools-automation', 'ai-agents', 1.0],
    ['розпізнати, сканувати, скан, ocr, scan', 'tools-automation', 'ocr', 1.0],
    ['плагін, розширення, plugin, extension', 'tools-automation', 'plugins', 1.0],

    // --- Мій дім
    ['рослина, рослини, кімнатні, plant, plants, houseplant', 'my-home', 'houseplants', 1.0],
    ['сад, садівництво, garden, gardening', 'my-home', 'garden', 1.0],
    ['город, грядки', 'my-home', 'kitchen-garden', 1.0],
    ['собака, собаку, пес, цуценя, dog, puppy', 'my-home', 'dog-training', 1.0],
    ['тварина, тварини, кіт, кішка, pet, pets, kitten', 'my-home', 'pets', 1.0],
    ['рецепт, рецепти, готувати, кулінарія, страва, вечеря, recipe, recipes, cook, cooking, meal', 'my-home', 'cooking', 1.0],
    ['авто, автомобіль, машина, машину, пдр, car, driving', 'my-home', 'auto', 1.0],
    ['інтерєр, interior', 'my-home', 'interior-design', 1.0],
    ['ремонт, будівництво, renovation, repair', 'my-home', 'renovation', 1.0],
    ['розумний, smart', 'my-home', 'smart-home', 0.7],
    // чутлива підкатегорія (search_only_on_match): лише прямі слова про померлих і пам'ять про них
    ["помер, померла, померли, померлий, померлого, померлої, померлих, покійний, покійна, покійного, загиблий, загиблих, меморіал, меморіальний, поминки, горювання, оживити, оживлення, deceased, died, memorial, griefbot, griefbots, deadbot, deadbots, afterlife, bereavement, bereaved, mourning", 'my-home', 'digital-memory-legacy', 1.0],
    ["пам'ять, пам'яті, памяті, двійник, двійника, remembrance, memories", 'my-home', 'digital-memory-legacy', 0.5],
    ['діти, дитина, дитини, дітей, батьки, виховання, kids, child, children, parenting', 'my-home', 'parenting', 1.0],
    ['покупки, магазин, shopping, shop', 'my-home', 'shopping', 0.8],
    ['енергія, сонячні, генератор, energy, solar', 'my-home', 'home-energy', 1.0],

    // --- Спорт
    ['спорт, фітнес, тренування, тренуватися, вправи, sport, sports, fitness, workout, exercise', 'sports', 'sports-fitness', 1.0],
    ['тренер, coach, coaching', 'sports', 'coaching-tools', 1.0],
    ['кіберспорт, esports', 'sports', 'esports', 1.0],

    // --- Кар'єра та робота
    ['резюме, cv, resume', 'career', 'resume-builders', 1.0],
    ['супровідний, cover, letter', 'career', 'resume-builders', 0.8],
    ['співбесіда, співбесіду, interview', 'career', 'interview-prep', 1.0],
    ['робота, роботу, вакансія, вакансії, job, jobs, vacancy', 'career', 'job-search', 1.0],
    ['фриланс, фрилансер, freelance, freelancer', 'career', 'freelance', 1.0],
    ['карєра, career', 'career', 'career-growth', 1.0],

    // --- Кібербезпека
    ['пароль, паролі, password, passwords', 'cybersecurity', 'password-managers', 1.0],
    ['vpn, приватність, анонімність, privacy', 'cybersecurity', 'vpn-privacy', 1.0],
    ['вірус, віруси, антивірус, virus, antivirus, malware', 'cybersecurity', 'device-protection', 1.0],
    ['шахрай, шахраї, шахрайство, шахрайський, дипфейк, дипфейки, діпфейк, підробка, підроблений, фейк, фейковий, переадресація, scam, scams, scammer, fraud, deepfake, deepfakes, fake, phishing, фішинг', 'cybersecurity', 'anti-scam-deepfakes', 1.0],
    ['клонування, клонований, spoofing, переадресацію', 'cybersecurity', 'anti-scam-deepfakes', 0.6],
    ['безпека, захист, хакер, security, hacker, protect', 'cybersecurity', null, 0.8],

    // --- Доступність
    ['незрячий, незрячих, сліпий, слабозорий, blind, vision', 'accessibility', 'blind-low-vision', 1.0],
    ['глухий, глухих, слабочуючий, deaf, hearing', 'accessibility', 'deaf-hard-of-hearing', 1.0],
    ['дислексія, dyslexia, adhd', 'accessibility', 'reading-neurodiversity', 1.0],
    ['доступність, інклюзивність, accessibility', 'accessibility', null, 1.0],

    // --- Релігія (чутливий розділ: лише за прямими словами)
    ['релігія, церква, церкви, молитва, молитви, помолитися, помолитись, молитися, бог, віра, духовний, духовність, біблія, коран, храм, мечеть, православя, християнство, religion, church, prayer, god, faith, bible, quran, mosque, temple', 'religion', null, 1.0],
    ['медитація, meditation', 'religion', null, 0.4],
    ['медитація, meditation', 'health-beauty', 'mental-health', 0.6],

    // --- Езотерика (чутливий розділ: лише за прямими словами)
    ['езотерика, езотеричний, окультизм, окультний, містика, містичний, esoteric, esoterics, occult, mystic, mysticism, metaphysical', 'esoterics', null, 1.0],
    ['гороскоп, гороскопи, астрологія, астролог, зодіак, знак зодіаку, ретроградний, horoscope, horoscopes, astrology, astrologer, zodiac', 'esoterics', 'astrology', 1.0],
    ['натальна, натальну, натальна карта, асцендент, синастрія, ефемериди, natal, ascendant, synastry, ephemeris', 'esoterics', 'astro-software', 1.0],
    ['джйотіш, кундлі, кундалі, панчанг, ведична астрологія, jyotish, kundli, kundali, panchang, vedic astrology', 'esoterics', 'vedic-astrology', 1.0],
    ['фен-шуй, феншуй, бацзи, ба цзи, feng shui, bazi', 'esoterics', 'feng-shui', 1.0],
    ['таро, тарот, оракул, оракули, ленорман, tarot, oracle, lenormand', 'esoterics', 'tarot', 1.0],
    ['нумерологія, нумеролог, ангельські числа, numerology, numerologist, angel numbers', 'esoterics', 'numerology', 1.0],
    ['ворожіння, ворожити, гадання, гадати, руни, рунічний, хіромантія, долоня, і-цзин, маятник, divination, runes, palmistry, palm reading, i ching, pendulum, dowsing', 'esoterics', 'divination', 1.0],
    ['екстрасенс, екстрасенси, медіум, медіуми, ясновидець, psychic, psychics, clairvoyant', 'esoterics', 'psychics', 1.0],
    ['чаклунство, відьма, відьми, відьомство, вікка, язичництво, заклинання, witch, witchcraft, wicca, pagan', 'esoterics', 'witchcraft', 1.0],
    ['оберіг, обереги, амулет, амулети, талісман, зле око, зурочення, пристріт, захист від зла, amulet, amulets, talisman, evil eye, hamsa', 'esoterics', 'protection', 1.0],
    ['кристал, кристали, мінерал, мінерали, crystal, crystals, gemstone, gemstones', 'esoterics', 'crystals', 0.9],
    ['пахощі, ладан, шавлія, пало санто, ритуальні свічки, incense, frankincense, sage, palo santo, smudge', 'esoterics', 'incense-candles', 1.0],
    ['рейкі, чакра, чакри, аура, цигун, reiki, chakra, chakras, aura, qigong', 'esoterics', 'energy-practices', 1.0],
    ['дизайн людини, бодіграф, human design, bodygraph, gene keys', 'esoterics', 'human-design', 1.0],
    ['сонник, наснилося, снилося, усвідомлені сни, dream, dreams, lucid dreaming', 'esoterics', 'dreams', 1.0],
    ['місячний календар, фаза місяця, молодик, moon calendar, moon phase, full moon, new moon', 'esoterics', 'moon-calendars', 1.0],

    // --- Українські додатки (чутливий розділ: не АІ, лише за прямими словами)
    ['український застосунок, українські застосунки, український додаток, українські додатки, ukrainian app, ukrainian apps', 'ukrainian-apps', null, 1.0],
    ['дія, держпослуги, державні послуги, пенсійний фонд, пенсія, податкова, моя податкова, diia', 'ukrainian-apps', 'ua-gov', 1.0],
    ['резерв+, армія+, військовий облік, відстрочка, тцк, впо, military id', 'ukrainian-apps', 'ua-military', 1.0],
    ['банк, банки, мобільний банк, монобанк, приват24, приватбанк, ощадбанк, картка, bank, banking, monobank, privatbank', 'ukrainian-apps', 'ua-banks', 1.0],
    ['комуналка, комунальні, оплата рахунків, платіж, платежі, переказ, utilities, bills', 'ukrainian-apps', 'ua-payments', 1.0],
    ['світло, електроенергія, відключення, графік відключень, обленерго, газ, вода, водоканал, показники лічильника, лічильник, electricity, outage, outages', 'ukrainian-apps', 'ua-energy', 1.0],
    ['тривога, повітряна тривога, укриття, сирена, ппо, шахед, air alert, air raid, shelter', 'ukrainian-apps', 'ua-alerts', 1.0],
    ['міський застосунок, паркування, проїзд, петиція, city app, parking', 'ukrainian-apps', 'ua-city', 1.0],
    ['укрзалізниця, потяг, поїзд, квитки на потяг, автобус, таксі, громадський транспорт, train, train tickets, taxi', 'ukrainian-apps', 'ua-transport', 1.0],
    ['азс, заправка, пальне, бензин, зарядна станція, електромобіль, штрафи пдр, fuel, petrol, ev charging', 'ukrainian-apps', 'ua-auto', 1.0],
    ['страховка, страхування, автоцивілка, осцпв, зелена карта, insurance', 'ukrainian-apps', 'ua-insurance', 1.0],
    ['нова пошта, укрпошта, посилка, посилки, доставка посилок, вантажоперевезення, доставка квітів, parcel, parcels', 'ukrainian-apps', 'ua-delivery', 1.0],
    ['аптека, аптеки, ліки, запис до лікаря, клініка, pharmacy', 'ukrainian-apps', 'ua-health', 0.8],
    ['супермаркет, продукти, доставка продуктів, groceries, supermarket', 'ukrainian-apps', 'ua-groceries', 1.0],
    ['київстар, водафон, лайфсел, мобільний оператор, тариф, kyivstar, vodafone, lifecell', 'ukrainian-apps', 'ua-telecom', 1.0],
    ['телебачення, телеканал, телеканали, радіостанція, радіо, онлайн-кінотеатр', 'ukrainian-apps', 'ua-media', 0.8],
    ['донат, донати, збір, збори, благодійність, волонтер, волонтерство, переселенці, правова допомога, donate, donation, charity', 'ukrainian-apps', 'ua-charity', 1.0],
    ['фоп, рро, прро, документообіг, кеп, sole trader', 'ukrainian-apps', 'ua-business', 1.0],
];

/** @return list<array{stem:string, cat:string, sub:?string, w:float}> */
function eli_intents_rows(): array
{
    $rows = [];
    foreach (ELI_INTENTS as [$words, $cat, $sub, $w]) {
        foreach (array_filter(array_map('trim', explode(',', $words))) as $word) {
            $stem = eli_search_stem(eli_search_clean($word));
            $rows[$stem . '|' . $cat . '|' . ($sub ?? '')] = ['stem' => $stem, 'cat' => $cat, 'sub' => $sub, 'w' => $w];
        }
    }

    return array_values($rows);
}

$mode = $argv[1] ?? 'list';
$rows = eli_intents_rows();

if ($mode === 'list') {
    $by = [];
    foreach ($rows as $r) {
        $by[$r['cat'] . ($r['sub'] ? ' / ' . $r['sub'] : '') . ' (×' . $r['w'] . ')'][] = $r['stem'];
    }
    foreach ($by as $k => $stems) {
        echo $k . ': ' . implode(', ', $stems) . "\n";
    }
    echo "\nУсього: " . count($rows) . " основ-зв'язків, " . count(array_unique(array_column($rows, 'stem'))) . " різних основ\n";
    exit;
}

$q = static fn(string $s): string => "'" . str_replace(["\\", "'"], ["\\\\", "''"], $s) . "'";
foreach ($rows as $r) {
    $catSql = '(SELECT id FROM categories WHERE slug = ' . $q($r['cat']) . ' LIMIT 1)';
    $subSql = $r['sub'] === null ? 'NULL'
        : '(SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = ' . $q($r['cat']) . ' AND s.slug = ' . $q($r['sub']) . ' LIMIT 1)';
    echo 'INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT ' . $q($r['stem']) . ', ' . $catSql . ', ' . $subSql . ', ' . $r['w']
        . ' FROM DUAL WHERE ' . $catSql . ' IS NOT NULL' . ($r['sub'] !== null ? ' AND ' . $subSql . ' IS NOT NULL' : '')
        . ' AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = ' . $q($r['stem'])
        . ' AND si.category_id <=> ' . $catSql . ' AND si.subcategory_id <=> ' . $subSql . ");\n";
}
