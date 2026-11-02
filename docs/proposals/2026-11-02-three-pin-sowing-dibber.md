# Three-pin sowing dibber

2026-11-02. Gardening proposal only. CAD implementation needs separate approval.

## Intended use and evidence

Make three evenly spaced planting holes with one gentle press into prepared, level, loose soil. Each blunt pin has a broad shoulder intended to limit penetration. This could reduce repeated ruler placement and depth estimation while preparing a batch of individually sown seeds. The fixed pitch sets spacing within each group of three; a ruler or string still positions later groups and rows.

[RHS sowing guidance](https://www.rhs.org.uk/propagation/how-to-sow-seeds-outdoors) establishes the depth/spacing task and says to use the seed packet. It also names ordinary pencils, plant labels and chop sticks as dibbers. [Creamore Mill already makes a multi-pin dibber](https://www.creamore.co.uk/product/seed-tray-dibber/), so this is an adaptation of an established tool. Its possible value here is a compact, original print with pitch and nominal penetration chosen for one actual sowing job. No novelty, germination improvement or universal crop setting is claimed.

An actual owner crop, recurring sowing batch and advantage over ordinary tools are unknown. Compare a marked pencil plus ruler, a small wood block with three smooth dowels, and an available commercial multi-dibber before CAD approval. Stop if one is adequate. This tool prepares holes; seed dispensing and releasing established plugs are separate tasks already covered by repository designs.

## Smallest practical design

One rigid print carries three identical tapered blunt pins in a straight line. Broad circular shoulders sit immediately above the short working tips, joined on their upper sides by a low rounded spine that provides a grip. Open gaps between shoulders allow visual inspection and brushing away soil. A small raised depth/pitch label identifies the chosen settings. No moving adjustment, interchangeable pins, tray rim attachment, indexing mechanism, soil tamper or seed funnel.

Use it only where all three shoulders can meet the prepared surface without touching a container rim, tray divider, existing plant or the spine. The shoulder-to-tip distance is nominal tool penetration, not guaranteed seed burial depth. Uneven ground, tilt, sinking shoulders, compaction and hole collapse can change the result. Seed placement, covering and watering remain part of the packet's procedure. Do not press harder to force the shoulders level in firm, stony or root-filled soil.

## Parametric OpenSCAD approach after approval

Create original cylinders and blunt tapered tips, union their shoulders and a rounded spine, and keep dimensions in millimeters at the top. Expose three-pin center pitch, shoulder-to-tip length, tip diameter, taper, shoulder diameter/thickness, spine height/width/thickness, grip clearance and edge radii. Keep pin count fixed at three for the first version. Dimensions follow the selected sowing job and measured soil/container access, not a generic preset.

Guard positive dimensions, blunt tips, separated shoulders with usable cleaning gaps, intact pin/shoulder/spine joins and a spine that stays above the soil-contact plane. Export a same-source one-pin shoulder coupon before the full bar. Check nominal depth and center pitch in exported geometry, small/large meaningful valid settings, and invalid overlapping shoulders, lost joins, zero-depth tips and spine contact. Require closed, connected, consistently wound meshes with finite, nondegenerate triangles and positive volume. These checks do not prove soil performance.

PETG is a candidate for a temporary plain-water-and-soil prototype; PLA may suffice for an indoor coupon. No purchased hardware is intended. Inspect an orientation with the flat spine down and tips upward for shoulder overhangs, pin strength, supports and safe contact finish before printing. FDM material choice does not establish cleaning compatibility or durability. Brush and rinse only as compatible with the selected material, dry after use and store indoors. Follow any required garden-tool sanitation procedure; discard this approach if it cannot tolerate that procedure.

## Measurements and physical validation

Before approval, identify the crop and packet instructions, intended individual sowing spacing and depth, seed size, normal batch count, soil/media texture and moisture, usable row length, container/divider clearances if any, and printer variation. Confirm that a three-hole pattern suits the task. Choose useful depth/spacing tolerances and a minimum whole-task time improvement before comparing methods. A surface-sown seed or a sowing method requiring continuous drills is outside this concept.

After approval, inspect the slicer and print the one-pin coupon first. In sacrificial media at the intended moisture and preparation, check gentle entry, shoulder sinking, hole collapse, withdrawal and actual remaining hole depth. Measure from the undisturbed local soil surface, not a compressed shoulder dent. Reject sticking, excessive compaction, tearing, sharp edges, debris shedding or a pin/shoulder that bends. Do not transfer a successful coupon result to all three pins without testing the full bar.

Test the full bar in fresh level patches, checking all three holes after each press for depth and pitch. Include the transitions between groups and rows; fixed within-group spacing does not establish overall planting spacing. Check withdrawal without dragging, soil accumulation and cleaning access. Reject any combination that needs force or fails the agreed dimensional tolerances.

Compare ten matched batches per method in alternating order, with the same target hole count, media preparation/moisture, crop settings and measurement method. Use separate fresh patches for each batch. Record acceptable holes, depth/pitch errors, rework and the complete retrieve/mark/press/place-seeds/cover/clean/store time. Include ruler alignment between groups and rows. Report fabrication/fitting time separately and retain the first-use total against the actual sowing frequency. Accept only if the agreed time improvement is met without worse hole quality or more compaction. Hole measurements do not establish final burial depth or germination.

Inspect after twenty additional press/withdrawal/cleaning cycles for tip wear, cracks, lodged soil and dimensional drift. No CAD export, slicing, print, fit, strength, cleaning, wear or usefulness evidence exists yet. The next decision is whether this fits a real sowing job well enough to approve a measured prototype.
