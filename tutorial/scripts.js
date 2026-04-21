/* BSVA AI Guided Tour — scripts.js
 * - Loads section partials via fetch (requires HTTP server; graceful fallback to guidance).
 * - Tracks progress in localStorage.
 * - Handles keyboard nav and checklist state.
 */

(() => {
  'use strict';

  const STORAGE_KEY_PROGRESS = 'bsva-tutorial-progress-v1';
  const STORAGE_KEY_THEME    = 'bsva-tutorial-theme-v1';
  const STORAGE_KEY_CHECKLIST = 'bsva-tutorial-checklist-v1';
  const STORAGE_KEY_DEPT     = 'bsva-tutorial-dept-v1';

  // Ordered list of sections. The dept sections are hidden until the user picks one.
  const SECTIONS = [
    '01-welcome',
    '02-install-recap',
    '03-architecture',
    '04-the-cycle',
    '05-before-you-paste',
    '06-nest-vs-tension',
    '07-choose-department',
    // dept sections inserted dynamically based on choice
    '09-first-session',
    '10-checklist',
  ];
  const DEPT_SECTIONS = {
    devrel:      '08-dept-devrel',
    tech:        '08-dept-tech',
    education:   '08-dept-education',
    operations:  '08-dept-operations',
  };

  // ── state ───────────────────────────────────────────────────
  const state = {
    current: null,
    visited: new Set(),
    mermaidLoaded: false,
  };

  // ── helpers ─────────────────────────────────────────────────
  const $  = (sel, root = document) => root.querySelector(sel);
  const $$ = (sel, root = document) => Array.from(root.querySelectorAll(sel));

  function loadJSON(key, fallback) {
    try {
      const v = localStorage.getItem(key);
      return v ? JSON.parse(v) : fallback;
    } catch { return fallback; }
  }
  function saveJSON(key, val) {
    try { localStorage.setItem(key, JSON.stringify(val)); } catch {}
  }

  function orderedSectionsWithDept() {
    const dept = loadJSON(STORAGE_KEY_DEPT, null);
    const list = [...SECTIONS];
    if (dept && DEPT_SECTIONS[dept]) {
      // Insert dept section after 07-choose-department (index 6)
      list.splice(7, 0, DEPT_SECTIONS[dept]);
    }
    return list;
  }

  // ── routing ─────────────────────────────────────────────────
  async function loadSection(id) {
    const content = $('#content');
    content.innerHTML = '<div class="loading">Loading…</div>';
    try {
      const res = await fetch(`sections/${id}.html`, { cache: 'no-cache' });
      if (!res.ok) throw new Error('HTTP ' + res.status);
      const html = await res.text();
      content.innerHTML = html;
      state.current = id;
      state.visited.add(id);
      saveVisited();
      updateNavActive();
      updateProgress();
      await runSectionHooks(id);
      window.scrollTo({ top: 0, behavior: 'instant' });
      if (location.hash !== `#${id}`) {
        history.replaceState(null, '', `#${id}`);
      }
    } catch (err) {
      // fetch failed — likely file:// protocol
      if (location.protocol === 'file:') {
        const tpl = document.getElementById('file-protocol-template');
        content.innerHTML = '';
        content.appendChild(tpl.content.cloneNode(true));
      } else {
        content.innerHTML = `<div class="error-card"><h2>Couldn't load section</h2><p>${err.message}</p></div>`;
      }
    }
  }

  // ── progress ────────────────────────────────────────────────
  function saveVisited() {
    saveJSON(STORAGE_KEY_PROGRESS, [...state.visited]);
  }
  function loadVisited() {
    const saved = loadJSON(STORAGE_KEY_PROGRESS, []);
    state.visited = new Set(saved);
  }
  function updateProgress() {
    const ordered = orderedSectionsWithDept();
    const total = ordered.length;
    const done  = ordered.filter(s => state.visited.has(s)).length;
    $('#progress-fill').style.width = `${Math.round((done / total) * 100)}%`;
    $('#progress-label').textContent = `${done} / ${total}`;
  }

  // ── nav UI ──────────────────────────────────────────────────
  function updateNavActive() {
    $$('#nav-list li').forEach(li => {
      li.classList.remove('active');
      const id = li.dataset.section;
      if (id === state.current) li.classList.add('active');
      if (state.visited.has(id)) li.classList.add('completed');
    });
  }

  function revealDeptInNav() {
    const dept = loadJSON(STORAGE_KEY_DEPT, null);
    // Hide all dept items, then reveal the chosen one
    $$('#nav-list li.indent').forEach(li => li.hidden = true);
    if (dept && DEPT_SECTIONS[dept]) {
      const id = DEPT_SECTIONS[dept];
      const li = $(`#nav-list li[data-section="${id}"]`);
      if (li) li.hidden = false;
    }
  }

  // ── section-specific hooks ──────────────────────────────────
  async function runSectionHooks(id) {
    const content = $('#content');

    // Load Mermaid lazily when a section needs it
    if ($('.mermaid', content)) await ensureMermaid();

    // The cycle stepper
    if (id === '04-the-cycle') wireCycleStepper();

    // Choose department
    if (id === '07-choose-department') wireDepartmentPicker();

    // Checklist
    if (id === '10-checklist') wireChecklist();

    // Copy-code buttons
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
            theme: document.documentElement.dataset.theme === 'dark' ? 'dark' : 'default',
            securityLevel: 'loose',
          });
          window.mermaid.run();
        } catch {}
        resolve();
      };
      s.onerror = () => resolve();  // continue without diagrams
      document.head.appendChild(s);
    });
  }

  function wireCycleStepper() {
    const steps = $$('.step');
    const detail = $('.step-detail');
    if (!steps.length || !detail) return;
    const details = JSON.parse($('#cycle-details')?.textContent || '[]');
    steps.forEach((s, i) => {
      s.addEventListener('click', () => {
        steps.forEach(x => x.classList.remove('active'));
        s.classList.add('active');
        const d = details[i];
        if (d) detail.innerHTML = `<h3>${d.title}</h3><p>${d.body}</p>` +
          (d.link ? `<p><a href="${d.link}">Read the full guide →</a></p>` : '');
      });
    });
    // Activate first by default
    steps[0].click();
  }

  function wireDepartmentPicker() {
    $$('[data-dept]').forEach(card => {
      card.addEventListener('click', (e) => {
        e.preventDefault();
        const dept = card.dataset.dept;
        saveJSON(STORAGE_KEY_DEPT, dept);
        revealDeptInNav();
        // advance to dept section
        const target = DEPT_SECTIONS[dept];
        loadSection(target);
      });
    });
  }

  function wireChecklist() {
    const saved = loadJSON(STORAGE_KEY_CHECKLIST, {});
    $$('.checklist input[type="checkbox"]').forEach(cb => {
      const key = cb.dataset.key;
      if (!key) return;
      cb.checked = !!saved[key];
      cb.closest('li').classList.toggle('done', cb.checked);
      cb.addEventListener('change', () => {
        saved[key] = cb.checked;
        saveJSON(STORAGE_KEY_CHECKLIST, saved);
        cb.closest('li').classList.toggle('done', cb.checked);
      });
    });
  }

  function wireCopyButtons() {
    $$('.copy-btn').forEach(btn => {
      btn.addEventListener('click', async () => {
        const target = btn.dataset.copy;
        if (!target) return;
        const el = document.querySelector(target);
        if (!el) return;
        const text = el.textContent;
        try {
          await navigator.clipboard.writeText(text);
          const orig = btn.textContent;
          btn.textContent = 'Copied ✓';
          setTimeout(() => { btn.textContent = orig; }, 1200);
        } catch {
          btn.textContent = 'Press ⌘/Ctrl+C to copy';
        }
      });
    });
  }

  // ── theme ───────────────────────────────────────────────────
  function applyTheme(theme) {
    document.documentElement.dataset.theme = theme;
    // tell mermaid to re-render if loaded
    if (state.mermaidLoaded && window.mermaid) {
      try {
        window.mermaid.initialize({
          startOnLoad: false,
          theme: theme === 'dark' ? 'dark' : 'default',
          securityLevel: 'loose',
        });
        window.mermaid.run();
      } catch {}
    }
  }
  function initTheme() {
    const saved = loadJSON(STORAGE_KEY_THEME, null);
    if (saved) {
      applyTheme(saved);
    } else if (window.matchMedia?.('(prefers-color-scheme: dark)').matches) {
      applyTheme('dark');
    } else {
      applyTheme('light');
    }
  }
  function toggleTheme() {
    const cur = document.documentElement.dataset.theme || 'light';
    const next = cur === 'dark' ? 'light' : 'dark';
    applyTheme(next);
    saveJSON(STORAGE_KEY_THEME, next);
  }

  // ── prev / next ─────────────────────────────────────────────
  function goTo(offset) {
    const ordered = orderedSectionsWithDept();
    const idx = ordered.indexOf(state.current);
    if (idx === -1) return;
    const next = idx + offset;
    if (next < 0 || next >= ordered.length) return;
    loadSection(ordered[next]);
  }

  // ── init ────────────────────────────────────────────────────
  function init() {
    initTheme();
    loadVisited();
    revealDeptInNav();
    updateProgress();

    // theme toggle
    $('#theme-toggle').addEventListener('click', toggleTheme);

    // prev / next buttons
    $('#prev-btn').addEventListener('click', () => goTo(-1));
    $('#next-btn').addEventListener('click', () => goTo(+1));

    // sidebar clicks
    $('#nav-list').addEventListener('click', (e) => {
      const a = e.target.closest('a');
      if (!a) return;
      e.preventDefault();
      const li = a.closest('li');
      const id = li?.dataset.section;
      if (id) loadSection(id);
    });

    // keyboard nav
    document.addEventListener('keydown', (e) => {
      if (e.target.matches('input, textarea, [contenteditable]')) return;
      if (e.key === 'ArrowRight') { goTo(+1); }
      else if (e.key === 'ArrowLeft')  { goTo(-1); }
      else if (e.key === '?')          { alert('← / → to navigate\nClick the sun/moon to toggle theme\nYour progress is saved locally.'); }
    });

    // hash handling
    const startHash = location.hash.replace('#', '');
    const ordered = orderedSectionsWithDept();
    const start = (startHash && ordered.includes(startHash)) ? startHash : ordered[0];
    loadSection(start);

    window.addEventListener('hashchange', () => {
      const h = location.hash.replace('#', '');
      if (h && h !== state.current && orderedSectionsWithDept().includes(h)) {
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
