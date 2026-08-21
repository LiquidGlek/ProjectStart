# Master Project Checklist

This is the controlling inventory of project promises. It answers “is the project done?” Agent checklists answer only “is this lane ready for review?”

## Primary Outcome Lock

This is the first section every agent and coordinator checks. It cannot be replaced by proxy work.

- **Exact user request:** `<quote or faithful one-sentence restatement>`
- **Observable success:** `<what the user can do and observe>`
- **Exact acceptance journey:** `<starting state -> action -> authoritative success -> persistence/recovery>`
- **Primary master row:** `<one Critical ID>`
- **Candidate/environment required:** `<real app/build/device/account>`
- **Current candidate classification:** `<DEVELOPMENT / DIAGNOSTIC / INTEGRATION / RELEASE CANDIDATE / RELEASED>`
- **Candidate promotion justification:** `<master row, changed bytes, passed prerequisites, next decisive journey, or NOT YET ELIGIBLE>`
- **Current truth:** `<NOT ATTEMPTED / FAIL / PARTIAL / PASS at exact evidence level>`
- **Last direct attempt:** `<time, candidate, result, EV-###>`
- **Successive failed candidates for this journey:** `<count and identities>`
- **Two-candidate circuit breaker:** `<CLEAR / TRIGGERED; required plan/review evidence>`
- **Known exact blocker:** `<fact or UNKNOWN; never vague>`
- **Adjacent work allowed before success:** `<only work required for this outcome>`
- **Exact deadline:** `<ISO timestamp and timezone or NONE>`
- **Current slice deadline:** `<ISO timestamp and timezone>`
- **Timebox stage:** `<EARLY / MIDPOINT / SCOPE FREEZE / STABILIZE / OVERRUN>`

The primary outcome stays open until the exact journey passes at the promised evidence level. Supporting tests, refactors, dashboards, documentation, and adjacent feature fixes do not change its status.

## Claim-scoped health

Never use unqualified “healthy,” “stable,” “ready,” or “complete.” Report each observed scope separately. Overall product/release health equals the weakest required Critical row, not the average of component checks.

| Scope | State | Candidate/evidence | Exact claim allowed |
|---|---|---|---|
| Primary journey | `<NOT RUN/PARTIAL/FAIL/BLOCKED/PASS>` | `<identity/EV-###>` | `<scope-limited statement>` |
| `<component, safe-idle state, build, installed route, or release>` | `<state>` | `<identity/EV-###>` | `<what this proves and no more>` |

## Candidate promotion gate

Before another version, package, install, or acceptance candidate, record: the master row requiring new bytes; exact relevant changes; passed prerequisites; the decisive journey it will exercise; why an isolated check is insufficient; its candidate classification; current failed-candidate count; circuit-breaker state; and the result that stops further packaging. `DIAGNOSTIC` is not `RELEASE CANDIDATE`; a version label is not evidence.

## Counting rules

- `[ ]` open; `[~]` active/partial; `[R]` ready for coordinator review; `[x]` independently verified; `[!]` blocked; `[D]` user-approved deferral.
- Required total = `[ ] + [~] + [R] + [x] + [!]`.
- Verified completion = `[x] / required total × 100`.
- `[D]` is excluded only with an explicit decision ID.
- `IDEA-###` backlog rows are not requirement gates and never enter the required total or completion percentage unless the user/Director explicitly promotes one into a new stable master row and records the decision.
- Split independently provable outcomes into separate rows.
- Report critical failures separately from the percentage.

## Project health

- **Snapshot time:** `<ISO timestamp and timezone>`
- **Required:** `<number>`
- **Verified `[x]`:** `<number>`
- **Ready for review `[R]`:** `<number>`
- **Active/partial `[~]`:** `<number>`
- **Blocked `[!]`:** `<number>`
- **Open `[ ]`:** `<number>`
- **Verified complete:** `<x / required × 100>%`
- **Remaining:** `<100 - verified>%`
- **Critical/high failures:** `<count and IDs>`
- **Current release recommendation:** `<NO / CONDITIONAL / YES and why>`
- **Primary outcome movement since last snapshot:** `<observable change, decisive blocker evidence, or NONE>`
- **Deadline health:** `<ON TRACK / AT RISK / MISSED; remaining time and reason>`

## Requirements register

Do not use these sample rows as real requirements. Replace them during project activation.

## Active critical path — 3 to 10 rows only

The exhaustive register remains authoritative, but active tasks work from this small window. Replace rows only when verified, decisively blocked, or reprioritized by the Director; do not add side quests.

| Order | Master ID | Observable next outcome | Owner task | Deadline | Current truth | Next action |
|---|---|---|---|---|---|---|
| 1 | REQ-001 | `<exact outcome-critical movement>` | `<task ID>` | `<time>` | `<state/evidence>` | `<one action>` |

| State | ID | User-visible promise / required outcome | Priority | Owner lane | Required evidence | Evidence / decision | Notes |
|---|---|---|---|---|---|---|---|
| [ ] | REQ-001 | `<one observable outcome>` | Critical | `<lane>` | `<class and exact proof>` | `<EV-###>` | `<risk/dependency>` |
| [ ] | REQ-002 | `<one observable outcome>` | High | `<lane>` | `<class and exact proof>` | `<EV-###>` | `<risk/dependency>` |

## Required cross-cutting gates

Keep only applicable gates, but explicitly mark non-applicable gates with a reason and coordinator review. Do not silently delete them.

| State | ID | Gate | Owner lane | Required evidence | Evidence / decision |
|---|---|---|---|---|---|
| [ ] | GATE-001 | Authoritative root, branch, dirty state, and protected changes verified | Coordination | Inspection | `<EV-###>` |
| [ ] | GATE-002 | Complete primary user journey works through the real interface | Product | Runtime/installed | `<EV-###>` |
| [ ] | GATE-003 | Failure, partial, offline, retry, and recovery states are truthful and safe | Reliability | Test/runtime | `<EV-###>` |
| [ ] | GATE-004 | Accessibility requirements are verified at the promised level | Accessibility | Tool/human | `<EV-###>` |
| [ ] | GATE-005 | Security and privacy boundaries are reviewed and verified | Security | Review/test | `<EV-###>` |
| [ ] | GATE-006 | Performance and resource growth remain within defined bounds | Performance | Measurement | `<EV-###>` |
| [ ] | GATE-007 | Installed/device/account/public behavior is verified where promised | Release | Matching external | `<EV-###>` |
| [ ] | GATE-008 | Human user acceptance is recorded for the exact candidate identity | Acceptance | Human | `<EV-###>` |
| [ ] | GATE-009 | Unrelated user work is preserved and owned diff is reviewed | Coordination | Diff/inspection | `<EV-###>` |
| [ ] | GATE-010 | Final artifact identity, rollback/recovery, and handoff are verified | Release | Artifact/runtime | `<EV-###>` |
| [ ] | GATE-011 | Every controlling mockup is decomposed into a measured layout/state contract | Visual | Reference/specification | `<EV-### or N/A decision>` |
| [ ] | GATE-012 | A real-control skeleton matches hierarchy and composition at the exact viewport before feature work | Visual | Rendered comparison + approval | `<EV-### or N/A decision>` |
| [ ] | GATE-013 | Finished feature states preserve the approved skeleton and receive exact-candidate visual acceptance | Visual | Rendered/human | `<EV-### or N/A decision>` |
| [ ] | GATE-014 | Prior art and reusable components were researched before architecture, with license and validation boundaries recorded | Product/Architecture | Primary-source research + decision brief | `<EV-###>` |
| [ ] | GATE-015 | An accepted project plan defines the smallest architecture, ordered vertical slices, task boundaries, and verification before detailed task checklists | Product/Architecture | Plan review + decision log | `<EV-###>` |
| [ ] | GATE-016 | Baseline product-category capabilities are classified and all required table-stakes workflows map to master rows | Product | Competitive capability matrix + plan review | `<EV-###>` |
| [ ] | GATE-017 | User intent is synthesized from explicit instructions, mockup implications, category expectations, and labeled inferences before research and planning | Product | Intent synthesis + plan traceability | `<EV-###>` |
| [ ] | GATE-018 | Audience, occasion, emotional promise, distribution context, personalization, and polish are translated into observable product and release criteria | Product/Release | Intent-to-acceptance traceability | `<EV-### or N/A decision>` |
| [ ] | GATE-019 | Competitive research has an explicit table-stakes, selected-parity, or full-parity commitment and no requested capability is silently dropped | Product | Research-to-master traceability | `<EV-###>` |
| [ ] | GATE-020 | Adversarial self-audits repair bureaucracy, human dependency, contradictions, scope distortion, and the strongest remaining slop path before plan acceptance and completion | Direction/QA | Audit findings + implemented repairs + recheck | `<EV-###>` |
| [ ] | GATE-021 | Every user correction is durably recorded, broadcast, acknowledged, regression-proven, and checked for recurrence | Direction/QA | CORR ledger + task receipts + regression evidence | `<EV-### or N/A decision>` |
| [ ] | GATE-022 | Every outcome-critical persistent/shared/external journey has a complete state-transition, authority, mutation, read-back, commit, recovery, idempotency, and external-effect contract before implementation | Architecture/Reliability | Accepted transaction contract + adversarial review | `<EV-### or N/A decision>` |
| [ ] | GATE-023 | Candidate promotion, claim-scoped health, and the two-candidate circuit breaker prevent patch spirals and unsupported release language | Direction/Release | Candidate ledger + journey evidence + circuit-breaker audit | `<EV-###>` |
| [ ] | GATE-024 | Every durable project role/domain is a separately registered top-level Codex task created through `create_thread`; no subagent owns a lane, master row, production/runtime work, checklist, deadline, or acceptance gate | Direction/Coordination | Task creation receipts + exact IDs/deeplinks + registry/checklist audit | `<EV-###>` |
| [ ] | GATE-025 | Every user turn, context compaction, restart, and handoff rehydrates the active outcome, priority, corrections, authority, lanes, and next action from the compact project state and controlling records | Direction/Coordination | Current `PROJECT_STATE.md` receipt + source/task reconciliation audit | `<EV-###>` |
| [ ] | GATE-026 | Every simultaneously ready independent lane is launched or resumed before the Director waits; waits monitor all active lanes together and replenish the ready set | Direction/Coordination | Launch-wave receipts + multi-target wait/replenishment audit | `<EV-###>` |
| [ ] | GATE-027 | Every top-level task proves its actual ID/deeplink, model/effort, project/root/worktree, checklist, and startup state before substantive project work | Direction/Coordination | Returned creation receipt + task self-read-back + Director comparison | `<EV-###>` |
| [ ] | GATE-028 | Stable durable lanes reuse valid existing tasks; every replacement is justified; terminal, duplicate, superseded, stopped, and misconfigured tasks are safely archived after state/process reconciliation, or truthfully proven `UNARCHIVABLE` when the host lost their backing records | Direction/Coordination | Registry history + handoff/process checks + archive receipts or failed-attempt/no-unintegrated-state evidence | `<EV-###>` |
| [ ] | GATE-029 | Exploratory user brainstorming and agent ideas are durably linked in the master backlog and affected task checklists without interrupting current work or inflating completion | Product/Direction | `IDEA-###` register + checklist links + promotion decision audit | `<EV-### or N/A decision>` |
| [ ] | GATE-030 | Director status leads with whole-product capability, missing major outcomes, weakest Critical row, active lanes, and next action before component or QA detail | Direction | Checkpoint reports compared with master/product truth | `<EV-###>` |
| [ ] | GATE-031 | The selected team mode is actually staffed and integrated: FULL TEAM launches 10–15 concurrent non-Director workers with an implementation majority, uses contract-first parallelization, then freezes and regroups every coherent handoff into one exact candidate before QA | Direction/Integration | Staffed-wave plan + create/reuse/start receipts + handoff barrier + integration batch/candidate + QA dispatch | `<EV-### or N/A for non-FULL mode with staffing proof>` |
| [ ] | GATE-032 | On project-start invocation, the Director obtains the user's exact 1–15 non-Director worker count and worker model/effort policy before initialization, then the first wave and verified actual startup models match those answers exactly | Direction/Coordination | Timestamped intake receipt + charter/state/plan/board agreement + exact lane assignments + actual startup read-backs | `<EV-###>` |

## Brainstorm and future backlog

This register captures ideas without silently changing the current mission.

- An explicit instruction such as “do this now,” “add this,” or a correction is current work: update the Primary Outcome Lock/requirements/priority as appropriate and record the decision or correction. User steering is not agent scope drift or a milestone-lock violation.
- Exploratory language such as “could we,” “maybe,” “what if,” or “should we” becomes an `IDEA-###` row with state `BACKLOG` unless the user explicitly promotes it.
- Agent-generated enhancements also start as `BACKLOG` unless they are already-required table stakes, safety obligations, or accepted-plan work.
- Record the exact wording/source here and link the same ID from every affected task checklist before the discussion ends.
- `BACKLOG` authorizes capture and bounded clarification only—not research, task creation, implementation, testing, or interruption of the active slice.
- Promotion requires an explicit `DEC-###` (or current user instruction), a stable master row, owner, priority, exit proof, and active-critical-path decision. `REJECTED` and `DUPLICATE` rows remain as history.

- **Open brainstorm items:** `<number>`
- **Newest brainstorm ID:** `<IDEA-### IDs or NONE>`

| State | Idea ID | Exact wording/source | Affected domain | Linked task checklist(s) | Why not now / promotion decision | Promoted master/decision |
|---|---|---|---|---|---|---|
| BACKLOG | IDEA-001 | `<exact brainstorm wording and speaker/time>` | `<domain>` | `<paths>` | `<why parked>` | NONE |

## Critical defects and blockers

| Severity | ID | Affected master rows | Owner | Status | Impact | Next safe action |
|---|---|---|---|---|---|---|
| `<Critical/High>` | `<BUG-###>` | `<IDs>` | `<lane>` | `<OPEN/BLOCKED>` | `<plain language>` | `<action>` |

## Milestones

| State | Milestone | Included master IDs | Exit proof | Approver |
|---|---|---|---|---|
| [ ] | `<name>` | `<IDs>` | `<exact evidence>` | `<role>` |

## Completion audit

- [ ] Re-read the original request and later decisions.
- [ ] Every promise maps to a stable master ID.
- [ ] Every active agent checklist maps back to master IDs.
- [ ] Every brainstormed idea is linked in the backlog and affected checklists; no unpromoted idea entered active work or completion math.
- [ ] Compact resume state was rehydrated after the latest user turn/compaction/restart and matches exact task read-backs.
- [ ] Every ready independent lane was launched/resumed before waiting; no valid stable lane was needlessly duplicated.
- [ ] Terminal/duplicate/superseded/misconfigured tasks are safely archived with receipts, or carry verified `UNARCHIVABLE` evidence; no reusable blocked/waiting task was archived as “unused.”
- [ ] Every `[x]` row cites current, matching evidence.
- [ ] Every critical/high defect is resolved or explicitly rejected by the user.
- [ ] Installed, physical, external, accessibility, security/privacy, and user-acceptance promises have matching proof or remain open.
- [ ] Unrelated work and protected regions are preserved.
- [ ] Final candidate/artifact identity is exact and reproducible.
- [ ] Final handoff lists all `NOT RUN`, blocked, deferred, and known limitations.
- [ ] Where mockups controlled the result, skeleton approval preceded feature work and final visual acceptance is separate.
