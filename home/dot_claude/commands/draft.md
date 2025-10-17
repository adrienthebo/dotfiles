# Submit Pull Request Command

Create a pull request message in ./DRAFT_MSG to speed the PR submission process while letting the human evaluate your work prior to submission.

## Instructions

Write a pull request message for this branch. The parent branch will be "$1"; if this field is empty then the parent branch will be "main".

You can check the diff with `git diff <PARENT>..HEAD`.

1. **Determine the git repo root** - First check if you're in a git worktree by running `git worktree list`. If the output shows you're in a worktree (the current directory matches one of the worktree paths), then that worktree directory IS the repository root for all purposes. Otherwise, run `git rev-parse --show-toplevel` to find the repository root. This is where the `.github` directory will be found.
2. **Check for PR template** - Look for a GitHub pull request template in the repository root (.github/pull_request_template.md or .github/PULL_REQUEST_TEMPLATE/*.md)
3. **Analyze all changes** - Review the full diff between the current branch and the base branch to understand ALL commits and changes that will be included
4. **Check for test results** - If tests have been run, prepare to include the output in the PR description using a collapsible details section
5. **Draft PR description** - Use the repository's template if found, otherwise use the default template below. Include test output if available. Write to ./DRAFT_MSG.

## Default PR Description Template

**Use this template only if no repository-specific template is found.**

Keep your PR description concise and focused. Clearly articulate the problem being solved - this explanation should be sufficient without needing lists of benefits.

```markdown
## What?
[State the specific changes in 1-2 clear sentences.]

## Why?
[Explain the problem this solves. Be direct and clear about the issue - a well-articulated problem statement makes the benefits self-evident.]

## How?
[Brief technical approach if non-obvious. Skip if straightforward.]

## Testing
[What testing was done.]

[If test output is available, include it in a collapsible section:]
<details>
<summary>Test Results</summary>

**npm test** (or other test command)

```
[Test output here]
```
</details>
```

## Including Test Output

When test output is available, include it in the PR description using collapsible details sections:

```markdown
<details>
<summary>Unit Test Results</summary>

**npm test**

```
✓ should handle user authentication (45ms)
✓ should validate input data (12ms)
✓ should return proper error codes (23ms)

Test Suites: 3 passed, 3 total
Tests: 15 passed, 15 total
```
</details>
```

This keeps the PR description clean while providing easy access to verification details. Include:
- The exact command used to run tests
- The complete relevant output (can be trimmed if very long)
- Multiple details sections for different test types (unit, integration, e2e)

## Quality Checklist

Before creating the PR, ensure:

- [ ] Title is concise but descriptive (format: `[service] brief description`)
  - Examples
    - `[https-terminator] check for Apple Private Relay`
    - `[protectd] use aho-corasick for user agent matching`
    - `[waf-controller] overhaul rule exclusion`
- [ ] Description uses active voice and complete sentences
- [ ] Each section provides meaningful context (not just "See ticket #123")
- [ ] Breaking changes are clearly highlighted
- [ ] Dependencies or deployment order are noted

## Execution

When this command is invoked, immediately:
1. Determine the repository root:
   - Run `git worktree list` to check if you're in a worktree
   - If in a worktree, use that directory as the repository root
   - Otherwise, use `git rev-parse --show-toplevel` for the repository root
2. Check for PR template files in the repository root:
   - `.github/pull_request_template.md`
   - `.github/PULL_REQUEST_TEMPLATE/*.md`
   - `docs/pull_request_template.md`
3. Run `git status` and `git diff --merge-base [base] HEAD` to understand all changes
4. Analyze the commit history with `git log --merge-base [base]`
5. Create the PR and open in browser for review:
   ```bash
   gh pr create --web --title "type: brief description" --body "$(cat <<'EOF'
   [Use repository template if found, otherwise:]
   
   ## What?
   [Description here]
   
   ## Why?
   [Explanation here]
   
   ## How?
   [Implementation details here]
   
   ## Testing
   [Test coverage here]

   <details>
   <summary>Test Results</summary>

   **[test command here]**

   ```
   [test output here]
   ```
   </details>
   EOF
   )"
   ```
   
Remember: A good PR description reduces review time, prevents misunderstandings, and serves as documentation for future reference.
