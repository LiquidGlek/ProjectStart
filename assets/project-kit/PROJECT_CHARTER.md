# Project Charter

Fill this once at project start. Change it only through an explicit user decision recorded in `DECISION_LOG.md`.

## Identity

- **Project:** `<name>`
- **Plain-language outcome:** `<what must be true for the user>`
- **Authoritative root:** `<absolute path>`
- **Repository/branch/HEAD:** `<repo, branch, commit or NOT A REPOSITORY>`
- **Controlling instructions:** `<paths>`
- **Human owner/approver:** `<name or role>`
- **Coordinator:** `<agent/task/deeplink>`
- **Communication registry:** `AGENT_COMMUNICATION.md`
- **Shared runtime/candidate registry:** `RUNTIME_OWNERSHIP.md`
- **Shared seam/integration registry:** `INTEGRATION_CONTRACTS.md`
- **Resource/process registry:** `RESOURCE_BUDGET.md`
- **Team mode:** `<SOLO / SMALL TEAM / FULL TEAM>`
- **Requested simultaneous workers:** `<exact integer 1-15; excludes Director>`
- **Worker model/effort policy:** `<exact user answer: one default, role mapping, or AUTO / HOST DEFAULT>`
- **Staffing intake receipt:** `<ISO timestamp; exact worker-count and model-policy answer plus source message/turn>`
- **Team staffing contract:** `<SOLO: exactly 1 / SMALL TEAM: exact requested 2-9 / FULL TEAM: exact requested 10-15 with IMPLEMENTATION strict majority>`
- **Autonomy boundary:** `<safe local decisions the Director may make without user input>`
- **Escalation boundary:** `<product choices, authority, destructive/external actions, acceptance>`
- **Target release or milestone:** `<identity>`
- **Controlling visual references:** `<paths/links or NONE>`
- **Controlling viewport and state:** `<dimensions, scale, populated state or NONE>`
- **Skeleton approver:** `<name/role or NOT APPLICABLE>`
- **Start time:** `<ISO timestamp and timezone>`
- **Exact deadline:** `<ISO timestamp and timezone or NONE>`
- **Current first-slice deadline:** `<ISO timestamp and timezone>`
- **Deadline owner:** `<user/role>`
- **Overrun rule:** `<report project-deadline truth honestly; Director may replan slices but only the user may reduce the promised outcome>`
- **Model/usage budget:** `<the user's answered worker model/effort policy controls; AUTO may use documented proportionate routing>`
- **Sol Max allocation owner:** `<Project Director>`
- **Sol Max lane and reason:** `<task/IDs/complexity reason or NONE>`
- **Project Director production write scope:** `NONE unless an explicit emergency role transfer is recorded`
- **Visible UI authority:** `<background-only by default; exact exceptions>`
- **Large download/deletion/service authority:** `<explicit boundary>`

## User intent synthesis

Complete this before prior-art research. The Director owns the synthesis; research and implementation must serve it rather than silently redefining it.

- **User's explicit request:** `<faithful statement>`
- **Intended recipient/audience:** `<who will actually use or receive it>`
- **Occasion/relationship context:** `<gift, professional, personal, public, internal, or other relevant context>`
- **Underlying job/problem:** `<what the user is actually trying to accomplish or avoid>`
- **Desired return state:** `<what the user expects to find when returning without babysitting>`
- **Emotional promise:** `<how the finished product should make the recipient/user feel>`
- **Personalization evidence:** `<specific details that make it feel intentionally made for this recipient, or NOT APPLICABLE>`
- **Distribution context:** `<private/internal/public; expected install and update path>`
- **Derived release implications:** `<signing, packaging, warnings, privacy, support; label each fact or inference>`
- **Polish translation:** `<observable visual, copy, onboarding, reliability, packaging, and first-launch criteria>`
- **Mockup-implied priorities:** `<hierarchy, workflow, density, tone, persistence, trust signals>`
- **Category-implied expectations:** `<ordinary capabilities to verify during research>`
- **Agent inferences with confidence:** `<inference; HIGH/MEDIUM/LOW; supporting evidence>`
- **Anti-intent:** `<technically possible outcomes that would violate the spirit of the request>`
- **Material ambiguity:** `<NONE or two competing interpretations and why they change the product>`
- **Resolution:** `<proceeding interpretation or exact focused user decision>`

Do not treat pixels as the whole intent. A mockup expresses information hierarchy, workflow, emphasis, trust, and product character as well as dimensions. Translate emotional language such as care, delight, professionalism, calm, or celebration into observable product criteria rather than decorative clichés. Do not let competing products override the user's intended advantage. Ask the user only when unresolved interpretations would produce materially different products; otherwise record the evidence-backed interpretation and continue.

## Success contract

The project succeeds when:

1. `<observable user outcome>`
2. `<observable quality/reliability outcome>`
3. `<required external or human acceptance>`

The project does **not** succeed merely because:

- code was written or compiled;
- tests or mocks passed;
- an agent reports confidence;
- most checklist rows are checked while a critical gate is open.

## Scope

### Included

- `<system, behavior, journey, artifact>`

### Excluded

- `<explicit non-goal>`

### Protected or shared regions

| Path/system | Owner | Rule |
|---|---|---|
| `<path>` | `<owner>` | `<read-only, shared, coordinator-only, etc.>` |

## Authority boundaries

| Action | Standing authority | Required approver/evidence |
|---|---|---|
| Local source edits | `<yes/no/scope>` | `<conditions>` |
| Tests/builds/renders | `<yes/no/scope>` | `<conditions>` |
| Install or device mutation | `<yes/no>` | `<approver>` |
| External messages/publication | `<yes/no>` | `<approver>` |
| Purchases/financial actions | `<yes/no>` | `<approver>` |
| Credentials/account changes | `<yes/no>` | `<approver>` |
| Destructive cleanup/deletion | `<yes/no>` | `<approver and recovery plan>` |

## Quality and evidence bar

- **Critical defects that block release:** `<list>`
- **Required evidence classes:** `<source, test, build, rendered, installed, physical, account, public, accessibility, security, human>`
- **Required environments/devices/accounts:** `<list or NOT AVAILABLE>`
- **Performance/security/privacy limits:** `<measurable limits>`
- **User acceptance owner and scenario:** `<person and journey>`
- **Required visual evidence:** `<measured reference, real-control skeleton, exact-viewport comparison, human approval, or NOT APPLICABLE>`

## Fixed project rules

- Master checklist IDs are stable and never reused.
- Difficult rows are not deleted to improve percentages.
- Deferral requires explicit user approval and a decision-log entry.
- New requirements, defects, risks, and external obligations are registered before implementation continues.
- Evidence must match the strength of the claim.
- The selected team mode is binding. FULL TEAM is not silently downgraded to one or two ready lanes; the plan creates 10–15 contract-isolated worker domains and an integration regroup barrier. Every worker still needs durable ownership—filler tasks are not progress.
- Implementers cannot independently approve their own behavior, visual, installed, external, security, or human-acceptance gates.

## Pre-mortem — prevent failure before implementation

Before substantive work, imagine the deadline passed and the locked outcome still failed. Record the most likely causes and install the guardrails now.

| ID | Likely failure or drift path | Earliest observable warning | Preventive guardrail | Owner | Triggered response |
|---|---|---|---|---|---|
| PM-001 | `<for example: tests grow while real journey remains unattempted>` | `<measurable signal>` | `<rule/check/ownership>` | `<role>` | `<immediate action>` |

- [ ] At least five task-specific failure/drift paths are recorded.
- [ ] Each path has an early warning that can be observed before the deadline.
- [ ] Each path has one owner and an immediate response.
- [ ] Acceptance, ownership collision, external dependency, evidence mismatch, and test-churn risks were considered.
- [ ] Pre-mortem guardrails are reflected in the master rows, agent checklists, or coordination board.
