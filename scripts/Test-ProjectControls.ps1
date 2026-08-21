[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [string]$TargetPath = (Get-Location).Path,

    [switch]$Strict
)

$ErrorActionPreference = 'Stop'
$root = [System.IO.Path]::GetFullPath($TargetPath)
$errors = [System.Collections.Generic.List[string]]::new()
$warnings = [System.Collections.Generic.List[string]]::new()

function Require-Text {
    param(
        [Parameter(Mandatory = $true)][string]$RelativePath,
        [Parameter(Mandatory = $true)][string]$Text
    )

    $path = Join-Path $root $RelativePath
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        $errors.Add("Missing file: $RelativePath")
        return
    }

    $content = Get-Content -LiteralPath $path -Raw
    if (-not $content.Contains($Text)) {
        $errors.Add("$RelativePath is missing required contract text: $Text")
    }
}

function Reject-Text {
    param(
        [Parameter(Mandatory = $true)][string]$RelativePath,
        [Parameter(Mandatory = $true)][string]$Text
    )

    $path = Join-Path $root $RelativePath
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        return
    }

    $content = Get-Content -LiteralPath $path -Raw
    if ($content.Contains($Text)) {
        $errors.Add("$RelativePath still has an unresolved activation value: $Text")
    }
}

function Require-ResolvedField {
    param(
        [Parameter(Mandatory = $true)][string]$RelativePath,
        [Parameter(Mandatory = $true)][string]$Label
    )

    $path = Join-Path $root $RelativePath
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        return
    }

    $content = Get-Content -LiteralPath $path -Raw
    $pattern = '(?m)^- \*\*' + [regex]::Escape($Label) + ':\*\* (.+)$'
    $match = [regex]::Match($content, $pattern)
    if (-not $match.Success) {
        $errors.Add("$RelativePath has no required field: $Label")
        return
    }

    $value = $match.Groups[1].Value.Trim()
    if ([string]::IsNullOrWhiteSpace($value) -or $value -match '<[^>]+>' -or $value -match '^(PENDING|TODO|UNKNOWN)$') {
        $errors.Add("$RelativePath has an unresolved required field: $Label")
    }
}

if (-not (Test-Path -LiteralPath $root -PathType Container)) {
    throw "Project directory does not exist: $root"
}

$requiredFiles = @(
    'README.md',
    'AGENTS.md',
    'PROJECT_STATE.md',
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
    'TEAM_OPERATING_MODEL.md',
    'agent-checklists\coordinator.md'
)

foreach ($relativePath in $requiredFiles) {
    if (-not (Test-Path -LiteralPath (Join-Path $root $relativePath) -PathType Leaf)) {
        $errors.Add("Missing file: $relativePath")
    }
}

Require-Text 'MASTER_CHECKLIST.md' '## Primary Outcome Lock'
Require-Text 'MASTER_CHECKLIST.md' '| [ ] | REQ-001 |'
Require-Text 'MASTER_CHECKLIST.md' '| [ ] | GATE-013 |'
Require-Text 'MASTER_CHECKLIST.md' '| [ ] | GATE-014 |'
Require-Text 'MASTER_CHECKLIST.md' '| [ ] | GATE-015 |'
Require-Text 'MASTER_CHECKLIST.md' '| [ ] | GATE-016 |'
Require-Text 'MASTER_CHECKLIST.md' '| [ ] | GATE-017 |'
Require-Text 'MASTER_CHECKLIST.md' '| [ ] | GATE-018 |'
Require-Text 'MASTER_CHECKLIST.md' '| [ ] | GATE-019 |'
Require-Text 'MASTER_CHECKLIST.md' '| [ ] | GATE-020 |'
Require-Text 'MASTER_CHECKLIST.md' '| [ ] | GATE-021 |'
Require-Text 'MASTER_CHECKLIST.md' '| [ ] | GATE-022 |'
Require-Text 'MASTER_CHECKLIST.md' '| [ ] | GATE-023 |'
Require-Text 'MASTER_CHECKLIST.md' '| [ ] | GATE-024 |'
Require-Text 'MASTER_CHECKLIST.md' '| [ ] | GATE-025 |'
Require-Text 'MASTER_CHECKLIST.md' '| [ ] | GATE-026 |'
Require-Text 'MASTER_CHECKLIST.md' '| [ ] | GATE-027 |'
Require-Text 'MASTER_CHECKLIST.md' '| [ ] | GATE-028 |'
Require-Text 'MASTER_CHECKLIST.md' '| [ ] | GATE-029 |'
Require-Text 'MASTER_CHECKLIST.md' '| [ ] | GATE-030 |'
Require-Text 'MASTER_CHECKLIST.md' '| [ ] | GATE-031 |'
Require-Text 'MASTER_CHECKLIST.md' '| [ ] | GATE-032 |'
Require-Text 'MASTER_CHECKLIST.md' '## Claim-scoped health'
Require-Text 'MASTER_CHECKLIST.md' '## Candidate promotion gate'
Require-Text 'MASTER_CHECKLIST.md' '## Brainstorm and future backlog'
Require-Text 'MASTER_CHECKLIST.md' '**Open brainstorm items:**'
Require-Text 'PROJECT_STATE.md' '## Mandatory rehydration'
Require-Text 'PROJECT_STATE.md' '**Skill contract:** `$project-start`'
Require-Text 'PROJECT_STATE.md' '**Team mode:**'
Require-Text 'PROJECT_STATE.md' '**Requested simultaneous workers:**'
Require-Text 'PROJECT_STATE.md' '**Worker model/effort policy:**'
Require-Text 'PROJECT_STATE.md' '**Staffing intake receipt:**'
Require-Text 'PROJECT_STATE.md' '**Staffed wave phase:**'
Require-Text 'PROJECT_STATE.md' '**First staffed build wave:**'
Require-Text 'PROJECT_STATE.md' '**Staffed build-wave counts:**'
Require-Text 'PROJECT_STATE.md' '**Staffed build-wave lane IDs:**'
Require-Text 'PROJECT_STATE.md' '**Staffed build-wave receipt:**'
Require-Text 'PROJECT_STATE.md' '**Integration regroup state:**'
Require-Text 'PROJECT_STATE.md' '**Ready independent lanes:**'
Require-Text 'PROJECT_STATE.md' '**Useful concurrency target:**'
Require-Text 'PROJECT_STATE.md' '**Last launch/replenishment receipt:**'
Require-Text 'PROJECT_STATE.md' '**Director wait state/receipt:**'
Require-Text 'PROJECT_STATE.md' '**Task lifecycle backlog:**'
Require-Text 'PROJECT_STATE.md' '## Active task read-backs'
Require-Text 'DECISION_LOG.md' '## Correction and regression ledger'
Require-Text 'AGENT_CHECKLIST_TEMPLATE.md' '**Active correction IDs:**'
Require-Text 'AGENT_CHECKLIST_TEMPLATE.md' '**Critical journey transaction contract:**'
Require-Text 'AGENT_CHECKLIST_TEMPLATE.md' '**Stable lane ID:**'
Require-Text 'AGENT_CHECKLIST_TEMPLATE.md' '**Worker class:**'
Require-Text 'AGENT_CHECKLIST_TEMPLATE.md' '**Actual task startup read-back:**'
Require-Text 'AGENT_CHECKLIST_TEMPLATE.md' '**Replacement/reuse receipt:**'
Require-Text 'AGENT_CHECKLIST_TEMPLATE.md' '**Linked open idea IDs:**'
Require-Text 'AGENT_CHECKLIST_TEMPLATE.md' '**Integration batch/order:**'
Require-Text 'AGENT_CHECKLIST_TEMPLATE.md' '**Staffed-wave handoff state:**'
Require-Text 'AGENT_CHECKLIST_TEMPLATE.md' '**User-selected worker model policy:**'
Require-Text 'AGENT_CHECKLIST_TEMPLATE.md' '**Model policy match receipt:**'
Require-Text 'AGENT_CHECKLIST_TEMPLATE.md' '## Linked brainstorm/backlog'
Require-Text 'PROJECT_CHARTER.md' '## User intent synthesis'
Require-Text 'PROJECT_CHARTER.md' '**Anti-intent:**'
Require-Text 'PROJECT_CHARTER.md' '**Emotional promise:**'
Require-Text 'PROJECT_CHARTER.md' '**Distribution context:**'
Require-Text 'PROJECT_CHARTER.md' '**Team staffing contract:**'
Require-Text 'PROJECT_CHARTER.md' '**Requested simultaneous workers:**'
Require-Text 'PROJECT_CHARTER.md' '**Worker model/effort policy:**'
Require-Text 'PROJECT_CHARTER.md' '**Staffing intake receipt:**'
Require-Text 'PRIOR_ART_RESEARCH.md' '**Parity interpretation:**'
Require-Text 'PROJECT_PLAN.md' '## Adversarial self-audit'
Require-Text 'PROJECT_PLAN.md' '## Critical journey transaction contract'
Require-Text 'PRIOR_ART_RESEARCH.md' '## Reuse decision'
Require-Text 'PRIOR_ART_RESEARCH.md' '## Baseline capability matrix'
Require-Text 'PRIOR_ART_RESEARCH.md' 'INTENTIONALLY EXCLUDED'
Require-Text 'PRIOR_ART_RESEARCH.md' 'license'
Require-Text 'PROJECT_PLAN.md' '## Ordered vertical slices'
Require-Text 'PROJECT_PLAN.md' '## Checklist derivation gate'
Require-Text 'PROJECT_PLAN.md' '**Plan state:**'
Require-Text 'PROJECT_PLAN.md' 'Creation mechanism'
Require-Text 'PROJECT_PLAN.md' 'Each lane''s original creation mechanism is `create_thread`; `spawn_agent` is prohibited.'
Require-Text 'PROJECT_PLAN.md' 'Launch wave'
Require-Text 'PROJECT_PLAN.md' 'Hard prerequisite'
Require-Text 'PROJECT_PLAN.md' '**Team mode:**'
Require-Text 'PROJECT_PLAN.md' '**Requested simultaneous workers:**'
Require-Text 'PROJECT_PLAN.md' '**Worker model/effort policy:**'
Require-Text 'PROJECT_PLAN.md' '**First staffed build wave:**'
Require-Text 'PROJECT_PLAN.md' '**Staffed-wave target:**'
Require-Text 'PROJECT_PLAN.md' '**Integration regroup rule:**'
Require-Text 'PROJECT_PLAN.md' 'Worker class'
Require-Text 'PROJECT_PLAN.md' 'Integration batch/order'
Require-Text 'COORDINATION_BOARD.md' 'Lanes showing test churn/no outcome movement'
Require-Text 'COORDINATION_BOARD.md' 'Primary outcome state'
Require-Text 'COORDINATION_BOARD.md' 'Current timebox stage'
Require-Text 'COORDINATION_BOARD.md' 'Planned durable lanes lacking create_thread receipt'
Require-Text 'COORDINATION_BOARD.md' 'Subagents currently carrying durable work'
Require-Text 'COORDINATION_BOARD.md' 'Ready independent lanes'
Require-Text 'COORDINATION_BOARD.md' 'Useful concurrency target'
Require-Text 'COORDINATION_BOARD.md' 'Under-utilization reason'
Require-Text 'COORDINATION_BOARD.md' 'Last launch/replenishment receipt'
Require-Text 'COORDINATION_BOARD.md' 'Director wait state/receipt'
Require-Text 'COORDINATION_BOARD.md' 'Task lifecycle backlog'
Require-Text 'COORDINATION_BOARD.md' 'Duplicate live stable lanes'
Require-Text 'COORDINATION_BOARD.md' 'Staffed wave phase'
Require-Text 'COORDINATION_BOARD.md' 'Requested simultaneous workers'
Require-Text 'COORDINATION_BOARD.md' 'Worker model/effort policy'
Require-Text 'COORDINATION_BOARD.md' 'Staffing intake receipt'
Require-Text 'COORDINATION_BOARD.md' 'First staffed build wave'
Require-Text 'COORDINATION_BOARD.md' 'Staffed build-wave counts'
Require-Text 'COORDINATION_BOARD.md' 'Staffed build-wave lane IDs'
Require-Text 'COORDINATION_BOARD.md' 'Staffed build-wave receipt'
Require-Text 'COORDINATION_BOARD.md' 'Integration regroup state'
Require-Text 'AGENT_COMMUNICATION.md' '## Director address'
Require-Text 'AGENT_COMMUNICATION.md' '## Task directory'
Require-Text 'AGENT_COMMUNICATION.md' '## Task creation contract'
Require-Text 'AGENT_COMMUNICATION.md' '**Durable lane creation tool:** `create_thread`'
Require-Text 'AGENT_COMMUNICATION.md' '**Forbidden substitute:** `spawn_agent`'
Require-Text 'AGENT_COMMUNICATION.md' 'No durable domain is hidden behind a subagent.'
Require-Text 'AGENT_COMMUNICATION.md' 'A stable lane keeps one live task'
Require-Text 'AGENT_COMMUNICATION.md' 'Actual model/effort'
Require-Text 'RUNTIME_OWNERSHIP.md' '## Current lock'
Require-Text 'RUNTIME_OWNERSHIP.md' 'An out-of-lane mismatch is a routed blocker'
Require-Text 'INTEGRATION_CONTRACTS.md' 'Installed candidate is not source'
Require-Text 'INTEGRATION_CONTRACTS.md' 'No-wait behavior'
Require-Text 'INTEGRATION_CONTRACTS.md' 'Director owns no routine production implementation.'
Require-Text 'RESOURCE_BUDGET.md' 'Whole-path attempt accounting'
Require-Text 'RESOURCE_BUDGET.md' 'Immediate pause and emergency stop'
Require-Text 'RESOURCE_BUDGET.md' 'materially interfere with the user or another task'
Require-Text 'MASTER_CHECKLIST.md' 'Active critical path'
Require-Text 'FOCUS_PROTOCOL.md' 'two materially different approaches'
Require-Text 'FOCUS_PROTOCOL.md' 'three meaningful checkpoints'
Require-Text 'FOCUS_PROTOCOL.md' '## Two-candidate circuit breaker'
Require-Text 'FOCUS_PROTOCOL.md' '## Candidate promotion and health language'
Require-Text 'FOCUS_PROTOCOL.md' '## Missing table-stakes impact check'
Require-Text 'FOCUS_PROTOCOL.md' 'before the first production edit whenever safe'
Require-Text 'TIMEBOX_PROTOCOL.md' 'Scope freeze'
Require-Text 'TIMEBOX_PROTOCOL.md' 'Stabilize'
Require-Text 'VISUAL_PROTOCOL.md' 'Real-control skeleton'
Require-Text 'VISUAL_PROTOCOL.md' 'Skeleton approval and freeze'
Require-Text 'TEAM_OPERATING_MODEL.md' '### Project Director'
Require-Text 'TEAM_OPERATING_MODEL.md' '### Software Developer'
Require-Text 'TEAM_OPERATING_MODEL.md' '### QA Verifier'
Require-Text 'TEAM_OPERATING_MODEL.md' '### Visual Auditor'
Require-Text 'TEAM_OPERATING_MODEL.md' 'Use **Sol Medium**'
Require-Text 'TEAM_OPERATING_MODEL.md' 'Use **Sol Max**'
Require-Text 'TEAM_OPERATING_MODEL.md' 'Use **Sol Low**'
Require-Text 'TEAM_OPERATING_MODEL.md' 'Use **Luna Max**'
Require-Text 'TEAM_OPERATING_MODEL.md' 'top-level Codex task'
Require-Text 'TEAM_OPERATING_MODEL.md' 'If `create_thread` is unavailable or fails'
Require-Text 'TEAM_OPERATING_MODEL.md' '## Compact recovery is mandatory'
Require-Text 'TEAM_OPERATING_MODEL.md' '## Staffing intake is mandatory'
Require-Text 'TEAM_OPERATING_MODEL.md' '## Parallel launch barrier'
Require-Text 'TEAM_OPERATING_MODEL.md' '## Staffed FULL TEAM build wave'
Require-Text 'TEAM_OPERATING_MODEL.md' '## Regroup and integration barrier'
Require-Text 'TEAM_OPERATING_MODEL.md' '## Stable lane and task lifecycle'
Require-Text 'AGENT_CHECKLIST_TEMPLATE.md' '**Task type:**'
Require-Text 'AGENT_CHECKLIST_TEMPLATE.md' '**Creation mechanism/receipt:**'
Require-Text 'AGENT_CHECKLIST_TEMPLATE.md' '**Subagent status:**'
Require-Text 'PROJECT_CHARTER.md' '| PM-001 |'
Require-Text 'PROJECT_CHARTER.md' '| PM-005 |'
Require-Text 'agent-checklists\coordinator.md' 'REQ-001'
Require-Text 'agent-checklists\coordinator.md' 'Drift alarm state'
Require-Text 'agent-checklists\coordinator.md' 'Two-candidate circuit breaker'
Require-Text 'COORDINATION_BOARD.md' 'Successive failed candidates for primary journey'

Reject-Text 'PROJECT_CHARTER.md' '- **Project:** `<name>`'
Reject-Text 'PROJECT_CHARTER.md' '- **Plain-language outcome:** `<what must be true for the user>`'
Reject-Text 'PROJECT_CHARTER.md' '- **Authoritative root:** `<absolute path>`'
Reject-Text 'MASTER_CHECKLIST.md' '- **Exact user request:** `<quote or faithful one-sentence restatement>`'
Reject-Text 'MASTER_CHECKLIST.md' '- **Exact acceptance journey:** `<starting state -> action -> authoritative success -> persistence/recovery>`'
Reject-Text 'MASTER_CHECKLIST.md' '- **Current truth:** `<NOT ATTEMPTED / FAIL / PARTIAL / PASS at exact evidence level>`'
Reject-Text 'MASTER_CHECKLIST.md' '- **Current candidate classification:** `<DEVELOPMENT / DIAGNOSTIC / INTEGRATION / RELEASE CANDIDATE / RELEASED>`'
Reject-Text 'MASTER_CHECKLIST.md' '- **Two-candidate circuit breaker:** `<CLEAR / TRIGGERED; required plan/review evidence>`'
Reject-Text 'COORDINATION_BOARD.md' '- **Coordinator:** `<name/task/deeplink>`'
Reject-Text 'COORDINATION_BOARD.md' '- **Primary outcome state:** `<NOT ATTEMPTED/FAIL/PARTIAL/PASS and EV-###>`'
Reject-Text 'PROJECT_STATE.md' '- **Primary outcome:** `<exact observable outcome>`'
Reject-Text 'PROJECT_STATE.md' '- **Current user-directed priority:** `<exact current milestone/outcome; explicit steering controls>`'
Reject-Text 'AGENT_COMMUNICATION.md' '- **Project Director task:** `<exact task title>`'
Reject-Text 'AGENT_COMMUNICATION.md' '- **Task ID:** `<exact ID>`'
Reject-Text 'AGENT_COMMUNICATION.md' '- **Deeplink:** `<exact copied deeplink>`'
Reject-Text 'agent-checklists\coordinator.md' '- **Agent/task/deeplink:** `<identity>`'
Reject-Text 'agent-checklists\coordinator.md' '- **Primary outcome lock:** `<exact master outcome this lane must advance>`'
Reject-Text 'agent-checklists\coordinator.md' '- **Exact acceptance journey:** `<real starting state -> user action -> authoritative result>`'
Reject-Text 'agent-checklists\coordinator.md' '- **Exact write ownership:** `<files, folders, regions, resources>`'
Reject-Text 'agent-checklists\coordinator.md' '- **Model/effort:** `<Luna Max read-only; Sol Low/Light for bounded QA; Sol Medium default; or Sol Max>`'

$readmePath = Join-Path $root 'README.md'
if (Test-Path -LiteralPath $readmePath -PathType Leaf) {
    $readme = Get-Content -LiteralPath $readmePath -Raw
    $links = [regex]::Matches($readme, '\[[^\]]+\]\(([^)#]+\.md)(?:#[^)]+)?\)')
    foreach ($match in $links) {
        $target = $match.Groups[1].Value
        if (-not (Test-Path -LiteralPath (Join-Path $root $target))) {
            $errors.Add("Broken README link: $target")
        }
    }
}

$masterPath = Join-Path $root 'MASTER_CHECKLIST.md'
if (Test-Path -LiteralPath $masterPath -PathType Leaf) {
    $master = Get-Content -LiteralPath $masterPath -Raw
    if ($master -notmatch '(?m)^\| \[ \] \| REQ-001 \| .+ \| Critical \|') {
        $errors.Add('REQ-001 is missing or is not Critical in MASTER_CHECKLIST.md.')
    }

    $deadlineMatch = [regex]::Match($master, '(?m)^- \*\*Exact deadline:\*\* (.+)$')
    if (-not $deadlineMatch.Success) {
        $errors.Add('MASTER_CHECKLIST.md has no exact deadline field.')
    }
    else {
        $parsedDeadline = [DateTimeOffset]::MinValue
        $deadlineValue = $deadlineMatch.Groups[1].Value.Trim()
        if (-not $deadlineValue.StartsWith('NONE', [System.StringComparison]::OrdinalIgnoreCase) -and -not [DateTimeOffset]::TryParse($deadlineValue, [ref]$parsedDeadline)) {
            $errors.Add('MASTER_CHECKLIST.md exact deadline must be NONE or a parseable timestamp with timezone.')
        }
    }

    $sliceDeadlineMatch = [regex]::Match($master, '(?m)^- \*\*Current slice deadline:\*\* (.+)$')
    if (-not $sliceDeadlineMatch.Success) {
        $errors.Add('MASTER_CHECKLIST.md has no current slice deadline field.')
    }
    else {
        $parsedSliceDeadline = [DateTimeOffset]::MinValue
        if (-not [DateTimeOffset]::TryParse($sliceDeadlineMatch.Groups[1].Value.Trim(), [ref]$parsedSliceDeadline)) {
            $errors.Add('MASTER_CHECKLIST.md current slice deadline is not a parseable timestamp with timezone.')
        }
    }

    $candidateClassMatch = [regex]::Match($master, '(?m)^- \*\*Current candidate classification:\*\* (.+)$')
    $candidateClass = if ($candidateClassMatch.Success) { $candidateClassMatch.Groups[1].Value.Trim() } else { '' }
    if ($candidateClass -notin @('DEVELOPMENT', 'DIAGNOSTIC', 'INTEGRATION', 'RELEASE CANDIDATE', 'RELEASED')) {
        $errors.Add('MASTER_CHECKLIST.md current candidate classification is missing or invalid.')
    }

    $promotionMatch = [regex]::Match($master, '(?m)^- \*\*Candidate promotion justification:\*\* (.+)$')
    if (-not $promotionMatch.Success -or [string]::IsNullOrWhiteSpace($promotionMatch.Groups[1].Value) -or $promotionMatch.Groups[1].Value -match '<[^>]+>') {
        $errors.Add('MASTER_CHECKLIST.md candidate promotion justification is missing or unresolved.')
    }
    elseif ($candidateClass -in @('RELEASE CANDIDATE', 'RELEASED') -and $promotionMatch.Groups[1].Value.Trim().StartsWith('NOT YET ELIGIBLE', [System.StringComparison]::OrdinalIgnoreCase)) {
        $errors.Add('A RELEASE CANDIDATE or RELEASED artifact cannot retain a NOT YET ELIGIBLE promotion justification.')
    }

    $failedCandidatesMatch = [regex]::Match($master, '(?m)^- \*\*Successive failed candidates for this journey:\*\*\s*([0-9]+)\b')
    $breakerMatch = [regex]::Match($master, '(?m)^- \*\*Two-candidate circuit breaker:\*\*\s*(CLEAR|TRIGGERED)\b')
    if (-not $failedCandidatesMatch.Success) {
        $errors.Add('MASTER_CHECKLIST.md must begin the successive failed-candidate field with a numeric count.')
    }
    if (-not $breakerMatch.Success) {
        $errors.Add('MASTER_CHECKLIST.md two-candidate circuit breaker must be CLEAR or TRIGGERED.')
    }
    if ($failedCandidatesMatch.Success -and [int]$failedCandidatesMatch.Groups[1].Value -ge 2 -and
        $breakerMatch.Success -and $breakerMatch.Groups[1].Value -ne 'TRIGGERED') {
        $errors.Add('Two or more successive failed candidates require the circuit breaker to be TRIGGERED.')
    }

    $currentTruthMatch = [regex]::Match($master, '(?m)^- \*\*Current truth:\*\*\s*(NOT ATTEMPTED|NOT RUN|FAIL|PARTIAL|PASS|BLOCKED)\b')
    if ($candidateClass -eq 'RELEASED' -and (-not $currentTruthMatch.Success -or $currentTruthMatch.Groups[1].Value -ne 'PASS')) {
        $errors.Add('A RELEASED artifact requires the Primary Outcome Lock current truth to be PASS.')
    }
}

$checklistDirectory = Join-Path $root 'agent-checklists'
if (Test-Path -LiteralPath $checklistDirectory -PathType Container) {
    $agentFiles = @(Get-ChildItem -LiteralPath $checklistDirectory -Filter '*.md' -File)
    if ($agentFiles.Count -eq 0) {
        $errors.Add('No active agent checklist exists.')
    }

    foreach ($agentFile in $agentFiles) {
        $agent = Get-Content -LiteralPath $agentFile.FullName -Raw
        if (-not $agent.Contains('**Assigned master IDs:**')) {
            $errors.Add("$($agentFile.Name) has no assigned master IDs field.")
        }
        if (-not $agent.Contains('**Primary outcome lock:**')) {
            $errors.Add("$($agentFile.Name) has no primary outcome lock.")
        }
        if (-not $agent.Contains('**Exact write ownership:**')) {
            $errors.Add("$($agentFile.Name) has no exact write ownership.")
        }
        if (-not $agent.Contains('**Critical journey transaction contract:**')) {
            $errors.Add("$($agentFile.Name) has no critical journey transaction contract reference.")
        }
        if (-not $agent.Contains('**Two-candidate circuit breaker:**')) {
            $errors.Add("$($agentFile.Name) has no two-candidate circuit-breaker state.")
        }
        if (-not $agent.Contains('**Task type:**')) {
            $errors.Add("$($agentFile.Name) has no task type field.")
        }
        if (-not $agent.Contains('**Creation mechanism/receipt:**')) {
            $errors.Add("$($agentFile.Name) has no task creation receipt field.")
        }
        if (-not $agent.Contains('**Subagent status:**')) {
            $errors.Add("$($agentFile.Name) has no subagent status field.")
        }
        if (-not $agent.Contains('**Stable lane ID:**')) {
            $errors.Add("$($agentFile.Name) has no stable lane ID field.")
        }
        if (-not $agent.Contains('**Worker class:**')) {
            $errors.Add("$($agentFile.Name) has no worker class field.")
        }
        if (-not $agent.Contains('**Actual task startup read-back:**')) {
            $errors.Add("$($agentFile.Name) has no actual task startup read-back field.")
        }
        if (-not $agent.Contains('**Replacement/reuse receipt:**')) {
            $errors.Add("$($agentFile.Name) has no replacement/reuse receipt field.")
        }
        if (-not $agent.Contains('**Linked open idea IDs:**')) {
            $errors.Add("$($agentFile.Name) has no linked open idea IDs field.")
        }
        if (-not $agent.Contains('**Integration batch/order:**')) {
            $errors.Add("$($agentFile.Name) has no integration batch/order field.")
        }
        if (-not $agent.Contains('**Staffed-wave handoff state:**')) {
            $errors.Add("$($agentFile.Name) has no staffed-wave handoff state field.")
        }
        if (-not $agent.Contains('**User-selected worker model policy:**')) {
            $errors.Add("$($agentFile.Name) has no user-selected worker model policy field.")
        }
        if (-not $agent.Contains('**Model policy match receipt:**')) {
            $errors.Add("$($agentFile.Name) has no model policy match receipt field.")
        }

        if ($Strict) {
            $relativeAgentPath = [System.IO.Path]::GetRelativePath($root, $agentFile.FullName)
            Require-ResolvedField $relativeAgentPath 'Task type'
            Require-ResolvedField $relativeAgentPath 'Creation mechanism/receipt'
            Require-ResolvedField $relativeAgentPath 'Subagent status'
            Require-ResolvedField $relativeAgentPath 'Stable lane ID'
            Require-ResolvedField $relativeAgentPath 'Worker class'
            Require-ResolvedField $relativeAgentPath 'Actual task startup read-back'
            Require-ResolvedField $relativeAgentPath 'Replacement/reuse receipt'
            Require-ResolvedField $relativeAgentPath 'Linked open idea IDs'
            Require-ResolvedField $relativeAgentPath 'Integration batch/order'
            Require-ResolvedField $relativeAgentPath 'Staffed-wave handoff state'
            Require-ResolvedField $relativeAgentPath 'Model/effort'
            Require-ResolvedField $relativeAgentPath 'User-selected worker model policy'
            Require-ResolvedField $relativeAgentPath 'Model policy match receipt'

            $taskType = [regex]::Match($agent, '(?m)^- \*\*Task type:\*\* (.+)$').Groups[1].Value.Trim()
            $creationMechanism = [regex]::Match($agent, '(?m)^- \*\*Creation mechanism/receipt:\*\* (.+)$').Groups[1].Value.Trim()
            $subagentStatus = [regex]::Match($agent, '(?m)^- \*\*Subagent status:\*\* (.+)$').Groups[1].Value.Trim()
            $startupReadback = [regex]::Match($agent, '(?m)^- \*\*Actual task startup read-back:\*\* (.+)$').Groups[1].Value.Trim()
            $workerClass = [regex]::Match($agent, '(?m)^- \*\*Worker class:\*\* (.+)$').Groups[1].Value.Trim()
            $modelPolicyReceipt = [regex]::Match($agent, '(?m)^- \*\*Model policy match receipt:\*\* (.+)$').Groups[1].Value.Trim()

            if ($taskType -notin @('TOP-LEVEL CODEX TASK', 'CURRENT DIRECTOR TASK')) {
                $errors.Add("$($agentFile.Name) task type must be TOP-LEVEL CODEX TASK or CURRENT DIRECTOR TASK.")
            }
            if ($taskType -eq 'TOP-LEVEL CODEX TASK' -and $creationMechanism -notmatch '^create_thread\b') {
                $errors.Add("$($agentFile.Name) owns a durable lane but has no create_thread receipt.")
            }
            $allowedWorkerClasses = @('DIRECTOR', 'IMPLEMENTATION', 'PRODUCT', 'ARCHITECTURE', 'QA', 'VISUAL', 'INTEGRATION', 'RELEASE', 'RESEARCH')
            if ($workerClass -notin $allowedWorkerClasses -or ($taskType -eq 'CURRENT DIRECTOR TASK' -and $workerClass -ne 'DIRECTOR') -or ($taskType -eq 'TOP-LEVEL CODEX TASK' -and $workerClass -eq 'DIRECTOR')) {
                $errors.Add("$($agentFile.Name) worker class does not match its task type.")
            }
            if ($creationMechanism -match 'spawn_agent' -or $subagentStatus -ne 'NOT A SUBAGENT') {
                $errors.Add("$($agentFile.Name) is a durable project checklist assigned to a subagent; create a top-level Codex task instead.")
            }
            if ($startupReadback -match '(?i)NOT VERIFIED|PENDING|UNKNOWN|<[^>]+>') {
                $errors.Add("$($agentFile.Name) has no verified actual task startup read-back.")
            }
            if ($taskType -eq 'TOP-LEVEL CODEX TASK' -and $modelPolicyReceipt -notmatch '(?i)^MATCH\b') {
                $errors.Add("$($agentFile.Name) has no MATCH receipt for the user-selected worker model policy.")
            }
            if ($agent -match 'IDEA-001 \| `<exact wording and speaker/time>`') {
                $errors.Add("$($agentFile.Name) linked brainstorm table still contains the unresolved sample row.")
            }
        }
    }
}

$activeFiles = @('PROJECT_STATE.md', 'PROJECT_CHARTER.md', 'MASTER_CHECKLIST.md', 'PRIOR_ART_RESEARCH.md', 'PROJECT_PLAN.md', 'COORDINATION_BOARD.md', 'AGENT_COMMUNICATION.md', 'agent-checklists\coordinator.md')
foreach ($relativePath in $activeFiles) {
    $path = Join-Path $root $relativePath
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        continue
    }

    $content = Get-Content -LiteralPath $path -Raw
    $placeholderCount = [regex]::Matches($content, '<[^>\r\n]+>').Count
    if ($placeholderCount -gt 0) {
        $message = "$relativePath contains $placeholderCount remaining template placeholders."
        $warnings.Add($message)
    }
}

if ($Strict) {
    $teamMode = ''
    $requestedWorkerCount = 0
    $workerModelPolicy = ''
    $staffingIntakeReceipt = ''
    $charterTeamPath = Join-Path $root 'PROJECT_CHARTER.md'
    if (Test-Path -LiteralPath $charterTeamPath -PathType Leaf) {
        $charterTeam = Get-Content -LiteralPath $charterTeamPath -Raw
        $charterTeamMatch = [regex]::Match($charterTeam, '(?m)^- \*\*Team mode:\*\* (SOLO|SMALL TEAM|FULL TEAM)\s*$')
        if (-not $charterTeamMatch.Success) {
            $errors.Add('PROJECT_CHARTER.md team mode must be SOLO, SMALL TEAM, or FULL TEAM.')
        }
        else {
            $teamMode = $charterTeamMatch.Groups[1].Value
        }
        $requestedWorkersMatch = [regex]::Match($charterTeam, '(?m)^- \*\*Requested simultaneous workers:\*\* ([0-9]+)\s*$')
        if (-not $requestedWorkersMatch.Success) {
            $errors.Add('PROJECT_CHARTER.md requested simultaneous workers must be one exact integer from 1 through 15.')
        }
        else {
            $requestedWorkerCount = [int]$requestedWorkersMatch.Groups[1].Value
            if ($requestedWorkerCount -lt 1 -or $requestedWorkerCount -gt 15) {
                $errors.Add('PROJECT_CHARTER.md requested simultaneous workers must be between 1 and 15.')
            }
            $expectedTeamMode = if ($requestedWorkerCount -eq 1) { 'SOLO' } elseif ($requestedWorkerCount -le 9) { 'SMALL TEAM' } else { 'FULL TEAM' }
            if ($teamMode -ne $expectedTeamMode) {
                $errors.Add('PROJECT_CHARTER.md team mode does not match the requested worker count (1 SOLO, 2-9 SMALL TEAM, 10-15 FULL TEAM).')
            }
        }
        $workerPolicyMatch = [regex]::Match($charterTeam, '(?m)^- \*\*Worker model/effort policy:\*\* (.+)$')
        $workerModelPolicy = if ($workerPolicyMatch.Success) { $workerPolicyMatch.Groups[1].Value.Trim() } else { '' }
        if ([string]::IsNullOrWhiteSpace($workerModelPolicy) -or $workerModelPolicy -match '<[^>]+>|(?i)NOT VERIFIED|PENDING|UNKNOWN') {
            $errors.Add('PROJECT_CHARTER.md must contain the exact answered worker model/effort policy.')
        }
        $intakeReceiptMatch = [regex]::Match($charterTeam, '(?m)^- \*\*Staffing intake receipt:\*\* (.+)$')
        $staffingIntakeReceipt = if ($intakeReceiptMatch.Success) { $intakeReceiptMatch.Groups[1].Value.Trim() } else { '' }
        if ($staffingIntakeReceipt -notmatch '[0-9]{4}-[0-9]{2}-[0-9]{2}T' -or $staffingIntakeReceipt -notmatch "(?i)workers=$requestedWorkerCount" -or
            ([string]::IsNullOrWhiteSpace($workerModelPolicy) -eq $false -and -not $staffingIntakeReceipt.Contains($workerModelPolicy))) {
            $errors.Add('PROJECT_CHARTER.md staffing intake receipt must timestamp and repeat the exact worker count and model policy.')
        }
        $staffingContractMatch = [regex]::Match($charterTeam, '(?m)^- \*\*Team staffing contract:\*\* (.+)$')
        if (-not $staffingContractMatch.Success -or $staffingContractMatch.Groups[1].Value -notmatch [regex]::Escape($teamMode) -or
            ($requestedWorkerCount -gt 0 -and $staffingContractMatch.Groups[1].Value -notmatch "(?<![0-9])$requestedWorkerCount(?![0-9])")) {
            $errors.Add('PROJECT_CHARTER.md team staffing contract must name the selected mode and exact requested worker count.')
        }
    }

    $strictFields = @{
        'PROJECT_STATE.md' = @(
            'Last updated',
            'Last rehydrated',
            'Rehydration reason/receipt',
            'Current phase',
            'Primary outcome',
            'Acceptance journey',
            'Current user-directed priority',
            'Plan state/decision',
            'Current candidate classification',
            'Last direct journey attempt',
            'Active correction IDs',
            'Current authority envelope',
            'Forbidden without new user authority',
            'Open brainstorm backlog',
            'Team mode',
            'Requested simultaneous workers',
            'Worker model/effort policy',
            'Staffing intake receipt',
            'Staffed wave phase',
            'First staffed build wave',
            'Staffed build-wave counts',
            'Staffed build-wave lane IDs',
            'Staffed build-wave receipt',
            'Integration regroup state',
            'Ready independent lanes',
            'Running ready lanes',
            'Useful concurrency target',
            'Under-utilization reason',
            'Next launch wave',
            'Last launch/replenishment receipt',
            'Director wait state/receipt',
            'Director production/runtime ownership',
            'Subagents carrying durable work',
            'Task lifecycle backlog',
            'Current blockers',
            'Whole-product status',
            'Next Director action'
        )
        'MASTER_CHECKLIST.md' = @(
            'Current candidate classification',
            'Candidate promotion justification',
            'Successive failed candidates for this journey',
            'Two-candidate circuit breaker'
        )
        'PROJECT_CHARTER.md' = @(
            'Controlling instructions',
            'Human owner/approver',
            'Target release or milestone',
            'Team mode',
            'Requested simultaneous workers',
            'Worker model/effort policy',
            'Staffing intake receipt',
            'Team staffing contract',
            "User's explicit request",
            'Intended recipient/audience',
            'Occasion/relationship context',
            'Underlying job/problem',
            'Desired return state',
            'Emotional promise',
            'Personalization evidence',
            'Distribution context',
            'Derived release implications',
            'Polish translation',
            'Agent inferences with confidence',
            'Anti-intent',
            'Material ambiguity',
            'Resolution'
        )
        'PRIOR_ART_RESEARCH.md' = @(
            'Controlling intent/anti-intent',
            'Questions that affect implementation',
            'Search timebox',
            'Stop condition',
            'Research owner/task',
            'Parity interpretation',
            'First vertical slice changed by research'
        )
        'PROJECT_PLAN.md' = @(
            'Controlling intent synthesis',
            'Prior-art decision',
            'Team mode',
            'Requested simultaneous workers',
            'Worker model/effort policy',
            'First staffed build wave',
            'Staffed-wave target',
            'Integration regroup rule',
            'Target user and problem',
            'Recipient/occasion and emotional promise',
            'Private/internal/public delivery',
            'Smallest useful product',
            'Deliberate advantages over existing products',
            'Personalization and polish acceptance',
            'Baseline/table-stakes coverage',
            'Intentional baseline exclusions',
            'Parity commitment',
            'Chosen architecture',
            'Why this choice',
            'Mutation/persistence/external-effect classification',
            'Authoritative starting state',
            'Ordered transitions and owners',
            'Permitted owned mutations',
            'Forbidden mutations',
            'Read-back authority',
            'Commit point',
            'Failure/recovery/idempotency',
            'External-effect ordering',
            'Sibling-impact map',
            'Missing invariant that would create a patch spiral'
        )
    }

    foreach ($entry in $strictFields.GetEnumerator()) {
        foreach ($label in $entry.Value) {
            Require-ResolvedField $entry.Key $label
        }
    }

    $planPath = Join-Path $root 'PROJECT_PLAN.md'
    if (Test-Path -LiteralPath $planPath -PathType Leaf) {
        $plan = Get-Content -LiteralPath $planPath -Raw
        if ($plan -notmatch '(?m)^\*\*Plan state:\*\* ACCEPTED\s*$') {
            $errors.Add('PROJECT_PLAN.md Plan state must be ACCEPTED before substantive implementation.')
        }
        $planDecisionMatch = [regex]::Match($plan, '(?m)^\*\*Decision ID:\*\* (DEC-[0-9]+)\s*$')
        if (-not $planDecisionMatch.Success) {
            $errors.Add('PROJECT_PLAN.md must cite an accepted DEC-number before substantive implementation.')
        }
        else {
            $acceptedPlanDecisionId = $planDecisionMatch.Groups[1].Value
        }
        if ($plan -match '<finding>|<simplification>|<autonomous route>|<merge/split/reroute>|<scope correction>|<evidence or correction>|<proof plan or honest blocker>|<controlling correction>|<transaction-contract repair>|<candidate-churn guardrail>|<guardrail/direct journey>') {
            $errors.Add('PROJECT_PLAN.md adversarial self-audit still contains unresolved sample findings or repairs.')
        }

        $planTeamMatch = [regex]::Match($plan, '(?m)^- \*\*Team mode:\*\* (SOLO|SMALL TEAM|FULL TEAM)\s*$')
        if (-not $planTeamMatch.Success -or $planTeamMatch.Groups[1].Value -ne $teamMode) {
            $errors.Add('PROJECT_PLAN.md team mode must match PROJECT_CHARTER.md.')
        }
        $planRequestedWorkersMatch = [regex]::Match($plan, '(?m)^- \*\*Requested simultaneous workers:\*\* ([0-9]+)\s*$')
        if (-not $planRequestedWorkersMatch.Success -or [int]$planRequestedWorkersMatch.Groups[1].Value -ne $requestedWorkerCount) {
            $errors.Add('PROJECT_PLAN.md requested simultaneous workers must match PROJECT_CHARTER.md exactly.')
        }
        $planWorkerPolicyMatch = [regex]::Match($plan, '(?m)^- \*\*Worker model/effort policy:\*\* (.+)$')
        if (-not $planWorkerPolicyMatch.Success -or $planWorkerPolicyMatch.Groups[1].Value.Trim() -ne $workerModelPolicy) {
            $errors.Add('PROJECT_PLAN.md worker model/effort policy must match PROJECT_CHARTER.md exactly.')
        }
        $firstWaveMatch = [regex]::Match($plan, '(?m)^- \*\*First staffed build wave:\*\* ([A-Z][A-Z0-9_-]*)\s*$')
        $firstStaffedWaveId = if ($firstWaveMatch.Success) { $firstWaveMatch.Groups[1].Value } else { '' }
        if (-not $firstWaveMatch.Success) {
            $errors.Add('PROJECT_PLAN.md must name one exact first staffed build wave ID.')
        }
        $regroupRuleMatch = [regex]::Match($plan, '(?m)^- \*\*Integration regroup rule:\*\* (.+)$')
        $regroupRule = if ($regroupRuleMatch.Success) { $regroupRuleMatch.Groups[1].Value.Trim() } else { '' }
        foreach ($requiredRegroupTerm in @('handoff', 'freeze', 'candidate', 'QA', 'original stable')) {
            if ($regroupRule -notmatch ('(?i)' + [regex]::Escape($requiredRegroupTerm))) {
                $errors.Add("PROJECT_PLAN.md integration regroup rule must state $requiredRegroupTerm behavior.")
            }
        }

        $planTaskSection = [regex]::Match($plan, '(?ms)^## Top-level task design\s*(.*?)(?=^## |\z)').Groups[1].Value
        $planTaskRows = @($planTaskSection -split "`r?`n" | Where-Object { $_ -match '^\|' -and $_ -notmatch '^\|---' -and $_ -notmatch '^\| Stable lane ID ' })
        $planLaneIds = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
        $planWorkerClasses = @{}
        $planAssignedModels = @{}
        $firstWaveLaneIds = [System.Collections.Generic.List[string]]::new()
        $firstWaveImplementationCount = 0
        $allowedPlanWorkerClasses = @('IMPLEMENTATION', 'PRODUCT', 'ARCHITECTURE', 'QA', 'VISUAL', 'INTEGRATION', 'RELEASE', 'RESEARCH')
        foreach ($row in $planTaskRows) {
            $columns = @($row.Trim('|') -split '\|' | ForEach-Object { $_.Trim() })
            if ($row -match '<[^>]+>') {
                $errors.Add('PROJECT_PLAN.md top-level task design still contains an unresolved sample or placeholder row.')
                continue
            }
            if ($columns.Count -lt 14 -or $columns[4].Trim('`') -ne 'create_thread') {
                $errors.Add('Every PROJECT_PLAN.md durable lane must name create_thread as its creation mechanism.')
            }
            if ($columns.Count -ge 14) {
                $assignedModel = @($columns[10] -split ';', 2)[0].Trim()
                if ($columns[0] -notmatch '^[A-Z][A-Z0-9_-]*$') {
                    $errors.Add('Every PROJECT_PLAN.md durable lane must have a stable lane ID.')
                }
                elseif (-not $planLaneIds.Add($columns[0])) {
                    $errors.Add("PROJECT_PLAN.md contains duplicate stable lane ID '$($columns[0])'.")
                }
                else {
                    $planWorkerClasses[$columns[0]] = $columns[1]
                    $planAssignedModels[$columns[0]] = $assignedModel
                }
                if ($columns[1] -notin $allowedPlanWorkerClasses) {
                    $errors.Add("PROJECT_PLAN.md lane '$($columns[0])' has an invalid worker class.")
                }
                if ([string]::IsNullOrWhiteSpace($columns[5]) -or [string]::IsNullOrWhiteSpace($columns[6]) -or [string]::IsNullOrWhiteSpace($columns[11]) -or [string]::IsNullOrWhiteSpace($columns[13])) {
                    $errors.Add("PROJECT_PLAN.md lane '$($columns[0])' must resolve launch wave, hard prerequisite, intended project/root/worktree, and integration batch/order.")
                }
                elseif (-not $columns[11].Contains($root)) {
                    $errors.Add("PROJECT_PLAN.md lane '$($columns[0])' intended project/root/worktree does not name the authoritative project root.")
                }
                if ($assignedModel -notmatch '^(?i:AUTO / HOST DEFAULT|gpt-[a-z0-9.-]+ / (none|minimal|low|medium|high|xhigh|max|ultra))$') {
                    $errors.Add("PROJECT_PLAN.md lane '$($columns[0])' must begin its assigned-model field with a canonical model / effort or AUTO / HOST DEFAULT.")
                }
                if ($columns[10] -notmatch ';' -or ([string]::IsNullOrWhiteSpace($workerModelPolicy) -eq $false -and $columns[10] -notmatch '(?i)user policy|AUTO / HOST DEFAULT')) {
                    $errors.Add("PROJECT_PLAN.md lane '$($columns[0])' must trace its canonical model/effort to the user policy.")
                }
                if ($columns[5] -eq $firstStaffedWaveId) {
                    $firstWaveLaneIds.Add($columns[0])
                    if ($columns[1] -eq 'IMPLEMENTATION') {
                        $firstWaveImplementationCount++
                    }
                }
            }
        }

        $firstWaveCount = $firstWaveLaneIds.Count
        switch ($teamMode) {
            'SOLO' {
                if ($requestedWorkerCount -ne 1 -or $firstWaveCount -ne $requestedWorkerCount) {
                    $errors.Add('SOLO first staffed build wave must contain exactly the requested 1 non-Director worker.')
                }
            }
            'SMALL TEAM' {
                if ($requestedWorkerCount -lt 2 -or $requestedWorkerCount -gt 9 -or $firstWaveCount -ne $requestedWorkerCount) {
                    $errors.Add('SMALL TEAM first staffed build wave must contain exactly the requested 2-9 non-Director workers.')
                }
            }
            'FULL TEAM' {
                if ($requestedWorkerCount -lt 10 -or $requestedWorkerCount -gt 15 -or $firstWaveCount -ne $requestedWorkerCount) {
                    $errors.Add('FULL TEAM first staffed build wave must contain exactly the requested 10-15 non-Director workers.')
                }
                if (($firstWaveImplementationCount * 2) -le $firstWaveCount) {
                    $errors.Add('FULL TEAM first staffed build wave must have IMPLEMENTATION as a strict majority.')
                }
            }
        }
    }

    $strictMasterPath = Join-Path $root 'MASTER_CHECKLIST.md'
    if (Test-Path -LiteralPath $strictMasterPath -PathType Leaf) {
        $strictMaster = Get-Content -LiteralPath $strictMasterPath -Raw
        if ($strictMaster.Contains('| Primary journey | `<NOT RUN/PARTIAL/FAIL/BLOCKED/PASS>`')) {
            $errors.Add('MASTER_CHECKLIST.md claim-scoped health still contains the unresolved Primary journey sample row.')
        }
        if ($strictMaster -match 'IDEA-001 \| `<exact brainstorm wording and speaker/time>`') {
            $errors.Add('MASTER_CHECKLIST.md brainstorm backlog still contains the unresolved sample row.')
        }

        $ideaCountMatch = [regex]::Match($strictMaster, '(?m)^- \*\*Open brainstorm items:\*\*\s*([0-9]+)\s*$')
        $newestIdeaMatch = [regex]::Match($strictMaster, '(?m)^- \*\*Newest brainstorm ID:\*\*\s*(.+)$')
        $ideaSection = [regex]::Match($strictMaster, '(?ms)^## Brainstorm and future backlog\s*(.*?)(?=^## |\z)').Groups[1].Value
        $backlogRows = @($ideaSection -split "`r?`n" | Where-Object { $_ -match '^\| BACKLOG \| IDEA-[0-9]+ \|' })
        $backlogIdeaIds = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
        foreach ($row in $backlogRows) {
            $columns = @($row.Trim('|') -split '\|' | ForEach-Object { $_.Trim().Trim('`') })
            if ($columns.Count -lt 7) {
                $errors.Add('MASTER_CHECKLIST.md contains a malformed BACKLOG idea row.')
                continue
            }
            $ideaId = $columns[1]
            [void]$backlogIdeaIds.Add($ideaId)
            $linkedChecklistPaths = @($columns[4] -split '[;,]' | ForEach-Object { $_.Trim().Trim('`') } | Where-Object { -not [string]::IsNullOrWhiteSpace($_) -and $_ -ne 'NONE' })
            if ($linkedChecklistPaths.Count -eq 0) {
                $errors.Add("MASTER_CHECKLIST.md backlog idea '$ideaId' has no affected task checklist link.")
            }
            foreach ($linkedChecklistPath in $linkedChecklistPaths) {
                $ideaChecklistPath = Join-Path $root $linkedChecklistPath
                if (-not (Test-Path -LiteralPath $ideaChecklistPath -PathType Leaf)) {
                    $errors.Add("MASTER_CHECKLIST.md backlog idea '$ideaId' links a missing checklist: $linkedChecklistPath")
                    continue
                }
                $ideaChecklist = Get-Content -LiteralPath $ideaChecklistPath -Raw
                $linkedOpenMatch = [regex]::Match($ideaChecklist, '(?m)^- \*\*Linked open idea IDs:\*\*\s*(.+)$')
                $linkedIdeaSection = [regex]::Match($ideaChecklist, '(?ms)^## Linked brainstorm/backlog\s*(.*?)(?=^## |\z)').Groups[1].Value
                if (-not $linkedOpenMatch.Success -or $linkedOpenMatch.Groups[1].Value -notmatch ('(?<![A-Z0-9-])' + [regex]::Escape($ideaId) + '(?![A-Z0-9-])') -or
                    $linkedIdeaSection -notmatch ('(?m)^\|\s*' + [regex]::Escape($ideaId) + '\s*\|')) {
                    $errors.Add("Backlog idea '$ideaId' is not linked in both the field and table of checklist '$linkedChecklistPath'.")
                }
            }
        }
        if (-not $ideaCountMatch.Success -or [int]$ideaCountMatch.Groups[1].Value -ne $backlogRows.Count) {
            $errors.Add('MASTER_CHECKLIST.md open brainstorm count does not match BACKLOG rows.')
        }
        if ($backlogRows.Count -eq 0 -and (-not $newestIdeaMatch.Success -or $newestIdeaMatch.Groups[1].Value.Trim() -ne 'NONE')) {
            $errors.Add('MASTER_CHECKLIST.md newest brainstorm ID must be NONE when no BACKLOG rows exist.')
        }
        if ($backlogRows.Count -gt 0 -and (-not $newestIdeaMatch.Success -or $newestIdeaMatch.Groups[1].Value.Trim() -notmatch '^IDEA-[0-9]+(?:\s*[,;]\s*IDEA-[0-9]+)*$')) {
            $errors.Add('MASTER_CHECKLIST.md newest brainstorm ID must name exact IDEA IDs when backlog items exist.')
        }
        if (Test-Path -LiteralPath $checklistDirectory -PathType Container) {
            foreach ($ideaAgentFile in Get-ChildItem -LiteralPath $checklistDirectory -Filter '*.md' -File) {
                $ideaAgent = Get-Content -LiteralPath $ideaAgentFile.FullName -Raw
                $linkedOpenMatch = [regex]::Match($ideaAgent, '(?m)^- \*\*Linked open idea IDs:\*\*\s*(.+)$')
                if ($linkedOpenMatch.Success -and $linkedOpenMatch.Groups[1].Value.Trim() -ne 'NONE') {
                    $linkedIds = @([regex]::Matches($linkedOpenMatch.Groups[1].Value, 'IDEA-[0-9]+') | ForEach-Object { $_.Value })
                    foreach ($linkedId in $linkedIds) {
                        if (-not $backlogIdeaIds.Contains($linkedId)) {
                            $errors.Add("Checklist '$($ideaAgentFile.Name)' links open idea '$linkedId' that is not a current MASTER_CHECKLIST.md BACKLOG row.")
                        }
                    }
                }
            }
        }
    }

    $strictStatePath = Join-Path $root 'PROJECT_STATE.md'
    if (Test-Path -LiteralPath $strictStatePath -PathType Leaf) {
        $strictState = Get-Content -LiteralPath $strictStatePath -Raw
        $statePlanMatch = [regex]::Match($strictState, '(?m)^- \*\*Plan state/decision:\*\* ACCEPTED (DEC-[0-9]+)\b')
        if (-not $statePlanMatch.Success) {
            $errors.Add('PROJECT_STATE.md plan state must be ACCEPTED with the same DEC-number required for substantive work.')
        }
        elseif (-not [string]::IsNullOrWhiteSpace($acceptedPlanDecisionId) -and $statePlanMatch.Groups[1].Value -ne $acceptedPlanDecisionId) {
            $errors.Add('PROJECT_STATE.md plan decision ID does not match PROJECT_PLAN.md.')
        }
        $rehydratedMatch = [regex]::Match($strictState, '(?m)^- \*\*Last rehydrated:\*\*\s*(.+)$')
        $rehydratedTime = [DateTimeOffset]::MinValue
        if (-not $rehydratedMatch.Success -or -not [DateTimeOffset]::TryParse($rehydratedMatch.Groups[1].Value.Trim(), [ref]$rehydratedTime)) {
            $errors.Add('PROJECT_STATE.md last rehydrated value must be a parseable timestamp with timezone.')
        }
        if ($strictState -notmatch '(?m)^- \*\*Current phase:\*\* (INTAKE|RESEARCH|PLAN|SKELETON|DEVELOPMENT|QA|INTEGRATION|RELEASE|BLOCKED)\s*$') {
            $errors.Add('PROJECT_STATE.md current phase is invalid.')
        }
        if ($strictState -notmatch '(?m)^- \*\*Current candidate classification:\*\* (DEVELOPMENT|DIAGNOSTIC|INTEGRATION|RELEASE CANDIDATE|RELEASED)\s*$') {
            $errors.Add('PROJECT_STATE.md candidate classification is invalid.')
        }
        $stateTeamMatch = [regex]::Match($strictState, '(?m)^- \*\*Team mode:\*\* (SOLO|SMALL TEAM|FULL TEAM)\s*$')
        if (-not $stateTeamMatch.Success -or $stateTeamMatch.Groups[1].Value -ne $teamMode) {
            $errors.Add('PROJECT_STATE.md team mode must match PROJECT_CHARTER.md.')
        }
        $stateRequestedWorkersMatch = [regex]::Match($strictState, '(?m)^- \*\*Requested simultaneous workers:\*\* ([0-9]+)\s*$')
        if (-not $stateRequestedWorkersMatch.Success -or [int]$stateRequestedWorkersMatch.Groups[1].Value -ne $requestedWorkerCount) {
            $errors.Add('PROJECT_STATE.md requested simultaneous workers must match PROJECT_CHARTER.md exactly.')
        }
        $stateWorkerPolicyMatch = [regex]::Match($strictState, '(?m)^- \*\*Worker model/effort policy:\*\* (.+)$')
        if (-not $stateWorkerPolicyMatch.Success -or $stateWorkerPolicyMatch.Groups[1].Value.Trim() -ne $workerModelPolicy) {
            $errors.Add('PROJECT_STATE.md worker model/effort policy must match PROJECT_CHARTER.md exactly.')
        }
        $stateIntakeReceiptMatch = [regex]::Match($strictState, '(?m)^- \*\*Staffing intake receipt:\*\* (.+)$')
        if (-not $stateIntakeReceiptMatch.Success -or $stateIntakeReceiptMatch.Groups[1].Value.Trim() -ne $staffingIntakeReceipt) {
            $errors.Add('PROJECT_STATE.md staffing intake receipt must match PROJECT_CHARTER.md exactly.')
        }
        $staffedPhaseMatch = [regex]::Match($strictState, '(?m)^- \*\*Staffed wave phase:\*\* (PLANNING|BUILD|REGROUP|INTEGRATION|QA|RELEASE)\s*$')
        if (-not $staffedPhaseMatch.Success) {
            $errors.Add('PROJECT_STATE.md staffed wave phase is invalid.')
        }
        $stateFirstWaveMatch = [regex]::Match($strictState, '(?m)^- \*\*First staffed build wave:\*\* ([A-Z][A-Z0-9_-]*)\s*$')
        if (-not $stateFirstWaveMatch.Success -or $stateFirstWaveMatch.Groups[1].Value -ne $firstStaffedWaveId) {
            $errors.Add('PROJECT_STATE.md first staffed build wave must match PROJECT_PLAN.md.')
        }
        $staffedCountsMatch = [regex]::Match($strictState, '(?m)^- \*\*Staffed build-wave counts:\*\* planned=([0-9]+); launched=([0-9]+); active=([0-9]+); implementation=([0-9]+); Director excluded\s*$')
        $staffedIdsMatch = [regex]::Match($strictState, '(?m)^- \*\*Staffed build-wave lane IDs:\*\* (.+)$')
        $staffedReceiptMatch = [regex]::Match($strictState, '(?m)^- \*\*Staffed build-wave receipt:\*\* (.+)$')
        $regroupMatch = [regex]::Match($strictState, '(?m)^- \*\*Integration regroup state:\*\* (.+)$')
        $staffedLaneIds = @()
        if ($staffedIdsMatch.Success -and $staffedIdsMatch.Groups[1].Value.Trim() -ne 'NONE') {
            $staffedLaneIds = @($staffedIdsMatch.Groups[1].Value -split ';' | ForEach-Object { $_.Trim() } | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
        }
        if (-not $staffedCountsMatch.Success) {
            $errors.Add('PROJECT_STATE.md staffed build-wave counts must use planned=N; launched=N; active=N; implementation=N; Director excluded.')
        }
        else {
            $staffedPlanned = [int]$staffedCountsMatch.Groups[1].Value
            $staffedLaunched = [int]$staffedCountsMatch.Groups[2].Value
            $staffedActive = [int]$staffedCountsMatch.Groups[3].Value
            $staffedImplementation = [int]$staffedCountsMatch.Groups[4].Value
            if ($staffedPlanned -ne $firstWaveCount -or $staffedLaneIds.Count -ne $firstWaveCount) {
                $errors.Add('PROJECT_STATE.md staffed planned count/lane IDs must match the first build wave in PROJECT_PLAN.md.')
            }
            if ($staffedPlanned -ne $requestedWorkerCount) {
                $errors.Add('PROJECT_STATE.md staffed planned count must equal the user-requested worker count.')
            }
            if ($staffedLaunched -ne $staffedPlanned) {
                $errors.Add('PROJECT_STATE.md staffed build wave must launch every planned worker before strict validation or waiting.')
            }
            if ($staffedImplementation -ne $firstWaveImplementationCount) {
                $errors.Add('PROJECT_STATE.md implementation-worker count must match PROJECT_PLAN.md worker classes.')
            }
            if ($staffedPhaseMatch.Success -and $staffedPhaseMatch.Groups[1].Value -eq 'BUILD' -and $staffedActive -ne $staffedPlanned) {
                $errors.Add('PROJECT_STATE.md BUILD phase must keep every staffed-wave worker active.')
            }
            if ($teamMode -eq 'FULL TEAM') {
                if ($staffedPlanned -lt 10 -or $staffedPlanned -gt 15 -or $staffedLaunched -lt 10 -or $staffedLaunched -gt 15) {
                    $errors.Add('PROJECT_STATE.md FULL TEAM must plan and launch 10-15 non-Director workers.')
                }
                if (($staffedImplementation * 2) -le $staffedPlanned) {
                    $errors.Add('PROJECT_STATE.md FULL TEAM must record an IMPLEMENTATION strict majority.')
                }
                if ($staffedPhaseMatch.Success -and $staffedPhaseMatch.Groups[1].Value -eq 'BUILD' -and ($staffedActive -lt 10 -or $staffedActive -gt 15)) {
                    $errors.Add('PROJECT_STATE.md FULL TEAM BUILD must keep 10-15 workers active.')
                }
            }
        }
        foreach ($planFirstWaveLaneId in @($firstWaveLaneIds)) {
            if ($planFirstWaveLaneId -notin $staffedLaneIds) {
                $errors.Add("PROJECT_STATE.md staffed build-wave lane IDs omit '$planFirstWaveLaneId'.")
            }
        }
        $staffedReceipt = if ($staffedReceiptMatch.Success) { $staffedReceiptMatch.Groups[1].Value.Trim() } else { '' }
        if ($staffedReceipt -notmatch '[0-9]{4}-[0-9]{2}-[0-9]{2}T') {
            $errors.Add('PROJECT_STATE.md staffed build-wave receipt requires a timestamp.')
        }
        foreach ($staffedLaneId in $staffedLaneIds) {
            $staffedIdPattern = '(?<![A-Z0-9_-])' + [regex]::Escape($staffedLaneId) + '(?![A-Z0-9_-])'
            if ($staffedReceipt -notmatch $staffedIdPattern) {
                $errors.Add("PROJECT_STATE.md staffed build-wave receipt omits lane '$staffedLaneId'.")
            }
        }
        $regroupState = if ($regroupMatch.Success) { $regroupMatch.Groups[1].Value.Trim() } else { '' }
        $handoffMatch = [regex]::Match($regroupState, '(?i)handoffs=([0-9]+)/([0-9]+)')
        if (-not $handoffMatch.Success -or [int]$handoffMatch.Groups[2].Value -ne $firstWaveCount) {
            $errors.Add('PROJECT_STATE.md integration regroup state must record handoffs=received/planned for the staffed wave.')
        }
        elseif ($staffedPhaseMatch.Success -and $staffedPhaseMatch.Groups[1].Value -in @('REGROUP', 'INTEGRATION', 'QA', 'RELEASE') -and
            ($regroupState -notmatch '(?i)^SATISFIED\b' -or [int]$handoffMatch.Groups[1].Value -ne $firstWaveCount)) {
            $errors.Add('PROJECT_STATE.md cannot enter REGROUP/INTEGRATION/QA/RELEASE before every staffed-wave handoff is satisfied.')
        }
        $readyMatch = [regex]::Match($strictState, '(?m)^- \*\*Ready independent lanes:\*\*\s*(.+)$')
        $runningMatch = [regex]::Match($strictState, '(?m)^- \*\*Running ready lanes:\*\*\s*([0-9]+)\s*$')
        $targetMatch = [regex]::Match($strictState, '(?m)^- \*\*Useful concurrency target:\*\*\s*([0-9]+)\s*$')
        $underMatch = [regex]::Match($strictState, '(?m)^- \*\*Under-utilization reason:\*\*\s*(.+)$')
        $launchReceiptMatch = [regex]::Match($strictState, '(?m)^- \*\*Last launch/replenishment receipt:\*\*\s*(.+)$')
        $waitReceiptMatch = [regex]::Match($strictState, '(?m)^- \*\*Director wait state/receipt:\*\*\s*(.+)$')
        $stateIdeaMatch = [regex]::Match($strictState, '(?m)^- \*\*Open brainstorm backlog:\*\*\s*([0-9]+)\b')
        if (-not $stateIdeaMatch.Success) {
            $errors.Add('PROJECT_STATE.md open brainstorm backlog must begin with a numeric count.')
        }
        elseif ($ideaCountMatch.Success -and [int]$stateIdeaMatch.Groups[1].Value -ne [int]$ideaCountMatch.Groups[1].Value) {
            $errors.Add('PROJECT_STATE.md brainstorm count does not match MASTER_CHECKLIST.md.')
        }
        $readyIds = @()
        if ($readyMatch.Success -and $readyMatch.Groups[1].Value.Trim() -ne 'NONE') {
            $readyIds = @($readyMatch.Groups[1].Value -split ';' | ForEach-Object { $_.Trim() } | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
            foreach ($readyId in $readyIds) {
                if ($readyId -notmatch '^[A-Z][A-Z0-9_-]*$') {
                    $errors.Add("PROJECT_STATE.md has an invalid ready stable lane ID: $readyId")
                }
            }
        }
        if (-not $runningMatch.Success -or -not $targetMatch.Success) {
            $errors.Add('PROJECT_STATE.md running-ready and useful-concurrency fields must begin with integers.')
        }
        else {
            $runningCount = [int]$runningMatch.Groups[1].Value
            $targetCount = [int]$targetMatch.Groups[1].Value
            if ($targetCount -ne $readyIds.Count) {
                $errors.Add('PROJECT_STATE.md useful concurrency target must equal the ready independent lane count.')
            }
            if ($runningCount -ne $targetCount) {
                $errors.Add('PROJECT_STATE.md running ready lanes must equal the useful concurrency target before strict validation or a wait.')
            }
            if ($runningCount -eq $targetCount -and ($underMatch.Success -and $underMatch.Groups[1].Value.Trim() -ne 'NONE')) {
                $errors.Add('PROJECT_STATE.md under-utilization reason must be NONE when running ready lanes equal target.')
            }
        }
        $launchReceipt = if ($launchReceiptMatch.Success) { $launchReceiptMatch.Groups[1].Value.Trim() } else { '' }
        $waitReceipt = if ($waitReceiptMatch.Success) { $waitReceiptMatch.Groups[1].Value.Trim() } else { '' }
        if ($readyIds.Count -gt 0) {
            if ($launchReceipt -match '(?i)^NOT APPLICABLE\b' -or $launchReceipt -notmatch '[0-9]{4}-[0-9]{2}-[0-9]{2}T') {
                $errors.Add('PROJECT_STATE.md ready lanes require a timestamped launch/replenishment receipt.')
            }
            foreach ($readyId in $readyIds) {
                $idPattern = '(?<![A-Z0-9_-])' + [regex]::Escape($readyId) + '(?![A-Z0-9_-])'
                if ($launchReceipt -notmatch $idPattern) {
                    $errors.Add("PROJECT_STATE.md launch/replenishment receipt omits ready lane '$readyId'.")
                }
            }
        }
        if ($waitReceipt -match '(?i)^WAITING\b') {
            if ($readyIds.Count -eq 0) {
                $errors.Add('PROJECT_STATE.md cannot wait on project tasks when no independent lane is ready.')
            }
            if ($waitReceipt -notmatch '\bwait_threads\b' -or $waitReceipt -notmatch '[0-9]{4}-[0-9]{2}-[0-9]{2}T') {
                $errors.Add('PROJECT_STATE.md WAITING state requires a timestamped wait_threads target/cursor receipt.')
            }
            foreach ($readyId in $readyIds) {
                $idPattern = '(?<![A-Z0-9_-])' + [regex]::Escape($readyId) + '(?![A-Z0-9_-])'
                if ($waitReceipt -notmatch $idPattern) {
                    $errors.Add("PROJECT_STATE.md wait_threads receipt omits ready lane '$readyId'.")
                }
            }
            $waitTaskIds = @([regex]::Matches($waitReceipt, '[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}'))
            if ($waitTaskIds.Count -lt $readyIds.Count) {
                $errors.Add('PROJECT_STATE.md wait_threads receipt does not contain one exact task ID per ready lane.')
            }
        }
        elseif ($waitReceipt -notmatch '(?i)^NOT WAITING\b') {
            $errors.Add('PROJECT_STATE.md Director wait state must begin with WAITING or NOT WAITING.')
        }
        if ($strictState -notmatch '(?m)^- \*\*Subagents carrying durable work:\*\* NONE\s*$') {
            $errors.Add('PROJECT_STATE.md must state that no subagents carry durable work.')
        }
        $stateLifecycleMatch = [regex]::Match($strictState, '(?m)^- \*\*Task lifecycle backlog:\*\*\s*(.+)$')
        $stateLifecycle = if ($stateLifecycleMatch.Success) { $stateLifecycleMatch.Groups[1].Value.Trim() } else { '' }
        $validUnarchivableState = $stateLifecycle -match '(?i)^UNARCHIVABLE\b' -and
            $stateLifecycle -match '[0-9a-fA-F]{8}-[0-9a-fA-F-]{27}' -and
            $stateLifecycle -match '(?i)archive attempt' -and
            $stateLifecycle -match '(?i)no unintegrated changes/processes'
        if ($stateLifecycle -ne 'NONE' -and -not $validUnarchivableState) {
            $errors.Add('PROJECT_STATE.md task lifecycle backlog must be NONE or a verified UNARCHIVABLE receipt with task ID, failed archive attempt, and no-unintegrated-changes/processes proof.')
        }
        elseif ($validUnarchivableState) {
            $warnings.Add('PROJECT_STATE.md records truthful host-level UNARCHIVABLE task debris; product work may continue but the sidebar cleanup limitation remains.')
        }
        if ($strictState -match '(?i)ARCHIVE PENDING|NOT VERIFIED') {
            $errors.Add('PROJECT_STATE.md contains an unresolved task startup or archive state.')
        }

        $stateTaskSection = [regex]::Match($strictState, '(?ms)^## Active task read-backs\s*(.*?)(?=^## |\z)').Groups[1].Value
        $stateTaskRows = @($stateTaskSection -split "`r?`n" | Where-Object { $_ -match '^\|' -and $_ -notmatch '^\|---' -and $_ -notmatch '^\| Stable lane ID ' })
        $stateLaneIds = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
        $stateLaneStatuses = @{}
        foreach ($row in $stateTaskRows) {
            $columns = @($row.Trim('|') -split '\|' | ForEach-Object { $_.Trim() })
            if ($columns.Count -lt 9 -or $row -match '<[^>]+>') {
                $errors.Add('PROJECT_STATE.md active task table contains an unresolved or malformed row.')
                continue
            }
            if (-not $stateLaneIds.Add($columns[0])) {
                $errors.Add("PROJECT_STATE.md contains duplicate active stable lane ID '$($columns[0])'.")
            }
            $stateLaneStatuses[$columns[0]] = $columns[4]
            if ($columns[1] -notmatch '[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}' -or
                $columns[1] -notmatch 'codex://threads/[0-9a-fA-F-]{36}') {
                $errors.Add("PROJECT_STATE.md lane '$($columns[0])' lacks an exact task ID and deeplink read-back.")
            }
            if ($columns[2] -match '(?i)NOT VERIFIED|PENDING|UNKNOWN' -or $columns[3] -match '(?i)NOT VERIFIED|PENDING|UNKNOWN') {
                $errors.Add("PROJECT_STATE.md lane '$($columns[0])' lacks verified actual model or project/workspace metadata.")
            }
            elseif (-not $columns[3].Contains($root)) {
                $errors.Add("PROJECT_STATE.md lane '$($columns[0])' actual project/workspace does not name the authoritative project root.")
            }
        }
        $activeStaffedStateCount = 0
        foreach ($staffedLaneId in $staffedLaneIds) {
            if (-not $stateLaneIds.Contains($staffedLaneId)) {
                $errors.Add("PROJECT_STATE.md staffed wave lane '$staffedLaneId' has no current task read-back.")
            }
            elseif ($stateLaneStatuses[$staffedLaneId] -eq 'ACTIVE') {
                $activeStaffedStateCount++
            }
        }
        if ($staffedPhaseMatch.Success -and $staffedPhaseMatch.Groups[1].Value -eq 'BUILD' -and $null -ne $staffedActive -and $activeStaffedStateCount -ne $staffedActive) {
            $errors.Add('PROJECT_STATE.md staffed active count does not match ACTIVE first-wave task read-backs.')
        }
        foreach ($readyId in $readyIds) {
            if (-not $stateLaneIds.Contains($readyId) -or $stateLaneStatuses[$readyId] -ne 'ACTIVE') {
                $errors.Add("PROJECT_STATE.md ready lane '$readyId' must have a current ACTIVE task read-back.")
            }
        }
        foreach ($stateLaneId in $stateLaneIds) {
            if ($stateLaneId -ne 'DIRECTOR' -and $stateLaneStatuses[$stateLaneId] -eq 'ACTIVE' -and $stateLaneId -notin $readyIds) {
                $errors.Add("PROJECT_STATE.md ACTIVE lane '$stateLaneId' is missing from the ready independent lane set.")
            }
        }
    }

    $researchPath = Join-Path $root 'PRIOR_ART_RESEARCH.md'
    if (Test-Path -LiteralPath $researchPath -PathType Leaf) {
        $research = Get-Content -LiteralPath $researchPath -Raw
        if ($research.Contains('| `<direct link>` |') -or $research.Contains('| `<ordinary category workflow>` |')) {
            $errors.Add('PRIOR_ART_RESEARCH.md still contains sample candidate or baseline rows.')
        }
        foreach ($tableContract in @(
            @{ Section = 'Candidate register'; Header = '^\| Candidate/source '; DecisionColumn = 5; Allowed = @('REUSE', 'ADAPT', 'LEARN', 'REJECT') },
            @{ Section = 'Baseline capability matrix'; Header = '^\| Baseline workflow/capability '; DecisionColumn = 3; Allowed = @('REQUIRED NOW', 'INTENTIONALLY EXCLUDED', 'NOT APPLICABLE') },
            @{ Section = 'Reuse decision'; Header = '^\| Needed capability '; DecisionColumn = 1; Allowed = @('REUSE', 'ADAPT', 'BUILD') }
        )) {
            $section = [regex]::Match($research, '(?ms)^## ' + [regex]::Escape($tableContract.Section) + '\s*(.*?)(?=^## |\z)').Groups[1].Value
            $rows = @($section -split "`r?`n" | Where-Object { $_ -match '^\|' -and $_ -notmatch '^\|---' -and $_ -notmatch $tableContract.Header })
            if ($rows.Count -eq 0) {
                $errors.Add("PRIOR_ART_RESEARCH.md section '$($tableContract.Section)' has no resolved decision rows.")
                continue
            }
            foreach ($row in $rows) {
                $columns = @($row.Trim('|') -split '\|' | ForEach-Object { $_.Trim().Trim('`') })
                if ($columns.Count -le $tableContract.DecisionColumn -or $columns[$tableContract.DecisionColumn] -notin $tableContract.Allowed) {
                    $errors.Add("PRIOR_ART_RESEARCH.md section '$($tableContract.Section)' has an invalid decision; allowed: $($tableContract.Allowed -join ', ').")
                }
            }
        }
    }

    $strictBoardPath = Join-Path $root 'COORDINATION_BOARD.md'
    if (Test-Path -LiteralPath $strictBoardPath -PathType Leaf) {
        $strictBoard = Get-Content -LiteralPath $strictBoardPath -Raw
        if ($strictBoard -notmatch '(?m)^- \*\*Subagents currently carrying durable work:\*\* NONE\s*$') {
            $errors.Add('COORDINATION_BOARD.md must state that no subagents are carrying durable work.')
        }
        $boardLifecycleMatch = [regex]::Match($strictBoard, '(?m)^- \*\*Task lifecycle backlog:\*\*\s*(.+)$')
        $boardLifecycle = if ($boardLifecycleMatch.Success) { $boardLifecycleMatch.Groups[1].Value.Trim() } else { '' }
        if ($null -ne $stateLifecycle -and $boardLifecycle -ne $stateLifecycle) {
            $errors.Add('COORDINATION_BOARD.md task lifecycle backlog does not match PROJECT_STATE.md.')
        }
        if ($strictBoard -notmatch '(?m)^- \*\*Duplicate live stable lanes:\*\* NONE\s*$') {
            $errors.Add('COORDINATION_BOARD.md must have no duplicate live stable lanes before strict validation.')
        }
        if ($strictBoard -match '(?m)^\| `?<LANE-ID>`? \|') {
            $errors.Add('COORDINATION_BOARD.md agent registry still contains the unresolved sample lane.')
        }
        if ($strictBoard -match '(?i)ARCHIVE PENDING') {
            $errors.Add('COORDINATION_BOARD.md still has a task awaiting archive reconciliation.')
        }
        $boardReadyMatch = [regex]::Match($strictBoard, '(?m)^- \*\*Ready independent lanes:\*\*\s*(.+)$')
        $boardRequestedWorkersMatch = [regex]::Match($strictBoard, '(?m)^- \*\*Requested simultaneous workers:\*\*\s*([0-9]+)\s*$')
        $boardWorkerPolicyMatch = [regex]::Match($strictBoard, '(?m)^- \*\*Worker model/effort policy:\*\*\s*(.+)$')
        $boardIntakeReceiptMatch = [regex]::Match($strictBoard, '(?m)^- \*\*Staffing intake receipt:\*\*\s*(.+)$')
        $boardStaffedPhaseMatch = [regex]::Match($strictBoard, '(?m)^- \*\*Staffed wave phase:\*\*\s*(.+)$')
        $boardFirstWaveMatch = [regex]::Match($strictBoard, '(?m)^- \*\*First staffed build wave:\*\*\s*(.+)$')
        $boardStaffedCountsMatch = [regex]::Match($strictBoard, '(?m)^- \*\*Staffed build-wave counts:\*\*\s*(.+)$')
        $boardStaffedIdsMatch = [regex]::Match($strictBoard, '(?m)^- \*\*Staffed build-wave lane IDs:\*\*\s*(.+)$')
        $boardStaffedReceiptMatch = [regex]::Match($strictBoard, '(?m)^- \*\*Staffed build-wave receipt:\*\*\s*(.+)$')
        $boardRegroupMatch = [regex]::Match($strictBoard, '(?m)^- \*\*Integration regroup state:\*\*\s*(.+)$')
        $boardRunningMatch = [regex]::Match($strictBoard, '(?m)^- \*\*Running ready lanes:\*\*\s*([0-9]+)\s*$')
        $boardTargetMatch = [regex]::Match($strictBoard, '(?m)^- \*\*Useful concurrency target:\*\*\s*([0-9]+)\s*$')
        $boardUnderMatch = [regex]::Match($strictBoard, '(?m)^- \*\*Under-utilization reason:\*\*\s*(.+)$')
        $boardLaunchMatch = [regex]::Match($strictBoard, '(?m)^- \*\*Last launch/replenishment receipt:\*\*\s*(.+)$')
        $boardWaitMatch = [regex]::Match($strictBoard, '(?m)^- \*\*Director wait state/receipt:\*\*\s*(.+)$')
        $boardActiveMatch = [regex]::Match($strictBoard, '(?m)^- \*\*Active tasks:\*\*\s*([0-9]+)\s*$')
        if (-not $boardActiveMatch.Success) {
            $errors.Add('COORDINATION_BOARD.md active tasks must be a numeric count.')
        }
        else {
            $boardActiveCount = [int]$boardActiveMatch.Groups[1].Value
        }
        if ($readyMatch.Success -and (-not $boardReadyMatch.Success -or $boardReadyMatch.Groups[1].Value.Trim() -ne $readyMatch.Groups[1].Value.Trim())) {
            $errors.Add('COORDINATION_BOARD.md ready independent lanes do not match PROJECT_STATE.md.')
        }
        if (-not $boardRequestedWorkersMatch.Success -or [int]$boardRequestedWorkersMatch.Groups[1].Value -ne $requestedWorkerCount) {
            $errors.Add('COORDINATION_BOARD.md requested simultaneous workers does not match PROJECT_CHARTER.md.')
        }
        if (-not $boardWorkerPolicyMatch.Success -or $boardWorkerPolicyMatch.Groups[1].Value.Trim() -ne $workerModelPolicy) {
            $errors.Add('COORDINATION_BOARD.md worker model/effort policy does not match PROJECT_CHARTER.md.')
        }
        if (-not $boardIntakeReceiptMatch.Success -or $boardIntakeReceiptMatch.Groups[1].Value.Trim() -ne $staffingIntakeReceipt) {
            $errors.Add('COORDINATION_BOARD.md staffing intake receipt does not match PROJECT_CHARTER.md.')
        }
        foreach ($stateBoardPair in @(
            @{ State = $staffedPhaseMatch; Board = $boardStaffedPhaseMatch; Name = 'staffed wave phase' },
            @{ State = $stateFirstWaveMatch; Board = $boardFirstWaveMatch; Name = 'first staffed build wave' },
            @{ State = $staffedIdsMatch; Board = $boardStaffedIdsMatch; Name = 'staffed build-wave lane IDs' },
            @{ State = $staffedReceiptMatch; Board = $boardStaffedReceiptMatch; Name = 'staffed build-wave receipt' },
            @{ State = $regroupMatch; Board = $boardRegroupMatch; Name = 'integration regroup state' }
        )) {
            if ($stateBoardPair.State.Success -and (-not $stateBoardPair.Board.Success -or $stateBoardPair.Board.Groups[1].Value.Trim() -ne $stateBoardPair.State.Groups[1].Value.Trim())) {
                $errors.Add("COORDINATION_BOARD.md $($stateBoardPair.Name) does not match PROJECT_STATE.md.")
            }
        }
        if ($staffedCountsMatch.Success) {
            $expectedStaffedCounts = "planned=$($staffedCountsMatch.Groups[1].Value); launched=$($staffedCountsMatch.Groups[2].Value); active=$($staffedCountsMatch.Groups[3].Value); implementation=$($staffedCountsMatch.Groups[4].Value); Director excluded"
            if (-not $boardStaffedCountsMatch.Success -or $boardStaffedCountsMatch.Groups[1].Value.Trim() -ne $expectedStaffedCounts) {
                $errors.Add('COORDINATION_BOARD.md staffed build-wave counts does not match PROJECT_STATE.md.')
            }
        }
        if ($runningMatch.Success -and (-not $boardRunningMatch.Success -or $boardRunningMatch.Groups[1].Value -ne $runningMatch.Groups[1].Value)) {
            $errors.Add('COORDINATION_BOARD.md running ready lane count does not match PROJECT_STATE.md.')
        }
        if ($targetMatch.Success -and (-not $boardTargetMatch.Success -or $boardTargetMatch.Groups[1].Value -ne $targetMatch.Groups[1].Value)) {
            $errors.Add('COORDINATION_BOARD.md useful concurrency target does not match PROJECT_STATE.md.')
        }
        if ($underMatch.Success -and (-not $boardUnderMatch.Success -or $boardUnderMatch.Groups[1].Value.Trim() -ne $underMatch.Groups[1].Value.Trim())) {
            $errors.Add('COORDINATION_BOARD.md under-utilization reason does not match PROJECT_STATE.md.')
        }
        if ($launchReceiptMatch.Success -and (-not $boardLaunchMatch.Success -or $boardLaunchMatch.Groups[1].Value.Trim() -ne $launchReceiptMatch.Groups[1].Value.Trim())) {
            $errors.Add('COORDINATION_BOARD.md launch/replenishment receipt does not match PROJECT_STATE.md.')
        }
        if ($waitReceiptMatch.Success -and (-not $boardWaitMatch.Success -or $boardWaitMatch.Groups[1].Value.Trim() -ne $waitReceiptMatch.Groups[1].Value.Trim())) {
            $errors.Add('COORDINATION_BOARD.md Director wait receipt does not match PROJECT_STATE.md.')
        }
    }

    $strictCommunicationPath = Join-Path $root 'AGENT_COMMUNICATION.md'
    if (Test-Path -LiteralPath $strictCommunicationPath -PathType Leaf) {
        $strictCommunication = Get-Content -LiteralPath $strictCommunicationPath -Raw
        $directorySection = [regex]::Match($strictCommunication, '(?ms)^## Task directory\s*(.*?)(?=^## |\z)').Groups[1].Value
        $directoryRows = @($directorySection -split "`r?`n" | Where-Object { $_ -match '^\|' -and $_ -notmatch '^\|---' -and $_ -notmatch '^\| Stable lane ID ' })
        $nonDirectorCount = 0
        $liveLaneIds = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
        $registeredLaneIds = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
        foreach ($row in $directoryRows) {
            $columns = @($row.Trim('|') -split '\|' | ForEach-Object { $_.Trim() })
            if ($columns.Count -lt 14 -or $row -match '<[^>]+>') {
                $errors.Add('AGENT_COMMUNICATION.md task directory contains an unresolved or malformed task row.')
                continue
            }

            $stableLaneId = $columns[0]
            $role = $columns[1]
            $mechanism = $columns[3].Trim('`')
            $taskId = $columns[4].Trim('`')
            $deeplink = $columns[5].Trim('`')
            $actualModel = $columns[6].Trim('`')
            $actualProject = $columns[7].Trim('`')
            $checklist = $columns[8].Trim('`')
            $lifecycle = $columns[11].Trim('`')
            $status = $columns[12].Trim('`')
            $terminalStates = @('STOPPED', 'REPLACED', 'MISCONFIGURED', 'DUPLICATE', 'SUPERSEDED')
            $isArchived = $lifecycle -match '(?i)^ARCHIVED\b'
            $isUnarchivable = $lifecycle -match '(?i)^UNARCHIVABLE\b' -and
                $lifecycle -match '(?i)archive attempt' -and
                $lifecycle -match '(?i)no unintegrated changes/processes'
            $isRetired = $isArchived -or $isUnarchivable
            if ($stableLaneId -notmatch '^[A-Z][A-Z0-9_-]*$') {
                $errors.Add("Task directory row '$role' has no valid stable lane ID.")
            }
            else {
                [void]$registeredLaneIds.Add($stableLaneId)
            }
            if ($role -eq 'Project Director') {
                if ($mechanism -ne 'current task') {
                    $errors.Add('The Project Director registry row must identify the current task as its origin.')
                }
            }
            else {
                $nonDirectorCount++
                if ($mechanism -notmatch '^create_thread\b' -or $mechanism -match 'spawn_agent') {
                    $errors.Add("Durable task '$role' was not created through create_thread; spawn_agent is never an allowed substitute.")
                }
            }
            if ($taskId -notmatch '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$') {
                $errors.Add("Task directory row '$role' has no exact returned task ID.")
            }
            if ($deeplink -notmatch '^codex://threads/[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$') {
                $errors.Add("Task directory row '$role' has no exact returned Codex deeplink.")
            }
            if ($actualModel -match '(?i)NOT VERIFIED|PENDING|UNKNOWN' -or $actualProject -match '(?i)NOT VERIFIED|PENDING|UNKNOWN') {
                $errors.Add("Task directory row '$role' lacks verified actual model or project/root/worktree metadata.")
            }
            elseif (-not $actualProject.Contains($root)) {
                $errors.Add("Task directory row '$role' actual project/root/worktree does not name the authoritative project root.")
            }
            if (-not $isRetired -and $stableLaneId -ne 'DIRECTOR' -and $null -ne $planAssignedModels -and $planAssignedModels.ContainsKey($stableLaneId)) {
                $assignedModel = $planAssignedModels[$stableLaneId]
                if ($assignedModel -ne 'AUTO / HOST DEFAULT' -and -not $actualModel.StartsWith($assignedModel, [System.StringComparison]::OrdinalIgnoreCase)) {
                    $errors.Add("Task directory row '$role' actual model/effort does not match its user-policy-backed PROJECT_PLAN.md assignment.")
                }
            }
            $checklistPath = Join-Path $root $checklist
            if (-not (Test-Path -LiteralPath $checklistPath -PathType Leaf)) {
                $errors.Add("Task directory row '$role' points to a missing checklist: $checklist")
            }
            else {
                $checklistContent = Get-Content -LiteralPath $checklistPath -Raw
                $checklistLaneMatch = [regex]::Match($checklistContent, '(?m)^- \*\*Stable lane ID:\*\*\s*(.+)$')
                $checklistWorkerMatch = [regex]::Match($checklistContent, '(?m)^- \*\*Worker class:\*\*\s*(.+)$')
                $checklistStartupMatch = [regex]::Match($checklistContent, '(?m)^- \*\*Actual task startup read-back:\*\*\s*(.+)$')
                $checklistModelMatch = [regex]::Match($checklistContent, '(?m)^- \*\*Model/effort:\*\*\s*(.+)$')
                $checklistPolicyMatch = [regex]::Match($checklistContent, '(?m)^- \*\*User-selected worker model policy:\*\*\s*(.+)$')
                $checklistPolicyReceiptMatch = [regex]::Match($checklistContent, '(?m)^- \*\*Model policy match receipt:\*\*\s*(.+)$')
                if (-not $checklistLaneMatch.Success -or $checklistLaneMatch.Groups[1].Value.Trim() -ne $stableLaneId) {
                    $errors.Add("Checklist '$checklist' stable lane ID does not match registry row '$stableLaneId'.")
                }
                if (-not $isRetired -and $stableLaneId -ne 'DIRECTOR' -and $null -ne $planWorkerClasses -and $planWorkerClasses.ContainsKey($stableLaneId) -and
                    (-not $checklistWorkerMatch.Success -or $checklistWorkerMatch.Groups[1].Value.Trim() -ne $planWorkerClasses[$stableLaneId])) {
                    $errors.Add("Checklist '$checklist' worker class does not match PROJECT_PLAN.md lane '$stableLaneId'.")
                }
                if (-not $isRetired -and $stableLaneId -ne 'DIRECTOR' -and $null -ne $planAssignedModels -and $planAssignedModels.ContainsKey($stableLaneId)) {
                    $assignedModel = $planAssignedModels[$stableLaneId]
                    if (-not $checklistModelMatch.Success -or -not $checklistModelMatch.Groups[1].Value.Trim().StartsWith($assignedModel, [System.StringComparison]::OrdinalIgnoreCase)) {
                        $errors.Add("Checklist '$checklist' model/effort does not match PROJECT_PLAN.md lane '$stableLaneId'.")
                    }
                    if (-not $checklistPolicyMatch.Success -or -not $checklistPolicyMatch.Groups[1].Value.Contains($workerModelPolicy)) {
                        $errors.Add("Checklist '$checklist' does not cite the exact user-selected worker model policy.")
                    }
                    if (-not $checklistPolicyReceiptMatch.Success -or $checklistPolicyReceiptMatch.Groups[1].Value.Trim() -notmatch '(?i)^MATCH\b') {
                        $errors.Add("Checklist '$checklist' lacks a MATCH receipt for its actual model/effort.")
                    }
                }
                if (-not $isRetired -and (-not $checklistStartupMatch.Success -or
                    -not $checklistStartupMatch.Groups[1].Value.Contains($taskId) -or
                    -not $checklistStartupMatch.Groups[1].Value.Contains($deeplink) -or
                    -not $checklistStartupMatch.Groups[1].Value.Contains($actualModel) -or
                    -not $checklistStartupMatch.Groups[1].Value.Contains($actualProject))) {
                    $errors.Add("Checklist '$checklist' startup read-back does not contain its exact task ID, deeplink, actual model, and actual project/root/worktree.")
                }
            }
            if ($lifecycle -match '(?i)ARCHIVE PENDING') {
                $errors.Add("Task directory row '$role' still awaits archive reconciliation.")
            }
            if ($status -in $terminalStates -and -not $isRetired) {
                $errors.Add("Terminal task directory row '$role' has no verified archive or UNARCHIVABLE receipt.")
            }
            if (-not $isRetired -and -not $liveLaneIds.Add($stableLaneId)) {
                $errors.Add("Stable lane '$stableLaneId' has more than one non-archived live task.")
            }
        }

        if ($planTaskRows.Count -gt $nonDirectorCount) {
            $errors.Add('PROJECT_PLAN.md defines more durable lanes than AGENT_COMMUNICATION.md registers with create_thread receipts.')
        }
        if ($null -ne $planLaneIds) {
            foreach ($planLaneId in $planLaneIds) {
                if (-not $registeredLaneIds.Contains($planLaneId)) {
                    $errors.Add("PROJECT_PLAN.md stable lane '$planLaneId' has no AGENT_COMMUNICATION.md registry row.")
                }
            }
        }
        if ($null -ne $stateLaneIds) {
            foreach ($liveLaneId in $liveLaneIds) {
                if (-not $stateLaneIds.Contains($liveLaneId)) {
                    $errors.Add("Live registry lane '$liveLaneId' is missing from PROJECT_STATE.md active task read-backs.")
                }
            }
            foreach ($stateLaneId in $stateLaneIds) {
                if (-not $liveLaneIds.Contains($stateLaneId)) {
                    $errors.Add("PROJECT_STATE.md lane '$stateLaneId' is not a non-archived live registry task.")
                }
            }
        }
        if ($null -ne $boardActiveCount -and $boardActiveCount -ne $liveLaneIds.Count) {
            $errors.Add('COORDINATION_BOARD.md active task count does not match non-archived registry tasks.')
        }
    }
}

$communicationPath = Join-Path $root 'AGENT_COMMUNICATION.md'
if (Test-Path -LiteralPath $communicationPath -PathType Leaf) {
    $communication = Get-Content -LiteralPath $communicationPath -Raw
    if ($communication.Contains('PENDING -')) {
        $message = 'AGENT_COMMUNICATION.md still has a pending Director task ID or deeplink.'
        if ($Strict) {
            $errors.Add($message)
        }
        else {
            $warnings.Add($message)
        }
    }
}

Write-Output "Project controls audit: $root"
Write-Output "Mode: $(if ($Strict) { 'STRICT' } else { 'ACTIVATION' })"
Write-Output "Errors: $($errors.Count)"
Write-Output "Warnings: $($warnings.Count)"

foreach ($warning in $warnings) {
    Write-Output "WARN: $warning"
}
foreach ($auditError in $errors) {
    Write-Output "FAIL: $auditError"
}

if ($errors.Count -gt 0) {
    exit 1
}

Write-Output 'PASS: required controls, outcome lock, resume packet, brainstorm linkage, staffed-wave and integration state, verified task lifecycle, timebox, drift, visual, links, and active checklists are coherent.'
if (-not $Strict -and $warnings.Count -gt 0) {
    Write-Output 'Activation passed with placeholders. Complete them and run again with -Strict before substantive implementation.'
}
