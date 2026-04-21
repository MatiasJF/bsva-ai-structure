# Education — QA and review

Education at BSVA values accuracy over fluency. QA isn't optional; it's the quality gate.

---

## The review layers

Every lesson (and most other artifacts) needs three review layers before publish:

1. **Pedagogy review** — another educator checks that audience / prerequisites / objectives are consistent and the content serves them.
2. **Technical review** — DevRel or Tech (via tension) for anything involving protocol, cryptography, SDK, or consensus claims.
3. **Accessibility + voice review** — reading level check, alt text, BSVA voice, brand voice.

For translations, add:

4. **Native-speaker review** — a translator with practitioner-level knowledge, identified via tension.

For assessments:

5. **Item-quality review** — second educator hunts for ambiguity, plausible-distractor quality, stem clarity.

## Who does which

- **Pedagogy**: peer in Education circle (rotated).
- **Technical**: DevRel `sdk-maintainer` role or Tech `tech-lead` role, via tension.
- **Accessibility + voice**: Claude runs `reading-level-checker` + `external-comm-check`; author acts on findings; Education Lead signs off.
- **Native-speaker (translations)**: identified per language; tensioned.
- **Item-quality**: rotated among Education peers.

## Pilot learners (when warranted)

For concepts notoriously misunderstood (UTXOs, SPV, script evaluation), add a pilot step:

1. Draft finalized.
2. 3–5 pilot learners volunteer.
3. They work through the lesson + CfU items under timed conditions.
4. Their struggles and misconceptions are reviewed.
5. Content revised; pilot repeats for any item that >40% got wrong.

This is expensive. Do it for high-leverage topics, not every lesson.

## Closing a review round

- Reviewer posts findings as comments on the nest (or on the tension if cross-role).
- Author addresses or contests each.
- Any unresolved concern blocks publish — escalate to Education Lead.

## Classifying review material

Review comments on Internal drafts are Internal. **Learner pilot data** is Confidential. Handle accordingly.

## Publication after QA

Once all QA layers pass, publish follows `publication-checklist.md` — the Education-specific version of `workflow/08-publish-gate.md`.
