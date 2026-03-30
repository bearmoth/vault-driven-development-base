---
name: docs-new
description: >
  Use when creating a spec, guide, runbook, reference doc, or milestone note.
  Picks the right template and ensures complete frontmatter.
  For concept notes use docs-ideate. For ADRs use docs-decide.
---

# docs:new — Create a New Document

Create a new vault note of any type not covered by a dedicated skill.

## Step 1: Determine document type

Ask: what type of document is this?
- **spec** — feature specification or implementation plan → `docs/specs/`
- **guide** — how-to instructions, step-by-step processes, runbooks → `docs/guides/`
- **reference** — API surface, schemas, lookup tables → `docs/reference/`
- **milestone** — a project milestone with goals and scope → `docs/product/milestones/`
- **roadmap** — already exists at `docs/product/roadmap.md`; update it instead

## Step 2: Gather required information

Ask for:
1. **Title** — human-readable name
2. **Filename slug** — lowercase, hyphens (e.g. `deploy-to-production`)
3. **Domain(s)** — which domains does this doc belong to? (must exist in `docs/meta/claude-context.md`)
4. **Brief description** — what is this doc about? (used for wikilink context in other notes)

For specs also ask:
- Which milestone does this belong to? (optional)
- Does it depend on other specs?

## Step 3: Create the note

- Use the template matching the type from `docs/templates/<type>.md`
- Place in the correct folder
- Fill in all frontmatter completely — no placeholders
- Mirror domains in `tags`: add `domain/<name>` entries
- Set `status` appropriately:
  - specs: `planned`
  - guides/reference: `implemented` (they document existing things)
  - milestones: `planned`
- Set `confidence` appropriately: `draft` for specs and milestones; `stable` for guides and reference docs
- Set `context: on-demand` for all doc types created by this skill
- Set `created` and `updated` to today
- Add wikilinks to related notes in the `related` field and inline in the body

## Step 4: Link from related notes

Check whether any existing note should link to this new one. If so, add a wikilink in its `## Related` section.

For specs: add a link under Active Specs in `docs/meta/claude-context.md`.
Also bump the `updated` date in `docs/meta/claude-context.md` to today.

## Step 5: Confirm

Tell the user where the note was created and what wikilinks were added.
