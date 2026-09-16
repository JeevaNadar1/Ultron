#!/usr/bin/env bash
# Validate the skill source, then package it as ultron.skill.
# Run before every commit that touches skills/ultron/.
set -euo pipefail

SRC="skills/ultron"
OUT="ultron.skill"

fail() { printf 'FAIL: %s\n' "$*" >&2; exit 1; }
warn() { printf 'WARN: %s\n' "$*" >&2; }

[ -f "$SRC/SKILL.md" ] || fail "$SRC/SKILL.md not found (run from the repo root)"

# --- frontmatter ------------------------------------------------------------
[ "$(head -1 "$SRC/SKILL.md")" = "---" ] || fail "SKILL.md must open with '---' on line 1"

# hardhat: assumes name/description are each one line, which is the only shape
# the uploader has ever been given. A wrapped description fails loudly here
# rather than silently shipping a truncated one.
fm=$(awk 'NR==1 {next} /^---$/ {exit} {print}' "$SRC/SKILL.md")
name=$(printf '%s\n' "$fm" | sed -n 's/^name: *//p')
desc=$(printf '%s\n' "$fm" | sed -n 's/^description: *//p')

[ -n "$name" ] || fail "frontmatter: 'name' missing"
[ -n "$desc" ] || fail "frontmatter: 'description' missing"
[ "$name" = "$(basename "$SRC")" ] || fail "frontmatter name '$name' != directory '$(basename "$SRC")'"
[ "${#desc}" -le 1024 ] || fail "description is ${#desc} chars, limit is 1024"

# --- every referenced file exists -------------------------------------------
refs=$(grep -oE '(references|assets)/[A-Za-z0-9._-]+\.md' "$SRC/SKILL.md" | sort -u)
for f in $refs; do
  [ -f "$SRC/$f" ] || fail "SKILL.md points at a file that isn't there: $f"
done

# --- every file is referenced -----------------------------------------------
# Unreferenced files never load under progressive disclosure. Dead weight, not
# a broken build.
for f in $(cd "$SRC" && find references assets -name '*.md' 2>/dev/null | sort); do
  printf '%s\n' "$refs" | grep -qx "$f" || warn "$f is never referenced from SKILL.md"
done

# --- package ----------------------------------------------------------------
rm -f "$OUT"
( cd skills && zip -qXr "../$OUT" ultron -x '*.DS_Store' '*__MACOSX*' )

files=$(unzip -Z1 "$OUT" | grep -c '\.md$')
lines=$(find "$SRC" -name '*.md' -exec cat {} + | wc -l | tr -d ' ')
printf 'built %s — %s markdown files, %s lines, description %s/1024 chars\n' \
  "$OUT" "$files" "$lines" "${#desc}"
