#!/usr/bin/env bash
# validate-gate.sh — Quality gate validation hook
# Triggered after quality-scores.json is written
# Validates the score structure and outputs gate decision

set -euo pipefail

SCORES_FILE="${1:-}"

if [ -z "$SCORES_FILE" ] || [ ! -f "$SCORES_FILE" ]; then
  echo "WARN: quality-scores.json not found at: $SCORES_FILE"
  exit 0
fi

# Extract overall score and decision using python (available on macOS)
RESULT=$(python3 -c "
import json, sys

try:
    with open('$SCORES_FILE', 'r') as f:
        data = json.load(f)

    score = data.get('overallScore', 0)
    passed = data.get('passed', False)
    iteration = data.get('iteration', 0)
    decision = data.get('decision', 'UNKNOWN')

    print(f'GATE: score={score:.3f} passed={passed} iteration={iteration} decision={decision}')

    if score < 0.5:
        print('ALERT: Score critically low (<0.5). Major improvements needed.')
    elif score < 0.8:
        print(f'INFO: Score below threshold. Iteration {iteration}/3.')

    # Validate dimension structure
    dims = data.get('dimensions', {})
    if not dims:
        print('WARN: No dimension scores found in quality-scores.json')
    else:
        low_dims = [k for k, v in dims.items() if isinstance(v, dict) and v.get('score', 1) < 0.6]
        if low_dims:
            print(f'ALERT: Low-scoring dimensions: {', '.join(low_dims)}')

except json.JSONDecodeError:
    print('ERROR: Invalid JSON in quality-scores.json')
    sys.exit(1)
except Exception as e:
    print(f'ERROR: {e}')
    sys.exit(1)
" 2>&1)

echo "$RESULT"
