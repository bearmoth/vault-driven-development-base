---
name: docs-audit
description: >
  Use periodically or before any milestone. Scans the vault for health issues:
  orphaned notes, stale statuses, broken wikilinks, and docs that have drifted
  from reality. Produces a prioritised list of issues to fix.
---

# docs:audit — Vault Health Check

Audit the vault for drift, orphans, and stale content. Produce a prioritised report.

## Step 1: Dispatch parallel scan agents

These five scans are independent. Dispatch all five in a single message (parallel Agent tool calls):

**Agent A — Orphaned notes** (`subagent_type: Explore`):
```
Scan the vault at docs/ for orphaned notes — notes with zero inbound wikilinks from other vault notes.

For each .md file (excluding docs/templates/), check whether its slug appears as a [[wikilink]] in any other note.

These notes are intentionally standalone and must NOT be flagged as orphans:
- All index pages (*/index.md)
- docs/meta/claude-context.md, docs/meta/conventions.md, docs/meta/glossary.md
- docs/product/roadmap.md
- docs/reference/architecture.md, docs/reference/domain-glossary.md
- docs/README.md

Return a list of orphan candidates with their path and last `updated:` date.
```

**Agent B — Stale statuses** (`subagent_type: Explore`):
```
Scan docs/ for notes where status likely doesn't match reality.

Run:
  grep -rl "status: ideating\|status: planned\|status: in-progress" docs --include="*.md" | grep -v docs/templates/

For each result, read the note and assess whether the status is plausible given the note's content and the current vault state. Return a list of suspects with your reasoning.
```

**Agent C — Overdue reviews** (`subagent_type: Explore`):

*(Before dispatching, substitute today's date for `{{TODAY}}` in the prompt below.)*

```
Find vault notes not updated recently.

Run:
  grep -r "^updated:" docs --include="*.md" | grep -v docs/templates/ | sort -t: -k2

Today is {{TODAY}}. Return all notes with updated dates older than 60 days before that date. Include path and date.
```

**Agent D — Quietly-implemented concepts** (`subagent_type: Explore`):
```
Find concept notes (type: concept) with status: ideating, maturity: seed, or maturity: developing that may have been quietly implemented.

Run:
  grep -rl "type: concept" docs --include="*.md"

Then find all specs with status: implemented.

Cross-reference: flag any concept whose subject matter corresponds to an implemented spec. Return candidates with path and the corresponding spec.
```

**Agent E — Index, coverage, and freshness** (`subagent_type: vault-auditor`):
```
Run your full audit: index page completeness, user-doc coverage, architecture doc freshness, and invalid frontmatter values. Return findings in your standard report format.
```

## Step 2: Collect results and produce audit report

Wait for all five agents to complete. Merge their findings into the structured report:

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

### Index Pages (N issues)
- [from vault-auditor]

### Missing User-Docs (N issues)
- [from vault-auditor]

### Architecture Doc
- [from vault-auditor]

### Invalid Frontmatter (N issues)
- [from vault-auditor]

### Recommended Actions (prioritised)
1. [Highest priority fix]
2. [Second priority]
```

## Step 3: Fix or defer

For each finding, either:
- **Fix now** — update the note (status, links, content)
- **Defer** — Read `docs/meta/claude-context.md` to find the relevant domain, then create a concept note with `type: concept, status: parked` tagged to that domain, so it isn't lost
