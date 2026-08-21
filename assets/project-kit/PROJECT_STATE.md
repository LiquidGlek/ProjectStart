# Project State — Compact Resume Packet

This file is the Director's compact, current projection of the project. It exists so context compaction, a task restart, or a handoff cannot silently erase the operating contract. It does not override `PROJECT_CHARTER.md`, `MASTER_CHECKLIST.md`, `DECISION_LOG.md`, or exact task receipts; reconcile any disagreement against those sources immediately.

## Mandatory rehydration

Before substantive action at the start of every user turn, after any context compaction/restart/handoff, and before creating tasks or waiting on them:

1. Read `AGENTS.md`, this packet, the Primary Outcome Lock and active critical path in `MASTER_CHECKLIST.md`, active `CORR-###` rows, `AGENT_COMMUNICATION.md`, and your own checklist.
2. Re-read the latest explicit user direction and classify it as current requirement/correction/decision/evidence, exploratory brainstorming, or ordinary discussion.
3. Reconcile this packet and the board against exact task read-backs. Conversation memory, task titles, and intended launch settings are not proof.
4. Update the rehydration receipt below before production edits, task creation, or a wait.

## Resume state

- **Skill contract:** `$project-start`
- **Last updated:** `<ISO timestamp and timezone>`
- **Last rehydrated:** `<ISO timestamp and timezone>`
- **Rehydration reason/receipt:** `<INITIALIZATION / USER TURN / COMPACTION / RESTART / HANDOFF; files and task read-backs reconciled>`
- **Current phase:** `<INTAKE / RESEARCH / PLAN / SKELETON / DEVELOPMENT / QA / INTEGRATION / RELEASE / BLOCKED>`
- **Primary outcome:** `<exact observable outcome>`
- **Acceptance journey:** `<starting state -> user action -> authoritative result -> persistence/recovery>`
- **Current user-directed priority:** `<exact current milestone/outcome; explicit steering controls>`
- **Plan state/decision:** `<DRAFT / ACCEPTED DEC-### / CHANGES REQUESTED>`
- **Current candidate classification:** `<DEVELOPMENT / DIAGNOSTIC / INTEGRATION / RELEASE CANDIDATE / RELEASED>`
- **Last direct journey attempt:** `<time/candidate/result/EV-### or NOT RUN>`
- **Active correction IDs:** `<CORR-### IDs or NONE>`
- **Current authority envelope:** `<safe actions already authorized>`
- **Forbidden without new user authority:** `<external/destructive/public/account/financial actions>`
- **Open brainstorm backlog:** `<number; newest IDEA-### IDs or NONE>`
- **Ready independent lanes:** `<semicolon-separated stable lane IDs or NONE>`
- **Running ready lanes:** `<number; excludes Director>`
- **Useful concurrency target:** `<number; equals ready independent lane count>`
- **Under-utilization reason:** `<NONE when running equals target; otherwise exact blocker/failed task IDs>`
- **Next launch wave:** `<stable lane IDs and trigger or NONE>`
- **Last launch/replenishment receipt:** `<timestamp; every launched/resumed stable lane and exact create/send receipt, or NOT APPLICABLE before lanes exist>`
- **Director wait state/receipt:** `<NOT WAITING and active action / WAITING; timestamp; one or more bounded wait_threads batches covering every stable lane with task IDs and cursors>`
- **Director production/runtime ownership:** `<NONE in team mode or exact timeboxed transfer DEC-###>`
- **Subagents carrying durable work:** `<MUST BE NONE>`
- **Task lifecycle backlog:** `<NONE / ARCHIVE PENDING exact IDs and retry / UNARCHIVABLE exact IDs, archive-attempt receipt, and proof of no unintegrated changes/processes>`
- **Current blockers:** `<exact IDs/facts or NONE>`
- **Whole-product status:** `<what the user can do now; missing major outcomes; weakest Critical row>`
- **Next Director action:** `<one concrete scheduling/verification action>`

`Ready independent lanes` means every listed lane can run now without colliding or waiting on a hard prerequisite. Therefore the useful concurrency target equals that count. If a resource, shared-seam, or authority constraint prevents simultaneous work, record it as a hard prerequisite and do not call that lane ready.

## Active task read-backs

Keep only the Director and currently live/reusable project tasks here. `AGENT_COMMUNICATION.md` retains lifecycle history.

| Stable lane ID | Task ID/deeplink | Actual model/effort | Actual project/workspace | Status | Current slice | Hard prerequisite | Next action | Last verified |
|---|---|---|---|---|---|---|---|---|
| DIRECTOR | `<exact ID and deeplink>` | `<actual read-back>` | `<actual project/root/worktree read-back>` | ACTIVE | `<slice>` | NONE | `<action>` | `<time>` |

## Update triggers

Update this packet after task creation or reuse, task terminal state, a user correction or steering decision, idea intake/promotion, a wait result, a meaningful checkpoint, candidate promotion, and before a long wait, handoff, or turn end. Keep it compact: link stable IDs and receipts instead of copying ledgers.
