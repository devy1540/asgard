---
name: mimir
description: "Interview only - Conduct a Socratic-style interview to collect your professional information for later document generation"
user_invocable: true
---

# Mimir — Interview Only

Run just the interview phase to collect your professional information. The interview data can be used later with `/asgard:forge` to generate documents without repeating the interview.

## What This Does

1. **Setup**: Initialize a session directory for storing interview data
2. **Target Analysis** (optional): If you have a target job posting, analyze it first to guide the interview
3. **Interview**: Socratic-style conversation covering 6 dimensions of your professional background
4. **Save**: Store interview log and completeness scores for future use

## Execution

### Step 1: Initialize

```
SESSION_ID="mimir-$(date +%Y%m%d)-$(head -c 3 /dev/urandom | xxd -p | head -c 6)"
mkdir -p ".asgard/${SESSION_ID}"
```

Write initial state:
```json
{
  "sessionId": "{SESSION_ID}",
  "phase": "interview",
  "startedAt": "{ISO timestamp}",
  "mode": "interview-only",
  "hasTarget": false
}
```
Save as `.asgard/{SESSION_ID}/bifrost-state.json`.

### Step 2: Ask About Target (Optional)

Use `AskUserQuestion`:
- "Do you have a target job posting you'd like to tailor the interview toward?"
- Options: "Yes, I have a URL" / "Yes, I'll paste the text" / "Yes, I have a file" / "No, general interview"

If target provided:
1. Collect the target input (URL via WebFetch / text / file via Read)
2. Analyze per `docs/shared/target-analysis.md` protocol
3. Save `target-profile.md` to session directory
4. Update state: `hasTarget: true`

### Step 3: Conduct Interview

Follow the protocol in `docs/shared/interview-protocol.md`:

1. Use `AskUserQuestion` for each interview round
2. Cover all 6 dimensions: Career History, Technical Skills, Key Projects, Soft Skills, Education, Goals
3. If target exists, add target-aware questions per the protocol
4. Track completeness scores per dimension
5. Continue until all dimensions >= 0.7 or max 15 rounds reached

### Step 4: Save Results

Write to session directory:
- `interview-log.md` — Complete Q&A log with completeness assessment
- `completeness-scores.json` — Structured dimension scores

Update state:
```json
{
  "phase": "interview-complete",
  "completedAt": "{ISO timestamp}"
}
```

### Step 5: Report

Tell the user:
- Session ID (needed for `/asgard:forge`)
- Session directory path
- Completeness scores summary
- Tip: "Run `/asgard:forge` with this session ID to generate your Resume and Portfolio"

## Notes

- Answer questions as specifically as possible — numbers, dates, and outcomes help create better documents
- You can say "skip" to any question you don't want to answer
- The interview data is saved locally and can be reused multiple times with `/asgard:forge`
