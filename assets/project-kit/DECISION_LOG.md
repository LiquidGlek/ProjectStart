# Decision Log

Record decisions that change requirements, architecture, ownership policy, evidence, release scope, or user acceptance. Do not use this log to retroactively justify an undocumented choice.

## Decision template

### DEC-001 — `<short title>`

- **Date/time:** `<ISO timestamp>`
- **Status:** `<PROPOSED/ACCEPTED/SUPERSEDED/REJECTED>`
- **Decision owner:** `<user/role>`
- **Prompting fact or question:** `<what forced a choice>`
- **Options considered:** `<meaningfully different options>`
- **Decision:** `<exact choice>`
- **Reason:** `<why>`
- **Master IDs affected:** `<IDs>`
- **Agent lanes/files affected:** `<lanes/targets>`
- **Evidence or user message:** `<reference>`
- **Consequences and follow-up:** `<required edits/tests/migrations>`
- **Supersedes/is superseded by:** `<decision ID or none>`

## Rules

- Only the user or named authority may approve scope reduction, deferral, destructive action, external publication, purchases, credentials, or acceptance gates.
- A decision changes status only after affected charter, master, board, and agent checklists are reconciled.
- Keep superseded decisions; point to the replacement.
- “The agent thought it was best” is not user approval.

## Correction and regression ledger

A user correction is a durable control, not transient chat context. Record it immediately as `CORR-###` before continuing affected work. Never delete or summarize away a correction; supersede it only with later explicit user direction.

### CORR-001 — `<short correction>`

- **Date/time and user evidence:** `<timestamp and exact message/reference>`
- **Mistake observed:** `<specific behavior/result>`
- **Required replacement behavior:** `<positive rule>`
- **Prohibited recurrence:** `<what must not happen again>`
- **Affected master IDs:** `<IDs>`
- **Affected tasks/files/systems:** `<exact targets>`
- **Guardrail/regression proof:** `<check, acceptance step, or process change>`
- **Broadcast by Director:** `<task IDs/deeplinks and timestamp>`
- **Acknowledgment receipts:** `<task -> timestamp -> checklist row>`
- **Recurrence count:** `<0 initially; increment on every repeat>`
- **Current state:** `<ACTIVE / PROVEN / SUPERSEDED>`
- **Superseded by:** `<CORR/DEC ID or NONE>`

### Correction rules

- The Director adds each correction to every affected task checklist and sends it through the task tools; the user does not repeat it to sibling tasks.
- Affected tasks acknowledge the exact replacement behavior before their next write or decision.
- At every meaningful checkpoint, the Director reconciles active corrections and recurrence counts before accepting progress.
- A repeated mistake triggers the drift alarm and adversarial self-audit. Strengthen ownership, acceptance, automation, or review; do not respond with another chat apology alone.
- Final completion requires every active correction to have matching regression evidence or an explicit unresolved blocker.
