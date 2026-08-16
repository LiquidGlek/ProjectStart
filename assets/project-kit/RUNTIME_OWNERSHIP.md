# Shared Runtime and Candidate Ownership

Parallel source work stays fast. Only mutation of one shared installed app, runtime configuration, port set, account, device, or acceptance candidate is serialized. The Project Director owns this registry.

## Current lock

- **Lock ID:** `<RLOCK-### or NONE>`
- **Owning top-level task ID/deeplink:** `<exact identity>`
- **Candidate identity:** `<commit/hash/build/version>`
- **Environment:** `<machine/user/profile/install/root/account/device>`
- **Purpose and master IDs:** `<one acceptance or diagnostic journey>`
- **Allowed mutations:** `<exact settings/files/processes/resources>`
- **Read-only/prohibited seams:** `<exact boundaries>`
- **Acquired/expires:** `<ISO timestamps>`
- **Release condition:** `<evidence, rollback, cleanup, handoff>`
- **Baseline/snapshot evidence:** `<EV-###>`
- **Rollback/recovery:** `<exact method>`

`NONE` means no task may mutate shared runtime state. Tasks may inspect read-only when safe or use an explicitly isolated sandbox.

## Fast lease rules

1. The Director grants one narrow, timeboxed lease upfront for a named journey; the task does not ask before every allowed operation.
2. Source ownership does not imply runtime ownership, and runtime serialization does not block parallel source work.
3. Before mutation, record baseline state and recoverable rollback where applicable.
4. Do not stop another task's processes, reuse its ports, change its runtime settings, install over its candidate, or use its account/device session.
5. An out-of-lane mismatch is a routed blocker, not permission to fix adjacent systems.
6. Transfer requires both tasks to acknowledge dirty/runtime state and update their checklists and the board.
7. Release after evidence, cleanup/rollback, and final state are recorded.
8. Ambiguous external results are reconciled before retry; never automatically repeat a possibly successful operation.

## Isolated environments

| ID | Owning task | Sandbox/profile/root/port/account | Candidate | Allowed purpose | Must not affect | Status |
|---|---|---|---|---|---|---|
| ISO-001 | `<task>` | `<exact isolation>` | `<identity>` | `<journey>` | `<shared state>` | `<ACTIVE/RELEASED>` |

## Lock and transfer history

| Lock ID | Time | Event | From | To | Candidate/environment | Baseline/final evidence | Result |
|---|---|---|---|---|---|---|---|
| RLOCK-001 | `<time>` | `<ACQUIRE/TRANSFER/RELEASE>` | `<task/NONE>` | `<task/NONE>` | `<identity>` | `<EV IDs>` | `<state>` |

## Out-of-lane mismatch routing

1. Stop before mutation.
2. Record exact mismatch, candidate, environment, and evidence.
3. Identify affected master IDs and likely owner without asserting an unproven cause.
4. Notify the Director through `AGENT_COMMUNICATION.md`.
5. Continue isolated, read-only, or disjoint work.
6. Resume that seam only after explicit lock/ownership transfer.

## Release audit

- [ ] Lock owner, candidate, environment, and allowed mutations matched the work performed.
- [ ] Baseline and final state are recorded.
- [ ] Other tasks' processes, ports, profiles, settings, accounts, devices, and candidates were preserved.
- [ ] Out-of-lane mismatches were routed rather than opportunistically fixed.
- [ ] Rollback/cleanup completed or remaining state is explicitly handed off.
