---
title: "API testing in 2026: what to check, how to start and which tools to choose"
description: "A practical API testing guide for testers: REST, GraphQL and gRPC basics, what to check in requests and responses, a checklist, manual testing in Postman, automated tests, contract tests, mocks, load, security and practice APIs."
date: "2026-11-04"
updated: "2026-11-04"
---

# API testing: what to check and which tools to choose

Most modern apps are an interface on top of an API. The Pay button in a mobile app, a filter in an online shop, signing in with Google: behind every action there is a request to a server. That is why API testing is no longer a job for automation engineers only. Manual testers check requests in Postman, watch the network in DevTools and find bugs before the UI is even ready.

This article explains what exactly to check in an API, how to build a checklist, which tools to start with and how to move from manual requests to automated tests, contract tests, mocks and load testing.

> **Important.** We checked features and terms on the official websites on 4 November 2026. Paid plans change, so check them on the service's site before paying.

## Quick pick

| Task | Start with | Alternatives |
|---|---|---|
| Manual requests and collections | [Postman](product:Postman) | [Bruno](product:Bruno), [Insomnia](product:Insomnia), [Hoppscotch](product:Hoppscotch), [Apidog](product:Apidog) |
| Requests from the terminal | [curl](product:curl) | [HTTPie](product:HTTPie), [Hurl](product:Hurl) |
| Automated tests in CI | [Newman](product:Newman) | [REST Assured](product:REST Assured), [Karate](product:Karate), [pytest](product:pytest), [Supertest](product:Supertest) |
| Tests from the spec | [Schemathesis](product:Schemathesis) | [Spectral](product:Spectral) (linter) |
| Mocks and stubs | [WireMock](product:WireMock) | [Mockoon](product:Mockoon), [Prism](product:Prism), [Beeceptor](product:Beeceptor) |
| Contract tests | [Pact](product:Pact) | — |
| GraphQL and gRPC | [Altair GraphQL Client](product:Altair GraphQL Client) | [Kreya](product:Kreya), [grpcurl](product:grpcurl) |
| Load | [Grafana k6](product:Grafana k6) | [Apache JMeter](product:Apache JMeter), [Gatling](product:Gatling), [Locust](product:Locust) |
| Security | [ZAP](product:ZAP) | [Burp Suite](product:Burp Suite) |

## What an API is and the main types

An API (Application Programming Interface) is an agreement on how one program talks to another: which address to call, what to send and what comes back. Testers most often deal with:

- **REST**, the most common style: resources have addresses (`/users/42`), actions are HTTP methods (GET, POST, PUT, PATCH, DELETE) and data travels as JSON. Such an API is usually described in an OpenAPI specification displayed by [Swagger](product:Swagger) UI.
- **[GraphQL](product:GraphQL)**: a single address, and the client describes in the query which fields it needs. Check not only the data but also the `errors` field: servers often return 200 even when the query failed.
- **gRPC**, a fast binary protocol for communication between microservices; the contract lives in `.proto` files.
- **SOAP**, an older XML format still common in banking, insurance and government systems. The classic tool for it is [SoapUI](product:SoapUI).
- **Webhooks**, when the server itself sends a request to your address (for example, about a successful payment). [Webhook.site](product:Webhook.site) lets you catch and inspect such a request.

## What to check in an API

Each request has a method, URL, headers, parameters and body; each response has a status code, headers and body. Check all of them:

1. **Status code.** 200/201 for success, 400 for invalid data, 401 without authentication, 403 without permission, 404 for a missing resource, 409 for a conflict, 422 for validation errors. A 500 is almost always a bug: the server didn't handle the situation.
2. **Response body.** Are all fields present, are the types right (a number, not the string `"42"`), date formats, empty arrays instead of `null`, schema compliance.
3. **Business logic.** After a POST the resource really exists, after a DELETE it is gone, the order total is correct, changes show up in the UI and database.
4. **Input validation.** Empty and overly long values, negative numbers, special characters, emoji, extra and missing fields, wrong data types.
5. **Authentication and permissions.** Requests without a token, with an expired or someone else's token; can you get another user's data by changing the id in the URL?
6. **Headers.** `Content-Type`, caching, CORS, no internal details (server versions) leaking in responses.
7. **Pagination, sorting and filters.** First and last page, a page out of range, a huge `limit`, filter combinations.
8. **Idempotency and retries.** What happens if the same payment or order request is sent twice?
9. **Error messages.** Clear for the client, consistent in format and without stack traces.
10. **Speed.** Response time for key requests and behaviour under load.

Data generators help with boundary values and unusual characters: [Mockaroo](product:Mockaroo) creates a set of realistic test records, and [Faker.js](product:Faker.js) generates data right in test code.

## Manual API testing: where to start

Start with two things: the **Network** tab in browser DevTools and an API client.

**DevTools** shows which requests the web UI sends: open the Network tab, do something on the site and inspect the request and response. Any request can be copied "as cURL" and pasted into an API client or a bug report, so a developer can reproduce the problem with one command.

**API clients:**

- **[Postman](product:Postman)** is the most popular: collections, environment variables, pre-request scripts and tests, documentation and mocks. Most courses and job ads expect it.
- **[Bruno](product:Bruno)** stores collections as files next to your code and works offline, handy when the team wants tests in Git.
- **[Insomnia](product:Insomnia)** and **[Hoppscotch](product:Hoppscotch)** (which runs right in the browser) are lighter alternatives with REST, GraphQL and WebSocket support.
- **[Apidog](product:Apidog)** combines API design, requests, mocks, test scenarios and documentation in one app.
- **[Thunder Client](product:Thunder Client)** lives inside VS Code, if you already work in the editor.

You will need the **terminal** too: **[curl](product:curl)** is on almost every computer and server, while **[HTTPie](product:HTTPie)** has simpler syntax and formats JSON nicely.

Check a response for syntax errors in **[JSONLint](product:JSONLint)**, and use **[httpbin](product:httpbin)** to see exactly what your client sent to the server.

## Intercepting traffic: mobile and desktop app APIs

A mobile app has no DevTools, so traffic is captured through a proxy: the phone sends requests through your computer and you see every request and response.

- **[Charles Proxy](product:Charles Proxy)** and **[Fiddler](product:Fiddler)** are the classics for web and mobile, with response rewriting and slow network simulation.
- **[Proxyman](product:Proxyman)** is a modern proxy with easy iOS and Android setup.
- **[HTTP Toolkit](product:HTTP Toolkit)** hooks into a browser or Android in one click, and **[mitmproxy](product:mitmproxy)** is an open-source console proxy scriptable in Python.
- **[Requestly](product:Requestly)** rewrites responses and headers in the browser so you can see how the UI handles a 500 or an empty list.

## A checklist for one endpoint

Take `POST /api/orders`, which creates an order:

- valid order → 201, the response contains the id and all fields, the order is visible via `GET /api/orders/{id}`;
- no token → 401; another user's token on someone else's order → 403 or 404;
- missing required field, empty string, negative quantity, non-existent product → 400/422 with a clear message;
- a string instead of a number, a very long comment, special characters and emoji → proper validation without a 500;
- the same request twice in a row → no duplicate order (if that is the intended behaviour);
- `Content-Type: text/plain` instead of JSON → 415 or 400;
- response time within requirements.

Keep such a checklist in a test management tool such as [Qase](product:Qase) or [TestRail](product:TestRail), and log bugs in [Jira](product:Jira) with the curl command and the server response.

## Automating API tests

API tests are the most cost-effective automation: they are fast, stable and don't break when the layout changes. Options depend on the team's language:

- **Postman collections in CI:** [Newman](product:Newman) runs a collection from the command line and produces a report, the easiest step from manual checks to automation.
- **Java:** [REST Assured](product:REST Assured) in given/when/then style with [JUnit](product:JUnit) or [TestNG](product:TestNG).
- **Python:** [pytest](product:pytest) with the requests or httpx library.
- **JavaScript/TypeScript:** [Supertest](product:Supertest) with [Jest](product:Jest) or [Vitest](product:Vitest), or API tests in [Playwright](product:Playwright) if your UI tests already use it.
- **Without programming:** [Karate](product:Karate) describes requests and assertions in a Gherkin-like syntax, and [Hurl](product:Hurl) in plain text files.
- **Low-code platforms:** [Katalon](product:Katalon) and [SoapUI](product:SoapUI) offer a graphical interface for API tests.

To run tests on every code change, plug them into [GitHub Actions](product:GitHub Actions) or [Jenkins](product:Jenkins) and collect results in [Allure Report](product:Allure Report).

### Tests written by the spec

If the API has an OpenAPI description, tools can do part of the work:

- **[Schemathesis](product:Schemathesis)** generates thousands of requests from the spec, looks for 500 errors and schema mismatches and gives a curl command to reproduce each finding;
- **[Spectral](product:Spectral)** checks the spec itself: errors, field naming, required descriptions and examples, before any code is written.

## Mocks, stubs and test environments

Often the service you need isn't ready yet, costs money or is unstable (a payment provider, a delivery service). Then you replace it with a stub:

- **[WireMock](product:WireMock)** is the standard for mocks in automated tests: canned responses, delays, errors, recording real traffic.
- **[Mockoon](product:Mockoon)** is a desktop app where you create a mock API in minutes without code.
- **[Prism](product:Prism)** starts a mock server straight from an OpenAPI file, and in proxy mode validates the real API against the spec.
- **[Beeceptor](product:Beeceptor)** offers mocks in the browser, including REST, SOAP and GraphQL.
- **[Testcontainers](product:Testcontainers)** spins up a real database or message broker in Docker for the duration of a test.
- Emails and SMS sent by the API (sign-up confirmation, password reset) can be checked with [Mailpit](product:Mailpit), [Mailtrap](product:Mailtrap) or [Mailosaur](product:Mailosaur).

## Contract testing

In a system with dozens of microservices, end-to-end tests become slow and brittle. Contract tests check something else: that the client and the service understand the API the same way. **[Pact](product:Pact)** records the client's expectations (which requests it sends and which responses it expects) and verifies that the service meets them, without deploying the whole system. That way a change in one service won't silently break another.

## GraphQL and gRPC

- **GraphQL:** [Altair GraphQL Client](product:Altair GraphQL Client) shows schema docs and lets you add fields to a query straight from them; [Postman](product:Postman), [Insomnia](product:Insomnia) and [Hoppscotch](product:Hoppscotch) handle GraphQL too. Check deeply nested queries, field-level permissions and the `errors` field in responses.
- **gRPC:** [Kreya](product:Kreya) imports protobuf files or server reflection and handles streaming, while [grpcurl](product:grpcurl) calls methods right from the terminal.

## Load and performance

An API that answers one tester quickly may fall over under a thousand users. To check:

- **[Grafana k6](product:Grafana k6)**: JavaScript scenarios and thresholds that are easy to enforce in CI;
- **[Apache JMeter](product:Apache JMeter)**: a graphical editor and the widest protocol support;
- **[Gatling](product:Gatling)**, **[Locust](product:Locust)** (Python) and **[Artillery](product:Artillery)** (YAML): scenarios as code.

Start simple: how do response time and error rate change as concurrent users grow from 10 to 100? More in [Load testing](blog-post.php?slug=load-testing&hl=en).

## API security

Typical API vulnerabilities are listed in the OWASP API Security Top 10: access to other users' objects by changing an id, weak authentication, overly verbose responses, no rate limiting. A manual tester can check the basics: requests without a token, with someone else's token, with extra fields (for example `"role": "admin"` in a profile update request).

For deeper checks there is **[ZAP](product:ZAP)** (a free open-source scanner) and **[Burp Suite](product:Burp Suite)**. Only test the security of systems you have permission to test. More in [Security testing](blog-post.php?slug=security-testing&hl=en).

## Where to practise

Free test APIs you can send requests to without worrying:

- **[ReqRes](product:ReqRes)** and **[JSONPlaceholder](product:JSONPlaceholder)**: the easiest start, no sign-up;
- **[Restful-Booker](product:Restful-Booker)**: a booking API with authentication and deliberate bugs;
- **[Swagger Petstore](product:Swagger Petstore)**: the classic OpenAPI demo with documentation;
- **[GoRest](product:GoRest)**: tokens, pagination and an OpenAPI spec;
- **[DummyJSON](product:DummyJSON)** and **[Fake Store API](product:Fake Store API)**: online shop data, search, authentication;
- **[Practice Software Testing](product:Practice Software Testing)**, **[QA Practice](product:QA Practice)** (including GraphQL), **[Contact List App](product:Contact List App)** and **[Expand Testing Practice](product:Expand Testing Practice)**: apps where you can compare UI and API behaviour.

More in the article [Practice sites for testers](blog-post.php?slug=qa-practice-sites&hl=en) and the [Practice Sites for Testers](subcategory:qa-practice) subcategory.

## A two-week plan

| Days | What to do | Where |
|---|---|---|
| 1–2 | HTTP methods, status codes, headers; requests in DevTools and curl | [httpbin](product:httpbin), [ReqRes](product:ReqRes) |
| 3–5 | A Postman collection: environment variables, a CRUD scenario, tests for codes and fields | [Restful-Booker](product:Restful-Booker), [GoRest](product:GoRest) |
| 6–8 | A checklist and negative tests for 3–5 endpoints, bug reports with curl commands | [Practice Software Testing](product:Practice Software Testing) |
| 9–10 | Run the collection with Newman and in GitHub Actions | [Newman](product:Newman), [GitHub Actions](product:GitHub Actions) |
| 11–12 | First automated tests in your language: REST Assured, pytest or Supertest | [Swagger Petstore](product:Swagger Petstore) |
| 13–14 | A mock server and a simple load test | [Mockoon](product:Mockoon), [Grafana k6](product:Grafana k6) |

The result is a Postman collection and a repository of automated tests you can show in your portfolio.

## AI in API testing

AI assistants handle the routine well: from an OpenAPI spec they suggest checks and negative scenarios, generate test data and scaffold automated tests. [Postman](product:Postman) has built-in AI features, and [GitHub Copilot](product:GitHub Copilot), [Cursor](product:Cursor) or [Claude Code](product:Claude Code) can write REST Assured or pytest tests from a description. But reread every generated test: AI easily writes an assertion that always passes, even when the API is broken.

For other kinds of testing, read [Manual testing tools](blog-post.php?slug=manual-testing-tools&hl=en) and [Test automation tools](blog-post.php?slug=test-automation-tools&hl=en). All tools from this article are in the [Testing](subcategory:testing) and [API](subcategory:api) subcategories.

## FAQ

**Do I need to code to test APIs?**
No, Postman and an understanding of HTTP are enough to start. You will need code when you automate checks, but even then you can begin with Postman tests and Newman.

**Postman or Bruno?**
Postman is the market standard with the most learning materials. Bruno is handier when the team wants collections in Git next to the code and no cloud account.

**How do API tests differ from UI tests?**
API tests check logic and data directly, without the UI, so they are faster and more stable. UI tests check what the user sees and can do. A good strategy has more API tests than UI tests.

**Is it safe to send requests to test APIs?**
Yes, that's what they are for. But don't enter real personal data or passwords there, as other users may see them.

**Not sure where to start?**
Ask [Elya](eli.php): she will pick API testing tools for your project and programming language.

*Fact-check date: 4 November 2026. Service terms may change, so check them on the official websites.*
