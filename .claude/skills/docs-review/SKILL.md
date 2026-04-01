---
name: docs-review
description: >
  Use after completing any task. Reviews and updates all affected vault notes,
  validates the done checklist (tests, linting, quality), and updates claude-context.md.
  This is non-negotiable — run it before closing every task.
---

# docs-review — Post-Task Review

Run this after every task. Cover all four areas below before declaring done.

## Area 1: Code quality gate

Verify the following before touching docs:

1. **Tests pass** — run the project's test suite (command in `claude-context.md` → Tech Stack). Do not skip. If tests fail, fix them first.
2. **Linting passes** — run the project's linter. Fix all errors (warnings are judgment calls).
3. **Quality review** — dispatch the `code-reviewer` agent (Agent tool, `subagent_type: code-reviewer`). Prompt it with:
   - The diff of your changes (`git show HEAD` for committed work, `git diff --staged` for staged-but-uncommitted work)
   - A note of what the task was trying to achieve

   The agent checks correctness, security, maintainability, and performance against this project's CLAUDE.md conventions. If it returns NEEDS WORK, fix before proceeding. Any 🔴 blockers are treated as test failures — do not proceed to Area 2.

   Also check: does this decision align with the active milestone and not foreclose planned future directions? Check `docs/product/roadmap.md`. If a shortcut creates future risk, create a concept note for the tech debt (`status: parked`, trade-off in body).
4. **Inline docs** — did you change any public API signatures? Update them now.
5. **Living docs audit** — identify every reference doc or user-doc that describes behaviour you changed. List them explicitly. Verify each is current. This step is not optional — do not proceed to Area 2 until you have checked each affected doc.

If any of the above fail, fix them before proceeding.

## Area 2: Vault note updates

Identify which vault notes are affected. For each:

1. **Update `status`** if it no longer reflects reality:
   - Spec fully implemented → `implemented`
   - Concept being committed to → `planned` (only if the human has explicitly decided to build it)
   - Concept well-understood but deprioritised → `parked`
2. **Bump `maturity`** on concept notes if understanding has deepened
3. **Bump `updated` date** to today for any note that changed
4. **Check wikilinks** — are there notes that should link to something new but don't?
5. **Link the PR** — if a spec moved to `implemented`, add `impl-pr: "owner/repo#NNN"`
6. **Mirror tags** — if `domain`, `status`, or `maturity` changed, update `tags` to match

## Area 3: New docs needed?

Did the task produce anything worth documenting?
- A non-obvious architectural pattern → concept note via `docs-ideate`
- A runbook or deployment step → guide note via `docs-new`
- A significant decision made mid-task → ADR via `docs-decide`

Invoke the relevant skill immediately — do not defer unless you need information from the user.

**After creating any new note, update the corresponding index page:**
- New concept note → add entry to `docs/concepts/index.md`
- New spec or TDD → add entry to `docs/specs/index.md`
- New guide or runbook → add entry to `docs/guides/index.md`
- New user-doc → add entry to `docs/user-docs/index.md`
- New reference doc → add entry to `docs/reference/index.md`

**User-facing behaviour check:** Did this task change anything a user, API consumer, or admin would experience? If yes, create or update the relevant user-doc in `docs/user-docs/`. A missing or stale user-doc is not "good enough for now" — it is a defect.

**TDD check:** Was a TDD written for this feature? Does it now reflect what was actually built? If implementation diverged, update the TDD before closing (Stage 3b protocol).

**Architecture check:** Did this task change the system's shape, data flow, or external dependencies? If yes, update `docs/reference/architecture.md`.

Index pages are the entry point for human readers browsing the vault. They must stay current — an undiscoverable note is effectively lost.

## Area 4: Update claude-context.md and close-out docs

- **Current Focus** — reflect what is now in progress (or that this task is done)
- **Active Specs** — remove `implemented` specs; add any new in-progress specs
- **Key Decisions** — add any new ADRs from this task
- **`updated`** — set to today
- **Specs index** — if a spec moved to `implemented`, move its entry in `docs/specs/index.md` from In Progress/Planned → the Implemented section under the correct milestone

**Milestone close:** If this is the last spec in a milestone:
1. Set milestone `status: implemented`
2. Populate the `## Retrospective` section: link all implemented specs, link ADRs from this milestone, write a short "What we learned" note, list any explicitly deferred work
3. Run `docs-audit` to catch any remaining drift before declaring the milestone done

## Done

Once all four areas are complete, confirm to the user:
- What vault notes were updated and how
- Whether any new notes were created
- That the done checklist is satisfied
