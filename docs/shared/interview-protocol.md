# Interview Protocol

Mimir follows this protocol to conduct Socratic-style interviews. The goal is to extract comprehensive, specific, and verifiable information about the user.

## Interview Flow

### Session Parameters
- **Maximum rounds**: 15
- **Completeness threshold**: 0.7 (per dimension)
- **Questions per round**: 1-3 (adaptive based on response depth)

### Flow Rules

1. **Start broad, go deep**: Begin with open-ended questions, then drill into specifics based on responses
2. **Follow the thread**: If a user mentions something interesting, probe deeper before moving to the next topic
3. **Validate specifics**: When users give vague answers, ask for numbers, dates, team sizes, and outcomes
4. **Respect the user**: If they indicate a topic is sensitive or off-limits, respect that and move on
5. **No leading questions**: Don't suggest answers or put words in the user's mouth
6. **Acknowledge before asking**: Briefly acknowledge the previous answer before the next question

### Completeness Scoring

Track completeness across 6 dimensions. Each dimension scored 0.0-1.0:

| Dimension | Weight | 0.7 Threshold |
|-----------|--------|----------------|
| Career History | 25% | All positions with dates, roles, and key achievements |
| Technical Skills | 20% | Skill list with proficiency levels and usage context |
| Key Projects | 25% | At least 3 projects with STAR details |
| Soft Skills & Leadership | 10% | Communication style, leadership examples |
| Education & Certifications | 10% | Degrees, certifications, relevant training |
| Goals & Motivation | 10% | Career direction, motivation, interests |

### Dimension Pass: score >= 0.7
### Overall Pass: all dimensions >= 0.7 OR average >= 0.75

## Question Bank

### Career History

**Opening**:
- "Tell me about your current role. What does a typical week look like?"
- "Walk me through your career journey — how did you get to where you are now?"

**Follow-up**:
- "What was your biggest achievement at {company}?"
- "How large was your team, and what was your specific role?"
- "Why did you transition from {role_A} to {role_B}?"
- "What was the most challenging project at {company} and how did you handle it?"

**Depth**:
- "You mentioned {X}. Can you quantify the impact? (users served, revenue, performance improvement)"
- "What was the before and after? What metrics changed?"

### Technical Skills

**Opening**:
- "What technologies do you work with most frequently right now?"
- "If you had to pick your top 3 strongest technical skills, what would they be and why?"

**Follow-up**:
- "How long have you been using {technology}? In what context?"
- "Describe a complex technical problem you solved with {technology}"
- "How do you stay current with {technology domain}?"

**Depth**:
- "What's a technical decision you made that you're particularly proud of?"
- "Have you contributed to any open source projects? Which ones?"

### Key Projects

**Opening**:
- "What's the project you're most proud of in your career?"
- "Tell me about a project where you had significant ownership"

**Follow-up (STAR)**:
- "What was the situation/context? (Situation)"
- "What were you specifically tasked with? (Task)"
- "What did you actually do? Walk me through your approach. (Action)"
- "What was the outcome? Any metrics? (Result)"

**Depth**:
- "What was the tech stack for that project?"
- "What would you do differently if you did it again?"
- "How many people were involved and what was your specific contribution?"

### Soft Skills & Leadership

**Opening**:
- "Have you mentored or managed other engineers? Tell me about that experience."
- "Describe a time you had to influence a decision without authority."

**Follow-up**:
- "How do you handle disagreements in technical decisions?"
- "Tell me about a time you had to communicate a complex technical concept to non-technical stakeholders."

### Education & Certifications

**Opening**:
- "What's your educational background?"
- "Do you have any certifications or have you completed any notable courses?"

**Follow-up**:
- "How has your education influenced your career direction?"
- "Any relevant research or thesis work?"

### Goals & Motivation

**Opening**:
- "Where do you see your career heading in the next 2-3 years?"
- "What kind of problems do you want to solve next?"

**Follow-up**:
- "What motivates you most in your work?"
- "What's your ideal team/company culture?"

## Target-Aware Interview

When `target-profile.md` exists, add these adaptations:

1. **Priority probing**: After covering basics, specifically ask about experiences matching target must-have requirements
2. **Gap exploration**: If the user hasn't mentioned a required skill, explicitly ask about it
3. **Keyword alignment**: Listen for experiences that map to target keywords and drill deeper
4. **Culture fit**: Ask about work styles that match target company culture

Example target-aware questions:
- "The role requires {skill}. Tell me about your experience with that."
- "This position involves {responsibility}. Have you done similar work?"
- "The company values {value}. Can you share an example of when you demonstrated that?"

## Output Format

### interview-log.md

```markdown
# Interview Log

**Session**: {session_id}
**Date**: {date}
**Rounds**: {count}
**Duration**: {estimated}

## Round {N}

**Q**: {question}
**A**: {user's answer}
**Follow-up**: {if any}

...

## Completeness Assessment

| Dimension | Score | Status | Notes |
|-----------|-------|--------|-------|
| Career History | 0.85 | PASS | All positions covered with metrics |
| Technical Skills | 0.75 | PASS | Good coverage, some skills need depth |
| ... | ... | ... | ... |

**Overall**: {score} — {PASS/NEEDS_MORE}
```

### completeness-scores.json

```json
{
  "rounds": 12,
  "dimensions": {
    "careerHistory": { "score": 0.85, "status": "pass" },
    "technicalSkills": { "score": 0.75, "status": "pass" },
    "keyProjects": { "score": 0.80, "status": "pass" },
    "softSkills": { "score": 0.70, "status": "pass" },
    "education": { "score": 0.90, "status": "pass" },
    "goals": { "score": 0.75, "status": "pass" }
  },
  "overallScore": 0.79,
  "passed": true
}
```
