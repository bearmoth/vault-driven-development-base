#!/bin/bash
# Validates frontmatter on vault notes written by Claude.
# Reads the Write/Edit tool's JSON input from stdin.
#
# Hard errors (exit 1): missing `type` or `status` — these break vault queries
# Soft warnings (exit 0): missing `domain`, `updated`, or other fields

set -euo pipefail

# Parse file_path from the JSON tool input on stdin
INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    print(data.get('file_path', ''))
except Exception:
    print('')
" 2>/dev/null || echo "")

if [[ -z "$FILE_PATH" ]]; then exit 0; fi

# Normalise to a repo-relative path so this works whether Claude passes
# an absolute path (common) or a relative one.
REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
if [[ "$FILE_PATH" == /* ]]; then
    REL_PATH="${FILE_PATH#"$REPO_ROOT"/}"
else
    REL_PATH="$FILE_PATH"
fi

# Only validate docs/**/*.md, excluding templates/
if [[ ! "$REL_PATH" =~ ^docs/.+\.md$ ]]; then exit 0; fi
if [[ "$REL_PATH" =~ ^docs/templates/ ]]; then exit 0; fi
if [[ ! -f "$FILE_PATH" ]]; then exit 0; fi

HARD_MISSING=()
SOFT_MISSING=()

# Hard required: type and status — without these vault queries break
for FIELD in type status; do
    if ! grep -qE "^${FIELD}:" "$FILE_PATH" 2>/dev/null; then
        HARD_MISSING+=("$FIELD")
    fi
done

# Soft required: domain and updated — important but warn only
for FIELD in domain updated; do
    if ! grep -qE "^${FIELD}:" "$FILE_PATH" 2>/dev/null; then
        SOFT_MISSING+=("$FIELD")
    fi
done

if [[ ${#HARD_MISSING[@]} -gt 0 ]]; then
    echo "[docs:validate] ERROR: $REL_PATH is missing required frontmatter: ${HARD_MISSING[*]}"
    echo "[docs:validate] Fix before proceeding — type and status are required on all vault notes."
    exit 1
fi

if [[ ${#SOFT_MISSING[@]} -gt 0 ]]; then
    echo "[docs:validate] WARNING: $REL_PATH is missing recommended frontmatter: ${SOFT_MISSING[*]}"
    echo "[docs:validate] Every vault note should have: type, status, domain, updated"
fi

exit 0
