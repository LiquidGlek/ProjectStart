# Agent Checklist — `<lane name>`

Copy this file once for every top-level Codex task or durable work lane. A durable lane must be created through `create_thread`, never `spawn_agent`. The task owns this checklist; the coordinator owns corresponding master-row status.

## Identity and assignment

- **Agent/task/deeplink:** `<identity>`
- **Task type:** `<TOP-LEVEL CODEX TASK / CURRENT DIRECTOR TASK>`
- **Creation mechanism/receipt:** `<create_thread plus returned receipt / current Director task>`
- **Subagent status:** `<NOT A SUBAGENT>`
- **Lane outcome:** `<plain-language result>`
- **Primary outcome lock:** `<exact master outcome this lane must advance>`
- **Exact acceptance journey:** `<real starting state -> user action -> authoritative result>`
- **Critical journey transaction contract:** `<PROJECT_PLAN.md section/transition IDs or NOT APPLICABLE with reason>`
- **Change impact classification:** `<LOCAL/SHARED SEAM/PERSISTENT MIGRATION/EXTERNAL-EFFECT TRANSACTION/CROSS-CUTTING INVARIANT>`
- **Coordinator:** `<identity>`
- **Parent master checklist:** `../MASTER_CHECKLIST.md`
- **Assigned master IDs:** `<exact IDs>`
- **Authoritative root/branch/HEAD:** `<path and identity>`
- **Nearest instructions:** `<paths>`
- **Exact write ownership:** `<files, folders, regions, resources>`
- **Read-only/shared targets:** `<targets and owners>`
- **Prohibited actions:** `<publication, install, credentials, destructive actions, etc.>`
- **Required reviewers/approvers:** `<roles>`
- **Start/deadline:** `<ISO timestamps and timezone>`
- **Lane time budget:** `<duration>`
- **Model/effort:** `<Luna Max read-only; Sol Low/Light for bounded QA; Sol Medium default; or Sol Max>`
- **Why this effort level is proportionate:** `<normal lane or exact complex critical reason>`
- **Timebox stage:** `<EARLY/MIDPOINT/SCOPE FREEZE/STABILIZE/OVERRUN>`
- **Assigned pre-mortem risks:** `<PM IDs and warning triggers>`
- **Controlling visual reference/viewport/state:** `<exact identity or NOT APPLICABLE>`
- **Skeleton gate status:** `<NOT APPLICABLE/OPEN/READY/APPROVED and EV-###>`
- **Shared runtime access:** `<NONE/READ-ONLY/ISOLATED SANDBOX/EXCLUSIVE LOCK and exact target>`
- **Runtime lock receipt:** `<RLOCK-### or NOT APPLICABLE>`
- **Decision/review deadline:** `<exact timestamp and fallback owner>`
- **Workspace isolation:** `<same-tree exact paths / worktree / isolated copy; root and base identity>`
- **Shared seam contracts:** `<SEAM-### IDs or none>`
- **Resource budget/attempt limit:** `<model/usage/disk/RAM/GPU/processes/whole-path attempts>`
- **Task-owned background processes:** `<PIDs/components/purpose/stop condition or none>`
- **Visible UI authority:** `<background-only or exact allowed interaction>`
- **Active correction IDs:** `<CORR-### IDs or NONE>`
- **Correction acknowledgment receipt:** `<exact replacement behavior acknowledged at timestamp>`

## Lane status

- **State:** `<ASSIGNED/ACTIVE/BLOCKED/READY FOR REVIEW/CHANGES REQUESTED/ACCEPTED/STOPPED>`
- **Snapshot time:** `<ISO timestamp>`
- **Required lane gates:** `<number>`
- **Verified locally:** `<number and percentage>`
- **Ready for coordinator review:** `<number>`
- **Open/partial/blocked:** `<number>`
- **Critical/high defects:** `<count and IDs>`
- **Current vertical slice:** `<one usable feature, repair, artifact, or decisive investigation>`
- **Slice exit condition:** `<observable result and exact proof>`
- **Tests permitted before slice review:** `<smallest checks needed and why>`
- **Last direct attempt of the real journey:** `<time/candidate/PASS-FAIL-NOT RUN/EV-###>`
- **Current candidate classification:** `<DEVELOPMENT/DIAGNOSTIC/INTEGRATION/RELEASE CANDIDATE/RELEASED>`
- **Candidate promotion justification:** `<row/change/prerequisites/decisive journey/stop result or NOT ELIGIBLE>`
- **Successive failed candidates for this journey:** `<count and identities>`
- **Two-candidate circuit breaker:** `<CLEAR/TRIGGERED; plan/review needed>`
- **Claim-scoped health:** `<component states; overall cannot exceed weakest Critical row>`
- **Movement on locked outcome:** `<observable change or NONE>`
- **Failed approaches since last escalation:** `<count and short references>`
- **Time remaining / deadline health:** `<calculated remainder; ON TRACK/AT RISK/MISSED>`
- **Next safe action:** `<one concrete action>`

## Master-row mapping

Every assigned master row must be mapped before implementation. This checklist may split work into smaller gates but may not weaken the parent outcome.

| State | Lane gate | Parent master ID(s) | Concrete requirement | Exit proof and evidence class | Evidence ID | Reviewer |
|---|---|---|---|---|---|---|
| [ ] | LANE-001 | `<REQ-###>` | `<one independently provable result>` | `<exact proof>` | `<EV-###>` | `<role>` |

Status: `[ ]` open, `[~]` active/partial, `[R]` ready for review, `[x]` coordinator-accepted for this lane, `[!]` blocked, `[D]` explicitly deferred by user decision.

## Preflight

- [ ] Read the user request, charter, master checklist, board, and nearest instructions.
- [ ] Inspect root, branch, HEAD, dirty state, relevant source, tests, and existing behavior.
- [ ] Record exact ownership and confirm no collision on the coordination board.
- [ ] Preserve unrelated dirty work and list protected regions.
- [ ] Translate every assigned promise into a lane gate with exact exit proof.
- [ ] Identify installed, physical, external, accessibility, security/privacy, and human gates affected.
- [ ] Add missing requirements, defects, or risks before implementation.
- [ ] Choose one vertical slice and record its exit condition before creating new tests.
- [ ] Review assigned pre-mortem warnings and install their guardrails before implementation.
- [ ] If a visual reference controls the lane, complete `../VISUAL_PROTOCOL.md` through skeleton approval before feature work.
- [ ] Verify `../RUNTIME_OWNERSHIP.md` before touching shared installed/runtime state; route out-of-lane mismatches instead of fixing them.
- [ ] Verify `../INTEGRATION_CONTRACTS.md`; prepare owned-side changes and queue shared integration instead of waiting for per-edit permission.

## Work slices

| State | Slice | Lane gates | Files/systems owned | Verification | Result/next action |
|---|---|---|---|---|---|
| [ ] | `<vertical result>` | `<LANE IDs>` | `<targets>` | `<command/journey>` | `<result>` |

## Focus and test-churn guard

- **User or project outcome this slice advances:** `<outcome>`
- **Smallest implementation needed:** `<work>`
- **Smallest evidence needed now:** `<proof>`
- **Broader verification checkpoint:** `<condition that triggers it>`
- **Side quests explicitly parked:** `<ideas/tests/refactors and why they are not current>`
- **Drift alarm state:** `<CLEAR/TRIGGERED; reason>`
- **Optional scope already cut:** `<items>`

Before any new or repeated check, answer:

1. Which exact lane/master row does it prove?
2. Is that row currently unproven or affected by changed bytes/assumptions?
3. What implementation, release, or risk decision changes for PASS versus FAIL?
4. Is a cheaper existing check already sufficient at this stage?

If those answers are unclear, park the test and finish the slice. See `../FOCUS_PROTOCOL.md`.

If two approaches fail or three meaningful checkpoints show no movement on the locked outcome, set the drift alarm to `TRIGGERED`. Do not start a third speculative approach or adjacent task. Record the exact facts, reduce the problem to the narrowest blocker, and send it to the coordinator.

If two successive candidates fail the same primary journey, regardless of immediate defect names, trigger the two-candidate circuit breaker. Freeze packaging/versioning and symptom patches; reconstruct the complete transaction contract, identify the missing invariant, run the bounded sibling-impact check, repair the accepted plan, and obtain required independent review before another candidate.

At midpoint, scope freeze, and stabilization checkpoints, update the timebox fields using `../TIMEBOX_PROTOCOL.md`. Never claim the deadline was met unless the exact locked outcome reached its required evidence level before the recorded deadline.

## Discoveries and change requests

Do not quietly absorb scope changes. Send project-level discoveries to the coordinator for a master ID or decision.

| ID | Discovery/defect | Affected master IDs | Severity | Proposed action | Coordinator response |
|---|---|---|---|---|---|
| DISC-001 | `<fact>` | `<IDs>` | `<level>` | `<action>` | `<pending/decision>` |

## Verification ledger

Put durable details in `../EVIDENCE_LEDGER.md`; cite IDs here.

| Lane gate | Command/journey/artifact | Result | Evidence ID | What it does not prove |
|---|---|---|---|---|
| `<LANE-###>` | `<exact check>` | `<PASS/FAIL/NOT RUN/BLOCKED>` | `<EV-###>` | `<limitation>` |

## Blockers

A blocker is narrow. Keep unrelated gates moving.

| Blocked gate | Exact blocking condition | Attempts/evidence | Needed authority/input | Disjoint next work |
|---|---|---|---|---|
| `<ID>` | `<condition>` | `<facts>` | `<need>` | `<action>` |

## Handoff

- **Outcome produced:** `<plain language>`
- **Exact acceptance journey result:** `<PASS/FAIL/NOT RUN and EV-###>`
- **Master IDs addressed:** `<IDs and READY/accepted state>`
- **Files inspected:** `<exact paths>`
- **Files changed:** `<exact paths>`
- **Unrelated changes preserved:** `<exact paths or none observed>`
- **Checks and results:** `<commands, counts, failures, skips>`
- **Evidence IDs:** `<EV-###>`
- **Candidate identity:** `<commit/hash/build/version or NOT APPLICABLE>`
- **Known defects/risks:** `<IDs>`
- **Not run/external gates:** `<exact list>`
- **Decisions needed:** `<exact questions or none>`
- **Next safe action:** `<one action>`

## Agent completion audit

- [ ] Re-read assigned master rows and later coordinator/user messages.
- [ ] Stayed within ownership or recorded every transfer.
- [ ] Added every discovered promise, defect, and safety obligation.
- [ ] Every locally checked row has matching current evidence.
- [ ] Failures, skips, blockers, and `NOT RUN` gates are explicit.
- [ ] No build/mock/source/static result is presented as installed, physical, external, or human proof.
- [ ] Handoff is complete enough to continue without chat history.
- [ ] Lane is marked `READY FOR REVIEW`, not project-complete.
