---
name: docs-decide
description: >
  Use when making any architectural or significant technical decision.
  Creates a numbered ADR in docs/decisions/ and links it from claude-context.md.
---

# docs:decide — Record an Architecture Decision

Document a significant technical decision as an Architecture Decision Record (ADR).

## Step 1: Gather decision details

Ask the user:
1. **What is the decision?** — one clear sentence (this becomes the ADR title suffix)
2. **Context** — what situation prompted this decision?
3. **Decision** — what exactly was decided?
4. **Alternatives considered** — what other options were evaluated?
5. **Consequences** — what becomes easier or harder as a result?
6. **Domain(s)** — which domains does this decision affect?

## Step 2: Determine the next ADR number

Count existing ADR files:
```bash
ls docs/decisions/ADR-*.md 2>/dev/null | wc -l
```
Next ADR number = count + 1. Zero-pad to 3 digits (e.g. 001, 002, 012).

## Step 2b: Forward-looking milestone check

**Before writing the ADR**, read `docs/product/roadmap.md`. Does this decision constrain or foreclose any planned future milestones or roadmap items?

- If yes: tell the user what is constrained, phrased as: "This decision makes [future goal] harder/impossible because [reason]." Ask whether to proceed or reconsider before continuing to Step 3.
- If no: proceed — note "No known roadmap conflicts" in the ADR Consequences section.

A decision that works today but forecloses a planned future direction is a problem, not a solution. Identify this *before* the ADR is written.

## Step 3: Create the ADR

- File: `docs/decisions/ADR-<NNN>-<decision-slug>.md`
- Use the template at `docs/templates/adr.md`
- Fill in ALL fields — no placeholders
- Set `status: stable`, `confidence: stable`
- Set `decision` frontmatter field to the one-line outcome
- Set `alternatives-considered` to the list of options evaluated
- Set `domain` to the identified domains
- Mirror domains in `tags`: add `domain/<name>` entries
- Set `created` and `updated` to today
- Add wikilinks inline where related concepts are mentioned

## Step 4: Check for supersession

Does this decision supersede an existing ADR? If yes:
- Add `supersedes: "[[ADR-NNN-old-title]]"` to the new ADR's frontmatter
- Update the old ADR: set `status: deprecated`, add a note at the top linking to the new ADR

## Step 5: Link from claude-context.md and decisions index

Add to the Key Decisions section of `docs/meta/claude-context.md`: `- [[ADR-NNN-decision-slug]] — one-line outcome`

Also bump the `updated` date in `docs/meta/claude-context.md`.

Add to `docs/decisions/index.md`:
- Under **Chronological** (newest first): `- [[ADR-NNN-decision-slug]] — one-line outcome *(YYYY-MM-DD)*`
- Under **By Domain** → relevant domain section: same entry

Bump `updated` on `docs/decisions/index.md`.

## Step 6: Confirm

Tell the user:
- The ADR file created and its number
- Whether it supersedes an existing ADR
- The link added to claude-context.md
