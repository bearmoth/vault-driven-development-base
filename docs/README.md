# [Project Name] — Documentation Vault

> [One-sentence project description — run docs-init to populate this.]

This folder is an [Obsidian](https://obsidian.md) vault containing all project documentation: architecture decisions, feature specs, concept explorations, guides, and user-facing docs.

---

## Vault Structure

| Directory | Contents |
|---|---|
| `meta/` | Project context, conventions, glossary — start here |
| `concepts/` | Ideas under exploration, not yet specs |
| `decisions/` | Architecture Decision Records (ADRs) |
| `guides/` | How-to guides and operational runbooks |
| `product/` | Roadmap and milestone notes |
| `reference/` | Architecture overview, domain glossary, API/schema reference |
| `specs/` | Feature specs and Technical Design Documents |
| `templates/` | Templates used by Claude skills (not browsable content) |
| `user-docs/` | End-user, API consumer, and admin documentation |

---

## Start Here

**[`meta/claude-context.md`](meta/claude-context.md)** — live project state: active domains, current focus, key decisions, and commands Claude needs to work in this repo.

---

## Using with Obsidian

Open the `docs/` folder as a vault in Obsidian to get graph view, backlinks, and Bases queries. All files are plain markdown and readable without Obsidian.

---

## Using with Claude Code

Every Claude Code session starts with `/docs-context` to load current project state.

Available skills: `docs-init` · `docs-ideate` · `docs-decide` · `docs-new` · `docs-review` · `docs-audit`
