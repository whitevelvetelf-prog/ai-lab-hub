---
title: "Mobile app testing in 2026: what to check, which devices to use and which tools to choose"
description: "A guide to testing Android and iOS apps: what makes mobile testing different, a checklist, emulators and real devices, device clouds, beta builds, bug reports, traffic, automation, performance, security and practice apps."
date: "2026-11-04"
updated: "2026-11-04"
---

# Mobile app testing: what to check and with what

A mobile app lives in much harsher conditions than a website on a desktop. Thousands of phone models with different screens and Android and iOS versions, weak signal in the subway, an incoming call in the middle of a payment, 3% battery, power saving mode, an OS that kills the app in the background without warning. You won't see most of these situations by tapping through the app on one new phone on office Wi-Fi.

This article explains how mobile testing differs from web testing, what to check, how to choose devices, how to get test builds and report bugs, and which tools to use for automation, performance and security.

> **Important.** We checked features and terms on the official websites on 4 November 2026. Paid plans change, so check them on the service's site before paying.

## Quick pick

| Task | Start with | Alternatives |
|---|---|---|
| Emulators and simulators | [Android Studio](product:Android Studio), [Xcode](product:Xcode) | [Genymotion](product:Genymotion), [Appetize.io](product:Appetize.io) |
| Real devices in the cloud | [BrowserStack](product:BrowserStack) | [Sauce Labs](product:Sauce Labs), [LambdaTest](product:LambdaTest), [Kobiton](product:Kobiton), [BitBar](product:BitBar), [AWS Device Farm](product:AWS Device Farm), [Firebase Test Lab](product:Firebase Test Lab) |
| Test builds | [TestFlight](product:TestFlight) (iOS) | [Firebase App Distribution](product:Firebase App Distribution), [Diawi](product:Diawi) |
| Phone screen on your computer | [scrcpy](product:scrcpy) | [Vysor](product:Vysor) |
| Bug reports from the phone | [Luciq (Instabug)](product:Luciq) | [Shake](product:Shake) |
| Network traffic | [Charles Proxy](product:Charles Proxy) | [Proxyman](product:Proxyman), [HTTP Toolkit](product:HTTP Toolkit) |
| Automation | [Appium](product:Appium) | [Maestro](product:Maestro), [Espresso](product:Espresso), [XCUITest](product:XCTest / XCUITest), [Detox](product:Detox), [Patrol](product:Patrol) |
| Crashes and stability | [Firebase Crashlytics](product:Firebase Crashlytics) | [Sentry](product:Sentry), [Bugsnag](product:Bugsnag) |
| Security | [MobSF](product:MobSF) | [Frida](product:Frida), [ZAP](product:ZAP), [Burp Suite](product:Burp Suite) |

## How mobile testing differs from web testing

- **Fragmentation.** Hundreds of Android models from different manufacturers with their own skins, different screen sizes and aspect ratios, camera cutouts, foldables, tablets. iOS has fewer devices but several supported OS versions at once.
- **App lifecycle.** The app is backgrounded, unloaded from memory by the OS, resumed an hour later, opened from a push notification or a link. Each transition is a chance for bugs with lost data and blank screens.
- **Unstable network.** Switching between Wi-Fi and mobile data, airplane mode, slow 3G, losing the connection mid-request.
- **Hardware and permissions.** Camera, location, microphone, Bluetooth, NFC, biometrics, notifications, and permission prompts the user may deny.
- **Interruptions.** Calls, SMS, alarms, low battery, plugging in headphones.
- **Store distribution.** A build goes through App Store or Google Play review, and users may stay on an old version for months. That's why updates over an old version and backward API compatibility matter.

## What to check: a checklist

**Installation and updates**
- clean install, first launch, onboarding;
- update over the previous version keeping data and login;
- uninstall and reinstall, logging in after reinstall.

**Functionality and UI**
- key scenarios on several screen sizes, in portrait and landscape;
- dark mode, larger system font, different languages and long translations;
- gestures: swipes, pull-to-refresh, long press, the Android Back button;
- the keyboard doesn't cover input fields; the right keyboard type (digits for phone numbers, email layout for email).

**Lifecycle and interruptions**
- background and reopen the app on every important screen, including during loading or payment;
- rotate the screen while filling in a form; data must not disappear;
- incoming call, notification, alarm, screen lock;
- the app is killed by the OS (on Android, the "Don't keep activities" developer option makes this easy to check).

**Network**
- airplane mode, Wi-Fi ↔ mobile data switching, slow connection;
- clear no-connection messages and retry;
- offline mode, if promised, and sync once the connection is back.

**Permissions and device features**
- grant, deny and "deny forever" every permission, then change it in settings;
- camera, location, biometrics, push notifications (including opening the app from a push);
- deep links from a browser, email or messenger.

**Resources**
- behaviour at low battery and in power saving mode;
- low free storage;
- battery and data usage during normal use.

**Accessibility**
- works with TalkBack (Android) and VoiceOver (iOS) screen readers: are buttons and fields announced?
- tap target size, contrast, larger font.

More in [Accessibility testing](blog-post.php?slug=accessibility-testing&hl=en).

## Emulators or real devices

**Emulators and simulators** are fast and free, ideal for everyday functional checks:

- **[Android Studio](product:Android Studio)** includes an Android emulator with any OS version and screen size, plus Logcat for logs;
- **[Xcode](product:Xcode)** has the iOS simulator (Mac only);
- **[Genymotion](product:Genymotion)** offers fast Android emulators with sensor, network and GPS controls;
- **[Appetize.io](product:Appetize.io)** opens an iOS simulator or Android emulator right in the browser, handy when a tester has no Mac.

But an emulator won't show real performance, camera, biometrics, Bluetooth, push behaviour or manufacturer-specific quirks. So **real devices** are a must: at least a few of the most popular among your users (from analytics), one old low-end Android and the oldest supported iOS version.

**Real device clouds** give access to hundreds of models without your own phone wall: [BrowserStack](product:BrowserStack), [Sauce Labs](product:Sauce Labs), [LambdaTest](product:LambdaTest), [Kobiton](product:Kobiton), [BitBar](product:BitBar), [AWS Device Farm](product:AWS Device Farm) and [HeadSpin](product:HeadSpin) (devices in different countries and carrier networks). [Firebase Test Lab](product:Firebase Test Lab) runs tests on Google-hosted devices and, for Android, offers a Robo test that crawls the app with no tests written.

To work with an Android phone from your computer, mirror and control its screen with **[scrcpy](product:scrcpy)** (free) or **[Vysor](product:Vysor)**, handy for screenshots, screen recordings and demos.

## Test builds

An app reaches the store only after testing, so testers get builds separately:

- **[TestFlight](product:TestFlight)** is Apple's official beta testing service for iOS apps;
- **[Firebase App Distribution](product:Firebase App Distribution)** distributes Android and iOS builds to the team and beta testers;
- **[Diawi](product:Diawi)** lets you share a build as a simple link.

Always include the app version and build number in bug reports: on mobile, different people often test different builds at the same time.

## Bug reports from the phone

A good mobile bug report includes the device model, OS version, app version, network type, steps, video and logs. Collecting all that by hand takes time, so there are SDKs you embed in the test build:

- **[Luciq (Instabug)](product:Luciq)**: shake the phone to send a bug with a screenshot, screen recording, logs and device data;
- **[Shake](product:Shake)**: a similar SDK for bug and crash reports.

Android logs are in Logcat ([Android Studio](product:Android Studio)); iOS logs are in Console on a Mac. Track bugs in [Jira](product:Jira) or another tracker.

## Network and API

Many mobile app bugs actually live in the interaction with the server. To see requests, route the phone through a proxy on your computer:

- **[Charles Proxy](product:Charles Proxy)**: the classic, with HTTPS interception, response rewriting and slow network simulation;
- **[Proxyman](product:Proxyman)**: a modern proxy with step-by-step iOS and Android setup;
- **[HTTP Toolkit](product:HTTP Toolkit)**: connects an Android device in one click.

By rewriting server responses you can easily check how the app handles an empty list, a 500 error or very long text. If the app uses SSL pinning, it is usually disabled in test builds. For testing the API itself, see [API testing](blog-post.php?slug=api-testing&hl=en).

## Automation

- **[Appium](product:Appium)** is the cross-platform standard: WebDriver-based tests for Android and iOS in several programming languages. It appears most often in job ads.
- **[Espresso](product:Espresso)** (Android) and **[XCTest / XCUITest](product:XCTest / XCUITest)** (iOS) are the native Google and Apple frameworks: fast and stable, but tests are written in the platform's language (Kotlin/Java or Swift), so developers often own them.
- **[Maestro](product:Maestro)** describes tests as short YAML steps and waits for elements by itself, the easiest start in mobile automation for a manual tester.
- **[Detox](product:Detox)** is for React Native apps; **[Patrol](product:Patrol)** is for Flutter and can tap system permission dialogs and work with notifications.
- Low-code and AI platforms: [Katalon](product:Katalon), [Testsigma](product:Testsigma), [mabl](product:mabl).

Run tests on emulators in CI ([GitHub Actions](product:GitHub Actions)) and on real devices in the clouds listed above. More in [Test automation tools](blog-post.php?slug=test-automation-tools&hl=en).

## Performance and stability

- **Launch time, smoothness, memory, battery.** Profilers are built into [Android Studio](product:Android Studio) and [Xcode](product:Xcode) (Instruments). **[Perfetto](product:Perfetto)** records a detailed trace of Android activity and shows why an app drops frames or starts slowly.
- **Crashes for real users.** **[Firebase Crashlytics](product:Firebase Crashlytics)** (free), **[Sentry](product:Sentry)** and **[Bugsnag](product:Bugsnag)** collect crashes, group them and show how many people are affected. Bugsnag also scores the stability of each release.
- **Server load.** A mobile app is only a client; whether the back end survives peak traffic is tested separately (see [Load testing](blog-post.php?slug=load-testing&hl=en)).

## Security

Mobile apps end up directly in an attacker's hands: an APK or IPA can be unpacked and examined. Basic checks from the OWASP Mobile Top 10: are passwords and tokens stored in plain text, are there API keys in the code, is the connection secure, does personal data leak into logs or app switcher screenshots?

- **[MobSF](product:MobSF)** automatically analyses an APK, AAB or IPA: risky permissions, hard-coded keys, weak cryptography. A good first step even without security experience.
- **[Frida](product:Frida)** lets you observe and change an app's behaviour at runtime, a tool for deeper pentesting.
- Traffic is checked with [Burp Suite](product:Burp Suite) or [ZAP](product:ZAP).

Only examine your own apps or apps you have permission to test. For the general principles, see [Security testing](blog-post.php?slug=security-testing&hl=en).

## Where to practise

- **[Sauce Labs My Demo App](product:Sauce Labs My Demo App)**: a demo shop for Android and iOS built specifically for manual and automated mobile testing;
- any app you use, for checklist and interruption exercises (without touching its servers);
- free courses at [Test Automation University](product:Test Automation University) and [Katalon Academy](product:Katalon Academy).

More practice sites in [Practice sites for testers](blog-post.php?slug=qa-practice-sites&hl=en).

## A one-month plan

| Week | What to do | Tools |
|---|---|---|
| 1 | Set up an emulator, run the checklist on a demo app, write bug reports with logs | [Android Studio](product:Android Studio), [Sauce Labs My Demo App](product:Sauce Labs My Demo App) |
| 2 | Interruptions, network and permissions on a real phone; screen recordings | [scrcpy](product:scrcpy), [Charles Proxy](product:Charles Proxy) |
| 3 | First YAML tests, then Appium | [Maestro](product:Maestro), [Appium](product:Appium) |
| 4 | Runs on cloud devices, crashes and basic security | [BrowserStack](product:BrowserStack), [Firebase Crashlytics](product:Firebase Crashlytics), [MobSF](product:MobSF) |

## AI in mobile testing

AI platforms such as [Testsigma](product:Testsigma) and [mabl](product:mabl) generate tests and fix them after UI changes, [Appetize.io](product:Appetize.io) gives AI agents access to cloud devices, and assistants like [GitHub Copilot](product:GitHub Copilot), [Cursor](product:Cursor) or [Claude Code](product:Claude Code) quickly write Maestro or Appium scenarios from a description. But deciding which devices and scenarios matter to your users, and checking how the app actually feels (smoothness, ease of use), remains a human job.

For more tools, read [Manual testing tools](blog-post.php?slug=manual-testing-tools&hl=en) and [Test automation tools](blog-post.php?slug=test-automation-tools&hl=en). All tools from this article are in the [Testing](subcategory:testing) and [Mobile Development](subcategory:mobile-development) subcategories.

## FAQ

**Can I test mobile apps without a phone?**
You can start: the Android emulator in [Android Studio](product:Android Studio) or [Genymotion](product:Genymotion) is free, and [Appetize.io](product:Appetize.io) gives you an iOS simulator in the browser. But before release, apps must be checked on real devices, your own or in the cloud.

**Do I need a Mac to test iOS?**
For the Xcode simulator and native XCUITest tests, yes. You can test manually on an iPhone via [TestFlight](product:TestFlight), and cloud services give access to iPhones from any computer.

**Appium or Maestro?**
Maestro is easier to start with and more stable thanks to automatic waiting. Appium is more flexible, supports several programming languages and is more often required in job ads.

**How many devices should I test on?**
Take the devices and OS versions that cover most of your users from analytics, add the oldest supported OS version and a low-end phone. Cover the rest with a device cloud.

**Not sure where to start?**
Ask [Elya](eli.php): she will pick tools for testing your app on Android, iOS or a cross-platform stack.

*Fact-check date: 4 November 2026. Service terms may change, so check them on the official websites.*
