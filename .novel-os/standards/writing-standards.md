---
type: standards
layer: 1
scope: global
---

# Layer 1: Global Writing Standards (Writing DNA)

This file defines the immutable global writing DNA for all projects in this studio. Agents must treat these rules as non-negotiable defaults unless a Layer 2 novel-specific style guide explicitly overrides them.

## Narrative Voice

- Point of view: Third-person limited, single POV character per scene. POV switches only at scene breaks (`---`).
- Tense: Past tense throughout unless the Layer 2 style guide specifies otherwise.
- Narrative distance: Close. The narration filters through the POV character's vocabulary, biases, and knowledge limits.

## Prose Style

- Sentence rhythm: Vary length deliberately. Action sequences favor short, declarative sentences; introspection may lengthen.
- Concrete over abstract: Prefer specific nouns and strong verbs. Adjective stacks (three or more) are forbidden.
- Dialogue: Contraction-heavy, interruption-friendly, character-differentiated. Dialogue tags default to "said"; adverb-laden tags are banned.
- All prose must pass the `ghostproof-lite.md` constraint set (see `.claude/skills/ghostproof-lite.md`).

## Genre Conventions

- Chapters target 1,500–4,000 words (pre-commit hook enforces the 1,500 floor).
- Every chapter ends on an unresolved beat: a question, threat, decision, or reversal.
- Scene structure follows Goal → Conflict → Disaster or Reaction → Dilemma → Decision.

## Formatting

- Chapters: `# Chapter N: Title` as the sole H1 per file.
- Scene breaks: horizontal rule (`---`) on its own line.
- No code blocks, no LLM reasoning tokens, no editorial notes in final prose files.
