---
type: governance
layer: orchestrator
status: active-checkpoint
saved_at: 2026-07-06T18:21:00+12:00
saved_by: cursor-orchestrator
pipeline_phase: pre-phase-1
---

# Session Save — AI Book Creator Studio

> **Resume here.** Read this file first when starting a new Cursor session. It is the authoritative checkpoint for infrastructure state, open gates, and next actions.

## Repository

| Item | Value |
|------|-------|
| **GitHub** | https://github.com/reversesingularity/ai-book-creator |
| **Local path** | `f:\Projects\ai-book-creator` |
| **Default branch** | `main` |
| **Latest commit** | `d9ab19f` — Obsidian MCP fix + governance sync |
| **Remote** | `origin` → `https://github.com/reversesingularity/ai-book-creator.git` |

## Pipeline Position

```
[✅ Phase 0: Infrastructure] → [⏸ Phase 1: Arc Generation] → Phase 2 → 2.5 → 3 → 4 → 5
```

| Phase | Status | Notes |
|-------|--------|-------|
| **0 — Scaffold & gates** | ✅ Complete | Worktrees, hooks, agents, MCP live, GitHub |
| **1 — High-level arcs** | ⏸ Blocked | Awaiting human creative seed (see gates below) |
| **2 — Scene outlines** | ⬜ Not started | |
| **2.5 — Chapter visuals** | ⬜ Not started | |
| **3 — Prose drafting** | ⬜ Not started | |
| **4 — Editorial pass** | ⬜ Not started | |
| **5 — Cover suite** | ⬜ Not started | |

## Infrastructure Verified (This Session)

- [x] `sync-worktrees.sh` executed — three locked worktrees at `.worktrees/`
  - `worktree-planning` → `agent/planning`
  - `worktree-drafting` → `agent/drafting`
  - `worktree-editing` → `agent/editing`
- [x] Pre-commit hook installed and live-tested (word count, ICK list, code blocks)
- [x] Four BYOA personas in `.claude/agents/`
- [x] `ghostproof-lite.md` skill (15 constraints)
- [x] Book-OS three-layer hierarchy scaffolded
- [x] MCP configured via `.cursor/mcp.json` + `envFile` → `.env`
- [x] `.env` created locally (gitignored) with valid 64-char Obsidian API key (no `Bearer` prefix)
- [x] `obsidian-lore` MCP **enabled, connected, and authenticated** in Cursor (14 tools)
- [x] Governance docs: `governance.md`, `session-save.md`, `prd.md` aligned
- [x] Baseline commits: `f557826`, `f6c517a`, `5b19ada`

## Human Input Gates (Must Clear Before Phase 1)

| Gate | File / Check | Status |
|------|--------------|--------|
| **G1 — Story premise** | `.novel-os/novel/premise.md` | ❌ Template placeholders remain |
| **G2 — Visual language** | `.novel-os/standards/visual-language.md` | ❌ All `[DEFINE]` blocks empty |
| **G3 — Obsidian MCP live** | Cursor Customize → MCP → `obsidian-lore` enabled + tools visible | ✅ Verified 2026-07-06 |
| **G4 — Obsidian vault open** | Local REST API on port `27124`; vault contains `.novel-os/` paths | ✅ Required at runtime |

Prose-only drafting could begin after **G1** alone. Phases **2.5** and **5** require **G2**.

## Agent → Worktree Assignments (Current)

| Worktree | Branch | Agents | Write targets |
|----------|--------|--------|---------------|
| `worktree-planning` | `agent/planning` | Memory Keeper, Visual Director | `writing-plan.md`, `image_prompts/chapters/` |
| `worktree-drafting` | `agent/drafting` | Prose Writer | `book_output/` |
| `worktree-editing` | `agent/editing` | Manuscript Editor, Visual Director | `book_output/` (patches), `image_prompts/covers/` |

## MCP Configuration Summary

- **Server**: `obsidian-lore` via `npx -y obsidian-mcp-server@latest` (`type: stdio`)
- **Secrets**: `OBSIDIAN_API_KEY` in `.env` — 64-char hex, **no** `Bearer` prefix
- **API endpoint**: `OBSIDIAN_BASE_URL=https://127.0.0.1:27124`, `OBSIDIAN_VERIFY_SSL=false`
- **Config files**: `.cursor/mcp.json` (Cursor) + root `mcp.json` (mirror, committed)
- **Activation**: Enable server in Cursor Customize → MCP; refresh after `.env` changes
- **Read paths**: `.novel-os/novel/`, `.novel-os/standards/`
- **Write paths**: `decisions.md`, `character-profiles.md`, `visual-language.md` (with approval)

## Binding Decisions (Quick Reference)

See full log: [`.novel-os/novel/decisions.md`](../.novel-os/novel/decisions.md)

| ID | Decision |
|----|----------|
| D-001 | MCP secrets load from `.env` via `envFile`; never commit keys |
| D-002 | Pre-commit hook is mandatory; never `--no-verify` |
| D-003 | Rolling Context Window for all prose drafting |
| D-004 | `visual-language.md` is immutable aesthetic law |
| D-005 | Canonical repo: `reversesingularity/ai-book-creator` |
| D-009 | Obsidian MCP runs via `npx` + `OBSIDIAN_BASE_URL`; API key is raw hex only |

## Next Actions (Ordered)

1. **Human author**: Fill `premise.md` (logline, synopsis, themes, author name).
2. **Human author**: Fill `visual-language.md` if illustrations/covers are wanted.
3. **Phase 1**: Launch Memory Keeper + Visual Director in `worktree-planning`.
   - Read: `premise.md`, `writing-standards.md`, `visual-language.md`
   - Write: arc table in `.novel-os/manuscripts/writing-plan.md`
4. **After Phase 1**: Update this session save (`pipeline_phase`, gates, next actions).

## Resume Protocol for New Sessions

1. Read **`docs/session-save.md`** (this file).
2. Read **`docs/governance.md`** for orchestrator rules.
3. Read **`docs/prd.md`** for phase ordering.
4. Check git status and worktree health: `bash sync-worktrees.sh`
5. Verify `obsidian-lore` is enabled and connected before lore-dependent agent work.
6. Do not start Phase 3 until Phase 2 outline for target chapter exists.

## Files Intentionally Still Templates

These are **per-book** creative inputs, not infrastructure debt:

- `.novel-os/novel/premise.md`
- `.novel-os/standards/visual-language.md` (per-series aesthetic)
- `.novel-os/novel/character-profiles.md` (filled during planning)
- `.novel-os/manuscripts/writing-plan.md` (filled Phase 1–2.5)

## Session History

| Date | Event |
|------|-------|
| 2026-07-05 | Initial scaffold verified; worktrees + hook live-tested |
| 2026-07-05 | MCP migrated to `.env` + `envFile`; `.cursor/mcp.json` created |
| 2026-07-05 | GitHub repo published; comprehensive README |
| 2026-07-05 | Session save + governance docs created |
| 2026-07-06 | Fixed Obsidian MCP: `npx` runner, `OBSIDIAN_BASE_URL`, API key format, Cursor activation |
| 2026-07-06 | `obsidian-lore` verified live (14 tools); governance docs synced to GitHub |
