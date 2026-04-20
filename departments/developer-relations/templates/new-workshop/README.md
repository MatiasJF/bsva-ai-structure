# new-workshop

A scaffold for a BSVA workshop — a repo with lessons, starter code, and solutions.

## Suggested layout

```
my-workshop/
├── README.md              overview, prerequisites, agenda
├── CLAUDE.md              symlink or copy from departments/developer-relations/
├── lessons/
│   ├── 01-intro/
│   │   ├── README.md      the lesson
│   │   ├── starter/       code students start with
│   │   └── solution/      reference solution
│   ├── 02-...
│   └── 99-conclusion/
├── slides/
│   └── workshop.md        optional — slides in MD, use bsva-pptx to render
└── instructor-notes.md    timing, common student mistakes, troubleshooting
```

## Conventions

- **One concept per lesson.** If a lesson needs 3 concepts, split it.
- **Every lesson must run standalone** from the starter code after `npm install`.
- **Solutions are checked in** — students reference them when stuck.
- **Slides (if any) are BSVA-branded** via the `bsva-pptx` skill.

## Usage

```bash
cp -R ~/bsva-ai-structure/departments/developer-relations/templates/new-workshop \
      ~/projects/my-workshop
cd ~/projects/my-workshop
ln -s ~/bsva-ai-structure/departments/developer-relations/CLAUDE.md CLAUDE.md
git init && git add . && git commit -m "scaffold from new-workshop"
```

Then start filling in `lessons/`.

## Checklist before running the workshop

- [ ] All lessons' starters and solutions compile.
- [ ] Instructor notes cover each lesson's timing and common pitfalls.
- [ ] Slides reviewed against BSVA brand voice.
- [ ] No credentials or test keys committed.
- [ ] Workshop has been tested end-to-end by someone who is not you.
