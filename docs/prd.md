# Automated Novel Generation: Product Requirements and Orchestration Pipeline

## 1. System Objective

To establish a fully autonomous, self-correcting writing pipeline utilizing isolated Git worktrees and specialized AI agents to generate human-quality long-form fiction **and professional visual assets** without context degradation or visual inconsistency.

## 2. The Narrative + Visual Pipeline

The generation process must proceed linearly through distinct phases, passing the state object sequentially between designated agents. Visual prompt generation runs as a parallel or immediately subsequent track.

### Phase 1: High-Level Arc Generation (The Story Planner)

- **Agent**: Memory Keeper (Opus 4.8) + Visual Director (Opus 4.8)
- **Workspace**: `worktree-planning`
- **Action**: Ingests the project premise and standard guides via MCP. Updates `.novel-os/novel/writing-plan.md` and generates high-level, overarching narrative arcs. Visual Director begins high-level visual motif planning and identifies key chapters/scenes requiring major illustrations.

### Phase 2: Granular Outline Creation (The Outline Creator)

- **Agent**: Memory Keeper (Opus 4.8)
- **Workspace**: `worktree-planning`
- **Action**: Breaks the high-level arc into a highly specific, scene-by-scene outline detailing character states, physical locations, and required plot payloads.

### Phase 2.5: Per-Chapter Visual Prompt Generation

- **Agent**: Visual Director (Opus 4.8)
- **Workspace**: `worktree-planning` → outputs to `image_prompts/chapters/`
- **Action**: For each chapter in the granular outline, generates 1–3 production-ready image prompts (opener, key moment, character/environmental). Prompts are canon-locked via MCP and the visual-language standards. Structured output with YAML frontmatter for batch processing.

### Phase 3: Sequential Prose Drafting (The Writer)

- **Agent**: Prose Writer (Sonnet 5)
- **Workspace**: `worktree-drafting`
- **Action**: Ingests the scene outline and generates narrative prose to `book_output/`.
- **Protocol**: Applies the `ghostproof-lite.md` constraints strictly. Follows the "Rolling Context Window" rule to optimize token usage.

### Phase 4: Stylistic Refinement (The Editor)

- **Agent**: Manuscript Editor (Nemotron 3 Ultra) + Visual Director (refinement pass)
- **Workspace**: `worktree-editing`
- **Action**: Reviews the draft for structural integrity, pacing, formatting artifacts, and strict adherence to the editorial ruleset. Visual Director performs a final consistency check on chapter prompts against the finalized prose.

### Phase 5: Full Cover Suite Prompt Generation

- **Agent**: Visual Director (Opus 4.8)
- **Workspace**: `worktree-editing` or dedicated cover planning branch
- **Action**: Triggered when the manuscript reaches beta/completion or at author-defined milestones. Generates the complete coordinated cover prompt set: front, spine, back, and full wrap. Includes series branding, author name, ISBN placeholder, blurb integration, and strict visual language consistency across all panels. Outputs to `image_prompts/covers/`.

## 3. Iterative Writing Protocol (The Rolling Context Window)

To optimize token limits and prevent context dilution, the Prose Writer must never be fed the entirety of the manuscript.

When drafting **Chapter [N]**, the agent must only receive:

1. The global synopsis and lore constraints (retrieved dynamically via the MCP Obsidian server).
2. The granular scene outline for Chapter [N].
3. The completed, finalized text of Chapter [N-1].

This sliding window ensures the immediate narrative continuity is preserved perfectly without saturating the LLM's KV cache with irrelevant early-book data, thus maintaining generation speed and logical coherence.

Visual prompts for Chapter [N] are generated from the outline plus any finalized previous chapter visuals, keeping visual continuity without requiring the full manuscript in context.

## 4. Self-Healing Validation Loop

Every commit of prose to `book_output/` or prompts to `image_prompts/` is intercepted by the shared pre-commit hook (`hooks/pre-commit`, installed via `sync-worktrees.sh`). On rejection (exit 1), the orchestrator must:

1. Read the stderr violation report.
2. Route prose failures to the Manuscript Editor and visual prompt failures to the Visual Director for surgical remediation.
3. Re-stage and re-attempt the commit. Never bypass the hook with `--no-verify`.

## 5. Context Hierarchy (Book-OS Framework)

| Layer | Directory | Purpose |
|-------|-----------|---------|
| Layer 1: Standards | `.novel-os/standards/` | Global writing DNA + global visual language rules. Narrative voice, prose style, POV preferences, genre conventions, locked visual aesthetic bible. |
| Layer 2: Novel | `.novel-os/novel/` | Creative vision for the current project. Story premise, creative decisions, novel-specific style guide, character profiles. |
| Layer 3: Manuscripts | `.novel-os/manuscripts/` | The detailed roadmap. Story outline, character arcs, scene-by-scene writing tasks, registered visual prompt tasks. |
