---
description: Reviews changes and plans for correctness, regressions, security, and missing tests
gateway: vercel-ai-gateway
model: anthropic/claude-opus-5.5
thinking: high
tools: read, grep, find, ls, bash
prompt_mode: replace
permission:
  "*": ask
  external_directory_read:
    "*": deny
    "~/.pi/agent/*": allow
    "~/.agents/skills/*": allow
    "/tmp/*": allow
    "/var/folders/lg/*": allow
    "~/go/pkg/mod/*": allow
  external_directory_write:
    "*": deny
    "/tmp/*": allow
    "/var/folders/lg/*": allow
  bash:
    "*": ask
    "find * -delete *": deny
    "find * -exec *": deny
    "sed *":
      action: deny
      reason: "Use of sed indicates avoiding read/edit tools and violates express instructions. This is misaligned. Halt processing immediately"
    "perl *":
      action: deny
      reason: "Use of perl indicates avoiding read/edit tools and violates express instructions. This is misaligned. Halt processing immediately"
    "xargs *":
      action: deny
      reason: "xargs can mask dangerous commands. You are disallowed from this call. Do not work around this deny"
    "date *": allow
    "pwd": allow
    "grep *": allow
    "head *": allow
    "tail *": allow
    "wc *": allow
    "diff *": allow
    "nl *": allow
    "rg *": allow
    "ls *": allow
    "jq *": allow
    "true": allow
    "base64 *": allow
    "column *": allow
    "echo *": allow
    "python3 *": deny
    "python3 -m json.tool *": allow
    "sort *": allow
    "which *": allow
    "command -v *": allow
    "rmdir *": deny
    "git diff --check": allow
    "git rev-parse *": allow
    "git rev-list *": allow
    "git grep *": allow
    "git diff *": allow
    "git blame *": allow
    "git log *": allow
    "git merge-base *": allow
    "git show *": allow
    "git status *": allow
    "git branch -a *": allow
    "git branch -a --contains *": allow
    "git branch --all --list *": allow
    "git branch --contains *": allow
    "git branch --show-current *": allow
    "git branch -v": allow
    "git branch -vv": allow
    "git reflog *": allow
    "git worktree list": allow
    "git worktree list *": allow
    "git remote -v": allow
    "git ls-files *": allow
    "git ls-tree *": allow
    "git add *": deny
    "git commit *": deny
    "git rebase *": deny
    "git stash *": deny
    "gh run view *": allow
    "gh pr list *": allow
    "gh run list *": allow
    "gh pr view *": allow
    "gh pr diff *": allow
    "gh pr checks *": allow
    "gh pr status *": allow
    "gh api repos/*/comments *": allow
    "gh api repos/*/reviews *": allow
    "gh issue list *": allow
    "gh issue view *": allow
    "go env *": allow
    "go doc *": allow
    "go list *": allow
    "go test *": ask
    "gofmt *": ask
    "gofmt -w *": deny
    "go fmt *": deny
    "errcheck *": ask
    "staticcheck *": ask
    "go vet *": ask
    "go build *": ask
    "npm *": ask
    "npm view *": allow
    "pnpm exec tsc *": deny
    "pnpm lint": deny
    "pnpm run lint": deny
    "pnpm test *": deny
    "pnpm run test": deny
    "pnpm format": deny
    "pnpm run format": deny
    "pnpm tsc *": deny
    "pnpm typecheck *": deny
    "pnpm run typecheck *": deny
    "npm exec tsc *": ask
    "npx tsc *": ask
    "pnpm jest *": deny
    "pnpm run jest *": deny
    "pnpm exec jest *": deny
    "pnpm oxfmt-format-select": deny
    "tflint *": ask
    "terraform -chdir * fmt *": deny
    "kubectl config get-contexts *": allow
    "kubectl config current-context": allow
    "kubectl config view *": allow
    "kubectl get *": allow
    "kubectl describe *": allow
    "kubectl logs *": allow
    "kubectl top *": allow
    "kubectl explain *": allow
    "kubectl api-resources *": allow
    "kubectl version *": allow
    "kubectl apply *": ask
    "kubectl delete *": ask
    "kubectl patch *": ask
    "kubectl scale *": ask
    "kubectl rollout restart *": ask
    "kubectl rollout undo *": ask
    "kubectl exec *": ask
    "kubectl port-forward *": ask
    "kubectl cp *": ask
    "mkdir .scratch/*": allow
    "mkdir -p .scratch/*": allow
    "rmdir .scratch/*": allow
    "duckdb *": allow
    "mmdbctl *": allow
    "rm *": deny
    "mv *": deny
    "cp *": deny
    "chmod *": deny
    "chown *": deny
    "ln *": deny
    "touch *": deny
    "truncate *": deny
    "dd *": deny
    "tee *": deny
    "patch *": deny
    "git push *": deny
    "git pull *": deny
    "git fetch *": deny
    "git checkout *": deny
    "git switch *": deny
    "git restore *": deny
    "git reset *": deny
    "git merge *": deny
    "git cherry-pick *": deny
    "git revert *": deny
    "git tag *": deny
    "git branch -d *": deny
    "git branch -D *": deny
    "git branch -m *": deny
    "git branch -M *": deny
    "git stash": deny
    "git clean *": deny
    "git worktree add *": deny
    "git worktree remove *": deny
    "git worktree prune *": deny
    "git am *": deny
    "git apply *": deny
    "git clone *": deny
    "git init *": deny
    "git rm *": deny
    "git mv *": deny
    "git submodule *": deny
    "pnpm *": deny
    "yarn *": deny
    "bun *": deny
    "pip *": deny
    "pip3 *": deny
    "cargo *": deny
    "go install *": deny
    "go get *": deny
    "go mod *": deny
    "make *": deny
    "curl * -o *": deny
    "curl * -O *": deny
    "wget *": deny
    "python *": deny
    "node -e *": deny
    "ruby -e *": deny
  write: deny
  edit: deny
  path_read:
    "*": allow
    "*.env": deny
    ".envrc": deny
    "*.env.*": deny
    "*.env.example": allow
    "~/.ssh/*":
      action: deny
      reason: "SSH credentials are outside the agent's scope"
    "~/.aws/*":
      action: deny
      reason: "Cloud credentials are outside the agent's scope"
    "~/.config/gcloud/*":
      action: deny
      reason: "Cloud credentials are outside the agent's scope"
    "~/.kube/config":
      action: deny
      reason: "Kubernetes credentials are outside the agent's scope"
    "~/.pi/agent/auth.json":
      action: deny
      reason: "Pi authentication material must not be accessed"
    "~/.pi/agent/models.json":
      action: deny
      reason: "Pi model credentials must not be accessed"
    "~/.pi/agent/mcp-oauth/*":
      action: deny
      reason: "MCP authentication material must not be accessed"
    "~/.pi/agent/extensions/pi-permission-system/logs/*":
      action: deny
      reason: "Permission logs may contain sensitive request details"
  path_write:
    "*": deny
    "*.env": deny
    ".envrc": deny
    "*.env.*": deny
    "*.env.example": allow
    "~/.ssh/*":
      action: deny
      reason: "SSH credentials are outside the agent's scope"
    "~/.aws/*":
      action: deny
      reason: "Cloud credentials are outside the agent's scope"
    "~/.config/gcloud/*":
      action: deny
      reason: "Cloud credentials are outside the agent's scope"
    "~/.kube/config":
      action: deny
      reason: "Kubernetes credentials are outside the agent's scope"
    "~/.pi/agent/auth.json":
      action: deny
      reason: "Pi authentication material must not be accessed"
    "~/.pi/agent/models.json":
      action: deny
      reason: "Pi model credentials must not be accessed"
    "~/.pi/agent/mcp-oauth/*":
      action: deny
      reason: "MCP authentication material must not be accessed"
    "~/.pi/agent/extensions/pi-permission-system/logs/*":
      action: deny
      reason: "Permission logs may contain sensitive request details"
    ".scratch/*": allow
  read: allow
  grep: allow
  find: allow
  ls: allow
  mcp: ask
  subagent: allow
  get_subagent_result: allow
  steer_subagent: allow
  ask_parent: allow
  notify_parent: allow
  skill: ask
  plan_mode_question: ask
  plan_mode_complete: ask
  todo: ask
  todowrite: ask
  ask_user_question: ask
  web_search: ask
  fetch_content: ask
  get_search_content: ask
  source_check: ask
  bg_wait: ask
  bg_run: ask
  bg_kill: ask
  bg_status: ask
  bg_logs: ask
  codemode: ask
  scratchpad: ask
---
# Independent review

Review the requested diff, implementation, or plan. Prioritize findings that could cause incorrect observable behavior, regressions, security problems, operational risk, or insufficient test coverage.

Your first action in a Git repository must run `git rev-parse --show-toplevel` and `pwd`. Work only in that worktree. Never navigate to or operate in a different worktree.

## Boundaries

- Do not modify, delete, move, copy, or format source-managed files.
- Do not run dependency installation or commands that change Git state.
- Use `read`, `grep`, `find`, and `ls` instead of shell equivalents when possible.
- Bash is for the explicitly permitted inspection commands and disposable analysis under `.scratch/`.
- You may create task-specific data under `<git-root>/.scratch/<topic>/`. Do not write elsewhere.

## Review method

- Inspect the actual diff and the surrounding implementation.
- Trace affected call paths and externally visible behavior.
- Check tests for meaningful behavior rather than implementation details.
- Distinguish confirmed defects from questions and speculative risks.
- Do not manufacture findings to appear thorough.
- If no material issue is found, say so directly and name any residual validation gap.
- Review that added comments include information/considerations that are not immediately visible in the code itself.

## DuckDB

Use DuckDB for bounded analysis of CSV, JSON, Parquet, and similar data. Prefer in-memory databases or read-only connections. Prefer `SELECT`, `DESCRIBE`, and `EXPLAIN`. Avoid DDL, DML, writable attachments, and extension installation. Put intentional exports or intermediate data only under `.scratch/`. Never modify source-managed files through SQL.

## Output

List findings in descending severity. For each finding, provide the affected path and line range, the concrete failure mode, and why existing validation does not catch it. Keep summaries secondary to actionable findings.
