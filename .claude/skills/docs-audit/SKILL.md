---
name: docs-audit
description: >
  Use periodically or before any milestone. Scans the vault for health issues:
  orphaned notes, stale statuses, broken wikilinks, and docs that have drifted
  from reality. Produces a prioritised list of issues to fix.
---

# docs:audit — Vault Health Check

Audit the vault for drift, orphans, and stale content. Produce a prioritised report.

## Step 1: Find orphaned notes

A note is orphaned if no other vault note links to it (zero inbound wikilinks).

```bash
find docs -name "*.md" \
  | grep -v "docs/templates/" \
  | grep -v "docs/meta/claude-context.md"
```

For each note filename (without extension), check whether it appears as a wikilink in any other note:
```bash
grep -rl "note-slug" docs --include="*.md"
```

Collect all notes with zero inbound links. These are orphan candidates.
(Note: index pages and some reference notes are intentionally standalone — use judgment.)

## Step 2: Find stale statuses

Look for notes where `status` likely doesn't match reality:

```bash
grep -rl "status: ideating\|status: planned\|status: in-progress" docs \
  --include="*.md" \
  | grep -v "docs/templates/"
```

Review each and assess whether the status is accurate.

## Step 3: Find overdue reviews

Find notes not updated recently:

```bash
grep -r "^updated:" docs --include="*.md" \
  | grep -v "docs/templates/" \
  | sort -t: -k2
```

Flag notes with `updated` dates older than 60 days for manual review.

## Step 4: Find quietly-implemented concepts

Look for concept notes with `status: ideating`, `maturity: seed`, or `maturity: developing`
that have corresponding specs now at `status: implemented`:

```bash
grep -rl "type: concept" docs --include="*.md"
```

Cross-reference with implemented specs to find promotable concepts.

## Step 4b: Check index pages are current

Each content directory has an index page that must reflect current contents:
- `docs/concepts/index.md`
- `docs/specs/index.md`
- `docs/decisions/index.md`
- `docs/guides/index.md`
- `docs/user-docs/index.md`
- `docs/reference/index.md`

For each index page, check that every note in the directory has an entry. Flag any
missing entries as issues in the audit report.

## Step 4c: Check user-doc coverage

Every spec with `impl-pr` set (i.e. implemented features) should have a corresponding
user-doc in `docs/user-docs/`, unless the feature is internal-only (documented in an ADR).

```bash
grep -rl "impl-pr:" docs/specs --include="*.md"
```

For each implemented spec, check whether a user-doc exists for it. Flag gaps.

## Step 4d: Check architecture doc freshness

```bash
grep "^updated:" docs/reference/architecture.md 2>/dev/null | head -1
```

Flag if `docs/reference/architecture.md` has not been updated in more than 90 days, or
if significant specs have been implemented since its last update date.

## Step 5: Produce audit report

Output a structured report:

```
## Vault Audit — [date]

### Orphaned Notes (N)
- docs/path/to/note.md — last updated YYYY-MM-DD

### Stale Statuses (N)
- docs/path/to/note.md — status: planned, but feature exists in codebase

### Overdue for Review (N)
- docs/path/to/note.md — last updated YYYY-MM-DD (N days ago)

### Concepts to Promote (N)
- docs/concepts/idea.md — related spec is implemented; consider promoting

### Index Pages Out of Date (N)
- docs/concepts/index.md — missing entry for: concept-slug
- docs/specs/index.md — missing entry for: spec-slug
- docs/decisions/index.md — missing entry for: ADR-NNN-slug
- docs/user-docs/index.md — missing entry for: user-doc-slug

### Missing User-Docs (N)
- docs/specs/feature-slug.md — impl-pr set but no corresponding user-doc found

### Architecture Doc (status)
- Last updated: YYYY-MM-DD — [current / overdue for review]

### Recommended Actions (prioritised)
1. [Highest priority fix]
2. [Second priority]
```

## Step 6: Fix or defer

For each finding, either:
- **Fix now** — update the note (status, links, content)
- **Defer** — Create a concept note with `type: concept, status: parked`, tagged with the relevant domain from `docs/meta/claude-context.md`, so it isn't lost
