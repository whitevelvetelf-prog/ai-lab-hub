---
title: "Security testing in 2026: what to check, how to start and which tools to choose"
description: "A guide to web application and API security testing for testers: OWASP Top 10, types of testing (SAST, DAST, SCA, pentesting), a checklist, Burp Suite and ZAP, scanners, secret detection, security in CI, legal practice platforms and a learning plan."
date: "2026-11-04"
updated: "2026-11-04"
---

# Security testing: what to check and with what

A functional test checks that an app does what it should. A security test checks the opposite: that it does *not* do what it shouldn't. It must not show other users' data, let people in without a password, run code pasted into a comment field or store passwords in plain text. One such bug can cost a company a leaked customer database, fines and its reputation.

Security testing is a specialism of its own, but every tester can handle the basic checks, and many tools run automatically in CI. This article explains where to start, what to check and which tools to choose, from free scanners to legal practice platforms.

> **Important.** Only test the security of your own systems or systems whose owner has given you written permission. Scanning or attacking other people's sites without permission is illegal, even "just to look". For learning there are purpose-built vulnerable apps and platforms, covered below. We checked features and terms on the official websites on 4 November 2026.

## Quick pick

| Task | Start with | Alternatives |
|---|---|---|
| Manual web app testing | [Burp Suite](product:Burp Suite) | [ZAP](product:ZAP), [Caido](product:Caido) |
| Automated site scanning (DAST) | [ZAP](product:ZAP) | [Nuclei](product:Nuclei), [Nikto](product:Nikto), [Invicti](product:Invicti), [Detectify](product:Detectify) |
| Code analysis (SAST) | [Semgrep](product:Semgrep) | [SonarQube](product:SonarQube), [GitHub Advanced Security](product:GitHub Advanced Security), [Checkmarx One](product:Checkmarx One), [Veracode](product:Veracode) |
| Vulnerable dependencies (SCA) | [Snyk](product:Snyk) | [OWASP Dependency-Check](product:OWASP Dependency-Check), [Trivy](product:Trivy), [Socket](product:Socket) |
| Secrets in code | [Gitleaks](product:Gitleaks) | [TruffleHog](product:TruffleHog), [GitGuardian](product:GitGuardian) |
| Infrastructure and network | [Nmap](product:Nmap) | [OpenVAS](product:OpenVAS), [Nessus](product:Nessus), [Intruder](product:Intruder) |
| Quick online checks | [HTTP Observatory](product:HTTP Observatory) | [Security Headers](product:Security Headers), [SSL Labs](product:SSL Labs) |
| Mobile apps | [MobSF](product:MobSF) | [Frida](product:Frida) |
| Learning | [PortSwigger Web Security Academy](product:PortSwigger Web Security Academy) | [TryHackMe](product:TryHackMe), [Hack The Box](product:Hack The Box), [OWASP Juice Shop](product:OWASP Juice Shop) |

## Types of security testing

- **SAST (static analysis)**: a tool reads source code and looks for dangerous patterns such as SQL queries built from variables, disabled certificate checks or weak cryptography. It works before the app even runs, in CI and the IDE.
- **DAST (dynamic analysis)**: a scanner attacks the running app from the outside, like an attacker, sending malicious values into fields and parameters and analysing the responses. No code access needed.
- **SCA (software composition analysis)**: checking third-party libraries for known vulnerabilities. Most of a modern app's code is dependencies, and a flaw in a popular library becomes a flaw in your product.
- **Secret detection**: API keys, passwords and tokens accidentally committed to a repository.
- **Manual security testing**: a tester works with an intercepting proxy and checks logic such as access rights, business flows and ways around restrictions. Scanners almost never find these bugs.
- **Penetration testing**: a comprehensive attack on the system by professionals under agreed rules, ending with a report.
- **Bug bounty**: a company lets outside researchers look for vulnerabilities and pays for findings via platforms such as [HackerOne](product:HackerOne) or [Bugcrowd](product:Bugcrowd).

A good strategy combines them: SAST, SCA and secret detection automatically on every commit, DAST on the test environment, manual checks for critical features and a pentest before major releases.

## OWASP Top 10: what to look for

The OWASP Top 10 lists the most common and dangerous categories of web application vulnerabilities, and both testers and developers rely on it. The current version is the OWASP Top 10:2025. Its categories in practical terms:

1. **Broken access control.** A user sees or changes someone else's data by changing an id in the URL (`/orders/1001` → `/orders/1002`), opens an admin page via a direct link, or a regular user performs an admin action through the API. SSRF, where the server can be made to call an internal address, now belongs here too.
2. **Security misconfiguration.** Debug mode on, default passwords, exposed service pages, missing security headers.
3. **Software supply chain failures.** Vulnerable, outdated or even malicious libraries, compromised build tools and CI.
4. **Cryptographic failures.** Passwords stored without strong hashing, data sent without HTTPS, outdated TLS versions.
5. **Injection.** SQL injection, XSS (JavaScript pasted into a field gets executed), command injection: anywhere user data reaches a query or page unsanitised.
6. **Insecure design.** No limit on login attempts, a 4-digit confirmation code with unlimited tries, a discount that can be applied many times.
7. **Authentication failures.** Weak password rules, sessions that don't end on logout, password reset tokens that can be guessed or reused.
8. **Software or data integrity failures.** Updates or plugins without signature checks, insecure deserialisation.
9. **Security logging and alerting failures.** Nobody notices an attack because suspicious actions aren't logged or nobody gets alerted.
10. **Mishandling of exceptional conditions.** On an error the app shows a stack trace and internal data or, worse, "fails open" and skips a check when something goes wrong.

There is a separate OWASP API Security Top 10 for APIs and an OWASP Mobile Top 10 for mobile apps.

## A checklist for testers

You can do these checks without deep security knowledge:

**Authentication and sessions**
- log in with a wrong password many times in a row: is there a limit or a CAPTCHA?
- the error message doesn't reveal whether the email exists;
- after logout, the Back button and the old token don't grant access;
- password reset links are single-use and expire.

**Access rights**
- log in as two users and try to view or change one user's data as the other by swapping the id in the URL or request;
- a regular user can't open admin pages or call admin APIs;
- extra fields in a request (for example `"role": "admin"` or `"price": 0`) are ignored by the server.

**Input**
- try `<script>alert(1)</script>`, `"><img src=x onerror=alert(1)>` and a quote `'` in text fields: the text should show as text, without running code or causing database errors;
- file uploads: can you upload `.php`, `.html` or a double-extension file, and is the size checked?
- the [BugMagnet](product:BugMagnet) extension makes inserting such values easy.

**Data and configuration**
- everything works only over HTTPS, without mixed content;
- API responses contain no extra data (passwords, hashes, internal fields) and errors contain no stack traces;
- check security headers with [HTTP Observatory](product:HTTP Observatory) or [Security Headers](product:Security Headers), and HTTPS setup with [SSL Labs](product:SSL Labs);
- session cookies have the `Secure`, `HttpOnly` and `SameSite` attributes.

Log each vulnerability like a regular bug, but mark it as security and restrict access in the tracker, for example in [Jira](product:Jira). Don't share details in open channels until it's fixed.

## Intercepting proxies: the main manual testing tool

A proxy sits between the browser and the server: you see every request and can change it before it's sent, swapping an id, role or price or bypassing a front-end check.

- **[Burp Suite](product:Burp Suite)** from PortSwigger is the industry standard. The free Community Edition includes the proxy, Repeater for replaying requests and Decoder; the paid Professional adds an automated scanner.
- **[ZAP](product:ZAP)** is a free open-source equivalent with an automated scanner, handy both for manual work and CI.
- **[Caido](product:Caido)** is a lighter modern alternative with HTTPQL filters and a free plan.
- **[mitmproxy](product:mitmproxy)** is a console proxy scriptable in Python.

For the network level there is **[Wireshark](product:Wireshark)**, which shows whether data is sent in plain text.

## Automated scanners

**Web apps and APIs (DAST):**
- **[ZAP](product:ZAP)**: automated scans and a passive baseline mode that's safe even for a test environment with data;
- **[Nuclei](product:Nuclei)**: thousands of templates for known vulnerabilities and misconfigurations;
- **[Nikto](product:Nikto)**: a classic web server scanner;
- **[sqlmap](product:sqlmap)**: automated confirmation of SQL injection;
- **[ffuf](product:ffuf)**: finding hidden pages, backups and parameters;
- commercial platforms **[Invicti](product:Invicti)** and **[Detectify](product:Detectify)** for regular scanning of many sites.

**Infrastructure:**
- **[Nmap](product:Nmap)**: which ports are open and what services run on them;
- **[OpenVAS](product:OpenVAS)** (free), **[Nessus](product:Nessus)** (with a free Essentials version) and **[Intruder](product:Intruder)**: scanning servers for known vulnerabilities and missing patches;
- **[Kali Linux](product:Kali Linux)** is a distribution with most of these tools preinstalled; **[Metasploit](product:Metasploit)** is a platform for checking whether a vulnerability can really be exploited (for experienced pentesters).

A scanner is an assistant, not a judge: it produces false positives and misses logic flaws. Verify every finding manually.

## Security in code and CI (DevSecOps)

A vulnerability is cheapest to fix before the code reaches production:

- **SAST:** [Semgrep](product:Semgrep), [SonarQube](product:SonarQube) (free Community Build available), [GitHub Advanced Security](product:GitHub Advanced Security), [Checkmarx One](product:Checkmarx One), [Veracode](product:Veracode), [Aikido Security](product:Aikido Security);
- **dependencies:** [Snyk](product:Snyk), [OWASP Dependency-Check](product:OWASP Dependency-Check), [Socket](product:Socket) (detects malicious packages);
- **containers and infrastructure as code:** [Trivy](product:Trivy);
- **secrets:** [Gitleaks](product:Gitleaks) as a pre-commit hook, [TruffleHog](product:TruffleHog) (checks whether a key is still live), [GitGuardian](product:GitGuardian).

Run these checks in [GitHub Actions](product:GitHub Actions) or [Jenkins](product:Jenkins) on every pull request, and a ZAP baseline scan after deploying to the test environment.

## APIs and mobile apps

**APIs** are the most common attack target: the UI doesn't protect against a request sent directly. Check access to other users' objects, extra fields, rate limiting and authorisation on every method. Send requests with [Postman](product:Postman) or Burp Suite, and see [API testing](blog-post.php?slug=api-testing&hl=en) for more.

**Mobile apps** can be analysed with [MobSF](product:MobSF) for risky permissions, keys in code and weak cryptography, while [Frida](product:Frida) lets you examine app behaviour at runtime. More in [Mobile app security testing](blog-post.php?slug=mobile-security-testing&hl=en) and [Mobile app testing](blog-post.php?slug=mobile-app-testing&hl=en).

**AI apps and chatbots** have vulnerabilities of their own: prompt injection, system prompt leakage and agents with excessive permissions. How to find them with the OWASP Top 10 for LLM is covered in [Testing AI and LLM applications](blog-post.php?slug=llm-app-testing&hl=en).

## Where to practise legally

- **[PortSwigger Web Security Academy](product:PortSwigger Web Security Academy)**: the best free course on web vulnerabilities, with interactive labs from the makers of Burp Suite;
- **[OWASP Juice Shop](product:OWASP Juice Shop)**: a deliberately vulnerable online shop with a challenge board;
- **[DVWA](product:DVWA)**: the classic vulnerable PHP app with difficulty levels, deployed locally;
- **[OWASP crAPI](product:OWASP crAPI)**: a deliberately vulnerable API for practising the OWASP API Top 10;
- **[TryHackMe](product:TryHackMe)**: learning paths with virtual machines right in the browser, best for beginners;
- **[Hack The Box](product:Hack The Box)**: labs, Academy courses and CTF competitions for going deeper.

Once you have the basics, try public bug bounty programmes on [HackerOne](product:HackerOne) or [Bugcrowd](product:Bugcrowd), strictly within each programme's scope. More practice sites in [Practice sites for testers](blog-post.php?slug=qa-practice-sites&hl=en).

## A one-month learning plan

| Week | What to learn | Where and with what |
|---|---|---|
| 1 | HTTP, cookies, sessions, HTTPS; OWASP Top 10; setting up Burp Suite | [PortSwigger Web Security Academy](product:PortSwigger Web Security Academy), [Burp Suite](product:Burp Suite) |
| 2 | Access control, XSS and SQL injection in practice | [OWASP Juice Shop](product:OWASP Juice Shop), [DVWA](product:DVWA) |
| 3 | API security, automated scanning | [OWASP crAPI](product:OWASP crAPI), [ZAP](product:ZAP), [Nuclei](product:Nuclei) |
| 4 | Security in CI: SAST, dependencies, secrets; writing a report | [Semgrep](product:Semgrep), [Trivy](product:Trivy), [Gitleaks](product:Gitleaks) |

## AI in security testing

AI assistants such as [GitHub Copilot](product:GitHub Copilot), [Cursor](product:Cursor) or [Claude Code](product:Claude Code) explain findings, suggest fixes and help write Semgrep rules or Nuclei templates. Scanners and platforms such as [Snyk](product:Snyk), [SonarQube](product:SonarQube) and [Caido](product:Caido) add AI to prioritise findings and check AI-generated code, which can contain vulnerabilities too. [HackerOne](product:HackerOne) also offers security testing of AI systems themselves. Deciding what counts as a risk and how to fix it is still up to people.

For other kinds of testing, read [Manual testing tools](blog-post.php?slug=manual-testing-tools&hl=en) and [Test automation tools](blog-post.php?slug=test-automation-tools&hl=en). All tools from this article are in the [Testing](subcategory:testing) and [Application Security](subcategory:appsec) subcategories.

## FAQ

**Can a manual tester do security testing?**
Yes. Checking access rights, input handling and logic is a natural extension of functional testing. Start with the checklist above and PortSwigger Academy.

**Burp Suite or ZAP?**
Burp Suite is the standard for manual testing, and its Community Edition is free. ZAP is completely free and better suited to automated scanning in CI. Many people use both.

**Can I scan any website to practise?**
No. Without the owner's permission it's illegal. Practise on learning platforms and your own local apps, or within the rules of bug bounty programmes.

**How does security testing differ from a pentest?**
Security testing is a regular part of the team's work: automated scanners and checks in every release. A pentest is a separate in-depth audit by specialists under agreed rules, usually a few times a year or before major releases.

**Not sure where to start?**
Ask [Elya](eli.php): she will pick security testing tools for your project and level.

*Fact-check date: 4 November 2026. Service terms may change, so check them on the official websites.*
