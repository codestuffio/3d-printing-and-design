# Lift-off hinge-taping rests

Date: 2026-10-23. Category: RC airplane accessories. Proposal only; CAD requires separate user approval.

## Use and evidence

Two short removable rests could support one measured foam wing and its aileron during the model's prescribed tape-hinge assembly. The practical goal is fewer alignment retries while laying tape. Each rest would have broad bearing lands at the elevations needed by that particular setup, with the working seam exposed. It would support the parts without entering the hinge gap or remaining on the aircraft.

A [2012 builder article hosted by Flite Test](https://www.flitetest.com/articles/How_to_Attach_the_Aileron_to_the_RC_Plane_Wing) describes maintaining even spacing during a folded tape-hinge procedure. This establishes a real assembly operation, not a manufacturer specification or evidence that this owner struggles with it. The article's dimensions and angles must not become universal defaults. Use the selected aircraft's actual instructions. No owner model, repeated task, alignment problem or useful time saving has been confirmed. Utility confidence is low, about 25%; geometry appears simple, but stable contact and tape access are unresolved.

First perform the actual task using its prescribed tape tabs or freehand positioning, then compatible card or wood bench blocks. Those methods may eliminate the print. The candidate only merits further work if repeated alignment drift remains and retrieving, positioning and removing two fitted rests improves the whole task. It is separate from the repository's aircraft stands, control-throw ruler holder, wing-root lead keeper and fastener dock. It does not measure control throw or set a universal hinge clearance.

## Smallest useful shape

A pair of identical loose fixed-profile blocks for one bench setup, each with a flat base, broad rounded bearing lands for the two parts and an open relief beneath the working seam. The lands would support accessible robust surfaces at measured elevations. Their placement must leave room for the full tape width, fingertips and smoothing motion. Keep tape and adhesive off the rests. No clip, clamp, adjustable joint, full-span fixture or part fitted between hinge edges.

The builder establishes alignment and spacing according to the aircraft instructions. The rests only support that position. Loose blocks may slide or allow the foam to rotate when tape is pulled; reject the arrangement if it cannot stay steady under normal application forces. Reject it if the actual wing lacks suitable contact surfaces, its contour needs a cradle, or the rest changes the prescribed fold, gap or hinge construction. The smallest version targets a compatible flat-contact foam assembly; it is not a general airfoil fixture.

Lift the rests completely away whenever the prescribed assembly changes fold or exposes the opposite side. Confirm an unobstructed withdrawal path before applying any tape. If the instruction sequence would trap a rest, tape over it, or require pulling on a partly bonded hinge to remove it, reject the geometry. Nothing from the tool remains on the finished model. Bench stability does not establish hinge strength, control freedom or flight readiness.

## Parametric OpenSCAD approach after approval

Extrude a rounded base and union two broad support lands, with a central open relief for the seam and tape-access envelope. Expose named millimeter parameters for base length/width/thickness, land widths/lengths/elevations, measured separation, seam relief, contact edge radius and placement margin. Derive the profile from the selected assembly; do not assume a default hinge angle or gap. If mirrored or unequal rests become necessary, reassess the scope before adding mechanisms.

Guard positive dimensions, intact joined lands, minimum supporting floor, rounding that preserves contact area, and clear tape and withdrawal envelopes. Check meaningful low/high elevations and separations, and reject erased lands, intersecting tape envelopes and nonpositive dimensions. Export a same-source short contact sample before the full pair. Validate strict closed, connected, consistently wound, finite, nondegenerate positive-volume meshes, bounds and actual land heights. Digital checks cannot establish foam compression, friction or printed accuracy.

## Material and measurements

PLA is a candidate for a cool indoor fit sample and bench prototype. PETG is an alternative only after contact finish and stiffness checks. No hardware or adhesive attachment is proposed. Choose orientation, walls, infill and supports after inspecting the measured contact geometry and slicer toolpaths; bearing surfaces must be smooth and free of support scars. Soft pads would alter elevation and compression, so they are outside this first scope.

Record aircraft/model, foam construction, exact hinge/tape instructions, permitted fold and spacing, tape width and adhesive keep-out, suitable bearing areas and their elevations, contour, available rest locations, bench flatness, complete hand/smoothing/withdrawal sweep and normal tape application forces. Establish whether the task occurs often enough to justify a tool. Record printer bed/nozzle/layer/material limits and measurement resolution. No nominal wing thickness, force rating, allowable indentation or printed dimensional precision is assumed.

## Acceptance and physical validation after approval

Before CAD approval, compare the prescribed method and simple blocks using scrap matching the actual wing and tape. Set a worthwhile improvement threshold and an alignment tolerance justified by the model instructions or a qualified reference assembly. If neither is available, do not invent a tolerance. Confirm the proposed support locations and removal sequence with a nonfunctional mockup.

After approval, check parameter cases and actual support/access geometry, inspect slicing, then print the contact sample. Measure land elevations and flatness; gently check matching scrap for rocking, indentation, abrasion and tape interference. Print the full pair only if the sample passes. Test normal tape laying on scrap assemblies first. Stop on sliding, twisting, dents, adhesive contamination, trapped tooling or a change to the intended hinge geometry. Count both rests out before changing fold and at task completion.

Compare ten matched scrap assemblies per method, alternating order and using equivalent fresh foam/tape. Include retrieval, setup, tape application, rest removal and cleanup. Record total time, alignment retries, measured drift, tape waste and visible defects. Require the agreed improvement without worse total effort or hinge outcome. Inspect after twenty additional placement/removal cycles for wear, bowing, rough edges and debris. Those cycles establish only the observed bench behavior.

Only after scrap trials pass should the builder consider a model assembly, following its complete hinge, travel, retention and preflight checks independently. The tool is not a repair approval or flightworthiness assessment. No CAD, slicer, print, fit, contact, alignment, hinge-strength, wear, usefulness or flight evidence exists yet.
