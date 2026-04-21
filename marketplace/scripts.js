/* BSVA AI Marketplace — scripts.js
 *
 * Loads data.json, renders filterable cards, opens a detail drawer on click.
 * Small markdown-to-HTML shim for the drawer body.
 */

(() => {
  'use strict';

  const STORAGE_KEY_THEME = 'bsva-tutorial-theme-v1';

  // ── state ───────────────────────────────────────────────────
  const state = {
    items: [],
    generated: '',
    q: '',
    scope: 'all',
    type: 'all',
  };

  // Scope display labels + order
  const SCOPES = [
    { value: 'all',                          label: 'All' },
    { value: 'global',                       label: 'Global' },
    { value: 'workflow',                     label: 'Workflow' },
    { value: 'security',                     label: 'Security' },
    { value: 'dept/developer-relations',     label: 'DevRel' },
    { value: 'dept/technology',              label: 'Technology' },
    { value: 'dept/education',               label: 'Education' },
    { value: 'dept/operations',              label: 'Operations' },
    { value: 'dept/operations/biz-dev',      label: 'Ops · Biz-Dev' },
    { value: 'dept/operations/marketing',    label: 'Ops · Marketing' },
    { value: 'dept/operations/legal',        label: 'Ops · Legal' },
    { value: 'dept/operations/exec',         label: 'Ops · Exec' },
    { value: 'guides/for-humans',            label: 'Guides · Humans' },
    { value: 'guides/for-claude',            label: "Guides · Claude" },
    { value: 'guides/visuals',               label: 'Guides · Visuals' },
  ];

  const TYPES = [
    { value: 'all',      label: 'All' },
    { value: 'skill',    label: 'Skills' },
    { value: 'mcp',      label: 'MCPs' },
    { value: 'template', label: 'Templates' },
    { value: 'workflow', label: 'Workflow docs' },
    { value: 'guide',    label: 'Guides' },
  ];

  // ── utils ───────────────────────────────────────────────────
  const $  = (sel) => document.querySelector(sel);
  const $$ = (sel) => Array.from(document.querySelectorAll(sel));

  function loadJSON(k, fb) {
    try { const v = localStorage.getItem(k); return v ? JSON.parse(v) : fb; }
    catch { return fb; }
  }
  function saveJSON(k, v) { try { localStorage.setItem(k, JSON.stringify(v)); } catch {} }

  function escapeHtml(s) {
    return String(s || '').replace(/[&<>"]/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'}[c]));
  }

  function scopeLabel(s) {
    const m = SCOPES.find(x => x.value === s);
    return m ? m.label : s;
  }
  function typeLabel(t) {
    const m = TYPES.find(x => x.value === t);
    return m ? m.label.replace(/s$/, '') : t;
  }

  // ── small markdown renderer (headings, bold, code, lists, links) ──
  function renderMd(src) {
    if (!src) return '';
    // extract fenced code blocks first
    const codes = [];
    src = src.replace(/```[a-zA-Z]*\n([\s\S]*?)```/g, (_, code) => {
      codes.push(code);
      return `@@CODE${codes.length - 1}@@`;
    });
    let html = escapeHtml(src);
    // headings
    html = html
      .replace(/^####\s*(.+)$/gm, '<h4>$1</h4>')
      .replace(/^###\s*(.+)$/gm, '<h3>$1</h3>')
      .replace(/^##\s*(.+)$/gm, '<h3>$1</h3>')
      .replace(/^#\s*(.+)$/gm, '<h3>$1</h3>');
    // blockquote
    html = html.replace(/^&gt; ?(.+)$/gm, '<blockquote>$1</blockquote>');
    // bold + italics
    html = html.replace(/\*\*([^\n*]+)\*\*/g, '<strong>$1</strong>');
    html = html.replace(/(^|\W)_([^_\n]+)_(\W|$)/g, '$1<em>$2</em>$3');
    // inline code
    html = html.replace(/`([^`\n]+)`/g, '<code>$1</code>');
    // links (simple)
    html = html.replace(/\[([^\]]+)\]\(([^)]+)\)/g, '<a href="$2">$1</a>');
    // unordered lists
    const lines = html.split('\n');
    const out = [];
    let inList = false;
    for (const line of lines) {
      const m = line.match(/^[-*]\s+(.+)$/);
      if (m) {
        if (!inList) { out.push('<ul>'); inList = true; }
        out.push(`<li>${m[1]}</li>`);
      } else {
        if (inList) { out.push('</ul>'); inList = false; }
        out.push(line);
      }
    }
    if (inList) out.push('</ul>');
    html = out.join('\n');
    // paragraphs: double-newlines
    html = html.split(/\n{2,}/).map(p => {
      if (/^<(h[1-6]|ul|ol|blockquote|pre)/i.test(p.trim())) return p;
      if (p.trim() === '') return '';
      return `<p>${p.replace(/\n/g, '<br>')}</p>`;
    }).join('\n');
    // restore code fences
    html = html.replace(/@@CODE(\d+)@@/g, (_, i) => `<pre><code>${escapeHtml(codes[+i])}</code></pre>`);
    return html;
  }

  // ── filters UI ──────────────────────────────────────────────
  function renderFilters() {
    const counts = (dim) => {
      const c = {};
      for (const it of state.items) c[it[dim]] = (c[it[dim]] || 0) + 1;
      return c;
    };
    const sCounts = counts('scope');
    const tCounts = counts('type');

    const sEl = $('#scope-filters');
    sEl.innerHTML = '';
    for (const s of SCOPES) {
      const n = s.value === 'all' ? state.items.length : (sCounts[s.value] || 0);
      if (s.value !== 'all' && n === 0) continue;  // hide empty scopes
      const btn = document.createElement('button');
      btn.className = 'chip-btn' + (state.scope === s.value ? ' active' : '');
      btn.innerHTML = `${s.label} <span class="count">${n}</span>`;
      btn.addEventListener('click', () => { state.scope = s.value; renderAll(); });
      sEl.appendChild(btn);
    }

    const tEl = $('#type-filters');
    tEl.innerHTML = '';
    for (const t of TYPES) {
      const n = t.value === 'all' ? state.items.length : (tCounts[t.value] || 0);
      if (t.value !== 'all' && n === 0) continue;
      const btn = document.createElement('button');
      btn.className = 'chip-btn' + (state.type === t.value ? ' active' : '');
      btn.innerHTML = `${t.label} <span class="count">${n}</span>`;
      btn.addEventListener('click', () => { state.type = t.value; renderAll(); });
      tEl.appendChild(btn);
    }
  }

  // ── filtering ──────────────────────────────────────────────
  function filtered() {
    const q = state.q.trim().toLowerCase();
    return state.items.filter(it => {
      if (state.scope !== 'all' && it.scope !== state.scope) return false;
      if (state.type  !== 'all' && it.type  !== state.type)  return false;
      if (!q) return true;
      const hay = (
        (it.name || '') + ' ' +
        (it.title || '') + ' ' +
        (it.description || '') + ' ' +
        (it.path || '') + ' ' +
        (it.owner || '')
      ).toLowerCase();
      return hay.includes(q);
    });
  }

  // ── grid render ────────────────────────────────────────────
  function renderGrid() {
    const list = filtered();
    const grid = $('#grid');
    const empty = $('#empty');
    const meta = $('#meta');

    grid.innerHTML = '';
    empty.hidden = list.length > 0;

    meta.innerHTML =
      `<strong>${list.length}</strong> of ${state.items.length} items` +
      (state.generated ? ` · generated ${new Date(state.generated).toLocaleString()}` : '');

    const tierClass = (c) => {
      if (!c) return '';
      const k = c.toLowerCase();
      if (k.startsWith('public'))       return 'mp-tier--public';
      if (k.startsWith('internal'))     return 'mp-tier--internal';
      if (k.startsWith('confidential')) return 'mp-tier--confidential';
      if (k.startsWith('restricted'))   return 'mp-tier--restricted';
      return '';
    };

    for (const it of list) {
      const card = document.createElement('button');
      card.className = 'mp-card';
      const tierHtml = it.classification
        ? `<span class="mp-tier ${tierClass(it.classification)}">${escapeHtml(it.classification)}</span>`
        : '';
      card.innerHTML = `
        <div class="mp-card-head">
          <div>
            <span class="mp-chip mp-chip--${it.type}">${typeLabel(it.type)}</span>
          </div>
          <span class="mp-scope">${escapeHtml(scopeLabel(it.scope))}</span>
        </div>
        <div class="mp-card-name">${escapeHtml(it.name || it.title || '')}</div>
        <div class="mp-card-desc">${escapeHtml(it.description || it.body_preview || '')}</div>
        <div class="mp-card-meta">
          ${tierHtml}
          ${it.owner ? `<code>${escapeHtml(it.owner)}</code>` : ''}
          ${it.version ? `<span>v${escapeHtml(it.version)}</span>` : ''}
        </div>
      `;
      card.addEventListener('click', () => openDrawer(it));
      grid.appendChild(card);
    }
  }

  // ── drawer ─────────────────────────────────────────────────
  let lastFocused = null;
  async function openDrawer(it) {
    lastFocused = document.activeElement;
    $('#drawer-title').textContent = it.name || it.title || '';
    $('#drawer-chips').innerHTML =
      `<span class="mp-chip mp-chip--${it.type}">${typeLabel(it.type)}</span>` +
      `<span class="mp-scope">${escapeHtml(scopeLabel(it.scope))}</span>`;
    const metaBits = [];
    if (it.classification) metaBits.push(`<span class="mp-tier">${escapeHtml(it.classification)}</span>`);
    if (it.owner)   metaBits.push(`<code>${escapeHtml(it.owner)}</code>`);
    if (it.version) metaBits.push(`<span>v${escapeHtml(it.version)}</span>`);
    metaBits.push(`<code>${escapeHtml(it.path)}</code>`);
    $('#drawer-meta').innerHTML = metaBits.join(' ');

    // Load full body from the source file
    const bodyEl = $('#drawer-body');
    bodyEl.innerHTML = '<p class="muted">Loading…</p>';

    const desc = it.description ? `<p class="muted" style="border-bottom:1px solid var(--border);padding-bottom:14px;margin-bottom:14px;">${escapeHtml(it.description)}</p>` : '';

    try {
      const res = await fetch('../' + it.path, { cache: 'no-cache' });
      if (!res.ok) throw new Error('HTTP ' + res.status);
      let text = await res.text();
      // strip frontmatter
      text = text.replace(/^---\s*\n[\s\S]*?\n---\s*\n/, '');
      bodyEl.innerHTML = desc + renderMd(text);
    } catch (err) {
      bodyEl.innerHTML = desc + `<p class="muted">Couldn't load the source file: ${escapeHtml(err.message)}</p>`;
    }

    $('#drawer-foot').innerHTML =
      `<a href="../${encodeURI(it.path)}" target="_blank" class="btn btn-primary">Open source file →</a>` +
      `<button class="btn btn-ghost" id="drawer-copy">Copy path</button>`;
    const drawer = $('#drawer');
    drawer.classList.add('open');
    drawer.setAttribute('aria-hidden', 'false');

    $('#drawer-copy')?.addEventListener('click', async () => {
      try { await navigator.clipboard.writeText(it.path); $('#drawer-copy').textContent = 'Copied ✓'; setTimeout(() => $('#drawer-copy').textContent = 'Copy path', 1200); } catch {}
    });

    $('#drawer-close').focus();
  }

  function closeDrawer() {
    const drawer = $('#drawer');
    drawer.classList.remove('open');
    drawer.setAttribute('aria-hidden', 'true');
    if (lastFocused) lastFocused.focus();
  }

  // ── theme (shared with tutorial) ────────────────────────────
  function applyTheme(theme) {
    document.documentElement.dataset.theme = theme;
    $('#icon-moon').style.display = theme === 'dark' ? 'block' : 'none';
    $('#icon-sun').style.display  = theme === 'light' ? 'block' : 'none';
  }
  function initTheme() {
    const saved = loadJSON(STORAGE_KEY_THEME, null);
    applyTheme(saved || 'dark');
  }
  function toggleTheme() {
    const cur = document.documentElement.dataset.theme || 'dark';
    const next = cur === 'dark' ? 'light' : 'dark';
    applyTheme(next);
    saveJSON(STORAGE_KEY_THEME, next);
  }

  // ── render everything ──────────────────────────────────────
  function renderAll() { renderFilters(); renderGrid(); }

  // ── init ───────────────────────────────────────────────────
  async function init() {
    initTheme();

    $('#theme-toggle').addEventListener('click', toggleTheme);
    $('#drawer-backdrop').addEventListener('click', closeDrawer);
    $('#drawer-close').addEventListener('click', closeDrawer);

    $('#search').addEventListener('input', (e) => {
      state.q = e.target.value;
      renderGrid();
    });

    document.addEventListener('keydown', (e) => {
      if (e.key === 'Escape') closeDrawer();
      // `/` focuses search
      if (e.key === '/' && !e.target.matches('input, textarea')) {
        e.preventDefault();
        $('#search').focus();
      }
    });

    try {
      const res = await fetch('data.json', { cache: 'no-cache' });
      if (!res.ok) throw new Error('HTTP ' + res.status);
      const data = await res.json();
      state.items = data.items || [];
      state.generated = data.generated || '';
    } catch (err) {
      $('#meta').innerHTML =
        `<strong style="color: var(--danger);">Could not load data.json.</strong><br>` +
        `Run <code>python3 marketplace/generate_index.py</code> from the repo root, or relaunch via <code>./tutorial/start.sh</code> (it generates on launch).`;
      return;
    }

    renderAll();
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
