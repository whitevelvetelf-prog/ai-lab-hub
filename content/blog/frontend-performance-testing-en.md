---
title: "Front-end performance testing in 2026: Core Web Vitals, tools and a checklist"
description: "How to test website speed: LCP, INP and CLS, lab vs field data, Lighthouse 13, PageSpeed Insights, WebPageTest, the DevTools Performance panel, bundle size control, CI checks and real-user monitoring (RUM)."
date: "2026-11-04"
updated: "2026-11-04"
---

# Front-end performance testing: what to measure and with what

A website can handle a thousand requests per second and still feel slow to a user. The hero image appears after five seconds, the "Buy" button responds with a noticeable lag, and the text jumps down as soon as a banner loads above it. Load testing won't catch any of this, because the problem isn't on the server but in the browser. That's what front-end performance testing is for.

For businesses this means money and visibility. Slow pages lose customers, and Google uses Core Web Vitals among its page experience signals. For many users it's also everyday reality: mobile data with an unstable signal on a phone that is far from a flagship.

> **In short.** Measure the three Core Web Vitals: LCP (how fast the main content appears), INP (how fast the page responds to interactions) and CLS (layout stability). Look at real-user data, not just the Lighthouse score. Test with CPU and network throttling, and add CI checks so regressions never reach production. We checked tool features and terms against official websites on 4 November 2026.

## Quick pick

| Task | Start with | Alternatives |
|---|---|---|
| Quick page check | [PageSpeed Insights](product:PageSpeed Insights) | [Lighthouse](product:Lighthouse), [GTmetrix](product:GTmetrix), [DebugBear](product:DebugBear) (free test) |
| Find out what exactly is slow | [Chrome DevTools](product:Chrome DevTools) (Performance panel) | [Firefox Profiler](product:Firefox Profiler), [Perfetto](product:Perfetto) |
| Detailed request waterfall and load video | [WebPageTest](product:WebPageTest) | [sitespeed.io](product:sitespeed.io), [GTmetrix](product:GTmetrix) |
| Real-user data with no code | [Chrome UX Report (CrUX)](product:Chrome UX Report) | [Treo](product:Treo), [PageSpeed Insights](product:PageSpeed Insights) |
| Your own RUM | [web-vitals](product:web-vitals) | [DebugBear](product:DebugBear), [RUMvision](product:RUMvision), [Request Metrics](product:Request Metrics), [Sentry](product:Sentry), [SpeedCurve](product:SpeedCurve) |
| CI checks | [Lighthouse CI](product:Lighthouse CI) | [Unlighthouse](product:Unlighthouse), [sitespeed.io](product:sitespeed.io), [Playwright](product:Playwright) |
| JavaScript size | [Size Limit](product:Size Limit) | [webpack-bundle-analyzer](product:webpack-bundle-analyzer), [Statoscope](product:Statoscope), [Bundlephobia](product:Bundlephobia) |
| Re-renders in frameworks | [React Developer Tools](product:React Developer Tools) | [Vue DevTools](product:Vue DevTools) |
| Overall front-end quality | [Yellow Lab Tools](product:Yellow Lab Tools) | [Lighthouse](product:Lighthouse) |
| Images | [Squoosh](product:Squoosh) | — |
| Ongoing monitoring for a team | [DebugBear](product:DebugBear) | [SpeedCurve](product:SpeedCurve), [Calibre](product:Calibre), [Treo](product:Treo), [Datadog](product:Datadog), [New Relic](product:New Relic) |

## Metrics: what to measure

### Core Web Vitals

Google highlights three key metrics. A page counts as "good" when 75% of visits meet the threshold, separately on mobile and desktop.

| Metric | What it means | Good | Poor |
|---|---|---|---|
| **LCP** (Largest Contentful Paint) | When the largest visible element appeared: hero image, heading, text block | up to 2.5 s | over 4 s |
| **INP** (Interaction to Next Paint) | How quickly the page visually responds to clicks, taps and key presses during the whole visit | up to 200 ms | over 500 ms |
| **CLS** (Cumulative Layout Shift) | How much content shifts unexpectedly while viewing | up to 0.1 | over 0.25 |

INP replaced the old FID metric on 12 March 2024. FID only measured the input delay of the first interaction, while INP covers all interactions and the full time until the next frame. Many sites that "passed" on FID turned out to be slow on INP.

Supporting metrics help with diagnosis: **TTFB** (time to first byte, good up to 0.8 s), **FCP** (first contentful paint, good up to 1.8 s) and **TBT** (total main-thread blocking time in a lab test).

### Lab vs field data

This is the most important distinction in performance testing.

- **Lab data** (synthetic) comes from running a page under controlled conditions: Lighthouse, WebPageTest, DevTools. It's reproducible, so it's great for finding causes and comparing before and after. But it's one page, one device and one network with no real interactions. That's why lab tools can't measure INP and use TBT instead.
- **Field data** (RUM) is collected from real visitors: the [Chrome UX Report (CrUX)](product:Chrome UX Report) or your own script such as [web-vitals](product:web-vitals). Google assesses Core Web Vitals on this data, and it shows how the site performs on old phones, on the subway and outside big cities.

A typical situation: Lighthouse on a developer's laptop shows 98, while field LCP on mobile is 4 seconds. Trust the field data and use the lab to find and fix the cause.

## What changed in 2025–2026

- **Lighthouse 13** (October 2025) removed the old performance audits and switched to "insights", the same ones the Chrome DevTools Performance panel shows. Some familiar audit IDs are gone, so if your CI parses the Lighthouse JSON report, check it after upgrading. Lighthouse 13 requires Node.js 22.19 or newer.
- **LCP and INP are no longer Chrome-only.** As part of Interop 2025, Firefox added INP in version 144 (October 2025) and Safari 26.2 (December 2025) added LCP and INP. You can now collect these metrics in your RUM for iPhone users too. CLS still works only in Chromium-based browsers, and CrUX still contains Chrome data only.
- **CrUX Vis replaced the CrUX Dashboard.** Google retired the old Looker Studio dashboard at the end of 2025. Use CrUX Vis or the CrUX History API for a site's Core Web Vitals history.
- **DevTools shows live metrics.** The Performance panel shows local LCP, CLS and INP as you interact with the page and compares them with CrUX field data. CPU throttling can be calibrated to match a low-end phone.
- **Long Animation Frames (LoAF).** This Chrome API shows which scripts made a frame long. It's much more precise than the old Long Tasks API and powers INP attribution in RUM services.
- **Soft navigations.** For single-page apps, Chrome is trialling an API that measures metrics on navigations without a full page load. It's still experimental, but worth watching if you use React, Vue or Angular.

## Step-by-step page check

Here's where to start when you're asked to "check the speed".

1. **Look at field data.** Open the page in [PageSpeed Insights](product:PageSpeed Insights). With enough traffic, the top shows real LCP, INP and CLS for 28 days. For the whole domain and its history use [Treo](product:Treo) or CrUX Vis. Now you know which metric is really a problem and on which devices.
2. **Reproduce in the lab.** In [Chrome DevTools](product:Chrome DevTools) enable device mode, network throttling (for example "Slow 4G") and CPU throttling (4–6× or a calibrated preset). Test in an incognito window without extensions.
3. **Record a Performance profile.** Reload the page while recording, and for INP click real buttons, open menus and type into fields. The Insights sidebar tells you the LCP element, which scripts block the main thread and where shifts come from.
4. **Check the waterfall.** In [WebPageTest](product:WebPageTest) run a test from the right location with a mobile profile. The waterfall and filmstrip show when the LCP resource started loading, which requests block rendering and how much third-party scripts weigh.
5. **Check repeat visits.** How does the page behave with a warm cache? Is it restored instantly from the back/forward cache (bfcache)? DevTools has a dedicated test in the Application tab.
6. **Record the result.** At least three runs, the median, test conditions and screenshots, so you can compare after fixes.

## What to check for each metric

### LCP: main content appears late

LCP breaks down into four parts: TTFB, resource load delay, resource load time and render delay. DevTools and [DebugBear](product:DebugBear) show this breakdown. Common causes:

- a slow server response (high TTFB): caching, CDN, heavy database queries;
- the hero image is discovered late: it's a CSS background, inserted by JavaScript or has `loading="lazy"`; lazy loading hurts the LCP image;
- no priority hints: `fetchpriority="high"` on the hero image or `<link rel="preload">` for critical resources;
- images that are too large or in old formats; check in [Squoosh](product:Squoosh) how much lighter AVIF or WebP would be, and add `srcset` for different screens;
- render-blocking CSS and JavaScript in `<head>`, web fonts without `font-display`;
- client-only rendering: the page stays empty until all JavaScript has loaded and run.

### INP: the page responds slowly

INP is the most common problem in 2026, especially on JavaScript-heavy sites. The delay has three parts: waiting for the main thread to become free, running the handler and rendering the next frame. What to check:

- long tasks (over 50 ms) in the profile: analytics, chat widgets, A/B tests, ad scripts, framework hydration;
- heavy event handlers, such as sorting a large list or recalculating the whole state on every keystroke;
- unnecessary re-renders in React or Vue, visible in [React Developer Tools](product:React Developer Tools) and [Vue DevTools](product:Vue DevTools) with render highlighting;
- a large DOM: thousands of nodes make every style and layout update expensive;
- no visual feedback: even if an operation is long, the UI should show an indicator immediately.

Test INP on real scenarios: open the menu, add an item to the cart, type in search, toggle a filter. The worst values usually come from low-end Android phones, so a test on a real budget smartphone tells you more than any emulation.

### CLS: content jumps

- images, videos and iframes without `width` and `height` or `aspect-ratio`;
- banners, cookie consent, ads or embeds injected above existing content;
- web fonts that change text size after loading;
- animations using `top` and `height` instead of `transform`.

Be sure to scroll to the end and click around: CLS counts during the whole visit, not just during load.

## JavaScript bundles: weight matters

Every kilobyte of JavaScript has to be downloaded, parsed and executed, and on a low-end phone that takes many times longer than on a developer's laptop. That's why bundle size control is part of performance testing.

- [Bundlephobia](product:Bundlephobia): before adding a library, see how much it weighs, whether it supports tree shaking and whether lighter alternatives exist.
- [webpack-bundle-analyzer](product:webpack-bundle-analyzer) and [Statoscope](product:Statoscope): a map of what ended up in the bundle. Typical finds are two versions of the same library, a whole date library instead of one function, or admin code in the public bundle.
- [Size Limit](product:Size Limit): a size budget that fails CI when a pull request makes the bundle heavier than the limit.
- The Coverage panel in [Chrome DevTools](product:Chrome DevTools) shows how much loaded JS and CSS never ran on the page: candidates for code splitting and lazy loading.
- [Yellow Lab Tools](product:Yellow Lab Tools) rates the front end overall: DOM complexity, duplicated CSS, problematic JavaScript patterns.

Check **third-party scripts** separately: analytics, support chats, ad pixels, review widgets. They often weigh more than the site's own code. Block them in DevTools (Network → Block request URL) and compare the metrics to see their real cost.

## Performance in automated tests and CI

Manual checks find problems; CI keeps them from coming back.

- **[Lighthouse CI](product:Lighthouse CI)** runs Lighthouse several times per build and checks assertions like "LCP no worse than 2.5 s", "TBT under 200 ms", "JavaScript under 300 KB". Because results vary, leave headroom in thresholds and use the median of several runs.
- **[Unlighthouse](product:Unlighthouse)** runs Lighthouse across every page of a site, handy before a big release or migration.
- **[sitespeed.io](product:sitespeed.io)** is an open-source suite for scheduled synthetic tests with dashboards in [Grafana](product:Grafana).
- **[Playwright](product:Playwright)** and **[Puppeteer](product:Puppeteer)** can capture a performance trace or Web Vitals right inside an end-to-end test of a key flow such as checkout.
- **[Size Limit](product:Size Limit)** keeps JavaScript weight in check on every pull request.

Keep noise in mind: on shared CI machines results can vary by 10–20%. Stable budgets on size and request count plus soft timing thresholds work better than a test that goes red every day for no reason.

## Real-user monitoring (RUM)

The lab won't tell you that Android users in one region see a 5-second LCP while iPhone users in the capital are fine. For that you need RUM: metrics collected from real visitors' browsers.

- **Free start:** the [web-vitals](product:web-vitals) library with the attribution build sends LCP, INP and CLS along with their causes to your analytics or backend.
- **Ready-made services:** [DebugBear](product:DebugBear), [RUMvision](product:RUMvision), [Request Metrics](product:Request Metrics) and [SpeedCurve](product:SpeedCurve) break data down by page, device and country and attribute INP to specific scripts.
- **If you already have APM:** [Sentry](product:Sentry), [Datadog](product:Datadog) and [New Relic](product:New Relic) have front-end monitoring modules, so you see front end and back end in one place.
- **Cloud hosting:** [Vercel](product:Vercel) has a built-in Speed Insights module for sites hosted on it.

For a tester, RUM is a source of priorities: you see which pages and flows are slowest in reality and test those first.

## How to report performance issues

A bug report saying "the site is slow" gives a developer nothing. A good report includes:

- **page and scenario:** URL and actions (for example, "tap Filters on mobile");
- **metric and value:** "INP 640 ms when opening filters", "LCP 4.2 s on the mobile profile";
- **conditions:** device or emulation, CPU and network throttling, browser and version, cold or warm cache;
- **number of runs** and the median, to tell a real problem from noise;
- **evidence:** a DevTools profile file (you can save and attach it), a WebPageTest link, a waterfall screenshot;
- **the cause, if visible:** "the LCP image has loading="lazy"", "a 380 ms long task in the chat script";
- **field data**, if available: "CrUX p75 INP on mobile is 450 ms".

## A one-month learning plan

| Week | What to do |
|---|---|
| 1 | Learn Core Web Vitals and the difference between lab and field data. Check 5 different sites in [PageSpeed Insights](product:PageSpeed Insights) and explain to yourself why the scores differ. |
| 2 | Master the Performance panel in [Chrome DevTools](product:Chrome DevTools): recording, throttling, finding the LCP element and long tasks. Run the same pages in [WebPageTest](product:WebPageTest) and learn to read the waterfall. |
| 3 | Inspect a practice project's bundle in [webpack-bundle-analyzer](product:webpack-bundle-analyzer) or [Statoscope](product:Statoscope), and set up [Lighthouse CI](product:Lighthouse CI) and [Size Limit](product:Size Limit) in GitHub Actions. |
| 4 | Add [web-vitals](product:web-vitals) to a test site and send metrics to the console or analytics. Write 3 performance bug reports using the template above. |

Any personal site or practice project will do. It also helps to take real sites from an industry you know and compare them in CrUX.

## AI in performance testing

AI assistants are good at explaining profiles and waterfalls if you give them context: describe or paste part of a trace, a Lighthouse JSON report or a list of long tasks, and ask for the most likely causes. Chrome DevTools has built-in AI assistance that answers questions about a recorded performance profile.

But verify the advice: AI may suggest generic "optimisations" that do nothing for your page, or miss that the LCP image is inserted by a script. Confirm every hypothesis with a before-and-after measurement. You'll find AI tools for developers in the [Web Development](subcategory:web-development) subcategory.

For other kinds of testing, see [Load testing](blog-post.php?slug=load-testing&hl=en), [Mobile app testing](blog-post.php?slug=mobile-app-testing&hl=en), [Accessibility testing](blog-post.php?slug=accessibility-testing&hl=en) and [Manual testing tools](blog-post.php?slug=manual-testing-tools&hl=en). All tools from this article are in the [Testing](subcategory:testing) and [Web Development](subcategory:web-development) subcategories.

## FAQ

**How is front-end performance testing different from load testing?**
Load testing checks how many users the server can handle. Front-end testing checks how fast a page works for one user in their browser. A site can pass one and fail the other, so you need both.

**Should I aim for 100 in Lighthouse?**
No. The Lighthouse score is a lab guideline. What matters more is that field Core Web Vitals are green for 75% of users.

**Why does PageSpeed Insights give different results each run?**
Lab tests naturally vary because of the network, server and third-party scripts. Do several runs and look at the median, and base decisions on field data.

**Why is there no field data for my page?**
CrUX only shows pages and sites with enough Chrome traffic. For new or niche sites, collect your own RUM with [web-vitals](product:web-vitals).

**How do I measure INP if Lighthouse doesn't have it?**
In the lab, record interactions in the DevTools Performance panel (it shows INP live) and use TBT as a proxy. Only field data gives you real INP.

**Not sure where to start?**
Ask [Elya](eli.php): she'll pick speed testing tools for your project and level.

*Facts checked on 4 November 2026. Service terms and browser capabilities may change, so check official websites.*
