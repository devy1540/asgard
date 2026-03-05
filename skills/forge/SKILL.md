---
name: forge
description: "Generate documents from existing data - Skip interview and create Resume/Portfolio from a previous session or provided data"
user_invocable: true
---

# Forge — Document Generation from Existing Data

Generate Resume.md and Portfolio.md using existing interview data from a previous `/asgard:mimir` session, or from user-provided data files. Skips the interview phase entirely.

## What This Does

1. **Load Data**: Read existing interview data from a previous session or user-provided files
2. **Data Collection** (optional): Gather additional data from connected platforms
3. **Analysis**: Structure and analyze the loaded data
4. **Generation**: Create Resume.md and Portfolio.md
5. **Verification**: Devil's advocate review
6. **Quality Gate**: Score and iterate if needed

## Execution

### Step 1: Identify Data Source

Use `AskUserQuestion`:
- "How would you like to provide your data?"
- Options:
  - "Use a previous Mimir session" — provide session ID
  - "I have data files to provide" — provide file paths
  - "Let me paste my information" — paste text directly

### Step 2: Load Data

**From previous session**:
1. Ask for the session ID
2. Read `.asgard/{session-id}/interview-log.md`
3. Read `.asgard/{session-id}/completeness-scores.json`
4. Read `.asgard/{session-id}/target-profile.md` (if exists)
5. Create a new session directory for this forge run:
   ```
   FORGE_ID="forge-$(date +%Y%m%d)-$(head -c 3 /dev/urandom | xxd -p | head -c 6)"
   mkdir -p ".asgard/${FORGE_ID}/output"
   ```
6. Copy relevant files to the new session directory

**From user-provided files**:
1. Ask user for file paths
2. Read each file
3. Create session directory
4. Save content as `interview-log.md` in the session directory

**From pasted text**:
1. Collect text via `AskUserQuestion` (may need multiple rounds)
2. Create session directory
3. Save as `interview-log.md`

### Step 3: Ask About Target (if not already present)

If no `target-profile.md` exists:

Use `AskUserQuestion`:
- "Do you have a target job posting to tailor the documents for?"
- Options: "Yes, I have a URL" / "Yes, I'll paste the text" / "Yes, I have a file" / "No, general purpose"

If target provided, analyze per `docs/shared/target-analysis.md`.

### Step 4: Optional Data Collection

Use `ToolSearch` to discover available MCP connectors.

Use `AskUserQuestion`:
- "Would you like to enrich your data with information from connected platforms?"
- Show available connectors
- Options: "Yes, collect from all available" / "Let me choose" / "No, use existing data only"

If yes, follow connector protocol from `docs/shared/connector-protocol.md`.

### Step 5: Execute Pipeline (Phase 3-7)

Create team and spawn agents for the remaining pipeline phases:

1. **Tyr** (Analysis): Cross-reference all data, build user profile
2. **Bragi** (Generation): Write Resume.md + Portfolio.md
3. **Loki** (Verification): Verify all claims
4. **Freya** (Quality Gate): Score and decide pass/fail
5. **Feedback loop** if score < 0.8 (max 3 iterations)

### Step 6: Deliver Results

Present:
- Path to `output/Resume.md`
- Path to `output/Portfolio.md`
- Quality score summary
- Target fit summary (if applicable)

Teardown the team per `docs/shared/team-teardown.md`.

## Notes

- This is ideal for regenerating documents with different target jobs using the same interview data
- You can run forge multiple times with the same mimir session but different targets
- The quality gate and feedback loop still apply — documents must meet the 0.8 threshold
