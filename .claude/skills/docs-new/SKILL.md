---
name: docs-new
description: >
  Use when creating a spec, guide, runbook, reference doc, or milestone note.
  Picks the right template and ensures complete frontmatter.
  For concept notes use docs-ideate. For ADRs use docs-decide.
---

# docs-new — Create a New Document

Create a new vault note of any type not covered by a dedicated skill.

## Step 1: Determine document type

Ask: what type of document is this?
- **spec** — feature specification with testable requirements → `docs/specs/`
- **tdd** — technical design document (how to build a complex feature) → `docs/specs/`
- **guide** — developer how-to instructions, runbooks → `docs/guides/`
- **user-doc** — user-facing documentation (end users, API consumers, admins) → `docs/user-docs/`
- **reference** — API surface, schemas, lookup tables, system reference → `docs/reference/`
- **milestone** — a project milestone with goals and scope → `docs/product/milestones/`
- **roadmap** — already exists at `docs/product/roadmap.md`; update it instead

## Step 2: Gather required information

Ask for:
1. **Title** — human-readable name
2. **Filename slug** — lowercase, hyphens (e.g. `deploy-to-production`)
3. **Domain(s)** — which domains? (must exist in `docs/meta/claude-context.md`)
4. **Brief description** — what is this doc about?

For **specs** also ask:
- Which concept note does this promote from? (Link the concept → update its status to `planned`.)
- Which milestone does this belong to? (Optional.)
- Does it depend on other specs?
- Does this spec introduce or rely on domain-specific terminology? If yes, ensure terms are defined in `docs/reference/domain-glossary.md`.

For **tdds** also ask:
- Which spec does this TDD support? (Required — TDDs must link to a spec.)
- Is this design exploratory (draft) or confirmed (stable)?

For **user-docs** also ask:
- Who is the audience? (`end-user` / `api-consumer` / `admin`)
- Which spec or feature does this document?

## Step 3: Create the note

- Use the template from `docs/templates/<type>.md`
- Place in the correct folder
- Fill all frontmatter completely — no placeholders
- Mirror domains in `tags`; also mirror `status`, `type`, `maturity` (concepts only)
- Set `status` appropriately: specs → `planned`; guides/reference → `implemented`; milestones → `planned`
- Set `confidence`: `draft` for specs and milestones; `stable` for guides and reference
- Set `context: on-demand`
- Set `created` and `updated` to today
- Add wikilinks to related notes in `related` and inline in the body

**For specs**, populate all structural sections before finishing:
- **Requirements**: EARS format — every requirement must be testable. If requirements are unclear, ask the user to clarify before writing them. See [[glossary]] for EARS patterns.
- **Task Breakdown**: ordered checklist, each task mapped to one or more REQ-IDs
- **Acceptance Criteria**: one checkbox per REQ, directly derived from the requirements list
- **Out of Scope**: explicit — prevents scope creep during implementation

Incomplete specs produce incomplete implementations. Do not leave these sections as placeholders.

## Step 4: Link from related notes

Check whether any existing note should link to this new one. Add wikilinks in `## Related` sections.

For specs:
- Add link under Active Specs in `docs/meta/claude-context.md` and bump `updated`
- If promoting a concept: update the concept note — set `status: planned`, add spec link in Related

**Update the corresponding index page:**
- New spec or TDD → add entry to `docs/specs/specs.md` (spec: under Planned; TDD: under TDDs)
- New guide or runbook → add entry to `docs/guides/guides.md`
- New user-doc → add entry to `docs/user-docs/user-docs.md` under the correct audience section
- New reference doc → add entry to `docs/reference/reference.md`
- New milestone → no index page; it's tracked via `docs/product/roadmap.md`

Index pages are browsable landing pages for the vault. Every new note must appear in its directory's index page in the same commit.

## Step 5: Confirm

Tell the user:
- Where the note was created and what wikilinks were added
- For specs: that Requirements, Task Breakdown, and Acceptance Criteria are complete
- For tdds: that it is linked to its parent spec and all sections are populated
- For user-docs: the audience defined and the spec it documents
- That implementation should not begin until the user reviews and approves the spec (and TDD if written)
