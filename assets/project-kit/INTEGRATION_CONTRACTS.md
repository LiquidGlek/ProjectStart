# Integration and Shared-Seam Contracts

This file prevents shared files and installed acceptance from turning into project-wide freezes. The Tech Lead/Integrator owns it; the Project Director enforces deadlines.

## Workspace strategy

Choose one explicit mode per top-level task:

| Mode | Use when | Rule |
|---|---|---|
| Exact-path same tree | Dirty shared checkout cannot be safely reproduced and paths do not overlap | Own exact paths/regions; preserve all unrelated changes. |
| Git worktree | Required baseline is committed and tasks need overlapping source paths | Each task gets an isolated branch/worktree and exact base commit. |
| Recoverable isolated copy | Dirty baseline must be reproduced and a safe copy procedure is available | Record source identity, copied dirty state, exclusions, and reintegration method. |
| Read-only analysis | No safe write isolation exists | Produce evidence/patch design; do not mutate. |

Never create isolation by discarding, committing, resetting, or silently copying user-owned dirty work. Record limitations.

## Installed candidate is not source

Physical or installed acceptance freezes the exact candidate bytes, install, configuration, and runtime named in `RUNTIME_OWNERSHIP.md`. It does **not** freeze unrelated source work in another isolated workspace. New source cannot be claimed as part of the running candidate until rebuilt and re-identified.

## Shared-seam contract

Create this before a domain task reaches the seam.

| ID | Shared seam/file/region | Integrator owner | Consuming tasks | Pre-authorized interface/change envelope | Owned-side deliverable | Decision deadline | Integration checkpoint | Status |
|---|---|---|---|---|---|---|---|---|
| SEAM-001 | `<exact target>` | `<task ID>` | `<task IDs>` | `<method/signature/schema/behavior>` | `<patch/API/tests>` | `<timestamp>` | `<condition>` | `<PROPOSED/ACCEPTED/QUEUED/INTEGRATED/FAILED>` |

Acceptance of the contract authorizes work inside its envelope. Do not require a second micro-approval for each one-line callback or adapter implementation.

For a staffed wave, an accepted contract must be implementable from both sides before either sibling finishes. Provide the smallest fixture/test double, owned-side adapter, schema/vector, or compatibility harness needed for isolated progress. “Waiting for the other implementation” is not a hard prerequisite until these routes are inspected and rejected for a concrete reason.

## Integration queue

| Order | Seam ID | Source task/candidate | Exact change/handoff | Preconditions | Integrator result | Evidence |
|---|---|---|---|---|---|---|
| 1 | `<SEAM-###>` | `<task/commit/hash>` | `<patch/files>` | `<tests/contracts>` | `<PENDING/PASS/FAIL>` | `<EV-###>` |

The queue is consumed at a staffed-wave regroup barrier, not opportunistically as unrelated developers are still changing the wave. Every planned worker supplies a coherent handoff or explicit blocker disposition. New feature work freezes; the Integrator applies batches in the accepted order, routes conflicts to original owners, records one exact candidate, and only then dispatches independent QA.

## No-wait behavior

- A domain task implements and verifies its owned side, queues the seam, then continues another required disjoint slice.
- If no outcome-critical disjoint slice remains, it becomes `READY FOR REVIEW` or narrowly `BLOCKED`; it does not invent more tests, abstractions, or adjacent features.
- Reviews are asynchronous. Ready work does not require the developer to idle.
- Decision deadline: 10% of lane timebox, minimum 3 minutes, maximum 10 minutes.
- On deadline, the Director chooses a reversible path, reassigns the integrator, or records a genuine blocker.
- Repeated polling of the same unchanged hold is not progress.

## Director/Integrator audit

- [ ] Director owns no routine production implementation.
- [ ] Every overlapping source seam has one Integrator and pre-authorized envelope.
- [ ] Installed acceptance froze only exact candidate/runtime identity, not isolated source work.
- [ ] No accepted narrow interface waited for redundant per-edit approval.
- [ ] Tasks without remaining critical work went ready/blocked instead of expanding scope.
- [ ] Integration evidence identifies exact source task, candidate, and affected master IDs.
- [ ] Every claimed sibling dependency was challenged with a frozen contract and fixture/test-double/owned-side route.
- [ ] Regroup records all planned handoffs, feature freeze, batch order, conflicts/owners, exact candidate, and QA dispatch.
