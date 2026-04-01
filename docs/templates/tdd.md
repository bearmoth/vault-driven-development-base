---
title: ""
type: tdd
domain: []
status: draft
confidence: draft
context: on-demand
spec: "[[spec-slug]]"
related: []
tags: [type/tdd, status/draft]
created: {{date}}
updated: {{date}}
---

<!--
type: tdd — Technical Design Document

A TDD answers HOW the feature will be built. It lives between concept (what problem) and spec (testable requirements). Use it for complex or architecturally significant features; skip it for simple ones. That choice is always the human's.

TDDs are LIVING during implementation — update in Stage 3b when the implementation diverges from the design. A TDD that doesn't match what was built is misleading.

status progression:
  draft        — design in progress; open questions may be unresolved
  in-progress  — implementation is underway; update as design evolves
  implemented  — implementation complete and TDD reflects what was built
-->

## Problem Statement

What specific technical problem does this TDD solve? One paragraph. Reference the parent spec via [[spec-slug]].

## Proposed Approach

High-level description of the implementation approach. Why this over alternatives? Summarise in 2–4 sentences; detail lives in the sections below.

## Module / Component Design

Describe the key modules, classes, functions, or services involved.

```
<!-- pseudocode, module map, or class diagram -->
```

## Data Flow

How does data move through the system for the primary use case?

```
<!-- sequence diagram, flow description, or request/response trace -->
```

## Key Trade-offs

| Decision point | Option chosen | Reason | What becomes harder |
|---|---|---|---|
| | | | |

> Any significant trade-off here → stop and run `docs-decide` to create an ADR.

## Alternatives Considered

What other approaches were evaluated and rejected? Why?

## Open Questions

What remains unresolved before or during implementation?

## Related

- [[spec-slug]] — the spec this TDD supports
