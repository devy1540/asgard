---
name: audit
description: "Self-verification - Validate Asgard's internal consistency, cross-references, and structural integrity"
user_invocable: true
---

# Audit — Self-Verification

Validate Asgard's own internal consistency. Checks cross-references, protocol completeness, rubric math, and structural integrity.

## What This Does

The Norns (Verdandi aspect) scan every file in the plugin and verify:
- All agent ↔ shared doc cross-references are valid
- Quality rubric weights sum to 100%
- Connector protocols have all 4 required sections
- Interview protocol covers all 6 dimensions
- Template fields match agent output schemas
- Hooks reference existing, executable scripts
- No orphan or missing files

## Execution

### Step 1: Initialize

```
mkdir -p ".asgard/evolution"
```

### Step 2: Spawn Norns

Spawn the **Norns** agent (agents/norns.md) in audit mode.

Send task: "Run Verdandi (structural audit) only. Scan all plugin files and produce audit-report.md."

### Step 3: Structural Scan

Norns will:

1. **Read plugin.json** → verify all listed agents and skills exist on disk
2. **Read each agent file** → verify referenced `docs/shared/` paths exist
3. **Read each skill file** → verify referenced agents exist
4. **Validate quality-scoring.md**:
   - 6-dimension weights sum to 100%
   - 7-dimension weights sum to 100%
   - All dimensions have scoring criteria defined
5. **Validate connector-protocol.md**:
   - Each connector has Discovery, Extraction, Structuring, Degradation
   - Required tool names follow valid naming patterns
6. **Validate interview-protocol.md**:
   - All 6 dimensions have question banks
   - Completeness scoring criteria defined for each
7. **Validate document-templates.md**:
   - Resume template fields align with user-profile.md structure
   - Portfolio template fields align with analysis-notes.md structure
8. **Validate hooks**:
   - hooks.json is valid JSON
   - Referenced scripts exist and are executable
9. **Check clarity-enforcement.md**:
   - No duplicate entries
   - Every banned expression has an alternative

### Step 4: Report

Produce `.asgard/evolution/audit-report.md`:

```markdown
# Asgard Audit Report

**Date**: {date}
**Files Scanned**: {count}
**Status**: {CLEAN / WARNINGS / FAILURES}

## Results

| Check | Status | Details |
|-------|--------|---------|
| Plugin.json references | PASS | All 8 agents, 5 skills found |
| Agent cross-references | PASS | All docs/shared/ paths valid |
| Quality rubric (6-dim) | PASS | Weights sum to 100% |
| Quality rubric (7-dim) | PASS | Weights sum to 100% |
| Connector protocols | WARN | Slack connector missing field X |
| Interview dimensions | PASS | All 6 dimensions covered |
| ... | ... | ... |

## Failures (Must Fix)
{Details of any FAIL items}

## Warnings (Should Fix)
{Details of any WARN items}

## Summary
{Overall health assessment}
```

Present the report to the user.

## Notes

- This is a read-only operation — nothing is modified
- Run this after any manual edits to the plugin to catch inconsistencies
- Run this before `/asgard:evolve` to establish a baseline
