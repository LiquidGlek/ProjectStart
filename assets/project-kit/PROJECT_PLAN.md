# Project Plan

Create this plan after inspecting the user's instructions, references, real project state, and `PRIOR_ART_RESEARCH.md`. Derive the detailed master checklist and top-level task lanes from this plan—not from guesses made at project startup.

## Planning basis

- **Locked user outcome:** `<one observable result>`
- **Controlling intent synthesis:** `<charter section and decisive interpretation>`
- **Acceptance journey:** `<starting state -> user action -> authoritative result -> persistence/recovery>`
- **Instructions and mockups inspected:** `<paths/links/versions>`
- **Existing project/code inspected:** `<root, relevant architecture, constraints>`
- **Prior-art decision:** `<summary and link to exact research rows>`
- **Deadline/timebox:** `<timestamp and timezone>`

## Product definition

- **Target user and problem:** `<who; what recurring problem>`
- **Recipient/occasion and emotional promise:** `<context and intended feeling>`
- **Private/internal/public delivery:** `<distribution and resulting packaging/signing/support implications>`
- **Smallest useful product:** `<first complete vertical slice>`
- **Required user-visible states:** `<normal, empty, loading, error, recovery, persistence>`
- **Controlling visual structure:** `<mockup contract or NONE>`
- **Deliberate advantages over existing products:** `<specific improvements>`
- **Personalization and polish acceptance:** `<observable evidence this was deliberately made for its recipient and context>`
- **Baseline/table-stakes coverage:** `<research rows included now>`
- **Intentional baseline exclusions:** `<rows and concrete reasons, or NONE>`
- **Parity commitment:** `<TABLE STAKES / SELECTED PARITY with groups / FULL PARITY and inventory identity>`
- **Explicitly out of scope:** `<tempting adjacent work>`

## Technical plan

- **Chosen architecture:** `<smallest architecture that delivers the outcome>`
- **Why this choice:** `<evidence and tradeoff>`
- **Reused/adapted components:** `<research row and license boundary>`
- **Core data model/contracts:** `<entities, calculations, interfaces>`
- **Persistence/recovery:** `<what survives restart; failure behavior>`
- **Security/privacy/accessibility constraints:** `<applicable requirements>`
- **Rejected alternatives:** `<option and decisive reason>`

## Critical journey transaction contract

Complete this section before implementing any outcome-critical journey that mutates persistent/shared state or causes an external effect. Use `NOT APPLICABLE` with a concrete reason only when the journey is genuinely stateless and local.

- **Mutation/persistence/external-effect classification:** `<LOCAL / SHARED SEAM / PERSISTENT MIGRATION / EXTERNAL-EFFECT TRANSACTION / CROSS-CUTTING INVARIANT, with reason>`
- **Authoritative starting state:** `<source of truth and required preconditions>`
- **Ordered transitions and owners:** `<state -> owner/action -> next state>`
- **Permitted owned mutations:** `<exact declared delta>`
- **Forbidden mutations:** `<state/systems that must remain untouched>`
- **Read-back authority:** `<what independently confirms each mutation and final state>`
- **Commit point:** `<when the new state becomes authoritative>`
- **Failure/recovery/idempotency:** `<before/during/after failure, restart, and repeat-action behavior>`
- **External-effect ordering:** `<what must converge locally before public/account/device effects, or NOT APPLICABLE with reason>`
- **Sibling-impact map:** `<direct readers, writers, validators, recovery paths, and downstream consumers>`
- **Missing invariant that would create a patch spiral:** `<one invariant or NONE with evidence>`

| Transition | Starting authority | Owner and permitted mutation | Required read-back | Failure/recovery result |
|---|---|---|---|---|
| `<state transition>` | `<source>` | `<owner/delta>` | `<authority>` | `<result>` |

## Ordered vertical slices

Each slice must end in an observable, testable product state. Do not list internal layers as separate slices unless they independently unlock user value.

| Order | Slice | Observable result | Depends on | Required proof | Estimated time |
|---|---|---|---|---|---|
| 1 | `<thin end-to-end slice>` | `<what works>` | `<dependency or NONE>` | `<evidence class>` | `<time>` |

## Top-level task design

Create separate top-level Codex tasks for every durable, independently ownable domain. Each planned lane must use `create_thread`; `spawn_agent` is prohibited. The Project Director coordinates and reviews; it normally owns no production code.

| Proposed top-level task/lane | Durable-task reason | Creation mechanism | Owns | Excludes | Shared seam | Model/effort reason | Exit handoff |
|---|---|---|---|---|---|---|---|
| `<lane>` | `<master ID/production ownership/checklist/gate/handoff>` | `create_thread` | `<files/system/outcome>` | `<other ownership>` | `<contract or NONE>` | `<tier and reason>` | `<artifact/evidence>` |

## Verification plan

| Promise | Earliest useful check | Exact exit proof | Independent reviewer |
|---|---|---|---|
| `<observable promise>` | `<focused check>` | `<runtime/installed/visual/etc.>` | `<task/role>` |

## Checklist derivation gate

- [ ] Original request and later corrections are represented without weakening them.
- [ ] Explicit, mockup-implied, category-implied, and inferred intent are separated and traceable to evidence.
- [ ] The plan delivers the user's underlying job and desired return state, not only literal controls or pixels.
- [ ] Audience, occasion, emotional promise, distribution context, and polish are translated into observable acceptance criteria.
- [ ] Signing, packaging, privacy, and support decisions are evidence-backed and labeled as facts or inferences.
- [ ] No competitor convention has displaced the user's intended product advantage.
- [ ] Competitive feature parity is separated from copying protected implementation, assets, branding, or expression.
- [ ] Every reused open-source component has an exact license/distribution decision.
- [ ] Research decisions changed or confirmed the plan explicitly.
- [ ] Every baseline capability is required now, intentionally excluded for a concrete reason, or genuinely not applicable.
- [ ] No ordinary end-to-end control is missing merely because the user did not spell it out.
- [ ] The first slice is a complete user journey, not a collection of technical layers.
- [ ] Every critical persistent/shared/external journey has a complete transaction contract before implementation.
- [ ] Cross-cutting changes map direct readers, writers, validators, recovery paths, and downstream consumers.
- [ ] Mockup work begins with the real-control skeleton when applicable.
- [ ] Architecture contains no speculative framework or unowned shared seam.
- [ ] Proposed top-level tasks have non-overlapping durable ownership.
- [ ] Every planned project lane uses `create_thread`; none uses `spawn_agent`, a nested agent, or an unregistered delegate.
- [ ] Every planned promise now maps to a stable master checklist ID.
- [ ] The active critical path contains only the next 3–10 outcome-critical rows.
- [ ] Director records the plan decision in `DECISION_LOG.md` before creating implementation tasks.

**Plan state:** `<DRAFT / READY FOR DIRECTOR REVIEW / ACCEPTED / CHANGES REQUESTED>`
**Decision ID:** `<DEC-### or PENDING>`

## Adversarial self-audit

Run this after the first complete draft and again against actual execution before claiming completion. Assume the process may be wrong.

| Challenge | Finding/evidence | Required repair | Rechecked result |
|---|---|---|---|
| Is document or checklist work delaying the first useful product slice? | `<finding>` | `<simplification>` | `<result>` |
| Does any rule require the user for a decision the Director or independent reviewer can safely own? | `<finding>` | `<autonomous route>` | `<result>` |
| Are team size, task boundaries, and model tiers proportionate? | `<finding>` | `<merge/split/reroute>` | `<result>` |
| Did research inflate vague scope or shrink explicit parity? | `<finding>` | `<scope correction>` | `<result>` |
| Are intent, distribution, emotional, release, and technical assumptions labeled? | `<finding>` | `<evidence or correction>` | `<result>` |
| Can every active gate be proven at its promised evidence level? | `<finding>` | `<proof plan or honest blocker>` | `<result>` |
| Do any controls contradict each other or the user's desired autonomy? | `<finding>` | `<controlling correction>` | `<result>` |
| Could local fixes change an authority, fingerprint, migration, recovery path, or external-effect ordering that another component validates? | `<finding>` | `<transaction-contract repair>` | `<result>` |
| Could successive candidate failures be mislabeled as unrelated bugs instead of one broken journey? | `<finding>` | `<candidate-churn guardrail>` | `<result>` |
| What is the strongest remaining path to a polished-looking but incomplete product? | `<finding>` | `<guardrail/direct journey>` | `<result>` |

- [ ] Every valid finding changed the plan, controls, ownership, or evidence route.
- [ ] No critique was accepted as documentation-only theater.
- [ ] The repaired plan still preserves the user's exact outcome and intent.
- [ ] Final execution audit confirms the repairs worked or records the exact remaining blocker.
