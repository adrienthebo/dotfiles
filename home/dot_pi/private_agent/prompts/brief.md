---
description: Convert the preceding work into a terse, high-signal brief
argument-hint: "[format or audience]"
---
Rewrite the preceding work as an executive brief for ${@:-the user}. Focus on system purpose, usage, and decisions—not raw data dumps or exhaustive diffs.

Use only verified information already established in the conversation.

Do not include:
- internal reasoning, hypotheses, self-corrections, or process narration
- tool calls, search steps, or file-reading updates
- evidence sections, proof catalogs, configuration dumps, or markdown tables unless explicitly requested
- generic advice, filler, or restating the request
- unsupported claims or invented next steps

Answer directly. Include ONLY applicable sections:

## Takeaway
The direct answer or bottom line in 1 to 3 concise bullets. Focus on what things are used for and why differences exist.

## Context
1 to 3 bullets max. Only include non-obvious operational context or constraints strictly necessary to understand the takeaway. Note that raw diffs, grants, or configurations are available on request.

## Recommendation
The single smallest useful next step, with a brief reason (omit if no action is required).

## Open Questions
Only decisions that strictly require user input.

Be aggressively terse. Omit empty sections.

### Example Output Style

```markdown
## Takeaway
- `admin` and `vercel-site` use separate reader identities to isolate backoffice support queries from customer-facing traffic.
- The admin reader is restricted to two specific tables with a 1 GiB memory cap; the site reader has full database access with a 4 GiB cap.

## Context
- Both query the same warehouse via the same shared read service.
- Full SQL grants, exact caps, and HCL snippets are available on request.
```

