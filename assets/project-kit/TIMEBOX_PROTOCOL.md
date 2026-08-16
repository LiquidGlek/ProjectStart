# Timebox Protocol — Deadlines That Produce Outcomes

An exact project deadline is a user commitment. A slice deadline is an internal focus constraint. When the user supplies no project deadline, keep it `NONE` and still timebox the first usable slice. Neither kind permits lowering the truth, safety, or evidence bar.

## Set the clock exactly

Record:

- start timestamp and timezone;
- project deadline timestamp and timezone, or `NONE` when the user supplied none;
- current slice deadline timestamp and timezone;
- total duration;
- each lane's budget and owner;
- who may extend the deadline or reduce the promised scope.

Never use “about an hour” in the control files when an exact timestamp is available. Calculate remaining time from the current clock; do not guess.

## Default deadline checkpoints

| Stage | Budget used | Required action |
|---|---:|---|
| Early | 0–25% | Inspect narrowly and attempt or reproduce the exact real journey as early as safe. |
| Midpoint | 50% | Demonstrate observable movement on the locked outcome or escalate the narrow blocker. Reassign ownership if useful. |
| Scope freeze | 75% | Stop optional tests, refactors, cleanup, polish, documentation, and new architecture. Keep only work required for the locked outcome and required gates. |
| Stabilize | 90% | Stop speculative approaches. Run the exact acceptance journey, repair only release-blocking defects, reconcile evidence, and prepare an honest handoff. |
| Deadline | 100% | Report `PASS`, `FAIL`, `PARTIAL`, or `BLOCKED` at the exact evidence level. Record overrun; never backdate success. |

These are defaults. A project may choose stricter checkpoints in its charter.

## What gets cut first

As the deadline closes, remove work in this order:

1. speculative frameworks and future-proofing;
2. unrelated cleanup and refactors;
3. redundant tests and repeated broad suites;
4. optional polish and documentation;
5. explicitly optional scope approved for deferral by the user.

Do not cut:

- the primary outcome lock;
- data-loss, security, privacy, destructive-action, or external-mutation safeguards;
- exact acceptance evidence required for the completion claim;
- required user approval;
- truthful reporting and recoverable handoff state.

## Agent deadline report

```text
Deadline: <timestamp/timezone>; <remaining or overrun>
Stage: <EARLY/MIDPOINT/SCOPE FREEZE/STABILIZE/OVERRUN>
Locked outcome: <PASS/FAIL/PARTIAL/NOT ATTEMPTED>
Movement since last checkpoint: <observable fact or NONE>
Cut/parked: <optional work>
Blocking seam: <exact fact or UNKNOWN>
Next until deadline: <one outcome-critical action>
```

## Coordinator deadline duties

- Compare lane activity with primary-outcome movement, not elapsed effort.
- Stop agents that accumulate unrelated work while the critical row is unchanged.
- Reassign narrow investigations when parallel work genuinely shortens the critical path.
- At midpoint, require direct evidence or a bounded blocker—not optimism.
- At scope freeze, reject new optional work.
- At stabilization, protect the real journey and evidence window from more engineering churn.
- If the deadline passes, record the exact overrun and current truth. A near miss is still a miss, but it is not a reason to discard verified progress.

## Safety under pressure

Deadlines do not authorize destructive commands, publication, deployment, external messages, purchases, account/credential changes, automatic retry of ambiguous external actions, or bypassing required approval. Stop and report the authority blocker even when time is short.
