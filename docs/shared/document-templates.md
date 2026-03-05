# Document Templates

Bragi uses these templates as the structural foundation for generating Resume.md and Portfolio.md. Adapt sections based on available data and target requirements.

## Resume.md Template

```markdown
# {Full Name}

{Email} | {Phone} | {Location}
{LinkedIn} | {GitHub} | {Portfolio URL}

---

## Summary

{2-3 sentences: career identity + key differentiator + career direction}
{If target exists: tailored to target position and company}

---

## Experience

### {Job Title} — {Company Name}
{Start Date} – {End Date} | {Location}

- {Achievement with measurable impact: Action + Object + Metric}
- {Achievement with measurable impact}
- {Achievement with measurable impact}
- **Tech Stack**: {technologies used}

### {Job Title} — {Company Name}
{Start Date} – {End Date} | {Location}

- {Achievement}
- {Achievement}
- **Tech Stack**: {technologies}

---

## Skills

### Technical
- **Languages**: {list}
- **Frameworks**: {list}
- **Infrastructure**: {list}
- **Tools**: {list}

### Domain Expertise
- {Domain area}: {specific expertise}

---

## Projects

### {Project Name}
{One-line description} | {Role} | {Date}

- {Key contribution with impact}
- {Key contribution with impact}
- **Tech Stack**: {technologies}
- **Link**: {URL if available}

---

## Education

### {Degree} — {University}
{Graduation Date}
- {Relevant coursework, honors, or activities}

---

## Certifications & Awards

- {Certification/Award}: {Issuer} ({Date})

---

## Languages

- {Language}: {Proficiency level}
```

## Portfolio.md Template

```markdown
# Portfolio — {Full Name}

> {One-line professional identity statement}

---

## Career Overview

{3-5 paragraphs telling the career story:}
{- How did you start?}
{- What's your specialization/expertise?}
{- What drives your work?}
{- Where are you heading?}
{If target exists: frame the narrative toward the target role}

---

## Featured Projects

### 1. {Project Name}

**Context**: {Company/Personal} | {Date Range} | {Team Size}
**Role**: {Your specific role}

#### Problem
{What problem did you solve? Why did it matter?}

#### Approach
{How did you approach the problem? Key technical decisions.}

#### Implementation
{Key technical details, architecture decisions, challenges overcome}

#### Results
- {Quantified outcome 1}
- {Quantified outcome 2}
- {Quantified outcome 3}

**Tech Stack**: {technologies}
**Links**: {GitHub, Demo, Article — if available}

---

### 2. {Project Name}

{Same structure as above}

---

## Technical Expertise

### {Domain 1}: {e.g., Backend Engineering}

{Paragraph describing depth of expertise with specific examples}

- **Key Technologies**: {list}
- **Notable Achievement**: {specific example}

### {Domain 2}: {e.g., System Design}

{Paragraph with examples}

---

## Impact Highlights

| Metric | Achievement | Context |
|--------|-------------|---------|
| {metric} | {number/result} | {project/company} |
| {metric} | {number/result} | {project/company} |

---

## Open Source & Community

- **{Project/Contribution}**: {description} ({stars/impact})
- **{Speaking/Writing}**: {topic} at {venue}

---

## Education & Continuous Learning

- {Degree} — {University} ({Year})
- {Certification} — {Issuer} ({Year})
- {Course/Self-study}: {topic}
```

## Template Usage Rules

1. **Adapt, don't force-fit**: If the user lacks data for a section, omit it rather than filling with placeholder text
2. **Target optimization**: When target-profile.md exists, reorder and emphasize sections that match target requirements
3. **Language**: Match the user's primary language (detected from interview) unless specified otherwise
4. **Length**: Resume should be 1-2 pages equivalent in markdown. Portfolio can be longer (3-5 pages)
5. **Consistency**: Use the same date format, naming style, and structure throughout
6. **Clarity enforcement**: Apply rules from clarity-enforcement.md — no banned expressions
