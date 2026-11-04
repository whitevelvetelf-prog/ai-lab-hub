---
title: "Practice sites for testers: where to train manual testing, APIs and automation for free"
description: "A collection of free QA practice sites: training shops with deliberate bugs, playgrounds for Selenium and Playwright, test APIs, mobile demo apps, SQL and security trainers, plus a 30-day plan and portfolio tips."
date: "2026-11-04"
updated: "2026-11-04"
---

# Practice sites for testers: where to train for free

You can read testing theory in a week, but employers care about something else: can you find a bug, describe it so that a developer reproduces it on the first try, write test cases and check an API? The only way to learn that is practice. Luckily you don't need a real project: there are dozens of free sites built specifically for training testers, with deliberate bugs, tricky elements and practice APIs.

This article collects the most useful practice sites grouped by skill, and ends with a 30-day plan and tips on turning practice into a portfolio.

> **Important.** We checked that these sites were available on 1 and 4 November 2026. Training sites sometimes move or shut down. If a link doesn't open, check the [Practice Sites for Testers](subcategory:qa-practice) subcategory, where we keep the list up to date.

## How to use practice sites

The biggest mistake is clicking around aimlessly. Work as you would on a real project:

1. **Study the product.** Walk through the main scenarios and note what the app does and who it is for.
2. **Write a checklist or test cases.** Use [Qase](product:Qase), [TestLink](product:TestLink) or even a spreadsheet.
3. **Test and log defects.** Each bug needs repro steps, expected and actual results and a screenshot. [Jam](product:Jam) or [Monosnap](product:Monosnap) are handy for capturing.
4. **Check the API and database** if the site allows it.
5. **Sum up:** a short test report covering what was tested, what was found and what still needs checking.

## Find the bug: sites with deliberate defects

These sites are built for manual testing: the bugs are planted on purpose, and your job is to find as many as you can.

- **[Buggy Cars Rating](product:Buggy Cars Rating)** is a car rating site with registration, profiles, voting and comments. The bugs are deliberate, so the site is often used as a take-home task in interviews.
- **[AcademyBugs](product:AcademyBugs)** is an online shop with deliberate defects of different types: buttons that don't work, wrong prices, a broken video player. The site explains bug types and shows how to write a proper bug report.
- **[Practice Software Testing](product:Practice Software Testing)** (Toolshop) is a modern tool shop with a REST API and several versions, including one with deliberate bugs. It suits both manual and automated testing.
- **[QA Practice](product:QA Practice)** has a "find the bugs" challenge, plus forms, an online shop, a REST API and GraphQL.
- **[Test Pages](product:Test Pages)** by Alan Richardson (EvilTester) offers pages, games and challenges for exploratory testing.
- **[TestSheepNZ](product:TestSheepNZ)** from New Zealand tester Mike Talks has a number-guessing game for exploratory testing with a findings log, automation katas and unusual projects.

To quickly insert boundary values and awkward characters into fields, install [BugMagnet](product:BugMagnet); to log an exploratory session, use the [Exploratory Testing Extension](product:Exploratory Testing Extension).

## Realistic apps for test cases and scenarios

These sites look like real products, which makes them good for practising test design: test cases, checklists, scenarios and regression suites.

- **Online shops:** [Sauce Demo](product:Sauce Demo) (Swag Labs) with several test users that behave differently, [Automation Exercise](product:Automation Exercise) with ready test cases, [Demoblaze](product:Demoblaze), [StackDemo](product:StackDemo) from BrowserStack and [Weather Shopper](product:Weather Shopper), where you pick a sunscreen based on the temperature.
- **Banks and business systems:** [ParaBank](product:ParaBank) (an online bank with accounts and transfers), the [OrangeHRM Demo](product:OrangeHRM Demo) HR system and [Guru99 Demo Sites](product:Guru99 Demo Sites) with banking, insurance and telecom projects.
- **Other app types:** the [Conduit](product:Conduit) (RealWorld) blogging platform, the [BlazeDemo](product:BlazeDemo) travel agency, [Contact List App](product:Contact List App) with a UI and API and [TodoMVC](product:TodoMVC) built with different frameworks.
- **[Cypress Real World App](product:Cypress Real World App)** is a payment app that runs locally and comes with ready automated test examples.

Tip: pick one app and go deep, from checklist to report, instead of glancing at ten.

## Playgrounds with tricky elements

Each page here is a typical problem: dynamic IDs, iframes, pop-ups, drag and drop, file uploads, elements that appear with a delay. For manual testers these pages show where defects tend to hide; for future automation engineers, what they will have to automate.

- **[The Internet](product:The Internet)** (Herokuapp): 40+ classic examples that thousands of automation engineers started with.
- **[DemoQA](product:DemoQA)**: forms, widgets, windows, drag and drop and a bookstore with an API.
- **[UI Test Automation Playground](product:UI Test Automation Playground)**: UI automation traps such as dynamic IDs, hidden layers and AJAX delays.
- **[Expand Testing Practice](product:Expand Testing Practice)**, **[LetCode](product:LetCode)**, **[WebDriverUniversity](product:WebDriverUniversity)**, **[Bondar Academy Playground](product:Bondar Academy Playground)**, **[TestKru](product:TestKru)** and **[GlobalSQA Demo Site](product:GlobalSQA Demo Site)**: big playgrounds for Selenium, Playwright and Cypress.
- **[Practice Test Automation](product:Practice Test Automation)** and the **[Rahul Shetty Academy Practice Page](product:Rahul Shetty Academy Practice Page)**: simple pages for your very first practice.

## Locators: CSS and XPath

You can't do without finding elements on a page, whether in automation or in DevTools.

- **[CSS Diner](product:CSS Diner)** is a 32-level game that teaches CSS selectors.
- **[XPather](product:XPather)** is a real-time online XPath tester.
- **[Testing Playground](product:Testing Playground)** suggests the best Testing Library query with accessibility in mind.
- The **[SelectorsHub](product:SelectorsHub)** extension generates and verifies XPath, CSS and Playwright locators on any site.

## Test APIs

You can send requests freely to these services from [Postman](product:Postman), [Bruno](product:Bruno) or [Hoppscotch](product:Hoppscotch) without worrying about breaking anything:

- **[ReqRes](product:ReqRes)** and **[JSONPlaceholder](product:JSONPlaceholder)**: the easiest start, with real responses and no sign-up.
- **[Restful-Booker](product:Restful-Booker)**: a booking API with authentication and deliberate bugs; data resets every 10 minutes.
- **[Swagger Petstore](product:Swagger Petstore)**: a demo API with Swagger UI docs where you can send requests right from the browser.
- **[GoRest](product:GoRest)**: tokens, pagination and an OpenAPI spec, as in real projects.
- **[Fake Store API](product:Fake Store API)** and **[DummyJSON](product:DummyJSON)**: online shop data, authentication, search.
- **[httpbin](product:httpbin)** echoes back what you sent, which is handy for learning methods, headers, status codes and delays.

**[JSONLint](product:JSONLint)** helps check a response for syntax errors.

## Mobile apps

**[Sauce Labs My Demo App](product:Sauce Labs My Demo App)** is a demo shop for Android and iOS where you can practise both manual mobile testing and automation with [Appium](product:Appium). [Genymotion](product:Genymotion) gives you an emulator to install it on, and [scrcpy](product:scrcpy) mirrors a phone screen to your computer.

## Security testing

- **[OWASP Juice Shop](product:OWASP Juice Shop)** is a deliberately vulnerable online shop from OWASP with a challenge board: XSS, SQL injection, authentication flaws and more.
- **[PortSwigger Web Security Academy](product:PortSwigger Web Security Academy)** is a free course from the makers of [Burp Suite](product:Burp Suite) with interactive labs.

Practise only on these training sites: testing the security of other people's real services without permission is illegal.

## SQL, regular expressions and Git

Testers often check data in the database, search logs and work with repositories. There are dedicated trainers for that:

- SQL: **[SQLBolt](product:SQLBolt)** (short lessons with exercises), **[SQLZoo](product:SQLZoo)** and the detective game **[SQL Murder Mystery](product:SQL Murder Mystery)**.
- Regular expressions: **[RegexOne](product:RegexOne)** and **[regex101](product:regex101)**.
- Git: **[Learn Git Branching](product:Learn Git Branching)** with branch visualisation.

## Courses, communities and first real projects

- Free courses: **[Test Automation University](product:Test Automation University)**, **[Katalon Academy](product:Katalon Academy)**, **[ToolsQA](product:ToolsQA)**, **[Guru99 Software Testing](product:Guru99 Software Testing)**.
- Certification: **[ISTQB](product:ISTQB)** syllabi and sample exams are free.
- Community: **[Ministry of Testing](product:Ministry of Testing)** has articles, events and discussions.
- Real experience: **[uTest](product:uTest)** offers training and paid crowdtesting projects.
- Instructor-led courses in Ukrainian: **[QALight](product:QALight)**, **[Hillel IT School — QA Manual](product:Hillel IT School — QA Manual)**, **[Mate academy — QA](product:Mate academy — QA)**.

## A 30-day plan

| Week | What to do | Practice sites |
|---|---|---|
| 1 | Explore one app, write a checklist and 15–20 test cases | Sauce Demo, Automation Exercise |
| 2 | Hunt for bugs and write bug reports | Buggy Cars Rating, AcademyBugs, Practice Software Testing |
| 3 | Test APIs in Postman: status codes, validation, authentication | ReqRes, Restful-Booker, GoRest |
| 4 | SQL, locators and your first automated tests | SQLBolt, CSS Diner, The Internet, DemoQA |

## Turning practice into a portfolio

Employers would much rather see your work than read "I know testing theory". Collect in a public GitHub repo or a document:

- test cases and a checklist for one of the practice sites;
- 5–10 good bug reports with screenshots or video;
- a Postman collection for a test API;
- a short test report;
- optionally, a few automated tests in Playwright or Selenium.

For the tools behind each step, read [Manual testing tools](blog-post.php?slug=manual-testing-tools&hl=en) and [Test automation tools](blog-post.php?slug=test-automation-tools&hl=en).

## FAQ

**Which practice site should a beginner start with?**
[Sauce Demo](product:Sauce Demo) or [Buggy Cars Rating](product:Buggy Cars Rating): they are simple but give you both scenarios for test cases and real bugs.

**Can I list practice sites on my CV?**
Yes, if you show results: links to test cases, bug reports or an API collection. A bare list of sites won't help.

**Is it safe to send requests to test APIs?**
Yes, that's what these services are for. But don't enter real personal data or passwords there, as other users may see them.

**Not sure where to start?**
Ask [Elya](eli.php): she will pick practice sites for your level and direction, whether manual testing, APIs or automation.

*Fact-check date: 4 November 2026. Training sites may change, so see the Practice Sites for Testers subcategory for the current list.*
