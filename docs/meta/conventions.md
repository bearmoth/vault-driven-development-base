---
title: "Project Conventions"
type: reference
domain: [meta]
status: stable
confidence: stable
context: on-demand
related: ["[[claude-context]]", "[[glossary]]"]
tags: [type/reference, status/stable, domain/meta]
created: 2026-03-31
updated: 2026-03-31
---

## Code Conventions

> Document project-specific coding standards here (naming, structure, patterns).
> Do not duplicate language-standard conventions — only document what's project-specific.

## Documentation Conventions

- All non-inline documentation lives in `docs/`. No ad-hoc notes elsewhere.
- Every vault note requires: `type`, `status`, `domain`, `updated`.
- Wikilink concepts inline as you write — not just in the Related section.
- Tags mirror frontmatter fields: `status/in-progress`, `domain/auth`, `type/spec`.
- New domains must be proposed in `claude-context.md` before use.
- `status` must reflect reality. `ideating` ≠ `planned` ≠ `implemented`.
- Inline docs describe *how* (signatures, behaviour). The vault describes *why*.

### Living Documentation Contract

Different doc types have different relationships to time and system state:

| Doc type | Describes | Update trigger |
|---|---|---|
| **Reference** | Current system state — APIs, schemas, config, data models | Same PR as the implementation that changes it |
| **Guide** | How to perform a task against the current system | Same PR as any system change that affects the procedure |
| **User-doc** | How end users, API consumers, or admins use a feature | Same PR as any change to user-facing behaviour |
| **TDD** | How a feature will be built technically | Updated in Stage 3b when implementation diverges |
| **Spec** | What was agreed to build | Frozen at `implemented`; never retroactively edited |
| **ADR** | Why a decision was made | Immutable; supersede with a new ADR if the decision changes |
| **Concept** | Evolving understanding of an idea | Updated via Exploration Log entries; status/maturity promoted as understanding deepens |

**Reference docs, guides, and user-docs must reflect current reality.** A document that has drifted from the system is not just outdated — it is actively misleading. When an implementation changes the system, the affected documents are updated in the same commit.

**Enforcement:** The frontmatter validator exits non-zero when `type` or `status` is missing (hard error). Missing `domain` or other fields produce a warning. The pre-commit hook reminds you to check which reference docs and user-docs describe the behaviour you just changed.

### Index Pages

Each content directory has a root index page:
- [[concepts/index]] — browsable list of all concept notes by status and domain
- [[guides/index]] — browsable list of all guides and runbooks
- [[reference/index]] — browsable list of all reference docs

When you add a new note to any of these directories, add an entry to the corresponding index page in the same commit. Index pages must always reflect the current contents of their directory.

### Frontmatter Schema

Valid values for key fields:

**type:** `adr` | `spec` | `tdd` | `guide` | `concept` | `roadmap` | `milestone` | `backlog` | `reference` | `runbook` | `user-doc`

**status:** `ideating` | `parked` | `planned` | `in-progress` | `implemented` | `deprecated` | `archived`

**confidence:** `speculative` | `draft` | `stable` | `canonical`

**maturity** *(concept notes only):* `seed` | `developing` | `fleshed-out`

**context:** `always-load` | `on-demand` *(default: on-demand)*

See [[glossary]] for definitions of each value.

**Tags must mirror structured fields.** When you set `domain: [auth, payments]`, add `domain/auth` and `domain/payments` to the `tags` array. Same for `status`, `type`, and `maturity`. Example:
```yaml
domain: [auth]
status: in-progress
type: spec
tags: [type/spec, status/in-progress, domain/auth]
```

### ADR Supersession

| Doc type | How changes are recorded |
|---|---|
| ADR | `supersedes` on the new ADR; old ADR gets `status: deprecated` |
| Spec (major rewrite) | `replaces` on new spec; `replaced-by` + `status: deprecated` on old |
| Concept / guide | Update in-place; bump `updated` date |
| Milestone | `status: archived` when restructured; history lives in git |

## Git Conventions

> Document branch naming, commit message format, and PR conventions here.

## Related

- [[claude-context]]
- [[glossary]]
