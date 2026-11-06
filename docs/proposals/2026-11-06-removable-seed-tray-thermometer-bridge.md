# Removable seed-tray thermometer bridge

November 6, 2026 · Gardening proposal for review

## The job

Check growing-media temperature at the same spot and depth in a seed tray while leaving both hands free as the reading settles. University of Georgia Extension recommends measuring media with a probe in the middle of the container or flat. Utah State University Extension describes checking soil temperature with a simple thermometer. A holder would address probe placement during that check. [UGA Extension](https://fieldreport.caes.uga.edu/publications/B1432/starting-plants-from-seed-for-the-home-gardener/) · [Utah State University Extension](https://extension.usu.edu/yardandgarden/research/starting-vegetable-seeds-indoors-materials)

Start with one actual tray and an independent thermometer whose instructions permit insertion in the media. Try holding it at a removable depth mark, or using a stable scrap crossbar and a clip on an approved grip surface. A print is worth considering only if checks recur and the simple method drifts, tips, or ties up a hand long enough to matter. The owner's equipment, check frequency and baseline difficulty are unknown.

## The smallest print

One short, rigid bar lifts onto two measured, stiff tray lands. Shallow feet locate the bar without pinching the tray. A clearance slot passes the shaft, and the probe's existing rigid shoulder rests on a flat seat. The slot and seat keep the shaft vertical enough for the chosen depth window while keeping the full sensing zone below the media surface and clear of the tray. Set the bar down first, lower the probe into a reserved media-filled cell, then lift the probe and bar off separately. This is a temporary spot check with the dome already off. Use a separate hand-read thermometer and remove the fixture after each check.

## What to measure

- Record the tray and thermometer models. Measure the bearing span, land width and stiffness, cell center offset, nearby plant clearance and free lift-out path.
- Measure the probe shaft and shoulder, the shoulder-to-tip length, device balance, required immersion and sensing-zone length. Confirm an allowed support surface and the manufacturer's settling and cleaning instructions.
- Measure media surface variation and bottom clearance in a representative filled cell. Set a target depth window from those limits. If normal fill variation and fit error leave no valid depth window, this fixed seat is unsuitable.

## OpenSCAD approach after approval

Use millimeters and top-level parameters for the bearing span, foot geometry and play, beam section, seat height, slot clearance and cell offset. Join rounded extruded profiles and subtract the through-slot. Use a cropped section of the same model to test the probe seat and a separate foot sample only if the tray fit needs it. PLA is a candidate for a cool bench fit sample. PETG is a candidate for the damp-use part, subject to the actual cleaning procedure. The compatible rigid-shoulder design needs no hardware.

Check closed, connected exports and positive dimensions across the measured configuration and reasonable variants. Reject a slot that cannot clear the shaft or retain the shoulder, inadequate bearing and web, and a seat projection outside the allowable depth window at the measured fill extremes.

## Physical checks before use

1. Inspect sliced layers around the seat and feet. Print the seat sample, then dry-fit the full bar and probe with the tray off the heater. Confirm the probe seats and lifts by hand, both feet bear, the tray stays level, and the loaded assembly stays put while the reading would settle. Reject drag, rocking, bending or tip contact with the tray.
2. In a representative media-filled spare cell, check actual placement and immersion at both fill extremes. Compare with the simplest workable method using the same thermometer and matched media, moisture and starting temperature. Alternate methods over ten paired placements using equivalent fresh spots. Record measured lateral and depth spread, retries, hands-on time and stabilized readings. Set acceptable lateral and depth tolerances and a reading-difference limit before testing, accounting for instrument resolution and reference repeatability.
3. The print earns its place if placements meet the lateral tolerance, stay inside the depth window and it reduces active holding time or depth spread while meeting the reading-difference limit, staying seated and taking no longer to clean. Track fitting, printing and cleanup effort separately. Screen wear and loosening over twenty extra placements and check cleaning on the actual material. A few early failures can stop the trial. The counts are short screening runs.

CAD, slicing, fit, strength, reading bias, wear and practical benefit remain unverified. Confirm a recurring check and a gap in the simpler method before CAD approval.
