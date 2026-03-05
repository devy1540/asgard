**A S G A R D** (아 스 가 르 드)

> *"Your story deserves to be told with precision, not platitudes."*
> 8 gods interview, analyze, write, and verify — so your resume doesn't ship on clichés.

---

> *The gods don't embellish. That's the point.*

Asgard is a **harness engineering plugin** for Claude Code. 8 agents — each a Norse deity with a distinct role and strict permissions — interview you, collect external data, write tailored documents, and verify every claim through structured adversarial review.

Most resumes fail because nobody challenged the wording. Asgard forces honesty before allowing eloquence.

---

## Philosophy

> *"I know that I know nothing"* — Socrates

Career documents fail at three points: **vague descriptions**, **unverified claims**, and **generic presentation**. Asgard addresses all three through separation of concerns at the agent level:

```
The one who interviews (Mimir)  cannot write the document (Bragi does).
The one who writes (Bragi)      cannot verify their own claims (Loki does).
The one who verifies (Loki)     cannot score the final quality (Freya does).
```

This is **structural honesty**. Every achievement requires evidence. Every claim survives devil's advocate challenge. Every gate has a mathematical threshold, not a vibes check.

Three gates control the pipeline:

| Gate | Threshold | Question |
|:-----|:---------:|:---------|
| Completeness Gate | >= 0.7 | "Do we know enough to write?" |
| Verification Gate | 0 CRITICAL | "Is every claim supported?" |
| Quality Gate | >= 0.8 | "Is the output good enough?" |

---

## Quick Start

```bash
# Install from marketplace
claude plugin marketplace add devy1540/asgard
claude plugin install asgard@asgard-marketplace
```

```
# Inside Claude Code

# Full pipeline: interview -> collect -> analyze -> write -> verify -> score
/asgard:bifrost

# Interview only (save for later)
/asgard:mimir

# Generate from existing data (skip interview)
/asgard:forge
```

---

## The Pipeline

```
Heimdall -> Mimir -> Huginn -> Tyr -> Bragi -> Loki -> Freya
 (target)  (ask)   (collect) (analyze) (write) (verify) (judge)
    ^                                              |
    +------------- Score < 0.8? Retry -------------+
```

Each stage has a **gate**. No stage proceeds without passing.

| Stage | Agent | Gate | What Happens |
|:------|:------|:----:|:-------------|
| **Target** | Heimdall | — | Parse job posting → extract requirements and keywords |
| **Interview** | Mimir | Completeness >= 0.7 | Socratic interview across 6 dimensions until 70%+ complete |
| **Collection** | Huginn | Soft (skip OK) | Gather data from GitHub, Slack, Notion, Jira via MCP |
| **Analysis** | Tyr | — | Cross-validate sources, build STAR matrix, map target fit |
| **Generation** | Bragi | — | Write Resume.md + Portfolio.md from templates |
| **Verification** | Loki | 0 CRITICAL issues | Every claim checked against evidence, exaggeration flagged |
| **Quality** | Freya | Score >= 0.8 | 7-dimension weighted evaluation, up to 3 retry loops |

---

## Skills

| Command | Description |
|:--------|:------------|
| **/asgard:bifrost** | Full pipeline — interview to final output with quality loop |
| **/asgard:mimir** | Interview only — collect information for later generation |
| **/asgard:forge** | Generate from existing data — reuse interviews with new targets |

---

## The Eight Gods

| Agent | Role | Model | Permissions |
|:------|:-----|:-----:|:------------|
| **Odin** | Orchestrator — pipeline management and gate decisions | opus | full |
| **Heimdall** | Target Analyst — job posting parsing and requirement extraction | opus | read-only |
| **Mimir** | Interviewer — Socratic questioning across 6 dimensions | opus | read-only |
| **Huginn** | Data Collector — MCP connector discovery and extraction | sonnet | read-only |
| **Tyr** | Analyst — cross-validation, STAR matrix, fit/gap analysis | opus | read-only |
| **Bragi** | Writer — Resume.md and Portfolio.md generation | opus | full |
| **Loki** | Verifier — claim verification, exaggeration detection | opus | read-only |
| **Freya** | Quality Evaluator — 7-dimension scoring and gate decision | opus | read-only |

6 of 8 agents are **read-only**. Only the orchestrator and the writer get write access.

---

## Quality Dimensions

Freya scores documents on 6 or 7 dimensions depending on whether a target job posting exists.

| Dimension | Without Target | With Target | What It Measures |
|:----------|:-------------:|:-----------:|:-----------------|
| Accuracy | 25% | 22% | Every claim backed by evidence |
| Completeness | 20% | 17% | All career phases and skills covered |
| Impact | 20% | 17% | Achievements quantified with metrics |
| Narrative | 15% | 12% | Coherent career arc and story |
| Presentation | 10% | 8% | Formatting, scannability, consistency |
| Differentiation | 10% | 9% | Unique value proposition stands out |
| **Target Fit** | — | **15%** | Alignment with job requirements |

Pass threshold: **>= 0.8**. Below that, feedback routes to the responsible agent and retries (up to 3 times).

---

## Connectors

Huginn dynamically discovers available MCP tools at runtime. No connector? No problem — the pipeline continues with what's available.

| Connector | Discovery | What It Collects |
|:----------|:----------|:-----------------|
| **GitHub** | `github` tools | Repos, languages, commits, contributions |
| **Slack** | `slack` tools | Profile, title, shared resources |
| **Notion** | `notion` tools | Project docs, personal notes |
| **Jira** | `atlassian` tools | Issues, projects, contribution stats |

Adding a new connector requires zero code changes — just define 4 fields (Discovery, Extraction, Structuring, Degradation) in `docs/shared/connector-protocol.md`.

---

## Output

Artifacts are stored under `.asgard/{id}/` with ID format `{skill}-{YYYYMMDD}-{6char}`.

```
.asgard/bifrost-20260305-a1b2c3/
├── target-profile.md          # Heimdall's target analysis
├── interview-log.md           # Mimir's Q&A log
├── external-data.md           # Huginn's collected data
├── user-profile.md            # Tyr's structured profile
├── verification-report.md     # Loki's claim verification
├── quality-scores.json        # Freya's dimension scores
├── quality-report.md          # Freya's detailed report
└── output/
    ├── Resume.md              # Final resume
    └── Portfolio.md           # Final portfolio
```

---

## Clarity Enforcement

Bragi writes. Loki catches. No exceptions.

| Banned | Why | Alternative |
|:-------|:----|:------------|
| "다양한 경험" | Says nothing | List the actual experiences |
| "Passionate about" | Cliché | Show through results |
| "Responsible for" | Duty, not achievement | "Delivered / Built / Reduced" |
| "Expert in" | Rarely verifiable | State years + specific achievements |
| "Results-driven" | Buzzword | State the actual results |

> *Full list: `docs/shared/clarity-enforcement.md`*

---

## Project Structure

```
asgard/
├── .claude-plugin/           # Plugin metadata
│   ├── marketplace.json
│   └── plugin.json
├── agents/                   # The Eight Gods
│   ├── odin.md               #   Orchestrator
│   ├── heimdall.md           #   Target Analyst
│   ├── mimir.md              #   Interviewer
│   ├── huginn.md             #   Data Collector
│   ├── tyr.md                #   Analyst
│   ├── bragi.md              #   Writer
│   ├── loki.md               #   Verifier
│   └── freya.md              #   Quality Evaluator
├── skills/                   # Slash commands
│   ├── bifrost/SKILL.md      #   Full pipeline
│   ├── mimir/SKILL.md        #   Interview only
│   └── forge/SKILL.md        #   Generate from data
├── docs/shared/              # Shared protocols
│   ├── worker-preamble.md    #   Agent lifecycle
│   ├── team-teardown.md      #   Shutdown protocol
│   ├── quality-scoring.md    #   Scoring rubric
│   ├── clarity-enforcement.md#   Banned expressions
│   ├── connector-protocol.md #   MCP connectors
│   ├── target-analysis.md    #   JD analysis
│   ├── document-templates.md #   Output templates
│   └── interview-protocol.md #   Question bank
└── hooks/                    # PostToolUse hooks
    ├── hooks.json
    ├── validate-gate.sh      #   Quality gate check
    └── checkpoint.sh         #   Artifact backup
```

---

> *"Your career is not a list of duties. It's a story of impact."*
> **The gods don't embellish. That's the point.**
