# Asgard

PR 자료(이력서/포트폴리오) 생성을 위한 Claude Code 플러그인.

Norse mythology 테마의 8개 에이전트가 5단계 파이프라인을 통해 맞춤형 이력서와 포트폴리오를 생성합니다.

## Features

- **타겟 맞춤형 생성**: 채용공고 URL, 텍스트, 파일을 분석하여 JD에 최적화된 산출물 생성
- **소크라테스식 인터뷰**: 6개 차원(경력/기술/프로젝트/소프트스킬/학력/목표)별 심층 질문
- **외부 데이터 연동**: GitHub, Slack, Notion, Jira 등 MCP 커넥터를 통한 데이터 수집
- **품질 게이트**: 7차원 품질 평가 + 자동 피드백 루프 (최대 3회 반복)
- **확장 가능**: 커넥터 프로토콜에 정의만 추가하면 새 데이터 소스 연동 가능

## Agents

| Agent | Role | Description |
|-------|------|-------------|
| **Odin** | Orchestrator | 팀 생성, 위상 전환, 게이트 판정 |
| **Heimdall** | Target Analyst | 채용공고/조건 분석 → 타겟 프로필 생성 |
| **Mimir** | Interviewer | 소크라테스식 질문으로 사용자 정보 수집 |
| **Huginn** | Data Collector | MCP 커넥터로 외부 데이터 수집 |
| **Tyr** | Analyst | 데이터 교차 검증 + 적합도/갭 분석 |
| **Bragi** | Writer | Resume.md + Portfolio.md 생성 |
| **Loki** | Verifier | 주장별 근거 확인, 과장 탐지 |
| **Freya** | Quality Evaluator | 6-7차원 품질 점수 산정 |

## Pipeline

```
Phase 0: Setup — 세션 초기화, 커넥터 탐색
Phase 0.5: Target Analysis — 채용공고 분석 (선택적)
Phase 1: Interview — 소크라테스식 인터뷰 (max 15 rounds)
Phase 2: Data Collection — 외부 데이터 수집
Phase 3: Analysis — 교차 검증 + 구조화
Phase 4: Generation — Resume.md + Portfolio.md
Phase 5: Verification — 과장/누락 검증
Phase 6: Quality Gate — 품질 평가 (>= 0.8 통과)
Phase 7: Teardown — 정리 + 결과 전달
```

품질 점수가 0.8 미만이면 피드백 루프가 Phase 4로 돌아가 최대 3회 반복합니다.

## Skills (Commands)

| Command | Description |
|---------|-------------|
| `/asgard:bifrost` | Full Pipeline — 인터뷰부터 최종 산출물까지 전체 수행 |
| `/asgard:mimir` | Interview Only — 나중에 forge로 문서 생성 가능 |
| `/asgard:forge` | Document Generation — 기존 데이터로 문서 생성 (인터뷰 스킵) |

## Quick Start

### Full Pipeline

```
/asgard:bifrost
```

채용공고가 있으면 URL/텍스트/파일로 제공하여 맞춤형 산출물을 받을 수 있습니다.

### Interview → Later Generation

```
# Step 1: 인터뷰만 수행
/asgard:mimir

# Step 2: 나중에 다른 타겟으로 문서 생성
/asgard:forge
```

## Output

산출물은 `.asgard/{session-id}/output/` 디렉토리에 저장됩니다:

```
.asgard/bifrost-20260305-abc123/output/
├── Resume.md      # 이력서
└── Portfolio.md   # 포트폴리오
```

## Quality Dimensions

| Dimension | Without Target | With Target |
|-----------|---------------|-------------|
| Completeness | 20% | 17% |
| Accuracy | 25% | 22% |
| Impact | 20% | 17% |
| Narrative | 15% | 12% |
| Presentation | 10% | 8% |
| Differentiation | 10% | 9% |
| Target Fit | — | 15% |

Pass threshold: **0.8**

## Connectors

Built-in MCP connectors: **GitHub**, **Slack**, **Notion**, **Jira**

새 커넥터 추가는 `docs/shared/connector-protocol.md`에 Discovery, Extraction, Structuring, Degradation 4개 항목만 정의하면 됩니다.

## Project Structure

```
asgard/
├── .claude-plugin/        # Plugin metadata
│   ├── marketplace.json
│   └── plugin.json
├── agents/                # 8 Norse mythology agents
│   ├── odin.md
│   ├── heimdall.md
│   ├── mimir.md
│   ├── huginn.md
│   ├── tyr.md
│   ├── bragi.md
│   ├── loki.md
│   └── freya.md
├── skills/                # Slash commands
│   ├── bifrost/SKILL.md
│   ├── mimir/SKILL.md
│   └── forge/SKILL.md
├── docs/shared/           # Shared protocols
│   ├── worker-preamble.md
│   ├── team-teardown.md
│   ├── quality-scoring.md
│   ├── clarity-enforcement.md
│   ├── connector-protocol.md
│   ├── target-analysis.md
│   ├── document-templates.md
│   └── interview-protocol.md
└── hooks/                 # PostToolUse hooks
    ├── hooks.json
    ├── validate-gate.sh
    └── checkpoint.sh
```

## License

MIT
