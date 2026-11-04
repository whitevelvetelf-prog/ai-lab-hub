---
title: "Manual testing tools: what a QA tester should install in 2026"
description: "A manual QA toolkit: bug reports with logs (Jam), screenshots (Monosnap, ShareX), pixel-perfect and UI checks, Jira and Confluence, test management, proxies, test data, plus free places to learn and practise."
date: "2026-11-04"
updated: "2026-11-04"
---

# Manual testing tools: what a QA tester should install

Manual testing is not "clicking buttons". A good tester runs dozens of scenarios a day, files defects that developers can reproduce on the first try, checks layouts against the mockup down to the pixel and keeps documentation that tells the team whether a release is ready. Without the right tools all of this takes twice as long.

This article collects a working manual QA toolkit: from screenshots and bug reports to test management, proxies and practice sites for those just starting out. Most tools are free or have a free plan, which is plenty to get going.

> **Important.** We checked features and free terms on the official websites on 4 November 2026. Pricing changes, so check the current terms on the service's site before paying.

## A minimal kit for day one

If you have just joined a project, start here:

| Task | Tool | Price |
|---|---|---|
| Bug report with logs and video | [Jam](product:Jam) | free plan |
| Annotated screenshots | [Monosnap](product:Monosnap), [ShareX](product:ShareX), [Lightshot](product:Lightshot) | free |
| Checking layout against the mockup | [PerfectPixel](product:PerfectPixel), [Page Ruler](product:Page Ruler) | free |
| Network, console, responsiveness | [Chrome DevTools](product:Chrome DevTools) | built into the browser |
| Tasks and defects | [Jira](product:Jira) | free for up to 10 users |
| Documentation and checklists | [Confluence](product:Confluence) | free for up to 10 users |
| Test data for forms | [Fake Filler](product:Fake Filler), [Mockaroo](product:Mockaroo) | free |

Below is more detail on each group.

## Bug reports that reproduce on the first try

The most common reason a bug "can't be reproduced" is missing context: what was in the console, what the server returned, which browser it happened in. Modern tools collect this automatically.

- **[Jam](product:Jam)** is a Chrome extension and a Mac app. One click adds console logs, network requests, user events and device details to a screen recording or screenshot. Instant replay saves the last few seconds if the bug has already happened. AI suggests a title and repro steps, and the report goes out as a link or straight to Jira, Linear, GitHub or Slack.
- **[Bird Eats Bug](product:Bird Eats Bug)** works in a similar way: screen recording with logs, network and clicks, handy for both testers and support teams.
- **[Marker.io](product:Marker.io)**, **[BugHerd](product:BugHerd)**, **[Userback](product:Userback)** and **[Ybug](product:Ybug)** are website widgets: a tester or client clicks on the problem spot, and the service attaches a screenshot, URL, browser and screen size. Great for acceptance testing with a client.
- For mobile apps there are **[Luciq](product:Luciq)** (formerly Instabug) and **[Shake](product:Shake)**: a beta tester shakes the phone, draws on the screenshot and sends a report with logs.

Even the best tool can't replace structure. A good bug report always has a short "what, where, under which conditions" title, repro steps, expected and actual results, the environment (browser, OS, build), severity and evidence (screenshot or video).

## Screenshots and screen recording

A screenshot with a red box often explains more than a paragraph of text.

- **[Monosnap](product:Monosnap)** (Mac, Windows) captures an area, annotates, blurs and records video; the file is uploaded to the cloud at once and becomes a link for your bug report.
- **[ShareX](product:ShareX)** (Windows) is a free open-source all-rounder: scrolling screenshots, MP4 and GIF recording, text recognition.
- **[Lightshot](product:Lightshot)**, **[Greenshot](product:Greenshot)** and **[Flameshot](product:Flameshot)** are lightweight free apps; Flameshot is popular on Linux and lets you place numbered step markers right while capturing.
- **[Shottr](product:Shottr)** (Mac) also measures distances in pixels, which is useful for UI checks. **[CleanShot X](product:CleanShot X)** is another good Mac option.
- **[Snagit](product:Snagit)** is paid but has the handiest step-by-step guide templates.
- **[Loom](product:Loom)** is for when showing a video with voice is easier than describing a complex scenario.

## UI testing and pixel-perfect checks

Checking whether the layout matches the mockup is a big part of a manual tester's job, especially in agencies and product teams with a design system.

- **[PerfectPixel](product:PerfectPixel)** is the main pixel-perfect tool. The extension overlays a semi-transparent mockup (a file, a Figma frame or a URL) on the live page. Arrow keys nudge the layer by 1 pixel, and the "Difference" blend mode highlights every mismatched pixel. Free: 2 layers per domain.
- **[VisBug](product:VisBug)** from Google Chrome Labs shows spacing between elements, fonts, colours and contrast on hover.
- **[Page Ruler](product:Page Ruler)** and **[PixelSnap](product:PixelSnap)** measure sizes and distances in pixels; **[WhatFont](product:WhatFont)** shows the font, size and line height; **[ColorZilla](product:ColorZilla)** gives the exact colour of any point.
- **[Zeplin](product:Zeplin)** is the designer's source of truth: exact spacing, colours and fonts for every element of the mockup.
- Responsiveness is easy to check in **[Responsively App](product:Responsively App)** (free, open source), **[Polypane](product:Polypane)** or the **[Responsive Viewer](product:Responsive Viewer)** extension: the page appears on several screens at once with synced scrolling.
- **[Chrome DevTools](product:Chrome DevTools)** is a must: device and slow-network emulation, console, cookies, network requests. **[Lighthouse](product:Lighthouse)** and **[GTmetrix](product:GTmetrix)** give you a speed and basic accessibility report.

For accessibility, add **WAVE** by WebAIM and **[axe DevTools](product:axe DevTools)**: they flag contrast problems, missing field labels and heading structure issues. More in [Accessibility testing](blog-post.php?slug=accessibility-testing&hl=en).

## Jira, Confluence and test management

**[Jira](product:Jira)** is the most widely used task and defect tracker in IT teams: bugs, statuses, priorities, sprint boards. **[Confluence](product:Confluence)**, also from Atlassian, is the place for the test strategy, test plans, checklists and test reports, with pages linked to Jira issues. Both are free for teams of up to 10 people.

Tracker alternatives include **[YouTrack](product:YouTrack)** from JetBrains (also free for up to 10 users) and the open-source **[Redmine](product:Redmine)**, **[Mantis Bug Tracker](product:Mantis Bug Tracker)** and **[Bugzilla](product:Bugzilla)**.

Once test cases outgrow a spreadsheet, you need a test management system:

- **[TestRail](product:TestRail)** is the market classic: cases, test plans, runs and reports.
- **[Xray](product:Xray)** and **[Zephyr](product:Zephyr)** work right inside Jira.
- **[Qase](product:Qase)**, **[Tuskr](product:Tuskr)** and **[QA Touch](product:QA Touch)** have free plans, good for small teams and learning.
- **[Testomat.io](product:Testomat.io)** is a Ukrainian service that keeps manual cases and automated tests side by side and has an advanced Jira plugin.
- **[Testpad](product:Testpad)** replaces heavyweight test cases with checklists, which is very handy for regression and exploratory testing.
- **[TestLink](product:TestLink)** and **[Kiwi TCMS](product:Kiwi TCMS)** are free open-source systems you can install yourself and practise on.

For test design, try **[Xmind](product:Xmind)** mind maps and Microsoft's **[PICT](product:PICT)**, which generates a minimal set of combinations for pairwise testing.

## Network and APIs: proxies and clients

To see exactly what the app sends to the server, or to reproduce a backend error, you need a proxy:

- **[Charles Proxy](product:Charles Proxy)** is the classic for mobile app testing: HTTPS interception, response rewriting, network throttling.
- **[Proxyman](product:Proxyman)**, **[Fiddler](product:Fiddler)**, **[HTTP Toolkit](product:HTTP Toolkit)** and the free **[mitmproxy](product:mitmproxy)** are alternatives with the same core features.
- **[Requestly](product:Requestly)** modifies requests right in the browser: redirects, headers, fake responses.

For manual API checks, besides Postman, look at **[Bruno](product:Bruno)** (collections stored as files in Git, works offline) and **[Hoppscotch](product:Hoppscotch)** (runs in the browser). **[Webhook.site](product:Webhook.site)** gives you an address in a second to confirm the app really sends its webhook, and **[Mockoon](product:Mockoon)** spins up a fake API if the backend isn't ready yet.

## Test data, email and devices

- **[Fake Filler](product:Fake Filler)** fills an entire form with plausible data in one click, a lifesaver on long sign-up forms.
- **[Mockaroo](product:Mockaroo)** (free up to 1,000 rows) and **[generatedata.com](product:generatedata.com)** generate test data tables in CSV, JSON or SQL.
- **[Mailtrap](product:Mailtrap)** and **[Mailpit](product:Mailpit)** catch emails from the test environment, so you can check confirmation or password reset emails without cluttering real inboxes.
- For Android: **[scrcpy](product:scrcpy)** is a free way to mirror and control a phone from your computer (handy for recording bug videos), and **[Genymotion](product:Genymotion)** provides emulators that simulate GPS, battery and network. **[Diawi](product:Diawi)** shares iOS and Android test builds by link.
- No access to the right browser or device? **[BrowserStack](product:BrowserStack)**, **[TestingBot](product:TestingBot)**, **[Browserling](product:Browserling)** or **[BitBar](product:BitBar)** provide real browsers and phones in the cloud.

## Exploratory testing

For exploratory sessions, the **[Exploratory Testing Extension](product:Exploratory Testing Extension)** lets you log bugs, notes, ideas and questions with screenshots in one click and get a session report at the end. **[TestCase Studio](product:TestCase Studio)** records your browser actions as plain sentences, giving you ready steps for a test case or bug report. To generate "awkward" values (long strings, special characters, boundaries), use [BugMagnet](product:BugMagnet).

## Where to learn and practise

If you are just entering the profession:

- **Theory and certification.** The **[ISTQB](product:ISTQB)** site offers free Foundation Level syllabi and sample exams; the CTFL certificate often appears in job ads. Free courses and references: **[Guru99 Software Testing](product:Guru99 Software Testing)**, **[Software Testing Help](product:Software Testing Help)**, **[ToolsQA](product:ToolsQA)**, **[Katalon Academy](product:Katalon Academy)**.
- **Ukrainian schools.** Paid courses from scratch with practice and job placement support: **[QALight](product:QALight)**, **[Hillel IT School — QA Manual](product:Hillel IT School — QA Manual)**, **[Mate academy — QA](product:Mate academy — QA)**.
- **SQL, regular expressions, Git.** Testers often check data in the database and search through logs. Practise on **[SQLBolt](product:SQLBolt)**, **[SQLZoo](product:SQLZoo)** and the detective game **[SQL Murder Mystery](product:SQL Murder Mystery)**; for regular expressions use **[RegexOne](product:RegexOne)** and **[regex101](product:regex101)**; for Git, **[Learn Git Branching](product:Learn Git Branching)**.
- **Practice sites.** Training shops and apps with deliberate bugs are collected in a separate subcategory, [Practice Sites for Testers](subcategory:qa-practice): The Internet, Sauce Demo, Buggy Cars Rating, Practice Software Testing and more. Hunt for defects, write bug reports in Jam and design test cases in Qase or TestLink. That's how you build a portfolio for your first interview.

## When to move to automation

Automation doesn't replace manual testing, but it takes the routine out of regression. A gentle start for a manual tester: **[Selenium IDE](product:Selenium IDE)** (record and replay in the browser), **[Robot Framework](product:Robot Framework)** and **[Cucumber](product:Cucumber)**, where tests read almost like plain text, and for mobile, **[Maestro](product:Maestro)** with YAML tests. All automation, load and AI testing tools are in the [Testing](subcategory:testing) subcategory.

## FAQ

**Can you work as a manual tester with free tools only?**
Yes. Jam or ShareX for bug reports, PerfectPixel and DevTools for UI, Jira and Confluence on the free plan, Bruno or Hoppscotch for APIs and Fake Filler for forms are enough for most projects.

**What should I learn first: Jira or test management?**
Jira. Almost every team uses it, while test management tools (TestRail, Xray, Qase) are usually introduced on the project.

**Does a manual tester need SQL?**
It helps. Basic SELECT and JOIN queries let you verify that data was actually saved, and they often come up in interviews.

**Not sure where to start?**
Ask [Elya](eli.php): she will pick tools for your project and level.

*Fact-check date: 4 November 2026. Service terms may change, so check them on the official websites.*
