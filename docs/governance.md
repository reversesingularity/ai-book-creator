# Orchestrator Governance

> Binding operational rules for the Lead Orchestrator (Cursor). Creative canon lives in `.novel-os/`; infrastructure canon lives here and in `docs/prd.md`.

## Authority Hierarchy

When documents conflict, resolve in this order:

1. **Human author explicit instruction** (current session)
2. **`docs/prd.md`** — pipeline phase ordering and protocols
3. **`docs/governance.md`** — this file (orchestrator conduct)
4. **`.novel-os/novel/decisions.md`** — binding creative decisions
5. **`.novel-os/standards/`** — Layer 1 writing + visual law
6. **Agent persona files** — role-specific constraints in `.claude/agents/`

## Session Management

| Artifact | Purpose | Update when |
|----------|---------|-------------|
| [`session-save.md`](session-save.md) | Checkpoint: phase, gates, next actions | End of every orchestration session |
| [`prd.md`](prd.md) | Pipeline specification | Architecture or phase changes |
| [`.novel-os/novel/decisions.md`](../.novel-os/novel/decisions.md) | Binding creative/infrastructure decisions | Any decision agents must not contradict |

**Resume rule:** Every new session starts by reading `session-save.md`, then `governance.md`, then `prd.md`.

## Phase Gates

No phase may begin until its gate clears.

### Phase 0 → Phase 1

| Gate | Requirement |
|------|-------------|
| G0-a | Worktrees exist (`bash sync-worktrees.sh`) |
| G0-b | Pre-commit hook installed |
| G0-c | `.env` contains valid `OBSIDIAN_API_KEY` (64-char hex; **no** `Bearer` prefix) |
| G0-d | MCP `obsidian-lore` **enabled and connected** in Cursor (Customize → MCP) |
| G1 | `premise.md` fully filled (no bracket placeholders) |
| G2 | `visual-language.md` filled if Phases 2.5 or 5 are in scope |

### Phase N → Phase N+1

| Transition | Requirement |
|------------|-------------|
| 1 → 2 | Arc table populated in `writing-plan.md` |
| 2 → 2.5 | All target chapters have scene outlines |
| 2.5 → 3 | Visual prompt tasks registered; prompts generated or explicitly deferred |
| 3 → 4 | Target chapter prose committed and passed hook |
| 4 → 5 | Manuscript at beta/completion milestone per author |

## Worktree Discipline

1. Agents operate **only** inside their assigned worktree (see `session-save.md`).
2. Cross-worktree file reads are allowed; cross-worktree writes are forbidden unless the orchestrator explicitly merges branches.
3. Re-run `sync-worktrees.sh` after clone or if worktrees are missing.
4. Never unlock or remove worktrees without author approval.

## MCP & Secrets Governance

| Rule | Detail |
|------|--------|
| **Secrets location** | `.env` only; gitignored |
| **Config location** | `.cursor/mcp.json` (primary); root `mcp.json` (committed mirror) |
| **Interpolation** | `"envFile": "${workspaceFolder}/.env"` — no API keys in JSON |
| **Runner** | `npx -y obsidian-mcp-server@latest` (Node.js 24+); **not** `bun` |
| **API URL** | `OBSIDIAN_BASE_URL=https://127.0.0.1:27124` with `OBSIDIAN_VERIFY_SSL=false` |
| **API key format** | 64-character hex string from Obsidian → Settings → Local REST API. Store raw key only — the MCP server adds `Bearer` to HTTP headers |
| **Activation** | Project MCP servers default to **disabled** in Cursor; enable `obsidian-lore` under Customize → MCP, then refresh after `.env` changes |
| **Write scope** | MCP may write only paths listed in `OBSIDIAN_WRITE_PATHS` |
| **Visual language edits** | Memory Keeper may propose; human author must approve changes to `visual-language.md` |

## Validation & Self-Healing

1. All commits to `book_output/` and `image_prompts/` must pass `hooks/pre-commit`.
2. On hook failure (exit 1): read stderr → route prose to Manuscript Editor, visuals to Visual Director → fix → re-commit.
3. **Never** use `git commit --no-verify`.
4. Do not lower hook thresholds without a new entry in `decisions.md`.

## Rolling Context Window (Enforced)

When orchestrating Phase 3 drafting for Chapter N, provide agents **only**:

1. Global synopsis + lore (MCP retrieval)
2. Chapter N scene outline
3. Finalized Chapter N−1 prose

Never attach the full manuscript or unrelated chapter drafts.

## Git & Publishing

| Rule | Detail |
|------|--------|
| **Canonical remote** | `https://github.com/reversesingularity/ai-book-creator.git` |
| **Default branch** | `main` |
| **Never commit** | `.env`, `.worktrees/`, `book_output/` drafts before author review (if policy added) |
| **Always commit** | Governance updates, `session-save.md`, approved Layer 2/3 Book-OS changes |

## Per-Book Reset Protocol

Starting a **new book** in this studio:

1. Reset Layer 2: `premise.md`, `character-profiles.md`, `decisions.md` (preserve infrastructure decisions D-001–D-009).
2. Update or fork `visual-language.md` if the series aesthetic changes.
3. Clear Layer 3: `writing-plan.md` arc/outline/registry sections.
4. Clear worktree outputs: `book_output/`, `image_prompts/` in each worktree.
5. Update `session-save.md` with new book metadata and reset phase to pre-Phase-1.

## Escalation

| Situation | Action |
|-----------|--------|
| Agent contradicts `decisions.md` | Halt draft; Memory Keeper resolves; log new decision |
| MCP unavailable | Fall back to direct file reads; do not simulate lore retrieval |
| Hook repeatedly fails same file | Manuscript Editor deep pass; check for systematic constraint violation |
| Phase skip requested by author | Log waiver in `decisions.md` with rationale |

## Related Documents

- [`session-save.md`](session-save.md) — current checkpoint
- [`prd.md`](prd.md) — full pipeline specification
- [`../README.md`](../README.md) — setup and layout
- [`../.claude/skills/ghostproof-lite.md`](../.claude/skills/ghostproof-lite.md) — prose constraints
