---
title: "Skill-Agent Dispatch Pattern"
type: concept
domain: [meta]
status: parked
confidence: stable
maturity: fleshed-out
context: on-demand
related: ["[[workflow]]", "[[conventions]]"]
tags: [type/concept, status/parked, maturity/fleshed-out, domain/meta]
created: 2026-04-01
updated: 2026-04-01
---

## What is it?

Skills (`.claude/skills/*/SKILL.md`) act as orchestrators — they define *when* and *what* to review or check. Agents (`.claude/agents/*.md`) act as specialists — they define *how* to do it, carrying a focused system prompt and a constrained tool set. A skill dispatches one or more agents at the right moment using the `Agent` tool with `subagent_type: <agent-name>`.

## Why does it matter?

Without this pattern, skill files accumulate both orchestration logic and domain logic in one place. As skills grow, the review criteria, the escalation logic, and the output format all mix together. Separating concerns means:

- The skill controls *when* something happens (after code changes, before completion claims, during vault audits)
- The agent controls *how* it happens (what to look for, what counts as a failure, what the report looks like)
- Each can evolve independently without breaking the other
- Multiple skills can share the same agent (e.g. `code-reviewer` could be called from both `docs-review` and a hypothetical `pr-review` skill)

## Design Influence

When adding new checks to any skill:
1. Ask: does this check require domain expertise that is reusable? → Create an agent.
2. Ask: is this check one-off logic that only makes sense in this skill's context? → Inline it.
3. Agent system prompts must be self-contained: the agent knows its job without reading the skill file. Pass context explicitly in the dispatch prompt; do not rely on shared state.
4. Use the least powerful model that can handle the task — mechanical scans → haiku; judgment calls → sonnet.

The dispatch prompt in the skill should tell the agent: what you're reviewing, what the goal was, and any project-specific context the agent's system prompt doesn't already cover.

## Open Questions

None. Pattern is implemented and stable.

## Related

- [[workflow]] — Stage 4 (Verify) and Stage 5 (Close) are where these agents are invoked
- [[conventions]] — frontmatter schema and valid values the vault-auditor enforces

## Exploration Log

### 2026-04-01

Implemented as part of agent augmentation: three agents created (`code-reviewer`, `reality-checker`, `vault-auditor`), wired into `docs-review`, `verification-before-completion`, and `docs-audit`. Pattern validated through full review cycles — spec compliance review + code quality review per task, plus a final cross-file review. Pattern is fleshed-out and stable.
