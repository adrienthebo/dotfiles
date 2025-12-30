---
description: Create a PR message in ./DRAFT_MSG and optionally submit as draft
argument-hint: [base-branch]
allowed-tools: Bash(git *), Bash(gh pr *), Bash(rm ./DRAFT_MSG), Read, Write, Glob, AskUserQuestion
---

# Submit Pull Request Command

## Context

- Current branch: !`git branch --show-current`
- Repository root: !`git rev-parse --show-toplevel`
- Git status: !`git status --short`
- Recent commits: !`git log --oneline -5`

## Instructions

Create a pull request message for the current branch. The base branch is "$1" (defaults to "main" if not provided).

1. Check for a PR template in the repository root (use the first one found):
   - `.github/pull_request_template.md`
   - `.github/PULL_REQUEST_TEMPLATE.md`
   - `.github/pull_request_template/*.md`
   - `.github/PULL_REQUEST_TEMPLATE/*.md`
   - `docs/pull_request_template.md`
   - `docs/PULL_REQUEST_TEMPLATE.md`
2. Analyze changes with `git diff <base-branch>...HEAD`
3. Analyze commit history with `git log <base-branch>..HEAD`
4. Write the PR description to `./DRAFT_MSG` using the repository template if found, otherwise the default template below
5. Display `./DRAFT_MSG` contents for review
6. Ask the user: "Submit as draft PR?"
7. If yes:
   ```bash
   gh pr create --draft --title "<title>" --body "$(cat ./DRAFT_MSG)" && rm ./DRAFT_MSG
   ```
   If no, exit. The user can edit `./DRAFT_MSG` and submit manually.

## Default PR Description Template

Use this template only if no repository-specific template is found. Keep it concise and focused.

```markdown
## What?
[State the specific changes in 1-2 clear sentences.]

## Why?
[Explain the problem this solves. Be direct and clear about the issue.]

## How?
[Brief technical approach if non-obvious. Skip if straightforward.]

## Testing
[What testing was done.]

<details>
<summary>Test Results</summary>

**[test command]**

```
[Test output here]
```
</details>
```

## Test Output

When test output is available, use collapsible `<details>` sections. Include:
- The exact command used
- The relevant output (trim if very long)
- Multiple sections for different test types (unit, integration, e2e)

## Quality Checklist

- [ ] Title is concise but descriptive (format: `[service] brief description`)
  - `[https-terminator] check for Apple Private Relay`
  - `[protectd] use aho-corasick for user agent matching`
  - `[waf-controller] overhaul rule exclusion`
- [ ] Description uses active voice and complete sentences
- [ ] Each section provides meaningful context (not just "See ticket #123")
- [ ] Breaking changes are clearly highlighted
- [ ] Dependencies or deployment order are noted
