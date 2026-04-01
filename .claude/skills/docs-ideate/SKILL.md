---
name: docs-ideate
description: >
  Use when exploring an idea that isn't yet a spec. Creates or updates a concept
  note in docs/concepts/ to capture the idea while it's still forming.
---

# docs-ideate — Capture an Idea

Capture a concept or idea in the vault before it becomes a spec. This skill never promotes an idea to a spec — that is always an explicit human decision.

## Step 1: Determine mode

Is this a **new** idea or are we **revisiting** an existing concept?

- **New**: Ask the user for details (Step 2).
- **Revisiting**: Find the existing note in `docs/concepts/`, read it in full, then proceed to Step 3 to add an Exploration Log entry and update the body.

## Step 2: Gather idea details (new concepts only)

Ask the user:
1. **Name** — what is this idea called? (will become the filename slug)
2. **What is it?** — a clear definition in 2–3 sentences
3. **Why does it matter?** — why is this worth capturing?
4. **Domain(s)** — which domains does it touch? (must exist in `docs/meta/claude-context.md`)
5. **Open questions** — what is still unclear?
6. **Design influence** — are there adjacent features or systems this should inform, even if never built? (Can be left blank for seed-stage ideas.)

## Step 3: Find related existing notes

Search `docs/concepts/` for existing concepts that are related. Also check `docs/specs/` for any specs this idea connects to or might be informed by.

## Step 4: Create or update the concept note

**New concept:**
- File: `docs/concepts/<idea-slug>.md`
- Use the template at `docs/templates/concept.md`
- Set `status: ideating`, `confidence: speculative`, `maturity: seed`
- Set `domain` to the identified domains
- Mirror in `tags`: `type/concept`, `status/ideating`, `maturity/seed`, `domain/<name>`
- Fill `related` with wikilinks to related notes found in Step 3
- Add wikilinks inline in the body where concepts are mentioned
- Set `created` and `updated` to today
- Add an initial Exploration Log entry dated today

**Revisiting concept:**
- Add a new dated entry to `## Exploration Log` (newest at top)
- Update body sections if understanding has evolved
- Bump `maturity` if the idea has developed: `seed → developing → fleshed-out`
- Update `status` only if disposition has genuinely changed:
  - `ideating → parked` if the idea is well-understood but not being actively explored
  - **Never change to `planned`** — that requires a human decision and `docs-new`
- Bump `updated` to today

## Step 5: Update concepts index (new concepts only)

If a **new** concept note was created, add an entry to `docs/concepts/concepts.md`:
- Under the appropriate section (`Seeds`, `Active Exploration`, or `Parked`) based on status/maturity
- Format: `- [[concept-slug]] — one-line description`

This keeps the index browsable as the concept library grows.

## Step 6: Update claude-context.md if significant

If this idea is meaningfully connected to the current focus: `- Exploring: [[idea-name]]` under Current Focus

Bump `updated` in `docs/meta/claude-context.md`.

## Step 7: Confirm

Tell the user:
- Where the note lives and what changed
- Its current `maturity` and `status`
- Any related specs or ADRs surfaced in Step 3
- Explicitly: promoting this concept to a spec is their call — they ask for `docs-new` when ready
