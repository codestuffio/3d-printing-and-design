---
date: 2026-10-09
category: 10-inch-rack-homelab
topic: rack-adapter-locator-cradle
---

# Proposal: rack adapter locator cradle

A small open cradle could keep one USB or Ethernet adapter in a repeatable position on an existing metal shelf in a 10-inch rack. Short stops would locate the case, and a removable hook-and-loop strap would retain it while leaving plugs accessible. This is a proposal only; creating OpenSCAD files requires separate implementation approval.

## Intended use and evidence

The practical problem is a loose peripheral shifting when nearby equipment is serviced, leaving its connectors harder to reach or pulling against its leads. That is a plausible problem, not an observed report from this rack. Before CAD, identify one actual adapter that moves undesirably during a recurring task. Skip the design if the current shelf and strap already work well.

[racknex's NM-BAR-002](https://racknex.com/19-inch-barracuda-f18-f80-x50-x100-x200-rackmount-kit-nm-bar-002/) uses hook-and-loop straps to secure equipment and spacers positioned to leave existing ventilation openings unobstructed. This is adjacent prior art for locating contacts plus removable restraint. It is a steel 19-inch kit for specific devices; it establishes neither compatibility nor thermal performance for this proposed print. Develop original geometry from actual measurements, without copying the commercial kit.

The repository's rack service-loop saddle parks cable slack beside a rail. This cradle would locate a device case on a shelf. It also differs from the earlier RC fastener dock, card perch and seed chute. Demand, novelty, fit and service benefit remain unverified. The reference design is for a small low-voltage USB/Ethernet peripheral, with no power-supply enclosure or rack shelf replacement.

## Smallest practical design

One low open frame with short rounded corner stops, two shelf fastening tabs and an accessible strap path. The metal shelf supports the adapter through the frame's central opening; the printed stops limit lateral movement. The strap crosses a measured clear area of the case and releases by hand. Both connector ends remain open. Stops must avoid vents, seams, feet, LEDs and controls.

Fasten the frame through two existing measured shelf openings with matching bolts, washers and nuts. This requires accessible underside clearance. If the shelf lacks suitable openings, reconsider the interface before CAD rather than inventing a universal clip. The strap retains the device to the fixed frame; it must not rely on friction between a loose print and the shelf. No snap latch, drawer, multi-device array, cable loop or full-width rack panel belongs in the first prototype.

The tradeoff is extra footprint and hardware compared with a strap alone. Stops that fit too closely may scrape the case; poorly placed tabs may obstruct adjacent gear. The print earns its place only if repeatable positioning or service access improves enough to justify those costs.

## Parametric OpenSCAD approach

If approved, build an open rectangular frame from rounded extruded profiles, add short stops and mounting tabs, and subtract measured bolt and strap slots. Keep dimensions in millimeters as named top-level parameters: case length/width, side clearance, contact locations and heights, frame width/thickness, corner radius, fastening centers and hole diameter, strap width/thickness and slot clearance. Model the central opening and keep connector corridors open. Use measured contact positions rather than assuming all four corners are available.

Assertions would reject nonpositive dimensions, stops that erase insertion clearance, slots or rounding that break minimum walls, and mounting holes that break tab edges. They cannot certify restraint or ventilation. Export a small contact/strap-slot coupon and a mounting-hole coupon before the full frame. Keep editable sources, README guidance and ignored regenerated exports under projects/rack-adapter-locator-cradle/ if implementation is later approved.

## Material, hardware and measurements

PETG is a candidate for a first indoor fit prototype, subject to actual rack temperature and device instructions. Use one existing hook-and-loop strap plus shelf-compatible bolts, washers and nuts. Hardware size and count remain dependent on the measured interface; the initial two-tab arrangement needs confirmation. A flat frame on the bed is the intended orientation, with stops upward. Inspect the slicer for bridges, support needs, contact roughness and layer direction before printing.

Record adapter model, mass, case dimensions and corner radii; feet, vents, controls, LEDs and connector positions; plug/boot envelopes and cable bend/access needs; shelf opening pattern, thickness, edge distances and underside clearance; adjacent-device extraction paths; available footprint and height; strap dimensions and release access; printer/nozzle/material and operating temperature. Check device mounting and ventilation guidance. The frame must not force a plug, squeeze the case or change the device's intended operating orientation.

## Acceptance checks and physical validation

1. Confirm a recurring service task and record the shelf-plus-strap baseline. Measure device displacement, connector access and removal/replacement time under the same ordinary handling.
2. Coupons fit the actual case, strap and shelf hardware without force, scraping, blocked slots or fasteners protruding into nearby equipment.
3. The full frame exports as one closed connected mesh. Approved parameter cases preserve contact clearance and minimum walls; invalid geometry fails clearly.
4. The installed frame stays fixed, the device rests on the metal shelf, and all required vents, indicators, controls, plugs and neighboring equipment remain accessible. Verify with the actual cables and hardware.
5. Run twenty recorded removal/reinstallation cycles. Track placement errors, displacement during the chosen task, handling time, strap release and case marks. Continue only if the cradle reduces unwanted movement or improves positioning/access relative to a strap alone without making service slower or disturbing neighboring leads.
6. During a normal operating period, inspect print deformation, loosened fasteners, strap wear and device contact marks. Record material, settings, rack conditions and the device's available temperature indications; stop if the arrangement impairs its operation. This trial establishes no thermal rating or long-term creep guarantee.

Print coupons first, then one frame if the interfaces fit. Slicer inspection, installed fit, restraint, wear, temperature and practical usefulness all need separate evidence. No CAD, mesh, slicer or physical test has been performed for this proposal.

## Selection rationale

Thirty candidates across six ideation lenses were generated before critique. A fresh basis review favored a measured cradle because stops and a reusable strap provide a concrete restraint hypothesis, with a cheap baseline that can reject unnecessary printing. Open-chock and zero-snap variants were folded into this family.

A clearance probe needs a repeated obstruction problem and an advantage over cardboard. Port maps compete with labels or paper, and moving legends add clearance requirements. Multi-device trays expand scope before one adapter demonstrates value. Fit coupons remain validation aids, not separate daily products. Selection supports a measured trial, not a novelty or demand claim.
