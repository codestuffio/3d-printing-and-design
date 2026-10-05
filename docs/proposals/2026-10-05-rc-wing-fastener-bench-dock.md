---
date: 2026-10-05
category: rc-airplane-accessories
topic: wing-fastener-bench-dock
---

# Proposal: RC wing-fastener bench dock

A small freestanding dock could give each removed wing bolt a visible parking position during assembly or bench maintenance. Its purpose is to keep one aircraft's hardware together and make an empty position easy to notice. This is a proposal only. OpenSCAD implementation requires separate approval.

## Intended use and evidence

Place the dock beside the airplane, park the removed wing fasteners in their labeled recesses, then retrieve them when reinstalling the wing. The initial design would hold one measured hardware set, with one position per actual fastener. Use numbered positions unless the aircraft actually has distinct left and right fasteners. Include washer pockets only if loose washers belong to that set.

The repository already has desktop, fixed-X and sliding-X RC stands. No wing-hardware organizer or earlier proposal for this dock was found in the current repository and daily records. This accessory could work on a bench without relying on the stands' pending physical validation.

Relevant manufacturer examples:

- The [E-flite Timber 1.5m 10-Year Anniversary manual](https://assets.horizonhobby.com/on/demandware.static/-/Sites-horizon-master/default/dw713e8689/Manuals/EFL-3352_EFL-3353_MANUAL_EN.pdf), pages 8 and 21, specifies two M6 × 30 mm nylon wing bolts. This establishes one real removable-fastener arrangement; it does not identify the user's airplane or its hardware.
- [DU-BRO nylon wing bolts](https://www.dubro.com/products/nylon-wing-bolts) come in different thread sizes and lengths, including 50.8 and 76.2 mm. A measured recess would accommodate the whole bolt without relying on magnets or a matching printed thread.
- [PowerHobby's RC tool holder with screw tray](https://www.powerhobby.com/products/powerhobbyy-rc-tool-tool-holder-w-scrwe-tray) already groups tools and loose hardware. Generic organization is established prior art. The proposed dock's narrower hypothesis is that one labeled position per fastener makes an incomplete set easier to see.

No user report of lost bolts or slow setup has been collected. Demand, novelty and benefit are unverified. If the user's wing fasteners are captive, or a plain tray already works just as well, skip this design.

## Smallest practical design

One shallow block with a horizontal recess per measured bolt, widened spaces for the heads, rounded finger scoops and visible position labels. Horizontal parking keeps the print low even when bolts are long. Each recess would have a closed floor and enough clearance to lift the bolt without scraping its threads. Any measured washer pocket would sit beside its matching bolt.

Keep the first prototype freestanding and gravity-held on a level bench. A cover, magnetic insert, snap retention, PVC attachment and transport rating would add work before the basic interaction is demonstrated. The dock would stay off the aircraft and would not replace wing-retention hardware. Checking the parked set would not establish that the wing is correctly assembled.

## Parametric OpenSCAD approach

If approved, create a rounded rectangular base and subtract elongated rounded pockets for each measured fastener. Widen each pocket at the head, subtract a finger scoop, then add shallow readable labels. An optional washer recess would be driven by the actual inventory.

Expose millimeter parameters for station count and spacing, bolt length and maximum shank diameter, head width and height, pocket clearance and depth, floor and divider thickness, edge radius, finger-scoop size, washer dimensions and label text. Do not model threads. Assert positive floor thickness, separated pockets and enough space for the head and fingers. Export a single-station fit coupon before the full dock; retain editable source and ignored exports under the repository's project conventions.

## Material, hardware and measurements

PLA is a candidate for a cool indoor fit prototype. Consider PETG if the actual use environment calls for it, then test at the recorded temperature. Start with a flat-base print and open pockets facing upward. Slicer inspection must establish whether the chosen scoops need support. No purchased hardware is required; the dock holds existing fasteners. Grip pads are a later option only if the bench test shows sliding.

Before CAD work, identify the airplane and confirm that its wing fasteners are removable. Measure their count, total length, maximum thread diameter, head envelope and any separate washers. Record which parts must stay associated, the preferred labels, available bench space, finger access, printer bed size, material and expected temperature. Nominal thread size alone does not supply the head or clearance dimensions.

## Acceptance and physical validation

1. The coupon accepts the actual bolt without force and allows easy lifting by its head.
2. The complete dock exports as one closed, connected mesh; pockets retain a positive floor and divider across the approved parameter range.
3. Every required fastener has a visible, unambiguous position. Remove one item and confirm that the empty position is easy to identify; verify optional washers separately.
4. The user can park and retrieve the full set for ten recorded cycles without tools, thread scraping, pocket confusion or a need to tip the dock.
5. On the actual level work surface, ordinary nearby tool handling does not move the dock or spill the parked set. The scoops must balance retrieval access with containment.
6. Compare the same teardown and reassembly routine against the current tray or storage habit. Continue only if the dock reduces searching or makes missing hardware easier to notice without adding awkward steps.

Print the coupon first, inspect fit and layer surfaces, then print one complete dock. Test with the actual hardware and record temperature, cycles and any sliding, spills or wear. An open bench dock provides no proven retention during transport. No CAD, slicer, print, fit, cycle or temperature test has been performed for this proposal.

## Selection rationale

Thirty candidates across six ideation lenses were generated before critique. An independent basis review favored a visible hardware-inventory layout, while finding that a plain tray currently has stronger support and fewer fit assumptions. The dock remains worth proposing because its extra benefit can be tested directly. It is small, requires no stand attachment, and can be rejected cheaply after a coupon and a comparison with the existing tray.

Another stand or cradle would overlap existing projects. Joiner rests compete with aircraft storage clips and bag pockets. Lead combs require unknown connector and cable measurements. A general tool tray has strong existing alternatives; gauges and fit coupons are useful validation aids but weak standalone additions. An aircraft-mounted holder introduces attachment and removal questions that this bench proposal avoids. A lid or stand clip could be considered later only if the simple dock demonstrates value.
