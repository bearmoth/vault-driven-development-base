#!/bin/bash
# Validates frontmatter on vault notes written by Claude.
# Reads the Write tool's JSON input from stdin.
# Exits 0 always — output is injected as a warning into Claude's context.

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

# Check for required frontmatter fields
MISSING=()
for FIELD in type status domain updated; do
    if ! grep -qE "^${FIELD}:" "$FILE_PATH" 2>/dev/null; then
        MISSING+=("$FIELD")
    fi
done

if [[ ${#MISSING[@]} -gt 0 ]]; then
    echo "[docs:validate] WARNING: $FILE_PATH is missing required frontmatter: ${MISSING[*]}"
    echo "[docs:validate] Every vault note needs: type, status, domain, updated"
fi

exit 0
