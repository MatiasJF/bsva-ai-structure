# 06 — Project scaffolding

How to start a new project so Claude has the right context from minute one.

---

```mermaid
flowchart TD
  start([I'm starting a new project]):::start

  pickDept{Which department<br/>owns this work?}
  pickTemplate["Choose template:<br/>departments/&lt;dept&gt;/templates/&lt;template&gt;/"]:::action
  clone["Copy template to new folder:<br/>cp -R template/ ~/path/to/project"]:::action
  init[Init git + make first commit<br/>'scaffold from template-name']:::action
  linkClaude["Link department CLAUDE.md:<br/>ln -s ../bsva-ai-structure/departments/&lt;dept&gt;/CLAUDE.md CLAUDE.md<br/>(or copy if you need to customize)"]:::action
  projClaude{Project needs its own<br/>CLAUDE.md additions?}
  extend["Create project CLAUDE.md that<br/>ADDS to (not replaces)<br/>the department one"]:::action
  verify[Open Claude in the folder<br/>ask: 'what is this project and<br/>how should I help?']:::action
  ok{Claude responds with<br/>department-appropriate context?}
  debug[Fix: check CLAUDE.md layering,<br/>department CLAUDE.md reachable,<br/>MCPs configured]:::action
  work([✓ Project ready — start work]):::done

  start --> pickDept --> pickTemplate --> clone --> init --> linkClaude --> projClaude
  projClaude -- "yes" --> extend --> verify
  projClaude -- "no"  --> verify
  verify --> ok
  ok -- "yes" --> work
  ok -- "no"  --> debug --> verify

  classDef start fill:#eaf4ff,stroke:#2f6fd8,stroke-width:2px
  classDef action fill:#fff,stroke:#555
  classDef done fill:#e8fae5,stroke:#4fa63b,stroke-width:2px
```

---

## Walkthrough

### Step 1 — Pick department and template
Each department has templates under `departments/<dept>/templates/`. Examples:
- `developer-relations/templates/new-workshop/`
- `developer-relations/templates/new-sdk-example/`
- `technology/templates/new-service/`
- `education/templates/new-course-module/`

Pick the one that matches the scope of your work. If none fit, use the closest match and customize.

### Step 2 — Copy, don't symlink the template
```bash
cp -R ~/bsva-ai-structure/departments/developer-relations/templates/new-workshop \
      ~/projects/my-new-workshop
cd ~/projects/my-new-workshop
git init
git add . && git commit -m "scaffold from new-workshop template"
```

Copying (not symlinking) lets the project evolve independently.

### Step 3 — Link the department CLAUDE.md
The project's root should have a `CLAUDE.md`. You can either **symlink** (auto-updates when the department version changes) or **copy** (stable, customizable).

**Symlink (recommended for most projects):**
```bash
ln -s ~/bsva-ai-structure/departments/developer-relations/CLAUDE.md CLAUDE.md
```

**Copy (if you need project-specific additions without affecting others):**
```bash
cp ~/bsva-ai-structure/departments/developer-relations/CLAUDE.md CLAUDE.md
# then edit CLAUDE.md with your project-specific additions
```

### Step 4 — Optional: project-specific CLAUDE.md additions
If the project has context Claude needs beyond the department default (a specific SDK version, a particular audience, a unique deployment constraint), add it to the project's CLAUDE.md. Layering: **extend, don't replace**.

### Step 5 — Verify
Open Claude in the folder. Ask it a grounding question:

> "What is this project about and what's the most helpful way you can assist here?"

A well-linked project produces an answer that references your department's voice, your project's purpose, and any BSVA-wide security rules. A broken linkage produces generic answers.

### Step 6 — Fix if needed
If Claude is generic:
- Confirm `CLAUDE.md` is in the project root and readable.
- Confirm the department `CLAUDE.md` it links to exists and is readable.
- Confirm you ran `install.sh` — the base `~/.claude/CLAUDE.md` must be present.
- Restart the Claude session (`/clear` or reopen).

---

## Template anatomy

A good template includes:

```
templates/new-workshop/
├── CLAUDE.md              (or a symlink to dept/CLAUDE.md)
├── README.md              what this template produces
├── .gitignore
├── src/
├── docs/
├── examples/
└── .claude/
    └── skills/            any project-specific skills
```

The template is not sacred — fork, modify, propose improvements back via PR.

---

## Ownership / RACI

| Step | Responsible | Accountable |
|---|---|---|
| Maintaining templates | Department Lead | Department Lead |
| Choosing a template | Project author | Project author |
| Scaffolding a project | Project author | Project author |
| Proposing template improvements | Project author | Department Lead |

---

## See also

- `departments/<your-dept>/templates/` — the templates for your department.
- `departments/<your-dept>/guides/how-to-start-a-project.md` — department-specific setup notes.
