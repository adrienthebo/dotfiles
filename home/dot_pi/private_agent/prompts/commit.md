---
description: Create a signed, atomic git commit following repository conventions
argument-hint: "[files to commit]"
---
Create a commit for the current intended changes. Requested file scope: ${@:-not specified}. When none is specified, determine which files belong to the current task; do not assume every unstaged file is intended.

First run `git rev-parse --show-toplevel`, `pwd`, `git branch --show-current`, `git status --short`, `git diff --staged --stat`, `git diff --stat`, and `git log --oneline -10`. Review staged and unstaged diffs, including untracked files you intend to commit. Check `.gitmessage`, `commitlint.config.js`, and `.commitlintrc.*` if present. Follow repository instructions over this template.

If files were specified, stage only those files. Otherwise, stage only the changes relevant to the current task, listing paths explicitly in a separate `git add` command. Never use `git add -A` or `git add --all`; never include unrelated changes, secrets, or unintended build artifacts. If the intended scope is unclear, ask before staging. Verify the staged diff before committing.

Use a single-line, imperative subject following the repository's convention (ideally 50 characters, at most 72, no terminal period). In the Vercel API monorepo, prefix it with the exact affected package name from `package.json` in brackets; when several packages change, prefer the one with the largest change. Add a body only if explicitly requested. Keep the commit atomic.

Commit with signing enabled. If this environment requires keychain initialization, use `eval "$(keychain --eval)" && git commit -m "<subject>"`; otherwise use the configured signing path. Never bypass signing or hooks. If signing or keychain initialization fails, stop and ask for help. Do not amend or squash an existing commit. If a hook changes files, inspect those changes and stage them explicitly before attempting a fresh commit.

Verify with `git show --stat --oneline HEAD` and report the commit hash, subject, and files/insertions/deletions. Do not push unless separately requested.
