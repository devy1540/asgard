#!/usr/bin/env bash
# checkpoint.sh — Artifact checkpoint hook
# Triggered after any .md file is written to a session directory
# Creates a timestamped backup in a .checkpoints subdirectory

set -euo pipefail

FILE_PATH="${1:-}"

if [ -z "$FILE_PATH" ] || [ ! -f "$FILE_PATH" ]; then
  exit 0
fi

# Extract the session directory (parent of the written file)
SESSION_DIR=$(dirname "$FILE_PATH")

# Handle output/ subdirectory — go up one more level
if [ "$(basename "$SESSION_DIR")" = "output" ]; then
  SESSION_DIR=$(dirname "$SESSION_DIR")
fi

# Only checkpoint files within .asgard/ directories
case "$FILE_PATH" in
  */.asgard/*)
    ;;
  *)
    exit 0
    ;;
esac

# Create checkpoints directory
CHECKPOINT_DIR="${SESSION_DIR}/.checkpoints"
mkdir -p "$CHECKPOINT_DIR"

# Generate checkpoint filename: original-name.YYYYMMDD-HHMMSS.md
BASENAME=$(basename "$FILE_PATH")
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
NAME="${BASENAME%.*}"
EXT="${BASENAME##*.}"
CHECKPOINT_FILE="${CHECKPOINT_DIR}/${NAME}.${TIMESTAMP}.${EXT}"

# Copy the file
cp "$FILE_PATH" "$CHECKPOINT_FILE"

echo "Checkpoint saved: ${CHECKPOINT_FILE}"
