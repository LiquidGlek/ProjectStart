# Agent Communication Registry

This is the durable address book for top-level Codex project tasks. The Project Director owns it. The coordination board owns work state; this file owns exact task identity and routing.

## Task creation contract

- **Durable lane creation tool:** `create_thread` (or the host-namespaced task-management equivalent that creates a sidebar-visible Codex task).
- **Forbidden substitute:** `spawn_agent` or any nested/subagent mechanism.
- A role or lane is durable when it owns a master ID, production file/system, shared seam, runtime, checklist, deadline, acceptance gate, independent verification, or resumable cross-task communication.
- A subagent is allowed only as one bounded, temporary support call inside an existing top-level task. It owns no project lane, master row, production change, runtime, checklist, deadline, or acceptance decision, and its result returns to the parent task.
- If `create_thread` is unavailable or task creation fails, record the lane as `BLOCKED`. Do not start it through a subagent and do not silently absorb it into the Director.

## Director address

- **Project Director task:** `<exact task title>`
- **Task ID:** `<exact ID>`
- **Deeplink:** `<exact copied deeplink>`
- **Checklist:** `agent-checklists/coordinator.md`
- **Last verified reachable:** `<ISO timestamp>`

Sibling tasks must receive this address at creation. If task discovery by title fails, use the exact ID/deeplink.

## Task directory

Register the `create_thread` receipt and returned ID/deeplink immediately after each task is created. No durable task may read project files, edit, test, or begin cross-task work while its receipt is absent.

| Role/domain | Exact task title | Creation mechanism/receipt | Task ID | Deeplink | Checklist | Owns | Send decisions/blockers to | Status | Last verified |
|---|---|---|---|---|---|---|---|---|---|
| Project Director | `<title>` | `current task` | `<ID>` | `<deeplink>` | `agent-checklists/coordinator.md` | Master, board, routing, integration decisions | User only at escalation boundary | ACTIVE | `<time>` |
| `<domain>` | `<title>` | `create_thread / <returned receipt>` | `<ID>` | `<deeplink>` | `agent-checklists/<lane>.md` | `<master IDs and exact system>` | Project Director | PROPOSED | `<time>` |

## Routing rules

- Requirements, priority, ownership, deadline, scope, and integration decisions go to the Project Director.
- Shared-seam questions go to the Tech Lead/Integrator and copy the Director.
- Implementation questions go directly to the owning domain task when its address is registered.
- QA and Visual Audit send failures to the owning task and copy the Director with exact master/evidence IDs.
- Tasks do not ask the user routine questions or create sibling tasks. The Director owns user escalation and task creation.
- Use exact IDs/deeplinks; titles are labels, not identity.

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
- [ ] Every task received the Director deeplink and registry path.
- [ ] Every task maps to one checklist and exact owned domain.
- [ ] Stopped/replaced tasks remain listed with status and replacement ID.
- [ ] No durable domain is hidden behind a subagent.
- [ ] Any temporary subagent was one-shot support with no master, production, runtime, checklist, deadline, or gate ownership.
