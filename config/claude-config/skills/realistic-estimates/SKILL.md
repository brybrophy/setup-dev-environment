---
name: realistic-estimates
description: Automatically follow this skill whenever producing timelines, LOEs (level of effort), or implementation plans that include time estimates. Adjusts estimates to account for AI-assisted development, team size, and the nature of the work (mechanical vs. creative).
version: 1.0.0
---

# Realistic Estimates with AI-Assisted Teams

## When to Apply

Apply this skill whenever you are:

- Writing an implementation plan with a timeline
- Estimating LOE for a task or project
- Proposing a phased rollout with dates
- Answering "how long will this take?"

## Core Principle

**Default estimates should assume the team has AI assistance (Claude, Codex, Copilot, etc.) unless told otherwise.** Most developers Bryan works with use AI tools daily. Estimates that ignore AI assistance will be inflated and out of touch.

## Before Writing Any Timeline

Ask yourself these questions:

1. **How many devs are working on this?** Don't assume 1 dev unless told. Ask or check context.
2. **Is AI assistance available?** Default: yes. AI dramatically accelerates mechanical/repetitive work.
3. **What percentage of the work is mechanical vs. creative?**
   - **Mechanical work** (adding annotations to 57 files, generating boilerplate, writing migrations from existing patterns, creating test scaffolding): AI reduces this by 5-10x.
   - **Creative work** (architecture decisions, debugging novel issues, cross-team coordination): AI helps but doesn't dramatically compress timelines.
4. **What are the real blockers?** Often the bottleneck is reviews, deployments, environment access, or waiting on others. Not the coding itself.

## Estimation Adjustments

| Work Type                                    | Traditional (1 dev, no AI) | With AI (1 dev) | With AI (2 devs) |
| -------------------------------------------- | -------------------------- | --------------- | ---------------- |
| Repetitive code changes across many files    | 1 week                     | 1 day           | Half day         |
| Boilerplate/scaffolding (migrations, config) | 3 days                     | Half day        | Half day         |
| New feature with clear patterns to follow    | 1 week                     | 2-3 days        | 1-2 days         |
| Novel architecture/design work               | 1 week                     | 3-4 days        | 2-3 days         |
| Debugging/investigation                      | 2 days                     | 1 day           | 1 day            |
| CI/CD and deployment pipeline work           | Unchanged                  | Unchanged       | Unchanged        |

## Common Mistakes to Avoid

- **Padding estimates for "unknown unknowns" when the work is well-understood.** If we've already researched the codebase and know exactly what needs to change, don't add buffer.
- **Estimating as if one person works sequentially.** If phases are independent, two devs can parallelize.
- **Ignoring that AI can generate bulk changes.** Adding an annotation to 57 entity files is minutes of work with AI, not days.
- **Forgetting that reviews and deploys are the real bottleneck.** Code-complete != shipped. Always separate "code done" from "in production."

## Format

When presenting timelines, be specific about what the time covers:

- "Code-complete in X days, in production by day Y"
- Call out parallelizable work explicitly
- Note what's blocked by external dependencies vs. what's just dev work
