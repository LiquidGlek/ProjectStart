# Multi-Agent Coordination Board

The coordinator owns this board. Its job is to make work visible, collision-free, and reviewable—not to replace the master checklist.

## Coordinator contract

The coordinator must:

1. Create every planned durable role/domain with `create_thread`, then register its creation receipt and returned task ID/deeplink before that lane reads, edits, tests, or coordinates.
2. Assign exact master IDs and non-overlapping paths or systems.
3. Reject vague ownership such as “backend” when exact seams can be named.
4. Resolve collisions before edits and record every transfer.
5. Route discoveries into the master checklist and decisions into the decision log.
6. Check evidence before promoting `[R]` task work to `[x]` master rows.
7. Keep blocked lanes narrow and continue disjoint work.
8. Produce one consolidated project status without inflating task self-reports.
9. Stop or redirect a lane when its work no longer advances the locked outcome or a named required gate.
10. Enforce the project deadline checkpoints and reduce optional scope before allowing an outcome-critical lane to drift.
11. Monitor pre-mortem warning triggers and act before they become blockers.
12. Freeze feature work on visual lanes until the measured real-control skeleton passes its gate.
13. Serialize shared installed/runtime mutation through `RUNTIME_OWNERSHIP.md`; do not let tasks repair out-of-lane environment mismatches opportunistically.
14. Keep lanes autonomous inside assigned boundaries; require approval only for boundary changes and enforce decision/review deadlines.
15. Keep the Director out of routine implementation and route shared source seams through pre-authorized integration contracts.
16. Enforce `RESOURCE_BUDGET.md`, whole-path attempt limits, process ownership, and immediate pause reconciliation.
17. Persist every user correction as `CORR-###`, broadcast it to affected tasks, collect acknowledgment receipts, and treat recurrence as a process failure.
18. Classify candidates and require promotion justification; after two successive failures of the same primary journey, freeze packaging/versioning and enforce the two-candidate circuit breaker.
19. Keep every health/readiness claim scoped; overall product or release health cannot exceed the weakest required Critical row.
20. Reject `spawn_agent` as a substitute for a durable project task. A subagent may only provide one-shot temporary support with no master row, production/runtime ownership, checklist, deadline, acceptance gate, or independently resumable lane.
21. If `create_thread` is unavailable or fails, mark that lane `BLOCKED`; do not hide it behind a nested agent or absorb it into the Director.

The coordinator must not silently implement shared integration work, waive a gate, self-approve human acceptance, or mark external behavior complete from local proof.

## Project pulse

- **Coordinator:** `<name/task/deeplink>`
- **Team mode and active roles:** `<SOLO/SMALL/FULL; roles>`
- **Last reconciled:** `<ISO timestamp>`
- **Active tasks:** `<count>`
- **Planned durable lanes lacking create_thread receipt:** `<IDs/lanes or NONE>`
- **Subagents currently carrying durable work:** `<MUST BE NONE>`
- **Ready for review:** `<count>`
- **Blocked tasks:** `<count>`
- **Unassigned critical rows:** `<IDs or none>`
- **Ownership collisions:** `<IDs or none>`
- **Lanes showing test churn/no outcome movement:** `<lanes or none>`
- **Primary outcome state:** `<NOT ATTEMPTED/FAIL/PARTIAL/PASS and EV-###>`
- **Last direct acceptance attempt:** `<time/candidate/result>`
- **Current candidate classification:** `<DEVELOPMENT/DIAGNOSTIC/INTEGRATION/RELEASE CANDIDATE/RELEASED>`
- **Successive failed candidates for primary journey:** `<count and identities>`
- **Two-candidate circuit breaker:** `<CLEAR/TRIGGERED; required repair/review>`
- **Claim-scoped health:** `<component/journey states; overall status>`
- **Unrelated work accumulated while primary stayed open:** `<none or exact work and justification>`
- **Project deadline / current slice deadline:** `<project deadline or NONE> / <slice timestamp and calculated remainder>`
- **Current timebox stage:** `<EARLY/MIDPOINT/SCOPE FREEZE/STABILIZE/OVERRUN>`
- **Pre-mortem warnings currently triggered:** `<PM IDs or none>`
- **Active shared runtime lock:** `<task/candidate/purpose or NONE>`
- **Reviews/decisions past deadline:** `<IDs or none>`
- **Shared seams waiting without a contract:** `<IDs or none>`
- **Resource/process interference:** `<none or exact conflict>`
- **Task-owned background processes:** `<count/owners or none>`
- **Active user corrections:** `<CORR IDs, affected tasks, recurrence count, or none>`
- **Next integration checkpoint:** `<condition, not vague time>`

## Agent registry

One row per top-level Codex task or durable lane. Every non-Director row must have a `create_thread` receipt. A task without that receipt, task ID/deeplink, checklist, and exact ownership is not authorized to read project files, edit, test, or coordinate.

| Task/lane | Creation mechanism/receipt | Task ID or deeplink | Model/effort | Checklist | Master IDs | Exact write ownership | Time budget/deadline | Excluded/shared regions | State | Last meaningful update | Next action |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `<lane>` | `create_thread / <returned receipt>` | `<task ID/deeplink>` | `<Luna Max read-only; Sol Low/Light, Medium, or Max>` | `agent-checklists/<name>.md` | `<IDs>` | `<paths/regions/systems>` | `<budget/deadline>` | `<paths>` | `PROPOSED` | `<timestamp>` | `<action>` |

Allowed states: `PROPOSED`, `ASSIGNED`, `ACTIVE`, `BLOCKED`, `READY FOR REVIEW`, `CHANGES REQUESTED`, `ACCEPTED`, `STOPPED`.

Role labels: `PROJECT DIRECTOR`, `PRODUCT/UX`, `TECH LEAD/INTEGRATOR`, `DEVELOPER`, `QA`, `VISUAL AUDITOR`, `RELEASE/ACCEPTANCE`. One task may hold compatible roles on a small project, but an implementer may not independently approve its own gate.

## Shared seams and freezes

| Seam/path/system | Current owner | Other affected lanes | Rule | Release condition |
|---|---|---|---|---|
| `<exact target>` | `<owner>` | `<lanes>` | `<read-only/frozen/coordinated>` | `<evidence or transfer>` |

## Dependencies and messages

Record only coordination facts that a replacement coordinator needs.

| ID | From | To | Need/decision | Blocks IDs | Status | Timestamp |
|---|---|---|---|---|---|---|
| COORD-001 | `<lane>` | `<lane/coordinator>` | `<specific request>` | `<IDs>` | `<OPEN/ANSWERED>` | `<time>` |

## Ownership transfer log

Ownership changes only after both the board and affected checklists are updated.

| Time | Target | From | To | Reason | Dirty/uncommitted state acknowledged | Evidence/handoff |
|---|---|---|---|---|---|---|
| `<time>` | `<path/system>` | `<owner>` | `<owner>` | `<reason>` | `<yes/no>` | `<EV-### or handoff>` |

## Integration queue

Ready does not mean integrated. Preserve order when lanes share contracts.

| Order | Lane | Master IDs | Candidate identity | Required preconditions | Reviewer | Result |
|---|---|---|---|---|---|---|
| 1 | `<lane>` | `<IDs>` | `<commit/hash/files>` | `<conditions>` | `<reviewer>` | `<PENDING/PASS/FAIL>` |

## Coordinator review checklist

- [ ] This durable lane is a separate top-level Codex task created through `create_thread`; it is not a subagent.
- [ ] The task creation receipt, ID, deeplink, and checklist were registered before lane work began.
- [ ] Agent stayed inside exact ownership.
- [ ] Changed and preserved files are listed.
- [ ] Relevant requirements and discoveries are present in the master checklist.
- [ ] Evidence IDs exist and match the required class and candidate identity.
- [ ] Tests exercise behavior rather than source strings or mocks alone.
- [ ] Verification was proportional; repeated or new tests changed a decision or proved an unproven row.
- [ ] The lane produced a coherent outcome, not only more test infrastructure or status artifacts.
- [ ] The exact acceptance journey was attempted, or a concrete prerequisite/blocker explains why it could not be attempted.
- [ ] Adjacent work performed while the primary outcome stayed open was necessary and mapped to its blocker or acceptance path.
- [ ] Deadline checkpoints were honored; optional scope was cut before proof, safety, or truth was weakened.
- [ ] Visual lanes followed reference decomposition and skeleton approval before features; mockups were not treated as loose inspiration.
- [ ] Known failures, skips, and `NOT RUN` gates are explicit.
- [ ] Shared-contract impact and integration order are understood.
- [ ] Agent lane can be accepted without implying broader project completion.
