# Focus Protocol — Finish Outcomes, Not Test Collections

This protocol prevents agents from drifting into dozens of low-value tests, refactors, audits, and documents while the requested outcome remains unfinished.

## Lock the outcome before work

Write the exact user request and acceptance journey in the master and agent checklists. For a request such as “make the primary action work,” the lock is not “improve the subsystem,” “add tests,” or “refactor the service.” It is the real journey:

```text
Required starting state -> user performs the action -> the authoritative system confirms success
-> product truthfully shows the result -> restart/failure behavior matches the promise
```

Attempt the exact journey early on the real candidate when safe. Its failure becomes diagnostic evidence. Proxy success never closes the locked row.

For an existing product or repair, attempt or reproduce the journey before the first production edit whenever safe. Otherwise run it on the earliest runnable slice and before any `RELEASE CANDIDATE`. Do not admit more than one coherent implementation slice without either a direct attempt or a concrete evidenced prerequisite that makes the journey impossible.

## The rule of one current slice

Each agent keeps exactly one current vertical slice: a usable feature, verified repair, finished artifact, rendered improvement, or decisive investigation that changes the project direction.

A slice must state:

- the master and lane IDs it advances;
- the user-visible or operational result;
- the smallest implementation needed;
- the exact exit proof;
- the next action.

New ideas go into **Side quests parked** in the agent checklist. They do not interrupt the slice unless they expose a critical safety issue, invalidate the approach, or are required for the slice's exit proof.

## A test must earn its existence

Run or create a test now only when all are true:

1. It maps to an open checklist row or a changed risk.
2. PASS and FAIL lead to meaningfully different next decisions.
3. Existing evidence is insufficient at this stage.
4. It is the smallest reliable check for the question.
5. Its evidence level matches the claim being made.

Good reasons:

- Prove the state transition required by a master row.
- Reproduce a reported defect before fixing it.
- Protect a risky boundary changed by the current slice.
- Decide between competing implementations.
- Qualify a coherent slice at its integration checkpoint.

Bad reasons:

- More passing tests make the work look complete.
- The test exercises a private helper already covered by behavior tests.
- Nothing relevant changed, but rerunning feels safe.
- A source-string assertion is easier than exercising the behavior.
- A broad suite is being used to avoid completing a hard journey.
- Test infrastructure is growing without reducing a named project risk.

## Verification cadence

### During a slice

Use the narrowest fast check that changes the next implementation decision. Do not rerun unchanged checks after commentary, documentation, or unrelated-file edits.

### At a coherent slice checkpoint

Run focused behavior tests, the relevant build/static check, and the exact runtime/rendered journey promised by the slice.

### At integration or release

Run broader regression, installed, device, external, accessibility, security/privacy, and human gates only when the candidate and environment are ready. Keep unavailable gates open or `NOT RUN`.

## Stop conditions for test churn

Stop testing and return to the outcome when any condition is true:

- Three checks in a row produce no new decision or evidence for an open row.
- The same check already passed on unchanged relevant bytes and assumptions.
- More test code than product/fix code is being added without an explicit risk reason.
- The agent cannot name the master row, claim, and changed decision before a check.
- A broad suite failure is unrelated to owned work; record and route it instead of taking over the defect.
- Tests pass but the real user journey remains unattempted.

The coordinator should mark the lane `CHANGES REQUESTED` when churn continues without outcome movement.

## Drift alarm

Trigger the alarm after either:

- two materially different approaches fail to advance the locked outcome; or
- three meaningful checkpoints produce no observable outcome movement or decisive blocker evidence.

When triggered:

1. Stop adding adjacent features, refactors, speculative abstractions, and extra tests.
2. State the current acceptance result: `NOT ATTEMPTED`, `FAIL`, or `PARTIAL`.
3. List the exact attempts, observed results, candidate identity, and evidence.
4. Identify the narrowest unknown or blocking seam.
5. Ask the coordinator for one bounded decision, ownership transfer, or specialist investigation.
6. Continue only safe work directly required by that blocker.

The alarm is cleared only by observable movement on the locked outcome or decisive evidence that changes the planned route. Time spent, files changed, and tests added do not clear it.

## Two-candidate circuit breaker

Count failures by Primary Outcome Lock journey, not by defect name. If two successive candidates fail the same journey, trigger this breaker even when each failure appears in a different component.

1. Freeze new versions, packaging, installation, candidate promotion, and symptom patches.
2. Mark the journey `FAIL` and record both candidate identities and complete failure chain.
3. Reconstruct the critical journey transaction contract: authority, ordered state transitions, allowed delta, read-back, commit, failure/recovery/idempotency, and external-effect ordering.
4. Identify the missing invariant and run one bounded sibling-impact check across direct readers, writers, validators, recovery paths, and downstream consumers.
5. Amend and re-accept `PROJECT_PLAN.md`; obtain independent adversarial review for cross-cutting changes.
6. Resume only one coherent implementation route. The next artifact must be explicitly classified and justified by the Candidate promotion gate.

Renaming the defect, changing model/evaluator, or incrementing the version does not clear the breaker. Clear it only after the repaired plan is accepted and the next exact journey attempt produces decisive evidence.

## Candidate promotion and health language

Classify every artifact as `DEVELOPMENT`, `DIAGNOSTIC`, `INTEGRATION`, `RELEASE CANDIDATE`, or `RELEASED`. Before packaging or versioning another candidate, state which row needs new bytes, what changed, which prerequisites passed, which decisive journey comes next, why isolated evidence is insufficient, and what result stops further packaging.

Qualify health claims by scope. A connected preview, successful build, safe idle state, or focused regression may pass while the product journey fails. Overall product/release health cannot exceed the weakest required Critical row.

## Missing table-stakes impact check

When an ordinary category capability is unexpectedly absent or a product-level claim is proven false, first invalidate every affected claim/evidence. Then inspect only its directly related capability family plus the transaction-contract impact map: readers, writers, validators, recovery paths, controls, and downstream consumers. Convert required findings into master rows or defects before implementation. Do not expand this bounded check into a whole-product audit, and do not patch the visible control while sibling claims remain falsely accepted.

## Side-quest triage

Classify discoveries immediately:

| Class | Action |
|---|---|
| Critical safety/data-loss/security issue | Record, alert coordinator, and pause only affected work. |
| Required for current slice exit | Add a lane gate and continue. |
| Required project promise but not current slice | Propose a master row; park for scheduling. |
| Nice refactor, extra test, polish, or speculative framework | Park; do not implement now. |
| Unrelated defect | Record enough evidence to route; do not take ownership silently. |

## Meaningful checkpoint report

```text
Slice: <one outcome>
Movement: <what became usable/proven or what decision changed>
Rows: <IDs and state changes>
Changed: <exact owned targets>
Evidence: <EV IDs>
Tests not run: <what was deliberately deferred and why>
Parked: <side quests>
Next: <one action>
```

If **Movement** is empty, the checkpoint is not progress.
