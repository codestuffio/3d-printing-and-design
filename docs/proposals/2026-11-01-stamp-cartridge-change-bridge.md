# Stamp cartridge change bridge

Date: 2026-11-01. Category: home office. Proposal only; CAD requires separate approval.

## Intended use and evidence

Temporarily park one removed self-inking stamp cartridge during its manufacturer-permitted replacement procedure. The practical problem would be a cartridge that rocks or transfers ink while being set down, forcing the user to hold it while handling the stamp. No owner device, repeated problem or inadequate baseline has been confirmed.

[Trodat's FAQ](https://www.trodat.net/int/en/services/faq) confirms that removal varies by model. Its [Printy usage page](https://www.trodat.net/int/en/services/usage-tips/original-trodat-printy) supplies model-specific replacement guidance. These sources establish the operation, not a need for a printed rest. No novelty, cleanliness, savings or compatibility claim is established.

First try the cartridge ink-face-up on its dry back, its original packaging and a stable dish over disposable paper. If any method works adequately, stop. Do not create a parking step when the normal change needs none, or add refilling, disassembly or cleaning steps to the manufacturer's procedure.

## Smallest practical design

One low, open bridge has two broad rails under measured clean, rigid cartridge edges and a crossbar clear of the cartridge. The cartridge rests ink-face-up, with finger access to its handling tabs. The ink pad and other wetted surfaces stay clear of the print and bench. Disposable paper beneath catches incidental transfer.

No basin, snap fit, clamp, lever or part inserted into the stamp. Reject this design if the cartridge lacks suitable dry support edges. This is a temporary maintenance rest, separate from the repository's rotating tape-core repair.

## Parametric OpenSCAD approach after approval

Use original rounded 2D profiles, extrusion and joined rails/crossbar in millimeters. Expose support-edge spacing/length, rail width/height, pad clearance, overhang, finger-access gap, base depth and corner radius at the top. A short same-source two-rail coupon samples the contact interface before the full print.

Guard positive dimensions, connected joins, adequate walls and useful clearance. Check small/default/large valid cases, meaningful invalid clearances/joins, strict closed connected meshes, and feature probes that reject an obstructed pad space or blocked handling-tab access. Export checks establish geometry only.

PLA is a candidate for a cool indoor dry-fit coupon; PETG is an alternative for handling trials. Neither is assumed ink-resistant or non-marring. No added hardware is planned. Inspect slicing for flat-bed orientation, unsupported rails and layer continuity; choose print settings after dimensions and loads are known. Discard a contaminated rest if no cleaning method is compatible with both materials.

## Measurements and unknowns

Identify the owned stamp/cartridge, replacement instructions and actual recurring failure first. Measure dry-edge contact bands, pad/wetted envelope, back protrusions, mass/balance, handling tabs, lift-out clearance and desk space. Establish whether the old cartridge ever needs setting down and whether changes are frequent enough to justify a dedicated print.

Record printer error, coupon clearance and any intended cleaning method. No manufacturer support-edge drawing, owner measurements, ink compatibility or physical loading evidence was obtained. Keep the rest external to the stamp mechanism.

## Acceptance and physical validation

After separate approval, inspect slicing and print the coupon first. On an expendable compatible cartridge, require gentle seating/lift-out without force, pad contact, trapped tabs, marks or distortion. Confirm that the ink face stays upward and wetted areas clear the rest during placement and removal. Then print the bridge and check rocking, sliding and tipping on the intended desk over disposable paper.

Before comparison, choose a minimum useful reduction in whole-task time or ink transfers and establish that ordinary handling exhibits the targeted problem. Compare the best baseline with the bridge across ten matched changes or permitted change rehearsals per method, alternating order on equivalent cartridges. Match ink loading, age, drying time and initial contamination; use fresh paper and reset contact surfaces between trials. Dry rehearsals establish handling only, not ink-transfer performance.

Include retrieval, setup, replacement, put-away and cleanup time. Report fabrication effort, storage and cleaning burden separately, and judge them against the actual replacement frequency; keep first-use practice separate from recurring service time. Count ink transfers, unwanted regrips, tips, mistakes and damage. Rehearsals do not establish long-term service benefit; zero baseline failures leave error reduction unestablished.

Complete twenty additional seating/lift-out cycles on an expendable cartridge and inspect rail wear, retained ink, access and stability. Reject pad contact, ink transfer from the rest, damaged plastic, binding or worse total handling than the baseline. CAD, slicing, print, fit, stability, ink containment, wear and usefulness remain unverified.
