---
description: Create git commits with appropriate messages following repository conventions
allowed-tools: Bash(git status), Bash(git diff:*), Bash(git log:*), Bash(git show:*), Bash(git branch:*), Read, Glob
---

# Commit Command

## Context

- Current branch: !`git branch --show-current`
- Status: !`git status --short`
- Staged changes: !`git diff --staged --stat`
- Unstaged changes: !`git diff --stat`
- Recent commits: !`git log --oneline -10`

## Instructions

Create a commit for the current changes. If no files are staged, stage all changes first.

1. Review the context above to understand current state
2. Check for commit conventions:
   - Look for `.gitmessage`, `commitlint.config.js`, `.commitlintrc.*`
   - Detect format from recent commit history
3. Stage changes if needed:
   - If user specified files, stage only those
   - Otherwise, stage all unstaged files by listing them individually (`git add file1 file2 ...`)
   - **Never use `git add -A` or `git add --all`** - always add files individually
   - Never commit build artifacts, generated files, or secrets
4. Construct the commit message following detected conventions
5. Create the commit using heredoc for multi-line messages:
   ```bash
   git commit -m "$(cat <<'EOF'
   Subject line here

   Optional body explaining rationale.
   EOF
   )"
   ```
6. Verify with `git show --stat`

## Message Format

### Subject Line
- 50 chars ideal, 72 max
- Imperative mood ("Add" not "Added")
- No period at end
- Follow repo convention for capitalization

### Body (when needed)
- Required for: breaking changes, complex logic, non-obvious reasons
- Wrap at 72 characters
- Explain WHY, not WHAT

### Footer (when applicable)
- Issue references: `Fixes #123`, `Closes #456`
- Breaking changes: `BREAKING CHANGE: description`

## Convention Detection

| Pattern | Format | Example |
|---------|--------|---------|
| Conventional Commits | `type(scope): desc` | `feat(auth): add OAuth2` |
| Component Prefix | `[component] desc` | `[api] fix rate limiting` |
| Simple Imperative | `Verb description` | `Add user authentication` |

Types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert

## Rules

- **Never amend or squash** - always create new commits
- **Never commit secrets** - no API keys, passwords, .env files, private keys
- **Atomic commits** - one logical change per commit
- **Detect, don't assume** - use repo patterns over generic standards
- **Separate commands** - run `git add` and `git commit` as separate Bash tool invocations, never chained with `&&`
- If pre-commit hooks modify files, stage them and create a new commit

## After Commit

Report:
```
Committed: [hash] "commit message"
Files changed: X, insertions: Y, deletions: Z
```
