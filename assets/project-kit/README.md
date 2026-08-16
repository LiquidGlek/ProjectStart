# Useful Agent Project Kit

This folder is a reusable operating system for projects worked on by one or more agents. It keeps requirements, ownership, progress, decisions, and proof separate so activity cannot be mistaken for completion.

Durable project roles and product-domain lanes must be separate sidebar-visible Codex tasks created with `create_thread`. Never use `spawn_agent` as a substitute. If task creation is unavailable or fails, leave the lane blocked; subagents are limited to one-shot support with no project ownership.

## The source-of-truth hierarchy

1. [`PROJECT_CHARTER.md`](PROJECT_CHARTER.md) defines the outcome, boundaries, authority, and quality bar.
2. [`MASTER_CHECKLIST.md`](MASTER_CHECKLIST.md) contains every project promise and is the only source for project completion.
3. [`PRIOR_ART_RESEARCH.md`](PRIOR_ART_RESEARCH.md) records what existing products, open-source code, formulas, and data can be reused before architecture is chosen.
4. [`PROJECT_PLAN.md`](PROJECT_PLAN.md) turns the inspected evidence and reuse decisions into architecture, vertical slices, and durable task lanes.
5. [`COORDINATION_BOARD.md`](COORDINATION_BOARD.md) assigns non-overlapping lanes and tracks every agent.
6. Each top-level task gets a copy of [`AGENT_CHECKLIST_TEMPLATE.md`](AGENT_CHECKLIST_TEMPLATE.md), linked to exact master row IDs.
7. [`AGENT_COMMUNICATION.md`](AGENT_COMMUNICATION.md) stores the Director and every top-level task's exact ID/deeplink and routing rule.
8. [`RUNTIME_OWNERSHIP.md`](RUNTIME_OWNERSHIP.md) serializes shared installed/runtime mutation and locks exact candidate identity.
9. [`INTEGRATION_CONTRACTS.md`](INTEGRATION_CONTRACTS.md) prevents shared seams and installed acceptance from becoming project-wide freezes.
10. [`RESOURCE_BUDGET.md`](RESOURCE_BUDGET.md) prevents runaway retries and tracks only the processes or interference risks that matter.
11. [`EVIDENCE_LEDGER.md`](EVIDENCE_LEDGER.md) records what actually proves each checked row.
12. [`DECISION_LOG.md`](DECISION_LOG.md) records decisions that change scope, architecture, or acceptance.
13. [`FOCUS_PROTOCOL.md`](FOCUS_PROTOCOL.md) prevents test churn and side-quest work.
14. [`TIMEBOX_PROTOCOL.md`](TIMEBOX_PROTOCOL.md) turns real deadlines into focus checkpoints without weakening truth or safety.
15. [`VISUAL_PROTOCOL.md`](VISUAL_PROTOCOL.md) makes mockups binding through a skeleton-first render-and-approval gate.
16. [`TEAM_OPERATING_MODEL.md`](TEAM_OPERATING_MODEL.md) defines the autonomous software-company roles, stage gates, and escalation boundary.
17. [`AGENTS.md`](AGENTS.md) tells every agent how to use the system.

If documents conflict, later explicit user direction wins. Reconcile that direction into the charter and master checklist before continuing.

## Start a new project

1. Copy this entire folder into the project root.
2. Fill in `PROJECT_CHARTER.md` and lock the master outcome.
3. Complete the bounded `PRIOR_ART_RESEARCH.md` brief.
4. Produce and accept `PROJECT_PLAN.md`; choose architecture and ordered vertical slices there.
5. Derive stable master IDs such as `REQ-001`, `UX-001`, and `REL-001` from the accepted plan and original promises.
6. Name one coordinator in `COORDINATION_BOARD.md`.
7. For each top-level task, copy `AGENT_CHECKLIST_TEMPLATE.md` to `agent-checklists/<lane>.md`.
8. Link every task row to one or more master IDs before assigning work.
9. Record proof in `EVIDENCE_LEDGER.md`; do not paste large logs into checklists.

Suggested layout after activation:

```text
project-root/
  AGENTS.md
  PROJECT_CHARTER.md
  MASTER_CHECKLIST.md
  PRIOR_ART_RESEARCH.md
  PROJECT_PLAN.md
  COORDINATION_BOARD.md
  AGENT_COMMUNICATION.md
  RUNTIME_OWNERSHIP.md
  INTEGRATION_CONTRACTS.md
  RESOURCE_BUDGET.md
  EVIDENCE_LEDGER.md
  DECISION_LOG.md
  FOCUS_PROTOCOL.md
  TIMEBOX_PROTOCOL.md
  VISUAL_PROTOCOL.md
  TEAM_OPERATING_MODEL.md
  agent-checklists/
    coordinator.md
    authentication.md
    user-interface.md
```

## The anti-slop loop

Every work item follows the same loop:

```text
Promise -> Master row -> Assigned owner -> Agent checklist -> Work
       -> Evidence -> Independent review when required -> Master row checked
```

An agent may complete its lane while the project remains incomplete. Only the coordinator updates the master status after checking the cited evidence. The coordinator does not invent requirements, waive gates, or treat consensus as proof.

## Minimal status report

Use this compact format instead of narrative progress theater:

```text
Lane: UI shell
State: ACTIVE
Master rows: UX-001, UX-002
Verified: 1/2
Changed: src/AppShell.*
Evidence: EV-014
Blocker: UX-002 needs approved mobile reference
Next: capture the narrow mobile decision; continue desktop error states
```

## What this kit deliberately prevents

- Two agents silently editing the same files.
- Agents creating untracked requirements in chat.
- Large numbers of small checks hiding a critical failure.
- Builds, mocks, screenshots, or confidence being reported as stronger proof than they are.
- Blocked work causing unrelated lanes to stop.
- Project completion being declared from agent self-reports alone.
- A hundred tiny tests replacing one finished user-visible slice.
