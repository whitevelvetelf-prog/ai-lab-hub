---
title: "Accessibility testing in 2026: WCAG 2.2, a checklist and tools for testers"
description: "A guide to accessibility (a11y) testing of websites and apps: WCAG 2.2 and the EAA, manual checks, keyboard and screen readers, contrast, automated checks with axe, Lighthouse and Pa11y in CI, mobile accessibility and a learning plan."
date: "2026-11-04"
updated: "2026-11-04"
---

# Accessibility testing: what to check and with what

Accessibility (a11y for short) means everyone can use a website or app. That includes blind people with a screen reader, people with low vision who enlarge text and people with colour-vision deficiencies. It includes those who control the computer only with a keyboard or their voice, and people with dyslexia or hearing loss. It also includes anyone holding a phone in one hand in bright sunlight.

Accessibility testing checks that none of them is left out: can you reach a button without a mouse, will a screen reader announce a form field, can you read grey text on a white background? For businesses it is also a legal requirement. Since 28 June 2025 the European Accessibility Act (EAA) has applied in the EU, including to non-EU companies that sell covered services to EU consumers.

> **In short.** Automated tools find only part of accessibility issues: estimates range from a third to a half. The rest can be found only by hand, with a keyboard, a screen reader and a careful eye. That is why this guide covers both the tools and a manual checklist. We checked the tools' features and terms against their official websites on 4 November 2026.

## Quick pick

| Task | Start with | Alternatives |
|---|---|---|
| Quick in-browser page check | [axe DevTools](product:axe DevTools) | WebAIM's WAVE, [Accessibility Insights](product:Accessibility Insights), [Lighthouse](product:Lighthouse), [ARC Toolkit](product:ARC Toolkit), [IBM Equal Access Accessibility Checker](product:IBM Equal Access Accessibility Checker) |
| Guided manual checks | [Accessibility Insights](product:Accessibility Insights) | [ANDI](product:ANDI), [Sa11y](product:Sa11y) |
| Screen reader | [NVDA](product:NVDA) (Windows) | [VoiceOver](product:VoiceOver), [TalkBack](product:TalkBack), [JAWS](product:JAWS), [Windows Narrator](product:Windows Narrator), [Orca](product:Orca) |
| Colour contrast | [Colour Contrast Analyser](product:Colour Contrast Analyser) | [WebAIM Contrast Checker](product:WebAIM Contrast Checker), [Who Can Use](product:Who Can Use), [Stark](product:Stark) |
| Colour-blindness simulation | [Color Oracle](product:Color Oracle) | [Sim Daltonism](product:Sim Daltonism), [Polypane](product:Polypane), [Chrome DevTools](product:Chrome DevTools) |
| Automated tests and CI | [axe-core](product:axe-core) | [Pa11y](product:Pa11y), [Lighthouse](product:Lighthouse), [IBM Equal Access Accessibility Checker](product:IBM Equal Access Accessibility Checker) |
| Checks while coding | [eslint-plugin-jsx-a11y](product:eslint-plugin-jsx-a11y) | [Storybook](product:Storybook) |
| Mobile apps | [Accessibility Scanner](product:Accessibility Scanner) (Android) | [Accessibility Inspector](product:Accessibility Inspector) (iOS), [TalkBack](product:TalkBack), [VoiceOver](product:VoiceOver) |
| PDF documents | [PAC PDF Accessibility Checker](product:PAC PDF Accessibility Checker) | — |
| Site-wide monitoring for business | [Siteimprove Accessibility](product:Siteimprove Accessibility) | [Silktide](product:Silktide), [Pope Tech](product:Pope Tech), [Level Access](product:Level Access), [Evinced](product:Evinced) |

## Standards: WCAG 2.2, the EAA and what to do about them

**WCAG** (Web Content Accessibility Guidelines) are the W3C's international guidelines that almost every digital accessibility law refers to. The current version is **WCAG 2.2** (October 2023), also approved as the ISO/IEC 40500:2025 standard. Its requirements follow four principles, known as POUR:

- **Perceivable.** Information can be perceived: images have text alternatives, videos have captions, contrast is sufficient.
- **Operable.** Everything works with a keyboard, there is enough time, nothing flashes dangerously.
- **Understandable.** Text is clear, the interface is predictable, form errors are explained.
- **Robust.** Markup is valid and assistive technologies such as screen readers interpret it correctly.

Each requirement has a level: A, AA or AAA. Laws and contracts usually require **level AA**, so that is the target to test against.

**What's new in WCAG 2.2:**
- the visible focus must not be completely hidden under sticky headers or banners;
- clickable targets must be at least 24×24 CSS pixels or have enough spacing from their neighbours;
- dragging movements need a simple-click alternative;
- help must stay in a consistent place across pages;
- users must not be forced to re-enter information they have already provided;
- logging in must not rely only on memory or puzzles, so, for example, you cannot block pasting a password.

The obsolete criterion 4.1.1 Parsing was removed in 2.2.

**WCAG 3.0** is still only a W3C working draft and does not replace 2.2. Keep an eye on it, but test against 2.2.

**The European Accessibility Act (EAA)** has required accessibility since 28 June 2025 from online shops, banking services, e-books, passenger transport tickets and services, telecoms and more. In practice that means conforming to the harmonised standard **EN 301 549**, which relies on WCAG AA for the web. Microenterprises providing services are exempt.

## Manual testing checklist

Any tester can cover this minimum in 15–30 minutes per page.

**Keyboard**
- Tab through the page from top to bottom. Can you reach every link, button and field? Is the order logical?
- Is the focus always visible? Is it ever hidden under a header (WCAG 2.2)?
- Do menus, tabs and dialogs open with Enter and Space and close with Esc? Does focus return to its place after a dialog closes?
- Are there any keyboard traps that focus cannot leave?
- Is there a "Skip to main content" link at the top?

**Structure and semantics**
- Is there one H1, with the other headings following the hierarchy without skipping levels? [ANDI](product:ANDI) or [Accessibility Insights](product:Accessibility Insights) help here.
- Do images have meaningful alt text, and decorative ones an empty alt?
- Do link names make sense out of context ("Read more" ×10 is bad)?
- Is the page language set (`lang="en"`)?

**Forms**
- Does every field have a visible label associated with it in code, not just a placeholder?
- Are errors explained in text, not only in red? Does a screen reader announce them?
- Can you paste a password or an SMS code?

**Colour and contrast**
- Normal text needs at least 4.5:1 contrast, large text 3:1, and field borders, icons and focus indicators 3:1. Check with the eyedropper in [Colour Contrast Analyser](product:Colour Contrast Analyser).
- Is any information conveyed by colour alone, such as "required fields are marked in red"? View the page through [Color Oracle](product:Color Oracle).

**Zoom and reflow**
- Zoom the browser to 200% and 400% (320px width). Is any text cut off? Does horizontal scrolling appear?
- Does the layout break when line height and spacing are increased?

**Media and motion**
- Do videos have captions and audio a transcript?
- Does sound start automatically? Can carousels and animations be paused? Is the "reduce motion" setting respected?

**Dynamic content**
- Are messages that appear without a page reload announced, such as "Added to cart", errors and notifications?

## Screen readers: how to test

Testing with a screen reader is the most valuable check, and the most unfamiliar for beginners. Start with one reader on your platform:

- **Windows:** [NVDA](product:NVDA). It is free, open source and widely used by blind people. The paid [JAWS](product:JAWS) is still popular in corporate settings. The built-in [Windows Narrator](product:Windows Narrator) works for a quick check.
- **macOS, iPhone, iPad:** [VoiceOver](product:VoiceOver), built in and switched on in the accessibility settings.
- **Android:** [TalkBack](product:TalkBack), built in.
- **Linux:** [Orca](product:Orca).

What to check:
- Can you move through the page by headings (the H key in NVDA) and landmarks?
- Are buttons and fields announced clearly? "Button, button, button" with no names is the classic defect of unlabelled icons.
- Are states announced: expanded/collapsed, selected, disabled?
- Can you complete the main flow, such as sign-up or checkout, without looking at the screen?

Tip: use the reader on a site you know is accessible about five times first, to learn how to drive it. Then, when you test your own product, you can tell a product defect from your own clumsiness.

The best test involves people with disabilities themselves. [Fable](product:Fable) runs usability testing with assistive-technology users.

## Automated in-browser checks

Extensions find technical violations in seconds. Run them on every new page:

- [axe DevTools](product:axe DevTools) from Deque: a free extension built on the [axe-core](product:axe-core) engine, known for few false positives. The paid version adds guided tests and reports.
- WebAIM's WAVE shows error icons right on top of the page. It is visual and handy for designers and managers.
- [Accessibility Insights](product:Accessibility Insights) from Microsoft combines the quick FastPass with a guided WCAG 2.1 AA assessment that includes manual tests.
- [Lighthouse](product:Lighthouse), built into [Chrome DevTools](product:Chrome DevTools), gives an accessibility score based on axe-core. It is a useful indicator, but a score of 100 does not mean a site is accessible.
- [ARC Toolkit](product:ARC Toolkit) from TPGi and the [IBM Equal Access Accessibility Checker](product:IBM Equal Access Accessibility Checker) are strong free alternatives. ARC also visualises tab order.
- [Sa11y](product:Sa11y) is made for content editors: it highlights empty headings, missing alt text and poor links right inside the CMS.
- [Polypane](product:Polypane) is a developer browser that can simulate vision impairments and shows the accessibility tree.

Check not only the initial page state but also open menus, dialogs and form error states.

## Accessibility in automated tests and CI

To keep accessibility from breaking with every release, add automated checks to your tests:

- **[axe-core](product:axe-core)** underpins most integrations: `@axe-core/playwright` for [Playwright](product:Playwright), `cypress-axe` for [Cypress](product:Cypress), `@axe-core/webdriverjs` for [Selenium](product:Selenium) and `jest-axe` for [Jest](product:Jest). One line in an existing e2e test is enough to check a page.
- **[Pa11y](product:Pa11y)**: Pa11y CI iterates over a list of URLs and fails if it finds errors. Pa11y Dashboard shows the trend.
- **[Lighthouse](product:Lighthouse)** CI lets you set a minimum accessibility score for every pull request.
- **[IBM Equal Access Accessibility Checker](product:IBM Equal Access Accessibility Checker)** has Node and Cypress packages.
- **[eslint-plugin-jsx-a11y](product:eslint-plugin-jsx-a11y)** catches errors in React code before it runs: img without alt, a div with onClick but no role, invalid ARIA.
- **[Storybook](product:Storybook)** with its accessibility addon checks every design-system component in isolation.

Run all of this in [GitHub Actions](product:GitHub Actions) or another CI. Start in "warn only" mode, and once existing errors are fixed, switch to "fail on new ones".

For setting up automated tests, see [Test automation tools](blog-post.php?slug=test-automation-tools&hl=en).

## Mobile apps

Mobile apps follow the same principles but use their own tools:

- **Android.** [Accessibility Scanner](product:Accessibility Scanner) scans a screen and flags small touch targets, missing labels and weak contrast. [Android Studio](product:Android Studio) has accessibility checks in the layout editor and lint. [Espresso](product:Espresso) can enable accessibility checks directly in UI tests.
- **iOS.** [Accessibility Inspector](product:Accessibility Inspector) in [Xcode](product:Xcode) shows element labels and roles and runs an audit. XCUITest offers an automated accessibility audit for UI tests.
- **By hand.** Use [TalkBack](product:TalkBack) and [VoiceOver](product:VoiceOver), larger system text (Dynamic Type on iOS), dark mode, and switch or voice control such as [Voice Access](product:Voice Access).

Touch targets should be at least 48×48 dp on Android and 44×44 pt on iOS (Google and Apple guidelines). For more on mobile testing, see [Mobile app testing](blog-post.php?slug=mobile-app-testing&hl=en).

## Documents, design and content

- **PDF.** [PAC PDF Accessibility Checker](product:PAC PDF Accessibility Checker) checks PDFs against PDF/UA and WCAG for free and shows what a screen reader will read. Microsoft Office has a built-in Accessibility Checker.
- **Design.** The [Stark](product:Stark) plugin for [Figma](product:Figma) checks contrast and simulates colour blindness in the mock-up, where fixing a defect is cheapest.
- **Text.** Plain, clear writing is accessibility too, especially for people with cognitive disabilities and dyslexia. [Hemingway Editor](product:Hemingway Editor) helps.

## Overlay widgets: why they don't replace testing

"Overlay" services promise to make a site accessible with one line of code: they add a button with font and contrast settings and "automatically fix" errors. The problem is that they don't change the site's own code. Many blind users and accessibility experts complain that such widgets get in the way of screen readers. In 2025 the US Federal Trade Commission required accessiBe to pay $1 million over misleading claims that its widget could make any website WCAG-compliant.

The takeaway for testers: if a site has an overlay, test it as you would without one. Defects get fixed in the code. Such services are listed in the [Digital Accessibility for Business](subcategory:digital-accessibility) subcategory, alongside audit and monitoring platforms.

## How to report accessibility defects

A good accessibility bug report includes:
- **the WCAG criterion**, for example "1.4.3 Contrast (Minimum), AA";
- **who is affected**: "NVDA users won't know the button opens a menu";
- **steps to reproduce**, including the tool (browser, screen reader, version);
- **the expected result**, ideally with a hint on how to fix it: "add aria-expanded" or "raise contrast to 4.5:1".

Set priority by impact. If checkout is impossible without a mouse, that's a blocker. A redundant alt on a decorative image is minor.

## One-month learning plan

1. **Week 1.** Read the short WCAG overview on the W3C WAI site. Install [axe DevTools](product:axe DevTools) and WAVE and check 5 of your favourite sites.
2. **Week 2.** Keyboard and contrast: run the checklist above on your project. Learn [Colour Contrast Analyser](product:Colour Contrast Analyser).
3. **Week 3.** Screen reader: 20 minutes a day with [NVDA](product:NVDA) or [VoiceOver](product:VoiceOver), first on accessible sites, then on your own.
4. **Week 4.** Automation: add [axe-core](product:axe-core) to existing e2e tests or [Pa11y](product:Pa11y) CI to your pipeline. Write up the defects you found using the template above.

After that, if accessibility becomes your specialism, you can prepare for the IAAP certifications (CPACC, WAS).

## AI in accessibility testing

AI already helps in several places:
- it drafts alternative text for images;
- it explains errors found by scanners and suggests code fixes;
- in PAC 2026 and some enterprise platforms it automates part of the manual checks.

Assistants such as [ChatGPT](product:ChatGPT), [Claude](product:Claude) or [GitHub Copilot](product:GitHub Copilot) help you quickly understand a WCAG criterion or ARIA attributes. But AI doesn't know what an image needs to convey in your context, and it can't feel how awkward a form is with a screen reader. The final call is a person's, and ideally that of people with disabilities.

For people with disabilities themselves, AI tools such as [Be My Eyes](product:Be My Eyes) are already changing daily life. They are collected in the Accessibility category, for example in the [Blind & Low Vision](subcategory:blind-low-vision) subcategory.

For other kinds of testing, read [Manual testing tools](blog-post.php?slug=manual-testing-tools&hl=en), [API testing](blog-post.php?slug=api-testing&hl=en) and [Security testing](blog-post.php?slug=security-testing&hl=en). All the tools in this article are in the [Testing](subcategory:testing) and [Digital Accessibility for Business](subcategory:digital-accessibility) subcategories.

## FAQ

**Are automated checks enough?**
No. Scanners find technical errors such as contrast, missing alt text and empty buttons. They can't judge whether the alt text is meaningful, the focus order logical or an error message clear. You need manual checks too.

**Which screen reader should I start with?**
[NVDA](product:NVDA) on Windows or [VoiceOver](product:VoiceOver) on a Mac or iPhone. Both are free and widely used by real users.

**Which WCAG level should I test against?**
AA. It is what the EAA, EN 301 549 and most contracts require. Level AAA is usually not achievable for an entire site.

**Does the EAA apply to companies outside the EU?**
Yes, if they offer covered products or services to consumers in the EU, such as an online shop that delivers to the EU. Ask a lawyer for legal advice.

**Can a widget make a site accessible?**
No. A widget doesn't fix the site's code. Test and fix the product itself.

**Not sure where to start?**
Ask [Elya](eli.php): she will pick accessibility testing tools for your project and level.

*Facts checked on 4 November 2026. Service terms and legal requirements can change, so check them on the official websites.*
