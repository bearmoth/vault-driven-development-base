---
title: "Domain Glossary"
type: reference
domain: []
status: draft
confidence: draft
context: on-demand
related: ["[[meta/glossary]]", "[[claude-context]]"]
tags: [type/reference, status/draft]
created: {{date}}
updated: {{date}}
---

<!--
This glossary defines domain-specific terms used in this project's code, specs, and ADRs. It is distinct from docs/meta/glossary.md, which defines vault vocabulary.

When to add a term:
- A new spec uses a term that isn't obvious to someone joining the project
- A codebase concept has a specific meaning that differs from common usage
- A term is easily confused with another

Format for each term:
  **Term**
  Definition: one clear sentence.
  Usage: example of how it appears in code or specs.
  Contrast with: related terms that are easily confused.
  Related: [[wikilink]] to spec or concept that introduced this term.

Run docs-init to seed this with terms for your project's domains.
-->

## Glossary

> Add domain-specific terms here as they emerge from specs and implementation. Keep definitions precise and grounded in how the term is actually used in this codebase.

<!-- Example structure:

### auth

**Session**
Definition: A server-side record associating a user identity with an active authentication state.
Usage: Created on successful login; invalidated on logout or expiry.
Contrast with: Token (a session may be represented by a token, but they are not the same concept).
Related: [[ADR-001-use-jwt-tokens]]

-->

*(no terms defined yet — add entries as the project's domain vocabulary emerges)*

## Related

- [[meta/glossary]] — vault vocabulary (workflow terms, status values, document types)
- [[claude-context]] — project domains that scope this glossary
