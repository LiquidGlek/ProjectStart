# Evidence Ledger

This file stores durable proof references. Evidence proves only the claim and candidate it actually exercised.

## Evidence classes

| Class | Can prove | Cannot prove by itself |
|---|---|---|
| Inspection | Files, configuration, ownership, source structure | Runtime behavior |
| Test | Modeled behavior exercised by that test | Real UI, device, platform, or unmodeled paths |
| Build/static | Compilation and static contracts | Launch, usability, installation, integration |
| Rendered/runtime | Behavior or pixels in the tested candidate/environment | Installed/public/physical behavior elsewhere |
| Installed | Exact installed candidate on named machine | Other machines, devices, or accounts |
| Physical/device | Named hardware path | Other hardware |
| Account/platform | Named external integration and account boundary | Other accounts or public delivery unless tested |
| Public/live | Exact public destination and read-back | Future availability or unrelated destinations |
| Accessibility/security | Exact audit/tool/manual scope | Areas outside that scope |
| Human acceptance | Named approver accepted exact candidate/journey | Technical correctness beyond observed journey |

## Ledger

Use one stable ID per evidence event. Never overwrite a failed result; add a new entry so history remains truthful.

| ID | Time | Master/lane IDs | Class | Candidate/environment | Procedure or command | Result | Artifact/receipt | Limitations | Verified by |
|---|---|---|---|---|---|---|---|---|---|
| EV-001 | `<ISO time>` | `<IDs>` | `<class>` | `<commit/hash/version/machine/account>` | `<exact command or journey>` | `<PASS/FAIL/NOT RUN/BLOCKED>` | `<path/link/receipt>` | `<what remains unproven>` | `<agent/human>` |

## Evidence rules

- Record command exit code, test counts, relevant failures/skips, artifact identity, timestamp, and environment.
- Keep secrets, tokens, private logs, personal data, and unnecessary machine paths out of shared evidence.
- A stale candidate cannot prove a changed candidate.
- Screenshots must identify candidate, viewport/state, and whether controls are real or mocked.
- External mutation with an ambiguous response remains unconfirmed until reconciled; do not automatically repeat it.
- Human acceptance names what was accepted and what was not reviewed.
