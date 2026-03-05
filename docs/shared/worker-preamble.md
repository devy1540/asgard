# Worker Agent Standard Lifecycle

All non-Odin agents follow this lifecycle. Read this before executing any task.

## Lifecycle Phases

### 1. Activation

When spawned by Odin, you receive:
- **Session directory**: `.asgard/{session-id}/` — all artifacts go here
- **Task assignment**: Your specific phase task via SendMessage
- **Context artifacts**: Paths to input files from prior phases

### 2. Input Validation

Before starting work:
1. Read all referenced input artifacts using the Read tool
2. Verify required files exist and are non-empty
3. If any required input is missing, message Odin immediately with what's missing

### 3. Execution

- Perform your designated task as described in your agent definition
- Write output artifacts to the session directory
- Do NOT write files outside the session directory unless explicitly instructed
- Do NOT modify artifacts produced by other agents

### 4. Output

When your task is complete:
1. Write all output artifacts to the session directory
2. Send a completion message to Odin with:
   - List of artifacts produced (file paths)
   - Brief summary of findings/results
   - Any warnings or issues encountered

### 5. Shutdown

After reporting completion:
- Wait for Odin's acknowledgment or follow-up instructions
- Approve shutdown when requested by Odin

## Communication Protocol

- **Report to**: Odin (always)
- **Receive from**: Odin (always)
- **Peer communication**: Only when explicitly instructed by Odin
- Use `SendMessage` with `type: "message"` and `recipient: "odin"`

## Error Handling

- If you encounter an unrecoverable error, message Odin with details
- Do NOT silently fail — always report issues
- Include the error context and what you attempted

## Artifact Naming

Follow the naming conventions specified in each phase. Use kebab-case for all file names.
