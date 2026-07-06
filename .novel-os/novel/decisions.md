---
type: novel
layer: 2
status: living-document
maintained_by: memory-keeper
---

# Creative Decisions Log

> Canonical record of every binding creative and infrastructure decision. The Memory Keeper appends here; drafting agents must never contradict an entry. If a draft conflicts with this file, the draft is wrong.

## Infrastructure Decisions (Studio — Do Not Remove on Per-Book Reset)

| ID | Decision | Rationale | Affects |
|----|----------|-----------|---------|
| D-001 | MCP secrets load from `.env` via `envFile` in `.cursor/mcp.json`; never commit API keys | Keeps repo shareable; Cursor resolves secrets at MCP spawn | All MCP-dependent phases |
| D-002 | Pre-commit hook (`hooks/pre-commit`) is mandatory for `book_output/` and `image_prompts/` commits | Self-healing QA loop; blocks AI slop and incomplete artifacts | Phases 3–5 |
| D-003 | Never bypass validation with `git commit --no-verify` | Preserves pipeline integrity | All phases |
| D-004 | Rolling Context Window: Chapter N drafting receives synopsis + Chapter N outline + Chapter N−1 only | Prevents context rot and KV-cache churn | Phase 3 |
| D-005 | `visual-language.md` is immutable aesthetic law; changes require human author approval | Visual consistency across chapters and cover suite | Phases 2.5, 5 |
| D-006 | Canonical Git remote: `https://github.com/reversesingularity/ai-book-creator.git` | Single source of truth for studio infrastructure | Repository ops |
| D-007 | Session state checkpointed in `docs/session-save.md` at end of each orchestration session | Enables reliable resume across Cursor sessions | Orchestrator |
| D-008 | Agent worktree isolation: planning / drafting / editing branches only | Prevents concurrent agent file collisions | All agent phases |
| D-009 | Obsidian MCP via `npx obsidian-mcp-server@latest` + `OBSIDIAN_BASE_URL`; API key is raw 64-char hex (no `Bearer`); enable server in Cursor MCP UI | Fixes broken `bun` runner; ensures authenticated vault access | Phase 0 gate G0-c/d |

## Creative Decisions (Per Book — Replace Below for Each New Project)

| ID | Decision | Rationale | Affects |
|----|----------|-----------|---------|
| D-100+ | *(none yet — Phase 1 not started)* | | |

> When Phase 1 begins, Memory Keeper assigns creative decisions starting at **D-100** to avoid colliding with infrastructure IDs D-001–D-009.
