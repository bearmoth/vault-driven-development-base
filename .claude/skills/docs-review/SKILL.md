---
name: docs-review
description: >
  Use after completing any task. Reviews and updates all affected vault notes,
  validates the done checklist (tests, linting, quality), and updates claude-context.md.
  This is non-negotiable — run it before closing every task.
---

# docs:review — Post-Task Review

Run this after every task. Cover all four areas below before declaring done.

## Area 1: Code quality gate

Verify the following before touching docs:

1. **Tests pass** — run the project's test suite. Do not skip. If tests fail, fix them first.
2. **Linting passes** — run the project's linter. Fix all errors (warnings are judgment calls).
3. **Quality review** — read through your changes with fresh eyes:
   - Is the code maintainable? Would someone unfamiliar with this task understand it in 6 months?
   - Does it align with the roadmap and active milestone?
   - Are there any shortcuts taken that will hurt later? If so, create a concept note capturing the tech debt.
4. **Inline docs** — did you change any public API signatures? If yes, update JSDoc / RustDoc / docstrings now.

If any of the above fail, fix them before proceeding.

## Area 2: Vault note updates

Identify which vault notes are affected by the task just completed. For each:

1. **Update `status`** if it no longer reflects reality:
   - `in-progress` spec now fully implemented → `implemented`
   - `ideating` concept now committed to → `planned`
2. **Bump `updated` date** to today for any note that changed
3. **Check wikilinks** — are there notes that should now link to something new but don't? Add missing wikilinks.
4. **Link the PR** — if a spec moved to `implemented`, add `impl-pr: "owner/repo#NNN"` to its frontmatter
5. **Mirror domain tags** — if you added/changed `domain` values, ensure `tags` reflects them

## Area 3: New docs needed?

Did the task produce anything worth documenting?
- A non-obvious architectural pattern → concept note via docs-ideate
- A runbook or deployment step → guide note via docs-new
- A significant decision made mid-task → ADR via docs-decide

Invoke the relevant skill immediately — do not defer to the user unless you need information to complete the note.

## Area 4: Update claude-context.md

- **Current Focus** — reflect what is now in progress (or that this task is done)
- **Active Specs** — remove `implemented` specs; add any new in-progress specs
- **Key Decisions** — add any new ADRs from this task
- **`updated`** — set to today

## Done

Once all four areas are complete, confirm to the user:
- What vault notes were updated and how
- Whether any new notes were created
- That the done checklist is satisfied
