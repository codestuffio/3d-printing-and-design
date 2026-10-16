# Wing-root lead keeper

Editable single-lead bench prototype from the [approved October 15 proposal](../../docs/proposals/2026-10-15-wing-root-lead-keeper.md). All interface dimensions are **UNMEASURED EXAMPLES**. The prototype is implemented; physical fit and usefulness remain unverified. Compare an existing aircraft holder, suitable temporary tape and a card mockup before printing.

![Keeper preview](preview.png)

The broad plate spans one wing-root opening while a disconnected plug stays outside. Its wire enters the upward-opening slot sideways, without threading the plug. The wider housing shoulder rests outside the slot. The plate bears gently on a firm, coplanar root land while the detached wing remains stationary on its own support. The integral side tab is engraved "REMOVE BEFORE ASSEMBLY".

This is an open slot, so a lead can escape if the keeper tilts. Nothing mechanically enforces the modeled tilt limit. Remove the keeper before moving/rotating the wing, mating connectors or fitting the wing to the aircraft. It carries neither the wing nor a hanging cable bundle. It is not for transport, vibration or flight retention. Do not squeeze insulation, contact terminals, pry a plug, modify the aircraft or attach it permanently.

## Files and exports

`wing-root-lead-keeper.scad` exports `part="keeper"` or `part="contact_coupon"`. The wrapper `contact-coupon.scad` selects the exact same coupon geometry. Both use named millimeter parameters at the top of the main source. No external CAD library is required. STLs go in the ignored `exports/` directory.

```sh
openscad --export-format asciistl -o projects/wing-root-lead-keeper/exports/keeper.stl projects/wing-root-lead-keeper/wing-root-lead-keeper.scad
openscad --export-format asciistl -o projects/wing-root-lead-keeper/exports/contact-coupon.stl projects/wing-root-lead-keeper/contact-coupon.scad
```

Pass the same measured `-D` overrides to the main source or wrapper. Example only, not an aircraft configuration:

```sh
openscad -D 'slot_width=3.4' -D 'wire_bundle_width=2.4' -D 'housing_minimum_width=5' -o /tmp/keeper-example.stl projects/wing-root-lead-keeper/wing-root-lead-keeper.scad
```

Default keeper bounds are X -24..48, Y -17..17, Z 0..3 mm. The body is 48 × 34 × 3 mm; the integral tab overlaps its right side and extends to X 48. The slot is 4.4 mm wide with root center at X 0, Y -1 and bottom at Y -3.2. It opens at Y +17 with a 1 mm flare per side. The rounded root leaves a 13.8 mm lower bridge. The slot/contact coupon is an exact crop of that profile, X -7.2..7.2, Y -8.2..17, Z 0..3 mm. It retains the complete slot/root/mouth, 5 mm side walls and 5 mm lower bridge, and omits the removal tab. The coupon does **not** validate full-plate retention at the aperture.

## Measure and set the interface

Record the actual aircraft/manual and recurring service task. Identify the selected lead, exit direction, slack, maximum wire-bundle width, strain relief and the minimum plug-housing shoulder width through every reachable rotation. Measure the opening's bounding rectangle and the entire firm contact-land footprint, nearby covering/foam/structure, hand access, removal path and supported wing orientation. The source assumes the opening rectangle and plate body are centered together. `slot_x` and `slot_seat_y` locate the circular slot root in this coordinate system; an offset opening needs a fresh model of the interface.

`wire_clearance` is total clearance, not per side. The example requires slot width at least wire width + 0.5 mm and leaves at least `shoulder_overlap` on each side of the narrow slot. Measure the housing's smallest projected shoulder through reachable rotations, rather than its convenient broad face. If no slot can clear the wires and block the shoulder, reject this interface. Slot dimensions do not establish insulation clearance or connector retention under load.

The complete rounded root, plus half the specified wire clearance on each side, must fit within the opening rectangle. This conservative guard covers a smaller wire settling below the root center or moving sideways inside an oversized root. It does not assume the wire remains centered in the slot.

The full plate body must fit on the measured firm, flat land. The side tab needs unobstructed clearance behind it; it must not press covering or foam. Recessed, flexible or irregular contact is outside this model. No screw, adhesive, pad or clip is included. Reject a fit that needs one to avoid damaging the root.

`maximum_tilt` is an **assumed**, unenforced angle from the root normal. The source compares `min(plate_width, plate_height) * cos(maximum_tilt)` against the opening rectangle's diagonal plus two contact margins. The default is 10° and gives about 33.48 mm versus 24 mm. This checks a conservative projected outline envelope within the stated angle. It does not prove that the open-slotted plate cannot be threaded, tilted edge-on, levered or otherwise moved through the opening. Inspect actual reachable motions using a card mockup, then the complete print. Reject plate entry or lead escape. Never infer unrestricted retention from plate width or a passing assertion.

The model rejects nonpositive dimensions, inadequate wire clearance or shoulder overlap, a missing lower bridge, side-wall breakout, a wire seat outside the opening, inadequate contact footprint, failed bounded projection, detached tab cores, an engraving that removes its floor and a coupon extending outside the body. It preserves at least `minimum_section`, an example geometric threshold rather than a strength rating. The fixed Liberation Sans Bold label reserves eight times `label_size` horizontally. `label_row_spacing` sets the row-center distance; guards separate rows and keep them inside the tab. Keep the removal text legible; small label sizes and font substitution need fresh export inspection and physical checks.

## CAD verification

The implementation packet records real OpenSCAD exports with strict closed, connected, consistently wound, finite, nondegenerate mesh checks. Bounds and occupied/empty probes cover the slot, lower bridge, tab and plate thickness. Coupon wrapper geometry must equal the selector export. These checks establish CAD geometry only.

To inspect a changed parameter set, export its STL again. Valid companion cases should include small/large wire bundles with corresponding housing/opening values, an offset seat, large rounding with sufficient tab overlap and the thinnest admitted plate/engraving. Invalid cases include `slot_width=3.8` for the default wire, `housing_minimum_width=5.5`, `slot_seat_y=-14.7`, `slot_x=20`, `maximum_tilt=85`, `handle_overlap=1`, `label_depth=2`, `coupon_side_wall=1`, the oversized low-root combination `slot_width=10; housing_minimum_width=12; slot_seat_y=-4.05`, and a short-tab combination `handle_length=20; edge_radius=1`. OpenSCAD may exit zero on CSG assertion failure; inspect diagnostics and require the intended assertion, rather than treating exit status alone as success. Changes need fresh mesh and spatial checks, not just parameter evaluation.

## Starting print settings and physical checks

PETG is a candidate for the keeper; PLA can be used for a cool indoor fit coupon. Start flat at Z 0 on the bed, label facing up, 0.20 mm layers, four walls and 30% infill. No supports are expected in this orientation, but inspect the slicer, slot edges, layer direction and label floor before printing. These are starting settings, not strength, heat or wear evidence. Remove burrs without narrowing the wire clearance or leaving sharp edges. A rough print can mark insulation or the aircraft.

1. Compare the existing holder, manufacturer-compatible tape and a paper/card mockup on the actual task. Skip a print if a simpler method works as well.
2. Print the coupon first. On a spare disconnected lead, check free sideways entry/removal, a clear rounded root, shoulder overlap through reachable plug rotations and no insulation pinch or terminal contact. Do not suspend a lead from the coupon.
3. Only then print the full keeper. On the independently supported, unpowered detached wing, keep the slot up, lead slack and contact visible. Confirm broad firm contact, tab clearance and a visible removal label. Check actual permitted stationary motions gently; never force the plate into the aperture or pull a wire to test it.
4. Reject any wedging, plate entry, lead retreat, unintended release, wire pinch, plug deformation, terminal contact or new marks on covering/foam/root. These absolute rejection gates apply across all trials, even when the baseline performs poorly.
5. Compare ten alternating matched service setups per method against the best acceptable holder/tape/card baseline. Record setup/removal time, retrieval attempts, unintended releases and marks. Agree on the useful improvement and measurement resolution first. Accept only if the chosen outcome improves, no other outcome worsens and every absolute gate passes. Zero retrieval problems with both methods can mean there is no benefit.
6. Repeat twenty gentle park/release cycles, inspecting slot edges, lower bridge, housing and insulation. Stop for damage or wear. Remove the keeper before connector mating/wing assembly, then follow the aircraft manual's connection and function checks.

No actual aircraft or connector has been measured, and there is no slicer, print, fit, wire-protection, strength, wear, transport, flight or usefulness evidence. The prior proposal's manufacturer references establish the handling task and existing alternatives; they do not validate this print.
