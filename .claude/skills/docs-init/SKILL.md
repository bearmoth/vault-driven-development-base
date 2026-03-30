---
name: docs-init
description: >
  Use once when setting up a new project for the first time.
  Personalises the vault template with real project information.
  Do NOT use on an already-initialised project — use docs-context instead.
---

# docs:init — Project Vault Initialisation

You are personalising this project's Obsidian vault template with real content.
The folder structure already exists. Your job is to fill it in.

## Step 1: Gather project information

Ask the user for the following, one at a time:
1. **Project name** — what should the project be called?
2. **Project description** — one paragraph: what does this project do and why does it exist?
3. **Initial domains** — what are the main areas of this system? (e.g. auth, payments, infra, api, ui). Aim for 3–7.
4. **Tech stack** — key languages, frameworks, and infrastructure choices.
5. **Founding decisions** — any significant technical decisions already made? (These will become ADRs.)

## Step 2: Update CLAUDE.md

Replace the placeholder `[Project Name]` and description paragraph in `CLAUDE.md` (at the project root, alongside `docs/`) with real values.

## Step 3: Update README.md

Replace `[Project Name]` and the description in `README.md` with real values.

## Step 4: Populate claude-context.md

Write real content into `docs/meta/claude-context.md`:
- Replace the Project section with the user's description
- Replace the Domains section with the user's domains (each with a one-line description)
- Set Current Focus to "Initial project setup"
- Leave Active Specs and Key Decisions empty for now
- Set `updated` date to today
- Note: the `{{date}}` Obsidian placeholder in the template will NOT be resolved automatically — replace it with today's date in YYYY-MM-DD format when writing the file.

## Step 5: Create founding ADR(s)

For each significant technical decision the user mentioned, create an ADR:
- File: `docs/decisions/ADR-001-<decision-slug>.md` (auto-increment if multiple)
- Use the ADR template at `docs/templates/adr.md`
- Fill in all fields completely — no placeholders
- After creating each ADR, add a link to it in `docs/meta/claude-context.md` under Key Decisions

## Step 6: Stub the roadmap

Update `docs/product/roadmap.md`:
- Replace the Vision placeholder with a real sentence about where this project is going
- Leave milestones empty — they'll be added as the project takes shape

## Step 7: Confirm

Tell the user:
- What was created and updated
- How to open `docs/` as an Obsidian vault (point them at the `docs/` subdirectory, not the repo root)
- That future sessions start by reading `docs/meta/claude-context.md`
- That the Done Checklist in `CLAUDE.md` applies to all tasks
