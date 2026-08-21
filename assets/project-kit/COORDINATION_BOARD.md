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
22. Rehydrate `PROJECT_STATE.md` at every user turn and after compaction, restart, or handoff before scheduling, creating tasks, waiting, or editing production.
23. Build a ready set from accepted-plan lanes whose hard prerequisites are satisfied. Launch or resume the entire ready set before the first wait; never wait on one task while another ready independent lane is idle or uncreated.
24. Use one multi-target `wait_threads` call for up to eight active lanes and replenish from the ready set before waiting again. A single-target wait is allowed only when exactly one non-Director lane is legitimately ready and target `1` is recorded. A lane blocked by a real collision, resource, authority, or hard dependency is not ready; record the exact reason.
25. Reuse the existing registered task for a stable lane whenever its ownership, checklist, model, and project/workspace remain valid. A new candidate, review pass, or slice is not a new lane and does not justify a new task.
26. Create a replacement only after recording why the existing task is absent, misconfigured, irrecoverable, duplicate, superseded, or explicitly stopped. Verify actual startup metadata rather than intended launch arguments.
27. Archive terminal lifecycle debris only after preserving handoff evidence, dirty/unintegrated work, and task-owned process state. Idle, waiting, blocked, or reusable is not terminal. If the host proves a terminal task cannot be archived because its backing record is gone, record `UNARCHIVABLE` with the failed archive receipt and proof that no unintegrated changes/processes remain; do not block disjoint product work or claim it was archived.
28. Capture exploratory ideas in the master backlog and affected checklists; do not let unpromoted `IDEA-###` rows consume a lane or completion percentage.

The coordinator must not silently implement shared integration work, waive a gate, self-approve human acceptance, or mark external behavior complete from local proof.

## Project pulse

- **Coordinator:** `<name/task/deeplink>`
- **Team mode and active roles:** `<SOLO/SMALL/FULL; roles>`
- **Last reconciled:** `<ISO timestamp>`
- **Last state rehydration:** `<ISO timestamp and reason/receipt>`
- **Ready independent lanes:** `<semicolon-separated stable lane IDs or NONE>`
- **Running ready lanes:** `<number; excludes Director>`
- **Useful concurrency target:** `<number; equals ready independent lane count>`
- **Under-utilization reason:** `<NONE or exact failed task/dependency/collision>`
- **Next launch wave:** `<stable lane IDs and trigger or NONE>`
- **Last launch/replenishment receipt:** `<timestamp; stable lane IDs and exact create/send receipts, or NOT APPLICABLE before lanes exist>`
- **Director wait state/receipt:** `<NOT WAITING and action / WAITING; timestamp; bounded wait_threads batch(es) covering all stable lane/task IDs/cursors>`
- **Active tasks:** `<count including Director>`
- **Planned durable lanes lacking create_thread receipt:** `<IDs/lanes or NONE>`
- **Subagents currently carrying durable work:** `<MUST BE NONE>`
- **Task lifecycle backlog:** `<NONE / ARCHIVE PENDING exact IDs and retry / UNARCHIVABLE exact IDs plus failed archive and no-unintegrated-state receipt>`
- **Duplicate live stable lanes:** `<NONE or stable lane IDs/tasks requiring reconciliation>`
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

One row per top-level Codex task or durable lane, retaining archived/replaced rows as history. Every stable lane has at most one non-archived live task. Every non-Director row must retain its original `create_thread` receipt. A task without that receipt, exact task ID/deeplink, actual startup read-back, checklist, and exact ownership is not authorized to read project files, edit, test, or coordinate.

| Stable lane ID | Task/lane | Creation/reuse receipt | Task ID/deeplink | Actual model/effort | Actual project/root/worktree | Checklist | Master IDs | Exact write ownership | Hard prerequisites | Time budget/deadline | Excluded/shared regions | Lifecycle/archive receipt | State | Last meaningful update | Next action |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `<LANE-ID>` | `<lane>` | `create_thread / <returned receipt>; <reuse/replacement receipt>` | `<task ID/deeplink>` | `<actual task read-back>` | `<actual project/root/worktree read-back>` | `agent-checklists/<name>.md` | `<IDs>` | `<paths/regions/systems>` | `<NONE or exact prerequisite>` | `<budget/deadline>` | `<paths>` | `<LIVE / ARCHIVED receipt / ARCHIVE PENDING retry / UNARCHIVABLE failed-attempt receipt>` | `PROPOSED` | `<timestamp>` | `<action>` |

Allowed states: `PROPOSED`, `ASSIGNED`, `ACTIVE`, `BLOCKED`, `READY FOR REVIEW`, `CHANGES REQUESTED`, `ACCEPTED`, `STOPPED`, `REPLACED`, `MISCONFIGURED`, `DUPLICATE`, `SUPERSEDED`. `STOPPED`, `REPLACED`, `MISCONFIGURED`, `DUPLICATE`, and `SUPERSEDED` are terminal and require an archive receipt after safe lifecycle reconciliation, or a verified `UNARCHIVABLE` receipt when the host has lost the backing task and no unintegrated changes/processes remain.

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
- [ ] The task creation receipt, ID, deeplink, actual model/effort, actual project/root/worktree, checklist, and startup state were registered and matched before lane work began.
- [ ] Existing stable-lane tasks were reconciled and reused; any replacement has a recorded reason and old/new task IDs.
- [ ] Every simultaneously ready independent lane was launched/resumed before waiting, and the wait covered all active targets together.
- [ ] Terminal/duplicate/superseded/misconfigured tasks were archived only after dirty work, handoff, and processes were reconciled, or carry verified `UNARCHIVABLE` evidence; reusable blocked/waiting tasks remain available.
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
