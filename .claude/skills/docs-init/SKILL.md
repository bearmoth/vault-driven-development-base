---
name: docs-init
description: >
  Use once when setting up a new project for the first time.
  Personalises the vault template with real project information.
  Do NOT use on an already-initialised project — use docs-context instead.
---

# docs-init — Project Vault Initialisation

You are personalising this project's Obsidian vault template with real content.
The folder structure already exists. Your job is to fill it in.

## Step 1: Gather project information

Ask the user for the following, one at a time:
1. **Project name** — what should the project be called?
2. **Project description** — one paragraph: what does this project do and why does it exist?
3. **Initial domains** — what are the main areas of this system? (e.g. auth, payments, infra). Aim for 3–7.
4. **Tech stack** — key languages, frameworks, and infrastructure choices.
5. **Commands** — what commands run tests, lint, and build? (Claude needs these to verify work.)
6. **Founding decisions** — any significant technical decisions already made? (These will become ADRs.)
7. **External users** — does this project have external users (end users, API consumers, admins)?
   If yes, which audiences? (This seeds the user-docs index sections.)
8. **System shape** — high-level: what kind of system is this? (e.g. web app + API, CLI tool,
   microservices, library) — seeds the architecture overview.

## Step 2: Update CLAUDE.md

Replace the placeholder `[Project Name]` and description paragraph in `CLAUDE.md` with real values.

## Step 3: Update README.md

Replace `[Project Name]` and the description in `README.md` with real values.

## Step 4: Populate claude-context.md

Write real content into `docs/meta/claude-context.md`:
- **Project** section: the user's description
- **Domains** section: each domain with a one-line description
- **Tech Stack** section: languages, frameworks, and test/lint/build commands
- **Current Focus**: "Initial project setup"
- Leave Active Specs and Key Decisions empty for now
- Set `updated` to today (replace `{{date}}` — Obsidian Templates does not auto-resolve this)

## Step 5: Create founding ADR(s)

For each significant technical decision the user mentioned, create an ADR:
- File: `docs/decisions/ADR-001-<decision-slug>.md` (auto-increment if multiple)
- Use `docs/templates/adr.md`; fill all fields — no placeholders
- After each ADR, add a link in `docs/meta/claude-context.md` under Key Decisions

## Step 6: Stub the roadmap

Update `docs/product/roadmap.md`:
- Replace the Vision placeholder with a real sentence about where this project is going
- Leave milestones empty — they'll be added as the project takes shape

## Step 6b: Initialise index pages and reference stubs

The vault has index pages for each content area and reference stubs that need project-specific
context. Update each:

**Index pages** — replace the generic overview sentence with one project-specific sentence:
- `docs/concepts/index.md` — describe what kinds of concepts this project is likely to explore
- `docs/guides/index.md` — describe the developer/ops context for guides
- `docs/reference/index.md` — describe what system components will have reference docs
- `docs/specs/index.md` — describe the feature delivery cadence (milestones, sprints, etc.)
- `docs/decisions/index.md` — no change needed; generic text is fine
- `docs/user-docs/index.md` — if the project has external users, replace audience section
  headings with the real audiences gathered in Step 1 item 7; otherwise add a note that
  this project is internal-only and user-docs are not maintained

**Reference stubs** — populate with real project content:
- `docs/reference/architecture.md` — replace placeholder sections with the system shape
  from Step 1 item 8; add real components, initial data flow description, and known constraints
- `docs/reference/domain-glossary.md` — seed with 2–5 key domain terms per domain from
  Step 1 item 3; definitions don't need to be perfect — they will evolve

Leave all index entries as `*(none yet)*` — they fill in as the project grows.

## Step 7: Confirm

Tell the user:
- What was created and updated
- How to open `docs/` as an Obsidian vault
- That future sessions start with `docs-context`
- That the Done Checklist in `CLAUDE.md` applies to all tasks
- Quick reference:
  - `docs-ideate` — capture and evolve ideas
  - `docs-decide` — record architectural decisions (ADRs)
  - `docs-new` — create specs, TDDs, guides, user-docs, reference docs, milestones
  - `docs-review` — close any task (non-negotiable)
  - `docs-audit` — periodic vault health check
- Browsable vault entry points: `docs/concepts/index.md`, `docs/specs/index.md`,
  `docs/decisions/index.md`, `docs/guides/index.md`, `docs/user-docs/index.md`,
  `docs/reference/index.md`
