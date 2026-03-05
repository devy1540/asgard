# Target Analysis Protocol

Heimdall follows this protocol to analyze job postings and target conditions.

## Input Sources

Heimdall accepts one or more of the following input types:

### 1. URL

- Fetch the job posting page using `WebFetch`
- Supported platforms: Wanted, Saramin, LinkedIn, company career pages, etc.
- Extract structured text from the page content
- If the page fails to load, ask user to provide the text directly

### 2. Text

- User pastes job description or requirements directly
- Collected via Odin forwarding the user's input

### 3. File

- Read local files using the `Read` tool
- Supported formats: PDF, Markdown (.md), plain text (.txt)
- Path provided by user through Odin

Multiple sources can be combined for a single target profile (e.g., URL + additional notes).

## Extraction Framework

From the raw input, extract and structure the following:

### Company Information

| Field | Description | Required |
|-------|-------------|----------|
| name | Company name | Yes |
| industry | Industry/domain | Yes |
| size | Company size (startup/mid/enterprise) | If available |
| culture | Work culture keywords | If available |
| techStack | Known technology stack | If available |

### Position Details

| Field | Description | Required |
|-------|-------------|----------|
| title | Job title | Yes |
| level | Seniority level (junior/mid/senior/lead) | Yes |
| team | Team or department | If available |
| type | Full-time/Contract/Remote | If available |

### Requirements

#### Must-Have (Required)
- Technical skills explicitly marked as required
- Minimum years of experience
- Education requirements
- Certifications or licenses

#### Nice-to-Have (Preferred)
- Skills listed as "preferred" or "bonus"
- Additional experience areas
- Soft skills mentioned

### Keyword Analysis

Extract and rank keywords by frequency and emphasis:
1. **Primary keywords**: Appear 3+ times or in title/requirements
2. **Secondary keywords**: Appear 1-2 times in description
3. **Implicit keywords**: Industry-standard skills implied but not stated

### Evaluation Criteria

If the posting mentions how candidates will be evaluated:
- Assessment methods (coding test, portfolio review, etc.)
- Decision factors explicitly stated
- Cultural fit indicators

## Output Format

### target-profile.md

```markdown
# Target Profile

## Company
- **Name**: {company_name}
- **Industry**: {industry}
- **Size**: {size}
- **Culture**: {culture_keywords}

## Position
- **Title**: {job_title}
- **Level**: {level}
- **Team**: {team}
- **Type**: {employment_type}

## Requirements

### Must-Have
- [ ] {requirement_1}
- [ ] {requirement_2}
...

### Nice-to-Have
- [ ] {preferred_1}
- [ ] {preferred_2}
...

## Keyword Map

### Primary (High Impact)
{keyword}: {frequency} mentions — {context}

### Secondary
{keyword}: {context}

### Implicit
{keyword}: {reasoning}

## Evaluation Criteria
- {criterion_1}
- {criterion_2}

## Pipeline Guidance

### For Mimir (Interview)
- Deep-dive questions about: {relevant_experience_areas}
- Probe for: {specific_skills_to_verify}

### For Tyr (Analysis)
- Fit analysis focus: {key_requirements}
- Gap analysis targets: {potential_gap_areas}

### For Bragi (Writing)
- Summary angle: {suggested_narrative}
- Keywords to weave in: {top_keywords}
- Experience to prioritize: {relevant_experience_types}

### For Loki (Verification)
- JD compliance checklist: {must_have_items}
- Keyword coverage targets: {keyword_list}
```

## Edge Cases

- **Vague posting**: If the job description is too vague, note the ambiguity and extract what's available. Recommend Mimir ask the user for clarification.
- **Multiple positions**: If the input contains multiple job postings, ask Odin to clarify which position to target.
- **Non-Korean/English**: Support both Korean and English job postings. Output in the same language as the posting unless user specifies otherwise.
- **Expired postings**: Process normally but note that the posting may be outdated.
