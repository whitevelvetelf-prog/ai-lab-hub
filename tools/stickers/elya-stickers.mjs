// AI LAB HUB — генератор стікерів «Еля» (SVG 200×200, прозорий фон, біла обвідка як у стікерів).
// Запуск: node tools/stickers/elya-stickers.mjs [--preview <file.html>]
// Результат: public/assets/stickers/elya/<id>.svg + (опційно) сторінка-превʼю.
// Персонаж — мультяшна Еля з відео сайту: біла кішка-сфінкс, великі вуха, блакитні очі, сріблястий жакет.
import { writeFileSync, mkdirSync } from 'node:fs';
import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = resolve(dirname(fileURLToPath(import.meta.url)), '../..');
const outDir = resolve(root, 'public/assets/stickers/elya');

const C = {
    line: '#3a3550', skin: '#f6f2f4', skinShade: '#e4dbe2', pinkIn: '#f4b6c6', nose: '#f08aa6',
    iris: '#3fa9ff', irisDark: '#1b6fd1', pupil: '#14183a', blush: '#ff9fbf',
    jacket: '#d7dce3', jacketShade: '#a9b1bd', top: '#efe3cf', accent: '#5b8cff',
    green: '#2fbf71', gold: '#f6c445', red: '#ff5d7a', purple: '#8b5cf6',
};
const S = (w = 2.6) => 'stroke="' + C.line + '" stroke-width="' + w + '" stroke-linejoin="round" stroke-linecap="round"';
const sw = S();

// ---------- частини персонажа ----------
const defs = `
<defs>
  <linearGradient id="jk" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="#eef1f5"/><stop offset=".55" stop-color="${C.jacket}"/><stop offset="1" stop-color="${C.jacketShade}"/></linearGradient>
  <radialGradient id="hd" cx=".45" cy=".35" r=".75"><stop offset="0" stop-color="#ffffff"/><stop offset=".7" stop-color="${C.skin}"/><stop offset="1" stop-color="${C.skinShade}"/></radialGradient>
  <radialGradient id="ir" cx=".5" cy=".45" r=".6"><stop offset="0" stop-color="#9fd6ff"/><stop offset=".55" stop-color="${C.iris}"/><stop offset="1" stop-color="${C.irisDark}"/></radialGradient>
  <filter id="st" x="-10%" y="-10%" width="120%" height="120%">
    <feMorphology in="SourceAlpha" operator="dilate" radius="4.5" result="d"/>
    <feFlood flood-color="#ffffff"/><feComposite in2="d" operator="in" result="w"/>
    <feGaussianBlur in="d" stdDeviation="2.2" result="b"/><feOffset in="b" dy="1.5" result="bo"/>
    <feFlood flood-color="#000" flood-opacity=".28"/><feComposite in2="bo" operator="in" result="sh"/>
    <feMerge><feMergeNode in="sh"/><feMergeNode in="w"/><feMergeNode in="SourceGraphic"/></feMerge>
  </filter>
</defs>`;

const body = `
  <path d="M36 192 C38 172 56 160 82 155 L118 155 C144 160 162 172 164 192 Q100 202 36 192 Z" fill="url(#jk)" ${sw}/>
  <path d="M86 156 L100 186 L114 156 Z" fill="${C.top}" ${sw}/>
  <path d="M82 155 L100 188 L94 197 M118 155 L100 188 L106 197" fill="none" ${sw}/>
  <path d="M90 138 L110 138 L114 157 Q100 166 86 157 Z" fill="${C.skin}" ${sw}/>`;

const ears = `
  <path d="M66 84 C56 62 50 40 52 22 C70 30 86 46 96 64 Z" fill="${C.skin}" ${sw}/>
  <path d="M68 74 C62 60 59 46 60 34 C71 41 81 51 88 63 Z" fill="${C.pinkIn}"/>
  <path d="M134 84 C144 62 150 40 148 22 C130 30 114 46 104 64 Z" fill="${C.skin}" ${sw}/>
  <path d="M132 74 C138 60 141 46 140 34 C129 41 119 51 112 63 Z" fill="${C.pinkIn}"/>`;

const head = `
  <path d="M100 56 C130 56 150 76 149 101 C148 122 130 144 100 146 C70 144 52 122 51 101 C50 76 70 56 100 56 Z" fill="url(#hd)" ${sw}/>
  <path d="M90 66 q10 -4 20 0 M88 73 q12 -5 24 0 M92 80 q8 -3 16 0" fill="none" stroke="#d9ccd6" stroke-width="2" stroke-linecap="round"/>`;

const cheeks = `<ellipse cx="70" cy="120" rx="8" ry="5" fill="${C.blush}" opacity=".55"/><ellipse cx="130" cy="120" rx="8" ry="5" fill="${C.blush}" opacity=".55"/>`;

const whiskers = `<g stroke="#b9b0bd" stroke-width="1.4" stroke-linecap="round" fill="none">
  <path d="M74 122 q-18 -4 -32 -2 M74 126 q-18 2 -30 8 M126 122 q18 -4 32 -2 M126 126 q18 2 30 8"/></g>`;

const nose = `<path d="M94 113 Q100 110 106 113 Q103 119 100 120 Q97 119 94 113 Z" fill="${C.nose}" ${sw}/>`;

// Очі
function eyeOpen(cx, dir, look = 0) {
    // мигдалеподібне око, нахил догори назовні
    const d = dir; // -1 ліве, 1 праве
    const outer = cx + 15 * d, inner = cx - 13 * d;
    return `<path d="M${inner} 101 Q${cx} 84 ${outer} 94 Q${cx + 2 * d} 113 ${inner} 101 Z" fill="url(#ir)" ${sw}/>
      <ellipse cx="${cx + 1 * d + look}" cy="99" rx="4.2" ry="8" fill="${C.pupil}"/>
      <circle cx="${cx - 3 + look}" cy="94" r="3" fill="#fff"/><circle cx="${cx + 4 + look}" cy="104" r="1.4" fill="#fff"/>`;
}
const EYES = {
    open: (l = 0) => eyeOpen(80, -1, l) + eyeOpen(120, 1, l),
    happy: () => `<path d="M68 101 Q80 88 93 100 M107 100 Q120 88 132 101" fill="none" ${S(3.4)}/>`,
    closed: () => `<path d="M68 99 Q80 108 93 99 M107 99 Q120 108 132 99" fill="none" ${S(3.2)}/>`,
    wink: () => eyeOpen(80, -1) + `<path d="M107 100 Q120 88 132 101" fill="none" ${S(3.4)}/>`,
    wide: () => `<g>${[80, 120].map(cx => `<ellipse cx="${cx}" cy="99" rx="13" ry="13" fill="url(#ir)" ${sw}/><circle cx="${cx}" cy="99" r="4.5" fill="${C.pupil}"/><circle cx="${cx - 4}" cy="94" r="3" fill="#fff"/>`).join('')}</g>`,
    heart: () => [80, 120].map(cx => `<path d="M${cx} 108 C${cx - 16} 98 ${cx - 12} 84 ${cx} 92 C${cx + 12} 84 ${cx + 16} 98 ${cx} 108 Z" fill="${C.red}" ${sw}/>`).join(''),
    sad: () => eyeOpen(80, -1) + eyeOpen(120, 1) + `<path d="M66 90 L88 83 M134 90 L112 83" fill="none" ${sw}/>`,
    side: () => EYES.open(4),
    stars: () => [80, 120].map(cx => star(cx, 99, 12, C.gold)).join(''),
};
function star(cx, cy, r, fill) {
    let p = '';
    for (let i = 0; i < 10; i++) {
        const a = -Math.PI / 2 + i * Math.PI / 5, rr = i % 2 ? r * 0.45 : r;
        p += (i ? 'L' : 'M') + (cx + rr * Math.cos(a)).toFixed(1) + ' ' + (cy + rr * Math.sin(a)).toFixed(1) + ' ';
    }
    return `<path d="${p}Z" fill="${fill}" ${S(2)}/>`;
}
// Рот
const MOUTH = {
    smile: `<path d="M100 120 Q94 128 87 124 M100 120 Q106 128 113 124" fill="none" ${sw}/>`,
    big: `<path d="M88 123 Q100 140 112 123 Z" fill="#c2405f" ${sw}/><path d="M93 130 Q100 136 107 130" fill="#ff8fab"/>`,
    o: `<ellipse cx="100" cy="129" rx="5" ry="6.5" fill="#c2405f" ${sw}/>`,
    flat: `<path d="M92 126 L108 126" fill="none" ${sw}/>`,
    sad: `<path d="M90 130 Q100 121 110 130" fill="none" ${sw}/>`,
    tongue: `<path d="M100 120 Q94 128 87 124 M100 120 Q106 128 113 124" fill="none" ${sw}/><path d="M101 125 Q103 134 108 132 Q110 127 107 124" fill="#ff8fab" ${S(2)}/>`,
    cat: `<path d="M100 120 Q95 127 90 124 M100 120 Q105 127 110 124" fill="none" ${sw}/>`,
};

// ---------- реквізит ----------
const paw = (x, y, r = 13) => `<g><ellipse cx="${x}" cy="${y}" rx="${r}" ry="${r * 0.92}" fill="${C.skin}" ${sw}/>
  <ellipse cx="${x}" cy="${y + 3}" rx="${r * 0.42}" ry="${r * 0.34}" fill="${C.pinkIn}"/>
  ${[-0.55, 0, 0.55].map(k => `<circle cx="${(x + k * r).toFixed(1)}" cy="${(y - r * 0.42 + Math.abs(k) * 3).toFixed(1)}" r="${(r * 0.17).toFixed(1)}" fill="${C.pinkIn}"/>`).join('')}</g>`;
const sleeveR = (x2, y2) => `<path d="M146 176 C156 160 ${x2 - 6} ${y2 + 26} ${x2 - 8} ${y2 + 10} L${x2 + 10} ${y2 + 8} C${x2 + 12} ${y2 + 30} 168 168 162 186 Z" fill="url(#jk)" ${sw}/>`;
const sleeveL = (x2, y2) => `<path d="M54 176 C44 160 ${x2 + 6} ${y2 + 26} ${x2 + 8} ${y2 + 10} L${x2 - 10} ${y2 + 8} C${x2 - 12} ${y2 + 30} 32 168 38 186 Z" fill="url(#jk)" ${sw}/>`;
const wave = `${sleeveR(166, 118)}${paw(166, 112)}<path d="M184 96 q6 6 4 14 M190 90 q9 9 6 22" fill="none" stroke="${C.accent}" stroke-width="3" stroke-linecap="round"/>`;
const thumb = `${sleeveR(164, 124)}<rect x="150" y="112" width="28" height="24" rx="11" fill="${C.skin}" ${sw}/>
  <path d="M156 114 C154 102 158 92 166 92 C170 92 170 100 168 112" fill="${C.skin}" ${sw}/><path d="M152 122 L176 122 M152 129 L176 129" stroke="#d9ccd6" stroke-width="2"/>`;
const badge = (x, y, r, fill, inner) => `<circle cx="${x}" cy="${y}" r="${r}" fill="${fill}" ${sw}/>${inner}`;
const check = (x, y, r = 18) => badge(x, y, r, C.green, `<path d="M${x - r * 0.45} ${y} l${r * 0.3} ${r * 0.32} l${r * 0.55} ${-r * 0.6}" fill="none" stroke="#fff" stroke-width="5" stroke-linecap="round" stroke-linejoin="round"/>`);
const heartP = (x, y, s = 1, fill = C.red) => `<path transform="translate(${x} ${y}) scale(${s})" d="M0 10 C-16 0 -12 -14 0 -6 C12 -14 16 0 0 10 Z" fill="${fill}" ${sw}/>`;
const coin = (x, y) => `<circle cx="${x}" cy="${y}" r="17" fill="${C.gold}" ${sw}/><circle cx="${x}" cy="${y}" r="11.5" fill="none" stroke="#d99a1e" stroke-width="2"/><text x="${x}" y="${y + 6}" text-anchor="middle" font-family="Arial, sans-serif" font-weight="700" font-size="17" fill="#8a5a00">₴</text>`;
const box = (x, y) => `<path d="M${x - 22} ${y - 8} L${x} ${y - 18} L${x + 22} ${y - 8} L${x + 22} ${y + 18} L${x} ${y + 28} L${x - 22} ${y + 18} Z" fill="#d9a066" ${sw}/>
  <path d="M${x - 22} ${y - 8} L${x} ${y + 2} L${x + 22} ${y - 8} M${x} ${y + 2} L${x} ${y + 28}" fill="none" ${sw}/><path d="M${x - 11} ${y - 13} L${x + 11} ${y - 3}" stroke="#b97a3e" stroke-width="4"/>`;
const hourglass = (x, y) => `<path d="M${x - 13} ${y - 20} L${x + 13} ${y - 20} L${x + 13} ${y - 15} Q${x + 13} ${y - 4} ${x + 3} ${y} Q${x + 13} ${y + 4} ${x + 13} ${y + 15} L${x + 13} ${y + 20} L${x - 13} ${y + 20} L${x - 13} ${y + 15} Q${x - 13} ${y + 4} ${x - 3} ${y} Q${x - 13} ${y - 4} ${x - 13} ${y - 15} Z" fill="#cfe8ff" ${sw}/>
  <path d="M${x - 8} ${y + 16} L${x + 8} ${y + 16} L${x} ${y + 6} Z M${x - 6} ${y - 12} L${x + 6} ${y - 12} L${x} ${y - 5} Z" fill="${C.gold}"/><path d="M${x - 17} ${y - 21} L${x + 17} ${y - 21} M${x - 17} ${y + 21} L${x + 17} ${y + 21}" ${S(4)}/>`;
const qmark = (x, y, fill = C.accent) => `<text x="${x}" y="${y}" text-anchor="middle" font-family="Arial Black, Arial, sans-serif" font-weight="900" font-size="38" fill="${fill}" stroke="${C.line}" stroke-width="2" paint-order="stroke">?</text>`;
const emark = (x, y, fill = C.gold) => `<text x="${x}" y="${y}" text-anchor="middle" font-family="Arial Black, Arial, sans-serif" font-weight="900" font-size="38" fill="${fill}" stroke="${C.line}" stroke-width="2" paint-order="stroke">!</text>`;
const phone = (x, y) => `<rect x="${x - 11}" y="${y - 19}" width="22" height="38" rx="5" fill="#2c2f4a" ${sw}/><rect x="${x - 8}" y="${y - 14}" width="16" height="25" rx="2" fill="#7cc4ff"/><circle cx="${x}" cy="${y + 15}" r="1.8" fill="#fff"/>
  <path d="M${x + 16} ${y - 18} q6 5 0 12 M${x + 21} ${y - 23} q11 10 0 22" fill="none" stroke="${C.accent}" stroke-width="3" stroke-linecap="round"/>`;
const laptop = `<path d="M44 168 L156 168 L166 196 L34 196 Z" fill="#c9ced6" ${sw}/><path d="M56 132 L144 132 L150 170 L50 170 Z" fill="#9aa3ad" ${sw}/><circle cx="100" cy="151" r="5" fill="#eef1f5"/>`;
const sweat = `<path d="M142 78 Q150 92 142 96 Q134 92 142 78 Z" fill="#8fd0ff" ${S(2)}/>`;
const tear = `<path d="M70 108 Q76 122 70 126 Q64 122 70 108 Z" fill="#8fd0ff" ${S(2)}/>`;
const sparkles = `${star(30, 60, 9, C.gold)}${star(172, 52, 7, C.gold)}${star(178, 92, 5, C.gold)}`;
const pawChin = `${paw(88, 146, 12)}`;
const pawsChest = `${paw(82, 166, 12)}${paw(118, 166, 12)}`;
const laughTears = `<path d="M62 96 q-8 6 -10 14 M138 96 q8 6 10 14" fill="none" stroke="#8fd0ff" stroke-width="4" stroke-linecap="round"/>`;
const zz = `<text x="150" y="64" font-family="Arial Black, Arial" font-weight="900" font-size="20" fill="${C.purple}" stroke="#fff" stroke-width="3" paint-order="stroke">z</text><text x="164" y="46" font-family="Arial Black, Arial" font-weight="900" font-size="26" fill="${C.purple}" stroke="#fff" stroke-width="3" paint-order="stroke">Z</text>`;

// ---------- набір ----------
// id, підпис UA / EN (у чаті — під стікером, мовою сторінки), очі, рот, реквізит перед / після голови
export const STICKERS = [
    { id: 'hello', uk: 'Привіт!', en: 'Hi!', eyes: 'happy', mouth: 'big', front: wave },
    { id: 'thanks', uk: 'Дякую!', en: 'Thank you!', eyes: 'closed', mouth: 'smile', front: pawsChest + heartP(40, 70, 1.2) + heartP(164, 64, 0.9) + heartP(150, 100, 0.6) },
    { id: 'agreed', uk: 'Домовились!', en: 'Deal!', eyes: 'happy', mouth: 'smile', front: thumb },
    { id: 'ok', uk: 'Так, згодна', en: 'Yes, agreed', eyes: 'open', mouth: 'smile', front: check(160, 70) },
    { id: 'paid', uk: 'Оплачено', en: 'Paid', eyes: 'happy', mouth: 'big', front: coin(160, 122) + check(42, 70, 15) },
    { id: 'sent', uk: 'Відправлено', en: 'Sent', eyes: 'open', mouth: 'smile', front: box(158, 124) },
    { id: 'received', uk: 'Отримала!', en: 'Got it!', eyes: 'stars', mouth: 'big', front: box(158, 124) + heartP(166, 84, 0.9) },
    { id: 'wait', uk: 'Хвилинку…', en: 'One moment…', eyes: 'side', mouth: 'flat', front: hourglass(160, 120) },
    { id: 'thinking', uk: 'Подумаю', en: 'Let me think', eyes: 'side', mouth: 'cat', front: pawChin + `<circle cx="152" cy="74" r="4" fill="#fff" ${S(2)}/><circle cx="162" cy="60" r="6" fill="#fff" ${S(2)}/>` + qmark(172, 46) },
    { id: 'question', uk: 'Є питання', en: 'I have a question', eyes: 'open', mouth: 'o', front: qmark(162, 70) + qmark(40, 74, C.purple) },
    { id: 'wow', uk: 'Вау!', en: 'Wow!', eyes: 'wide', mouth: 'o', front: emark(160, 70) + sparkles },
    { id: 'love', uk: 'Чудово!', en: 'Awesome!', eyes: 'heart', mouth: 'big', front: heartP(40, 64, 1) + heartP(164, 60, 1.1) },
    { id: 'haha', uk: 'Ха-ха!', en: 'Haha!', eyes: 'happy', mouth: 'big', front: laughTears },
    { id: 'sorry', uk: 'Вибачте', en: 'Sorry', eyes: 'sad', mouth: 'sad', front: tear + sweat },
    { id: 'working', uk: 'Працюю', en: 'Working on it', eyes: 'open', mouth: 'flat', front: laptop + `<path d="M150 70 l6 -8 M160 78 l9 -3 M146 60 l1 -10" stroke="${C.gold}" stroke-width="3" stroke-linecap="round"/>` },
    { id: 'call', uk: 'Зателефоную', en: "I'll call you", eyes: 'wink', mouth: 'smile', front: phone(160, 120) },
    { id: 'bye', uk: 'До зв’язку!', en: 'Talk soon!', eyes: 'wink', mouth: 'tongue', front: wave },
    { id: 'sleepy', uk: 'Завтра відповім', en: "I'll reply tomorrow", eyes: 'closed', mouth: 'cat', front: zz },
];

export function stickerSvg(s) {
    const eyes = (EYES[s.eyes] || EYES.open)();
    const mouth = MOUTH[s.mouth] || MOUTH.smile;
    return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="-10 -10 220 220" width="220" height="220" role="img" aria-label="Еля: ${s.uk}">${defs}
<g filter="url(#st)">${body}${ears}${head}${cheeks}${eyes}${nose}${mouth}${s.front || ''}</g>${whiskers}</svg>\n`;
}

mkdirSync(outDir, { recursive: true });
for (const s of STICKERS) {
    writeFileSync(resolve(outDir, s.id + '.svg'), stickerSvg(s));
}
const pi = process.argv.indexOf('--preview');
if (pi > 0) {
    const cells = STICKERS.map(s => `<figure><img src="file:///${outDir.replace(/\\/g, '/')}/${s.id}.svg" width="160" height="160" alt=""><figcaption>${s.uk}<br><small>${s.id}</small></figcaption></figure>`).join('');
    writeFileSync(process.argv[pi + 1], `<!doctype html><meta charset="utf-8"><title>Еля — стікери</title>
<style>body{font-family:Arial;margin:0;padding:16px;display:grid;grid-template-columns:1fr 1fr;gap:12px}
section{padding:12px;border-radius:12px;display:flex;flex-wrap:wrap;gap:8px}figure{margin:0;text-align:center;width:170px}figcaption{font-size:13px}
.d{background:#00032c;color:#fff}.l{background:#f3f4f8}</style><section class="d">${cells}</section><section class="l">${cells}</section>`);
}
console.log(STICKERS.length + ' stickers → ' + outDir);
