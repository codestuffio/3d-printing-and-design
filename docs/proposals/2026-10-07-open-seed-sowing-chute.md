---
date: 2026-10-07
category: gardening
topic: open-seed-sowing-chute
---

# Proposal: open seed-sowing chute

A small hand-held tray could keep a few seeds visible and guide them through an open tip close to the soil. The user would tilt and tap the tray to release seeds, then pour leftovers back into the packet. This is a proposal only. OpenSCAD implementation requires separate approval.

## Intended use and evidence

The intended use is sowing one measured type of dry seed into a prepared row or seed tray. An open channel would let the user see and reach seeds that stop moving. A light-colored prototype could make dark seeds easier to see, although surface texture and static may make a printed part worse than paper.

[University of Maryland Extension's salad-table guidance](https://extension.umd.edu/resource/plant-fertilize-water-salad-tabletm-or-salad-boxtm) describes tapping seeds from a folded index card and keeping it close to the growing mix because round seeds bounce. It also notes that dark seeds can be hard to see against dark media. That supports the handling task and a strong existing solution. It does not prove a printed chute will improve it. Follow the actual seed packet's sowing instructions; the chute would set neither spacing nor depth.

No user report of spilled seeds or difficult sowing has been collected. Garden ownership alone does not establish this need. Garden stake caps and light-stake replacements serve different tasks. The earlier rack saddle, RC fastener dock and card perch are also distinct. Novelty, demand and usefulness remain unverified. Skip this design if the user does not sow seeds by hand, or if a folded card or small spoon works as well.

## Smallest practical design

One shallow tray with a flat underside, rounded back and side walls, a finger-holding area, and a narrowing open trough at the front. The outlet would remain wide enough for the selected seeds to pass freely. It would not dispense a guaranteed count per tap. The channel stays accessible along its whole length so a stuck seed can be nudged out and residue inspected.

Start with one seed type and one small batch. A lid, rotating dial, calibrated gate, packet clip, storage compartment and row-spacing mechanism would add scope before basic handling is demonstrated. The main drawback is the printed surface: layer ridges, damp debris or static could hold seeds, and an open tray may spill when bumped.

## Parametric OpenSCAD approach

If approved, hull simple tray and outlet profiles, then subtract a continuous open channel with rounded internal transitions. Keep dimensions in millimeters at the top of the source. Expose tray length and width, holding-area length, channel depth, outlet width and length, wall and floor thickness, transition radius and edge rounding. The outlet should have no raised step that traps the selected seed.

Reject nonpositive dimensions, an outlet wider than its tray, broken floor or walls, and rounding that erases the narrow end. Export a short channel-and-tip coupon before the full tray. The full design would remain one closed, connected mesh with editable source and regenerated exports in the project's ignored exports folder. Geometry checks would establish neither seed flow nor cleanability.

## Material, hardware and measurements

PLA is a candidate for a cool, dry indoor handling prototype. Consider another material only after establishing the actual temperature, cleaning routine and use environment. No purchased hardware is required. A flat underside with the channel facing up is the intended printing orientation; the slicer must establish support needs and whether interior steps or rough surfaces will catch seeds. A printed tray is not a moisture-proof seed-storage container.

Before CAD work, confirm the user's sowing routine and compare the current card or spoon. Measure the selected seeds' size, shape and variation, the packet opening for returning leftovers, desired batch size, comfortable grip and reach, outlet clearance over the row or tray, printer capability and available material. Record whether treated seeds are involved and follow their packet handling and cleaning directions. Do not assume all crops or coated seeds will behave alike.

## Acceptance checks and physical validation

1. The coupon passes the selected dry seeds without force, crushing or a need to shake violently. Record jams and clumps; change the channel or stop if the printed texture defeats it.
2. The full design exports as one closed, connected mesh. Its floor and walls remain intact over the approved parameter range, and the outlet stays open.
3. The user can hold the tray near the actual sowing surface, release seeds by controlled tilting and tapping, and return unused seeds to the measured packet opening.
4. Run ten recorded transfer cycles with the same seed type and batch size. Count unintended spills, jams and seeds left behind, and record handling time. Inspect the channel for seed damage, residue and rough edges.
5. Compare equal batches and the same target against a folded index card and the current tool. Continue only if the print makes handling easier or reduces unintended spills without making seed release or recovery worse.
6. After the intended cleaning routine, inspect the open channel and confirm it is dry before another seed batch. Stop if residue cannot be removed or seed types cannot be kept separate.

Print the coupon first, then one complete tray if it works. Record seed type, batch size, material, print settings, conditions and results. No CAD, slicer, print, seed-flow, cleaning or durability test has been performed. Better germination, yield and planting precision are not established benefits.

## Selection rationale

Thirty candidates across six ideation lenses were generated before critique. A fresh basis review favored the open chute because the sowing task has direct horticultural guidance, the part is small, and a cheap comparison can reject it before further work. Two overlapping pour-boat and zero-hardware ideas were folded into this single family.

Pot feet and a crop-specific spacing gauge were credible alternatives, but need a particular drainage problem or repeated spacing task. Ties and trellis parts risk overlapping the existing stake cap; a packet display repeats the card perch. Other tool holders, dividers and winders lacked a measured advantage over hooks, cardboard or string. Approval of this brief would not by itself authorize CAD implementation.
