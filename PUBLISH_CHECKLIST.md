# Public Repository Publish Checklist

## Outcome

Publish the validated `project-start` Codex skill as a dedicated public GitHub repository without including unrelated projects, private paths, caches, credentials, or stale package files.

## Ownership and boundaries

- **Owned local repository:** isolated `ProjectStart` checkout.
- **Source package:** installed `project-start` skill, copied byte-for-byte before public wrapper files were added.
- **Target:** `LiquidGlek/ProjectStart`
- **Excluded:** unrelated repositories and products, credentials, local memories, sessions, test fixtures, and local distribution ZIPs.

## Gates

- [x] PUB-001 — Confirm GitHub authentication and actual account identity. Evidence: authenticated CLI resolves to `LiquidGlek`.
- [x] PUB-002 — Confirm no existing `LiquidGlek/ProjectStart` repository would be overwritten.
- [x] PUB-003 — Copy only the validated installed skill into an isolated repository directory.
- [x] PUB-004 — Add public installation, use, validation, and repository-layout documentation.
- [x] PUB-005 — Inspect Git status and diff before staging. Evidence: isolated repository contains only the skill package, public README, ignore rules, and this checklist.
- [x] PUB-006 — Run package validation, PowerShell parsing, initialization, and activation audit from the repository copy. Evidence: all four checks passed from the isolated checkout.
- [x] PUB-007 — Scan tracked content for private paths, credentials, caches, and unrelated product material. Evidence: bounded scan passed with no matches.
- [ ] PUB-008 — Commit the exact reviewed file set.
- [ ] PUB-009 — Create and push to the public `LiquidGlek/ProjectStart` repository.
- [ ] PUB-010 — Read back repository visibility, default branch, commit, and public files from GitHub.

## Current status

- **Checked/open/total:** 7 / 3 / 10
- **Verified complete:** isolated source, human-written public README, package validation, PowerShell parsing, fresh initialization, activation audit, and private-content scan.
- **Critical failure:** none known.
- **Next action:** stage the exact reviewed files, commit, create the public repository, push, and read back the published state.
