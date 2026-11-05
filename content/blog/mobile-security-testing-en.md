---
title: "Mobile App Security Testing in 2026: OWASP MASVS, a Checklist and Tools"
description: "A practical guide to security testing Android and iOS apps: OWASP Mobile Top 10 and MASVS, static and dynamic analysis, traffic interception and SSL pinning, on-device storage, deep links, root and jailbreak, Frida, MobSF, jadx, practice apps and a learning plan."
date: "2026-11-05"
updated: "2026-11-05"
---

# Mobile app security testing

A website lives on a server the attacker cannot reach. A mobile app is the opposite: its APK or IPA file sits with everyone who downloaded it. Anyone can unpack the build, read the code, find hardcoded API keys, change checks and run a modified copy on a rooted phone. So mobile app security rests on two things: what the app stores and sends on the device itself, and whether the server refuses to trust everything that comes from the client.

This article covers what to check in mobile apps, how to set up your workstation, which tools to pick for Android and iOS and where to practise legally. General web and API security principles are in [Security testing](blog-post.php?slug=security-testing&hl=en), and functional mobile testing is in [Mobile app testing](blog-post.php?slug=mobile-app-testing&hl=en).

> **Important.** Only examine your own apps or apps whose owner has given you written permission to test. Decompiling, bypassing protections and tampering with other people's apps without permission may break the law and terms of use. For learning there are intentionally vulnerable apps, listed below. We checked tool features and terms against official websites on 5 November 2026.

## Quick picks

| Task | Start with | Alternatives |
|---|---|---|
| Standard and methodology | [OWASP MAS](product:OWASP MAS) (MASVS, MASTG) | — |
| Automated APK / IPA analysis | [MobSF](product:MobSF) | [Ostorlab](product:Ostorlab), [Oversecured](product:Oversecured), [Appknox](product:Appknox), [NowSecure](product:NowSecure) |
| Android decompilation | [jadx](product:jadx) | [Apktool](product:Apktool), [Ghidra](product:Ghidra) (native code) |
| Secrets in the build | [APKLeaks](product:APKLeaks) | [MobSF](product:MobSF), [Gitleaks](product:Gitleaks) (in the repository) |
| Traffic interception | [Burp Suite](product:Burp Suite) | [mitmproxy](product:mitmproxy), [HTTP Toolkit](product:HTTP Toolkit), [Proxyman](product:Proxyman), [Charles Proxy](product:Charles Proxy) |
| Runtime analysis | [Frida](product:Frida) | [objection](product:objection), [reFlutter](product:reFlutter) (Flutter) |
| Android components and IPC | [drozer](product:drozer) | [MobSF](product:MobSF) |
| Rooted test device | [Magisk](product:Magisk) on a dedicated phone | [Genymotion](product:Genymotion), [Corellium](product:Corellium) (virtual iOS and Android) |
| App protection (for developers) | [freeRASP](product:freeRASP) | [Approov](product:Approov) |
| Learning | [OWASP MAS](product:OWASP MAS) and MAS Crackmes | [AndroGoat](product:AndroGoat), [DVIA-v2](product:DVIA-v2) |

## How mobile security differs from the web

- **The client is in the attacker's hands.** Everything built into the app — keys, internal server URLs, check logic, "hidden" features — can be found with a decompiler. A secret in client code is no longer a secret.
- **Data on the device.** The app stores tokens, caches, SQLite databases, files and screenshots in the app switcher. Phones get lost, and they may carry malware or root.
- **Interaction with other apps.** Deep links, Android intents, content providers, URL schemes and the clipboard are channels through which another app can send malicious data or take yours.
- **The network is out of your control.** Public Wi-Fi, rogue access points, proxies. The app must validate server certificates properly.
- **Tampering and repackaging.** An attacker can modify the app (disable purchase checks, ads or root detection), re-sign it and distribute the copy.
- **The platforms differ.** Android and iOS have different secure storage (Keystore and Keychain), permission models and protections, so they have to be tested separately.

## OWASP Mobile Top 10 and MASVS

The **OWASP Mobile Top 10** lists the most common risks for mobile apps. The current version is from 2024:

1. **Improper credential usage** — keys and passwords in code, credentials sent without protection.
2. **Inadequate supply chain security** — vulnerable or malicious SDKs and libraries, a compromised build.
3. **Insecure authentication/authorization** — permission checks only on the client, weak sessions, login bypass.
4. **Insufficient input/output validation** — injections, XSS in WebView, unsafe deep links.
5. **Insecure communication** — HTTP instead of HTTPS, disabled certificate validation.
6. **Inadequate privacy controls** — excessive personal data, leaks into logs, analytics and ad SDKs.
7. **Insufficient binary protections** — easy to decompile, modify and repackage.
8. **Security misconfiguration** — debugging in release, backups allowed, exported components, excessive permissions.
9. **Insecure data storage** — tokens and personal data in plain text in files, databases and preferences.
10. **Insufficient cryptography** — outdated algorithms, home-made "ciphers", keys stored next to encrypted data.

The Top 10 tells you *what* to look for. For systematic testing there is the **[OWASP MAS](product:OWASP MAS)** project:

- **MASVS** — the requirements standard, grouped into eight areas: STORAGE, CRYPTO, AUTH, NETWORK, PLATFORM (interaction with the platform), CODE (code quality and dependencies), RESILIENCE (resistance to reverse engineering and tampering) and PRIVACY;
- **MASTG** — the guide on *how* to test each requirement on Android and iOS: techniques, tests, demos and best practices;
- **MASWE** — a list of common weaknesses linked to tests;
- **the checklist** — a handy basis for a test plan and report.

Not every app needs maximum resilience: a game is fine with the baseline, while banking, healthcare or payment apps also need protection against reverse engineering and tampering. Agree on the level with the team at the start.

## The tester's workstation

**Devices.** For Android, the easiest option is a dedicated test phone with [Magisk](product:Magisk) for root access, or an emulator from [Android Studio](product:Android Studio) or [Genymotion](product:Genymotion). Never root your personal phone with banking apps on it. For iOS you need a Mac with [Xcode](product:Xcode); deep checks need a jailbroken device, which is hard to get for new iOS versions, so companies use [Corellium](product:Corellium) virtual devices.

**Builds.** Ask developers for two versions: the **release** build (this is what reaches users; test protections on it) and a **debug** build that trusts your proxy certificate (more convenient for API testing).

**Tools on your computer:** `adb` from the Android SDK, an intercepting proxy ([Burp Suite](product:Burp Suite) or [mitmproxy](product:mitmproxy)), [jadx](product:jadx), [Apktool](product:Apktool), [Frida](product:Frida) with [objection](product:objection) and [MobSF](product:MobSF). MobSF is easiest to run in Docker:

```
docker run -it --rm -p 8000:8000 opensecurity/mobile-security-framework-mobsf:latest
```

Then open `http://localhost:8000` and drag an APK, AAB or IPA into the window.

## Step 1. Static analysis: what's inside the build

Static analysis does not need the app to run — you examine the file itself.

**Automatically.** [MobSF](product:MobSF) shows permissions, exported components, risky manifest settings, weak cryptography, server URLs and possible secrets within minutes. Cloud scanners [Ostorlab](product:Ostorlab) (with a free plan), [Oversecured](product:Oversecured), [Appknox](product:Appknox) and [NowSecure](product:NowSecure) go deeper and integrate with CI. Treat the report as a list of hypotheses: some findings are false positives.

**Manually.** Unpack and decompile the app:

```
apktool d app-release.apk -o app_src
jadx -d app_java app-release.apk
```

Open `AndroidManifest.xml` and check:
- `android:debuggable="true"` — must not be present in a release build;
- `android:allowBackup="true"` — app data can be extracted through a backup;
- `android:exported="true"` on activities, services, receivers and providers — each such component is reachable by other apps and must check who sends it what;
- `android:usesCleartextTraffic="true"` and `network_security_config.xml` — whether HTTP is allowed and whether the app trusts user certificates;
- permissions — does the app really need contacts, SMS or precise location?

In [jadx-gui](product:jadx), search for `api_key`, `secret`, `password`, `Bearer`, `http://`, test server URLs and commented-out features. [APKLeaks](product:APKLeaks) automates this search. Native `.so` libraries are studied in [Ghidra](product:Ghidra).

An iOS IPA is a zip archive: check `Info.plist` (App Transport Security exceptions such as `NSAllowsArbitraryLoads`, URL schemes, permissions) and the strings in the binary.

**Keys in code are always a defect.** If you find a key for a paid API or cloud storage in the app, assume others have found it too. The right fix is for the key never to reach the client, with requests going through your own server.

## Step 2. On-device data storage

Install the app, log in, use it, then see what remains on the device. On Android the app's private folder is `/data/data/<package>/`; on a rooted test device or with a debug build you can browse it via `adb`:

```
adb shell run-as com.example.app ls -R /data/data/com.example.app
```

What to check:
- **SharedPreferences, SQLite databases, files** — no passwords, tokens, card numbers or personal data in plain text;
- **secrets live in Android Keystore or iOS Keychain**, not in ordinary files;
- **logs** (`adb logcat` or Console on a Mac) — no tokens, requests or personal data in a release build;
- **clipboard** — password and code fields block copying, and the app does not read the clipboard needlessly;
- **app switcher screenshot** — screens with cards, codes and balances are hidden (on Android, `FLAG_SECURE`);
- **keyboard cache** — password and code fields do not end up in keyboard suggestions;
- **external storage and downloads** — exported documents are not left in public folders;
- **after logout** local data and tokens are deleted.

## Step 3. Network and API

Point the device at a proxy on your computer and install the proxy certificate. An Android caveat: since Android 7, apps do not trust user-installed certificates by default. So for the debug build developers add a block to `network_security_config.xml` that applies only to debug builds:

```
<network-security-config>
  <debug-overrides>
    <trust-anchors>
      <certificates src="user" />
    </trust-anchors>
  </debug-overrides>
</network-security-config>
```

On iOS, after installing the certificate profile you must also enable it under Settings → General → About → Certificate Trust Settings.

What to check:
- **all traffic goes over HTTPS**, with no plain-text requests, including from third-party SDKs;
- **the release build rejects a forged certificate**: without the proxy certificate installed, the app should refuse to connect rather than silently work;
- **SSL pinning**, if claimed, really works in release — and there is a plan for rotating certificates so the app does not break when they change;
- **the API enforces permissions on the server**: swap the order id, role, price or bonus amount — the server must refuse. Most serious mobile vulnerabilities actually live in the back end;
- **responses carry no extra data** that the app simply doesn't show on screen;
- **tokens expire** and are revoked after logout or a password change.

Flutter apps ignore the system proxy, so [reFlutter](product:reFlutter) comes in handy. [HTTP Toolkit](product:HTTP Toolkit) sets up interception on an Android device in a few clicks, while [Proxyman](product:Proxyman) and [Charles Proxy](product:Charles Proxy) are convenient on a Mac. More on API checks in [API testing](blog-post.php?slug=api-testing&hl=en).

## Step 4. Platform interaction: deep links, components, WebView

**Deep links and URL schemes.** The app opens from a link, which means anyone can send the user a link with arbitrary parameters. On Android, links are easy to trigger with `adb`:

```
adb shell am start -W -a android.intent.action.VIEW -d "myapp://reset-password?token=test" com.example.app
```

Check that links do not perform actions without confirmation (transfers, email changes), do not open arbitrary URLs in a WebView and do not bypass the login screen. For HTTPS links, check App Links (Android) and Universal Links (iOS) so another app cannot hijack links to your domain.

**Exported Android components.** [drozer](product:drozer) finds activities, services, receivers and content providers reachable by other apps and tests them for data leaks, SQL injection and permission bypasses.

**WebView.** If the app shows web pages inside, check whether JavaScript is enabled only where needed, whether arbitrary URLs can be loaded, whether JavaScript–native bridges are safe and whether local files are accessible.

**Permissions.** Deny each permission and make sure the app neither crashes nor bypasses the denial. Check that camera, location and contacts data is not sent where it shouldn't go.

## Step 5. Runtime analysis: Frida and objection

[Frida](product:Frida) attaches to a running app and lets you trace and modify function calls: see what the app encrypts and where it sends it, change the result of a root or purchase check, bypass SSL pinning. [objection](product:objection) is a layer on top of Frida with ready-made commands in its console, such as `android sslpinning disable` or `ios keychain dump`, with no scripting.

What to check at this step:
- **whether important checks run on the server**, not just in the app: if Frida "turns off" the purchase check and a paid feature unlocks, the server trusts the client;
- **whether passwords and keys stay in memory** longer than necessary;
- **biometrics**: is Face ID or fingerprint login bound to a key in Keystore/Keychain, or is it just a yes/no flag that is easy to flip?

## Step 6. Resilience against reverse engineering and tampering

These checks matter for apps where tampering has a real cost: banking, payments, games with in-app purchases, healthcare.

- **Root and jailbreak.** How the app behaves on a rooted device: warns, limits features or exits — according to product requirements.
- **Emulator, debugger and Frida.** Does the app notice it is running in an emulator or under an instrumentation tool?
- **Modification.** Unpack the app with [Apktool](product:Apktool), change something minor, rebuild and re-sign — will the app or the server notice it is not the original?
- **Obfuscation.** Is the decompiled code hard to read (R8/ProGuard on Android, obfuscators for iOS)?

Keep in mind that any client-side protection can be bypassed; it only raises the cost of an attack. What works best is combining in-app protection, such as the free [freeRASP](product:freeRASP) SDK, with a server-side check that the request came from the genuine app: Google's Play Integrity API, Apple's App Attest or the [Approov](product:Approov) service.

## Step 7. Supply chain and privacy

- **Third-party SDKs and libraries.** Ads, analytics, chat, payments — each SDK gets the same rights as your app. MobSF and commercial scanners build a component list (SBOM); repository dependencies are checked by [Snyk](product:Snyk) or [Trivy](product:Trivy), and code by [Semgrep](product:Semgrep), which has rules for Kotlin, Java and Swift.
- **Consistency with store declarations.** The data the app actually collects and sends (visible in the proxy) must match the Data safety section on Google Play and the privacy manifest on the App Store.
- **Personal data.** Can users delete their account and data from the app? Does personal data leak into analytics and crash reports?

## Quick checklist

**Build and configuration**
- release without `debuggable`, extra permissions or exported components;
- `allowBackup` disabled or exclusion rules configured;
- no keys, passwords or test server URLs in code and resources.

**Data**
- tokens and secrets only in Keystore/Keychain;
- no personal data in plain text in files, databases, logs or caches;
- sensitive screens hidden in the app switcher, data deleted after logout.

**Network and API**
- HTTPS only; a forged certificate is rejected in release;
- permissions enforced on the server: other users' ids, roles and prices are rejected;
- tokens expire and are revoked.

**Platform**
- deep links perform no actions without confirmation and open no arbitrary URLs;
- WebView is restricted, JavaScript bridges are safe;
- denied permissions are handled correctly.

**Resilience** (if required)
- the response to root, jailbreak, emulators, Frida and modification matches the requirements;
- the server verifies that requests come from the genuine app.

File vulnerabilities as bugs with a security label and restricted access in the tracker, including build version, device and OS, steps, evidence and a reference to the MASVS requirement. Do not publish details until they are fixed.

## Security in CI

Automated checks are best run on every build rather than once before release:

- static analysis of code and dependencies — [Semgrep](product:Semgrep), [Snyk](product:Snyk), [Gitleaks](product:Gitleaks) for secrets in the repository;
- scanning the finished build — [MobSF](product:MobSF) via its REST API or the cloud services [Ostorlab](product:Ostorlab), [Oversecured](product:Oversecured) and [Appknox](product:Appknox), with integrations for [GitHub Actions](product:GitHub Actions) and other CI;
- manual testing and pentests — for new critical features and before major releases.

For apps that need independent validation there is the **MASA** programme (App Defense Alliance): accredited labs assess the app against MASVS, and Google Play can show an independent security review badge.

## Where to practise legally

- **[OWASP MAS](product:OWASP MAS)** — MASTG with demos and **MAS Crackmes** challenges for reverse engineering practice on Android and iOS;
- **[AndroGoat](product:AndroGoat)** — an intentionally vulnerable Kotlin Android app with 30+ challenges: storage, WebView, components, pinning, root;
- **[DVIA-v2](product:DVIA-v2)** — an intentionally vulnerable Swift iOS app: storage, jailbreak, biometrics, network, patching;
- **[OWASP crAPI](product:OWASP crAPI)** — a vulnerable API of the kind mobile clients talk to, for practising the OWASP API Top 10;
- **[MobSF](product:MobSF)** — run the practice apps through it and compare its automatic findings with your own.

More practice targets in [QA practice sites](blog-post.php?slug=qa-practice-sites&hl=en).

## A one-month learning plan

| Week | What to learn | Where and with what |
|---|---|---|
| 1 | APK and IPA structure, the manifest, permissions; OWASP Mobile Top 10 and MASVS; static analysis | [OWASP MAS](product:OWASP MAS), [MobSF](product:MobSF), [jadx](product:jadx), [Apktool](product:Apktool) |
| 2 | On-device storage and logs; traffic interception, certificates, API checks | [AndroGoat](product:AndroGoat), [Burp Suite](product:Burp Suite), [HTTP Toolkit](product:HTTP Toolkit) |
| 3 | Deep links, components, WebView; runtime analysis | [drozer](product:drozer), [Frida](product:Frida), [objection](product:objection) |
| 4 | Root and jailbreak, pinning bypass, iOS specifics; a MASVS-based report | [Magisk](product:Magisk), [DVIA-v2](product:DVIA-v2), MAS Crackmes |

## AI in mobile app security testing

AI assistants such as [Claude Code](product:Claude Code), [Cursor](product:Cursor) or [GitHub Copilot](product:GitHub Copilot) help you make sense of decompiled code, explain MobSF findings, write Frida scripts and suggest fixes. Commercial platforms like [Ostorlab](product:Ostorlab), [Oversecured](product:Oversecured) and [Appknox](product:Appknox) use AI agents that log into the app themselves and try to confirm findings. But AI makes mistakes: verify every finding by hand, and do not upload clients' code or builds to third-party services without permission.

For other kinds of testing, see [Security testing](blog-post.php?slug=security-testing&hl=en), [Mobile app testing](blog-post.php?slug=mobile-app-testing&hl=en) and [API testing](blog-post.php?slug=api-testing&hl=en). All tools from this article are in the [Testing](subcategory:testing) and [Application Security](subcategory:appsec) subcategories.

## FAQ

**Do I need a rooted or jailbroken phone?**
Not to start. Static analysis, traffic inspection with a debug build and API checks need no root. For storage checks, pinning bypass and resilience testing, a dedicated rooted Android test phone or an emulator is more convenient. For iOS, companies often use Corellium virtual devices.

**Where should a manual tester start?**
Run the build through MobSF, set up traffic interception and check permissions in the API — swapping ids and roles uncovers the most real problems. Then study MASTG and practise on AndroGoat.

**Does SSL pinning protect against everything?**
No. Pinning protects against traffic interception on the network, but on a rooted device it is bypassed in minutes. Security must rest on the server: permission checks, token expiry and, where needed, app attestation.

**Is obfuscation enough to hide an API key?**
No. Obfuscation only makes code harder to read. Any key that ships in the app can be found. Sensitive requests should go through your server.

**Is Android or iOS more secure?**
Each platform has its own mechanisms and typical mistakes, and vulnerabilities depend more on the app and its back end than on the OS. Both versions need to be tested separately.

**Not sure where to start?**
Ask [Elya](eli.php): she will pick tools for security testing your mobile app.

*Fact-check date: 5 November 2026. Service terms may change, so check them on the official websites.*
