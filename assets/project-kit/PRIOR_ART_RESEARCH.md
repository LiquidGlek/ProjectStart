# Prior Art and Reuse Brief

Research existing work after reading the user's instructions and references, but before choosing architecture or writing production code. The purpose is to avoid rebuilding solved parts—not to delay delivery with an open-ended survey.

## Research lock

- **Locked user outcome:** `<master ID and one sentence>`
- **Controlling intent/anti-intent:** `<charter synthesis summary>`
- **Questions that affect implementation:** `<2–5 exact questions>`
- **Search timebox:** `<normally 10–15% of the first delivery timebox>`
- **Stop condition:** `3–7 credible candidates inspected, reusable options decided, and remaining uncertainty no longer changes the first vertical slice.`
- **Research owner/task:** `<task ID/deeplink>`
- **Parity interpretation:** `<TABLE STAKES / SELECTED PARITY / FULL PARITY; exact user evidence>`

## Candidate register

Prefer primary sources: official documentation, source repositories, specifications, papers, and the actual competing product. Record the license before copying code, data, formulas, or assets.

| Candidate/source | What it already solves | Relevant implementation/data | License and reuse boundary | Freshness/credibility | Decision |
|---|---|---|---|---|---|
| `<direct link>` | `<capability>` | `<file/API/formula/pattern>` | `<license; COPY/ADAPT/LEARN ONLY>` | `<evidence>` | `<REUSE/ADAPT/LEARN/REJECT>` |

## Baseline capability matrix

Inspect the actual competing product and at least two credible products or official guides from the same category. Capture ordinary user workflows, not just reusable code. The Director owns the question: “What would a reasonable user be shocked to find missing?”

| Baseline workflow/capability | Supporting products/sources | Why users expect it | Project decision | Reason | Master ID |
|---|---|---|---|---|---|
| `<ordinary category workflow>` | `<direct primary links>` | `<category expectation>` | `<REQUIRED NOW / INTENTIONALLY EXCLUDED / NOT APPLICABLE>` | `<concrete reason>` | `<ID or pending>` |

`INTENTIONALLY EXCLUDED` is a real product decision, not a parking place for inconvenient work. The Director may resolve obvious table stakes autonomously as required. Escalate only when including the capability would materially change the promised product, authority, cost, or deadline.

Do not silently translate “research this category” into full competitor parity, and do not silently shrink an explicit parity request into a convenient subset. `TABLE STAKES` captures ordinary expected workflows; `SELECTED PARITY` names exact capability groups; `FULL PARITY` inventories every discovered user-facing capability and keeps each one in the master backlog until delivered or explicitly changed by the user.

Competitive capability research establishes what users expect; it does not authorize copying proprietary code, assets, branding, wording, or protected expression. For open-source candidates, inspect the exact license and distribution obligations before choosing reuse, linking, bundling, modification, or independent reimplementation.

## Reuse decision

| Needed capability | Decision | Exact source/component | Why | Validation required |
|---|---|---|---|---|
| `<capability>` | `<REUSE/ADAPT/BUILD>` | `<source or NONE>` | `<tradeoff>` | `<proof before relying on it>` |

## Architecture consequences

- **What we will reuse directly:** `<licensed component/data or NONE>`
- **What we will adapt:** `<pattern/formula/data and attribution obligation>`
- **What we learned but will implement independently:** `<idea and reason>`
- **What must be new:** `<project-specific advantage>`
- **Rejected attractive detours:** `<candidate and decisive reason>`
- **First vertical slice changed by research:** `<specific change>`

## Anti-drift rules

- Search only questions that can change a current master row, architecture boundary, reuse decision, or acceptance method.
- Do not clone or import a candidate before checking its license, maintenance state, security surface, and fit.
- Do not equate a popular project with correct formulas or current game data; verify the exact part we rely on.
- Do not treat the user's mockup or literal feature list as exhaustive. Use the baseline matrix to catch obvious category workflows without inventing unrelated scope.
- Stop when the recorded stop condition is met. Add later research only for a newly discovered decisive question.
- Research completion is a decision artifact, not a completion claim for the product.
- Research may improve the route but may not replace the user's intent with competitor conventions.
