/*
 * AI LAB HUB — автозбереження чернетки форми подачі оголошення (app/mp-drafts.php, public/mp-draft.php).
 * Форма з атрибутом data-draft-key: через 1,5 с після введення і при закритті/згортанні сторінки поля
 * надсилаються на сервер. Якщо сервер передав збережену чернетку (script[data-draft-json]) і форма ще
 * порожня — поля заповнюються з неї. Файли (фото) не зберігаються.
 */
(function () {
  'use strict';
  var form = document.querySelector('form[data-draft-key]');
  if (!form || !window.fetch || !window.FormData) {
    return;
  }
  var key = form.getAttribute('data-draft-key');
  var url = form.getAttribute('data-draft-url') || 'mp-draft.php';
  var statusEl = document.querySelector('[data-draft-status]');
  var csrfEl = form.querySelector('input[name="csrf"]');
  var SKIP = { csrf: 1, ft: 1, website: 1, form_key: 1 };
  var timer = null;
  var lastSent = '';
  var dirty = false;

  function collect() {
    var out = {};
    var fd = new FormData(form);
    fd.forEach(function (value, name) {
      if (SKIP[name] || typeof value !== 'string') {
        return;   // службові поля й файли
      }
      if (/\[\]$/.test(name)) {
        (out[name] = out[name] || []).push(value);
      } else {
        out[name] = value;
      }
    });
    return out;
  }

  function hasContent(data) {
    return ['title', 'short_desc', 'full_desc', 'company_name', 'url'].some(function (k) {
      return typeof data[k] === 'string' && data[k].trim() !== '';
    });
  }

  function say(text) {
    if (statusEl) {
      statusEl.textContent = text || '';
    }
  }

  function body(data, action) {
    var fd = new FormData();
    fd.append('csrf', csrfEl ? csrfEl.value : '');
    fd.append('form_key', key);
    fd.append('action', action || 'save');
    if (data) {
      fd.append('data', JSON.stringify(data));
    }
    return fd;
  }

  function save(useBeacon) {
    var data = collect();
    var json = JSON.stringify(data);
    if (!hasContent(data) || json === lastSent) {
      return;
    }
    lastSent = json;
    dirty = false;
    if (useBeacon && navigator.sendBeacon) {
      navigator.sendBeacon(url, body(data));
      return;
    }
    say(form.getAttribute('data-draft-saving'));
    fetch(url, { method: 'POST', body: body(data), credentials: 'same-origin' })
      .then(function (r) { return r.json(); })
      .then(function (j) {
        say(j && j.ok ? form.getAttribute('data-draft-saved') + (j.saved_at ? ' · ' + j.saved_at : '') : '');
      })
      .catch(function () { lastSent = ''; say(''); });
  }

  function schedule() {
    dirty = true;
    clearTimeout(timer);
    timer = setTimeout(function () { save(false); }, 1500);
  }

  // --- Відновлення --------------------------------------------------------
  function restore(data) {
    Object.keys(data).forEach(function (name) {
      var fields = form.querySelectorAll('[name="' + name.replace(/"/g, '') + '"]');
      var val = data[name];
      var list = Array.isArray(val) ? val : [val];
      Array.prototype.forEach.call(fields, function (el) {
        if (el.type === 'file' || el.type === 'hidden' || SKIP[name]) {
          return;
        }
        if (el.type === 'checkbox' || el.type === 'radio') {
          el.checked = list.indexOf(el.value) !== -1;
        } else if (!Array.isArray(val)) {
          el.value = val;
        }
        el.dispatchEvent(new Event('change', { bubbles: true }));
      });
    });
  }

  var draftJson = document.querySelector('script[data-draft-json]');
  if (draftJson) {
    try {
      var saved = JSON.parse(draftJson.textContent || '{}');
      if (!hasContent(collect())) {
        restore(saved);
        lastSent = JSON.stringify(collect());
        var note = document.querySelector('[data-draft-restored]');
        if (note) {
          note.hidden = false;
        }
      }
    } catch (e) { /* пошкоджена чернетка — ігноруємо */ }
  }

  var discard = document.querySelector('[data-draft-discard]');
  if (discard) {
    discard.addEventListener('click', function () {
      fetch(url, { method: 'POST', body: body(null, 'delete'), credentials: 'same-origin' })
        .finally(function () { window.location.reload(); });
    });
  }

  form.addEventListener('input', schedule);
  form.addEventListener('change', schedule);
  form.addEventListener('submit', function () { clearTimeout(timer); dirty = false; });
  document.addEventListener('visibilitychange', function () {
    if (document.visibilityState === 'hidden' && dirty) {
      save(true);
    }
  });
  window.addEventListener('pagehide', function () {
    if (dirty) {
      save(true);
    }
  });
})();
