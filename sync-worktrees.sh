#!/bin/bash
# sync-worktrees.sh
# Initializes isolated Git worktrees for parallel Cursor sub-agents.
# Prevents file collisions when agents plan, draft, edit, and generate
# visual prompts concurrently. Safe to re-run (idempotent sync).

set -euo pipefail

REPO_ROOT=$(pwd)
WORKTREE_DIR="${REPO_ROOT}/.worktrees"
mkdir -p "$WORKTREE_DIR"

declare -A WORKTREES=(
    ["worktree-planning"]="agent/planning"
    ["worktree-drafting"]="agent/drafting"
    ["worktree-editing"]="agent/editing"
)

echo "Initializing isolated agent worktrees..."

# Ensure the repository has a baseline commit to branch from.
if ! git rev-parse HEAD >/dev/null 2>&1; then
    echo "Initializing empty repository with baseline commit..."
    git add -A
    git commit --allow-empty -m "chore: initial baseline commit for agent worktrees"
fi

for WT_NAME in "${!WORKTREES[@]}"; do
    BRANCH_NAME="${WORKTREES[$WT_NAME]}"
    WT_PATH="${WORKTREE_DIR}/${WT_NAME}"

    if [ -d "$WT_PATH" ]; then
        echo "Worktree $WT_NAME already exists at $WT_PATH. Syncing..."
        git -C "$WT_PATH" fetch origin || true
    else
        echo "Creating new worktree: $WT_NAME on branch $BRANCH_NAME..."
        if git show-ref --verify --quiet "refs/heads/$BRANCH_NAME"; then
            git worktree add "$WT_PATH" "$BRANCH_NAME"
        else
            git worktree add -b "$BRANCH_NAME" "$WT_PATH" main
        fi

        # Lock the worktree to prevent autonomous garbage collection.
        git worktree lock "$WT_PATH" --reason "Reserved for persistent Cursor sub-agent orchestration"
    fi

    # Output + context directories inside each worktree.
    mkdir -p "${WT_PATH}/book_output"
    mkdir -p "${WT_PATH}/.novel-os/manuscripts"
    mkdir -p "${WT_PATH}/image_prompts/chapters"
    mkdir -p "${WT_PATH}/image_prompts/covers"
done

# Install the shared pre-commit validation hook.
# Worktrees share the main repo's hooks directory, so one install covers all agents.
HOOK_SRC="${REPO_ROOT}/hooks/pre-commit"
HOOK_DST="$(git rev-parse --git-common-dir)/hooks/pre-commit"
if [ -f "$HOOK_SRC" ]; then
    cp "$HOOK_SRC" "$HOOK_DST"
    chmod +x "$HOOK_DST"
    echo "Pre-commit validation hook installed."
fi

echo "Worktree isolation infrastructure successfully synchronized."
