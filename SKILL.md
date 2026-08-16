---
name: project-start
description: Initialize and launch a focused, autonomous software-project workflow with durable Markdown controls, a Project Director, separate top-level Codex tasks created through create_thread for every durable product domain, per-task checklists, outcome/deadline/drift gates, independent QA, and mockup-to-real-control skeleton validation. Never use spawn_agent as a substitute for a planned project task. Use when the user invokes $project-start or asks Codex to start, organize, or autonomously run a new or existing coding project without babysitting, especially when multiple project tasks, a visual reference, or a strict deadline are involved.
---

# Project Start

Create a tiny bootstrap control first, then inspect, research, plan, derive the detailed checklists, and run the work like a small evidence-driven software company. Keep the exact user outcome locked. Do not mistake agent activity, tests, builds, or visual resemblance for completion.

## 1. Inspect before initialization

Resolve the authoritative project root from the user's path, the current Git root, and controlling instructions. Inspect branch, HEAD, dirty state, relevant source, existing project controls, and every supplied mockup/reference. Preserve unrelated work.

Extract or infer:

- exact user outcome;
- observable real acceptance journey;
- exact project deadline and timezone when the user supplied one; otherwise `NONE`, plus a 60-minute first-slice timebox;
- controlling mockups with viewport and semantic state;
- authority boundaries for local edits, installs, destructive actions, accounts, publication, purchases, and credentials.

If the outcome or acceptance journey truly cannot be inferred, ask one concise question. Do not ask about routine implementation or team choices.

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
  -Outcome "<exact outcome>" `
  -AcceptanceJourney "<starting state -> action -> authoritative result -> persistence/recovery>" `
  -ProjectDeadline "<ISO timestamp with timezone, or omit>" `
  -TimeboxMinutes <minutes> `
  -TeamMode "<SOLO|SMALL TEAM|FULL TEAM>" `
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

Use the generated documents in this order:

1. `PROJECT_CHARTER.md`  -  authority, deadline, pre-mortem, visual references, and success boundary.
2. `PROJECT_CHARTER.md`  -  synthesize explicit intent, mockup-implied priorities, category expectations, labeled inferences, desired return state, and anti-intent.
3. `MASTER_CHECKLIST.md`  -  fill only the exact Primary Outcome Lock initially.
4. `PRIOR_ART_RESEARCH.md`  -  bounded primary-source survey of the actual product, credible repositories, formulas/data, licenses, and reusable components.
5. `PROJECT_PLAN.md`  -  product definition, chosen architecture, ordered vertical slices, verification, and proposed durable task boundaries.
6. `MASTER_CHECKLIST.md`  -  derive stable detailed requirement/gate IDs from the accepted plan and original promises.
7. `TEAM_OPERATING_MODEL.md`  -  roles, durable task boundary, and escalation policy.
8. `AGENT_COMMUNICATION.md`  -  exact Director and sibling task IDs/deeplinks and routing.
9. `RUNTIME_OWNERSHIP.md`  -  exact shared installed/runtime candidate lease.
10. `INTEGRATION_CONTRACTS.md`  -  workspace isolation, shared-seam envelopes, decision deadlines, and integration queue.
11. `RESOURCE_BUDGET.md`  -  whole-path attempts, process ownership, non-interference, and emergency stop.
12. `COORDINATION_BOARD.md`  -  top-level task ownership, deadlines, and live state.
13. `FOCUS_PROTOCOL.md`, `TIMEBOX_PROTOCOL.md`, and `VISUAL_PROTOCOL.md`  -  mandatory gates.

Intent synthesis happens before research. Separate explicit statements, mockup-implied workflow/hierarchy/character, category-implied expectations, and agent inferences with confidence. Record the user's underlying job, desired return state, intended recipient/audience, occasion or relationship context, emotional promise, private/internal/public distribution, personalization, polish, and anti-intent: outcomes that could satisfy literal words while violating the spirit. Translate emotional language into observable visual, copy, onboarding, reliability, packaging, and first-launch criteria rather than generic decoration. Treat derived signing, packaging, privacy, update, or support implications as labeled facts or inferences. Ask one focused question only when competing interpretations materially change the product; otherwise record the strongest evidence-backed interpretation and proceed. Research may improve the route but cannot replace intent with competitor conventions.

Research is a decision gate, not an open-ended phase. Timebox it to roughly 10-15% of the first delivery window and normally inspect 3-7 credible candidates. Prefer primary sources and record license/reuse boundaries. End every needed capability with `REUSE`, `ADAPT`, `LEARN`, or `BUILD`; stop once further searching no longer changes the first vertical slice.

The research brief must also compare the actual competing product and at least two credible products or official guides from the same category. Build a baseline capability matrix answering: "What would a reasonable user be shocked to find missing?" Classify each capability as `REQUIRED NOW`, `INTENTIONALLY EXCLUDED` with a concrete reason, or `NOT APPLICABLE`. Record the parity interpretation as `TABLE STAKES`, `SELECTED PARITY` with named groups, or `FULL PARITY`, with exact user evidence. Do not inflate vague category research into full parity, and never shrink an explicit parity request into a convenient subset; full parity keeps every discovered capability in the master backlog until delivered or explicitly changed by the user. The Director should include obvious table stakes autonomously; escalate only when inclusion materially changes the promised product, authority, cost, or deadline. A mockup and literal user feature list are not assumed exhaustive. Competitive parity permits learning about functions and workflows, not copying proprietary code, assets, branding, wording, or protected expression. Inspect exact open-source license and distribution obligations before reuse, modification, linking, or bundling.

Before accepting `PROJECT_PLAN.md`, perform its adversarial self-audit with no presumption that the workflow is good. Look for document burden, slow time-to-value, unnecessary human approval, disproportionate task/model choices, contradictions, unlabeled assumptions, parity inflation or shrinkage, unprovable gates, and the strongest remaining slop path. Correct the plan and controls for every valid finding; do not merely record the critique. Repeat this audit against actual execution before final completion.

Accept `PROJECT_PLAN.md` only after that repair pass. The plan must describe the smallest useful product, deliberate advantage over existing products, baseline/table-stakes coverage and intentional exclusions, smallest architecture, reuse decisions, ordered end-to-end slices, task ownership, shared seams, and exact verification. For an outcome-critical journey that mutates persistent/shared state or causes an external effect, require a transaction contract before implementation: authoritative starting state, ordered transitions, owners, permitted and forbidden mutations, read-back authority, commit point, failure/recovery/idempotency, and external-effect ordering. Record plan acceptance in `DECISION_LOG.md`.

Then convert every user promise and accepted plan outcome into one independently provable master row before implementation. Keep the primary outcome Critical. Create five task-specific pre-mortem paths with early warnings and responses.

Keep only 3-10 master rows in the active critical-path window. The exhaustive register may remain large, but active tasks must not use it as permission to pursue hundreds of small gates. Set a whole-path attempt limit before task creation; add resource caps only when the project actually needs them.

For a controlling mockup, decompose the reference into measurable layout/state rows. Feature UI work stays blocked until a real-control skeleton is rendered at the exact viewport/state and approved. The mockup is a binding contract, not inspiration.

## 4. Create durable top-level Codex tasks

The current task acts as Project Director. Every planned project role or durable domain must be a separate top-level Codex task visible in the sidebar. Call the task-management `create_thread` tool (or its host-namespaced equivalent). Never call `spawn_agent` to create a Product/UX, architecture, developer, QA, visual-audit, integration, release, research, or other planned project lane.

Classify work before delegating. It is a **durable top-level task** when any condition is true:

- it owns a master ID, production file/system, shared seam, or runtime;
- it receives its own checklist, deadline, model allocation, evidence gate, or handoff;
- it implements, integrates, packages, installs, operates, visually audits, or independently verifies project work;
- it must communicate with the Director or sibling lanes; or
- it must remain independently resumable beyond one bounded support call.

If uncertain, create a top-level task. A subagent is permitted only when every condition is true: the work is one-shot and temporary inside one existing top-level task; it owns no master ID, production file/system, runtime, checklist, deadline, or independent gate; it returns its result only to its parent; and current user/system instructions allow subagents. A bounded read-only search may qualify. Planned implementation, QA, visual review, research ownership, integration, release, and product decisions do not qualify.

Task creation is fail-closed. If `create_thread` is unavailable or fails, record the lane `BLOCKED` and report the missing task capability. Do not silently replace it with `spawn_agent`, a nested agent, or Director implementation. In `SOLO` mode the Director may keep the explicitly accepted narrow implementation lane, but any required independent QA or visual approval still needs a separate top-level task.

In `SOLO` mode, the Director may implement, package, and operate the narrow lane, but may not self-approve required QA or visual evidence. In team modes, the Director normally owns no production files and does not become the primary implementer, packager, installer, runtime operator, or self-reviewer. If emergency implementation is unavoidable, record a timeboxed role transfer and assign independent verification.

Record the current Director task's exact ID/deeplink in `AGENT_COMMUNICATION.md` before creating siblings. Do not rely on title discovery. If the ID/deeplink cannot be discovered from available task tools or current context, ask the user for the copied Director deeplink once; this is required durable routing information.

Use `create_thread` to create tasks such as Core Engine, User Interface, Data/Persistence, Visual Skeleton, QA, or Integration only when they own genuinely independent work. Derive the actual lanes from the accepted plan; do not copy these names mechanically. Prefer the smallest effective team. Before creation, record `Creation mechanism: create_thread` in the proposed lane. After creation, record the exact returned task ID/deeplink before the lane reads, edits, tests, or coordinates project work.

Use Luna Max only for high-volume read-only groundwork with rigid outputs; never let it implement, choose architecture/product direction, judge visual quality, own integration, or approve completion. A Sol task verifies Luna output, and the Director stops filler or invented scope. Use Sol Low (the "Sol Light" tier) for small, sharply bounded QA/evidence tasks with exact pass/fail criteria. Use Sol Medium for the Director, normal development, integration, visual work, and QA requiring diagnosis. Reserve Sol Max for one inspected, genuinely complex, outcome-critical development task such as a concurrency-heavy core engine or cross-cutting recovery boundary. Do not use higher effort. Choose Max upfront when the complexity is already clear; provide it a complete plan and record the usage reason in the charter, board, and checklist. Escalate Low QA to Medium only when the inspected reasoning scope expands, not merely because a check fails. Max work still requires independent verification.

Before creating each task, confirm that `PROJECT_PLAN.md` is accepted. Then:

1. Copy `AGENT_CHECKLIST_TEMPLATE.md` to `agent-checklists/<lane>.md`.
2. Fill exact task/deeplink placeholder, master IDs, outcome, acceptance journey, Git identity, file/system ownership, excluded/shared regions, deadline, exit proof, and pre-mortem risks.
3. Add the proposed lane to `COORDINATION_BOARD.md` and resolve collisions.
4. Select and record a safe workspace mode from `INTEGRATION_CONTRACTS.md`; never discard or silently copy dirty user work.
5. Create a pre-authorized shared-seam contract before the task reaches an overlapping source boundary.
6. Give the task the authoritative root, controlling document order, checklist path, exact allowed and prohibited scope, required evidence, and handoff contract.
7. Call `create_thread`; do not call `spawn_agent`.

After task creation, record the returned task ID/deeplink and `create_thread` receipt in `AGENT_COMMUNICATION.md`, its checklist, and the board before any project work. Send the new task the Director deeplink and communication-registry path. Created tasks must read the controls, inspect their seam, and report evidence-backed movement. They do not create competing master plans or sibling tasks. A task without this receipt is unauthorized to work.

## 5. Stage work like a software company

Use these stage gates:

1. **Intake/intent:** Director locks outcome, synthesizes explicit and implied intent plus anti-intent, deadline, authority, and pre-mortem with only a bootstrap checklist.
2. **Research:** bounded prior-art work produces explicit reuse/build decisions, baseline capabilities, and license boundaries without overriding intent.
3. **Plan:** Director accepts the product/technical plan, then derives the master and task checklists.
4. **Product/skeleton:** Product/UX task measures mockups; an independent Visual Auditor approves the real-control skeleton before dependent UI features. Ask the user before feature work only for a material interpretation the references and intent synthesis cannot resolve.
5. **Development:** separate top-level developer tasks deliver narrow vertical slices in non-overlapping ownership.
6. **Independent verification:** QA and Visual Auditor tasks review exact candidate evidence and cannot self-approve implementation.
7. **Integration/release:** Integration task owns shared seams and candidate identity; external/installed/human gates stay open until actually performed.

Backend or infrastructure tasks that do not depend on the visual skeleton may progress in parallel. Do not let "parallel" mean two tasks editing the same shared seam.

Installed/physical acceptance freezes only the exact candidate bytes and runtime in `RUNTIME_OWNERSHIP.md`. It does not freeze isolated source development. Shared source changes flow through the Integrator queue and a pre-authorized envelope; do not require redundant approval for an already accepted narrow interface.

## 6. Direct without babysitting the user

The Director handles routine architecture, task routing, ownership, tests, retries of safe local operations, corrections, and integration. Escalate only material product ambiguity, missing authority/input, destructive or external action, unresolved controlling conflict, or required human acceptance.

At the start of every user turn, classify new content as new requirement, correction to prior behavior, decision, acceptance evidence, or ordinary discussion. Persist requirements, corrections, decisions, and evidence into their controlling project records before resuming affected work; do not rely on the conversation remaining in context.

Follow task progress using compact task waits rather than repeatedly rereading full tasks. At meaningful updates and deadline checkpoints:

- persist every new user correction as `CORR-###` in `DECISION_LOG.md`, broadcast it to affected top-level tasks, add it to their checklists, and collect acknowledgment receipts before affected work continues;
- reconcile active corrections and recurrence counts; context compaction, task restart, later planning, or summary rewriting may not erase them;
- reconcile the board and master status;
- compare activity to primary-outcome movement;
- check the last direct real-journey attempt;
- classify the current artifact as `DEVELOPMENT`, `DIAGNOSTIC`, `INTEGRATION`, `RELEASE CANDIDATE`, or `RELEASED` and require a promotion justification before packaging, installing, or versioning another candidate;
- enforce ownership and integration order;
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

Continue safe disjoint work while one lane is blocked. If no outcome-critical disjoint work remains, mark the task ready or narrowly blocked; do not manufacture tests or adjacent features. Default review/decision deadline is 10% of the lane timebox, minimum 3 minutes and maximum 10 minutes. On expiry, choose a reversible path, reassign, or record a genuine blocker rather than repeatedly polling. Do not ask the user to perform Project Director work.

Treat the user's pause, stop, no-model, or equivalent instruction as an immediate global resource stop. Start no new work; reconcile task-owned processes and preserve dirty state before reporting. Usage and disk are generally acceptable, but work must not materially interfere with the user or another task. Count renamed retries, prompt variants, evaluator changes, and model swaps toward one whole-path focus budget. Keep visible UI background-only unless the user asked or a genuine login/CAPTCHA/human-acceptance boundary requires it.

## 7. Completion and handoff

Project completion requires every non-deferred master row to have current evidence at its promised level and no known Critical/High blocker. Tests, builds, mocks, source inspection, screenshots, or time spent never substitute for installed, physical, account, public, accessibility, security, visual-human, or user-acceptance proof.

Before the final response:

1. Run `Test-ProjectControls.ps1 -Strict`.
2. Reconcile every top-level task handoff and exact owned change.
3. Re-run only checks affected by integration or changed assumptions.
4. Record final candidate identity, failures, skips, `NOT RUN`, blockers, and remaining external/human gates.
5. Report one consolidated outcome and the smallest next action if anything remains.

Never claim the deadline or project succeeded when the Primary Outcome Lock did not pass at the required evidence level.

## Bundled resources

- `scripts/Initialize-ProjectStart.ps1` safely creates and activates the control files.
- `scripts/Test-ProjectControls.ps1` audits required files, links, research/plan gates, outcome/deadline/drift/visual/team/runtime/integration/resource contracts, pre-mortem rows, and the active coordinator checklist.
- `assets/project-kit/` contains the reusable Markdown templates copied into projects.
