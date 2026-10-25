# Seed-tray rinse-drain stands

2026-10-25. Gardening proposal only. CAD implementation needs separate approval.

## Intended use and evidence

Two small freestanding supports would hold one empty reusable seed tray tilted above an existing catch basin after its final rinse. The open cells face downward at an angle so water can escape through their mouths. This could free a hand and reduce repeated repositioning when draining a tray that fits poorly in an existing dish rack. It serves empty-container handling, separate from the repository's seed chute, plug pusher, soil shield and leaf support.

[University of Minnesota Extension](https://extension.umn.edu/garden-and-home/yard-and-garden/gardening-in-minnesota/how-to-clean-and-disinfect-gardening-tools-and-containers) and [Iowa State Extension](https://yardandgarden.extension.iastate.edu/how-to/how-clean-and-disinfect-plant-containers) describe cleaning reusable containers with ordinary brushes or rags and washing. They support the cleaning task, not these supports, faster drying or FDM hygiene. The drainage mechanism is a first-principles hypothesis. Actual owner tray inventory, retained-water problem and cleaning frequency are unknown. Usefulness confidence is low. None of the 30 candidates in today's ideation cleared the independent critic's evidence floor; this brief records one conditional direction for discussion. No novelty or pathogen-removal claim is made.

First compare the current method, an existing dish rack and two smooth shaped blocks. Test the actual empty tray by hand to find whether any orientation drains its cell geometry better. If it already drains freely when inverted, or the rack fits, stop here. The print only earns a place if a recurring handling problem remains and two compact fitted supports improve it.

## Smallest practical design

Print two identical broad-footed blocks. Each has a loose, fixed-angle open cradle for a short section of the tray's lower outer rim, a rounded bearing floor and a drain opening to the basin. Space the blocks along that rim so they carry the empty tray without twisting it. Place both feet on one flat, stable surface inside a catch basin; the whole tray and its drip path must fit that basin. No spanning a sink, gripping a basin lip, snap fit, hinge, stacked trays or loaded growing tray.

The cradle must engage a robust rim section while clearing cell bodies and leaving the mouths open. It does not guarantee retention. Confirm that gravity seats the tray against the cradle's bearing surfaces without requiring rim flex or friction to prevent pivoting out. Evaluate tray pivoting separately from whole-assembly tipping. Wet feet may slide; lifting the tray may lift a block; the tray may flex, tip or pivot out. Those are rejection cases, not reasons to tighten the cradle around a fragile rim. Supports are for stationary draining after rinsing, not brushing against or carrying the tray. No faster evaporation, storage sanitation or plant-health benefit is established.

## Parametric OpenSCAD approach after approval

Use an original rounded base and sloped support profile, then subtract the open rim cradle, cell-body clearance and through-drain. Expose dimensions in millimeters: foot width/depth, support height, cradle angle, measured rim envelope/clearance, bearing length, wall/floor thickness, contact radius and drain width. Keep the pair identical; support spacing is set physically from measured robust rim locations.

Guard positive dimensions, intact base/support joins, adequate bearing and remaining walls, cell clearance and a continuous drain path. Check a meaningful measured range plus invalid geometry and near-limit cases. A same-source short cradle coupon should precede the complete pair. CAD can check geometry and envelopes; wet tipping, friction and tray flex require physical evidence.

## Materials, measurements and unknowns

PETG is a candidate for a cool-water prototype; PLA could serve a short indoor fit check. Neither choice establishes cleanability, chemical compatibility or durability. Use only after the tray's prescribed cleaning process and final rinse, away from cleaning solutions and heat. Do not change that process to accommodate the supports. No metal hardware or purchased fasteners are intended.

Measure the actual empty tray's rim cross-section, stiffness, mass, cell projections and mouth/drain-hole layout. Find supported contact locations, tray angle and total center-of-mass projection. Measure the basin's flat floor, available footprint, full tray envelope and drip path, wet-hand insertion/removal clearance, rinse conditions and printer resolution. A narrow or curved basin floor, weak rim, unsuitable cell shape or insufficient tipping margin may rule the concept out. All proposed dimensions remain unset until these measurements exist.

## Acceptance and physical validation

1. Before CAD approval, confirm a repeated problem. Compare current handling, the rack and smooth blocks using the same tray and rinse amount. Record retained water, repositioning, occupied space and whole-task time including setup and cleanup. Agree a useful improvement before printing; no improvement means no design.
2. After approval, export the coupon and full block as closed, connected, consistently wound meshes with finite, nondegenerate triangles and positive volume. Check cradle angle, rim/cell clearance, foot/bearing dimensions and the drain opening; reject deliberately wrong feature fixtures and invalid parameters. Inspect slicing, contact finish, supports and layer loading.
3. Fit the coupon without force. Test the full pair with the actual empty tray and plain cool water in the basin, first at its final placement and then through gentle wet-hand placement/removal. Check rocking, sliding, tipping, block lift, tray deformation and drainage obstruction. Reject any unstable combination; do not add a loaded plant tray to this trial.
4. Run ten matched rinse/drain cycles per method, alternating order and using equal drain intervals. Measure remaining water by weighing against a repeatable dry-tray reference. Record collected runoff separately; infer retention from it only if starting water is independently accounted for. Compare hands-on time, repositioning and cleanup burden. Claim only the measured result for that tray; without a rack comparison, no claim to beat a rack.
5. Complete twenty additional unloaded placement/removal/rinse cycles. Inspect feet, rim marks, cracks and trapped debris. Stop if cleaning the supports adds more work than they save. Long-term wear, chemical/heat exposure and outdoor use require separate evidence.

No CAD, slicer, print, fit, wet stability, drainage improvement, durability or usefulness evidence exists yet.
