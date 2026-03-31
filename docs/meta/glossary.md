---
title: "Glossary"
type: reference
domain: []
status: stable
confidence: stable
context: on-demand
related: ["[[conventions]]", "[[claude-context]]"]
tags: [type/reference, status/stable]
created: {{date}}
updated: {{date}}
---

## Document Types

### Concept
A captured idea or mental model. Lives in `docs/concepts/`. Has a [[glossary#maturity|maturity]]
lifecycle independent of its [[glossary#status|status]]. Concepts may never become specs — that
is fine. Their value is as permanent reference points in the knowledge graph that inform design
decisions in related work.

### Spec
A formal, buildable description of a feature or change. Lives in `docs/specs/`. Contains EARS
requirements, a task breakdown, and acceptance criteria. Specs progress linearly:
`planned → in-progress → implemented`.

### ADR (Architecture Decision Record)
A permanent record of a significant technical decision. Lives in `docs/decisions/`. Numbered
sequentially (`ADR-001-slug.md`). Never deleted — superseded ADRs are marked `deprecated` with
a link to their replacement. See [[conventions]] for supersession rules.

### Guide
Step-by-step instructions for a task. Lives in `docs/guides/`. Describes currently-existing
behaviour (`status: implemented`). Use `status: draft` if writing a guide for something not yet
built.

### Milestone
A bundle of related specs with a shared theme and target date. Lives in
`docs/product/milestones/`. Used to coordinate scope and communicate progress.

---

## Status Values

### `ideating`
The note is being actively explored. Open questions are expected and normal. Applies to concepts
that are still fuzzy and to specs before requirements are agreed.

### `parked`
*(Concept-specific.)* The idea is well-understood but is not on the near-term roadmap. Use this
when you want the concept to exist as a design consideration for adjacent work without committing
to building it. A parked concept is a deliberate deferral, not abandonment. Typically paired with
`maturity: fleshed-out`.

### `planned`
Work is committed and scoped. For specs: requirements are written and approved by a human. For
milestones: scope is decided. Implementation has not started.

### `in-progress`
Implementation is underway. For specs: the first task in the task breakdown has been started.

### `implemented`
Work is complete, merged, and verified. For specs: all acceptance criteria are checked off and
`impl-pr` is filled. For milestones: all member specs are `implemented`.

### `deprecated`
Superseded by something newer. The note remains for historical context. For ADRs: the new ADR
carries a `supersedes` link pointing here. For specs: `replaced-by` on this note and `replaces`
on the new spec form the link pair.

### `archived`
No longer active or relevant. Used for cancelled specs, closed milestones, and abandoned concepts.

---

## Maturity Values

Maturity applies only to **concept** notes. It tracks depth of understanding, independent of
whether the concept is being actively worked on.

### `seed`
Just captured. Very fuzzy. Many open questions dominate. Not yet stable enough to meaningfully
inform design in other areas.

### `developing`
Being actively explored. The shape is forming. Some open questions remain but the core idea is
becoming clearer and beginning to feel real.

### `fleshed-out`
Stable mental model. Well-understood and internally consistent. Ready to inform design decisions
in related features even if there are no plans to build it yet. The canonical state for a parked
future feature: `status: parked, maturity: fleshed-out`.

---

## Workflow Terms

### EARS (Easy Approach to Requirements Syntax)
A structured format for writing unambiguous, testable requirements. Used in spec Requirements and
Acceptance Criteria sections. Core rule: if you cannot write a test for a requirement, rewrite
the requirement. See the spec template for full pattern reference.

### Domain
A named scope of the project (e.g. `auth`, `payments`, `infra`). Domains are defined in
[[claude-context]]. Claude checks this list before tagging a note. New domains are proposed first
— no silent sprawl.

### Tech Debt
A deliberate shortcut taken during implementation that creates future risk. When incurred, capture
it immediately as a concept note (`status: parked`, trade-off described in the body) so it exists
as a named thing in the knowledge graph rather than disappearing into a comment.

### Wikilink
An Obsidian internal link: `[[note-name]]`. Creates a navigable graph edge. Add wikilinks inline
as concepts are mentioned — not only in the Related section. Graph view and backlinks derive their
value from these links.

---

## Related

- [[conventions]]
- [[claude-context]]
