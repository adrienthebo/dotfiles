# /commit Command Documentation

## Purpose
Intelligently create git commits with appropriate messages that follow repository conventions and best practices.

## Core Workflow

### 1. Parallel Initial Analysis (ALWAYS run these together)
Run these commands in parallel to understand the current state:
```bash
git status                          # Check working tree state
git diff --staged                   # View staged changes
git diff                           # View unstaged changes
git log --oneline -20             # Recent commit patterns
git branch --show-current          # Current branch name
```

### 2. Determine Commit Strategy

#### A. Check for Explicit Conventions
1. Look for commit convention files:
   - `.gitmessage` - Git message template
   - `CONTRIBUTING.md` - Contribution guidelines
   - `.github/pull_request_template.md` - PR conventions
   - `commitlint.config.js` - Commit linting rules
   - `.commitlintrc.*` - Alternative commitlint config

2. Detect commit message format from recent history:
   ```bash
   git log --oneline -30 | head -10
   ```

#### B. Pattern Recognition Priority
1. **Conventional Commits** (if detected: `feat:`, `fix:`, `docs:`, etc.)
   ```
   type(scope): description
   ```
   Types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert

2. **Component/Module Prefix** (if detected: `[component]`, `[module]`)
   ```
   [component] Action description
   ```

3. **Simple Imperative** (default fallback)
   ```
   Add/Update/Fix/Remove description
   ```

### 3. Message Construction Rules

#### Subject Line
- **Length**: 50 chars ideal, 72 max
- **Tense**: Imperative mood ("Add" not "Added")
- **Capitalization**: Follow repo convention (usually capitalize first word)
- **Punctuation**: No period at end
- **Content**: WHAT changed, not HOW

#### Body (when needed)
- Required when:
  - Breaking changes
  - Complex logic changes
  - Non-obvious reasons for change
  - Multiple related changes
- Wrap at 72 characters
- Explain WHY, not WHAT (the diff shows what)
- Use bullet points for multiple items

#### Footer (when applicable)
- Issue references: `Fixes #123`, `Closes #456`
- Breaking changes: `BREAKING CHANGE: description`
- Co-authors: `Co-authored-by: Name <email>`

### 4. Execution Process

#### Stage Changes (if needed)
```bash
# Analyze what needs staging
git status

# Stage appropriately:
git add -A          # All changes (new, modified, deleted)
git add -u          # Only tracked files
git add <specific>  # Specific files
```

#### Create Commit
Always use heredoc for multi-line messages:
```bash
git commit -m "$(cat <<'EOF'
Subject line here

Optional body paragraph explaining the rationale.
Can be multiple paragraphs.

Fixes: #123
EOF
)"
```

For simple one-liners:
```bash
git commit -m "type(scope): brief description"
```

#### Post-Commit Verification
```bash
git status        # Ensure commit succeeded
git show --stat   # Review the commit
```

### 5. Automated Decision Matrix

| Change Type | Conventional | Simple | Example |
|------------|--------------|---------|---------|
| New feature | `feat:` | Add | `feat(auth): add OAuth2 support` |
| Bug fix | `fix:` | Fix | `fix(parser): handle null values` |
| Documentation | `docs:` | Update | `docs: update API examples` |
| Style/Format | `style:` | Format | `style: apply consistent indentation` |
| Refactoring | `refactor:` | Refactor | `refactor(db): simplify query builder` |
| Performance | `perf:` | Optimize | `perf: cache database queries` |
| Tests | `test:` | Add/Update | `test: add unit tests for auth` |
| Build/Dependencies | `build:` | Update | `build: upgrade to Node 20` |
| CI/CD | `ci:` | Update | `ci: add GitHub Actions workflow` |
| Maintenance | `chore:` | Update | `chore: update dev dependencies` |
| Revert | `revert:` | Revert | `revert: revert commit abc123` |

### 6. Special Handling

#### Pre-commit Hooks
- If commit fails due to hooks, check output for:
  - Formatting changes made automatically
  - Linting errors to fix
  - Test failures
- After hooks run, if files were modified:
  ```bash
  git add -u
  git commit -m "Apply pre-commit hook changes"
  ```

#### Multiple Changes Assessment
Before committing, evaluate if changes should be:
- **Single commit**: Related changes for one feature/fix
- **Multiple commits**: Unrelated changes or logical separations
- Use `git add -p` for partial staging if needed

#### Sensitive Content Check
Never commit:
- API keys, passwords, tokens
- `.env` files with secrets
- Private keys or certificates
- Personal data or PII
- Large binary files (unless tracked by LFS)

### 7. Error Recovery

#### Common Issues and Solutions
| Issue | Solution |
|-------|----------|
| Pre-commit hook failure | Fix issues, re-stage, retry |
| Empty commit message | Ensure message not blank |
| Nothing to commit | Check `git status`, stage files |
| Detached HEAD | Checkout a branch first |
| Merge in progress | Complete or abort merge |

#### Fixing Mistakes
If you forgot files or need to correct something:
```bash
# Stage the forgotten/fixed files
git add <files>
# Create a new commit with the fix
git commit -m "Add missing files" # or "Fix: description"
```

**Important**: Always create new commits rather than amending existing ones. This maintains a clear history of changes.

### 8. Claude-Specific Instructions

#### Workflow Priority
1. **ALWAYS** run initial analysis commands in parallel
2. **NEVER** assume conventions - detect from repository
3. **PREFER** existing patterns over generic standards
4. **AVOID** overly verbose messages unless complex change
5. **CHECK** for staged vs unstaged intelligently
6. **NEVER** amend or squash commits - only create new ones

#### Conciseness Rules
- Single file change, obvious fix = one-line message
- Multiple files, same feature = one-line with good summary
- Breaking change = always include body
- Performance improvement = include metrics if available

#### Intelligent Staging
- If user says "commit", assume they want all changes
- If specific files mentioned, stage only those
- If mix of related/unrelated, ask for clarification
- Never commit build artifacts or generated files

#### Pattern Matching Priority
1. Explicit repo configuration files
2. Recent commit history patterns (last 20 commits)
3. Branch-specific patterns
4. Language/framework conventions
5. Generic best practices

### 9. Examples by Repository Type

#### Node.js/JavaScript Project
```bash
# Detected: package.json, conventional commits in history
git commit -m "feat(api): add rate limiting middleware"
git commit -m "fix(auth): prevent session timeout during upload"
git commit -m "chore: update dependencies"
```

#### Python Project
```bash
# Detected: setup.py, simple imperatives in history
git commit -m "Add type hints to core modules"
git commit -m "Fix memory leak in data processing"
git commit -m "Update pytest configuration"
```

#### Monorepo
```bash
# Detected: multiple package.json, component prefixes
git commit -m "[web] Add dark mode toggle"
git commit -m "[api] Fix database connection pooling"
git commit -m "[shared] Update utility functions"
```

#### Documentation Changes
```bash
git commit -m "docs: update installation instructions"
git commit -m "docs: add API usage examples"
git commit -m "Update README with new badges"
```

### 10. Quality Checklist

Before finalizing commit:
- [ ] Message follows detected repository convention
- [ ] Subject line is clear and under 72 chars
- [ ] Imperative mood used (with rare exceptions)
- [ ] No typos or grammatical errors
- [ ] Issue references included if applicable
- [ ] No sensitive information included
- [ ] Changes are related (atomic commit)
- [ ] Build/tests pass (if can be verified quickly)

### 11. Quick Reference

#### Minimal Workflow
```bash
# Analyze (parallel)
git status && git diff --staged && git log --oneline -10

# Stage
git add -A

# Commit
git commit -m "type: description"

# Verify
git show --stat
```

#### When User Says "commit" or "/commit"
1. Run parallel analysis
2. Auto-detect pattern
3. Stage all changes (unless specified)
4. Generate appropriate message
5. Commit
6. Show result

#### Response Format
After successful commit:
```
✓ Committed: [hash] "commit message here"
Files changed: X, insertions: Y, deletions: Z
```

### 12. Advanced Patterns

#### Multiple Related Changes
Keep commits atomic and focused. Each commit should represent one logical change. If you have multiple unrelated changes, create separate commits for each.

#### Split Commits (when requested)
```bash
git reset HEAD~1  # Undo last commit, keep changes
git add <files-for-first-change>
git commit -m "Part 1: description"
git add <files-for-second-change>
git commit -m "Part 2: description"
```

#### Sign Commits (if configured)
```bash
git commit -S -m "message"  # GPG sign
```

## Important Notes

### Commit Philosophy
- **Never amend commits**: Always create new commits to preserve history
- **Never squash commits**: Each commit should stand on its own
- **Fix forward**: If something is wrong, create a new commit to fix it
- **Preserve history**: The commit history tells the story of the project

### Error Correction Strategy
When you discover an error after committing:
1. Don't panic - commits are meant to show progression
2. Create a new commit that fixes the issue
3. Use clear commit messages like:
   - `Fix: correct typo in previous commit`
   - `Add: include forgotten test file`
   - `Fix: resolve linting errors`

## Remember
- Follow repository patterns over generic rules
- Be concise but complete
- Stage intelligently based on context
- Verify success before reporting completion
- Never commit secrets or sensitive data
- Always create new commits, never modify existing ones