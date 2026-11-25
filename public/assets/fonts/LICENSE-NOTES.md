# Шрифти гри «Багвіль» (самохостинг)

Сцени Розділу 1 (`public/assets/css/bugville.css`, клас `.bvs`) використовують два шрифти з прототипу
`docs/bugville/prototype/bugville_prototype_avtomat.html`. У прототипі вони підключалися з Google Fonts; у грі —
лише локальні файли з цієї папки (`bugville/`), без запитів до сторонніх доменів (Політика конфіденційності:
у першому розділі немає трекерів і сторонніх запитів).

| Шрифт | Накреслення | Підмножини | Файли |
|---|---|---|---|
| Nunito | 400, 600, 800 | cyrillic, latin | `bugville/nunito-{cyrillic,latin}-{400,600,800}-normal.woff2` |
| Rubik | 500, 700, 800 | cyrillic, latin | `bugville/rubik-{cyrillic,latin}-{500,700,800}-normal.woff2` |

## Ліцензія

Обидва шрифти — **SIL Open Font License 1.1** (OFL). Ліцензія дозволяє вільно використовувати, вбудовувати й
розповсюджувати шрифти, зокрема розміщувати їх на власному сервері для вебсторінок; не можна лише продавати самі
файли шрифтів окремо. Повні тексти ліцензій лежать поруч із файлами:

- `bugville/OFL-nunito.txt` — Copyright 2014 The Nunito Project Authors (https://github.com/googlefonts/nunito)
- `bugville/OFL-rubik.txt` — Copyright 2015 The Rubik Project Authors (https://github.com/googlefonts/rubik)

Тексти ліцензій узято з репозиторію Google Fonts: `https://github.com/google/fonts/tree/main/ofl/nunito` і
`https://github.com/google/fonts/tree/main/ofl/rubik`.

## Джерело файлів

Файли woff2 — збірка Fontsource (ті самі шрифти Google Fonts, розбиті на підмножини), пакети npm
`@fontsource/nunito@5.1.0` і `@fontsource/rubik@5.1.0`, завантажено 2026-11-25 з
`https://cdn.jsdelivr.net/npm/@fontsource/<шрифт>@5.1.0/files/`. Файли не змінювалися. Шрифти перейменовано лише
в CSS (`"BV Nunito"`, `"BV Rubik"`), щоб не плутати з установленими в системі; назви файлів оригінальні.
