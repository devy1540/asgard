# Clarity Enforcement

All agents (especially Bragi) must avoid vague, overused, or inflated language. This document defines banned expressions and their concrete alternatives.

## Banned Expressions

### Vague Descriptors

| Banned | Why | Alternative |
|--------|-----|-------------|
| "다양한 경험" | Says nothing specific | List the actual experiences |
| "Various technologies" | Meaningless without specifics | Name the technologies |
| "Extensive experience" | Unquantified | "5 years of experience in X" |
| "Passionate about" | Cliché, unverifiable | Show through actions/results |
| "Detail-oriented" | Generic trait | Demonstrate with specific examples |
| "Team player" | Overused | Describe specific collaboration outcomes |
| "Self-motivated" | Unverifiable | Show initiative through examples |
| "Results-driven" | Buzzword | State the actual results |

### Inflated Claims

| Banned | Why | Alternative |
|--------|-----|-------------|
| "Expert in" | Rarely verifiable | "Proficient in" or state years + achievements |
| "Led transformation" | Often exaggerated | Specify what changed and measurable outcome |
| "Revolutionized" | Almost always hyperbole | "Improved X by Y%" |
| "Cutting-edge" | Subjective | Name the specific technology/approach |
| "Best-in-class" | Unverifiable superlative | Compare with specific metrics |
| "Spearheaded" | Overused power verb | "Initiated and delivered" with specifics |

### Empty Filler

| Banned | Why | Alternative |
|--------|-----|-------------|
| "Responsible for" | Describes duty, not achievement | "Delivered/Built/Reduced/Increased" |
| "Assisted with" | Minimizes contribution | State specific contribution |
| "Helped to" | Vague | State what you did specifically |
| "Involved in" | Passive, unclear role | State your role and contribution |
| "Worked on" | No outcome | State what was built/achieved |
| "등등", "기타" | Lazy listing | Complete the list or omit |

## Enforcement Rules

1. **Bragi**: Must not use any banned expression in generated documents
2. **Loki**: Must flag any banned expression found during verification (severity: WARNING)
3. **Freya**: Penalize Presentation and Differentiation scores for banned expression usage

## Positive Patterns

Prefer these patterns in all generated content:

- **Action + Object + Metric**: "Reduced API response time from 2s to 200ms"
- **Context + Action + Result**: "As tech lead of 5-person team, migrated monolith to microservices, reducing deploy time by 80%"
- **STAR format**: Situation → Task → Action → Result (with numbers)
- **Specific over general**: "Python, Go, TypeScript" over "multiple programming languages"
- **Show don't tell**: Demonstrate qualities through examples rather than claiming them
