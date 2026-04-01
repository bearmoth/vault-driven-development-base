---
title: "Architecture Overview"
type: reference
domain: []
status: draft
confidence: draft
context: on-demand
related: ["[[claude-context]]", "[[conventions]]"]
tags: [type/reference, status/draft]
created: {{date}}
updated: {{date}}
---

<!--
This document describes the CURRENT architecture of the system. It must always reflect reality — update it in the same commit as any change that:
- Adds, removes, or renames a major component
- Changes how data flows between components
- Introduces a new external dependency
- Changes deployment topology

Run docs-init to populate this with your project's real architecture.
-->

## System Shape

> Describe the overall shape of the system in 2–3 sentences. What kind of system is it? (e.g. monolith, microservices, event-driven, client-server, CLI tool + server, etc.)

## Components

> List the major components and what each one does.

| Component | Purpose |
|---|---|
| | |

## Data Flow

> Describe how data flows through the system for the primary use case. Add a canvas diagram link here if one exists: ![[architecture.canvas]]

## External Dependencies

> List external services, APIs, databases, or infrastructure the system depends on.

| Dependency | Purpose | Notes |
|---|---|---|
| | | |

## Key Constraints

> What architectural constraints shape the design? (e.g. must be horizontally scalable, must work offline, regulated data handling, etc.)

## Related

- [[claude-context]] — project state and active focus
- [[decisions]] — ADRs that explain why the architecture is shaped this way
