---
name: bifrost
description: "Full Pipeline - Interview, analysis, document generation, verification, and quality gate with iterative improvement loop"
user_invocable: true
---

# Bifrost — The Rainbow Bridge (Full Pipeline)

You are invoking the complete Asgard pipeline. This will guide you through a comprehensive process to generate tailored PR materials (Resume + Portfolio).

## What This Does

1. **Setup**: Initialize session, discover data sources, check for target job posting
2. **Target Analysis** (optional): Analyze a job posting to tailor all outputs
3. **Interview**: Socratic-style conversation to understand your background (max 15 rounds)
4. **Data Collection**: Gather data from connected platforms (GitHub, Slack, Notion, Jira)
5. **Analysis**: Cross-reference and structure all collected information
6. **Generation**: Create Resume.md and Portfolio.md
7. **Verification**: Devil's advocate review of all claims
8. **Quality Gate**: Score against 6-7 quality dimensions (pass threshold: 0.8)
9. **Feedback Loop**: If quality < 0.8, iterate up to 3 times

## Execution

Delegate to **Odin** (agents/odin.md) who will orchestrate the entire pipeline.

### Step 1: Initialize

Use Bash to generate a session ID and create the session directory:

```
SESSION_ID="bifrost-$(date +%Y%m%d)-$(head -c 3 /dev/urandom | xxd -p | head -c 6)"
mkdir -p ".asgard/${SESSION_ID}/output"
```

### Step 2: Create Team

```
TeamCreate:
  team_name: "{SESSION_ID}"
  description: "Asgard Bifrost pipeline session"
```

### Step 3: Discover Connectors

Use `ToolSearch` to check for available MCP connectors:
- Search "github" → check for GitHub tools
- Search "slack" → check for Slack tools
- Search "notion" → check for Notion tools
- Search "jira atlassian" → check for Jira tools

Report available connectors to the user.

### Step 4: Ask About Target

Use `AskUserQuestion`:
- "Do you have a target job posting or specific conditions you'd like to tailor your materials for?"
- Options: "Yes, I have a URL" / "Yes, I'll paste the text" / "Yes, I have a file" / "No, general purpose"

If target provided → Spawn Heimdall for Phase 0.5
If no target → Skip to Phase 1

### Step 5: Execute Pipeline

Spawn agents sequentially following Odin's phase protocol (agents/odin.md):
- Phase 0.5: Heimdall (if target)
- Phase 1: Mimir (interview)
- Phase 2: Huginn (data collection)
- Phase 3: Tyr (analysis)
- Phase 4: Bragi (generation)
- Phase 5: Loki (verification)
- Phase 6: Freya (quality gate)
- Loop back to Phase 4 if needed
- Phase 7: Teardown

### Step 6: Deliver Results

Present to the user:
- Path to `.asgard/{SESSION_ID}/output/Resume.md`
- Path to `.asgard/{SESSION_ID}/output/Portfolio.md`
- Quality score summary
- Target fit summary (if applicable)

## Notes

- The interview phase requires your active participation — answer questions thoughtfully
- External data collection is optional and depends on available MCP connections
- Quality gate threshold is 0.8 — the system will iterate to improve below that score
- All artifacts are preserved in the session directory for reference
