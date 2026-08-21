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
- **Team mode:** `<SOLO / SMALL TEAM / FULL TEAM>`
- **Requested simultaneous workers:** `<exact integer 1-15; excludes Director>`
- **Worker model/effort policy:** `<exact user answer copied from charter>`
- **Staffing intake receipt:** `<ISO timestamp; answer and source reconciled>`
- **Staffed wave phase:** `<PLANNING / BUILD / REGROUP / INTEGRATION / QA / RELEASE>`
- **First staffed build wave:** `<wave ID or NONE before plan acceptance>`
- **Staffed build-wave counts:** `<planned=N; launched=N; active=N; implementation=N; Director excluded>`
- **Staffed build-wave lane IDs:** `<semicolon-separated 10-15 IDs for FULL TEAM, mode-proportionate IDs otherwise, or NONE before plan acceptance>`
- **Staffed build-wave receipt:** `<timestamp; exact lane IDs and create/reuse/send receipts, or NOT APPLICABLE before plan acceptance>`
- **Integration regroup state:** `<OPEN handoffs=N/N / SATISFIED handoffs=N/N at timestamp / NOT APPLICABLE before build>`
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

`Ready independent lanes` means every listed lane can run now without colliding or waiting on a hard prerequisite. Therefore the useful concurrency target equals that count. Before accepting a hard prerequisite, attempt contract-first parallelization with frozen interfaces, fixtures/test doubles, owned-side adapters, and isolated worktrees. During `BUILD`, requested, planned, launched, and active worker counts must match exactly. In FULL TEAM, `IMPLEMENTATION` must be a strict majority. The Director is excluded. Every actual startup model must match its user-policy-backed lane assignment. The team may move to `REGROUP` only after every planned lane has a coherent handoff or an explicit accepted blocker disposition.

## Active task read-backs

Keep only the Director and currently live/reusable project tasks here. `AGENT_COMMUNICATION.md` retains lifecycle history.

| Stable lane ID | Task ID/deeplink | Actual model/effort | Actual project/workspace | Status | Current slice | Hard prerequisite | Next action | Last verified |
|---|---|---|---|---|---|---|---|---|
| DIRECTOR | `<exact ID and deeplink>` | `<actual read-back>` | `<actual project/root/worktree read-back>` | ACTIVE | `<slice>` | NONE | `<action>` | `<time>` |

## Update triggers

Update this packet after task creation or reuse, task terminal state, a user correction or steering decision, idea intake/promotion, a wait result, a meaningful checkpoint, candidate promotion, and before a long wait, handoff, or turn end. Keep it compact: link stable IDs and receipts instead of copying ledgers.
