<div align="center">

# ProjectStart

### A Codex skill for keeping long-running projects focused, visible, and honest.

[![Codex Skill](https://img.shields.io/badge/Codex-Skill-111827?style=for-the-badge)](./SKILL.md)
[![PowerShell](https://img.shields.io/badge/PowerShell-Validated-2563EB?style=for-the-badge&logo=powershell&logoColor=white)](./scripts)
[![Anti Drift](https://img.shields.io/badge/Anti--Drift-Fail--Closed-E11D48?style=for-the-badge)](./assets/project-kit/FOCUS_PROTOCOL.md)
[![MIT License](https://img.shields.io/badge/License-MIT-16A34A?style=for-the-badge)](./LICENSE)

<a href="https://github.com/LiquidGlek/ProjectStart/archive/refs/heads/main.zip"><img alt="Download ProjectStart" src="https://img.shields.io/badge/Download_ProjectStart-111827?style=for-the-badge&logo=github&logoColor=white"></a>

</div>

---

I built this after asking agents to fix one button and coming back twelve hours later to find that the button still did not work. They had written tests, investigated unrelated code, and made plenty of progress on everything except the thing I asked for.

A checklist helped immediately. This skill is the larger version of that idea.

ProjectStart first asks how many simultaneous workers you want and what model/effort they should use. It then gives the project a Director, one master checklist, separate task checklists, deadlines, ownership boundaries, correction records, prior-art research, visual gates, and evidence rules. In FULL TEAM mode it deliberately staffs the answered 10–15 non-Director workers at once, gives most of them real implementation domains, freezes the interfaces that let them build independently, and then regroups their handoffs through one integration wave. It also keeps a compact resume packet, reuses stable task lanes, archives terminal debris when the host permits, records truthful unarchivable leftovers when it does not, and parks brainstorms without losing them. The point is not more paperwork. It is leaving a developer team to work without babysitting and returning to one integrated product instead of scattered agent activity.

> [!IMPORTANT]
> Every lasting role or product domain must be a separate, sidebar-visible Codex task created with `create_thread`. `spawn_agent` is not a substitute for a developer, QA task, visual auditor, integrator, release owner, researcher, or any other durable project lane. If task creation fails, that lane stays blocked.

## What it is trying to fix

| What kept happening | What ProjectStart does about it |
|---|---|
| The requested feature stayed broken while side work multiplied | Locks the primary outcome and allows one current vertical slice |
| Agents wrote dozens of tiny tests that changed nothing | Makes every test name the open gate and the decision its result can change |
| The finished UI barely resembled the mockup | Requires measurements and a real-control skeleton before feature work |
| Obvious features were missed because I did not list every industry standard | Researches competitors, open-source projects, and table-stakes workflows first |
| A correction was forgotten ten hours later | Records corrections as durable IDs and checks for recurrence |
| Agents could not find or communicate with one another | Registers every task by exact ID and deeplink |
| A hidden subagent ended up owning half the product | Requires every durable lane to be a real top-level task |
| The Director launched one task, waited, and left every other lane asleep | Computes a ready set, starts the whole launch wave, and waits on active tasks together |
| The skill guessed an expensive team size or launched the wrong model | Asks for an exact 1–15 worker count and model/effort policy first, then validates the plan and actual startup receipts against those answers |
| “Full team” quietly became one or two workers because everything else supposedly depended on them | Requires a 10–15-worker first build wave, challenges artificial dependencies with frozen contracts and test doubles, and fails strict validation when the team is understaffed |
| Agents finished isolated branches but never became one product | Freezes the wave at a handoff barrier, integrates in declared batches, routes conflicts back to original owners, and tests one exact candidate |
| Long context compaction erased the operating rules | Rehydrates a compact `PROJECT_STATE.md` packet every turn, restart, and handoff |
| New random tasks replaced usable old tasks | Gives each lane a stable ID, verifies actual startup metadata, and requires reuse or a recorded replacement reason |
| Finished and duplicate tasks piled up forever | Reconciles dirty work/processes, archives safely terminal tasks, and keeps archive receipts |
| A casual “could we?” derailed the current milestone | Captures it as a linked `IDEA-###` backlog item until explicitly promoted |
| A build or unit test was reported as proof the app worked | Requires evidence at the same level as the claim |

## How a project runs

```mermaid
flowchart LR
    A["Instructions<br/>and mockups"] --> S["Ask worker count<br/>and model policy"]
    S --> B["Inspect the real project"]
    B --> C["Research existing work<br/>and expected features"]
    C --> D["Write and audit the plan"]
    D --> E["Staff 10–15 verified workers<br/>for FULL TEAM"]
    E --> F["Concurrent contract-isolated<br/>build wave"]
    F --> G["Regroup and integrate<br/>coherent handoffs"]
    G --> J["Independent QA<br/>and visual review"]
    J --> H["Try the exact<br/>user journey"]
    H -->|Fail| F
    H -->|Pass| I["Evidence-backed<br/>handoff"]
```

Planning happens before the large checklists are created. The initial checklist stays small: inspect, understand intent, research, plan, and then derive the real work. This prevents the project from locking itself into a bad first guess.

## What the skill creates

```text
Your Project/
├── PROJECT_CHARTER.md          # What the user actually wants and does not want
├── PROJECT_STATE.md            # Compact resume packet for turns, compaction, and handoffs
├── PRIOR_ART_RESEARCH.md       # Existing products, open source, and reuse decisions
├── PROJECT_PLAN.md             # Architecture and ordered vertical slices
├── MASTER_CHECKLIST.md         # The only authority for project completion
├── COORDINATION_BOARD.md       # Ownership, deadlines, blockers, and live state
├── AGENT_COMMUNICATION.md      # Task IDs, actual startup read-backs, reuse, routing, and archives
├── DECISION_LOG.md             # Decisions and user corrections that must survive context loss
├── EVIDENCE_LEDGER.md          # Proof for every completed claim
├── FOCUS_PROTOCOL.md           # Drift alarms and patch-spiral circuit breakers
├── VISUAL_PROTOCOL.md          # Mockup fidelity and skeleton approval
├── TEAM_OPERATING_MODEL.md     # Director, developer, QA, and audit roles
└── agent-checklists/
    ├── coordinator.md
    └── one checklist for every top-level task
```

## Install

### Easiest: ask Codex to install it

Copy this into a Codex task:

```text
Use $skill-installer to install the project-start skill from https://github.com/LiquidGlek/ProjectStart and name it project-start.
```

The installer downloads public GitHub skills directly and refuses to overwrite an existing skill directory.

### Manual install

Clone the repository into your Codex skills directory as `project-start`:

### Windows PowerShell

```powershell
git clone https://github.com/LiquidGlek/ProjectStart.git "$env:USERPROFILE\.codex\skills\project-start"
```

### macOS or Linux

```bash
git clone https://github.com/LiquidGlek/ProjectStart.git ~/.codex/skills/project-start
```

If that folder already exists, preserve or remove it intentionally before cloning. Do not blindly overwrite an existing skill.

## Use it

Open a Codex task inside the project you want to build. Give it your instructions, constraints, deadline, and any mockups or reference images. Then invoke:

```text
$project-start
```

The Director's first response asks for the exact simultaneous worker count (1–15, excluding the Director) and worker model/effort policy unless you already included both in the invocation. You may give one model for everyone, a role-based mix, or `AUTO`. It then inspects the project and references, writes down the user intent, researches what already exists, creates an audited plan, and launches exactly the answered count. A 10–15-worker answer becomes FULL TEAM, with implementation-domain owners as the majority. Every lane gets a stable ID, reusable top-level Codex task, exact checklist, verified model/project/workspace, deadline, frozen seam, and coherent handoff. After the build wave, feature work freezes while the Integrator combines every handoff into one candidate and independent QA runs against it.

The Director coordinates and checks evidence. It does not quietly become the main developer when another task is blocked.

## When work needs a new task

It needs a **new top-level Codex task** if it owns any of the following:

- A master-checklist requirement or acceptance gate.
- Production files, a product system, a shared seam, or runtime state.
- Its own deadline, checklist, model allocation, or durable handoff.
- Implementation, integration, packaging, installation, release work, QA, or visual approval.
- Work that another task must be able to find, message, pause, or resume later.

A subagent is only for one bounded piece of temporary help inside an existing task. It owns no project lane, production change, runtime, checklist, deadline, or approval.

If there is any doubt, classify the work as a durable lane—then reuse that lane's valid registered top-level task. Create a new one only when no valid task exists.

## Validation

The initializer copies the control kit into a project without overwriting files that are already there:

```powershell
.\scripts\Initialize-ProjectStart.ps1 `
  -TargetPath C:\Projects\MyApp `
  -Outcome "The requested user journey works in the real application." `
  -AcceptanceJourney "Fresh launch -> user action -> authoritative result -> restart persistence" `
  -WorkerCount 10 `
  -WorkerModelPolicy "default=gpt-5.6-sol / medium"
```

The validator has two modes:

```powershell
# Reports planning placeholders but permits the initial planning stage
.\scripts\Test-ProjectControls.ps1 -TargetPath C:\Projects\MyApp

# Must pass before substantive implementation begins
.\scripts\Test-ProjectControls.ps1 -TargetPath C:\Projects\MyApp -Strict
```

Strict mode rejects unresolved or mismatched staffing intake, a first wave that differs from the requested count, actual models that differ from policy-backed assignments, malformed task registries, missing `create_thread` receipts, unverified project/workspace startup, serialized ready lanes, an understaffed or QA-heavy FULL TEAM wave, premature integration, unresolved archive debris, stale resume state, and durable lanes assigned to `spawn_agent`.

## A few rules I care about

- The user's latest explicit direction wins. Write it down instead of trusting chat history.
- Casual brainstorming is saved in both the backlog and affected checklist, but it stays out of active work and completion math until promoted.
- Reuse the valid task for a stable lane; a new slice or review pass is not a reason to make another task.
- FULL TEAM means 10–15 non-Director workers during the build wave, not one or two convenient lanes.
- Build against frozen contracts and fixtures instead of waiting for sibling implementations.
- Regroup every coherent handoff, freeze feature work, integrate in order, and test one exact candidate.
- Research before rebuilding something that already exists.
- Build the real mockup skeleton before filling it with features.
- Do not ask the user for approval on ordinary, reversible work inside an assigned lane.
- A passing test does not prove an installed application, device, account, or public service works.
- Two failed candidates for the same journey trigger a stop and a deeper transaction review.
- Percentages never outweigh one critical broken feature.

## Repository map

| Path | What it contains |
|---|---|
| [`SKILL.md`](./SKILL.md) | The controlling Codex workflow |
| [`agents/openai.yaml`](./agents/openai.yaml) | Skill metadata |
| [`assets/project-kit/`](./assets/project-kit) | The project documents and templates |
| [`scripts/Initialize-ProjectStart.ps1`](./scripts/Initialize-ProjectStart.ps1) | The safe initializer |
| [`scripts/Test-ProjectControls.ps1`](./scripts/Test-ProjectControls.ps1) | Activation and strict validation |
| [`scripts/Test-ProjectStartRegression.ps1`](./scripts/Test-ProjectStartRegression.ps1) | Fresh-fixture and adversarial failure regression suite |
| [`LICENSE`](./LICENSE) | MIT open-source license |

## Current validation

The current package has passed skill-package validation, PowerShell parsing, fresh initialization, activation auditing, a fully resolved strict fixture, and adversarial regressions proving that serialized ready lanes, single-target waits that omit another ready lane, wrong task projects, unverified startup metadata, durable subagent lanes, unarchived terminal tasks, retryable archive debris, duplicate live lanes, backlog-count drift, missing checklist links, and stale resume state are rejected. Separate positive cases prove that one archived history plus one reused live lane is valid and permanently missing host task records can remain truthfully `UNARCHIVABLE` without stopping product work.

ProjectStart is open source under the [MIT License](./LICENSE).

---

<div align="center">

**The goal is simple: come back to the product you asked for.**

</div>
