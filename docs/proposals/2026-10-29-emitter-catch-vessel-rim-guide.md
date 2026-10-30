# Emitter catch-vessel rim guide

Date: 2026-10-29. Category: gardening. Proposal only; CAD implementation requires separate approval.

## Use and evidence

Temporarily park one flexible supply tube so its existing endline drip emitter stays above an existing collecting vessel during a timed output check. The proposed benefit is fewer missed drops or interrupted collections when a loose tube wanders. An actual owner system, recurring collection problem and useful advantage remain unconfirmed.

[UC ANR's emitter evaluation guidance](https://ucanr.edu/site/maintenance-microirrigation-systems/emitter-evaluations) describes collecting discharge in a graduated cylinder over a timed interval and explains that elevation changes affect operating pressure. [Agriculture Victoria](https://agriculture.vic.gov.au/farm-management/water/irrigation/drip-irrigation/drip-system-maintenance-and-monitoring) emphasizes collecting all of a dripper's output when measuring it. These sources establish the task, not a need for this accessory or the accuracy of a printed fixture. Their field procedures are not a household irrigation prescription.

First compare the current method, a wider collecting vessel followed by transfer, and an ordinary padded clip or clothespin with stable blocks supporting the vessel. Stop if these solve the problem comfortably. No novelty, universal compatibility, water-saving or plant-health benefit is claimed. This serves emitter inspection, distinct from the repository's plant propagation rim support, seed handling, tray draining, soil shield and owner-managed planter crossbar.

## Smallest practical design

One removable piece has a broad, loose inverted-U seat over one measured rigid vessel rim and a short inward arm ending in a rounded, open upward-facing tube saddle. The saddle supports a straight supply-tube segment upstream of the emitter. Its clearance must avoid squeezing, flattening or sharply bending that tube. The emitter body, adjustment and free outlet stay untouched and visible over the vessel opening. The print makes no fluid connection and carries no collected water.

Use one compatible endline emitter and a vessel supported on a stable surface. Preserve the outlet elevation and supply routing used by the unrestrained reference setup; adjust existing vessel support rather than pulling the line down to fit the guide. Keep a visible air gap above the highest collected-water level. Reject an interface that needs a tighter grip, longer lever, added clamp or new support structure to stay put. Exclude inline emitters, pressurized fittings, seals, funnels, permanent installation and printed volume graduations.

The loose rim seat and tube saddle may slip or rock. Tube spring force could tip even an empty vessel, alter the tube path or lift the guide. Those are reasons to reject the geometry, not assume friction will solve it. A cup or ordinary clip may be better.

## Parametric approach after approval

Build original rounded profiles in OpenSCAD, union the rim seat and arm, then subtract the open rim slot and tube cradle. Keep dimensions in millimeters at the top: rim thickness/profile allowance, seating depth and contact length, arm reach, tube outside diameter and radial clearance, saddle depth, wall thickness, edge radii and minimum connected section. Preserve open loading and removal paths. The rim seat locates loosely; it is not a snap fit.

Assert positive dimensions, intact rounded joins, minimum walls, usable rim bearing and an open tube mouth wider than the measured tube. Check measured small/large valid interfaces and invalid wall loss, interference, excessive reach or blocked openings. Verify actual slot/cradle dimensions and bounds as well as finite, closed, connected, consistently wound, nondegenerate positive-volume mesh exports. Export a short same-source rim-and-saddle coupon first. Mesh checks cannot establish tube freedom, vessel stability or measurement fidelity.

PETG is a candidate for a temporary plain-water handling prototype; PLA may suffice for a cool indoor fit coupon. No added hardware beyond the existing emitter, tube, stable vessel and its ordinary support. Choose orientation after inspecting rim/arm layer loads, supports and contact finish in the slicer. Clean and dry the accessible surfaces after use; material choice alone proves no durability or cleaning compatibility. Store the guide indoors.

## Measurements and acceptance

Before CAD approval, identify an actual repeated collection problem and compare the baselines. Measure the vessel rim cross-section, curvature, opening, empty mass, base footprint and working capacity; tube outside diameter, stiffness and allowed bend radius; emitter envelope, outlet position and adjustment access; available slack, original outlet elevation, air gap, supporting surface and nearby plant clearance. Record flow conditions, collection interval, vessel resolution, printer variation and a minimum useful improvement threshold. The complete filling range matters because vessel loading and water level change during collection.

After approval, inspect the slicer and coupon, then test one full guide with spare tubing and an empty vessel before connecting the intended system. Check placement, full removal, lateral motion, tube freedom, emitter clearance and stability at empty and maximum planned fill. Reject rocking, lift, slipping, tube marks or kinks, emitter contact, spill, immersion or tipping. Do not rely on the increasing water weight to stabilize an initially unstable vessel.

First check flow noninterference separately: run matched timed trials with and without the guide while a wide secondary vessel catches every miss from the normal vessel, then combine both collected amounts. Keep outlet elevation, tube routing, emitter adjustment and operating conditions fixed. Establish repeatability and measurement resolution in advance. If complete capture or comparable conditions cannot be established, leave flow noninterference unverified and do not accept the guide.

Then compare ten matched timed collections per method in alternating order on one stable setup. Keep the emitter adjustment, outlet elevation, routing, interval and operating conditions consistent. Record missed drops, interruptions, retries, collected amount and whole-task retrieve/place/collect/read/remove/clean time. Agree on acceptable collection variation before the comparison, using vessel resolution and repeated unrestrained reference readings; a changed amount in the normal vessel alone cannot distinguish improved capture from changed emitter flow or establish accuracy. Reject a repeatable flow change, incomplete capture, changed elevation or any contact failure even if handling is faster.

Continue only if the chosen handling improvement exceeds the agreed threshold without worse collection consistency or total effort. Separate fabrication and fitting effort from recurring time and retain the first-use total. Inspect fit, joins, tube and vessel after twenty further placement/removal cycles. There is no CAD, slicer, print, fit, flow, stability, wear or usefulness evidence yet.
