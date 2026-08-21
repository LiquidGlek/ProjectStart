# Project Agent Rules

Every task reads `AGENTS.md`; `PROJECT_STATE.md`; the outcome and user-intent sections of `PROJECT_CHARTER.md`; the Primary Outcome Lock and assigned rows in `MASTER_CHECKLIST.md`; the task registry/ownership rows in `COORDINATION_BOARD.md`; and its own checklist. The Project Director also reads `PRIOR_ART_RESEARCH.md`, `PROJECT_PLAN.md`, `TEAM_OPERATING_MODEL.md`, and `AGENT_COMMUNICATION.md` completely. Read other controls only when they apply: `VISUAL_PROTOCOL.md` for reference-driven work, `RUNTIME_OWNERSHIP.md` before shared runtime mutation, `INTEGRATION_CONTRACTS.md` for shared seams/workspaces, `RESOURCE_BUDGET.md` for retries/processes or user interference, `TIMEBOX_PROTOCOL.md` at deadline checkpoints, `FOCUS_PROTOCOL.md` on drift/test decisions, and evidence/decision ledgers when writing or reviewing those records.

## Truth and authority

- The user's latest explicit direction controls. Put it into the project documents; do not leave it only in chat.
- Record every user correction immediately as `CORR-###` in `DECISION_LOG.md`, add it to affected task checklists, and acknowledge the replacement behavior before continuing. Context compaction, task restart, or later planning may not erase it.
- At the start of every user turn, classify new content as a current requirement, correction, decision, acceptance evidence, exploratory brainstorming, or ordinary discussion and persist durable items before resuming affected work. “Do this now” and corrections are active; “could/maybe/what if/should we” is `IDEA-###` backlog by default.
- At every user turn and after context compaction, restart, or handoff, rehydrate `PROJECT_STATE.md` from the Primary Outcome Lock, active corrections, registry, board, task read-backs, and latest explicit user direction before scheduling, editing, creating tasks, or waiting.
- `MASTER_CHECKLIST.md` is the completion authority. Agent checklists inherit its rows and may add detail, but cannot narrow, merge away, defer, reword, or check a master promise.
- The coordinator schedules and verifies. The coordinator cannot waive user approval, external verification, safety, or evidence requirements.
- Report only observed results. Use `NOT RUN`, `PARTIAL`, `FAIL`, or `BLOCKED` when that is the truth.

## Before editing

1. Inspect the real project root, branch, HEAD, dirty state, and nearest instructions.
2. Claim a lane and exact file/region ownership on `COORDINATION_BOARD.md`.
3. Create your own checklist from `AGENT_CHECKLIST_TEMPLATE.md`.
4. Link every assigned row to exact master IDs and define exit evidence.
5. Record exclusions and overlapping owners. Do not edit until collisions are resolved.
6. Synthesize user intent in `PROJECT_CHARTER.md` before research: separate explicit requirements, mockup implications, category expectations, and labeled agent inferences; record anti-intent and resolve only material ambiguity with the user.
7. Before choosing architecture or writing production code, complete the bounded prior-art/reuse decision in `PRIOR_ART_RESEARCH.md` unless the Director has already supplied an accepted brief for your lane.
8. Derive detailed master rows and task checklists from the accepted `PROJECT_PLAN.md`. Before that plan exists, keep only a tiny bootstrap checklist for inspection, intent synthesis, research, planning, and checklist derivation.

## While working

- Treat the master checklist's **Primary Outcome Lock** as the current mission. Do not replace it with adjacent polish, refactors, extra tests, or “related improvements.”
- Reuse proven components, data, formulas, and patterns when their license, maintenance state, correctness, and fit are verified. Research is timeboxed and must end in a specific `REUSE`, `ADAPT`, `LEARN`, or `BUILD` decision.
- During prior-art research, identify table-stakes workflows a reasonable user expects from this product category. Map each to a master row, a concrete intentional exclusion, or a genuine not-applicable decision; do not omit it merely because the user did not spell it out.
- Translate audience, occasion, relationship, emotional language, private/public delivery, and “polish” into observable product, personalization, packaging, first-launch, and reliability criteria. Label derived signing or release decisions as facts or inferences.
- Competitive feature research authorizes functional learning only. Do not copy proprietary code, assets, branding, wording, or protected expression. Verify exact open-source license and distribution obligations before reuse.
- Attempt the exact acceptance journey early enough to expose the real blocker. A test suite is not proof that the requested button, command, or workflow works.
- For existing behavior, attempt or reproduce the journey before the first production edit whenever safe; otherwise use the earliest runnable slice and never admit more than one implementation slice or a release candidate without a direct attempt or evidenced prerequisite.
- Before implementing a critical journey that mutates persistent/shared state or causes external effects, require its accepted transaction contract: authority, transitions, owned delta, read-back, commit, recovery/idempotency, and external-effect ordering.
- Add newly discovered requirements or defects to your checklist immediately and propose a master row when project scope is affected.
- Add every exploratory user idea and agent-generated enhancement to the `MASTER_CHECKLIST.md` brainstorm backlog and affected task checklists immediately. Until promoted by explicit direction/`DEC-###` into a stable master row, do not research, implement, test, create a task for, interrupt current work for, or count it toward completion.
- When table-stakes behavior is unexpectedly absent or a product-level claim is false, invalidate dependent evidence and run one bounded sibling-risk check across the related capability family and transaction-contract impact map before fixing it.
- Re-read active correction IDs at every checkpoint. Repeating a corrected mistake triggers the drift alarm and adversarial self-audit plus a stronger guardrail.
- Make small, coherent vertical slices. Preserve unrelated work.
- Do not cross another agent's ownership boundary, stop its processes, reuse its ports, or rewrite its files without a recorded transfer.
- Keep status current after a meaningful checkpoint, blocker, ownership change, or evidence result. Avoid empty heartbeat chatter.
- Continue safe disjoint work when one row is blocked.
- Keep one current vertical slice. Before adding or rerunning a test, state which checklist row it proves and what decision its result can change.
- Do not create tiny tests for already-proven implementation details. Run focused checks while forming a slice and broader checks only at a coherent integration/release checkpoint.
- After two failed approaches or three meaningful checkpoints without movement on the primary outcome, trigger the drift alarm in `FOCUS_PROTOCOL.md`: stop expanding scope, preserve evidence, diagnose the exact blocker, and escalate it to the coordinator.
- If two successive candidates fail the same primary journey, trigger the separate two-candidate circuit breaker even when the immediate defects differ: freeze new versions, packaging, installation, and symptom patches until the full failure chain, missing invariant, sibling impacts, transaction contract, repaired plan, and required independent review are complete.
- When a deadline exists, record it with timezone and follow `TIMEBOX_PROTOCOL.md`. Cut optional scope as time closes; never cut the locked outcome, safety, approvals, or the evidence required for the claim.
- When a mockup or visual reference controls the work, follow `VISUAL_PROTOCOL.md`: measure it, build the real-control skeleton, render at the exact state/viewport, and obtain skeleton approval before feature implementation.
- When several agents are useful, follow `TEAM_OPERATING_MODEL.md`. The Project Director assigns proportionate, non-overlapping lanes and keeps routine coordination away from the user.
- Before delegation, classify the work. Any lane that owns a master ID, production file/system, runtime, checklist, deadline, evidence gate, cross-task communication, implementation, QA, visual audit, integration, release, or durable handoff must be a separate top-level Codex task created with `create_thread`, never `spawn_agent`.
- `spawn_agent` is allowed only for one-shot temporary support inside an existing top-level task when it owns no project lane, production target, master ID, checklist, deadline, runtime, or independent approval. If uncertain, classify the work as a durable lane, then reuse its valid registered top-level task or create one only if none exists; do not make a duplicate.
- If `create_thread` is unavailable or fails, mark the proposed lane `BLOCKED`; do not substitute a subagent, nested agent, or unrecorded Director implementation.
- Every top-level task must know the Director deeplink and be registered in `AGENT_COMMUNICATION.md` with its exact returned task ID/deeplink before cross-task work begins.
- Before `create_thread`, reconcile the stable lane ID against the communication registry and exact task state. Reuse the valid existing task across slices/candidates/reviews. Create a replacement only for a recorded absent/misconfigured/irrecoverable/duplicate/superseded/stopped task, and record old/new IDs and reason.
- A created or resumed task performs startup verification first and reports exact ID/deeplink, actual model/effort, actual project/root/worktree, checklist, and status. Intended launch settings are not proof; a mismatch stops substantive work and requires safe archive/replacement.
- Before every wait, compute the ready independent lane set. Launch or resume every ready lane before waiting; if two or more are ready, they work simultaneously. Monitor 2–8 active lanes in one multi-target wait and replenish the ready set after a terminal/blocking event. A single-target wait is allowed only when exactly one non-Director lane is legitimately ready with target `1`. Never single-target-wait while another ready lane is idle/uncreated, and never invent filler concurrency.
- Archive stopped, duplicate, superseded, terminal, or misconfigured tasks only after reconciling handoff, dirty/unintegrated work, and task-owned processes, then verify and record the archive receipt. Do not archive a blocked, waiting, idle, or reusable task merely as “unused.”
- Work autonomously inside assigned master IDs, ownership, interfaces, and authority. Do not request approval for ordinary reversible local implementation or proportional checks.
- Shared installed apps, runtime configuration, ports, accounts, devices, and acceptance candidates require an active owner in `RUNTIME_OWNERSHIP.md`. Without a lock, remain read-only or use an isolated sandbox.
- When an out-of-lane runtime mismatch appears, record and route it. Do not fix it unless the Director transfers exact ownership.
- In `SOLO` mode, the Director may also implement, package, and operate the narrow lane, but may not self-approve required QA or visual evidence. In team modes, the Director normally owns no production files and does not become the primary implementer, packager, or runtime operator.
- An installed candidate freeze protects exact installed bytes and runtime state; it does not freeze source development in isolated workspaces. Use `INTEGRATION_CONTRACTS.md` for shared seams.
- Obey `RESOURCE_BUDGET.md`. Usage and disk are generally acceptable; do not materially interfere with the user or another task. Renamed retries still count against one whole-path focus budget.
- A user pause, stop, or no-model instruction interrupts implementation immediately. Reconcile task-owned processes and report them before any new work.
- Do not commit, push, publish, deploy, install, delete, purchase, message externally, or change credentials unless the user or project charter explicitly authorizes it.

## Evidence and completion

- A row is `[x]` only when its stated exit proof exists at the required evidence class.
- Source proves source. Tests prove modeled behavior. A build proves compilation. Rendered, installed, physical, account, public, accessibility, security, and human claims require their matching evidence.
- Put durable proof in `EVIDENCE_LEDGER.md` and cite its `EV-###` ID from checklists.
- Separate implemented progress from verified progress.
- Report critical/high defects separately; percentages cannot outweigh a release blocker.
- Classify candidates as `DEVELOPMENT`, `DIAGNOSTIC`, `INTEGRATION`, `RELEASE CANDIDATE`, or `RELEASED`. Require promotion justification before packaging/versioning, and scope every “healthy,” “stable,” “ready,” or “complete” claim; overall product/release health cannot exceed the weakest required Critical row.
- Project status leads with whole-product capability, missing major outcomes, current user-directed priority, weakest Critical row, running/target concurrency, and next launch wave before component or QA detail.
- An agent marks its row `READY FOR REVIEW`; only the coordinator marks the corresponding master row verified.
- No project is complete while a required master row is open, partial, blocked, contradicted, weakly evidenced, or awaiting approval.

## Required handoff

Every handoff states exact files inspected/changed, commands and results, evidence IDs, remaining risks, `NOT RUN` gates, unrelated changes preserved, and the next safe action. A successor must be able to continue without chat history.
