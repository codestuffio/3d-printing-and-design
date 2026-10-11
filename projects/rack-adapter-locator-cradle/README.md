# Rack adapter locator cradle

An open frame locates one small USB or Ethernet adapter on an existing metal shelf. Low stops limit lateral movement; two raised slots accept removable hook-and-loop restraint. Two bolts secure the frame through shelf openings. The adapter rests on the metal shelf inside the opening, not on a printed floor.

**All default dimensions are unmeasured examples.** The 75 × 28 × 18 mm case, 54 mm shelf-hole spacing and 14 mm strap are placeholders. Measure your actual hardware before printing. This is not a universal 10-inch rack mount, a replacement shelf or a power-supply enclosure.

## Files and dimensions

- `rack-adapter-locator-cradle.scad`: complete frame; parameters are at the top, in millimeters.
- `contact-coupon.scad`: one exact side-contact profile and raised strap slot on a short rail.
- `mounting-coupon.scad`: both exact mounting tabs and holes, joined by a narrow bridge to check spacing.
- `preview.png`: rendered example geometry; it is not a fit photograph.
- `exports/`: ignored generated STL files.

The example frame has a 76.2 × 29.2 mm rectangular opening with 0.6 mm clearance on each side. Its outer frame is 88.2 × 41.2 mm; mounting tabs extend the footprint to 72 mm across Y. The highest stops are 10 mm above the shelf. Connector ends have central gaps between short stops, but the base rail is still 3 mm high: connectors, boots and cables must clear that rail and the stops.

`side_contacts` gives two X positions on both long sides. `end_contacts` gives two Y positions on both short ends. Move these contacts to case surfaces that can tolerate contact, away from vents, buttons, seams, feet and plugs. This version uses symmetric opposite sides; it does not support arbitrary asymmetric devices. `strap_x` selects a clear crossing along the case. Measure case feet and irregular outlines separately; a rectangular reference does not represent them.

`mount_x` and `mount_spacing` place the two shelf holes at `[mount_x, ±mount_spacing/2]`. Edit tab dimensions for actual shelf openings and hardware. Assertions require overlap with the frame and washer clearance outside the frame; they do not establish a useful attachment to your shelf. Suitable holes and underside access are required. Do not drill a shelf based on these example dimensions.

## Export and preview

From the repository root, with OpenSCAD on PATH:

```sh
openscad -o projects/rack-adapter-locator-cradle/exports/cradle.stl projects/rack-adapter-locator-cradle/rack-adapter-locator-cradle.scad
openscad -o projects/rack-adapter-locator-cradle/exports/contact-coupon.stl projects/rack-adapter-locator-cradle/contact-coupon.scad
openscad -o projects/rack-adapter-locator-cradle/exports/mounting-coupon.stl projects/rack-adapter-locator-cradle/mounting-coupon.scad
```

On this Mac, the installed CLI is `/Applications/OpenSCAD-2021.01.app/Contents/MacOS/OpenSCAD`. Substitute that quoted path for `openscad` when it is not on PATH. Use `-D` overrides or save measured parameters in the source. Both coupons include the same source and assertions, so their interfaces follow the full frame.

`part` selects `cradle`, `contact_coupon` or `mounting_coupon`. Enable `show_reference` in OpenSCAD preview to see a transparent rectangular example case at shelf level. Background reference geometry is excluded from rendered STL exports. The reference is not the adapter's real vent, foot or connector envelope.

## Print and install

PETG is a candidate for the first indoor prototype, subject to measured rack temperature and device guidance. Start with 0.2 mm layers, four walls and 35% infill. Print flat with slots and stops upward. These are starting settings, not strength or heat ratings. Inspect the horizontal strap-slot roofs in the slicer: the example bridge spans 15.2 mm along X. Confirm bridge quality or plan removable support that leaves the slots clear. Rounded contacts must be smooth enough not to mark the case.

Use two matching shelf-compatible bolts, washers and nuts. The example 3.6 mm hole and 9 mm washer allowance do not specify the correct thread or bolt length. Check nut access, bolt protrusion and neighboring equipment before tightening. No press fit, adhesive, printed spring latch or rack rail clamp is used.

The slots run horizontally through the side lugs, above the shelf. The inner lug faces leave at least `strap_thickness + strap_clearance` beside the example case for each returning strap leg (2.6 mm with the defaults). Assertions reject straps that leave too little lug material; a thick strap may require a wider frame. Keep their outside exits accessible after bolting the frame down. Use a sufficiently long two-sided hook-and-loop strip: pass it through each raised anchor and fold it back around that anchor's upper bridge. Join the free sections over the case, leaving both crossings above the case rather than underneath it. Both anchor loops must close securely; a straight loose strip through the two slots is not restraint. Check this routing with the coupon and actual strap before the full print. If your strap cannot make and retain those loops, use compatible restraint rather than forcing it into the slots. Keep the strip only snug enough to locate the case, without squeezing it, blocking vents or pressing buttons. Release the strip by hand to lift the adapter out.

## Fit and acceptance sequence

1. Identify one adapter that moves undesirably during a real recurring service task. Record the shelf-plus-strap baseline: displacement, connector access and removal/replacement time. Keep the simpler arrangement if it already works well.
2. Measure case dimensions, mass, feet and contact surfaces; vent/control/LED locations; plug, boot and cable bend envelopes; shelf hole spacing, thickness and underside clearance; strap dimensions and fastening overlap; available space, extraction paths, printer/material and operating temperature. Follow the device's placement and ventilation instructions.
3. Print the contact coupon. Check case contact, clearance, surface finish, actual strap passage and fastening loops. It does not test the opposite contacts or complete-case fit.
4. Print the mounting coupon. Verify both holes, washers and nuts against the shelf without forcing them. The coupon verifies the proposed interface, not full-frame restraint.
5. Inspect the full-frame toolpath, then print one frame. Confirm that the case sits directly on the metal shelf, all required vents and connectors clear the contacts/base/strap, and neighboring equipment remains removable. Tighten the measured hardware and check that the frame stays fixed.
6. Run twenty recorded removal/reinstallation cycles using the same service task as the baseline. Record displacement, placement errors, time, case marks, strap release and disturbed leads. Continue only if positioning or access improves over a strap alone without making service slower.
7. During a normal operating period, inspect deformation, fastener loosening and strap wear; record material, settings, rack conditions and available device temperature indications. Stop if placement impairs operation. A short check establishes no thermal rating or long-term creep life.

CAD validation checks mesh topology and valid/invalid parameters; it cannot prove the strap routing, shelf compatibility, physical restraint, airflow, operating temperature, wear or usefulness. Those require the actual hardware, slicer and printed trials. The merged [October 9 proposal](../../docs/proposals/2026-10-09-rack-adapter-locator-cradle.md) records the rationale and strap-only comparison.
