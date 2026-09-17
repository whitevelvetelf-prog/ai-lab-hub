<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Донат.
 */

require_once __DIR__ . '/../app/translations.php';

$cardNumber = '4874 1000 3303 1223';
$monobankUrl = 'https://send.monobank.ua/jar/43D5XGBFyP';

?>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AI LAB HUB — Донат</title>
    <style>
        *,
        *::before,
        *::after {
            box-sizing: border-box;
        }

        :root {
            --bg-start: #00032c;
            --bg-end: #2116ad;
            --card-bg: rgba(255, 255, 255, 0.05);
            --card-border: rgba(255, 255, 255, 0.14);
            --text-muted: rgba(255, 255, 255, 0.75);
            --accent: #5b8cff;
        }

        html,
        body {
            margin: 0;
            padding: 0;
        }

        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            font-family: "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            color: #ffffff;
            background: linear-gradient(160deg, var(--bg-start) 0%, var(--bg-end) 100%);
            background-attachment: fixed;
            line-height: 1.6;
        }

        .site-header {
            display: flex;
            align-items: center;
            padding: 20px 32px;
        }

        .site-header__brand {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
            color: #ffffff;
        }

        .site-header__logo {
            height: 42px;
            width: auto;
            display: block;
            border-radius: 10px;
        }

        .page {
            flex: 1;
            width: 100%;
            max-width: 640px;
            margin: 0 auto;
            padding: 48px 24px 64px;
        }

        .stub__title {
            margin: 0 0 12px;
            font-size: clamp(1.8rem, 5vw, 2.6rem);
            font-weight: 800;
            letter-spacing: 0.02em;
        }

        .stub__text {
            margin: 0 0 18px;
            font-size: 1.05rem;
            color: var(--text-muted);
        }

        .donate-card {
            margin-top: 28px;
            padding: 28px;
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .donate-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            width: 100%;
            padding: 16px 24px;
            border-radius: 999px;
            font-size: 1.05rem;
            font-weight: 700;
            text-decoration: none;
            color: #00032c;
            background: linear-gradient(135deg, #5b8cff, #a5c0ff);
            box-shadow: 0 6px 18px rgba(91, 140, 255, 0.4);
            transition: background 0.15s ease;
        }

        .donate-btn:hover {
            background: linear-gradient(135deg, #6f9bff, #b8ceff);
        }

        .donate-divider {
            display: flex;
            align-items: center;
            gap: 14px;
            margin: 28px 0 20px;
            color: var(--text-muted);
            font-size: 0.9rem;
        }

        .donate-divider::before,
        .donate-divider::after {
            content: "";
            flex: 1;
            height: 1px;
            background: var(--card-border);
        }

        .donate-alt__label {
            margin: 0 0 10px;
            font-size: 0.98rem;
            color: var(--text-muted);
        }

        .donate-card-number {
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
        }

        .donate-card-number__value {
            font-size: 1.15rem;
            font-weight: 700;
            letter-spacing: 0.03em;
            font-variant-numeric: tabular-nums;
        }

        .donate-copy-btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 8px 16px;
            border-radius: 999px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            background: transparent;
            color: #ffffff;
            font-size: 0.9rem;
            font-weight: 600;
            font-family: inherit;
            cursor: pointer;
            transition: background 0.15s ease, border-color 0.15s ease;
        }

        .donate-copy-btn:hover {
            background: rgba(255, 255, 255, 0.1);
            border-color: rgba(255, 255, 255, 0.5);
        }

        .donate-copy-btn.is-copied {
            background: rgba(91, 140, 255, 0.25);
            border-color: #5b8cff;
        }

        .donate-copy-btn svg {
            width: 16px;
            height: 16px;
        }
    </style>
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <header class="site-header">
        <a class="site-header__brand" href="index.php">
            <img class="site-header__logo" src="/logo.png" alt="AI LAB HUB">
        </a>
    </header>

    <main class="page">
        <h1 class="stub__title">Донат на AI LAB HUB</h1>

        <p class="stub__text">Дякуємо за вашу підтримку! Ваш внесок допомагає AI LAB HUB розвиватися, наповнюватися корисними AI-інструментами та ставати кращим для всіх, хто ним користується. Кожен внесок має значення. Дякуємо, що допомагаєте нам рухатися вперед.</p>

        <div class="donate-card">
            <a class="donate-btn" href="<?= htmlspecialchars($monobankUrl, ENT_QUOTES) ?>" target="_blank" rel="noopener">Задонатити</a>

            <div class="donate-divider">Або переказом на картку</div>

            <p class="donate-alt__label">Банки:</p>
            <div class="donate-card-number">
                <span class="donate-card-number__value" id="cardNumber"><?= htmlspecialchars($cardNumber, ENT_QUOTES) ?></span>
                <button type="button" class="donate-copy-btn" id="copyCardBtn" data-card="<?= htmlspecialchars($cardNumber, ENT_QUOTES) ?>">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect width="14" height="14" x="8" y="8" rx="2" ry="2"/><path d="M4 16c-1.1 0-2-.9-2-2V4c0-1.1.9-2 2-2h10c1.1 0 2 .9 2 2"/></svg>
                    <span id="copyCardBtnLabel">Скопіювати</span>
                </button>
            </div>
        </div>
    </main>

    <?php include __DIR__ . '/../app/footer.php'; ?>

    <script>
        (function () {
            var btn = document.getElementById('copyCardBtn');
            var label = document.getElementById('copyCardBtnLabel');
            if (!btn || !label) {
                return;
            }
            var defaultLabel = label.textContent;

            btn.addEventListener('click', function () {
                var value = btn.getAttribute('data-card') || '';

                function onCopied() {
                    btn.classList.add('is-copied');
                    label.textContent = 'Скопійовано!';
                    setTimeout(function () {
                        btn.classList.remove('is-copied');
                        label.textContent = defaultLabel;
                    }, 2000);
                }

                if (navigator.clipboard && navigator.clipboard.writeText) {
                    navigator.clipboard.writeText(value).then(onCopied, function () {
                        fallbackCopy(value, onCopied);
                    });
                } else {
                    fallbackCopy(value, onCopied);
                }
            });

            function fallbackCopy(value, done) {
                var scrollX = window.scrollX;
                var scrollY = window.scrollY;

                var input = document.createElement('textarea');
                input.value = value;
                input.style.position = 'fixed';
                input.style.top = scrollY + 'px';
                input.style.left = '0';
                input.style.opacity = '0';
                document.body.appendChild(input);
                input.focus();
                input.select();
                try {
                    document.execCommand('copy');
                } catch (e) {
                    /* ignore */
                }
                document.body.removeChild(input);
                window.scrollTo(scrollX, scrollY);
                done();
            }
        })();
    </script>
</body>
</html>
