#!/usr/bin/env bash
# Blocks destructive git commands before they execute.
# Reads the pending tool call from stdin (Claude Code PreToolUse hook format:
# JSON with a .tool_input.command field). Exits non-zero and prints a reason
# to block; exits 0 to allow.

set -euo pipefail

input="$(cat)"
command="$(echo "$input" | grep -o '"command"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*"command"[[:space:]]*:[[:space:]]*"//;s/"$//')"

blocked_patterns=(
  'git push .*--force'
  'git push .*-f([[:space:]]|$)'
  'git reset --hard'
  'git clean -f'
  'git branch -D'
  'git checkout \.'
  'git restore \.'
)

for pattern in "${blocked_patterns[@]}"; do
  if echo "$command" | grep -qE "$pattern"; then
    echo "Blocked: '$command' matches a destructive git pattern ($pattern)." >&2
    echo "This agent does not have authority to run this command. If it's genuinely needed, a human runs it directly." >&2
    exit 1
  fi
done

exit 0
