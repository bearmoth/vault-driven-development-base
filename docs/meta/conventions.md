---
title: "Project Conventions"
type: reference
domain: []
status: stable
confidence: stable
context: on-demand
related: ["[[Project Context]]"]
tags: [type/reference, status/stable]
created: {{date}}
updated: {{date}}
---

## Code Conventions

> Document project-specific coding standards here (naming, structure, patterns).
> Do not duplicate language-standard conventions — only document what's project-specific.

## Documentation Conventions

- All non-inline documentation lives in `docs/`.
- Every vault note requires: `type`, `status`, `domain`, `updated`.
- Wikilink concepts inline as you write — not just in the Related section.
- Tags mirror frontmatter fields: `status/in-progress`, `domain/auth`, `type/spec`.
- New domains must be proposed in `claude-context.md` before use.

### Frontmatter Schema

Valid values for key fields:

**type:** `adr` | `spec` | `guide` | `concept` | `roadmap` | `milestone` | `backlog` | `reference` | `runbook`

**status:** `ideating` | `planned` | `in-progress` | `implemented` | `deprecated` | `archived`

**confidence:** `speculative` | `draft` | `stable` | `canonical`

**context:** `always-load` | `on-demand` *(default: on-demand)*

**Tags must mirror structured fields.** When you set `domain: [auth, payments]`, add `domain/auth` and `domain/payments` to the `tags` array. Same for `status` and `type`. Example:
```yaml
domain: [auth]
status: in-progress
type: spec
tags: [type/spec, status/in-progress, domain/auth]
```

## Git Conventions

> Document branch naming, commit message format, PR conventions here.

## Related

- [[Project Context]]
