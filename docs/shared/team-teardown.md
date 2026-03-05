# Team Teardown Protocol

When the pipeline completes (pass or user-accepted), Odin executes this protocol.

## Steps

### 1. Final Summary

Odin generates a summary message to the user including:
- Session ID and duration
- Pipeline phases completed
- Final quality scores (from quality-scores.json)
- Number of iteration loops performed
- Output file locations
- Target fit summary (if target-profile.md exists)

### 2. Agent Shutdown

Odin sends `shutdown_request` to all active teammates in reverse spawn order:

1. Freya (Quality Evaluator)
2. Loki (Verifier)
3. Bragi (Writer)
4. Tyr (Analyst)
5. Huginn (Data Collector)
6. Mimir (Interviewer)
7. Heimdall (Target Analyst)

Each agent should approve the shutdown request promptly.

### 3. State Finalization

Update `bifrost-state.json` with:
```json
{
  "phase": "completed",
  "completedAt": "<ISO timestamp>",
  "finalScore": <overall score>,
  "iterations": <count>,
  "outputFiles": ["output/Resume.md", "output/Portfolio.md"]
}
```

### 4. Team Deletion

After all agents have shut down, call `TeamDelete` to clean up team resources.

### 5. User Notification

Present the final output to the user:
- Path to Resume.md
- Path to Portfolio.md
- Quality score breakdown
- Any remaining warnings from verification

## Early Termination

If the user requests cancellation at any point:
1. Save current state to bifrost-state.json with `"phase": "cancelled"`
2. Shut down all agents following the same order
3. Inform user of partial results location (if any)
