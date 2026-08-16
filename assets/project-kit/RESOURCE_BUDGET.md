# Resource and Process Rules

Ordinary compute, model usage, downloads, and disk use are acceptable. This file exists only to stop work from interfering with the user or another task, prevent runaway retries, and make background processes accountable.

## Project rules

- **Whole-path attempt limit:** `<count covering retries, prompt variants, evaluator changes, and model swaps>`
- **Protected user/task activity:** `<specific active work that must not be interrupted, or NONE>`
- **Visible UI rule:** `Background-only unless the user asks or login/CAPTCHA/human acceptance requires it.`
- **Pause/stop rule:** `The user's latest pause, stop, or no-model instruction applies immediately.`

Do not add detailed disk, RAM, GPU, download, or token budgets unless this project actually needs one. A task may use substantial resources when that is the proportionate route to the locked outcome and it does not materially interfere with other active work.

## Background process registry

| ID | Owning task | PID/component | Purpose | Stop condition | Final state |
|---|---|---|---|---|---|
| PROC-001 | `<task>` | `<PID/component>` | `<purpose>` | `<condition>` | `<RUNNING/STOPPED/UNKNOWN>` |

Tasks may inspect ownership before stopping a process. Never close unrelated processes merely because they consume resources.

## Whole-path attempt accounting

An attempt is any execution intended to achieve the same outcome, including renamed retries, prompt variants, evaluator changes, model swaps, and recovery runs. The budget resets only by an explicit Director decision based on new decisive evidence, and material new downloads or destructive cleanup may still require user authority.

When the limit is reached:

1. Stop the operation family.
2. Record candidates, failures, costs, and decisive evidence.
3. Do not declare another “final” or “one last” route.
4. Choose a materially different critical-path strategy or escalate one bounded decision.

## Immediate pause and emergency stop

On user `pause`, `stop`, `no model`, or equivalent:

1. Stop starting new writes, builds, tests, model calls, downloads, renders, or background work.
2. Interrupt or safely stop task-owned processes where doing so will not corrupt data; otherwise report the exact safe reconciliation point.
3. Verify process ownership before termination.
4. Preserve dirty work and evidence; do not reset or clean.
5. Report exact processes started, stopped, still running, and why.
6. Resume only after explicit user release.

## Director audit

- [ ] Active work maps to the 3–10-row critical-path window.
- [ ] Retry families are counted as one path, not reset by renaming.
- [ ] Work did not materially interfere with the user or another task.
- [ ] Every task-owned background process has a stop condition and final state.
- [ ] User pause/stop/no-model instructions were reconciled immediately.
