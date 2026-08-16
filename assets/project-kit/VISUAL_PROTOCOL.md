# Visual Protocol — Reference First, Skeleton Before Features

A mockup is a binding product reference when the user asks the implementation to follow it. Do not treat it as loose inspiration.

## Why agents miss mockups

- The image communicates composition implicitly, while code requires explicit measurements and hierarchy.
- Feature-first work hardens arbitrary containers, spacing, and navigation before fidelity is checked.
- Empty or mismatched candidate data can make the same components look like a different product.
- Functional tests reward behavior but say nothing about visual hierarchy.
- “Looks similar” has no stable meaning without exact viewport, state, and comparison evidence.

## Gate 1 — Reference contract

Before implementation, record:

- exact reference identity/path and version;
- viewport, display scaling, theme, and device class;
- meaningful UI state, selection, data density, errors, and overlays;
- major regions in reading order;
- grid/columns, widths, heights, spacing, alignment, and scroll behavior;
- typography hierarchy, color roles, borders, radii, elevation, and imagery;
- fixed, fluid, sticky, overlay, responsive, and repeated structures;
- interaction states that the still image cannot prove;
- audience/occasion, intended emotional character, and concrete personalization/polish signals when applicable;
- ambiguities requiring user decisions.

Convert these into measurable master/agent rows. Do not begin feature implementation from the image alone.

An emotional promise such as care, delight, professionalism, calm, or celebration is not satisfied by generic decoration. It requires coherent details appropriate to the recipient: deliberate copy, visual consistency, thoughtful defaults, complete states, smooth first launch, and no placeholder or template residue.

## Gate 2 — Real-control skeleton

Build only the structural shell using the actual application controls and layout system:

- correct page frame, navigation, header, primary workspace, secondary regions, and footer/commands;
- correct hierarchy, proportions, spacing system, and representative populated placeholders;
- responsive behavior for the controlling sizes;
- no deep feature logic beyond what is needed to render truthful representative states.

The skeleton is not a throwaway picture. It is the real implementation structure that features will inhabit.

## Gate 3 — Exact rendered comparison

Render the skeleton at the same viewport and semantically matched state as the reference. Compare side by side and record:

- region bounds and proportions;
- hierarchy and attention order;
- typography scale and density;
- spacing/alignment rhythm;
- missing, extra, or displaced surfaces;
- every material mismatch and its disposition.

Source review, an AI-generated image, a unit test, or an empty shell does not satisfy this gate.

## Gate 4 — Skeleton approval and freeze

Obtain explicit approval for the exact rendered skeleton candidate from an independent Visual Auditor using the measured reference contract. Record its identity and evidence ID. User approval before feature work is required only for a material interpretation that the references, intent synthesis, and auditor cannot resolve. Then freeze the structural contract:

- feature agents receive named slots/regions rather than freedom to redesign the page;
- changes to primary hierarchy, region bounds, navigation, or responsive structure require a decision and renewed skeleton review;
- shared layout files have one explicit owner.

Feature work remains blocked until this gate is approved when the mockup controls the promise.

## Gate 5 — Features inside the skeleton

Implement one vertical feature slice at a time within its assigned slot. Use fixtures that match the reference state, including realistic density, long text, selection, errors, and disabled/pending states. Do not let feature convenience silently reshape the approved composition.

## Gate 6 — Final visual acceptance

Render the complete real controls at every controlling viewport and state. Compare again to the approved skeleton and original reference. Skeleton approval proves structure only; final human acceptance of the exact finished candidate is a separate open gate.

## Drift alarms for visual work

Trigger `CHANGES REQUESTED` when any occurs:

- feature logic begins before skeleton approval;
- the candidate is rendered at a different viewport or semantic state without disclosure;
- agents call source structure, mock images, or functional tests visual proof;
- shared layout changes without recorded ownership;
- many components are polished while primary composition remains wrong;
- a feature agent changes skeleton hierarchy to make its local task easier.

## Visual checkpoint report

```text
Reference: <exact file/version/viewport/state>
Candidate: <exact build/commit/viewport/state>
Gate: <REFERENCE/SKELETON/FEATURE/FINAL>
Matched: <material relationships verified>
Mismatched: <material differences>
Evidence: <EV IDs and captures>
Approval: <OPEN/APPROVED and by whom>
Feature work allowed: <YES/NO>
Next: <one correction or slice>
```
