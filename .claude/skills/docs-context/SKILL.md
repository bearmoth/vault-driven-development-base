---
name: docs-context
description: >
  Use before starting any non-trivial task. Loads relevant vault context
  so Claude understands the current project state, active decisions, and
  related specs before touching any code or docs.
---

# docs-context — Load Vault Context

Load the vault context relevant to the current task. Do this before writing any code or docs.

## Step 1: Read the project brain

Read `docs/meta/claude-context.md` in full.

Note:
- The project description and tech stack (including test, lint, and build commands)
- All defined domains and what they cover
- What is currently in focus
- All active specs (read any that are relevant to the current task)
- Key decisions (read any ADRs relevant to the current task)

## Step 2: Identify relevant domains

Based on the task at hand, which domains does it touch? List them — this scopes your vault search.

## Step 3: Find related vault notes

Search for notes matching the relevant domains. Prioritise:
1. Specs with `status: in-progress` or `status: planned` in relevant domains
2. ADRs with matching domains
3. Concepts with `maturity: fleshed-out` or `developing` in relevant domains
4. Concepts with `status: parked` that have a Design Influence section relevant to this task

Run this once per domain identified in Step 2:

```bash
grep -rl "domain:.*<domain-name>" docs/ --include="*.md" \
  | grep -v "docs/templates/"
```

## Step 4: Read the most relevant notes

Read up to 5 notes most directly relevant to the task. Follow wikilinks one level deep if
they point to something you haven't read yet.

Pay attention to:
- Concepts with `status: parked` — they exist to inform adjacent design decisions
- ADRs — they explain *why* things are the way they are

## Step 5: Summarise what you've learned

Before proceeding, form an internal summary:
- What does the project do?
- What is currently in progress that might be affected?
- Are there parked concepts or ADRs that should influence this work?
- What are the test/lint commands needed for verification?
