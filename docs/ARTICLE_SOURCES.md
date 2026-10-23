# Джерела статті «ШІ та пам'ять про померлих» (slug ai-digital-memory-loved-ones)

Дата перевірки всіх пунктів: **2026-10-23**, якщо не вказано інше.
Позначки: ✅ підтверджено першоджерелом · ⚠️ лише вторинне джерело (журналістика / комерційний сайт) · ❌ не вдалося підтвердити.

## 1. Статус компаній «розмовних копій»

| Сервіс | Статус | Як перевірено |
|---|---|---|
| HereAfter AI | ✅ головний сайт hereafter.ai повертає 404 (HTTP-запит 2026-10-23); app.hereafter.ai ще відповідає 200. ⚠️ Дати «прощальне повідомлення в липні 2026, офлайн з 18.08.2026, записи лише за запитом на support@hereafter.ai» — тільки з afterlife.ai (конкурент), офіційної заяви не знайдено. | curl, [afterlife.ai](https://www.afterlife.ai/hereafter-ai-shutting-down) |
| StoryFile | ✅ банкрутство за главою 11 (New York Southern, справа 7:24-bk-22398, подано 05.05.2024; ⚠️ закрито через добровільне припинення 30.04/05.05.2025 за PacerMonitor). ⚠️ Продаж активів Key 7 Investment (02.2025) — сторінка компанії storyfile.com/news/key7-purchase тепер 404, лише вторинні джерела. ✅ Сайт storyfile.com зараз продає B2B-платформу для музеїв/установ («Book a demo») і згадує «Legacies»; споживчого застосунку чи цін немає. | storyfile.com, [PacerMonitor](https://www.pacermonitor.com/public/case/53384816/StoryFile,_Inc), [AI Business](https://aibusiness.com/verticals/startup-behind-ai-william-shatner-files-for-bankruptcy) |
| Eternos → Uare.ai | ✅ uare.ai працює: «Human-First Individual AIs» для живих професіоналів, верифікація особи, експорт і видалення даних, дані не йдуть на навчання публічних моделей. Про Eternos і посмертне використання на сайті не згадано. ⚠️ Ребрендинг і раунд $10,3 млн (листопад 2025) — вторинні джерела. | uare.ai, [The AI Insider](https://theaiinsider.tech/2025/11/29/liveperson-founder-rebrands-eternos-as-uare-ai-and-raises-10-3m-to-build-personal-ai-models-based-on-human-life-stories) |
| You, Only Virtual (YOV) | ✅ myyov.com працює, продукт «Versona», доступ лише через «Join The Waitlist»; на головній немає умов про згоду, видалення даних чи ціни. ❌ Функцію «Versona Voice / дзвінки» на сайті не підтверджено. | myyov.com |
| Project December | ✅ projectdecember.net працює; доступ за разову оплату $5.00 з 1000 «compute credits» (сторінка buy.php). Вікових обмежень і застережень на сторінці покупки не знайдено. ❌ «Плата за сеанс» не підтверджено в такому формулюванні. | projectdecember.net/buy.php |
| Seance AI | ✅ seance.ai — припаркований домен (сервер «Parking/1.0», HTTP 436/405). Сервіс вважаємо недоступним. | curl |
| Soul Machines | ⚠️ у receivership з 05.02.2026 (KPMG), за NBR. Сайт ще відкривається. У каталог не додаємо (B2B «цифрові працівники», не про пам'ять). | [NBR](https://www.nbr.co.nz/tech/soul-machines-in-receivership) |
| Sensay | ✅ змінив напрям: сайт sensay.io продає збереження знань співробітників, що звільняються (AI-інтерв'юер), а не «репліки» людей. | sensay.io |

## 2. Дослідження й етика

- ✅ Hollanek T., Nowaczyk-Basińska K. *Griefbots, Deadbots, Postmortem Avatars: on Responsible Applications of Generative AI in the Digital Afterlife Industry.* Philosophy & Technology 37, 63 (09.05.2024), відкритий доступ. DOI [10.1007/s13347-024-00744-w](https://doi.org/10.1007/s13347-024-00744-w). Підтверджено в тексті: три сценарії (зокрема бот, що вставляє рекламу в мову померлої бабусі); рекомендації — процедури «відставки» (retirement) ботів, змістовна прозорість (видно, що це ШІ, і ризики пояснено до початку), доступ лише для дорослих, принцип взаємної згоди «донора даних» і користувачів, протоколи виходу (opt-out).
- ✅ Lu J., Yang M., Cui Y., Liu Y., Wong T.K.S., Hu Y. *Exploring public perceptions of artificial intelligence in bereavement support: a qualitative study of griefbots.* Frontiers in Digital Health 8 (02.06.2026). [Посилання](https://www.frontiersin.org/journals/digital-health/articles/10.3389/fdgth.2026.1852514/full). 25 дорослих, провінція Гуандун (Китай), інтерв'ю жовтень 2024; учасники обговорювали уявне, а не реальне тривале використання. Вигоди: втіха, відчуття продовження зв'язку, символічне завершення. Ризики: порушення природного горювання, неавтентичність і спотворення образу, залежність і погіршення соціального функціонування, тривале горе, шахрайство, використання даних без згоди. Висновок: «neither inherently beneficial nor inherently harmful».
- ✅ (анотація) Betancur Franco et al. *Design guidelines for the therapeutic use of AI in grief.* Journal of Responsible Technology 25 (03.2026), DOI [10.1016/j.jrt.2026.100148](https://doi.org/10.1016/j.jrt.2026.100148). Інтерв'ю з терапевтами (N=4), опитування людей із досвідом втрати (N=49), інтерв'ю (N=4); настанови: персоналізація, приватність і безпека даних, нагляд фахівця, обмеження за віком і психологічними особливостями; рамка RUDA. Повний текст закритий (ScienceDirect 403). ❌ «Порівняння з прийомом ліків» і «терапевти відкритіші до обмеженого використання» в анотації не підтверджено — у статті не використовуємо.
- ✅ (анотація/опис) Cheng K.Y. *Principles of consent and non-addiction in AI grief bots.* Journal of Responsible Technology 26 (06.2026), DOI 10.1016/j.jrt.2026.100177 ([NYU IFP](https://ifp.nyu.edu/2026/journal-article-abstracts/principles-of-consent-and-non-addiction-in-ai-grief-bots/)). Згода на створення, використання й видалення; запобігання залежності (тайм-аути, постійні нагадування, що це ШІ). ⚠️ Деталі взято з анотації через пошук, повний текст недоступний.
- ✅ Kozlovski A., Harbinja E., Dobbe R. *The Many Faces of Indeterminacy in Interactive Deadbots.* Philosophy & Technology 39(2):74 (13.04.2026). [PMC13076435](https://pmc.ncbi.nlm.nih.gov/articles/PMC13076435/). Пошукові (записані відповіді: HereAfter, StoryFile) проти генеративних (Project December, YOV, Seance AI) систем; генеративні дають різні відповіді на те саме питання, можуть «галюцинувати».
- ✅ Hospice News, H. Vossel, *AI Grief Bots Present 'New Complexities' in Bereavement Care* (09.04.2026). [Посилання](https://hospicenews.com/2026/04/09/ai-grief-bots-present-new-complexities-in-bereavement-care/). Фахівці з горя: ризик розмиття межі між пам'яттю й присутністю, плутанина «що реально» у вразливому стані, явна згода людини за життя. ⚠️ Оцінка ринку: ~22 млрд $ (2024) → ~80 млрд $ (2034) — цитата з «Wellbeing Sciences Review» у Hospice News, першоджерело не відкрито.
- ❌ Medscape, *AI Griefbots Resurrect Dead Loved Ones: Healthy or Harmful?* — платний доступ (HTTP 402), не прочитано. У статті не цитуємо.

## 3. Право (огляд, не юридична порада)

- ✅ Цивільний кодекс України, ст. 303 ч. 4 і ст. 308 ч. 1 ([zakon.rada.gov.ua/laws/show/435-15](https://zakon.rada.gov.ua/laws/show/435-15)): після смерті людини її особисті папери (зокрема листи, фото, щоденники) й зображення можна публічно використовувати лише за згодою дітей, вдови (вдівця), а якщо їх немає — батьків, братів і сестер.
- ✅ GDPR, recital 27 ([gdpr-info.eu](https://gdpr-info.eu/recitals/no-27/)): регламент не застосовується до даних померлих; країни ЄС можуть мати власні правила. Дані живих родичів у листуванні — персональні дані цих людей.
- ✅ AI Act ЄС, ст. 50 ([artificialintelligenceact.eu/article/50](https://artificialintelligenceact.eu/article/50/)): люди мають знати, що спілкуються з ШІ; синтетичний контент маркується; дипфейки розкриваються; застосовується з 02.08.2026. ⚠️ Що Digital Omnibus (Регламент 2026/1744) не відклав ст. 50 — лише вторинні джерела.
- ⚠️ США: Tennessee ELVIS Act (чинний з 01.07.2024, голос як частина прав на образ); California AB 1836 (підписано 17.09.2024, чинний з 01.01.2025, цифрові репліки померлих виконавців без згоди спадкоємців); NO FAKES Act (S.4591) — на 23.10.2026 не ухвалений (схвалений комітетом Сенату 18.06.2026). Підтверджено через юридичні огляди й прес-релізи, congress.gov не відкрився (403).
- Спеціального закону саме про «deadbots» ми не знайшли ні в Україні, ні в ЄС, ні у США (стан на 2026-10-23). У статті формулюємо як «нам не відомо», без категоричних висновків.

## 4. Цифрова спадщина (функції платформ)

- ✅ Google Inactive Account Manager ([support.google.com/accounts/answer/3036546](https://support.google.com/accounts/answer/3036546)): до 10 довірених людей, власне повідомлення, вибір даних для передачі; без плану Google може видалити акаунт, неактивний щонайменше 2 роки.
- ✅ Apple Legacy Contact ([support.apple.com/102631](https://support.apple.com/en-us/102631)): iOS/iPadOS 15.2+ або macOS 12.1+; ключ доступу + свідоцтво про смерть; доступні фото, повідомлення, нотатки, файли, резервні копії; недоступні придбані медіа й дані iCloud Keychain.
- ⚠️ Meta (Facebook): «контакт-спадкоємець» може закріпити допис на меморіальній сторінці, змінити фото профілю, приймати запити в друзі, завантажити архів (якщо дозволено); не може входити в акаунт і читати приватні повідомлення ([оголошення Meta, 2015](https://about.fb.com/news/2015/02/adding-a-legacy-contact/)). Довідка Meta не читається без JavaScript; у статті радимо звіряти з актуальною довідкою.

## 5. Допомога в Україні

- ✅ Lifeline Ukraine — **7333**, цілодобово (головна сторінка [lifelineukraine.com](https://lifelineukraine.com), 2026-10-23).
- ✅ Платформа програми «Ти як?» — [howareu.com](https://howareu.com) (сайт відповідає; програма описана на [kmu.gov.ua](https://www.kmu.gov.ua/news/vseukrainska-prohrama-mentalnoho-zdorovia-ty-iak-kudy-zvertatysia-za-dopomohoiu), 2023).
- ✅ Екстрені служби: 112 (єдиний номер), 103 (швидка допомога).
- Інші номери з переліку КМУ (2023) у статті не наводимо: сторінка давня, повторно перевірити кожен не вдалося.
