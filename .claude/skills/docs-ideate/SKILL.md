---
name: docs-ideate
description: >
  Use when exploring an idea that isn't yet a spec. Creates or updates a concept
  note in docs/concepts/ to capture the idea while it's still forming.
---

# docs:ideate — Capture an Idea

Capture a concept or idea in the vault before it becomes a spec.

## Step 1: Gather idea details

Ask the user:
1. **Name** — what is this idea called? (will become the filename slug)
2. **What is it?** — a clear definition in 2–3 sentences
3. **Why does it matter?** — why is it worth capturing?
4. **Domain(s)** — which domains does it touch? (must exist in `docs/meta/claude-context.md`)
5. **Open questions** — what's still unclear?

## Step 2: Find related existing notes

Search `docs/docs/concepts/` for existing notes that are related.
Also check `docs/docs/specs/` for any specs this idea connects to.

## Step 3: Create the concept note

- File: `docs/concepts/<idea-slug>.md`
- Use the template at `docs/templates/concept.md`
- Set `status: ideating`, `confidence: speculative`, `maturity: seed`
- Set `domain` to the identified domains
- Mirror domains in `tags`: add `domain/<name>` entries alongside `type/concept` and `status/ideating`
- Fill in the `related` field with wikilinks to related notes found in Step 2
- Add wikilinks inline in the body where concepts are mentioned
- Set `created` and `updated` to today

## Step 4: Update claude-context.md if significant

If this idea is meaningfully connected to the current focus, add a brief mention under Current Focus:
`- Exploring: [[idea-name]]`

Also bump the `updated` date in `docs/meta/claude-context.md`.

## Step 5: Confirm

Tell the user the note was created and where it lives. If there are related specs or ADRs worth surfacing, mention them.
