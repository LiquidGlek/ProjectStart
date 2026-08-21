# Change Checklist — Staffed Full-Team Build Waves

## Requested outcome

Correct ProjectStart so every invocation first asks for the user's exact simultaneous worker count and worker model/effort policy, enforces those answers, and makes `FULL TEAM` a real software-company build wave: 10–15 concurrent non-Director top-level workers own contract-isolated product domains, then regroup at an explicit integration barrier to combine coherent handoffs into one candidate.

## Ownership and boundaries

- **Owned files:** ProjectStart skill instructions, generated project-kit controls, initializer, validator, regression suite, public documentation, installed skill package, and release archive.
- **Live correction target:** existing Project Director task `01a00d54-8e12-7103-b00c-69600354bfaa`; preserve its current atomic integration and dirty work.
- **Excluded:** direct implementation of MavisMakes product domains from this task; the corrected Director owns team formation and routing.
- **Preserve:** stable-lane reuse, top-level `create_thread` tasks, no durable subagents, exact ownership, evidence classes, user authority, safe archive rules, and anti-filler/test-churn controls.

## Gates

| State | ID | Requirement | Exit proof |
|---|---|---|---|
| [x] | SCALE-001 | Persist the user correction that FULL TEAM is a staffed company wave, not a two-lane ready-set trickle | Live Director correction receipt plus skill/control wording |
| [x] | SCALE-002 | Define unambiguous team-mode staffing | SOLO/SMALL/FULL ranges; FULL is 10–15 non-Director workers and implementation is the majority |
| [x] | SCALE-003 | Remove artificial dependency serialization | Plans must freeze seams and permit owned-side work with contracts, fixtures, or test doubles before declaring a sibling a blocker |
| [x] | SCALE-004 | Require a complete staffed first build wave | Plan and state identify 10–15 stable lane IDs, ownership, work class, model, workspace, handoff, and integration batch |
| [x] | SCALE-005 | Require explicit regroup and integration | All wave lanes return coherent handoffs; feature work freezes; Integrator combines in declared order; fixes return to original lane tasks |
| [x] | SCALE-006 | Enforce FULL TEAM mechanically | Strict validator rejects fewer than 10 or more than 15 first-wave workers, a non-majority implementation wave, incomplete launch receipts, and premature integration |
| [x] | SCALE-007 | Preserve proportional modes | SOLO and SMALL TEAM remain usable for explicitly selected narrow projects and are not forced into filler concurrency |
| [x] | SCALE-008 | Add adversarial regressions | Positive staffed FULL TEAM fixture plus negative two-worker, QA-heavy, partial-launch, and premature-regroup cases pass/fail as intended |
| [x] | SCALE-009 | Keep documentation and UI metadata truthful | README, skill description, and default prompt describe staffed build and integration waves without overpromising |
| [x] | SCALE-010 | Synchronize and validate the installed skill | Package validation, PowerShell parse, regression suite, and source/installed hash comparison pass |
| [x] | SCALE-011 | Correct the live Director behavior | It records the correction, publishes a 10–15-worker plan, reuses/creates the lanes, and returns exact launch receipts before waiting |
| [x] | SCALE-012 | Publish and verify the public release | Clean commit on public `main`, remote read-back, and clean distributable ZIP with recorded SHA-256 |
| [x] | SCALE-013 | Ask the staffing question before project work | Every `$project-start` invocation without both answers asks one combined question for exact worker count and model/effort policy, then stops before initialization, research, planning, files, or tasks |
| [x] | SCALE-014 | Treat the answers as an exact launch contract | Requested, planned, launched, and simultaneously active worker counts match; actual worker model/effort matches the user policy with no silent substitution |
| [x] | SCALE-015 | Reject bypasses and mismatches mechanically | Regression coverage proves mandatory initializer parameters and strict validation rejects count, assignment, or actual-model mismatches |

## Status

- **Checked/active/open/total:** 15 / 0 / 0 / 15
- **Verified complete:** 100%
- **Current slice:** COMPLETE.
- **Critical failure:** NONE in the verified source, installed package, extracted release archive, or public read-back.
- **Evidence:** source and installed skill validators pass; the full regression suite passes its combined-question, mandatory-parameter, positive FULL TEAM, and adversarial failure cases; a fresh 10-worker initialization produced matching charter/state/plan/board receipts; the live Director activated 15 non-Director worker tasks concurrently; public `main`, GitHub API, and `git ls-remote` matched release commit `858c92b327dfb2078d886c72da235fdca72ba477`; the public README and skill contained the new intake contract; the 27-entry release ZIP matched all 26 source files and has SHA-256 `C15A19F4A01D6C11FBC0BED9A1D425DD4029885DF359949E7468043A1959C55F`.
- **Next action:** invoke `$project-start`; when worker count or model policy is absent, answer the combined staffing question and let the Director derive and launch the exact team.
