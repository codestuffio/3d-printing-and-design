---
date: 2026-10-11
category: home-office
topic: paper-stack-corner-jogger
---

# Proposal: paper-stack corner jogger

A small L-shaped fence could help square a same-size stack of loose pages before gripping it and applying an existing binder clip. Its practical target is fewer repeated alignment attempts and less edge spread after transfer. This is a proposal only. OpenSCAD implementation requires separate approval.

## Intended use and evidence

Place the fence on the desk, bring two adjacent paper edges against its inner faces, then grip the stack and slide it out through the open sides. The paper rests directly on the desk throughout alignment. The tool would suit a recurring paperwork routine where hand tapping leaves uneven edges or needs repeated attempts. No such problem, document volume or paper habit has been reported by the user.

[Smith Signature Prints sells a paper-cutter jogger-block STL and 3MF](https://smithsignatureprints.com/products/paper-cutter-alignment-guide-jogger-block-stl-file). The listing establishes existing printable prior art; its files, dimensions and physical performance were not inspected. This proposal would use original, simple fence geometry. It makes no novelty claim and does not attach to a cutter.

The [Rapesco 1725 punch manual](https://rapesco.com/kd733/wp-content/uploads/2024/12/1725_A5-Diary-Punch-MANUAL-MULTI-LANG_2024_EN.pdf) describes page-edge and center registration for different paper sizes. This is adjacent evidence that paper positioning matters in an office task, not evidence that this fence improves punching or that the user owns that punch.

Two perpendicular stops can locate a rectangular sheet. A flexible stack may resist sliding because of curl or friction, buckle under pressure, or lose registration when gripped. The hypothesis is worth a small comparison because those failures are observable. Ordinary tapping on the desk is the baseline. If it already works as well, skip the print.

## Smallest practical design

One bottomless L-shaped fence with two short, straight inner contact faces, low walls, outward-facing feet and a relieved inner corner. The feet stay entirely outside the paper area so the lowest sheet never has to climb a floor, ledge or ramp. The open sides provide hand access and an exit path. Keep the desk as the common support plane for every sheet.

Wall height would serve one measured stack range. Contact length must be enough to control rotation without using a full-page tray. Corner relief should clear print buildup while preserving straight contact along both edges. Print texture and elephant-foot bulging at the lowest contact height remain fit risks.

Start without a clip recess, moving stops, paper-size markings, scanner attachment or powered vibration. Apply the existing binder clip after removing the gripped stack. Transfer drift is part of the acceptance test; extra clip access should be reconsidered only if a useful basic fence fails at that step.

## Parametric OpenSCAD approach

If approved, union two perpendicular rectangular walls with broad exterior foot profiles and subtract the corner relief. Keep the inner faces planar; round only external edges that do not define the paper reference. Expose millimeter parameters for both contact lengths, wall height and thickness, external foot width, corner relief, external edge radius and printer compensation at the lower contact face.

Assertions would reject nonpositive dimensions, disconnected feet, relief that removes useful contact, and rounding or compensation that erases a wall. Export a small complete fence first so both registration and stability are tested together. Check a closed, connected mesh and meaningful valid/invalid parameter cases. Keep editable source and ignored exports under the repository conventions.

## Material, hardware and measurements

PLA is a candidate for a cool indoor prototype. PETG could be considered if the measured environment requires a different material, with print behavior checked again. Start with the exterior feet flat on the bed and walls upward. Inspect the actual toolpath, base flatness and paper-contact texture before use. No purchased hardware is needed initially. Grip pads are a later response to measured sliding, not assumed to solve stability.

Before CAD work, confirm a recurring same-size paper task. Record sheet dimensions, cut-edge variation, paper thickness and curl, minimum/typical/maximum sheet counts, total stack height, the current alignment routine and the next handling step. Measure desk space and surface, hand access, existing binder-clip position, printer/nozzle/layer settings and material. Choose an edge-spread measurement method, record its resolution and agree on a useful improvement target before testing.

## Acceptance and physical validation

1. First compare a simple cardboard L-fence with normal hand tapping. Reject the concept before CAD if it adds work without improving the completed task.
2. After approval, verify mesh connectivity and intended parameter assertions. On the print, measure contact-face squareness and check that the lowest sheet reaches both faces without climbing a bulge or catching a seam.
3. Use the same sheets in ten paired alignment-and-transfer trials per representative stack size, alternating baseline/tool order. Start from comparable shuffled edges; record total time, retries and maximum edge spread along both registered edges after gripping, removing and clipping the stack. Record the measurement resolution.
4. Continue only if the chosen outcome repeatedly improves and meets the agreed target. Final edge spread must not worsen beyond the recorded measurement resolution, retries and total handling time must not increase, and no new paper damage or stability failures may occur. A neat stack still inside the fence is insufficient evidence.
5. Include representative curled sheets. Record buckling, snagging, sheet marks, fixture sliding or tipping and loss of registration during removal. Inspect wear and base flatness after twenty handling cycles. Stop if the fence needs excessive pressure or creates new paper damage.

No CAD, slicer, print, alignment, wear or usefulness evidence exists. A cardboard trial tests the workflow but cannot establish printed tolerances or surface behavior. This is a desk tool; scanner feed quality and cutting accuracy would need separate evidence.

## Selection rationale

Thirty candidates across paper alignment, cable service access and small repair handling were generated before critique. The corner-jogger family offered a compact, independent physical trial and no device-specific interface. Its benefit remains weaker evidence than a reported user problem.

A punch-centering stop had stronger task evidence but depends on an unconfirmed punch and refill routine. A carrier-sheet loading square similarly needs an actual scanner sleeve. Cable-end holders overlap the existing cable-management work and cheap clips; repair trays overlap the fastener dock and ordinary divided boxes. Lift-away frames and clip-access variants were folded into the jogger comparison, then omitted from the first prototype. The prior card perch displays a task; this proposal aligns a document stack.
