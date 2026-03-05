---
name: evolve
description: "Self-evolution - Analyze past runs, identify weaknesses, and improve Asgard's agents and protocols"
user_invocable: true
---

# Evolve — Self-Evolution

Analyze Asgard's historical performance, audit current integrity, and generate data-driven improvements to agents, protocols, and templates.

## What This Does

The Norns (all three aspects) work together:

1. **Urd (Past)**: Analyze historical quality scores, verification reports, and interview logs
2. **Verdandi (Present)**: Audit current structural integrity
3. **Skuld (Future)**: Generate and apply improvement proposals

## Execution

### Step 1: Initialize

```
mkdir -p ".asgard/evolution"
```

### Step 2: Spawn Norns

Spawn the **Norns** agent (agents/norns.md) in evolve mode.

Send task: "Run full evolution cycle — Urd, Verdandi, Skuld."

### Step 3: Urd — Historical Analysis

Scan all past sessions in `.asgard/`:

1. **Collect quality-scores.json** from all sessions
   - Aggregate dimension scores across runs
   - Identify chronically weak dimensions (avg < 0.75)
   - Track score trends over time

2. **Collect verification-report.md** from all sessions
   - Count CRITICAL/WARNING/SUGGESTION occurrences by type
   - Identify most frequently flagged claim types
   - Track clarity enforcement violations

3. **Collect completeness-scores.json** from all sessions
   - Average rounds to completion
   - Identify dimensions that take longest to fill
   - Track which question types produce richest answers

4. **Collect bifrost-state.json** from all sessions
   - Average iteration count (how often quality gate fails first pass)
   - Track which feedback routes are most used
   - Measure pipeline success rate

Produce `.asgard/evolution/evolution-analysis.md`.

If no past sessions exist, skip Urd and note: "No historical data available. Run /asgard:bifrost first to generate baseline data."

### Step 4: Verdandi — Structural Audit

Run the same checks as `/asgard:audit`. Produce `.asgard/evolution/audit-report.md`.

### Step 5: Skuld — Improvement Proposals

Based on Urd's patterns and Verdandi's findings, generate proposals:

#### Proposal Categories

| Category | Trigger | Example Fix |
|----------|---------|-------------|
| Agent Prompt | Dimension avg < 0.75 | Add instructions to responsible agent |
| Interview Questions | Dimension slow to fill | Add more effective questions to bank |
| Clarity Enforcement | Frequently flagged expressions | Add to ban list with alternatives |
| Quality Calibration | Scores cluster too high/low | Adjust criteria thresholds |
| Connector Protocol | Audit warnings | Fix missing fields or definitions |
| Structural Fixes | Audit failures | Fix broken references or missing files |

#### Proposal Format

```markdown
# Evolution Proposals

## Proposal 1: {Title}
- **Category**: {Agent Prompt / Interview / Clarity / ...}
- **Trigger**: {Data that prompted this proposal}
- **File**: {File to modify}
- **Current**: {Current content (excerpt)}
- **Proposed**: {New content (excerpt)}
- **Rationale**: {Why this improvement should help}
- **Expected Impact**: {Which dimension/metric should improve}
```

### Step 6: User Approval

Present proposals to the user via `AskUserQuestion`:
- Show each proposal with before/after preview
- Options: "Apply all" / "Let me choose" / "Skip evolution"
- If "Let me choose": present each proposal individually

### Step 7: Apply Changes

For each approved proposal:
1. Read the target file
2. Apply the edit using `Edit` tool
3. Log the change in `.asgard/evolution/evolution-log.md`:
   ```markdown
   ## {Date} — Evolution Cycle

   ### Applied: {Proposal Title}
   - **File**: {path}
   - **Rationale**: {reason}
   - **Change**: {summary}
   ```

### Step 8: Re-Audit

Run Verdandi again to confirm:
- No new audit failures introduced
- All structural checks still pass
- Report clean audit to user

### Step 9: Summary

Present to the user:
- Number of proposals generated
- Number of proposals applied
- Audit status (before → after)
- Recommendations for next steps

## Notes

- All changes require explicit user approval — nothing is auto-applied
- Evolution log is append-only for full traceability
- Run this periodically after several `/asgard:bifrost` sessions for best results
- First run without history will only perform audit + structural fixes
- Each evolution cycle makes Asgard better at generating quality documents
