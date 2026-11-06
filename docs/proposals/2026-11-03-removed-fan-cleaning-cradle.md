# Proposal: removed-fan cleaning cradle

Date: 2026-11-03 · Category: 10 inch rack homelab maintenance · Proposal only; CAD requires separate approval.

A small bench cradle would hold one removed, electrically disconnected square fan by measured rigid frame edges during gentle dry brushing. It aims to leave a hand available to steady the rigid frame while the other brushes, without balancing the fan on its hub or trapping its lead beneath it. Blade steadying would follow the actual cleaning procedure; dry brushing does not inherently require it. The fan is lifted and turned by its frame to reach its other face.

## Practical case and evidence

This is worth considering for an owner who repeatedly removes small rack fans and finds frame-holding or improvised supports awkward. No owned fan, cleaning frequency, awkward task or advantage over ordinary tools has been confirmed. First compare holding the frame and two stable smooth blocks under suitable frame edges, with disposable paper beneath. Stop if either works comfortably or fan removal is unnecessary under its manufacturer's procedure. Do not remove a working fan or purchase a spare merely to create a use for this tool.

[DeskPi's DP-0045 panel](https://wiki.deskpi.com/rackmate/accessories/dp-0045-1u-venting-blank-panel/) supports up to four 40 × 40 × 10 mm fans, establishing a concrete mini-rack context rather than universal fit. [Noctua's cleaning guidance](https://www.noctua.at/en/support/faqs/how-should-i-clean-my-noctua-product) describes removal for cleaning, gentle contact and limits on fan cleaning. It does not endorse this fixture, and the actual fan's instructions govern. This proposal claims no improved cooling, bearing life, cleaning performance or novelty.

## Smallest useful print

One low open U-shaped base joins two short support rails. Shallow ledges bear on two measured rigid perimeter edges; low outside stops locate the frame without squeezing it. The center and one end remain open for hub, blade, strut and lead clearance. Finger gaps allow frame-only lifting and flipping. The base must stay stable with the fan resting on either face; a lead-exit notch follows the measured lead position.

Use only for gentle dry brushing of an already removed, disconnected fan on a cleared bench. The cradle is a rest, not a clamp or blade lock. It must leave permitted frame and blade contact accessible. Powered testing, compressed air, liquid cleaning and changes to the rack or fan are outside this first design. If no rigid contact area works in both orientations, reject this layout rather than support a blade, hub or delicate strut. No magnets, snap fit, moving parts, fan screws or purchased hardware.

## Parametric OpenSCAD approach after approval

Create original rounded 2D rail/base profiles and extrude them in millimeters. Subtract the center opening, finger gaps and lead exit. Keep frame width/length, locating clearance, ledge width and span, support height, stop height, base footprint, lead-notch dimensions and edge radii editable at the top. A same-source short rail coupon checks the proposed bearing ledge and stop before the whole cradle. Fit should be loose enough for gravity placement and lifting; no forced retention.

PLA is a candidate for a cool, dry bench coupon; PETG is an alternative for the full rest. Neither is assumed nonmarring, antistatic or compatible with cleaning chemicals. Print broad base down; inspect ledge overhangs, minimum walls, contact finish, bed flatness and layer directions in the slicer. No operating-temperature rack installation is intended.

## Measurements and decision gates

Before CAD, record actual fan model and allowed cleaning procedure; frame dimensions and rigidity; corner pads, ribs and protrusions on both faces; rotor/blade swept envelope and axial play; lead exit, connector and bend clearance; two usable bearing regions; finger/brush access; fan mass and center of gravity; bench surface and available footprint. Measure printer fit error and the smallest reliable ledge/wall. Nominal 40 mm frame size cannot establish those features. Agree a useful handling improvement before testing.

After approval, guard positive dimensions, joined rails/base, adequate remaining walls, nonintersecting contact and rotor envelopes, and lead/finger clearances. Export closed, connected, consistently wound meshes for default and meaningfully different measured frame variants. Reject invalid clearances, undersized openings and disconnected rails. Feature checks should detect an obstructed center, misplaced ledges and a blocked lead exit even when the mesh remains manifold. Geometry checks cannot establish fan contact, stability or cleaning usefulness.

## Physical acceptance

Slice and print the coupon first, then check it gently against a suitable already-removed, disconnected fan whose cleaning is permitted. A spare is useful if already available. Print the full cradle only if intended rigid contact is accessible. Test each face on the actual bench: ledges contact only the agreed rigid regions; rotor, hub, struts and lead remain clear; no forcing, rocking, sliding or tipping under ordinary gentle brushing; frame-only lift/flip stays easy. Reject any marks, debris, flex, blade contact or lead pinching. A loose rest is not drop protection.

Compare ten matched dry handling sequences per method, alternating method order: retrieve support, seat fan, reach both faces, steady the frame or blades as permitted, lift/flip, remove and put away. Record time, extra grasps, unwanted movement and lead interference. Use a clean suitable disconnected fan for these rehearsals; they measure handling only. An initial few trials may reject the idea before the full comparison. Record fabrication, fitting, storage and cleaning burden separately and retain first-use total. A handling benefit does not prove dust removal or reduced damage.

Only then try the actual manufacturer's permitted dry cleaning on suitable already-removed, disconnected fans. Compare similar fans with similar initial dust when available and record differences; without a fair comparison, make no cleaning-superiority claim. Inspect twenty additional placement/flip/removal cycles for ledge wear, cracks, deformation, fan marks and lead damage. The ten-sequence and twenty-cycle counts are short screening choices; they establish neither lifetime durability nor a statistically established speed advantage. Actual fit, slicing, printing, stability, wear, cleaning benefit and recurring usefulness remain unverified.
