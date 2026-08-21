[CmdletBinding()]
param(
    [switch]$KeepFixtures
)

$ErrorActionPreference = 'Stop'
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$initializer = Join-Path $scriptRoot 'Initialize-ProjectStart.ps1'
$validator = Join-Path $scriptRoot 'Test-ProjectControls.ps1'
$pwsh = Join-Path $PSHOME 'pwsh.exe'
if (-not (Test-Path -LiteralPath $pwsh -PathType Leaf)) {
    throw "PowerShell runtime not found: $pwsh"
}

$tempBase = [System.IO.Path]::GetFullPath([System.IO.Path]::GetTempPath())
$suiteRoot = [System.IO.Path]::GetFullPath((Join-Path $tempBase ('ProjectStart-Regression-' + [guid]::NewGuid().ToString())))
if (-not $suiteRoot.StartsWith($tempBase, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "Unsafe regression fixture root: $suiteRoot"
}
New-Item -ItemType Directory -Path $suiteRoot | Out-Null

$directorId = '11111111-1111-4111-8111-111111111111'
$coreId = '22222222-2222-4222-8222-222222222222'
$uiId = '33333333-3333-4333-8333-333333333333'
$directorLink = "codex://threads/$directorId"
$coreLink = "codex://threads/$coreId"
$uiLink = "codex://threads/$uiId"
$actualModel = 'gpt-5.6-sol / medium; verified from host read-back'
$timestamp = '2026-08-21T12:00:00-05:00'

function Get-Raw {
    param([Parameter(Mandatory = $true)][string]$Path)
    return Get-Content -LiteralPath $Path -Raw
}

function Set-Raw {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string]$Content
    )
    [System.IO.File]::WriteAllText($Path, $Content, [System.Text.UTF8Encoding]::new($false))
}

function Set-Field {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string]$Label,
        [Parameter(Mandatory = $true)][string]$Value
    )
    $content = Get-Raw $Path
    $pattern = '(?m)^- \*\*' + [regex]::Escape($Label) + ':\*\* .+$'
    if (-not [regex]::IsMatch($content, $pattern)) {
        throw "Fixture field not found: $Path / $Label"
    }
    Set-Raw $Path ([regex]::Replace($content, $pattern, "- **${Label}:** $Value", 1))
}

function Replace-SectionSampleRow {
    param(
        [Parameter(Mandatory = $true)][string]$Content,
        [Parameter(Mandatory = $true)][string]$SectionTitle,
        [Parameter(Mandatory = $true)][string]$SamplePattern,
        [Parameter(Mandatory = $true)][string[]]$Rows
    )
    $sectionStart = $Content.IndexOf("## $SectionTitle", [System.StringComparison]::Ordinal)
    if ($sectionStart -lt 0) {
        throw "Fixture section not found: $SectionTitle"
    }
    $nextSection = $Content.IndexOf("`n## ", $sectionStart + 3, [System.StringComparison]::Ordinal)
    if ($nextSection -lt 0) {
        $nextSection = $Content.Length
    }
    $section = $Content.Substring($sectionStart, $nextSection - $sectionStart)
    if (-not [regex]::IsMatch($section, $SamplePattern, [System.Text.RegularExpressions.RegexOptions]::Multiline)) {
        throw "Fixture sample row not found in section: $SectionTitle"
    }
    $replacement = $Rows -join [Environment]::NewLine
    $section = [regex]::Replace($section, $SamplePattern, $replacement, [System.Text.RegularExpressions.RegexOptions]::Multiline)
    return $Content.Substring(0, $sectionStart) + $section + $Content.Substring($nextSection)
}

function Invoke-Audit {
    param(
        [Parameter(Mandatory = $true)][string]$Target,
        [switch]$Strict
    )
    $arguments = @('-NoProfile', '-File', $validator, '-TargetPath', $Target)
    if ($Strict) {
        $arguments += '-Strict'
    }
    $output = @(& $pwsh @arguments 2>&1)
    return [pscustomobject]@{
        ExitCode = $LASTEXITCODE
        Text = ($output -join [Environment]::NewLine)
    }
}

function Assert-Audit {
    param(
        [Parameter(Mandatory = $true)][string]$Name,
        [Parameter(Mandatory = $true)]$Result,
        [Parameter(Mandatory = $true)][int]$ExitCode,
        [string]$Contains
    )
    if ($Result.ExitCode -ne $ExitCode) {
        throw "$Name expected exit $ExitCode but received $($Result.ExitCode).$([Environment]::NewLine)$($Result.Text)"
    }
    if (-not [string]::IsNullOrWhiteSpace($Contains) -and -not $Result.Text.Contains($Contains)) {
        throw "$Name did not contain expected text: $Contains$([Environment]::NewLine)$($Result.Text)"
    }
    Write-Output "PASS: $Name"
}

function Copy-Fixture {
    param(
        [Parameter(Mandatory = $true)][string]$Source,
        [Parameter(Mandatory = $true)][string]$Name
    )
    $destination = Join-Path $suiteRoot $Name
    Copy-Item -LiteralPath $Source -Destination $destination -Recurse
    foreach ($file in Get-ChildItem -LiteralPath $destination -Filter '*.md' -File -Recurse) {
        $content = (Get-Raw $file.FullName).Replace($Source, $destination)
        Set-Raw $file.FullName $content
    }
    return $destination
}

function New-StrictFixture {
    param([Parameter(Mandatory = $true)][string]$Root)

    $activeDocuments = @(
        'PROJECT_STATE.md',
        'PROJECT_CHARTER.md',
        'MASTER_CHECKLIST.md',
        'PRIOR_ART_RESEARCH.md',
        'PROJECT_PLAN.md',
        'COORDINATION_BOARD.md',
        'AGENT_COMMUNICATION.md',
        'agent-checklists\coordinator.md'
    )
    foreach ($relativePath in $activeDocuments) {
        $path = Join-Path $Root $relativePath
        Set-Raw $path ([regex]::Replace((Get-Raw $path), '<[^>\r\n]+>', 'RESOLVED'))
    }

    $researchPath = Join-Path $Root 'PRIOR_ART_RESEARCH.md'
    $research = Get-Raw $researchPath
    $research = Replace-SectionSampleRow $research 'Candidate register' '^\| (?:`RESOLVED`|RESOLVED) \|.*$' @('| https://example.invalid/source | Conversion behavior | Documented formula | MIT; LEARN ONLY | Primary-source fixture | LEARN |')
    $research = Replace-SectionSampleRow $research 'Baseline capability matrix' '^\| (?:`RESOLVED`|RESOLVED) \|.*$' @('| Complete conversion journey | Official category documentation | Ordinary user expectation | REQUIRED NOW | Primary outcome | REQ-001 |')
    $research = Replace-SectionSampleRow $research 'Reuse decision' '^\| (?:`RESOLVED`|RESOLVED) \|.*$' @('| Conversion formula | BUILD | NONE | Small project-specific implementation | Focused test and real journey |')
    Set-Raw $researchPath $research

    $coreProject = "$Root; worktree=core"
    $uiProject = "$Root; worktree=ui"

    $planPath = Join-Path $Root 'PROJECT_PLAN.md'
    $plan = Get-Raw $planPath
    $plan = $plan.Replace('**Plan state:** `RESOLVED`', '**Plan state:** ACCEPTED')
    $plan = $plan.Replace('**Decision ID:** `RESOLVED`', '**Decision ID:** DEC-001')
    $corePlanRow = "| CORE | Core Engine | REQ-001 and production ownership | ``create_thread`` | WAVE-1 | NONE | src/core | src/ui | SEAM-001 | Sol Medium for normal implementation | $coreProject | commit and EV-CORE |"
    $uiPlanRow = "| UI | User Interface | REQ-001 and production ownership | ``create_thread`` | WAVE-1 | NONE | src/ui | src/core | SEAM-001 | Sol Medium for normal implementation | $uiProject | commit and EV-UI |"
    $plan = Replace-SectionSampleRow $plan 'Top-level task design' '^\| (?:`RESOLVED`|RESOLVED) \| (?:`RESOLVED`|RESOLVED) \|.*$' @($corePlanRow, $uiPlanRow)
    Set-Raw $planPath $plan

    $statePath = Join-Path $Root 'PROJECT_STATE.md'
    Set-Field $statePath 'Plan state/decision' 'ACCEPTED DEC-001'
    Set-Field $statePath 'Current phase' 'DEVELOPMENT'
    Set-Field $statePath 'Ready independent lanes' 'CORE; UI'
    Set-Field $statePath 'Running ready lanes' '2'
    Set-Field $statePath 'Useful concurrency target' '2'
    Set-Field $statePath 'Under-utilization reason' 'NONE'
    Set-Field $statePath 'Next launch wave' 'WAVE-1 running: CORE; UI'
    Set-Field $statePath 'Last launch/replenishment receipt' "$timestamp; launched/resumed CORE and UI; create/send receipts verified."
    Set-Field $statePath 'Director wait state/receipt' "WAITING; $timestamp; wait_threads targets CORE=$coreId cursor=core-1 and UI=$uiId cursor=ui-1."
    $state = Get-Raw $statePath
    $directorStateMatch = [regex]::Match($state, '(?m)^\| DIRECTOR \|.*$')
    if (-not $directorStateMatch.Success) {
        throw 'Fixture Director state row not found.'
    }
    $coreStateRow = "| CORE | $coreId and $coreLink | $actualModel | $coreProject | ACTIVE | Core vertical slice | NONE | Implement assigned row | $timestamp |"
    $uiStateRow = "| UI | $uiId and $uiLink | $actualModel | $uiProject | ACTIVE | UI vertical slice | NONE | Implement assigned row | $timestamp |"
    $state = $state.Replace($directorStateMatch.Value, $directorStateMatch.Value + [Environment]::NewLine + $coreStateRow + [Environment]::NewLine + $uiStateRow)
    Set-Raw $statePath $state

    $boardPath = Join-Path $Root 'COORDINATION_BOARD.md'
    Set-Field $boardPath 'Last state rehydration' "$timestamp; USER TURN; controls and task read-backs reconciled."
    Set-Field $boardPath 'Ready independent lanes' 'CORE; UI'
    Set-Field $boardPath 'Running ready lanes' '2'
    Set-Field $boardPath 'Useful concurrency target' '2'
    Set-Field $boardPath 'Under-utilization reason' 'NONE'
    Set-Field $boardPath 'Next launch wave' 'WAVE-1 running: CORE; UI'
    Set-Field $boardPath 'Last launch/replenishment receipt' "$timestamp; launched/resumed CORE and UI; create/send receipts verified."
    Set-Field $boardPath 'Director wait state/receipt' "WAITING; $timestamp; wait_threads targets CORE=$coreId cursor=core-1 and UI=$uiId cursor=ui-1."
    Set-Field $boardPath 'Active tasks' '3'
    $board = Get-Raw $boardPath
    $directorBoardRow = "| DIRECTOR | Project Director | current task | $directorId / $directorLink | $actualModel | $Root; NOT A REPOSITORY | ``agent-checklists/coordinator.md`` | GATE-001 through GATE-030 | Project controls | NONE | current timebox | production files | LIVE | ``ACTIVE`` | $timestamp | Coordinate |"
    $coreBoardRow = "| CORE | Core Engine | create_thread / receipt; NEW because no task existed | $coreId / $coreLink | $actualModel | $coreProject | ``agent-checklists/core.md`` | REQ-001 | src/core | NONE | current timebox | src/ui | LIVE | ``ACTIVE`` | $timestamp | Implement |"
    $uiBoardRow = "| UI | User Interface | create_thread / receipt; NEW because no task existed | $uiId / $uiLink | $actualModel | $uiProject | ``agent-checklists/ui.md`` | REQ-001 | src/ui | NONE | current timebox | src/core | LIVE | ``ACTIVE`` | $timestamp | Implement |"
    $board = Replace-SectionSampleRow $board 'Agent registry' '^\| (?:`RESOLVED`|RESOLVED) \| (?:`RESOLVED`|RESOLVED) \|.*$' @($directorBoardRow, $coreBoardRow, $uiBoardRow)
    Set-Raw $boardPath $board

    $communicationPath = Join-Path $Root 'AGENT_COMMUNICATION.md'
    $communication = Get-Raw $communicationPath
    $coreCommunicationRow = "| CORE | Core Engine | Core Engine Task | ``create_thread / receipt; NEW because no task existed`` | $coreId | $coreLink | $actualModel | $coreProject | ``agent-checklists/core.md`` | REQ-001 and src/core | Project Director | LIVE | ACTIVE | $timestamp |"
    $uiCommunicationRow = "| UI | User Interface | User Interface Task | ``create_thread / receipt; NEW because no task existed`` | $uiId | $uiLink | $actualModel | $uiProject | ``agent-checklists/ui.md`` | REQ-001 and src/ui | Project Director | LIVE | ACTIVE | $timestamp |"
    $communication = Replace-SectionSampleRow $communication 'Task directory' '^\| (?:`RESOLVED`|RESOLVED) \| (?:`RESOLVED`|RESOLVED) \|.*$' @($coreCommunicationRow, $uiCommunicationRow)
    Set-Raw $communicationPath $communication

    $coordinatorPath = Join-Path $Root 'agent-checklists\coordinator.md'
    foreach ($lane in @(
        @{ Id = 'CORE'; TaskId = $coreId; Link = $coreLink; Project = $coreProject; Path = 'agent-checklists\core.md'; Outcome = 'Core Engine Task' },
        @{ Id = 'UI'; TaskId = $uiId; Link = $uiLink; Project = $uiProject; Path = 'agent-checklists\ui.md'; Outcome = 'User Interface Task' }
    )) {
        $destination = Join-Path $Root $lane.Path
        Copy-Item -LiteralPath $coordinatorPath -Destination $destination
        Set-Field $destination 'Agent/task/deeplink' "$($lane.Outcome); $($lane.TaskId); $($lane.Link)"
        Set-Field $destination 'Stable lane ID' $lane.Id
        Set-Field $destination 'Task type' 'TOP-LEVEL CODEX TASK'
        Set-Field $destination 'Creation mechanism/receipt' 'create_thread / receipt'
        Set-Field $destination 'Actual task startup read-back' "$timestamp; $($lane.TaskId); $($lane.Link); model/effort=$actualModel; actual project/root/worktree=$($lane.Project); checklist=$($lane.Path.Replace('\','/')); status=ACTIVE"
        Set-Field $destination 'Replacement/reuse receipt' 'NEW because no registered task existed'
        Set-Field $destination 'Subagent status' 'NOT A SUBAGENT'
    }
}

$passed = $false
try {
    $base = Join-Path $suiteRoot 'base'
    New-Item -ItemType Directory -Path $base | Out-Null
    $initOutput = @(& $pwsh -NoProfile -File $initializer `
        -TargetPath $base `
        -ProjectName 'Regression Fixture' `
        -DirectorTaskTitle 'Project Director' `
        -DirectorTaskId $directorId `
        -DirectorDeeplink $directorLink `
        -DirectorModelEffort $actualModel `
        -Outcome 'The exact user journey works.' `
        -AcceptanceJourney 'Launch -> action -> result -> restart persistence' `
        -TeamMode 'SMALL TEAM' 2>&1)
    if ($LASTEXITCODE -ne 0) {
        throw "Initializer failed.$([Environment]::NewLine)$($initOutput -join [Environment]::NewLine)"
    }

    Assert-Audit 'fresh initialization activation' (Invoke-Audit $base) 0 'PASS:'
    Assert-Audit 'pre-plan strict mode fails closed' (Invoke-Audit $base -Strict) 1 'Plan state must be ACCEPTED'

    New-StrictFixture $base
    Assert-Audit 'fully resolved strict fixture' (Invoke-Audit $base -Strict) 0 'PASS:'

    $serialized = Copy-Fixture $base 'negative-serialized'
    Set-Field (Join-Path $serialized 'PROJECT_STATE.md') 'Running ready lanes' '1'
    Set-Field (Join-Path $serialized 'COORDINATION_BOARD.md') 'Running ready lanes' '1'
    Assert-Audit 'serialized ready lanes are rejected' (Invoke-Audit $serialized -Strict) 1 'running ready lanes must equal the useful concurrency target'

    $singleWait = Copy-Fixture $base 'negative-single-target-wait'
    $singleWaitReceipt = "WAITING; $timestamp; wait_threads targets CORE=$coreId cursor=core-1."
    Set-Field (Join-Path $singleWait 'PROJECT_STATE.md') 'Director wait state/receipt' $singleWaitReceipt
    Set-Field (Join-Path $singleWait 'COORDINATION_BOARD.md') 'Director wait state/receipt' $singleWaitReceipt
    Assert-Audit 'single-target wait omitting a ready lane is rejected' (Invoke-Audit $singleWait -Strict) 1 "wait_threads receipt omits ready lane 'UI'"

    $wrongProject = Copy-Fixture $base 'negative-wrong-project'
    $wrongCommunication = Join-Path $wrongProject 'AGENT_COMMUNICATION.md'
    Set-Raw $wrongCommunication ((Get-Raw $wrongCommunication).Replace("| $actualModel | $wrongProject; worktree=ui | ``agent-checklists/ui.md`` |", "| $actualModel | C:\WrongProject; worktree=ui | ``agent-checklists/ui.md`` |"))
    Assert-Audit 'wrong task project is rejected' (Invoke-Audit $wrongProject -Strict) 1 'actual project/root/worktree does not name the authoritative project root'

    $unverified = Copy-Fixture $base 'negative-unverified-startup'
    $unverifiedCommunication = Join-Path $unverified 'AGENT_COMMUNICATION.md'
    Set-Raw $unverifiedCommunication ((Get-Raw $unverifiedCommunication).Replace("| UI | User Interface | User Interface Task | ``create_thread / receipt; NEW because no task existed`` | $uiId | $uiLink | $actualModel |", "| UI | User Interface | User Interface Task | ``create_thread / receipt; NEW because no task existed`` | $uiId | $uiLink | NOT VERIFIED |"))
    Assert-Audit 'unverified actual model is rejected' (Invoke-Audit $unverified -Strict) 1 'lacks verified actual model'

    $subagentLane = Copy-Fixture $base 'negative-subagent-lane'
    Set-Field (Join-Path $subagentLane 'agent-checklists\core.md') 'Creation mechanism/receipt' 'spawn_agent / hidden nested worker'
    Set-Field (Join-Path $subagentLane 'agent-checklists\core.md') 'Subagent status' 'SUBAGENT'
    Assert-Audit 'durable subagent lanes are rejected' (Invoke-Audit $subagentLane -Strict) 1 'assigned to a subagent'

    $terminal = Copy-Fixture $base 'negative-terminal-unarchived'
    $terminalCommunication = Join-Path $terminal 'AGENT_COMMUNICATION.md'
    Set-Raw $terminalCommunication ((Get-Raw $terminalCommunication).Replace('| LIVE | ACTIVE | 2026-08-21T12:00:00-05:00 |', '| LIVE | STOPPED | 2026-08-21T12:00:00-05:00 |'))
    Assert-Audit 'terminal unarchived tasks are rejected' (Invoke-Audit $terminal -Strict) 1 'has no verified archive or UNARCHIVABLE receipt'

    $archivePending = Copy-Fixture $base 'negative-archive-pending'
    $archivePendingReceipt = "ARCHIVE PENDING $uiId; retry after host task refresh"
    Set-Field (Join-Path $archivePending 'PROJECT_STATE.md') 'Task lifecycle backlog' $archivePendingReceipt
    Set-Field (Join-Path $archivePending 'COORDINATION_BOARD.md') 'Task lifecycle backlog' $archivePendingReceipt
    Assert-Audit 'retryable archive backlog is rejected' (Invoke-Audit $archivePending -Strict) 1 'contains an unresolved task startup or archive state'

    $unarchivable = Copy-Fixture $base 'positive-unarchivable-host-debris'
    $oldId = '44444444-4444-4444-8444-444444444444'
    $oldLink = "codex://threads/$oldId"
    $oldProject = "$unarchivable; worktree backing missing"
    $unarchivableReceipt = "UNARCHIVABLE $oldId; archive attempt AR-001 failed because host backing task is missing; no unintegrated changes/processes; verified $timestamp"
    $oldChecklist = Join-Path $unarchivable 'agent-checklists\old-terminal.md'
    Copy-Item -LiteralPath (Join-Path $unarchivable 'agent-checklists\ui.md') -Destination $oldChecklist
    Set-Field $oldChecklist 'Agent/task/deeplink' "Old terminal task; $oldId; $oldLink"
    Set-Field $oldChecklist 'Stable lane ID' 'OLD'
    Set-Field $oldChecklist 'Creation mechanism/receipt' 'create_thread / historical receipt'
    Set-Field $oldChecklist 'Actual task startup read-back' "$timestamp; $oldId; $oldLink; model/effort=$actualModel; actual project/root/worktree=$oldProject; checklist=agent-checklists/old-terminal.md; status=STOPPED"
    Set-Field $oldChecklist 'Replacement/reuse receipt' 'REPLACED by UI after host backing loss'
    $oldCommunicationRow = "| OLD | Historical UI | Old Terminal Task | ``create_thread / historical receipt`` | $oldId | $oldLink | $actualModel | $oldProject | ``agent-checklists/old-terminal.md`` | historical task | Project Director | $unarchivableReceipt | STOPPED | $timestamp |"
    $unarchivableCommunication = Join-Path $unarchivable 'AGENT_COMMUNICATION.md'
    $unarchivableText = Get-Raw $unarchivableCommunication
    $uiRowMatch = [regex]::Match($unarchivableText, '(?m)^\| UI \| User Interface \|.*$')
    $unarchivableText = $unarchivableText.Replace($uiRowMatch.Value, $uiRowMatch.Value + [Environment]::NewLine + $oldCommunicationRow)
    Set-Raw $unarchivableCommunication $unarchivableText
    Set-Field (Join-Path $unarchivable 'PROJECT_STATE.md') 'Task lifecycle backlog' $unarchivableReceipt
    Set-Field (Join-Path $unarchivable 'COORDINATION_BOARD.md') 'Task lifecycle backlog' $unarchivableReceipt
    Assert-Audit 'verified host-level unarchivable debris does not stop product work' (Invoke-Audit $unarchivable -Strict) 0 'UNARCHIVABLE task debris'

    $reusedHistory = Copy-Fixture $base 'positive-reused-lane-history'
    $oldUiId = '55555555-5555-4555-8555-555555555555'
    $oldUiLink = "codex://threads/$oldUiId"
    $oldUiProject = "$reusedHistory; worktree=old-ui"
    $archivedUiRow = "| UI | Historical User Interface | Old UI Task | ``create_thread / historical receipt`` | $oldUiId | $oldUiLink | $actualModel | $oldUiProject | ``agent-checklists/ui.md`` | prior UI slice | Project Director | ARCHIVED ARC-002; replaced by $uiId after handoff | REPLACED | $timestamp |"
    $reusedCommunication = Join-Path $reusedHistory 'AGENT_COMMUNICATION.md'
    $reusedText = Get-Raw $reusedCommunication
    $currentUiMatch = [regex]::Match($reusedText, '(?m)^\| UI \| User Interface \|.*$')
    $reusedText = $reusedText.Replace($currentUiMatch.Value, $archivedUiRow + [Environment]::NewLine + $currentUiMatch.Value)
    Set-Raw $reusedCommunication $reusedText
    Assert-Audit 'archived history plus one reused live lane is accepted' (Invoke-Audit $reusedHistory -Strict) 0 'PASS:'

    $duplicate = Copy-Fixture $base 'negative-duplicate-live-lane'
    $duplicateCommunication = Join-Path $duplicate 'AGENT_COMMUNICATION.md'
    $duplicateText = Get-Raw $duplicateCommunication
    $coreRowMatch = [regex]::Match($duplicateText, '(?m)^\| CORE \| Core Engine \|.*$')
    if (-not $coreRowMatch.Success) {
        throw 'Duplicate-lane fixture could not find CORE row.'
    }
    $duplicateText = $duplicateText.Replace($coreRowMatch.Value, $coreRowMatch.Value + [Environment]::NewLine + $coreRowMatch.Value)
    Set-Raw $duplicateCommunication $duplicateText
    Assert-Audit 'duplicate live stable lanes are rejected' (Invoke-Audit $duplicate -Strict) 1 'more than one non-archived live task'

    $ideaMismatch = Copy-Fixture $base 'negative-idea-count'
    $ideaMaster = Join-Path $ideaMismatch 'MASTER_CHECKLIST.md'
    $ideaText = Get-Raw $ideaMaster
    $noneIdeaRow = [regex]::Match($ideaText, '(?m)^\| NONE \| NONE \| No brainstorm items recorded at initialization\..*$')
    if (-not $noneIdeaRow.Success) {
        throw 'Idea fixture could not find the NONE row.'
    }
    $ideaText = $ideaText.Replace($noneIdeaRow.Value, '| BACKLOG | IDEA-001 | Could we add another mode? User at checkpoint. | UI | `agent-checklists/ui.md` | Parked until promoted. | NONE |')
    Set-Raw $ideaMaster $ideaText
    Assert-Audit 'brainstorm count drift is rejected' (Invoke-Audit $ideaMismatch -Strict) 1 'open brainstorm count does not match BACKLOG rows'

    $ideaLink = Copy-Fixture $base 'negative-idea-checklist-link'
    $ideaLinkMaster = Join-Path $ideaLink 'MASTER_CHECKLIST.md'
    $ideaLinkText = Get-Raw $ideaLinkMaster
    $noneIdeaLinkRow = [regex]::Match($ideaLinkText, '(?m)^\| NONE \| NONE \| No brainstorm items recorded at initialization\..*$')
    if (-not $noneIdeaLinkRow.Success) {
        throw 'Idea-link fixture could not find the NONE row.'
    }
    $ideaLinkText = $ideaLinkText.Replace($noneIdeaLinkRow.Value, '| BACKLOG | IDEA-001 | Could we add another mode? User at checkpoint. | UI | `agent-checklists/ui.md` | Parked until promoted. | NONE |')
    Set-Raw $ideaLinkMaster $ideaLinkText
    Set-Field $ideaLinkMaster 'Open brainstorm items' '1'
    Set-Field $ideaLinkMaster 'Newest brainstorm ID' 'IDEA-001'
    Set-Field (Join-Path $ideaLink 'PROJECT_STATE.md') 'Open brainstorm backlog' '1; newest IDEA-001'
    Assert-Audit 'unlinked brainstorm checklist is rejected' (Invoke-Audit $ideaLink -Strict) 1 'is not linked in both the field and table'

    $staleResume = Copy-Fixture $base 'negative-stale-resume'
    Set-Field (Join-Path $staleResume 'PROJECT_STATE.md') 'Plan state/decision' 'DRAFT; stale compacted state'
    Assert-Audit 'stale resume state is rejected' (Invoke-Audit $staleResume -Strict) 1 'plan state must be ACCEPTED'

    Write-Output 'PASS: ProjectStart regression suite completed.'
    $passed = $true
}
finally {
    if ($passed -and -not $KeepFixtures) {
        $resolvedSuite = [System.IO.Path]::GetFullPath($suiteRoot)
        if (-not $resolvedSuite.StartsWith($tempBase, [System.StringComparison]::OrdinalIgnoreCase) -or
            -not (Split-Path -Leaf $resolvedSuite).StartsWith('ProjectStart-Regression-', [System.StringComparison]::Ordinal)) {
            throw "Refusing unsafe fixture cleanup: $resolvedSuite"
        }
        Remove-Item -LiteralPath $resolvedSuite -Recurse -Force
    }
    elseif (Test-Path -LiteralPath $suiteRoot) {
        Write-Output "Regression fixtures retained: $suiteRoot"
    }
}
