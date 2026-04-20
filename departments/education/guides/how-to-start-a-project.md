# How to start an Education project

## Pick a template

| Template | For |
|---|---|
| `templates/new-course-module/` | A multi-lesson module (4–10 lessons). |
| `templates/new-lesson/` | A single lesson with objectives, content, checks. |
| `templates/new-assessment/` | A quiz, exam, or rubric-graded project. |

## Scaffold

```bash
cp -R ~/bsva-ai-structure/departments/education/templates/new-lesson ~/projects/my-lesson
cd ~/projects/my-lesson
ln -s ~/bsva-ai-structure/departments/education/CLAUDE.md CLAUDE.md
git init && git add . && git commit -m "scaffold from new-lesson"
```

## Pedagogy minimums

Every artifact should declare:
- **Audience** (who this is for, specifically).
- **Prerequisites** (what the reader must already know).
- **Learning objectives** (what the reader will understand after).
- **Assessment strategy** (how we'll know they got it).

Without these, Claude's output drifts generic. Fill them in first, then draft content.

## Working with Claude on content

- **Start from an outline.** Ask Claude to refine your bullet outline, then expand one section at a time.
- **Use the BSV Academy MCP** — verify concept definitions against the knowledge base. Don't let Claude define BSV terms from training data if the MCP knows differently.
- **Check every claim.** Especially for beginners, a misstated detail misleads many learners.

## Translations

- Keep the English source in the same file until final review.
- Flag technical terms you're uncertain about.
- Get a native-speaker practitioner to review before publication.

## Checklist before publishing

- [ ] Objectives achievable by the intended audience from the stated prerequisites.
- [ ] Every technical claim verified (ideally via the Academy MCP or a primary source).
- [ ] Assessment items unambiguous and match the lesson definitions.
- [ ] Accessibility: alt text on images, reading level checked.
- [ ] Brand voice (`guides/for-claude/brand-voice.md`).
