# Connector Protocol

Extensible data source connector architecture for Huginn. New connectors can be added by defining the four required sections below — no agent code changes needed.

## Connector Interface

Each connector defines four components:

### 1. Discovery

How to detect if the MCP tools for this source are available.

```
discovery:
  toolSearchQuery: "<keyword to search>"
  requiredTools: ["<tool_name_1>", "<tool_name_2>"]
  optional: true  # If true, pipeline continues without this connector
```

### 2. Extraction

Which MCP tools to call and in what order to extract data.

```
extraction:
  steps:
    - tool: "<tool_name>"
      params: { ... }
      output: "<variable_name>"
    - tool: "<tool_name>"
      params: { ... }
      dependsOn: "<previous_variable>"
      output: "<variable_name>"
```

### 3. Structuring

How to format the extracted data into standardized output.

```
structuring:
  jsonSchema:
    type: object
    properties: { ... }
  summaryTemplate: |
    ## {source_name} Profile
    - **Key Metric**: {value}
    ...
```

### 4. Degradation

What to do when the connector is unavailable.

```
degradation:
  behavior: skip  # skip | warn | error
  fallbackMessage: "GitHub data unavailable — skipping repository analysis"
  impactedDimensions: ["completeness"]
```

---

## Built-in Connectors

### GitHub Connector

```yaml
discovery:
  toolSearchQuery: "github"
  requiredTools: ["mcp__plugin_github_github__get_me", "mcp__plugin_github_github__search_repositories"]
  optional: true

extraction:
  steps:
    - tool: mcp__plugin_github_github__get_me
      output: user_profile
    - tool: mcp__plugin_github_github__search_repositories
      params:
        query: "user:{username}"
      output: repositories
    - tool: mcp__plugin_github_github__list_commits
      params:
        owner: "{username}"
        repo: "{top_repo}"
      output: recent_commits

structuring:
  jsonFile: github-profile.json
  fields:
    - username
    - publicRepos (count)
    - topRepositories (name, stars, language, description) — top 10 by stars
    - contributionStats (commits, PRs, issues last year)
    - primaryLanguages
    - notableProjects (repos with most stars/forks)

degradation:
  behavior: skip
  fallbackMessage: "GitHub MCP not available — skipping code portfolio analysis"
  impactedDimensions: ["completeness", "accuracy"]
```

### Slack Connector

```yaml
discovery:
  toolSearchQuery: "slack"
  requiredTools: ["mcp__claude_ai_Slack__slack_read_user_profile"]
  optional: true

extraction:
  steps:
    - tool: mcp__claude_ai_Slack__slack_read_user_profile
      output: slack_profile
    - tool: mcp__claude_ai_Slack__slack_search_public
      params:
        query: "from:{user} has:link"
      output: shared_resources

structuring:
  jsonFile: slack-profile.json
  fields:
    - displayName
    - title
    - statusText
    - teamMemberships
    - activityPatterns

degradation:
  behavior: skip
  fallbackMessage: "Slack MCP not available — skipping workplace communication analysis"
  impactedDimensions: ["completeness"]
```

### Notion Connector

```yaml
discovery:
  toolSearchQuery: "notion"
  requiredTools: ["mcp__notionApi__API-post-search"]
  optional: true

extraction:
  steps:
    - tool: mcp__notionApi__API-post-search
      params:
        query: "resume OR portfolio OR project"
      output: relevant_pages
    - tool: mcp__notionApi__API-retrieve-a-page
      params:
        page_id: "{page_id}"
      output: page_content

structuring:
  jsonFile: notion-data.json
  fields:
    - relevantPages (title, lastEdited, summary)
    - projectDocumentation
    - personalNotes

degradation:
  behavior: skip
  fallbackMessage: "Notion MCP not available — skipping document analysis"
  impactedDimensions: ["completeness"]
```

### Jira Connector

```yaml
discovery:
  toolSearchQuery: "jira atlassian"
  requiredTools: ["mcp__claude_ai_Atlassian__searchJiraIssuesUsingJql"]
  optional: true

extraction:
  steps:
    - tool: mcp__claude_ai_Atlassian__atlassianUserInfo
      output: user_info
    - tool: mcp__claude_ai_Atlassian__searchJiraIssuesUsingJql
      params:
        jql: "assignee = currentUser() ORDER BY updated DESC"
      output: assigned_issues

structuring:
  jsonFile: jira-data.json
  fields:
    - projectsContributed (project name, role)
    - issueStats (total, resolved, types)
    - recentWork (last 20 issues with summary)

degradation:
  behavior: skip
  fallbackMessage: "Jira/Atlassian MCP not available — skipping project management analysis"
  impactedDimensions: ["completeness"]
```

## Adding a New Connector

To add a new data source:

1. Define the four sections (Discovery, Extraction, Structuring, Degradation) following the format above
2. Add the definition to this file under "Built-in Connectors"
3. Huginn will automatically discover and use it at runtime

No changes to agent code are required. Huginn reads this protocol file and dynamically executes connectors based on MCP tool availability.
