-- =====================================================================
-- AI LAB HUB — міграція 2026-11-19 (№ 28): EN-тексти сторінок «Про проєкт», «Політика конфіденційності»,
-- «Умови використання» (українські — в app/translations.php). Ручний переклад, source = 'manual'.
-- Пункти з позначкою «ЧЕРНЕТКА» / «DRAFT» перекладено як є — остаточний текст погоджує юрист.
-- Лише INSERT … ON DUPLICATE KEY UPDATE у ui_translations; повторний запуск безпечний. Без DROP/DELETE/TRUNCATE.
-- =====================================================================

SET NAMES utf8mb4;

INSERT INTO ui_translations (key_name, lang, translated_text, source) VALUES
('about_title', 'en', 'About the project', 'manual'),
('about_intro', 'en', 'AI LAB HUB is a catalog of AI tools built to help anyone quickly find the right solution for their task without getting lost among hundreds of similar services.', 'manual'),
('about_mission', 'en', 'Our mission is simple: gather AI tools from around the world in one place, sort them into clear areas, and let you find the right solution in minutes — whether it is a one-off free task or a professional tool for everyday work.', 'manual'),
('about_features_h', 'en', 'What makes AI LAB HUB special:', 'manual'),
('about_feature_eli', 'en', 'Elya, our AI assistant, helps you pick exactly what you need by understanding your task and budget — instead of just showing a list of filters.', 'manual'),
('about_feature_honest', 'en', 'We do not show ratings or “inflated” scores — only an honest description of what each tool does.', 'manual'),
('about_feature_fresh', 'en', 'The catalog is regularly expanded and checked so that the information stays up to date.', 'manual'),
('about_free', 'en', 'The platform is free for users and always will be. We may receive an affiliate commission from some services listed in the catalog — this does not affect which tools get into the catalog or how they are described.', 'manual'),
('about_team_h', 'en', 'Who is behind the project', 'manual'),
('about_team_text', 'en', 'AI LAB HUB is created and maintained by Serena Milova — the owner, developer and administrator of the project.', 'manual'),
('about_contact', 'en', 'If you have a suggestion or a comment, or want to tell us about your AI product — write to us; the contacts are on the “Contacts” page.', 'manual'),
('legal_privacy_title', 'en', 'Privacy Policy', 'manual'),
('legal_stub_note', 'en', 'The full document will be added soon', 'manual'),
('legal_privacy_market_h', 'en', '3.1. Data in the Marketplace, courses and jobs sections', 'manual'),
('legal_privacy_market_text', 'en', 'If you publish a product in the Marketplace, a course, or a job as an employer, we may collect additional data: company name, contact details for communicating with candidates or buyers, and payment details for receiving payouts (where applicable). This data is used solely for the operation of the relevant section of the platform and is not shared with third parties, except where directly necessary to complete a transaction (for example, with a payment provider).', 'manual'),
('legal_privacy_donate_h', 'en', '3.2. Donations', 'manual'),
('legal_privacy_donate_text', 'en', 'Donations are transferred directly through the donor’s bank or payment service. Payment data (card number, account, payer’s name, etc.) is processed by the bank or payment service, not by the site: the site does not receive or store it.', 'manual'),
('legal_privacy_assets_h', 'en', '3.4. Digital assets and complaints — DRAFT', 'manual'),
('legal_privacy_assets_store', 'en', 'For “Digital assets” we store the original file privately (without a public address), its SHA-256 hash, a perceptual hash for finding similar images, the upload time, the author’s identifier and declarations (origin, rights). Capture metadata (EXIF/XMP/GPS) is not shown in public previews; in a file issued to another user under a license, the author’s metadata is replaced with information about the author, the license and the download number.', 'manual'),
('legal_privacy_assets_log', 'en', 'When an original is downloaded, we record the user, the asset, the time, the hash of the issued file and an anonymous hash of the IP address (not the address itself). To protect previews against mass copying, we keep a request log with an anonymous IP hash; entries are kept for up to 7 days, and the suspicious-activity log for as long as needed for review.', 'manual'),
('legal_privacy_assets_complaints', 'en', 'Copyright complaints contain the complainant’s name and contact details; we use them only to review the complaint and may tell the author of the asset what the complaint is about (without unnecessary personal data of the complainant, unless the procedure requires otherwise).', 'manual'),
('legal_privacy_updated', 'en', 'Last updated: October 11, 2026; section 3.4 (draft) — October 22, 2026; section 3.5 (cookies) — November 3, 2026, updated November 19, 2026.', 'manual'),
('legal_terms_title', 'en', 'Terms of Use', 'manual'),
('legal_terms_market_h', 'en', '3.1. Marketplace, courses and jobs', 'manual'),
('legal_terms_market_intro', 'en', 'The platform may provide access to additional sections: a marketplace of ready-made AI solutions, courses from third-party authors/companies, and a jobs section for employers in the AI field.', 'manual'),
('legal_terms_market_sellers', 'en', 'Regarding the Marketplace: sellers of ready-made solutions are solely responsible for the quality, legality and conformity of their goods/services with the stated description. The platform may charge a commission on transactions; its amount is shown separately at the time of purchase.', 'manual'),
('legal_terms_market_courses', 'en', 'Regarding courses: course authors are solely responsible for the content of their learning materials. The platform does not guarantee any particular learning outcome.', 'manual'),
('legal_terms_market_jobs', 'en', 'Regarding jobs: employers who post vacancies are solely responsible for the accuracy of the vacancy information and the employment terms. The platform is not a party to the employment relationship between the employer and the candidate and is not responsible for the employment terms.', 'manual'),
('legal_terms_donate_h', 'en', '3.2. Donations', 'manual'),
('legal_terms_donate_voluntary', 'en', 'You can support the project with a voluntary contribution (donation) using the details on the %s page. A donation is voluntary, free-of-charge support for the project; it is not payment for goods or services and does not give the donor any additional rights or advantages on the platform.', 'manual'),
('legal_terms_donate_no_refund', 'en', 'Donations are non-refundable.', 'manual'),
('legal_terms_donate_payments', 'en', 'The platform does not accept or process payments: the transfer is made directly through the donor’s bank or payment service. The platform does not receive or store donors’ payment data (card numbers, accounts, etc.).', 'manual'),
('legal_terms_assets_h', 'en', '3.4. Digital assets (images, illustrations, characters) — DRAFT', 'manual'),
('legal_terms_assets_own', 'en', 'You may publish only your own works or works you hold the rights to. It is prohibited to publish other people’s characters and brands (fan art of other franchises, logos, well-known characters) without the rights holder’s written permission, images of real people without their consent, and any images of minors in a dangerous or intimate context.', 'manual'),
('legal_terms_assets_origin', 'en', 'The author states the origin of the work (made by hand, with AI assistance, or fully by AI) and may not present AI-generated work as handmade. Legal protection of purely AI-generated images is limited or absent in many countries.', 'manual'),
('legal_terms_assets_license', 'en', 'By publishing an asset, the author grants the platform a non-exclusive, royalty-free right to store the file and show its preview on the site for the duration of the publication. Users receive rights to the asset only under the license chosen by the author and shown next to the preview; the platform is not a party to license agreements or to agreements between the author and the user.', 'manual'),
('legal_terms_assets_liability', 'en', 'The author is liable for infringing the rights of third parties. The platform may remove or hide assets, restrict publishing and block accounts for violations. Copyright complaints and counter-notices are handled under the %s; repeated violations lead to suspension of publishing.', 'manual'),
('legal_terms_assets_tech', 'en', 'The platform applies technical measures (private storage of originals, watermarked previews, a download log), but it is impossible to fully prevent copying of what is shown on screen — there is no guarantee of protection against copying.', 'manual'),
('legal_terms_updated', 'en', 'Last updated: October 11, 2026; section 3.4 (draft) — October 22, 2026.', 'manual'),
('legal_terms_donate_link', 'en', '“Support the project”', 'manual'),
('legal_terms_copyright_link', 'en', 'Copyright Policy', 'manual')
ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = 'manual';
