[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [string]$TargetPath = (Get-Location).Path,

    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$Outcome,

    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$AcceptanceJourney,

    [string]$ProjectDeadline,

    [string]$ProjectName,

    [string]$DirectorTaskTitle = 'Project Director',

    [string]$DirectorTaskId = 'PENDING - populate before creating sibling tasks',

    [string]$DirectorDeeplink = 'PENDING - copy the exact Director task deeplink before creating sibling tasks',

    [ValidateRange(5, 10080)]
    [int]$TimeboxMinutes = 60,

    [ValidateSet('SOLO', 'SMALL TEAM', 'FULL TEAM')]
    [string]$TeamMode = 'SMALL TEAM',

    [string]$VisualReference,

    [string]$VisualViewportState
)

$ErrorActionPreference = 'Stop'

function Set-TextFile {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string]$Content
    )

    [System.IO.File]::WriteAllText($Path, $Content, [System.Text.UTF8Encoding]::new($false))
}

function Replace-Text {
    param(
        [Parameter(Mandatory = $true)][string]$Content,
        [Parameter(Mandatory = $true)][string]$Old,
        [Parameter(Mandatory = $true)][string]$New
    )

    if (-not $Content.Contains($Old)) {
        throw "Initializer template is missing expected text: $Old"
    }

    return $Content.Replace($Old, $New)
}

$resolvedTarget = [System.IO.Path]::GetFullPath($TargetPath)
if (-not (Test-Path -LiteralPath $resolvedTarget -PathType Container)) {
    throw "Target project directory does not exist: $resolvedTarget"
}

if ([string]::IsNullOrWhiteSpace($ProjectName)) {
    $ProjectName = Split-Path -Leaf $resolvedTarget
}

$assetRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\assets\project-kit'))
if (-not (Test-Path -LiteralPath $assetRoot -PathType Container)) {
    throw "Bundled project kit is missing: $assetRoot"
}

$coreFiles = @(
    'README.md',
    'AGENTS.md',
    'PROJECT_CHARTER.md',
    'MASTER_CHECKLIST.md',
    'PRIOR_ART_RESEARCH.md',
    'PROJECT_PLAN.md',
    'COORDINATION_BOARD.md',
    'AGENT_COMMUNICATION.md',
    'RUNTIME_OWNERSHIP.md',
    'INTEGRATION_CONTRACTS.md',
    'RESOURCE_BUDGET.md',
    'AGENT_CHECKLIST_TEMPLATE.md',
    'EVIDENCE_LEDGER.md',
    'DECISION_LOG.md',
    'FOCUS_PROTOCOL.md',
    'TIMEBOX_PROTOCOL.md',
    'VISUAL_PROTOCOL.md',
    'TEAM_OPERATING_MODEL.md'
)

$coordinatorRelativePath = 'agent-checklists\coordinator.md'
$missingAssets = @($coreFiles | Where-Object { -not (Test-Path -LiteralPath (Join-Path $assetRoot $_) -PathType Leaf) })
if ($missingAssets.Count -gt 0) {
    throw "Bundled project kit is incomplete. Missing assets: $($missingAssets -join ', ')"
}

$visualSourcePath = $null
$visualDestinationRelativePath = $null
if (-not [string]::IsNullOrWhiteSpace($VisualReference) -and [System.IO.Path]::IsPathRooted($VisualReference)) {
    $visualSourcePath = [System.IO.Path]::GetFullPath($VisualReference)
    if (-not (Test-Path -LiteralPath $visualSourcePath -PathType Leaf)) {
        throw "Controlling visual reference does not exist: $visualSourcePath"
    }

    $insideTarget = $visualSourcePath.StartsWith(
        $resolvedTarget + [System.IO.Path]::DirectorySeparatorChar,
        [System.StringComparison]::OrdinalIgnoreCase
    )
    if ($insideTarget) {
        $VisualReference = $visualSourcePath
    }
    else {
        $visualExtension = [System.IO.Path]::GetExtension($visualSourcePath)
        $visualDestinationRelativePath = "project-references\controlling-visual$visualExtension"
        $VisualReference = Join-Path $resolvedTarget $visualDestinationRelativePath
    }
}

$destinations = @($coreFiles | ForEach-Object { Join-Path $resolvedTarget $_ })
$destinations += Join-Path $resolvedTarget $coordinatorRelativePath
if ($null -ne $visualDestinationRelativePath) {
    $destinations += Join-Path $resolvedTarget $visualDestinationRelativePath
}
$conflicts = @($destinations | Where-Object { Test-Path -LiteralPath $_ })

if ($conflicts.Count -gt 0) {
    $conflictList = $conflicts -join [Environment]::NewLine
    throw "Initialization refused because files already exist. No files were changed. Inspect and adopt or merge them explicitly:$([Environment]::NewLine)$conflictList"
}

$started = Get-Date
$deadline = $started.AddMinutes($TimeboxMinutes)
$startedText = $started.ToString('yyyy-MM-ddTHH:mm:sszzz')
$deadlineText = $deadline.ToString('yyyy-MM-ddTHH:mm:sszzz')
$snapshotText = $startedText
$projectDeadlineText = 'NONE supplied'
if (-not [string]::IsNullOrWhiteSpace($ProjectDeadline)) {
    $parsedProjectDeadline = [DateTimeOffset]::MinValue
    if (-not [DateTimeOffset]::TryParse($ProjectDeadline, [ref]$parsedProjectDeadline)) {
        throw "ProjectDeadline is not a parseable timestamp with timezone: $ProjectDeadline"
    }
    $projectDeadlineText = $parsedProjectDeadline.ToString('yyyy-MM-ddTHH:mm:sszzz')
}

$repoState = 'NOT A REPOSITORY'
$gitCommand = Get-Command git -ErrorAction SilentlyContinue
if ($null -ne $gitCommand) {
    $previousErrorPreference = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'
    try {
        $gitRoot = (& $gitCommand.Source -C $resolvedTarget rev-parse --show-toplevel 2>$null)
        $gitProbeExit = $LASTEXITCODE
    }
    finally {
        $ErrorActionPreference = $previousErrorPreference
    }

    if ($gitProbeExit -eq 0 -and -not [string]::IsNullOrWhiteSpace($gitRoot)) {
        $previousErrorPreference = $ErrorActionPreference
        $ErrorActionPreference = 'Continue'
        try {
            $branch = (& $gitCommand.Source -C $resolvedTarget branch --show-current 2>$null)
            $head = (& $gitCommand.Source -C $resolvedTarget rev-parse HEAD 2>$null)
            $dirtyLines = @(& $gitCommand.Source -C $resolvedTarget status --short 2>$null)
        }
        finally {
            $ErrorActionPreference = $previousErrorPreference
        }
        $dirty = if ($dirtyLines.Count -eq 0) { 'CLEAN' } else { "DIRTY ($($dirtyLines.Count) paths)" }
        $repoState = "root=$gitRoot; branch=$branch; HEAD=$head; state=$dirty"
    }
}

$agentChecklistDirectory = Join-Path $resolvedTarget 'agent-checklists'
New-Item -ItemType Directory -Path $agentChecklistDirectory | Out-Null

foreach ($name in $coreFiles) {
    Copy-Item -LiteralPath (Join-Path $assetRoot $name) -Destination (Join-Path $resolvedTarget $name)
}
Copy-Item -LiteralPath (Join-Path $assetRoot 'AGENT_CHECKLIST_TEMPLATE.md') -Destination (Join-Path $resolvedTarget $coordinatorRelativePath)
if ($null -ne $visualDestinationRelativePath) {
    $visualDestinationPath = Join-Path $resolvedTarget $visualDestinationRelativePath
    New-Item -ItemType Directory -Path (Split-Path -Parent $visualDestinationPath) | Out-Null
    Copy-Item -LiteralPath $visualSourcePath -Destination $visualDestinationPath
}

$charterPath = Join-Path $resolvedTarget 'PROJECT_CHARTER.md'
$charter = Get-Content -LiteralPath $charterPath -Raw
$charter = Replace-Text $charter '- **Project:** `<name>`' "- **Project:** $ProjectName"
$charter = Replace-Text $charter '- **Plain-language outcome:** `<what must be true for the user>`' "- **Plain-language outcome:** $Outcome"
$charter = Replace-Text $charter '- **Authoritative root:** `<absolute path>`' "- **Authoritative root:** $resolvedTarget"
$charter = Replace-Text $charter '- **Repository/branch/HEAD:** `<repo, branch, commit or NOT A REPOSITORY>`' "- **Repository/branch/HEAD:** $repoState"
$charter = Replace-Text $charter '- **Coordinator:** `<agent/task/deeplink>`' '- **Coordinator:** Primary coordinator (current Codex task)'
$charter = Replace-Text $charter '- **Team mode:** `<SOLO / SMALL TEAM / FULL TEAM>`' "- **Team mode:** $TeamMode"
$charter = Replace-Text $charter '- **Autonomy boundary:** `<safe local decisions the Director may make without user input>`' '- **Autonomy boundary:** Safe, reversible local inspection, implementation, tests, renders, coordination, and recovery within assigned scope.'
$charter = Replace-Text $charter '- **Escalation boundary:** `<product choices, authority, destructive/external actions, acceptance>`' '- **Escalation boundary:** Material product ambiguity; destructive, difficult-to-reverse, external, public, financial, credential, or account actions; unavailable required inputs; final human acceptance.'
$visualReferenceText = if ([string]::IsNullOrWhiteSpace($VisualReference)) { 'NONE supplied at initialization' } else { $VisualReference }
$visualStateText = if ([string]::IsNullOrWhiteSpace($VisualViewportState)) { 'NONE supplied at initialization' } else { $VisualViewportState }
$skeletonApproverText = if ([string]::IsNullOrWhiteSpace($VisualReference)) { 'NOT APPLICABLE unless a controlling reference is added' } else { 'User' }
$charter = Replace-Text $charter '- **Controlling visual references:** `<paths/links or NONE>`' "- **Controlling visual references:** $visualReferenceText"
$charter = Replace-Text $charter '- **Controlling viewport and state:** `<dimensions, scale, populated state or NONE>`' "- **Controlling viewport and state:** $visualStateText"
$charter = Replace-Text $charter '- **Skeleton approver:** `<name/role or NOT APPLICABLE>`' "- **Skeleton approver:** $skeletonApproverText"
$charter = Replace-Text $charter '- **Start time:** `<ISO timestamp and timezone>`' "- **Start time:** $startedText"
$charter = Replace-Text $charter '- **Exact deadline:** `<ISO timestamp and timezone or NONE>`' "- **Exact deadline:** $projectDeadlineText"
$charter = Replace-Text $charter '- **Current first-slice deadline:** `<ISO timestamp and timezone>`' "- **Current first-slice deadline:** $deadlineText"
$charter = Replace-Text $charter '- **Deadline owner:** `<user/role>`' '- **Deadline owner:** User'
$charter = Replace-Text $charter '- **Overrun rule:** `<report project-deadline truth honestly; Director may replan slices but only the user may reduce the promised outcome>`' '- **Overrun rule:** Report project-deadline truth honestly. The Director may replan internal slices but only the user may reduce the promised outcome.'
$charter = Replace-Text $charter '- **Sol Max allocation owner:** `<Project Director>`' '- **Sol Max allocation owner:** Project Director'
$charter = Replace-Text $charter '- **Sol Max lane and reason:** `<task/IDs/complexity reason or NONE>`' '- **Sol Max lane and reason:** NONE at initialization; inspect complexity before allocating.'
$preMortemSample = '| PM-001 | `<for example: tests grow while real journey remains unattempted>` | `<measurable signal>` | `<rule/check/ownership>` | `<role>` | `<immediate action>` |'
$preMortemRows = @'
| PM-001 | The real acceptance journey remains unattempted while proxy work grows. | First checkpoint has no direct attempt or narrowly evidenced prerequisite. | Attempt the exact journey early and keep its state in the project pulse. | Coordinator | Stop proxy work and require the journey or exact blocker. |
| PM-002 | Tests and test infrastructure replace outcome delivery. | Three checks add no new decision or evidence for an open row. | Apply the test gate and drift alarm. | Lane owner | Park new tests and return to the current vertical slice. |
| PM-003 | Agents collide in shared files or systems. | Ownership is vague, overlapping, or absent from the board. | Refuse edits until exact ownership and transfer state are recorded. | Coordinator | Freeze the seam and resolve ownership before changes. |
| PM-004 | Weak evidence is used to claim the real outcome works. | Build, mock, source, or unit evidence is cited for a runtime/external/human claim. | Match every row to an explicit evidence class and coordinator review. | Reviewer | Reopen the row and run the matching acceptance evidence. |
| PM-005 | Deadline pressure causes scope drift or a false success claim. | Optional work continues after scope freeze or deadline state is vague. | Enforce midpoint, scope-freeze, and stabilization checkpoints. | Coordinator | Cut optional scope and report PASS, FAIL, PARTIAL, or BLOCKED truthfully. |
'@
$charter = Replace-Text $charter $preMortemSample $preMortemRows.TrimEnd()
Set-TextFile -Path $charterPath -Content $charter

$masterPath = Join-Path $resolvedTarget 'MASTER_CHECKLIST.md'
$master = Get-Content -LiteralPath $masterPath -Raw
$master = Replace-Text $master '- **Exact user request:** `<quote or faithful one-sentence restatement>`' "- **Exact user request:** $Outcome"
$master = Replace-Text $master '- **Observable success:** `<what the user can do and observe>`' "- **Observable success:** $Outcome"
$master = Replace-Text $master '- **Exact acceptance journey:** `<starting state -> action -> authoritative success -> persistence/recovery>`' "- **Exact acceptance journey:** $AcceptanceJourney"
$master = Replace-Text $master '- **Primary master row:** `<one Critical ID>`' '- **Primary master row:** REQ-001'
$master = Replace-Text $master '- **Candidate/environment required:** `<real app/build/device/account>`' '- **Candidate/environment required:** Inspect and record the exact real candidate and environment before claiming completion.'
$master = Replace-Text $master '- **Current candidate classification:** `<DEVELOPMENT / DIAGNOSTIC / INTEGRATION / RELEASE CANDIDATE / RELEASED>`' '- **Current candidate classification:** DEVELOPMENT'
$master = Replace-Text $master '- **Candidate promotion justification:** `<master row, changed bytes, passed prerequisites, next decisive journey, or NOT YET ELIGIBLE>`' '- **Candidate promotion justification:** NOT YET ELIGIBLE; research and plan are not accepted.'
$master = Replace-Text $master '- **Current truth:** `<NOT ATTEMPTED / FAIL / PARTIAL / PASS at exact evidence level>`' '- **Current truth:** NOT ATTEMPTED'
$master = Replace-Text $master '- **Last direct attempt:** `<time, candidate, result, EV-###>`' '- **Last direct attempt:** NOT RUN; no evidence yet.'
$master = Replace-Text $master '- **Successive failed candidates for this journey:** `<count and identities>`' '- **Successive failed candidates for this journey:** 0; none.'
$master = Replace-Text $master '- **Two-candidate circuit breaker:** `<CLEAR / TRIGGERED; required plan/review evidence>`' '- **Two-candidate circuit breaker:** CLEAR; no candidate attempt exists.'
$master = Replace-Text $master '- **Known exact blocker:** `<fact or UNKNOWN; never vague>`' '- **Known exact blocker:** UNKNOWN'
$master = Replace-Text $master '- **Adjacent work allowed before success:** `<only work required for this outcome>`' '- **Adjacent work allowed before success:** Only work mapped to REQ-001, a required gate, or a narrowly evidenced blocker.'
$master = Replace-Text $master '- **Exact deadline:** `<ISO timestamp and timezone or NONE>`' "- **Exact deadline:** $projectDeadlineText"
$master = Replace-Text $master '- **Current slice deadline:** `<ISO timestamp and timezone>`' "- **Current slice deadline:** $deadlineText"
$master = Replace-Text $master '- **Timebox stage:** `<EARLY / MIDPOINT / SCOPE FREEZE / STABILIZE / OVERRUN>`' '- **Timebox stage:** EARLY'
$requirementsSample = @'
| [ ] | REQ-001 | `<one observable outcome>` | Critical | `<lane>` | `<class and exact proof>` | `<EV-###>` | `<risk/dependency>` |
| [ ] | REQ-002 | `<one observable outcome>` | High | `<lane>` | `<class and exact proof>` | `<EV-###>` | `<risk/dependency>` |
'@
$requirementsRow = "| [ ] | REQ-001 | $Outcome | Critical | Primary outcome lane | Exact acceptance journey on the real candidate at the promised evidence level | NOT RUN | Deadline $deadlineText |"
$master = Replace-Text $master $requirementsSample.TrimEnd() $requirementsRow
Set-TextFile -Path $masterPath -Content $master

$researchPath = Join-Path $resolvedTarget 'PRIOR_ART_RESEARCH.md'
$research = Get-Content -LiteralPath $researchPath -Raw
$research = Replace-Text $research '- **Locked user outcome:** `<master ID and one sentence>`' "- **Locked user outcome:** REQ-001 - $Outcome"
$research = Replace-Text $research '- **Research owner/task:** `<task ID/deeplink>`' "- **Research owner/task:** $DirectorTaskId / $DirectorDeeplink until an explicit research task is created"
Set-TextFile -Path $researchPath -Content $research

$planPath = Join-Path $resolvedTarget 'PROJECT_PLAN.md'
$plan = Get-Content -LiteralPath $planPath -Raw
$plan = Replace-Text $plan '- **Locked user outcome:** `<one observable result>`' "- **Locked user outcome:** $Outcome"
$plan = Replace-Text $plan '- **Acceptance journey:** `<starting state -> user action -> authoritative result -> persistence/recovery>`' "- **Acceptance journey:** $AcceptanceJourney"
$plan = Replace-Text $plan '- **Instructions and mockups inspected:** `<paths/links/versions>`' "- **Instructions and mockups inspected:** $visualReferenceText"
$plan = Replace-Text $plan '- **Existing project/code inspected:** `<root, relevant architecture, constraints>`' "- **Existing project/code inspected:** $resolvedTarget; $repoState"
$plan = Replace-Text $plan '- **Deadline/timebox:** `<timestamp and timezone>`' "- **Deadline/timebox:** $deadlineText"
Set-TextFile -Path $planPath -Content $plan

$boardPath = Join-Path $resolvedTarget 'COORDINATION_BOARD.md'
$board = Get-Content -LiteralPath $boardPath -Raw
$board = Replace-Text $board '- **Coordinator:** `<name/task/deeplink>`' '- **Coordinator:** Primary coordinator (current Codex task)'
$board = Replace-Text $board '- **Team mode and active roles:** `<SOLO/SMALL/FULL; roles>`' "- **Team mode and active roles:** $TeamMode; Project Director active, other top-level tasks pending inspected lane design"
$board = Replace-Text $board '- **Last reconciled:** `<ISO timestamp>`' "- **Last reconciled:** $snapshotText"
$board = Replace-Text $board '- **Planned durable lanes lacking create_thread receipt:** `<IDs/lanes or NONE>`' '- **Planned durable lanes lacking create_thread receipt:** NONE at initialization; implementation lanes are not authorized until the plan is accepted and their receipts are registered.'
$board = Replace-Text $board '- **Subagents currently carrying durable work:** `<MUST BE NONE>`' '- **Subagents currently carrying durable work:** NONE'
$board = Replace-Text $board '- **Primary outcome state:** `<NOT ATTEMPTED/FAIL/PARTIAL/PASS and EV-###>`' '- **Primary outcome state:** NOT ATTEMPTED; no evidence yet.'
$board = Replace-Text $board '- **Last direct acceptance attempt:** `<time/candidate/result>`' '- **Last direct acceptance attempt:** NOT RUN'
$board = Replace-Text $board '- **Current candidate classification:** `<DEVELOPMENT/DIAGNOSTIC/INTEGRATION/RELEASE CANDIDATE/RELEASED>`' '- **Current candidate classification:** DEVELOPMENT'
$board = Replace-Text $board '- **Successive failed candidates for primary journey:** `<count and identities>`' '- **Successive failed candidates for primary journey:** 0; none.'
$board = Replace-Text $board '- **Two-candidate circuit breaker:** `<CLEAR/TRIGGERED; required repair/review>`' '- **Two-candidate circuit breaker:** CLEAR; no candidate attempt exists.'
$board = Replace-Text $board '- **Claim-scoped health:** `<component/journey states; overall status>`' '- **Claim-scoped health:** Primary journey NOT RUN; overall product status NOT RUN.'
$board = Replace-Text $board '- **Project deadline / current slice deadline:** `<project deadline or NONE> / <slice timestamp and calculated remainder>`' "- **Project deadline / current slice deadline:** $projectDeadlineText / $deadlineText; $TimeboxMinutes minutes in current slice at initialization"
$board = Replace-Text $board '- **Current timebox stage:** `<EARLY/MIDPOINT/SCOPE FREEZE/STABILIZE/OVERRUN>`' '- **Current timebox stage:** EARLY'
$board = Replace-Text $board '- **Pre-mortem warnings currently triggered:** `<PM IDs or none>`' '- **Pre-mortem warnings currently triggered:** none at initialization'
Set-TextFile -Path $boardPath -Content $board

$communicationPath = Join-Path $resolvedTarget 'AGENT_COMMUNICATION.md'
$communication = Get-Content -LiteralPath $communicationPath -Raw
$communication = Replace-Text $communication '- **Project Director task:** `<exact task title>`' "- **Project Director task:** $DirectorTaskTitle"
$communication = Replace-Text $communication '- **Task ID:** `<exact ID>`' "- **Task ID:** $DirectorTaskId"
$communication = Replace-Text $communication '- **Deeplink:** `<exact copied deeplink>`' "- **Deeplink:** $DirectorDeeplink"
$communication = Replace-Text $communication '- **Last verified reachable:** `<ISO timestamp>`' "- **Last verified reachable:** $snapshotText"
$directorDirectoryRow = '| Project Director | {0} | `current task` | {1} | {2} | `agent-checklists/coordinator.md` | Master, board, routing, integration decisions | User only at escalation boundary | ACTIVE | {3} |' -f $DirectorTaskTitle, $DirectorTaskId, $DirectorDeeplink, $snapshotText
$communication = Replace-Text $communication '| Project Director | `<title>` | `current task` | `<ID>` | `<deeplink>` | `agent-checklists/coordinator.md` | Master, board, routing, integration decisions | User only at escalation boundary | ACTIVE | `<time>` |' $directorDirectoryRow
Set-TextFile -Path $communicationPath -Content $communication

$coordinatorPath = Join-Path $resolvedTarget $coordinatorRelativePath
$coordinator = Get-Content -LiteralPath $coordinatorPath -Raw
$coordinator = Replace-Text $coordinator '- **Agent/task/deeplink:** `<identity>`' '- **Agent/task/deeplink:** Primary coordinator (current Codex task)'
$coordinator = Replace-Text $coordinator '- **Task type:** `<TOP-LEVEL CODEX TASK / CURRENT DIRECTOR TASK>`' '- **Task type:** CURRENT DIRECTOR TASK'
$coordinator = Replace-Text $coordinator '- **Creation mechanism/receipt:** `<create_thread plus returned receipt / current Director task>`' '- **Creation mechanism/receipt:** current Director task'
$coordinator = Replace-Text $coordinator '- **Subagent status:** `<NOT A SUBAGENT>`' '- **Subagent status:** NOT A SUBAGENT'
$coordinator = Replace-Text $coordinator '- **Lane outcome:** `<plain-language result>`' '- **Lane outcome:** Keep the project focused, collision-free, timeboxed, and evidence-backed.'
$coordinator = Replace-Text $coordinator '- **Primary outcome lock:** `<exact master outcome this lane must advance>`' "- **Primary outcome lock:** $Outcome"
$coordinator = Replace-Text $coordinator '- **Exact acceptance journey:** `<real starting state -> user action -> authoritative result>`' "- **Exact acceptance journey:** $AcceptanceJourney"
$coordinator = Replace-Text $coordinator '- **Critical journey transaction contract:** `<PROJECT_PLAN.md section/transition IDs or NOT APPLICABLE with reason>`' '- **Critical journey transaction contract:** PENDING accepted PROJECT_PLAN.md; implementation is blocked until classified.'
$coordinator = Replace-Text $coordinator '- **Change impact classification:** `<LOCAL/SHARED SEAM/PERSISTENT MIGRATION/EXTERNAL-EFFECT TRANSACTION/CROSS-CUTTING INVARIANT>`' '- **Change impact classification:** PENDING inspected plan.'
$coordinator = Replace-Text $coordinator '- **Coordinator:** `<identity>`' '- **Coordinator:** Self; primary coordinator (current Codex task)'
$coordinator = Replace-Text $coordinator '- **Parent master checklist:** `../MASTER_CHECKLIST.md`' '- **Parent master checklist:** `../MASTER_CHECKLIST.md`'
$coordinator = Replace-Text $coordinator '- **Assigned master IDs:** `<exact IDs>`' '- **Assigned master IDs:** REQ-001, GATE-001 through GATE-024'
$coordinator = Replace-Text $coordinator '- **Authoritative root/branch/HEAD:** `<path and identity>`' "- **Authoritative root/branch/HEAD:** $resolvedTarget; $repoState"
$coordinator = Replace-Text $coordinator '- **Exact write ownership:** `<files, folders, regions, resources>`' '- **Exact write ownership:** Project control Markdown files and coordination records; implementation ownership must be assigned separately.'
$coordinator = Replace-Text $coordinator '- **Start/deadline:** `<ISO timestamps and timezone>`' "- **Start/deadline:** $startedText / $deadlineText"
$coordinator = Replace-Text $coordinator '- **Lane time budget:** `<duration>`' "- **Lane time budget:** $TimeboxMinutes minutes"
$coordinator = Replace-Text $coordinator '- **Model/effort:** `<Luna Max read-only; Sol Low/Light for bounded QA; Sol Medium default; or Sol Max>`' '- **Model/effort:** Sol Medium'
$coordinator = Replace-Text $coordinator '- **Why this effort level is proportionate:** `<normal lane or exact complex critical reason>`' '- **Why this effort level is proportionate:** Default Director and coordination workload.'
$coordinator = Replace-Text $coordinator '- **Timebox stage:** `<EARLY/MIDPOINT/SCOPE FREEZE/STABILIZE/OVERRUN>`' '- **Timebox stage:** EARLY'
$coordinator = Replace-Text $coordinator '- **Assigned pre-mortem risks:** `<PM IDs and warning triggers>`' '- **Assigned pre-mortem risks:** PM-001 through PM-005'
$coordinator = Replace-Text $coordinator '- **Controlling visual reference/viewport/state:** `<exact identity or NOT APPLICABLE>`' "- **Controlling visual reference/viewport/state:** $visualReferenceText; $visualStateText"
$coordinator = Replace-Text $coordinator '- **Skeleton gate status:** `<NOT APPLICABLE/OPEN/READY/APPROVED and EV-###>`' "- **Skeleton gate status:** $(if ([string]::IsNullOrWhiteSpace($VisualReference)) { 'NOT APPLICABLE unless a controlling reference is added' } else { 'OPEN; no evidence yet' })"
$coordinator = Replace-Text $coordinator '- **Shared runtime access:** `<NONE/READ-ONLY/ISOLATED SANDBOX/EXCLUSIVE LOCK and exact target>`' '- **Shared runtime access:** NONE at initialization'
$coordinator = Replace-Text $coordinator '- **Runtime lock receipt:** `<RLOCK-### or NOT APPLICABLE>`' '- **Runtime lock receipt:** NOT APPLICABLE at initialization'
$coordinator = Replace-Text $coordinator '- **Decision/review deadline:** `<exact timestamp and fallback owner>`' "- **Decision/review deadline:** $deadlineText; fallback owner Project Director"
$coordinator = Replace-Text $coordinator '- **Workspace isolation:** `<same-tree exact paths / worktree / isolated copy; root and base identity>`' '- **Workspace isolation:** Project Director control files only; implementation task workspaces pending inspection.'
$coordinator = Replace-Text $coordinator '- **Shared seam contracts:** `<SEAM-### IDs or none>`' '- **Shared seam contracts:** none at initialization'
$coordinator = Replace-Text $coordinator '- **Resource budget/attempt limit:** `<model/usage/disk/RAM/GPU/processes/whole-path attempts>`' '- **Resource budget/attempt limit:** Set one whole-path attempt limit; add resource caps only if this project actually needs them.'
$coordinator = Replace-Text $coordinator '- **Task-owned background processes:** `<PIDs/components/purpose/stop condition or none>`' '- **Task-owned background processes:** none at initialization'
$coordinator = Replace-Text $coordinator '- **Visible UI authority:** `<background-only or exact allowed interaction>`' '- **Visible UI authority:** background-only unless user asks or a genuine human interaction boundary requires it'
$coordinator = Replace-Text $coordinator '- **Active correction IDs:** `<CORR-### IDs or NONE>`' '- **Active correction IDs:** NONE at initialization'
$coordinator = Replace-Text $coordinator '- **Correction acknowledgment receipt:** `<exact replacement behavior acknowledged at timestamp>`' '- **Correction acknowledgment receipt:** NOT APPLICABLE at initialization'
$coordinator = Replace-Text $coordinator '- **Current vertical slice:** `<one usable feature, repair, artifact, or decisive investigation>`' '- **Current vertical slice:** Bootstrap only: inspect references/project, synthesize intent, research prior art, produce the plan, then derive detailed checklists.'
$coordinator = Replace-Text $coordinator '- **Slice exit condition:** `<observable result and exact proof>`' '- **Slice exit condition:** PROJECT_PLAN.md is accepted and every planned promise maps to a stable master ID.'
$coordinator = Replace-Text $coordinator '- **Tests permitted before slice review:** `<smallest checks needed and why>`' '- **Tests permitted before slice review:** Only checks that directly locate or prove the REQ-001 path.'
$coordinator = Replace-Text $coordinator '- **Last direct attempt of the real journey:** `<time/candidate/PASS-FAIL-NOT RUN/EV-###>`' '- **Last direct attempt of the real journey:** NOT RUN'
$coordinator = Replace-Text $coordinator '- **Current candidate classification:** `<DEVELOPMENT/DIAGNOSTIC/INTEGRATION/RELEASE CANDIDATE/RELEASED>`' '- **Current candidate classification:** DEVELOPMENT'
$coordinator = Replace-Text $coordinator '- **Candidate promotion justification:** `<row/change/prerequisites/decisive journey/stop result or NOT ELIGIBLE>`' '- **Candidate promotion justification:** NOT ELIGIBLE; research and plan are not accepted.'
$coordinator = Replace-Text $coordinator '- **Successive failed candidates for this journey:** `<count and identities>`' '- **Successive failed candidates for this journey:** 0; none.'
$coordinator = Replace-Text $coordinator '- **Two-candidate circuit breaker:** `<CLEAR/TRIGGERED; plan/review needed>`' '- **Two-candidate circuit breaker:** CLEAR; no candidate attempt exists.'
$coordinator = Replace-Text $coordinator '- **Claim-scoped health:** `<component states; overall cannot exceed weakest Critical row>`' '- **Claim-scoped health:** Primary journey NOT RUN; overall product status NOT RUN.'
$coordinator = Replace-Text $coordinator '- **Movement on locked outcome:** `<observable change or NONE>`' '- **Movement on locked outcome:** NONE at initialization'
$coordinator = Replace-Text $coordinator '- **Failed approaches since last escalation:** `<count and short references>`' '- **Failed approaches since last escalation:** 0'
$coordinator = Replace-Text $coordinator '- **Time remaining / deadline health:** `<calculated remainder; ON TRACK/AT RISK/MISSED>`' "- **Time remaining / deadline health:** $TimeboxMinutes minutes at initialization; ON TRACK"
$coordinator = Replace-Text $coordinator '- **Next safe action:** `<one concrete action>`' '- **Next safe action:** Complete the bounded prior-art brief, then produce PROJECT_PLAN.md before creating implementation tasks.'
Set-TextFile -Path $coordinatorPath -Content $coordinator

Write-Output "Project controls initialized: $resolvedTarget"
Write-Output "Project: $ProjectName"
Write-Output "Primary outcome: $Outcome"
Write-Output "Acceptance journey: $AcceptanceJourney"
Write-Output "Timebox: $startedText to $deadlineText ($TimeboxMinutes minutes)"
Write-Output "Project deadline: $projectDeadlineText"
Write-Output "Director address: $DirectorTaskId / $DirectorDeeplink"
Write-Output "Created files: $($coreFiles.Count + 1)"
Write-Output 'Next: inspect references and project state, complete bounded prior-art research, accept PROJECT_PLAN.md, derive detailed checklists, then run Test-ProjectControls.ps1 -Strict.'
exit 0
