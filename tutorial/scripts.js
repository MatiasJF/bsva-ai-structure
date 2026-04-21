/* BSVA AI Guided Tour — scripts.js (v2)
 * - Loads section partials via fetch (requires HTTP server; graceful file:// fallback).
 * - Renders progress dots in the topbar.
 * - Handles keyboard nav, localStorage progress, theme, checklist, cycle-orbit positioning.
 */

(() => {
  'use strict';

  const STORAGE_KEY_PROGRESS  = 'bsva-tutorial-progress-v1';
  const STORAGE_KEY_THEME     = 'bsva-tutorial-theme-v1';
  const STORAGE_KEY_CHECKLIST = 'bsva-tutorial-checklist-v1';
  const STORAGE_KEY_DEPT      = 'bsva-tutorial-dept-v1';

  // Section catalog — labels are used for nav tooltips
  const SECTIONS = [
    { id: '01-welcome',           label: '1. Welcome' },
    { id: '02-install-recap',     label: '2. Install recap' },
    { id: '03-architecture',      label: '3. Architecture' },
    { id: '04-the-cycle',         label: '4. The cycle' },
    { id: '05-before-you-paste',  label: '5. Before you paste' },
    { id: '06-nest-vs-tension',   label: '6. Nest vs tension' },
    { id: '07-choose-department', label: '7. Choose department' },
    // dept sections inserted dynamically
    { id: '09-first-session',     label: '9. First session' },
    { id: '10-checklist',         label: '10. Checklist' },
  ];
  const DEPT_SECTIONS = {
    devrel:     { id: '08-dept-devrel',     label: '8. DevRel' },
    tech:       { id: '08-dept-tech',       label: '8. Technology' },
    education:  { id: '08-dept-education',  label: '8. Education' },
    operations: { id: '08-dept-operations', label: '8. Operations' },
  };

  const state = {
    current: null,
    visited: new Set(),
    mermaidLoaded: false,
  };

  // ── utils ───────────────────────────────────────────────────
  const $  = (sel, root = document) => root.querySelector(sel);
  const $$ = (sel, root = document) => Array.from(root.querySelectorAll(sel));
  const loadJSON = (k, fb) => { try { const v = localStorage.getItem(k); return v ? JSON.parse(v) : fb; } catch { return fb; } };
  const saveJSON = (k, v)  => { try { localStorage.setItem(k, JSON.stringify(v)); } catch {} };

  function orderedSections() {
    const dept = loadJSON(STORAGE_KEY_DEPT, null);
    const list = [...SECTIONS];
    if (dept && DEPT_SECTIONS[dept]) {
      list.splice(7, 0, { ...DEPT_SECTIONS[dept], indent: true });
    }
    return list;
  }

  // ── progress dots ───────────────────────────────────────────
  function renderDots() {
    const dotsEl = $('#progress-dots');
    dotsEl.innerHTML = '';
    const list = orderedSections();
    list.forEach((s, i) => {
      const btn = document.createElement('button');
      btn.className = 'dot' + (s.indent ? ' indent' : '');
      btn.dataset.section = s.id;
      btn.setAttribute('aria-label', s.label);
      btn.title = s.label;
      if (state.visited.has(s.id)) btn.classList.add('visited');
      if (state.current === s.id)  btn.classList.add('active');
      btn.addEventListener('click', () => loadSection(s.id));
      dotsEl.appendChild(btn);
    });
  }

  // ── section loading ─────────────────────────────────────────
  async function loadSection(id) {
    const content = $('#content');
    content.classList.remove('section-enter');
    // force reflow to replay animation
    void content.offsetWidth;
    content.innerHTML = '<div class="loading">Loading…</div>';

    try {
      const res = await fetch(`sections/${id}.html`, { cache: 'no-cache' });
      if (!res.ok) throw new Error('HTTP ' + res.status);
      const html = await res.text();
      content.innerHTML = html;
      content.classList.add('section-enter');
      state.current = id;
      state.visited.add(id);
      saveJSON(STORAGE_KEY_PROGRESS, [...state.visited]);
      renderDots();
      updateNavButtons();
      await runSectionHooks(id);
      window.scrollTo({ top: 0, behavior: 'instant' });
      if (location.hash !== `#${id}`) history.replaceState(null, '', `#${id}`);
    } catch (err) {
      if (location.protocol === 'file:') {
        const tpl = $('#file-protocol-template');
        content.innerHTML = '';
        content.appendChild(tpl.content.cloneNode(true));
      } else {
        content.innerHTML = `<div class="error-card"><h2>Couldn't load section</h2><p>${err.message}</p></div>`;
      }
    }
  }

  function updateNavButtons() {
    const list = orderedSections();
    const idx = list.findIndex(s => s.id === state.current);
    $('#prev-btn').disabled = idx <= 0;
    $('#next-btn').disabled = idx >= list.length - 1;
  }

  function goTo(offset) {
    const list = orderedSections();
    const idx = list.findIndex(s => s.id === state.current);
    if (idx === -1) return;
    const nextIdx = idx + offset;
    if (nextIdx < 0 || nextIdx >= list.length) return;
    loadSection(list[nextIdx].id);
  }

  // ── section hooks ──────────────────────────────────────────
  async function runSectionHooks(id) {
    const content = $('#content');
    if ($('.mermaid', content)) await ensureMermaid();
    if (id === '04-the-cycle')           wireOrbit();
    if (id === '07-choose-department')   wireDepartmentPicker();
    if (id === '10-checklist')           wireChecklist();
    wireCopyButtons();
  }

  function ensureMermaid() {
    if (state.mermaidLoaded) {
      try { window.mermaid && window.mermaid.run(); } catch {}
      return Promise.resolve();
    }
    return new Promise((resolve) => {
      const s = document.createElement('script');
      s.src = window.__MERMAID_SRC;
      s.onload = () => {
        state.mermaidLoaded = true;
        try {
          window.mermaid.initialize({
            startOnLoad: false,
            theme: document.documentElement.dataset.theme === 'light' ? 'default' : 'dark',
            securityLevel: 'loose',
            themeVariables: {
              fontFamily: 'ui-sans-serif, system-ui, sans-serif',
              primaryColor: '#142544',
              primaryTextColor: '#f0f4fa',
              primaryBorderColor: '#2d4773',
              lineColor: '#9ba8c4',
              textColor: '#f0f4fa',
              edgeLabelBackground: '#0f1e36',
            }
          });
          window.mermaid.run();
        } catch {}
        resolve();
      };
      s.onerror = () => resolve();
      document.head.appendChild(s);
    });
  }

  // ── orbit / cycle stepper ──────────────────────────────────
  function wireOrbit() {
    const wrap = $('.orbit-wrap');
    if (!wrap) return;
    const steps = $$('.orbit-step', wrap);
    if (!steps.length) return;

    // Position steps around the circle
    const count = steps.length;
    const rect = wrap.getBoundingClientRect();
    const cx = 50;  // percent
    const cy = 50;
    const r  = 42;  // percent radius

    steps.forEach((s, i) => {
      const angle = (i / count) * Math.PI * 2 - Math.PI / 2; // start at top
      const x = cx + r * Math.cos(angle);
      const y = cy + r * Math.sin(angle);
      s.style.left = x + '%';
      s.style.top  = y + '%';
      s.addEventListener('click', () => activateStep(i));
    });

    // Also reposition on resize
    window.addEventListener('resize', () => {
      steps.forEach((s, i) => {
        const angle = (i / count) * Math.PI * 2 - Math.PI / 2;
        const x = cx + r * Math.cos(angle);
        const y = cy + r * Math.sin(angle);
        s.style.left = x + '%';
        s.style.top  = y + '%';
      });
    }, { once: true });

    function activateStep(i) {
      steps.forEach(x => x.classList.remove('active'));
      steps[i].classList.add('active');
      const details = JSON.parse($('#cycle-details')?.textContent || '[]');
      const d = details[i];
      const detail = $('.orbit-detail');
      if (d && detail) {
        detail.innerHTML = `<h3>${d.title}</h3><p>${d.body}</p>${d.link ? `<a href="${d.link}">Full guide →</a>` : ''}`;
      }
    }

    activateStep(0);
  }

  // ── department picker ─────────────────────────────────────
  function wireDepartmentPicker() {
    $$('[data-dept]').forEach(card => {
      card.addEventListener('click', (e) => {
        e.preventDefault();
        const dept = card.dataset.dept;
        saveJSON(STORAGE_KEY_DEPT, dept);
        const target = DEPT_SECTIONS[dept];
        if (target) loadSection(target.id);
      });
    });
  }

  // ── checklist ──────────────────────────────────────────────
  function wireChecklist() {
    const saved = loadJSON(STORAGE_KEY_CHECKLIST, {});
    const boxes = $$('.checklist input[type="checkbox"]');
    const ring = $('.checklist-progress-ring .fill');
    const pctEl = $('.checklist-progress-ring .pct');
    const labelEl = $('.checklist-progress-label');

    function refreshRing() {
      const total = boxes.length;
      const done  = boxes.filter(b => b.checked).length;
      const pct = total ? Math.round((done / total) * 100) : 0;
      if (ring) {
        const circumference = 2 * Math.PI * 24;  // r=24
        const dashOffset = circumference - (pct / 100) * circumference;
        ring.setAttribute('stroke-dasharray', String(circumference));
        ring.setAttribute('stroke-dashoffset', String(dashOffset));
      }
      if (pctEl)   pctEl.textContent = pct + '%';
      if (labelEl) labelEl.innerHTML = `<strong>${done} of ${total}</strong> complete — nice work.`;
    }

    boxes.forEach(cb => {
      const key = cb.dataset.key;
      if (!key) return;
      cb.checked = !!saved[key];
      cb.closest('li').classList.toggle('done', cb.checked);
      cb.addEventListener('change', () => {
        saved[key] = cb.checked;
        saveJSON(STORAGE_KEY_CHECKLIST, saved);
        cb.closest('li').classList.toggle('done', cb.checked);
        refreshRing();
      });
    });

    // clicking the li also toggles
    $$('.checklist li').forEach(li => {
      li.addEventListener('click', (e) => {
        if (e.target.tagName === 'A' || e.target.tagName === 'CODE') return;
        if (e.target.tagName === 'INPUT') return;
        const cb = li.querySelector('input[type="checkbox"]');
        if (cb) { cb.checked = !cb.checked; cb.dispatchEvent(new Event('change')); }
      });
    });

    refreshRing();
  }

  // ── copy buttons ───────────────────────────────────────────
  function wireCopyButtons() {
    $$('.copy-btn').forEach(btn => {
      btn.addEventListener('click', async (e) => {
        e.stopPropagation();
        const target = btn.dataset.copy;
        if (!target) return;
        const el = document.querySelector(target);
        if (!el) return;
        const text = (el.innerText || el.textContent || '').trim();
        try {
          await navigator.clipboard.writeText(text);
          const orig = btn.textContent;
          btn.textContent = 'Copied ✓';
          setTimeout(() => { btn.textContent = orig; }, 1200);
        } catch {
          btn.textContent = 'Press ⌘/Ctrl+C';
        }
      });
    });
  }

  // ── theme ──────────────────────────────────────────────────
  function applyTheme(theme) {
    document.documentElement.dataset.theme = theme;
    $('#icon-moon').style.display = theme === 'dark' ? 'block' : 'none';
    $('#icon-sun').style.display  = theme === 'light' ? 'block' : 'none';
    if (state.mermaidLoaded && window.mermaid) {
      try {
        window.mermaid.initialize({
          startOnLoad: false,
          theme: theme === 'light' ? 'default' : 'dark',
          securityLevel: 'loose',
        });
        window.mermaid.run();
      } catch {}
    }
  }
  function initTheme() {
    const saved = loadJSON(STORAGE_KEY_THEME, null);
    if (saved)                 applyTheme(saved);
    else                       applyTheme('dark');  // default is dark
  }
  function toggleTheme() {
    const cur = document.documentElement.dataset.theme || 'dark';
    const next = cur === 'dark' ? 'light' : 'dark';
    applyTheme(next);
    saveJSON(STORAGE_KEY_THEME, next);
  }

  // ── init ───────────────────────────────────────────────────
  function init() {
    initTheme();
    state.visited = new Set(loadJSON(STORAGE_KEY_PROGRESS, []));

    $('#theme-toggle').addEventListener('click', toggleTheme);
    $('#prev-btn').addEventListener('click', () => goTo(-1));
    $('#next-btn').addEventListener('click', () => goTo(+1));

    document.addEventListener('keydown', (e) => {
      if (e.target.matches('input, textarea, [contenteditable]')) return;
      if (e.key === 'ArrowRight') goTo(+1);
      else if (e.key === 'ArrowLeft')  goTo(-1);
    });

    renderDots();

    // Initial load: hash or first section
    const startHash = location.hash.replace('#', '');
    const list = orderedSections();
    const start = (startHash && list.find(s => s.id === startHash)) ? startHash : list[0].id;
    loadSection(start);

    window.addEventListener('hashchange', () => {
      const h = location.hash.replace('#', '');
      if (h && h !== state.current && orderedSections().find(s => s.id === h)) {
        loadSection(h);
      }
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
