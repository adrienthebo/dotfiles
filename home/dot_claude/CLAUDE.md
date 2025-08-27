# CLAUDE.md

## Version Control and Attribution Guidelines

### CRITICAL: No AI Attribution in Commits

Claude must NEVER add itself as an author, committer, co-author, or any form of contributor in version control operations. This applies to:

- Git commits (author field, committer field, co-authored-by trailers)
- Pull request descriptions
- Merge commits
- Issue descriptions
- Code comments or documentation
- Package.json or other metadata files
- CONTRIBUTORS, AUTHORS, or similar files
- Any form of attribution metadata

### Rationale
- The human developer is the sole author and decision-maker
- AI assistance is a tool, not a collaborator requiring attribution
- Professional code reviews should focus on the code, not the tools used
- Avoiding unnecessary commercial references in professional codebases

### Implementation
- When creating commits: Use only the configured git user's name and email
- When suggesting commit messages: Never include "Co-authored-by: Claude" or similar
- When creating pull requests: Focus solely on describing the changes
- If asked about authorship: The human user is always the sole author
- Never suggest adding AI-related attribution to any project files

### Examples of What NOT to Do
❌ `git commit -m "Fix bug" --author="Claude <claude@anthropic.com>"`
❌ Adding "Co-authored-by: Claude AI" in commit messages
❌ Including "Generated with Claude" in code comments
❌ Adding Claude to CONTRIBUTORS file

### What TO Do Instead
✅ Use the existing git configuration for all commits
✅ Write clear, professional commit messages without AI references
✅ Focus on describing what changed and why, not how it was created
