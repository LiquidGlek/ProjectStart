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
Require-Text 'MASTER_CHECKLIST.md' '## Claim-scoped health'
Require-Text 'MASTER_CHECKLIST.md' '## Candidate promotion gate'
Require-Text 'DECISION_LOG.md' '## Correction and regression ledger'
Require-Text 'AGENT_CHECKLIST_TEMPLATE.md' '**Active correction IDs:**'
Require-Text 'AGENT_CHECKLIST_TEMPLATE.md' '**Critical journey transaction contract:**'
Require-Text 'PROJECT_CHARTER.md' '## User intent synthesis'
Require-Text 'PROJECT_CHARTER.md' '**Anti-intent:**'
Require-Text 'PROJECT_CHARTER.md' '**Emotional promise:**'
Require-Text 'PROJECT_CHARTER.md' '**Distribution context:**'
Require-Text 'PRIOR_ART_RESEARCH.md' '**Parity interpretation:**'
Require-Text 'PROJECT_PLAN.md' '## Adversarial self-audit'
Require-Text 'PROJECT_PLAN.md' '## Critical journey transaction contract'
Require-Text 'PRIOR_ART_RESEARCH.md' '## Reuse decision'
Require-Text 'PRIOR_ART_RESEARCH.md' '## Baseline capability matrix'
Require-Text 'PRIOR_ART_RESEARCH.md' 'REQUIRED NOW / INTENTIONALLY EXCLUDED / NOT APPLICABLE'
Require-Text 'PRIOR_ART_RESEARCH.md' '<REUSE/ADAPT/LEARN/REJECT>'
Require-Text 'PRIOR_ART_RESEARCH.md' 'license'
Require-Text 'PROJECT_PLAN.md' '## Ordered vertical slices'
Require-Text 'PROJECT_PLAN.md' '## Checklist derivation gate'
Require-Text 'PROJECT_PLAN.md' '**Plan state:**'
Require-Text 'PROJECT_PLAN.md' 'Creation mechanism'
Require-Text 'PROJECT_PLAN.md' 'Each planned lane must use `create_thread`; `spawn_agent` is prohibited.'
Require-Text 'COORDINATION_BOARD.md' 'Lanes showing test churn/no outcome movement'
Require-Text 'COORDINATION_BOARD.md' 'Primary outcome state'
Require-Text 'COORDINATION_BOARD.md' 'Current timebox stage'
Require-Text 'COORDINATION_BOARD.md' 'Planned durable lanes lacking create_thread receipt'
Require-Text 'COORDINATION_BOARD.md' 'Subagents currently carrying durable work'
Require-Text 'AGENT_COMMUNICATION.md' '## Director address'
Require-Text 'AGENT_COMMUNICATION.md' '## Task directory'
Require-Text 'AGENT_COMMUNICATION.md' '## Task creation contract'
Require-Text 'AGENT_COMMUNICATION.md' '**Durable lane creation tool:** `create_thread`'
Require-Text 'AGENT_COMMUNICATION.md' '**Forbidden substitute:** `spawn_agent`'
Require-Text 'AGENT_COMMUNICATION.md' 'No durable domain is hidden behind a subagent.'
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

        if ($Strict) {
            $relativeAgentPath = [System.IO.Path]::GetRelativePath($root, $agentFile.FullName)
            Require-ResolvedField $relativeAgentPath 'Task type'
            Require-ResolvedField $relativeAgentPath 'Creation mechanism/receipt'
            Require-ResolvedField $relativeAgentPath 'Subagent status'

            $taskType = [regex]::Match($agent, '(?m)^- \*\*Task type:\*\* (.+)$').Groups[1].Value.Trim()
            $creationMechanism = [regex]::Match($agent, '(?m)^- \*\*Creation mechanism/receipt:\*\* (.+)$').Groups[1].Value.Trim()
            $subagentStatus = [regex]::Match($agent, '(?m)^- \*\*Subagent status:\*\* (.+)$').Groups[1].Value.Trim()

            if ($taskType -notin @('TOP-LEVEL CODEX TASK', 'CURRENT DIRECTOR TASK')) {
                $errors.Add("$($agentFile.Name) task type must be TOP-LEVEL CODEX TASK or CURRENT DIRECTOR TASK.")
            }
            if ($taskType -eq 'TOP-LEVEL CODEX TASK' -and $creationMechanism -notmatch '^create_thread\b') {
                $errors.Add("$($agentFile.Name) owns a durable lane but has no create_thread receipt.")
            }
            if ($creationMechanism -match 'spawn_agent' -or $subagentStatus -ne 'NOT A SUBAGENT') {
                $errors.Add("$($agentFile.Name) is a durable project checklist assigned to a subagent; create a top-level Codex task instead.")
            }
        }
    }
}

$activeFiles = @('PROJECT_CHARTER.md', 'MASTER_CHECKLIST.md', 'PRIOR_ART_RESEARCH.md', 'PROJECT_PLAN.md', 'COORDINATION_BOARD.md', 'AGENT_COMMUNICATION.md', 'agent-checklists\coordinator.md')
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
    $strictFields = @{
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
        if ($plan -notmatch '(?m)^\*\*Decision ID:\*\* DEC-[0-9]+\s*$') {
            $errors.Add('PROJECT_PLAN.md must cite an accepted DEC-number before substantive implementation.')
        }
        if ($plan -match '<finding>|<simplification>|<autonomous route>|<merge/split/reroute>|<scope correction>|<evidence or correction>|<proof plan or honest blocker>|<controlling correction>|<transaction-contract repair>|<candidate-churn guardrail>|<guardrail/direct journey>') {
            $errors.Add('PROJECT_PLAN.md adversarial self-audit still contains unresolved sample findings or repairs.')
        }

        $planTaskSection = [regex]::Match($plan, '(?ms)^## Top-level task design\s*(.*?)(?=^## |\z)').Groups[1].Value
        $planTaskRows = @($planTaskSection -split "`r?`n" | Where-Object { $_ -match '^\|' -and $_ -notmatch '^\|---' -and $_ -notmatch '^\| Proposed top-level task/lane ' })
        foreach ($row in $planTaskRows) {
            $columns = @($row.Trim('|') -split '\|' | ForEach-Object { $_.Trim() })
            if ($row -match '<[^>]+>') {
                $errors.Add('PROJECT_PLAN.md top-level task design still contains an unresolved sample or placeholder row.')
                continue
            }
            if ($columns.Count -lt 3 -or $columns[2].Trim('`') -ne 'create_thread') {
                $errors.Add('Every PROJECT_PLAN.md durable lane must name create_thread as its creation mechanism.')
            }
        }
    }

    $strictMasterPath = Join-Path $root 'MASTER_CHECKLIST.md'
    if (Test-Path -LiteralPath $strictMasterPath -PathType Leaf) {
        $strictMaster = Get-Content -LiteralPath $strictMasterPath -Raw
        if ($strictMaster.Contains('| Primary journey | `<NOT RUN/PARTIAL/FAIL/BLOCKED/PASS>`')) {
            $errors.Add('MASTER_CHECKLIST.md claim-scoped health still contains the unresolved Primary journey sample row.')
        }
    }

    $researchPath = Join-Path $root 'PRIOR_ART_RESEARCH.md'
    if (Test-Path -LiteralPath $researchPath -PathType Leaf) {
        $research = Get-Content -LiteralPath $researchPath -Raw
        if ($research.Contains('| `<direct link>` |') -or $research.Contains('| `<ordinary category workflow>` |')) {
            $errors.Add('PRIOR_ART_RESEARCH.md still contains sample candidate or baseline rows.')
        }
    }

    $strictBoardPath = Join-Path $root 'COORDINATION_BOARD.md'
    if (Test-Path -LiteralPath $strictBoardPath -PathType Leaf) {
        $strictBoard = Get-Content -LiteralPath $strictBoardPath -Raw
        if ($strictBoard -notmatch '(?m)^- \*\*Subagents currently carrying durable work:\*\* NONE\s*$') {
            $errors.Add('COORDINATION_BOARD.md must state that no subagents are carrying durable work.')
        }
        if ($strictBoard -match '(?m)^\| `?<lane>`? \|') {
            $errors.Add('COORDINATION_BOARD.md agent registry still contains the unresolved sample lane.')
        }
    }

    $strictCommunicationPath = Join-Path $root 'AGENT_COMMUNICATION.md'
    if (Test-Path -LiteralPath $strictCommunicationPath -PathType Leaf) {
        $strictCommunication = Get-Content -LiteralPath $strictCommunicationPath -Raw
        $directorySection = [regex]::Match($strictCommunication, '(?ms)^## Task directory\s*(.*?)(?=^## |\z)').Groups[1].Value
        $directoryRows = @($directorySection -split "`r?`n" | Where-Object { $_ -match '^\|' -and $_ -notmatch '^\|---' -and $_ -notmatch '^\| Role/domain ' })
        $nonDirectorCount = 0
        foreach ($row in $directoryRows) {
            $columns = @($row.Trim('|') -split '\|' | ForEach-Object { $_.Trim() })
            if ($columns.Count -lt 5 -or $row -match '<[^>]+>') {
                $errors.Add('AGENT_COMMUNICATION.md task directory contains an unresolved or malformed task row.')
                continue
            }

            $role = $columns[0]
            $mechanism = $columns[2].Trim('`')
            $taskId = $columns[3].Trim('`')
            $deeplink = $columns[4].Trim('`')
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
        }

        if ($planTaskRows.Count -gt $nonDirectorCount) {
            $errors.Add('PROJECT_PLAN.md defines more durable lanes than AGENT_COMMUNICATION.md registers with create_thread receipts.')
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

Write-Output 'PASS: required controls, outcome lock, timebox, drift alarms, visual skeleton contract, links, and active coordinator checklist are present.'
if (-not $Strict -and $warnings.Count -gt 0) {
    Write-Output 'Activation passed with placeholders. Complete them and run again with -Strict before substantive implementation.'
}
