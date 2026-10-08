---
date: 2026-10-08
category: playful
topic: wobble-potato
---

# Proposal: wobble potato

A squat potato with an unimpressed face could rock from side to side after a gentle finger nudge. Its curved belly would provide the motion; a low, broad body would aim to bring it back toward upright. This is a proposal only. OpenSCAD implementation requires separate approval.

## Intended use and evidence

Place the potato on a level desk, nudge it within a modest tested angle, and watch it wobble to rest. The appeal is a silly expression paired with a simple physical interaction. Enjoyment is subjective, and no user demand, therapeutic benefit or productivity improvement has been established.

The [Roly Poly Owl creator](https://www.reddit.com/r/3dprinter/comments/1uvbhpl/meet_my_roly_poly_owl_it_always_returns_upright/) describes a weighted base and separate printed parts. That establishes wobbling creature prior art, but supplies no measured recovery angle or ballast specification. The potato would explore an original, squat, one-piece profile without inserted weights. It would need its own balance tests; the owl's reported behavior cannot be carried over.

For an ideal uniform extrusion, keeping the center of mass below the center of the circular contact arc gives a restoring tendency near upright. A lower semicircle with a short upper cap is a plausible starting shape. Decorative cuts, extrusion width, shells and infill change the printed mass distribution. A geometric estimate would therefore be preliminary evidence, not proof that the print returns upright. No claim of recovery from arbitrary orientations is intended.

No playful rocking design appears among the current stands, mounts, stakes, cable support or earlier proposals. Novelty is unverified. If the user dislikes the interaction, or an existing desk toy already supplies the same fun, skip it.

## Smallest practical design

One rigid, broad extrusion of a symmetric side profile: circular lower belly, short rounded upper cap, and shallow recessed eyes and mouth on the broad faces. Keep the decoration above the contact arc and balanced between the faces. The potato would rock in one plane; its extrusion width would resist falling onto a broad face.

The broad face would lie on the bed during printing, then the finished piece would stand on its curved belly. Start without limbs, antennas, cavities, flexures, joints, magnets, ballast or a separate base. A tall character may look funnier but raises its center of mass. Deep facial cuts or texture on the belly may spoil balance or smooth contact.

## Parametric OpenSCAD approach

If approved, build the belly and upper cap as a connected 2D profile, then linear-extrude it to the chosen width. Subtract shallow facial details from the broad faces. Expose millimeter parameters for belly radius, cap height and width, extrusion width, edge rounding, facial position and recess depth, plus contact-arc resolution. Derive profile joins from those named dimensions.

Reject nonpositive dimensions, disconnected joins, recesses that break through the body, and rounding that removes the intended contact arc. Estimate the ideal profile's mass distribution as an early screening check, then inspect the sliced shell and infill arrangement. Neither calculation nor an assertion would certify printed balance. Keep editable source, ignored regenerated exports and project print guidance under the repository conventions.

## Material, hardware and unknowns

PLA is a candidate for a cool indoor prototype; no purchased hardware is required. Choose and record one repeatable shell/infill recipe rather than treating every slicer profile as equivalent. Start with the broad face on the bed. The slicer must establish first-layer contact, facial-detail quality, curved-edge faceting and support needs. The face against the bed may need shallower or omitted decoration.

Before CAD, confirm that a one-plane wobble is the desired interaction. Record the comfortable nudge size, available desk footprint, actual desk surface and slope, preferred character size and expression, printer/nozzle/layer capability, filament, shell/infill recipe and expected temperature. Agree on a modest initial release angle and acceptable sideways drift. Width, friction, layer ridges and elephant foot all remain prototype variables.

## Acceptance checks and physical validation

1. The approved parameter cases export one closed, connected mesh. Invalid dimensions fail clearly, and facial cuts preserve the body and circular contact arc.
2. Inspect the toolpath, print one complete undecorated balance prototype, and record dimensions, mass and print settings. A thin arc coupon cannot establish the full body's balance.
3. Before printing, agree on an acceptable final resting tilt. On the actual level work surface, release the prototype ten times from each side at the agreed modest angle. Require all ten releases per side to return within that tilt without falling onto a broad face. Record sticking, sliding and travel distance. Reduce scope or revise the shape if it fails; do not label it self-righting beyond the tested conditions.
4. After the balance prototype works, repeat those checks with the final facial details and the same print recipe. Confirm that a gentle nudge produces visible rocking without needing a launch or approaching a desk edge.
5. Repeat fifty gentle nudges, inspect the contact arc for roughness, wear or desk marks, and recheck motion. Record the surface and temperature. This is a proposed trial, not a durability rating.
6. Let the user try a short play session. Continue only if the motion and expression are enjoyable enough to keep on the desk; no productivity measurement is needed.

No CAD, slicer, print, balance, recovery-angle, wear or enjoyment test has been performed. Physical behavior must be measured on the complete print, separately from mesh validity.

## Selection rationale

Thirty candidates across six ideation lenses were generated before critique. The rigid rocker family keeps the playful interaction visible and the first experiment small. It avoids moving-joint clearance and flexure-fatigue work, while preserving an honest, testable balance question. Bean, mood-blob and creature-rocker variants were combined into this one proposal.

Tactile pebbles and finger mazes are simpler but their feel is harder to judge before printing. Ball dishes, bowling sets and modular tracks add pieces or desk space. An [OpenSCAD oloid printing account](https://fabacademy.org/2020/labs/barcelona/students/antoine-jaunard/3D-scanning-printing-oloid-shape.html) records support and print failures, so unusual rolling geometry carries extra fabrication work. Weighted creatures add assembly; flexures and captured rings add material or clearance uncertainty. Those are alternatives if a simple rocker fails to earn its place.
