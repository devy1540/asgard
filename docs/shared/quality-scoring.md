# Quality Scoring Rubric

Freya uses this rubric to evaluate generated documents. Scoring varies based on whether a target profile exists.

## Dimensions

### 1. Completeness

Does the document cover all relevant aspects of the candidate's profile?

| Score | Criteria |
|-------|----------|
| 0.9-1.0 | All career phases, skills, projects, and achievements thoroughly covered |
| 0.7-0.8 | Most areas covered with minor gaps |
| 0.5-0.6 | Notable gaps in coverage (missing projects, skills, or career phases) |
| < 0.5 | Major sections missing or severely underdeveloped |

### 2. Accuracy

Are all claims supported by evidence from interview or external data?

| Score | Criteria |
|-------|----------|
| 0.9-1.0 | Every claim traceable to interview or external data source |
| 0.7-0.8 | Most claims supported; minor unverified details |
| 0.5-0.6 | Several claims lack supporting evidence |
| < 0.5 | Significant unsupported or contradicted claims |

### 3. Impact

Are achievements expressed with measurable outcomes and clear impact?

| Score | Criteria |
|-------|----------|
| 0.9-1.0 | Quantified results with clear business/technical impact throughout |
| 0.7-0.8 | Most achievements quantified; some generic descriptions |
| 0.5-0.6 | Mostly descriptive with few metrics |
| < 0.5 | Vague, responsibility-focused rather than achievement-focused |

### 4. Narrative

Is there a coherent career story connecting experiences to a trajectory?

| Score | Criteria |
|-------|----------|
| 0.9-1.0 | Clear career arc with logical progression and compelling theme |
| 0.7-0.8 | Readable narrative with minor disconnects |
| 0.5-0.6 | Disjointed; experiences listed without connecting thread |
| < 0.5 | No discernible narrative structure |

### 5. Presentation

Is the document well-formatted, scannable, and professional?

| Score | Criteria |
|-------|----------|
| 0.9-1.0 | Perfect formatting, consistent style, easy to scan |
| 0.7-0.8 | Good formatting with minor inconsistencies |
| 0.5-0.6 | Formatting issues that reduce readability |
| < 0.5 | Poor formatting, hard to read |

### 6. Differentiation

Does the document make the candidate stand out from similar profiles?

| Score | Criteria |
|-------|----------|
| 0.9-1.0 | Unique value proposition clear; memorable differentiators highlighted |
| 0.7-0.8 | Some differentiation but could be stronger |
| 0.5-0.6 | Generic; could apply to many candidates |
| < 0.5 | No distinguishing elements |

### 7. Target Fit (only when target-profile.md exists)

How well does the document align with the target job requirements?

| Score | Criteria |
|-------|----------|
| 0.9-1.0 | All must-have requirements addressed; nice-to-haves well covered; keywords optimized |
| 0.7-0.8 | Most requirements addressed; partial keyword coverage |
| 0.5-0.6 | Some requirements addressed but notable gaps |
| < 0.5 | Poor alignment with target requirements |

## Weighting

### Without Target (6 dimensions)

| Dimension | Weight |
|-----------|--------|
| Completeness | 20% |
| Accuracy | 25% |
| Impact | 20% |
| Narrative | 15% |
| Presentation | 10% |
| Differentiation | 10% |

### With Target (7 dimensions)

| Dimension | Weight |
|-----------|--------|
| Completeness | 17% |
| Accuracy | 22% |
| Impact | 17% |
| Narrative | 12% |
| Presentation | 8% |
| Differentiation | 9% |
| Target Fit | 15% |

## Gate Thresholds

- **Pass**: Overall weighted score >= 0.8
- **Fail + Retry**: Score < 0.8 AND iteration count < 3
- **Fail + User Decision**: Score < 0.8 AND iteration count >= 3

## Output Format

### quality-scores.json

```json
{
  "iteration": 1,
  "hasTarget": true,
  "dimensions": {
    "completeness": { "score": 0.85, "weight": 0.17, "weighted": 0.1445 },
    "accuracy": { "score": 0.90, "weight": 0.22, "weighted": 0.198 },
    "impact": { "score": 0.75, "weight": 0.17, "weighted": 0.1275 },
    "narrative": { "score": 0.80, "weight": 0.12, "weighted": 0.096 },
    "presentation": { "score": 0.90, "weight": 0.08, "weighted": 0.072 },
    "differentiation": { "score": 0.70, "weight": 0.09, "weighted": 0.063 },
    "targetFit": { "score": 0.85, "weight": 0.15, "weighted": 0.1275 }
  },
  "overallScore": 0.828,
  "passed": true,
  "weakestDimensions": ["differentiation", "impact"]
}
```

### quality-report.md

A human-readable report with:
- Score summary table
- Per-dimension analysis with specific examples
- Improvement recommendations (if not passed)
- Feedback routing suggestions (which agent should address which issue)
