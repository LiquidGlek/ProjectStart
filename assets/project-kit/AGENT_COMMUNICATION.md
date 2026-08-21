# Agent Communication Registry

This is the durable address book for top-level Codex project tasks. The Project Director owns it. The coordination board owns work state; this file owns exact task identity and routing.

## Task creation contract

- **Durable lane creation tool:** `create_thread` (or the host-namespaced task-management equivalent that creates a sidebar-visible Codex task).
- **Forbidden substitute:** `spawn_agent` or any nested/subagent mechanism.
- A role or lane is durable when it owns a master ID, production file/system, shared seam, runtime, checklist, deadline, acceptance gate, independent verification, or resumable cross-task communication.
- A subagent is allowed only as one bounded, temporary support call inside an existing top-level task. It owns no project lane, master row, production change, runtime, checklist, deadline, or acceptance decision, and its result returns to the parent task.
- If `create_thread` is unavailable or task creation fails, record the lane as `BLOCKED`. Do not start it through a subagent and do not silently absorb it into the Director.
- A stable lane keeps one live task across slices, candidates, fixes, and review cycles. Before `create_thread`, reconcile this directory and exact task read-backs; resume the valid registered task by ID/deeplink when it still matches.
- New task creation requires a recorded replacement reason: no task exists, or the previous task is confirmed misconfigured, irrecoverable, duplicate, superseded, or explicitly stopped. “Idle,” “finished one slice,” “needs another pass,” and “hard to find by title” are not replacement reasons.
- Every created/resumed task must return a startup receipt with its exact ID/deeplink, actual model/effort, actual project/root/worktree, checklist, and status. The Director compares the receipt to the assignment and user-selected model policy before substantive work. Intended arguments are not proof; a model mismatch stops the lane.
- Safely archive a terminal/duplicate/superseded/misconfigured task only after its unintegrated changes, dirty worktree, task-owned processes, and handoff evidence are reconciled. Verify the archive and retain its historical row. Do not archive a blocked, waiting, or idle task that remains reusable. If the host proves the backing task no longer exists, record `UNARCHIVABLE` with the failed archive receipt and proof of no unintegrated changes/processes; never report it as archived or let sidebar debris halt unrelated product work.

## Director address

- **Project Director task:** `<exact task title>`
- **Task ID:** `<exact ID>`
- **Deeplink:** `<exact copied deeplink>`
- **Checklist:** `agent-checklists/coordinator.md`
- **Last verified reachable:** `<ISO timestamp>`

Sibling tasks must receive this address at creation. If task discovery by title fails, use the exact ID/deeplink.

## Task directory

Register the `create_thread` receipt and returned ID/deeplink immediately after each task is created. Then obtain and compare the actual startup read-back before substantive work. No durable task may read project files beyond startup verification, edit, test, or begin cross-task work while either receipt is absent or mismatched.

| Stable lane ID | Role/domain | Exact task title | Creation/reuse receipt | Task ID | Deeplink | Actual model/effort | Actual project/root/worktree | Checklist | Owns | Send decisions/blockers to | Lifecycle/replacement/archive receipt | Status | Last verified |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| DIRECTOR | Project Director | `<title>` | `current task` | `<ID>` | `<deeplink>` | `<actual read-back>` | `<actual project/root/worktree>` | `agent-checklists/coordinator.md` | Master, board, routing, integration decisions | User only at escalation boundary | CURRENT | ACTIVE | `<time>` |
| `<LANE-ID>` | `<domain>` | `<title>` | `create_thread / <returned receipt>; <reuse/replacement receipt>` | `<ID>` | `<deeplink>` | `<actual read-back>` | `<actual project/root/worktree>` | `agent-checklists/<lane>.md` | `<master IDs and exact system>` | Project Director | `<LIVE / REPLACED BY ID / ARCHIVED receipt / ARCHIVE PENDING retry / UNARCHIVABLE failed-attempt receipt>` | PROPOSED | `<time>` |

## Routing rules

- Requirements, priority, ownership, deadline, scope, and integration decisions go to the Project Director.
- Shared-seam questions go to the Tech Lead/Integrator and copy the Director.
- Implementation questions go directly to the owning domain task when its address is registered.
- QA and Visual Audit send failures to the owning task and copy the Director with exact master/evidence IDs.
- Tasks do not ask the user routine questions or create sibling tasks. The Director owns user escalation and task creation.
- Use exact IDs/deeplinks; titles are labels, not identity.
- When several ready tasks are useful, message/start the whole launch wave first and then monitor all active IDs in one multi-target wait. Do not serialize independent work through single-task waits.
- In FULL TEAM, send all 10–15 staffed-wave assignments before waiting. Split monitoring into bounded 2–8-target batches without reducing actual concurrency; every worker continues independently while the Director monitors.
- At regroup, send the feature-freeze/handoff request to every wave task, then route integration conflicts and QA failures back to the original stable lane IDs rather than creating replacement tasks.

## Communication receipts

Keep only messages that affect ownership, requirements, blockers, integration, or acceptance.

| ID | Time | From task | To task | Master IDs | Message/decision | Delivery/response state |
|---|---|---|---|---|---|---|
| MSG-001 | `<time>` | `<task ID>` | `<task ID>` | `<IDs>` | `<bounded message>` | `<SENT/ACKNOWLEDGED/ANSWERED/UNCERTAIN>` |

Never automatically resend an externally consequential or ambiguous message. Reconcile its delivery state first.

## Address audit

- [ ] Director task ID and deeplink are exact and current.
- [ ] Every planned durable role/domain was created with `create_thread`, not `spawn_agent`.
- [ ] Every active top-level task has its creation receipt and exact returned ID/deeplink.
- [ ] Every active task has a verified actual model/effort and actual project/root/worktree startup receipt matching the assignment.
- [ ] The user answered the exact worker count and model/effort policy before initialization; the live non-Director count and every actual model match those answers.
- [ ] Every task received the Director deeplink and registry path.
- [ ] Every task maps to one checklist and exact owned domain.
- [ ] Every stable lane reuses its valid task; any replacement records the exact reason and old/new IDs.
- [ ] Stopped/replaced/duplicate/superseded/misconfigured tasks remain listed with status, replacement ID where applicable, and verified archive or `UNARCHIVABLE` receipt.
- [ ] No blocked, waiting, or merely idle reusable task was archived as unused.
- [ ] No durable domain is hidden behind a subagent.
- [ ] FULL TEAM has exact create/reuse/start receipts for 10–15 non-Director workers and an implementation majority.
- [ ] Every staffed-wave task received the regroup/freeze and integration-result routing receipts.
- [ ] Any temporary subagent was one-shot support with no master, production, runtime, checklist, deadline, or gate ownership.
