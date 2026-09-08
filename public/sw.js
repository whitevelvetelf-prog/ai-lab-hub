// AI LAB HUB — базовий Service Worker
// Мета: (1) дозволити браузеру пропонувати "Додати на головний екран",
// (2) кешувати статичні файли для швидшого повторного відкриття.
// Це НЕ офлайн-режим для всього сайту — сторінки з БД (каталог, CRM, Еля)
// завжди йдуть напряму в мережу.

const CACHE_NAME = 'ailabhub-static-v2';

// Додайте сюди реальні шляхи до логотипу/CSS/іконок, які рідко змінюються
const STATIC_ASSETS = [
  '/icons/icon-192.png',
  '/icons/icon-512.png',
  '/manifest.json'
];

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => cache.addAll(STATIC_ASSETS))
  );
  self.skipWaiting();
});

self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((keys) =>
      Promise.all(
        keys.filter((key) => key !== CACHE_NAME).map((key) => caches.delete(key))
      )
    )
  );
  self.clients.claim();
});

self.addEventListener('fetch', (event) => {
  // Кешуємо тільки статику (icons/manifest). Усе інше (сторінки, CRM, Еля,
  // AJAX-запити до БД) завжди йде напряму в мережу — не чіпаємо.
  const url = new URL(event.request.url);
  const isStatic = STATIC_ASSETS.some((path) => url.pathname === path);

  if (isStatic) {
    event.respondWith(
      caches.match(event.request).then((cached) => cached || fetch(event.request))
    );
  }
});
