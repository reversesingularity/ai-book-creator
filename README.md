# Autonomous Publishing & Technical Documentation Studio

Multi-agent workspace for long-form book and enterprise documentation generation. Cursor acts as the Lead Orchestrator; specialized sub-agents operate in isolated Git worktrees.

## Quick Start (Orchestrator Bootstrap)

```bash
# 1. Initialize worktrees + install the validation hook
bash sync-worktrees.sh

# 2. Fill in the Layer 1/2 context templates before Phase 1:
#    .novel-os/standards/visual-language.md   (visual aesthetic law)
#    .novel-os/novel/premise.md               (logline, synopsis, series info)

# 3. Configure MCP: put your Obsidian Local REST API key in mcp.json

# 4. Follow the pipeline in docs/prd.md, phase by phase.
```

## Layout

| Path | Purpose |
|------|---------|
| `sync-worktrees.sh` | Creates/locks `.worktrees/worktree-{planning,drafting,editing}` on branches `agent/{planning,drafting,editing}`; installs the pre-commit hook. |
| `.claude/agents/` | BYOA persona files: Memory Keeper (Opus 4.8), Prose Writer (Sonnet 5), Manuscript Editor (Nemotron 3 Ultra), Visual Director (Opus 4.8). |
| `.claude/skills/ghostproof-lite.md` | 15 negative editorial constraints enforced on all prose. |
| `mcp.json` | Obsidian lore-retrieval MCP server (DeepLore-style two-stage retrieval; scoped read/write paths). |
| `.novel-os/` | Book-OS three-layer context: `standards/` (L1), `novel/` (L2), `manuscripts/` (L3). |
| `docs/prd.md` | The orchestration pipeline mandate — the source of truth for phase ordering. |
| `hooks/pre-commit` | Python validation hook (word count, ICK list, plot flags, artifacts, visual prompt structure). Installed to `.git/hooks/` by the sync script. |
| `book_output/` | Final prose per chapter (agents write here inside their worktrees). |
| `image_prompts/` | Visual Director output: `chapters/Chapter-XX/` and `covers/Book-X-Full-Suite/`. |

## Agent → Worktree Assignment

| Worktree | Branch | Agents |
|----------|--------|--------|
| `worktree-planning` | `agent/planning` | Memory Keeper + Visual Director (chapter visuals) |
| `worktree-drafting` | `agent/drafting` | Prose Writer |
| `worktree-editing` | `agent/editing` | Manuscript Editor + Visual Director (cover suite) |

## Rules the Orchestrator Must Enforce

1. Each sub-agent operates only inside its assigned worktree path.
2. Rolling Context Window: Chapter N drafting receives only the synopsis, the Chapter N outline, and finalized Chapter N-1. Never the full manuscript.
3. Rejected commits (hook exit 1) route back to the Manuscript Editor (prose) or Visual Director (visual prompts). Never use `--no-verify`.
4. `.novel-os/standards/visual-language.md` is immutable law for all image prompts.
