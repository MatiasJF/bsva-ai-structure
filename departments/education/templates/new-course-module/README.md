# new-course-module

Scaffold for a BSV Academy module — a cluster of lessons organized around a topic.

## Expected layout

```
my-module/
├── README.md            module overview + syllabus
├── CLAUDE.md
├── syllabus.md          module-level objectives, audience, prerequisites
├── lessons/
│   ├── 01-intro/        (each follows the new-lesson template)
│   ├── 02-.../
│   └── ...
├── assessments/
│   └── final.md         module-level assessment if any
└── instructor-notes.md  timing, pitfalls, progression guidance
```

## Module-level syllabus.md

Include:
- **Module audience** and **prerequisites**.
- **Terminal objectives** (what a learner can do after completing the module).
- **Lesson map** (list, with each lesson's 1-line objective).
- **Assessment strategy** (how we evaluate completion).
- **Estimated total time**.

## Convention

Modules are named `N-short-slug/` where N is the module's position in the broader course (`01-foundations`, `02-scripting`, ...). Within a module, lessons use the same numeric prefix pattern.
