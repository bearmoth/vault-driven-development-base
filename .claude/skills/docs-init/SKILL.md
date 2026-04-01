---
name: docs-init
description: >
  Use once when setting up a new project for the first time.
  Personalises the vault template with real project information.
  Do NOT use on an already-initialised project — use docs-context instead.
---

# docs-init — Project Vault Initialisation

You are personalising this project's Obsidian vault template with real content. The folder structure already exists. Your job is to fill it in.

## Step 1: Gather project information

Before anything else, ask:

**Is this a new project, or are you adopting this template into an existing codebase?**
- **New project**: proceed with all steps below.
- **Adopting** (existing codebase already has its own README): skip Step 3. At Step 7, note which README sections the user should add manually if missing.

Then ask the following, one at a time:
1. **Project name** — what should the project be called?
2. **Project description** — one paragraph: what does this project do and why does it exist?
3. **Initial domains** — what are the main areas of this system? (e.g. auth, payments, infra). Aim for 3–7.
4. **Tech stack** — key languages, frameworks, and infrastructure choices.
5. **Commands** — what commands run tests, lint, and build? (Claude needs these to verify work.)
6. **Founding decisions** — any significant technical decisions already made? (These will become ADRs.)
7. **External users** — does this project have external users (end users, API consumers, admins)? If yes, which audiences? (This seeds the user-docs index sections.)
8. **System shape** — high-level: what kind of system is this? (e.g. web app + API, CLI tool, microservices, library) — seeds the architecture overview.

## Step 2: Update CLAUDE.md

Replace the placeholder `[Project Name]` and description paragraph in `CLAUDE.md` with real values.

## Step 3: Update README.md and docs/README.md

*(Skip this step if the user indicated "adopting" in Step 1.)*

In `README.md`:
- Replace `[Project Name]` in the H1 with the real project name
- Replace the description blockquote with the real one-sentence description
- In **Quick Start → Install**, replace `[install command]` with the install command from the tech stack (Step 1). If unknown, leave as placeholder and note it in Step 7.
- In **Quick Start → First run**, replace with the test command from Step 1. Use the test command if one exists; otherwise the primary run command.
- In **Usage**, write 1–2 sentences describing the system shape and who uses it. Brief is fine — it seeds the section; the user will refine it.
- Leave Prerequisites, Contributing, License, and the badge comment as placeholders.

In `docs/README.md`:
- Replace `[Project Name]` in the H1 with the real project name
- Replace the bracketed description placeholder with the real one-sentence description

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

The vault has index pages for each content area and reference stubs that need project-specific context. Update each:

**Index pages** — replace the generic overview sentence with one project-specific sentence:
- `docs/concepts/index.md` — describe what kinds of concepts this project is likely to explore
- `docs/guides/index.md` — describe the developer/ops context for guides
- `docs/reference/index.md` — describe what system components will have reference docs
- `docs/specs/index.md` — describe the feature delivery cadence (milestones, sprints, etc.)
- `docs/decisions/index.md` — no change needed; generic text is fine
- `docs/user-docs/index.md` — if the project has external users, replace audience section headings with the real audiences gathered in Step 1 item 7; otherwise add a note that this project is internal-only and user-docs are not maintained

**Reference stubs** — populate with real project content:
- `docs/reference/architecture.md` — replace placeholder sections with the system shape from Step 1 item 8; add real components, initial data flow description, and known constraints
- `docs/reference/domain-glossary.md` — seed with 2–5 key domain terms per domain from Step 1 item 3; definitions don't need to be perfect — they will evolve

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
- Browsable vault entry points: `docs/concepts/index.md`, `docs/specs/index.md`, `docs/decisions/index.md`, `docs/guides/index.md`, `docs/user-docs/index.md`, `docs/reference/index.md`

If this was an **adoption** (existing project), remind the user which sections to add to their existing `README.md` if missing: Quick Start, Usage, Documentation (→ docs/), Development Workflow, Contributing, License.
