---
type: governance
layer: orchestrator
status: active-checkpoint
saved_at: 2026-07-06T18:28:00+12:00
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
| **Latest commit** | `356c572` — session checkpoint for next agent |
| **Remote** | `origin` → `https://github.com/reversesingularity/ai-book-creator.git` |

## Pipeline Position

```
[✅ Phase 0: Infrastructure] → [⏸ Phase 1: Arc Generation] → Phase 2 → 2.5 → 3 → 4 → 5
```

| Phase | Status | Notes |
|-------|--------|-------|
| **0 — Scaffold & gates** | ✅ Complete | Worktrees, hooks, agents, MCP live, GitHub synced |
| **1 — High-level arcs** | ⏸ Blocked | Awaiting human creative seed (G1, G2) |
| **2 — Scene outlines** | ⬜ Not started | |
| **2.5 — Chapter visuals** | ⬜ Not started | |
| **3 — Prose drafting** | ⬜ Not started | |
| **4 — Editorial pass** | ⬜ Not started | |
| **5 — Cover suite** | ⬜ Not started | |

## Last Session Summary (2026-07-06)

**Goal:** Fix broken Obsidian MCP server; sync governance docs; push to GitHub.

**Resolved:**
1. **MCP would not start** — old config used `bun run obsidian-mcp-server` but Bun is not installed. Fixed to `npx -y obsidian-mcp-server@latest` with `"type": "stdio"`.
2. **Wrong env vars** — `OBSIDIAN_PORT` / `OBSIDIAN_HOST` are ignored by `obsidian-mcp-server`. Replaced with `OBSIDIAN_BASE_URL=https://127.0.0.1:27124` and `OBSIDIAN_VERIFY_SSL=false`.
3. **Server stayed disconnected** — project MCP servers default to **disabled** in Cursor. User must enable `obsidian-lore` under Customize → MCP.
4. **API key auth failed** — user had `Bearer ` prefix in `.env`. Key must be **raw 64-char hex only**; MCP adds `Bearer` to HTTP headers. Recorded as **D-009**.

**Verified live:**
- Obsidian Local REST API responds on HTTPS `27124` and HTTP `27123`
- `obsidian-lore` enabled, active, 14 tools registered
- `.env` API key: 64-char hex, no Bearer prefix

**Committed & pushed:** `abb701a` (main governance/MCP sync), follow-up doc commits through `472ca13`.

## Infrastructure Verified (Cumulative)

- [x] `sync-worktrees.sh` — three locked worktrees at `.worktrees/`
- [x] Pre-commit hook installed and live-tested
- [x] Four BYOA personas in `.claude/agents/`
- [x] `ghostproof-lite.md` skill (15 constraints)
- [x] Book-OS three-layer hierarchy scaffolded
- [x] MCP: `.cursor/mcp.json` + `envFile` → `.env`
- [x] `.env` locally with valid Obsidian API key (gitignored)
- [x] `obsidian-lore` MCP enabled + connected in Cursor
- [x] Governance trilogy: `governance.md`, `session-save.md`, `prd.md`
- [x] GitHub `main` up to date with all infrastructure docs

## Human Input Gates (Must Clear Before Phase 1)

| Gate | File / Check | Status |
|------|--------------|--------|
| **G1 — Story premise** | `.novel-os/novel/premise.md` | ❌ Template placeholders remain |
| **G2 — Visual language** | `.novel-os/standards/visual-language.md` | ❌ All `[DEFINE]` blocks empty |
| **G3 — Obsidian MCP live** | Customize → MCP → `obsidian-lore` enabled + ~14 tools | ✅ Verified 2026-07-06 |
| **G4 — Obsidian vault open** | Local REST API on `27124`; vault has `.novel-os/` paths | ✅ Runtime requirement |

Prose-only drafting could begin after **G1** alone. Phases **2.5** and **5** require **G2**.

## Agent → Worktree Assignments

| Worktree | Branch | Agents | Write targets |
|----------|--------|--------|---------------|
| `worktree-planning` | `agent/planning` | Memory Keeper, Visual Director | `writing-plan.md`, `image_prompts/chapters/` |
| `worktree-drafting` | `agent/drafting` | Prose Writer | `book_output/` |
| `worktree-editing` | `agent/editing` | Manuscript Editor, Visual Director | `book_output/` (patches), `image_prompts/covers/` |

## MCP Configuration Summary

| Setting | Value |
|---------|-------|
| **Server name** | `obsidian-lore` |
| **Runner** | `npx -y obsidian-mcp-server@latest` (`type: stdio`) |
| **Secrets** | `OBSIDIAN_API_KEY` in `.env` — 64-char hex, **no** `Bearer` |
| **API URL** | `OBSIDIAN_BASE_URL=https://127.0.0.1:27124`, `OBSIDIAN_VERIFY_SSL=false` |
| **Config** | `.cursor/mcp.json` (Cursor) + `mcp.json` (committed mirror) |
| **Activation** | Enable in Customize → MCP; refresh after `.env` edits |
| **Read paths** | `.novel-os/novel/`, `.novel-os/standards/` |
| **Write paths** | `decisions.md`, `character-profiles.md`, `visual-language.md` |

**Troubleshooting for next agent:**
- If MCP shows disconnected → check Customize → MCP toggle is **on**, then refresh.
- If `authenticated: false` → verify `.env` key is 64-char hex with no `Bearer`, then refresh MCP.
- If tools missing → Obsidian must be running with Local REST API plugin enabled.
- Bun is **not** required; Node.js 24+ is sufficient.

## Binding Decisions (Quick Reference)

Full log: [`.novel-os/novel/decisions.md`](../.novel-os/novel/decisions.md)

| ID | Decision |
|----|----------|
| D-001 | MCP secrets in `.env` via `envFile`; never commit keys |
| D-002 | Pre-commit hook mandatory; never `--no-verify` |
| D-003 | Rolling Context Window for prose drafting |
| D-004 | `visual-language.md` is immutable aesthetic law |
| D-005 | Canonical repo: `reversesingularity/ai-book-creator` |
| D-006–D-008 | Git remote, session-save checkpoints, worktree isolation |
| D-009 | MCP via `npx` + `OBSIDIAN_BASE_URL`; raw hex API key; enable in Cursor UI |

## Next Actions (Ordered)

1. **Human author**: Fill `premise.md` (logline, synopsis, themes, author name) — clears G1.
2. **Human author**: Fill `visual-language.md` if illustrations/covers wanted — clears G2.
3. **Orchestrator**: On resume, spot-check `obsidian-lore` still enabled in MCP settings.
4. **Phase 1** (after G1): Launch Memory Keeper + Visual Director in `worktree-planning`.
   - Read: `premise.md`, `writing-standards.md`, `visual-language.md` (via MCP where useful)
   - Write: arc table in `.novel-os/manuscripts/writing-plan.md`
5. **After Phase 1**: Update this session save (`pipeline_phase`, gates, next actions).

## Resume Protocol for New Sessions

1. Read **`docs/session-save.md`** (this file).
2. Read **`docs/governance.md`** for orchestrator rules.
3. Read **`docs/prd.md`** for phase ordering.
4. `bash sync-worktrees.sh` — verify worktree health.
5. Confirm `obsidian-lore` enabled + connected before lore-dependent work.
6. Do not start Phase 3 until Phase 2 outline exists for target chapter.

## Files Intentionally Still Templates

- `.novel-os/novel/premise.md`
- `.novel-os/standards/visual-language.md`
- `.novel-os/novel/character-profiles.md`
- `.novel-os/manuscripts/writing-plan.md`

## Session History

| Date | Event |
|------|-------|
| 2026-07-05 | Initial scaffold; worktrees + hook live-tested |
| 2026-07-05 | MCP migrated to `.env` + `envFile`; GitHub published |
| 2026-07-06 | Diagnosed & fixed Obsidian MCP (`npx`, `OBSIDIAN_BASE_URL`, API key format, Cursor activation) |
| 2026-07-06 | `obsidian-lore` verified live; governance docs committed + pushed (`abb701a` → `472ca13`) |
| 2026-07-06 | Session checkpoint saved for next agent instance (this file) |
