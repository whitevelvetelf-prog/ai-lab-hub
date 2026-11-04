---
title: "Load testing in 2026: types, metrics, tools and your first test"
description: "A guide to load testing: types of performance tests, key metrics and percentiles, planning a test, k6, JMeter, Gatling, Locust, cloud platforms, monitoring during the test, common mistakes and a learning plan."
date: "2026-11-04"
updated: "2026-11-04"
---

# Load testing: types, metrics and tools

A site that works perfectly for one tester can fall over on the first day of a sale, after a newsletter or a mention in the news. Load testing answers questions functional tests never ask: how many users can the system handle, how fast does it respond under load, where is the bottleneck and what happens when resources run out?

This article explains the types of performance tests, the metrics worth watching, how to plan your first test, which tools to choose and how to avoid getting pretty but meaningless numbers.

> **Important.** We checked features and terms on the official websites on 4 November 2026. Paid plans change, so check them on the service's site before paying.

## Quick pick

| Task | Start with | Alternatives |
|---|---|---|
| Scenarios as code, CI | [Grafana k6](product:Grafana k6) | [Gatling](product:Gatling), [Locust](product:Locust), [Artillery](product:Artillery) |
| Graphical editor, many protocols | [Apache JMeter](product:Apache JMeter) | [Taurus](product:Taurus) (YAML on top of JMeter) |
| .NET team | [NBomber](product:NBomber) | [Grafana k6](product:Grafana k6) |
| Quick benchmark of one endpoint | [oha](product:oha) | [wrk](product:wrk), [Vegeta](product:Vegeta) |
| Cloud runs without your own infrastructure | [BlazeMeter](product:BlazeMeter) | [Azure Load Testing](product:Azure Load Testing), [Loader.io](product:Loader.io) |
| Enterprise systems | [NeoLoad](product:NeoLoad) | [BlazeMeter](product:BlazeMeter) |
| Monitoring during the test | [Grafana](product:Grafana) + [Prometheus](product:Prometheus.io) | [Datadog](product:Datadog), [New Relic](product:New Relic), [Sentry](product:Sentry) |
| Page speed in the browser | [Lighthouse](product:Lighthouse) | [sitespeed.io](product:sitespeed.io), [GTmetrix](product:GTmetrix) |

## Types of performance tests

"Load testing" is often used for all performance testing, but it is really several different tests with different goals:

- **Smoke test**: 1–5 virtual users for a minute. Checks that the script works at all before you run anything big.
- **Load test**: the expected normal or peak number of users. Answers "can the system handle our real traffic and do we meet the requirements?"
- **Stress test**: load grows gradually beyond normal until the system starts to degrade. Shows the limit and *how* the system breaks: does it slow down gradually or suddenly fail with errors?
- **Spike test**: a sharp jump in users within seconds, like after a push notification or the start of ticket sales.
- **Soak (endurance) test**: moderate load for hours. Reveals memory leaks, full disks and exhausted connections you won't see in 10 minutes.
- **Scalability test**: how throughput changes as you add servers or resources.
- **Capacity test**: how many users the system can serve while keeping acceptable speed.

## Key metrics

- **Response time (latency).** Look at **percentiles**, not the average: p95 = 800 ms means 95% of requests finished faster than 800 ms and 5% took longer. The average hides the tail of slow requests that real users complain about.
- **Throughput**: requests or transactions per second (RPS, TPS).
- **Error rate**: the share of 5xx responses, timeouts and failed checks.
- **Concurrent users (virtual users, VUs)**: how many scenarios run in parallel.
- **System resources**: CPU, memory, disk, network, database connections, queue length. Without them, the load generator's numbers don't explain *why* the system slowed down.
- **User-facing metrics**: for web pages these are Core Web Vitals (LCP, INP, CLS), measured by [Lighthouse](product:Lighthouse).

Write requirements as concrete criteria (SLOs): "p95 for checkout < 1 s, errors < 1% at 500 concurrent users". Tools such as [Grafana k6](product:Grafana k6) and [Taurus](product:Taurus) check such thresholds automatically and fail the CI run if they are exceeded.

## How to plan a load test

1. **Set a goal.** "Check that the catalogue handles 3× Black Friday traffic" is a goal; "see how many RPS we get" is not.
2. **Build a load profile.** Which scenarios users perform and in what proportion (for example 70% browse the catalogue, 20% search, 10% buy) and how many there are at peak. Sources: analytics, web server logs, monitoring.
3. **Make scenarios realistic.** Pauses between actions (think time), varied test data instead of the same product every time, authentication and caching as with real users.
4. **Prepare the environment.** It should be as close to production as possible in resources, configuration and database size. A test on an empty database will show unrealistically good numbers.
5. **Set up monitoring** of servers, the database and dependencies before the run.
6. **Start with a smoke test**, then increase the load step by step.
7. **Analyse and repeat.** Find the bottleneck, fix it, run the same test again and compare.

> Only load test systems you own or have written permission to test. A load test against someone else's site is no different from a DDoS attack. That is why cloud services such as [Loader.io](product:Loader.io) ask you to verify domain ownership.

## Open-source tools

- **[Grafana k6](product:Grafana k6)**: JavaScript scenarios, built-in checks and thresholds, easy CI runs and a cloud option in Grafana Cloud k6. The default choice for new projects.
- **[Apache JMeter](product:Apache JMeter)**: a graphical test plan editor, proxy-based recording, the widest protocol support (HTTP, JDBC, JMS, FTP and more) and thousands of articles. Still the tool most often listed in performance tester job ads.
- **[Gatling](product:Gatling)**: scenarios as code in Java, Kotlin, Scala or JavaScript with detailed HTML reports; generates heavy load efficiently.
- **[Locust](product:Locust)**: user behaviour is plain Python code, and a web UI shows results in real time.
- **[Artillery](product:Artillery)**: YAML or JavaScript scenarios, HTTP, WebSocket and load with real browsers via Playwright.
- **[Taurus](product:Taurus)**: a short YAML config on top of JMeter, Gatling or Locust with pass/fail criteria for CI.
- **[NBomber](product:NBomber)**: for .NET teams, with scenarios in C# or F#. Free for personal use; commercial use needs a licence.

**For quick benchmarks** without scenarios, use command-line tools: **[oha](product:oha)** with live charts in the terminal, **[wrk](product:wrk)** for maximum load from a single machine and **[Vegeta](product:Vegeta)** for a constant request rate.

## Cloud and enterprise platforms

When one computer can't generate enough load, or you need load from different regions:

- **[BlazeMeter](product:BlazeMeter)** runs JMeter, Gatling, Locust and k6 scripts in the cloud; the free plan allows up to 50 virtual users and 10 tests a month.
- **[Azure Load Testing](product:Azure Load Testing)** runs JMeter and Locust scripts in Microsoft's cloud and shows Azure resource metrics alongside.
- **[NeoLoad](product:NeoLoad)** from Tricentis targets large companies: web, mobile apps, APIs, SAP and AI result analysis.
- **[Loader.io](product:Loader.io)** is the simplest start: set up a test in the browser, free for up to 10,000 clients in a one-minute test.

## Monitoring during the test

The load generator shows *that* the system slowed down; monitoring shows *why*. Always watch servers, the database and dependencies during a run:

- **[Prometheus](product:Prometheus.io)** collects metrics from applications and servers, and **[Grafana](product:Grafana)** shows k6 or JMeter results and system health on one dashboard. This is the most common open-source stack.
- **[Datadog](product:Datadog)** and **[New Relic](product:New Relic)** are commercial platforms with request tracing (APM): you can see which service or SQL query takes the time. New Relic has a free tier with 100 GB of data a month.
- **[Sentry](product:Sentry)** shows errors and slow transactions that appear under load.

Typical bottlenecks: slow SQL queries without indexes, an exhausted database connection pool, locks, no caching, synchronous calls to external services, container memory limits.

## Front-end performance

Load tests check the server, but users also feel how fast the page is in the browser:

- **[Lighthouse](product:Lighthouse)**: a performance and Core Web Vitals audit right in Chrome DevTools;
- **[GTmetrix](product:GTmetrix)**: a report with a request waterfall showing what slows loading down;
- **[sitespeed.io](product:sitespeed.io)**: regular measurements in real browsers with page load video and monitoring in Grafana.

To find and fix exactly these problems (Core Web Vitals, bundles, real-user monitoring), see [Front-end performance testing](blog-post.php?slug=frontend-performance-testing&hl=en).

A good practice is to combine both: load the back end with [Grafana k6](product:Grafana k6) or [Artillery](product:Artillery) and at the same time measure how the page opens for a single user under that load.

## Common mistakes

- **Looking at average response time** instead of p95/p99.
- **The load generator is the bottleneck.** If your laptop's CPU is at 100%, you are measuring the laptop, not the server.
- **Unrealistic data:** all virtual users log in with one account and open the same product, so everything comes from cache.
- **No think time**: 100 "users" without pauses create load like thousands of real ones.
- **Testing on an unrepresentative environment** or with an empty database.
- **No server monitoring**, so you have to guess the cause of the slowdown.
- **Ignoring errors:** fast 500 responses "improve" the average time, but that's a failure, not a success.
- **A one-off test before release** instead of regular CI runs that catch regressions right away.

## Where to practise

You may only load test your own systems. The easiest way is to run a training app locally, such as [Conduit](product:Conduit) or the [Cypress Real World App](product:Cypress Real World App), or your own API in Docker, and write scenarios against it. For minimal experiments, a local [httpbin](product:httpbin) can respond with a set delay. Some services, such as [ParaBank](product:ParaBank), present themselves as suitable for load tests too, but public practice sites are shared by everyone, so keep the load small.

## A one-month learning plan

| Week | What to learn | Tools |
|---|---|---|
| 1 | HTTP, test types, metrics, percentiles; a first smoke test of a local app | [oha](product:oha), [Grafana k6](product:Grafana k6) |
| 2 | A realistic scenario: authentication, test data, think time, checks and thresholds | [Grafana k6](product:Grafana k6) or [Apache JMeter](product:Apache JMeter) |
| 3 | Monitoring: server and database metrics, finding the bottleneck | [Prometheus](product:Prometheus.io), [Grafana](product:Grafana) |
| 4 | Stress and soak tests, CI runs, a report with conclusions | [GitHub Actions](product:GitHub Actions), [Taurus](product:Taurus) |

Free testing and automation courses are available at [Test Automation University](product:Test Automation University).

## AI in load testing

AI assistants such as [GitHub Copilot](product:GitHub Copilot), [Cursor](product:Cursor) or [Claude Code](product:Claude Code) help write a k6 or Locust scenario from a description or a HAR file, generate test data and explain charts. Commercial platforms like [NeoLoad](product:NeoLoad) and [New Relic](product:New Relic) add AI result analysis and root-cause search. But the load profile, requirements and conclusions remain a human responsibility: AI doesn't know how many shoppers will come to your sale.

For more tools, read [Test automation tools](blog-post.php?slug=test-automation-tools&hl=en) and [API testing](blog-post.php?slug=api-testing&hl=en). All tools from this article are in the [Testing](subcategory:testing) subcategory.

## FAQ

**How does load testing differ from stress testing?**
A load test checks the system at the expected load; a stress test goes beyond normal to find the limit and see how the system breaks.

**k6 or JMeter?**
k6 suits teams that write tests as code and run them in CI. JMeter has a GUI, more protocols and appears more often in job ads. Both are free.

**How many virtual users do I need?**
As many as the real concurrent users you expect at peak, plus headroom (often 2–3×). The number comes from analytics, not "a million just in case".

**Can I load test in production?**
Yes, but only with planning: at the lowest-traffic hours, with monitoring, agreement with the team and readiness to stop the test.

**Not sure where to start?**
Ask [Elya](eli.php): she will pick load testing tools for your stack and task.

*Fact-check date: 4 November 2026. Service terms may change, so check them on the official websites.*
