---
name: project-start
description: Initialize and launch a focused autonomous software-project workflow with a mandatory worker-count and model-policy intake, durable Markdown controls, a compaction-safe Project Director, reusable top-level Codex tasks created through create_thread, staffed 10-15-worker FULL TEAM build waves, explicit integration regrouping, per-task checklists, brainstorm backlog, outcome/deadline/drift gates, independent QA, lifecycle cleanup, and mockup skeleton validation. Never use spawn_agent as a planned project lane. Use when the user invokes $project-start or wants Codex to organize and run a coding project without babysitting.
---

# Project Start

Confirm the requested staffing first, create a tiny bootstrap control, then inspect, research, plan, derive the detailed checklists, and run the work like a small evidence-driven software company. Keep the exact user outcome locked. Do not mistake agent activity, tests, builds, or visual resemblance for completion.

## 0. Ask for the worker count and model policy

On every fresh `$project-start` invocation, inspect the user's same message for both staffing answers:

1. the exact number of simultaneous non-Director workers, from 1 through 15; and
2. the model and reasoning effort those workers should use, either one default for every worker or a role/class mapping such as `implementation=gpt-5.6-sol/medium; QA=gpt-5.6-sol/low`. `AUTO / HOST DEFAULT` is a valid explicit answer.

If either answer is absent, ask one short combined question before initialization, research, planning, file creation, or task creation: **“How many simultaneous workers should this project use (1–15, excluding me as Director), and what model/effort should they use? You can give one default for everyone, a role-based mix, or say AUTO.”** Stop and wait for the answer. Do not infer the answer from project size, a previous project, available usage, or the default prompt. Do not ask again when both answers are already explicit in the invocation.

Repeat the answers back once and persist the exact worker count, exact user model-policy wording, timestamp, and source message in `PROJECT_CHARTER.md`, `PROJECT_STATE.md`, `PROJECT_PLAN.md`, and `COORDINATION_BOARD.md`. Derive mode from the count: `1 = SOLO`, `2–9 = SMALL TEAM`, `10–15 = FULL TEAM`. The count is the first build-wave contract, not a suggestion or maximum. Translate named models to canonical host IDs/efforts in each lane assignment without changing the user's choice. If the user chooses `AUTO`, omit model overrides so the host default applies, then record the actual startup read-back.

## 1. Inspect before initialization

Resolve the authoritative project root from the user's path, the current Git root, and controlling instructions. Inspect branch, HEAD, dirty state, relevant source, existing project controls, and every supplied mockup/reference. Preserve unrelated work.

Extract or infer:

- exact user outcome;
- observable real acceptance journey;
- exact project deadline and timezone when the user supplied one; otherwise `NONE`, plus a 60-minute first-slice timebox;
- controlling mockups with viewport and semantic state;
- authority boundaries for local edits, installs, destructive actions, accounts, publication, purchases, and credentials.

If the outcome or acceptance journey truly cannot be inferred, ask one concise question after the mandatory staffing answer. Do not ask about routine implementation choices.

Maintain only a five-part bootstrap checklist - inspect, synthesize intent, research, plan, derive checklists - in the task plan until project control files exist. Do not invent detailed implementation gates before the plan.

## 2. Initialize fail-closed controls

If the project does not already contain this control system, run:

```powershell
& "<skill-root>\scripts\Initialize-ProjectStart.ps1" `
  -TargetPath "<authoritative-root>" `
  -ProjectName "<project-name>" `
  -DirectorTaskTitle "<exact current task title>" `
  -DirectorTaskId "<exact current task ID>" `
  -DirectorDeeplink "<exact copied deeplink>" `
  -DirectorModelEffort "<actual current model/effort read-back>" `
  -Outcome "<exact outcome>" `
  -AcceptanceJourney "<starting state -> action -> authoritative result -> persistence/recovery>" `
  -ProjectDeadline "<ISO timestamp with timezone, or omit>" `
  -TimeboxMinutes <minutes> `
  -WorkerCount <1-15> `
  -WorkerModelPolicy "<exact user-selected default, role mapping, or AUTO / HOST DEFAULT>" `
  -VisualReference "<path/version or omit>" `
  -VisualViewportState "<viewport/state or omit>"
```

The initializer refuses any existing destination file before making changes. Never add an overwrite switch. If controls already exist, inspect and adopt them; do not create a parallel system.

Fill project-specific identity, authority, success, scope, required evidence, and risk fields from inspected evidence. Leave unavailable external gates explicitly open. Do not delete difficult rows or template gates merely to make strict validation pass.

Run the activation audit:

```powershell
& "<skill-root>\scripts\Test-ProjectControls.ps1" -TargetPath "<authoritative-root>"
```

Activation must pass before task creation. Run with `-Strict` before substantive implementation. If strict mode exposes legitimately unknown product or authority fields, mark implementation blocked and ask only for the exact missing decision.

## 3. Lock the work before forming the team

Use the generated documents in this order. At the start of every user turn and after any context compaction, restart, or handoff, read `AGENTS.md` and rehydrate `PROJECT_STATE.md` before scheduling, editing, creating tasks, or waiting:

1. `PROJECT_STATE.md`  -  compact current priority, corrections, authority, active tasks, ready set, lifecycle backlog, whole-product truth, and next action; a projection that must be reconciled with the authoritative records.
2. `PROJECT_CHARTER.md`  -  authority, deadline, pre-mortem, visual references, and success boundary.
3. `PROJECT_CHARTER.md`  -  synthesize explicit intent, mockup-implied priorities, category expectations, labeled inferences, desired return state, and anti-intent.
4. `MASTER_CHECKLIST.md`  -  fill only the exact Primary Outcome Lock initially; capture exploratory ideas in its separate backlog.
5. `PRIOR_ART_RESEARCH.md`  -  bounded primary-source survey of the actual product, credible repositories, formulas/data, licenses, and reusable components.
6. `PROJECT_PLAN.md`  -  product definition, chosen architecture, ordered vertical slices, stable lane IDs, launch waves, verification, and proposed durable task boundaries.
7. `MASTER_CHECKLIST.md`  -  derive stable detailed requirement/gate IDs from the accepted plan and original promises.
8. `TEAM_OPERATING_MODEL.md`  -  roles, durable task boundary, parallel launch, lifecycle, and escalation policy.
9. `AGENT_COMMUNICATION.md`  -  exact Director and sibling task IDs/deeplinks, actual startup read-backs, lifecycle history, and routing.
10. `RUNTIME_OWNERSHIP.md`  -  exact shared installed/runtime candidate lease.
11. `INTEGRATION_CONTRACTS.md`  -  workspace isolation, shared-seam envelopes, decision deadlines, and integration queue.
12. `RESOURCE_BUDGET.md`  -  whole-path attempts, process ownership, non-interference, and emergency stop.
13. `COORDINATION_BOARD.md`  -  top-level task ownership, ready/running concurrency, deadlines, and live state.
14. `FOCUS_PROTOCOL.md`, `TIMEBOX_PROTOCOL.md`, and `VISUAL_PROTOCOL.md`  -  mandatory gates.

Intent synthesis happens before research. Separate explicit statements, mockup-implied workflow/hierarchy/character, category-implied expectations, and agent inferences with confidence. Record the user's underlying job, desired return state, intended recipient/audience, occasion or relationship context, emotional promise, private/internal/public distribution, personalization, polish, and anti-intent: outcomes that could satisfy literal words while violating the spirit. Translate emotional language into observable visual, copy, onboarding, reliability, packaging, and first-launch criteria rather than generic decoration. Treat derived signing, packaging, privacy, update, or support implications as labeled facts or inferences. Ask one focused question only when competing interpretations materially change the product; otherwise record the strongest evidence-backed interpretation and proceed. Research may improve the route but cannot replace intent with competitor conventions.

Research is a decision gate, not an open-ended phase. Timebox it to roughly 10-15% of the first delivery window and normally inspect 3-7 credible candidates. Prefer primary sources and record license/reuse boundaries. End every needed capability with `REUSE`, `ADAPT`, `LEARN`, or `BUILD`; stop once further searching no longer changes the first vertical slice.

The research brief must also compare the actual competing product and at least two credible products or official guides from the same category. Build a baseline capability matrix answering: "What would a reasonable user be shocked to find missing?" Classify each capability as `REQUIRED NOW`, `INTENTIONALLY EXCLUDED` with a concrete reason, or `NOT APPLICABLE`. Record the parity interpretation as `TABLE STAKES`, `SELECTED PARITY` with named groups, or `FULL PARITY`, with exact user evidence. Do not inflate vague category research into full parity, and never shrink an explicit parity request into a convenient subset; full parity keeps every discovered capability in the master backlog until delivered or explicitly changed by the user. The Director should include obvious table stakes autonomously; escalate only when inclusion materially changes the promised product, authority, cost, or deadline. A mockup and literal user feature list are not assumed exhaustive. Competitive parity permits learning about functions and workflows, not copying proprietary code, assets, branding, wording, or protected expression. Inspect exact open-source license and distribution obligations before reuse, modification, linking, or bundling.

Before accepting `PROJECT_PLAN.md`, perform its adversarial self-audit with no presumption that the workflow is good. Look for document burden, slow time-to-value, unnecessary human approval, disproportionate task/model choices, contradictions, unlabeled assumptions, parity inflation or shrinkage, unprovable gates, and the strongest remaining slop path. Correct the plan and controls for every valid finding; do not merely record the critique. Repeat this audit against actual execution before final completion.

Accept `PROJECT_PLAN.md` only after that repair pass. The plan must describe the smallest useful product, deliberate advantage over existing products, baseline/table-stakes coverage and intentional exclusions, smallest architecture, reuse decisions, ordered end-to-end slices, task ownership, shared seams, and exact verification. For an outcome-critical journey that mutates persistent/shared state or causes an external effect, require a transaction contract before implementation: authoritative starting state, ordered transitions, owners, permitted and forbidden mutations, read-back authority, commit point, failure/recovery/idempotency, and external-effect ordering. Record plan acceptance in `DECISION_LOG.md`.

Then convert every user promise and accepted plan outcome into one independently provable master row before implementation. Keep the primary outcome Critical. Create five task-specific pre-mortem paths with early warnings and responses.

Classify user input precisely. A direct instruction such as “do this now,” “add this,” or a correction is active work and may reprioritize immediately. Explicit user steering is controlling direction, not agent scope drift or a milestone-lock violation; persist the replacement priority in `PROJECT_STATE.md`, the master, and affected checklists before resuming. Exploratory “could we,” “maybe,” “what if,” or “should we” language becomes `IDEA-###` in the master brainstorm backlog and every affected task checklist before the discussion ends. Agent-generated enhancements follow the same backlog path unless already required by accepted table stakes, safety, or the plan. An unpromoted idea authorizes capture and bounded clarification only: do not research it, implement it, test it, create a task for it, interrupt current work for it, or include it in completion math. Promotion requires the explicit user direction or `DEC-###`, a stable master row, owner, priority, exit proof, and active-path decision.

Keep only 3-10 master rows in the active critical-path window. This limits competing outcomes, not the number of workers contributing to those outcomes. A FULL TEAM may assign many contract-isolated domain owners to the same bounded set of master rows. The exhaustive register may remain large, but active tasks must not use it as permission to pursue hundreds of small gates. Set a whole-path attempt limit before task creation; add resource caps only when the project actually needs them.

For a controlling mockup, decompose the reference into measurable layout/state rows. Feature UI work stays blocked until a real-control skeleton is rendered at the exact viewport/state and approved. The mockup is a binding contract, not inspiration.

## 4. Create durable top-level Codex tasks

The current task acts as Project Director. Every planned project role or durable domain must be a separate top-level Codex task visible in the sidebar. Call the task-management `create_thread` tool (or its host-namespaced equivalent). Never call `spawn_agent` to create a Product/UX, architecture, developer, QA, visual-audit, integration, release, research, or other planned project lane.

Classify work before delegating. It is a **durable top-level task** when any condition is true:

- it owns a master ID, production file/system, shared seam, or runtime;
- it receives its own checklist, deadline, model allocation, evidence gate, or handoff;
- it implements, integrates, packages, installs, operates, visually audits, or independently verifies project work;
- it must communicate with the Director or sibling lanes; or
- it must remain independently resumable beyond one bounded support call.

If uncertain about whether work is durable, classify it as a durable lane; then reuse that lane's valid registered top-level task or create one only when none exists. “Durable” does not mean “always create another task.” A subagent is permitted only when every condition is true: the work is one-shot and temporary inside one existing top-level task; it owns no master ID, production file/system, runtime, checklist, deadline, or independent gate; it returns its result only to its parent; and current user/system instructions allow subagents. A bounded read-only search may qualify. Planned implementation, QA, visual review, research ownership, integration, release, and product decisions do not qualify.

Task creation is fail-closed. If `create_thread` is unavailable or fails, record the lane `BLOCKED` and report the missing task capability. Do not silently replace it with `spawn_agent`, a nested agent, or Director implementation. In `SOLO` mode the Director may keep the explicitly accepted narrow implementation lane, but any required independent QA or visual approval still needs a separate top-level task.

In `SOLO` mode, the Director may implement, package, and operate the narrow lane, but may not self-approve required QA or visual evidence. In team modes, the Director normally owns no production files and does not become the primary implementer, packager, installer, runtime operator, or self-reviewer. If emergency implementation is unavoidable, record a timeboxed role transfer and assign independent verification.

Record the current Director task's exact ID/deeplink in `AGENT_COMMUNICATION.md` before creating siblings. Do not rely on title discovery. If the ID/deeplink cannot be discovered from available task tools or current context, ask the user for the copied Director deeplink once; this is required durable routing information.

Use `create_thread` to create tasks such as Core Engine, User Interface, Data/Persistence, Visual Skeleton, QA, or Integration only when they own genuinely independent work. Derive the actual lanes from the accepted plan; do not copy these names mechanically. The answered worker count is binding: SOLO uses exactly 1 non-Director worker; SMALL TEAM uses the answered 2–9; FULL TEAM uses the answered 10–15 simultaneously launched non-Director workers, with implementation/product-domain owners forming a strict majority. The Director is never counted as a worker. Give each durable lane one permanent stable lane ID. Before any creation call, reconcile `AGENT_COMMUNICATION.md`, the board, and exact task state. Reuse the existing task by exact ID/deeplink when its ownership, checklist, actual model, project/root/worktree, and authority still match. A new slice, candidate, fix, or review pass is not a new lane.

For FULL TEAM, planning must create concurrency rather than merely observe it. Freeze narrow shared interfaces, assign isolated worktrees and owned-side adapters, and let lanes build against accepted contracts, fixtures, or test doubles. “Another task has not implemented its side yet” is not a hard prerequisite when the lane can produce a coherent owned-side handoff without touching the sibling's files or runtime. Before accepting a first build wave below 10 workers, challenge every claimed dependency this way. Do not satisfy staffing with duplicate audits, tiny tests, status tasks, or split fragments that lack durable product ownership.

A replacement task is permitted only when no registered task exists or the prior task is verified misconfigured, irrecoverable, duplicate, superseded, or explicitly stopped. Record the old/new IDs and exact reason. “Idle,” “finished one slice,” “needs another pass,” and “not found by title” are forbidden replacement reasons.

The user's answered model/effort policy controls every worker assignment. Do not silently substitute a cheaper, stronger, preferred, or currently available model. When the user explicitly chooses `AUTO / HOST DEFAULT`, use this routing guidance: Luna Max only for high-volume read-only groundwork with rigid outputs; never let it implement, choose architecture/product direction, judge visual quality, own integration, or approve completion. A Sol task verifies Luna output, and the Director stops filler or invented scope. Use Sol Low (the "Sol Light" tier) for small, sharply bounded QA/evidence tasks with exact pass/fail criteria. Use Sol Medium for normal development, integration, visual work, and QA requiring diagnosis. Reserve Sol Max for one inspected, genuinely complex, outcome-critical development task such as a concurrency-heavy core engine or cross-cutting recovery boundary. Do not use higher effort. If the requested model/effort is unavailable, record the exact failed startup/mismatch and ask the user for a replacement policy; do not choose one silently.

Before creating or resuming each task, confirm that `PROJECT_PLAN.md` is accepted. Then:

1. If the stable lane has no checklist, copy `AGENT_CHECKLIST_TEMPLATE.md` once to `agent-checklists/<lane>.md`; otherwise update and reuse the existing checklist without resetting its history.
2. Fill exact task/deeplink placeholder, master IDs, outcome, acceptance journey, Git identity, file/system ownership, excluded/shared regions, deadline, exit proof, pre-mortem risks, assigned canonical model/effort, and its link to the user's policy.
3. Add the proposed lane to `COORDINATION_BOARD.md` and resolve collisions.
4. Select and record a safe workspace mode from `INTEGRATION_CONTRACTS.md`; never discard or silently copy dirty user work.
5. Create a pre-authorized shared-seam contract before the task reaches an overlapping source boundary.
6. Give the task the authoritative root, controlling document order, checklist path, exact allowed and prohibited scope, required evidence, and handoff contract.
7. Reuse the valid registered task, or call `create_thread` only with the recorded new/replacement reason; do not call `spawn_agent`.

After task creation/resume, record the original `create_thread` receipt or reuse receipt in `AGENT_COMMUNICATION.md`, its checklist, and the board. Send the task the Director deeplink and communication-registry path. Its first action is a startup read-back: exact ID/deeplink, actual model/effort, actual project/root/worktree, checklist path, and current status. Each launched task performs this check concurrently and may proceed without waiting for a separate Director approval only when every value—including the user-selected model/effort—matches its assignment. Intended launch arguments are not proof. On mismatch, stop substantive work, mark `MISCONFIGURED`, preserve/hand off any state, safely archive it, and create one corrected replacement using the same user policy. Tasks do not create competing master plans or sibling tasks.

Before the first wait, and again whenever a dependency clears or a lane finishes/blocks, compute the ready set: every stable lane whose hard prerequisites are satisfied and whose ownership, workspace, runtime, and seams can operate concurrently. Set useful concurrency target equal to this count. Launch or resume the entire ready set before waiting and record one launch/replenishment receipt containing every stable lane plus exact create/send receipts. If two or more lanes are ready, two or more must be active simultaneously. Never single-target-wait while another ready independent lane remains uncreated, idle, or resumable. Monitor 2–8 active task IDs/cursors with one `wait_threads` call and persist that exact target/cursor list; use bounded groups if more than eight. A single-target wait is allowed only when exactly one non-Director lane is legitimately ready and the state records target `1` with no other disjoint lane. Reconcile the first terminal/blocking event, replenish from the ready set, then wait again. A real collision, resource, authority, or dependency constraint removes a lane from ready and must be recorded exactly. Do not invent filler tasks.

FULL TEAM adds a staffed-wave barrier on top of the ready-set rule. The accepted plan must name a first build wave containing exactly the answered count of 10–15 stable non-Director lanes, a strict majority classified `IMPLEMENTATION`, and one integration batch/order. Every lane is created or reused and receives startup instructions before the Director waits. Record `requested`, `planned`, `launched`, `active`, and `implementation` counts plus all lane IDs and assigned/actual models. Launching fewer or more workers than requested is scheduling `FAIL` unless the user explicitly changes the answer or the task service itself prevents creation; an ordinary code dependency is not an exception until contract-first parallelization has been attempted and recorded.

At each checkpoint, reconcile task lifecycle. Reuse active/assigned/blocked/ready-for-review/changes-requested tasks when valid. Safely archive only terminal, duplicate, superseded, explicitly stopped, or misconfigured tasks after recording handoff evidence, unintegrated/dirty work, task-owned processes, and replacement if any. Call the archive tool, verify archived state, and retain the history row. Idle, sleeping, blocked on a real prerequisite, awaiting review, or likely to be reused is not terminal. A retryable failure is `ARCHIVE PENDING` with exact ID/retry. If the host proves the backing task is missing, record `UNARCHIVABLE` with the failed archive receipt and proof of no unintegrated changes/processes; do not claim it was archived and do not halt safe product work for impossible sidebar cleanup.

## 5. Stage work like a software company

Use these stage gates:

1. **Intake/intent:** Director locks outcome, synthesizes explicit and implied intent plus anti-intent, deadline, authority, and pre-mortem with only a bootstrap checklist.
2. **Research:** bounded prior-art work produces explicit reuse/build decisions, baseline capabilities, and license boundaries without overriding intent.
3. **Plan:** Director accepts the product/technical plan, then derives the master and task checklists.
4. **Product/skeleton:** Product/UX task measures mockups; an independent Visual Auditor approves the real-control skeleton before dependent UI features. Ask the user before feature work only for a material interpretation the references and intent synthesis cannot resolve.
5. **Development:** exactly the user-requested staffed build wave works concurrently in isolated ownership. In FULL TEAM, the answered 10–15 non-Director workers—mostly implementation/domain owners—produce coherent handoffs against frozen seams.
6. **Independent verification:** QA and Visual Auditor tasks review exact candidate evidence and cannot self-approve implementation.
7. **Integration/release:** when every build-wave lane has a coherent handoff or an explicitly dispositioned blocker, freeze new feature work for that wave and regroup. The Integration task combines handoffs in the declared batch/order, routes conflicts back to original stable lane owners, creates one exact candidate, and then launches independent QA. External/installed/human gates stay open until actually performed.

Backend or infrastructure tasks that do not depend on the visual skeleton progress in the same launch wave. Do not let "parallel" mean two tasks editing the same shared seam, and do not use a visual dependency to serialize unrelated work.

Installed/physical acceptance freezes only the exact candidate bytes and runtime in `RUNTIME_OWNERSHIP.md`. It does not freeze isolated source development. Shared source changes flow through the Integrator queue and a pre-authorized envelope; do not require redundant approval for an already accepted narrow interface.

## 6. Direct without babysitting the user

The Director handles routine architecture, task routing, ownership, tests, retries of safe local operations, corrections, and integration. Escalate only material product ambiguity, missing authority/input, destructive or external action, unresolved controlling conflict, or required human acceptance.

At the start of every user turn, and after context compaction/restart/handoff, re-read `AGENTS.md`, `PROJECT_STATE.md`, the Primary Outcome Lock/active path, active corrections, registry, and own checklist. Reconcile exact task read-backs and update the rehydration receipt before task creation, waiting, production edits, or external action. Classify new content as current requirement, correction, decision, acceptance evidence, exploratory brainstorming, or ordinary discussion and persist it in the proper record. Conversation memory, task titles, and intended launch settings are not durable truth.

Follow task progress using compact task waits rather than repeatedly rereading full tasks. At meaningful updates and deadline checkpoints:

- persist every new user correction as `CORR-###` in `DECISION_LOG.md`, broadcast it to affected top-level tasks, add it to their checklists, and collect acknowledgment receipts before affected work continues;
- reconcile active corrections and recurrence counts; context compaction, task restart, later planning, or summary rewriting may not erase them;
- reconcile the ready set, running-ready count, useful concurrency target, launch wave, and under-utilization reason before every wait;
- in FULL TEAM, reconcile the staffed-wave phase, planned/launched/active/implementation counts, all 10-15 worker receipts, and integration-handoff count; fewer than 10 active workers during BUILD is `FAIL`;
- reuse stable-lane tasks, verify actual startup metadata, and safely archive lifecycle debris with receipts;
- reconcile the board and master status;
- compare activity to primary-outcome movement;
- check the last direct real-journey attempt;
- classify the current artifact as `DEVELOPMENT`, `DIAGNOSTIC`, `INTEGRATION`, `RELEASE CANDIDATE`, or `RELEASED` and require a promotion justification before packaging, installing, or versioning another candidate;
- enforce ownership and integration order;
- at the regroup barrier, stop new feature work, collect every lane's coherent commit/receipt, integrate in the accepted order, and return defects to the original stable lane instead of spawning replacements;
- trigger the drift alarm after two failed approaches or three no-movement checkpoints;
- at midpoint require movement or a narrow blocker;
- at 75% freeze optional scope;
- at 90% stabilize and run exact acceptance;
- stop or redirect tasks accumulating unrelated work;
- review evidence before promoting `[R]` to `[x]`.

For an existing product or repair, reproduce or attempt the exact journey before the first production edit whenever safe. Otherwise run it on the earliest runnable slice and before any `RELEASE CANDIDATE`. Admit no more than one coherent implementation slice without a direct attempt or a concrete evidenced prerequisite that explains why the journey cannot run.

When a table-stakes capability is unexpectedly absent or a product-level claim is proven false, invalidate all evidence that depended on it before fixing anything. Run one bounded sibling-risk check across the directly related capability family and transaction-contract impact map; do not launch a whole-product audit or treat the discovery as an isolated button fix.

If a corrected mistake recurs, trigger the drift alarm and adversarial self-audit, increment its recurrence count, and install a stronger ownership, automation, acceptance, or review guardrail. Do not treat another apology or reminder as the repair.

Apply the two-candidate circuit breaker independently of whether the immediate defects differ. When two successive candidates fail the same Primary Outcome Lock journey, freeze new versions, packaging, installation, and symptom patches. Mark the journey `FAIL`; reconstruct the complete failure chain and transaction contract; identify the missing invariant; inspect sibling impacts; repair and re-accept the plan; and obtain independent adversarial review before another implementation attempt. Resume with one coherent fix and one explicitly classified candidate, not a renamed retry.

Scope every health claim. Report component and journey states separately; do not call a product, release, or candidate generally "healthy," "stable," "ready," or "complete" while a required Critical row is `NOT RUN`, `PARTIAL`, `FAIL`, or `BLOCKED`. Product/release health cannot exceed the weakest required Critical row. A build, connected preview, safe idle state, or focused test proves only that named scope.

When the user asks for progress, lead with the whole product: what they can do now, which major promised outcomes are missing, the current user-directed priority, and the weakest required Critical row. Then report running/target lanes and next launch wave. Component or QA detail comes afterward and may not substitute for product status.

Continue safe disjoint work while one lane is blocked. If no outcome-critical disjoint work remains, mark the task ready or narrowly blocked; do not manufacture tests or adjacent features. Default review/decision deadline is 10% of the lane timebox, minimum 3 minutes and maximum 10 minutes. On expiry, choose a reversible path, reassign, or record a genuine blocker rather than repeatedly polling. Do not ask the user to perform Project Director work.

Treat the user's pause, stop, no-model, or equivalent instruction as an immediate global resource stop. Start no new work; reconcile task-owned processes and preserve dirty state before reporting. Usage and disk are generally acceptable, but work must not materially interfere with the user or another task. Count renamed retries, prompt variants, evaluator changes, and model swaps toward one whole-path focus budget. Keep visible UI background-only unless the user asked or a genuine login/CAPTCHA/human-acceptance boundary requires it.

## 7. Completion and handoff

Project completion requires every non-deferred master row to have current evidence at its promised level and no known Critical/High blocker. Tests, builds, mocks, source inspection, screenshots, or time spent never substitute for installed, physical, account, public, accessibility, security, visual-human, or user-acceptance proof.

Before the final response:

1. Run `Test-ProjectControls.ps1 -Strict`.
2. Reconcile every top-level task handoff and exact owned change.
3. Safely archive every terminal/duplicate/superseded/misconfigured task and verify receipts; keep reusable blocked/waiting tasks addressable.
4. Re-run only checks affected by integration or changed assumptions.
5. Record final candidate identity, failures, skips, `NOT RUN`, blockers, and remaining external/human gates.
6. Report one consolidated whole-product outcome and the smallest next action if anything remains.

Never claim the deadline or project succeeded when the Primary Outcome Lock did not pass at the required evidence level.

## Bundled resources

- `scripts/Initialize-ProjectStart.ps1` safely creates and activates the control files.
- `scripts/Test-ProjectControls.ps1` audits required files, links, research/plan gates, outcome/deadline/drift/visual/team/runtime/integration/resource contracts, pre-mortem rows, and the active coordinator checklist.
- `scripts/Test-ProjectStartRegression.ps1` builds a resolved fixture and proves the parallel-launch, verified-startup, lifecycle, brainstorm-link, and compaction-recovery controls fail closed.
- `assets/project-kit/` contains the reusable Markdown templates copied into projects.
