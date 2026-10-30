# Servo-eyelet insertion puck

Date: 2026-10-27. Category: RC airplane bench tools. Proposal only; separate approval is required before CAD implementation.

## Use and evidence

Insert one supplied brass eyelet into one rubber mounting grommet on a loose, unpowered servo. The proposed benefit is easier small-part alignment with fewer dropped eyelets. The owner has not reported this problem or confirmed compatible servos, so usefulness confidence is low. No novelty, universal fit or flight-performance claim is made.

[DU-BRO's servo mounting guide](https://www.dubro.com/blogs/du-bro-101/du-bro-101-servo-mounting-for-rc-airplanes-cars-boats-or-helicopters) places the brass flange below the rubber isolator. [Randal Sordelet's 2011 Park Pilot account](https://www.theparkpilot.org/parksolutions_eyelettool) describes escaping eyelets and a stepped metal insertion tool, but explicitly says a fitting screwdriver works. These support the assembly operation and a strong baseline, not demand for this puck. Follow the actual servo manufacturer's instructions; do not transfer lubricant advice from that historical article.

This differs from the existing wing-fastener dock, lead keeper, ruler holder and hinge rests: it temporarily supports one eyelet during installation, then leaves the assembly completely.

## Smallest useful design

One broad, flat-bottom printed puck with a raised annular bearing land, a shallow open eyelet-flange seat and one smooth metal locator pin. The flange rests on the land; the pin locates the bore without carrying insertion force. Bring the already-grommeted mounting ear down over the eyelet by hand, then withdraw vertically. The narrow raised land must leave the case, ear and grommet clear throughout the stroke. No servo-body clamp, hammer, lever, press, multi-eyelet magazine or aircraft-mounted part.

The locator must withdraw freely and cannot bottom against the case or become an insertion-depth stop. Pin retention, projection and access are unresolved design questions. Start with a locating-seat coupon and sacrificial matching hardware; abandon this geometry if a complete seating and withdrawal path cannot be demonstrated without twisting or tool contact against the servo body. The printed contact must support the metal flange while leaving rubber and the mounting ear clear at full seating.

## Possible OpenSCAD approach after approval

Create an original rounded puck and narrow raised boss using cylinders and rounded profiles. Subtract the shallow flange pocket and a measured pin socket. Keep all dimensions in millimeters at the top: base diameter/height, boss diameter/height, flange diameter/depth/clearance, pin socket diameter/depth/clearance and edge radius. Record the actual pin projection separately. Guard remaining floor/walls, continuous annular flange support, a socket beneath the seat that preserves the bearing land, and case/ear clearance. A same-source seat/socket coupon precedes the complete puck. No source or exports are included in this proposal.

PLA is an indoor fit-prototype candidate; PETG is an alternative subject to contact and stiffness trials. Use one measured smooth, blunt metal pin with a deliberate removable retention method established during design. No sharp cut wire, printed fine pin, adhesive on servo hardware or replacement eyelets/grommets. Print orientation, layer height, walls and fit allowance require slicer and coupon evidence.

## Measurements and decision before CAD

Confirm a repeated awkward insertion task and compare the current method, a fitting screwdriver used by hand over a shallow tray, and a simple drilled wood support. Count dropped eyelets and retries and record complete preparation/insertion/cleanup time. Agree a minimum useful improvement before any trial. Stop if a baseline already works comfortably or the actual servo has no such mounting hardware.

Measure the actual servo model and prescribed assembly order; ear and case envelope on every side; supplied grommet shape, flange thickness and seated position; eyelet bore, barrel and flange dimensions; access during the whole stroke; pin diameter, finish and projection; hand clearance; bench friction; printer resolution and actual dimensional error. No measurements exist yet. Do not infer fit from a nominal servo size.

## Acceptance and physical validation after separate approval

1. Export the coupon and full puck as closed, connected, consistently wound, nondegenerate positive-volume meshes. Check seat/socket/bearing geometry and meaningful valid/invalid dimensions, including deliberately inadequate flange support and a broken socket floor. Mesh checks cannot establish the metal-pin interface or servo clearance.
2. Inspect slicing and print the coupon first. On sacrificial matching parts, prove safe pin projection throughout the stroke, free pin withdrawal, complete flange seating, case/ear/rubber clearance and stable support under gentle hand insertion without binding or forcing a mismatched fit. Reject pin migration, binding, rocking, grommet tears, flange distortion, case marks, debris or incomplete seating. Use manufacturer seating criteria; no numerical force limit is invented here.
3. Compare ten fresh matched eyelet/grommet installations per method with balanced order and equivalent hardware. Reused softened grommets confound comparison. Record dropped parts, retries, whole-task time and visible damage. Inspect seating independently of speed. Include one-time fabrication/setup separately and retain first-use total cost.
4. Perform twenty additional tool loading/withdrawal cycles with appropriate spare hardware, checking the socket, pin retention, printed seat and contact marks. Reject any damage or no useful improvement. Do not claim superiority to an untested commercial tool.

No CAD, slicing, print, fit, insertion force, wear or utility results exist. Servo mounting verification and flight readiness remain the builder's separate work.
