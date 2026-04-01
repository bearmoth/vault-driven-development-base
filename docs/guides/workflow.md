---
title: "Development Workflow"
type: guide
domain: [meta]
status: implemented
confidence: stable
context: on-demand
related: ["[[claude-context]]", "[[conventions]]", "[[glossary]]"]
tags: [type/guide, status/implemented, domain/meta]
created: 2026-03-31
updated: 2026-03-31
---

## Overview

A structured, repeatable process from raw idea to shipped, documented code.

```
Ideation → Spec & Plan → [TDD?] → Implement → [Refine?] → Verify → Close
   ↑_______________________________________________________________|
```

Every stage has a defined skill to invoke, exit criteria, and a clear human gate before proceeding. **Claude never decides a stage is complete and moves to the next one.** Each transition requires an explicit human decision.

---

## Stage 0: Load Context

**Always first. No exceptions.**

**Skill:** `docs-context`

Read `docs/meta/claude-context.md`, surface relevant specs, ADRs, and [[glossary#parked|parked]] concepts that might influence the work. Note the tech stack commands for later verification.

**Exit criteria:** You can answer — what is in progress right now, and does this task conflict with or depend on it?

---

## Stage 1: Ideation

**Purpose:** Capture fuzzy ideas before they evaporate. This is exploration, not commitment.

**Skill:** `docs-ideate`

Creates or updates a [[glossary#concept|concept]] note in `docs/concepts/`. Concepts accumulate understanding over time via an Exploration Log — dated entries added inline, newest first. Related ideas are connected via [[glossary#wikilink|wikilinks]]; the graph view and backlinks panel make the concept network navigable without separate session files.

**Maturity progression** (see [[glossary]] for definitions):

| Maturity | Meaning |
|---|---|
| `seed` | Just captured, very fuzzy |
| `developing` | Shape is forming, actively being explored |
| `fleshed-out` | Stable mental model; ready to inform adjacent design |

A concept at `fleshed-out` + `status: parked` is the canonical form for a **future feature consideration** — well understood, not on the roadmap, but actively considered when designing related work. Claude surfaces these during `docs-context` when relevant.

**Human gate:** Claude never promotes a concept to a spec. When you decide an idea is ready to commit to, you say so and invoke `docs-new`.

**Exit criteria:** The idea is captured, linked, and open questions are explicit. You are not expected to resolve them here.

---

## Stage 2: Spec & Plan

**Purpose:** Turn a concept into a buildable contract with verifiable requirements.

**Skill:** `docs-new` (create spec), `docs-decide` (for design decisions), `docs-new` again (create milestone if needed)

### 2a. Create the spec

A spec is not a description — it is a **contract**. Every requirement must be written in [[glossary#ears|EARS]] format and be directly testable. If you cannot write an acceptance test for a requirement, rewrite the requirement.

The spec template enforces three structural sections:

- **Requirements** — EARS format, one per line, each with a REQ-ID
- **Task Breakdown** — ordered implementation tasks, each mapped to REQ-IDs
- **Acceptance Criteria** — one checkbox per REQ, verified at Stage 4

Incomplete specs produce incomplete implementations. `docs-new` will not finish until all three sections are properly populated.

### 2b. Record decisions

Any significant design decision made while writing the spec → `docs-decide` immediately. Don't defer.

### 2c. Link to milestone

Check `docs/product/roadmap.md`. Does this spec belong to the active milestone? If no milestone exists yet, create one with `docs-new`. Add the spec to the milestone's `specs:` list and add a link in `claude-context.md` → Active Specs.

**Human gate:** Implementation does not begin until you review and approve the spec. "Looks good, let's build it" is the gate.

**Exit criteria:** Requirements are EARS-formatted and testable. Task breakdown is ordered and REQ-mapped. Acceptance criteria are complete and unambiguous. No open questions that would block implementation.

---

## Stage 2b: Technical Design (optional)

**Purpose:** For complex or architecturally significant features, describe *how* the system will be built before committing to EARS requirements. Surfaces technical trade-offs and design decisions *before* implementation begins.

**Skill:** `docs-new` (type: tdd)

**When to use it:** The human decides. Signals that a TDD is needed:
- The feature involves multiple components or significant data flow changes
- Multiple implementation approaches exist with meaningful trade-offs
- The spec requirements are likely to change once the technical approach is understood

**When to skip it:** Simple features, single-file changes, well-understood patterns. Do not require a TDD — offer it.

A TDD covers: proposed approach, module/component design, data flow, key trade-offs, and alternatives considered. Significant trade-offs in the TDD → `docs-decide` immediately.

**TDDs are living during Stage 3.** When implementation diverges from the TDD, update the TDD in Stage 3b. A TDD that doesn't match what was built is misleading.

**Human gate:** Same as Stage 2 — implementation does not begin until the human approves. If a TDD was written, it is reviewed alongside the spec.

**Exit criteria:** Technical approach is agreed. No open questions that would block implementation. Significant design decisions have ADRs.

---

## Stage 3: Implement

**Purpose:** Build the spec, one task at a time. The spec's task list is the single source of truth for progress.

**Skill:** None dedicated — follow the loop below strictly.

### Before starting: dependency check

Check the spec's `depends-on` field. For each listed dependency:
- Is the dependency spec `status: implemented`? ✓ proceed
- Is it `status: in-progress` or `status: planned`? **Stop** — unblock the dependency first, or explicitly decide to proceed with known risk (document the risk as a concept note, `status: parked`)

Do not begin implementation on a spec with unmet dependencies without explicit human sign-off.

### Per-task loop

For each unchecked task in the spec's task breakdown:

1. **Read** the relevant EARS requirements for this task
2. **Implement** the change
3. **Test** — run the test suite (command in `claude-context.md` → Tech Stack). Fix failures before continuing.
4. **Checkpoint** — check off the task in the spec. Bump `updated`.

> Do not batch checkpoints. Mark each task done immediately.

### Mid-task decisions

Significant architectural decision encountered during implementation → **stop, run `docs-decide`**, then continue. Do not defer.

### Spec status

- First task started → set spec `status: in-progress`
- All tasks checked off → leave at `in-progress` until Stage 4 passes

**Exit criteria:** All tasks in the task breakdown are checked off. Tests pass after every task.

---

## Stage 3b: Refine (when needed)

**Purpose:** When implementation reveals that the spec was wrong, update the spec before continuing — not after, and not by quietly diverging from it.

**Skill:** `docs-decide` (if the divergence involves a significant design decision)

This stage is not always needed, but when it is, it is mandatory.

**Triggers** — stop and refine when:
- An EARS requirement turns out to be unimplementable as written
- A task reveals a dependency that wasn't in the spec
- The implementation approach must deviate significantly from the spec's intent

**What to do:**
1. **Stop** — do not continue implementing against a spec you know is wrong
2. **Update the spec** — revise the affected requirements, task breakdown, and acceptance criteria to reflect reality. Bump `updated`.
3. **Record the decision** — if the change is significant, run `docs-decide` to create an ADR
4. **Get human confirmation** — show the diff to the user before resuming Stage 3

> "Quietly diverging from the spec" is the same as having no spec. The spec is only useful if it matches what was actually built.

**Exit criteria:** The spec accurately reflects the plan going forward. Human has confirmed the change.

---

## Stage 4: Verify

**Purpose:** Confirm the implementation satisfies every requirement before declaring done.

**Skill:** `verification-before-completion`

1. **Run the full test suite.** All tests must pass.
2. **Run the linter.** Fix all errors.
3. **Check each acceptance criterion** in the spec, one by one. For each:
   - Identify the test(s) that cover it
   - If a criterion has no coverage, write the test or document why it's not applicable
4. **Quality review:**
   - Is the code maintainable and understandable without context?
   - Does it align with the active milestone *and not undermine future ones*? Check `docs/product/roadmap.md` — a decision that works now but forecloses a planned future direction is a problem.
   - Any shortcuts that create future risk? → concept note, `status: parked`
5. **Update inline docs** for any changed public APIs.

**Exit criteria:** All acceptance criteria checked off. Tests and lint pass. Inline docs current. Evidence in hand before claiming done.

---

## Stage 5: Close

**Purpose:** Update all docs to reflect reality. Leave the vault cleaner than you found it.

**Skill:** `docs-review`

1. Set spec `status: implemented`. Add `impl-pr: "owner/repo#NNN"`.
2. Update the originating concept note: bump `maturity` if understanding has deepened.
3. Update `claude-context.md`:
   - Remove spec from Active Specs
   - Update Current Focus
   - Add new ADRs to Key Decisions
   - Bump `updated`
4. Check the milestone: are all specs `implemented`? If yes, set milestone `status: implemented`.
5. Run `docs-audit` if this is the last spec in a milestone.

**Exit criteria:** Vault reflects reality. No stale statuses. `claude-context.md` is accurate for the next session.

---

## Skill Invocation Map

| You want to… | Invoke |
|---|---|
| Start any task | `docs-context` |
| Capture a new idea | `docs-ideate` |
| Revisit / develop an existing idea | `docs-ideate` |
| Record a decision | `docs-decide` |
| Formalise an idea into a spec | `docs-new` |
| Create a TDD for a complex feature | `docs-new` (type: tdd) |
| Create a guide, runbook, user-doc, or reference doc | `docs-new` |
| Implement (per-task loop) | Stage 3 protocol above |
| Spec needs updating mid-implementation | Stage 3b protocol above |
| Verify before claiming done | `verification-before-completion` |
| Close a task and update docs | `docs-review` |
| Periodic vault health check | `docs-audit` |
| Set up a brand-new project | `docs-init` (once only) |

---

## EARS Quick Reference

EARS (Easy Approach to Requirements Syntax) — structured format for unambiguous, testable requirements. See [[glossary]] for full definitions.

| Pattern | Template |
|---|---|
| Ubiquitous | The `<system>` shall `<response>`. |
| Event-driven | WHEN `<trigger>`, the `<system>` shall `<response>`. |
| State-driven | WHILE `<state>`, the `<system>` shall `<response>`. |
| Conditional | IF `<condition>`, THEN the `<system>` shall `<response>`. |
| Option | WHERE `<feature is enabled>`, the `<system>` shall `<response>`. |

**Rules:** "shall" = mandatory. Avoid untestable words: "fast", "reliable", "user-friendly". One requirement = one sentence. Every REQ must appear in Acceptance Criteria.

## Related

- [[claude-context]]
- [[conventions]]
- [[glossary]]
