# Change Checklist — Parallelism, Resume Continuity, and Idea Backlog

## Requested outcome

Update ProjectStart so independent top-level tasks actually run concurrently, long projects recover the active operating contract after context compaction, and user brainstorming is durably captured in both a backlog and the controlling checklist without silently becoming current implementation scope.

## Ownership and boundaries

- **Owned files:** ProjectStart skill, generated project-kit templates, initializer, validator, public README, and release records.
- **Excluded:** unrelated active product repositories and their running tasks; this skill update must not mutate, pause, or reinterpret product code.
- **Preserve:** top-level-task enforcement, user-controlled reprioritization, evidence classes, visual gates, authority boundaries, and unrelated repository history.

## Gates

| State | ID | Requirement | Exit proof |
|---|---|---|---|
| [x] | CHG-001 | Inspect the real test evidence and current skill/repository state | Thread evidence, clean starting Git state, and exact affected files recorded |
| [x] | CHG-002 | Distinguish exploratory brainstorming from explicit current work or corrections | Skill and templates define `IDEA-###` intake, promotion, non-interruption, and user-steering rules |
| [x] | CHG-003 | Put every brainstormed item in the durable backlog and controlling checklist | Generated master and task checklists contain linked idea intake/status fields; strict audit cross-checks both locations |
| [x] | CHG-004 | Launch every ready independent lane before waiting | Parallel launch barrier and multi-target wait/replenishment contract exist in skill and generated controls |
| [x] | CHG-005 | Preserve useful concurrency without manufacturing overlap or filler | Ready-set, dependency, running/target-concurrency, and under-utilization fields are required and cross-checked |
| [x] | CHG-006 | Recover governing state after compaction/restart | Compact `PROJECT_STATE.md` resume packet plus mandatory every-turn/compaction/restart/handoff rehydration protocol |
| [x] | CHG-007 | Prevent stale or unverified task startup | Exact task ID/deeplink/model/project/worktree/checklist/status receipt is required and wrong-project/unverified tests fail |
| [x] | CHG-008 | Reuse durable lane tasks and retire lifecycle debris | Existing valid lane tasks are resumed; every replacement has a reason; terminal debris is archived or carries verified host-level `UNARCHIVABLE` evidence |
| [x] | CHG-009 | Enforce the new contracts mechanically | Initializer and strict validator reject unresolved resume, backlog, concurrency, startup, subagent, and lifecycle state |
| [x] | CHG-010 | Validate a fresh initialization and deliberate negative cases | Package, parser, activation, resolved strict, adversarial regression, ZIP extraction, and extracted regression checks pass |
| [~] | CHG-011 | Synchronize the installed skill and public repository | Installed/package hashes match; public commit/push and remote read-back remain |
| [x] | CHG-012 | Make the operating language resistant to task misinterpretation | Rules name triggers, required actions, forbidden fallbacks, receipts, and fail states; adversarial scenarios exercise likely misreads |

## Status

- **Checked/active/open/total:** 11 / 1 / 0 / 12
- **Verified complete:** 91.7%
- **Current slice:** publish the reviewed package and verify the public remote identity.
- **Critical failure:** none known.
- **Evidence:** skill-package validation passed; all three PowerShell scripts parse; installed/public package hashes match across 24 files; the regression suite passes 16 positive/negative receipts; clean ZIP extraction passes package validation and the full regression suite.
- **Next action:** review/stage the exact diff, commit, push public `main`, and compare local/remote HEAD.
