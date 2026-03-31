# [Project Name]

> One-paragraph description of what this project is and does.

## Vault

The `docs/` directory is an Obsidian vault and the **single source of truth** for all project knowledge. Before starting any task, read:

`docs/meta/claude-context.md` — project state, active domains, current focus, key decisions.

## Documentation Rules

- All non-inline documentation lives in the vault. No ad-hoc notes elsewhere.
- Every vault note must have complete frontmatter: `type`, `status`, `domain`, `updated`.
- Link concepts with [[wikilinks]] inline as you write — not just in the Related section.
- `status` must reflect reality. `ideating` ≠ `planned` ≠ `implemented`. Keep it honest.
- When a spec moves to `implemented`, update `claude-context.md` and link the PR via `impl-pr`.
- Domains are defined in `claude-context.md`. Propose new ones before using them; don't invent silently.

## Reading Large Files

When reading large files, run `wc -l` first to check the line count. If the file is over 2,000 lines, use the `offset` and `limit` parameters on the Read tool to read chunks rather than attempting to read the entire file at once.

## Inline Documentation

- Maintain JSDoc / RustDoc / language-appropriate inline docs on all public APIs.
- Inline docs describe *how* (signatures, parameters, behaviour). The vault describes *why*.
- When you change a public API, update its inline docs in the same commit.

## Skills — When to Use Them

| Skill | When |
|---|---|
| `docs-init` | Once, when setting up this project for the first time |
| `docs-context` | Before starting any non-trivial task |
| `docs-ideate` | When exploring an idea that isn't yet a spec |
| `docs-decide` | When making any architectural or significant technical decision |
| `docs-new` | When creating a spec, guide, runbook, reference, or milestone note |
| `docs-review` | After completing any task — non-negotiable |
| `docs-audit` | Periodically, or before any milestone |

## Done Checklist

Before closing any task, confirm **all** of the following:

- [ ] Tests pass
- [ ] Linting passes
- [ ] Changes reviewed for quality, maintainability, and alignment with roadmap
- [ ] Inline docs updated for any changed public APIs
- [ ] `docs-review` completed — vault notes updated, `updated` dates bumped, statuses accurate, wikilinks in place
- [ ] `claude-context.md` reflects current project state

## Agile + Roadmap

- Active milestone lives in `docs/product/milestones/`. Check it when prioritising tasks.
- Unexpected tasks are fine — update the milestone note to reflect scope changes.
- `docs/product/roadmap.md` is the long-horizon view. Don't lose sight of it.
