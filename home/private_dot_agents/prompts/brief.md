---
description: Convert the preceding work into a standalone executive summary
argument-hint: "[format or audience]"
---
Rewrite the preceding work as a standalone executive summary for ${@:-the user}.

The summary is not a preview of the work or a shrunken report—for the decision-maker, it is the entire document. A reader who reads only this summary must be able to grasp the conclusion and make the decision without consulting the transcript or implementation details.

## Principles

- **Lead with the conclusion or recommendation (BLUF):**
  - For an investigation, open with the finding and its operational implication ("so what?"), never the search process or methodology.
  - For a plan or proposal, open with the recommended approach and why it wins over the alternative, never a file-by-file walkthrough.
- **Keep only what moves the decision:** State the 1–3 load-bearing facts, constraints, costs, or risks (the catch) in the reader's terms.
- **Pair open decisions with a recommended default:** Only ask questions that materially change the outcome, and state the default so the reader can approve with a single "yes".
- **Demote the apparatus:** Cut file inventories, function names, type/schema boilerplate, test lists, tool logs, and methodology. Mention in one line at the end what supporting detail is available on request.
- **Use only verified facts** already established in the conversation. Do not run tools to gather new evidence, and never invent claims, numbers, or next steps.

## Output Format

Output ONLY the applicable sections below (omit any section that does not apply):

- **`## Bottom Line`** — 1–3 sentences or bullets stating the recommendation or core finding and why it matters.
- **`## Key Constraints & Risks`** — 1–3 bullets covering only non-obvious constraints, trade-offs, or risks that affect the decision.
- **`## Decisions Needed`** — Only choices that block or materially alter the work, each with an explicit `(recommended — reason)` default. Omit this section if no decision is needed.

### Example (Investigation)

```markdown
## Bottom Line
- `admin` and `vercel-site` use separate ClickHouse reader identities to isolate backoffice support queries from customer-facing traffic.
- `admin` is restricted to two tables with a 1 GiB memory cap; `vercel-site` has full database read access with a 4 GiB cap.

## Key Constraints & Risks
- Both identities share the same underlying read service and cluster compute pool, so cap changes on `vercel-site` still affect shared headroom.

_Full SQL grants and Terraform definitions available on request._
```

### Example (Plan / Proposal)

```markdown
## Bottom Line
- Store `.security.system.categories` on the versioned `FirewallConfig` document and project it into `project.security.system.categories` on activation, reusing the existing Cosmos → Proxy Metadata replication path.
- Avoid a separate endpoint: `PUT` and `PATCH /v1/security/firewall/config` already handle validation, audit history, draft promotion, and proxy projection for per-project security settings.

## Key Constraints & Risks
- `vercel/proxy`'s `metadata-replicator` (`Project.cs`) and `vercel/api`'s `transformProject` both overwrite the full `PROXY_METADATA_TABLE` `Data` blob; `Project.cs` must include `security.system.categories` or change-feed writes will strip it.

## Decisions Needed
1. **When `firewallEnabled` is `false`**: keep `system.categories` active (recommended — system mitigations run independently of customer WAF rules) or clear it?
2. **Entitlements**: allow on all plans (recommended — matches existing baseline system mitigations) or gate behind Enterprise?

_File-by-file changes and schema definitions available on request._
```

