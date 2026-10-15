# Wing-root lead keeper

Date: 2026-10-15. Category: RC airplane accessories. Proposal only; OpenSCAD implementation requires separate approval.

## Use and evidence

Keep disconnected servo or lighting plugs outside one measured wing-root opening while a detached wing remains stationary on its existing bench support. The practical target is avoiding repeated retrieval of a lead that slips back inside during service. Aircraft identity, recurring difficulty and benefit are unconfirmed.

The [Hangar 9 P-51D Mustang 60cc manual](https://www.horizonhobby.com/on/demandware.static/Sites-horizon-us-Site/Sites-horizon-master/default/Manuals/HAN4770-Manual.pdf), printed page 40, describes a wing-root holder that keeps extension leads from falling inside during transport. [Horizon Hobby's servo installation guide](https://www.horizonhobby.com/blog-arf-servo-installation/), step 11, uses temporary tape to keep a routed lead outside the wing. These establish the task and strong existing solutions. They do not establish a need on the user's aircraft or the performance of a print. Develop original geometry from measurements; no novelty or universal fit is claimed.

Compare the aircraft's existing holder and a manufacturer-compatible temporary tape method first. Skip this design if either works comfortably, if the opening has no firm permitted contact land, or if the wing has integrated connectors. Existing repository stands support the aircraft, the fastener dock parks hardware, and the ruler holder supports a measurement. This keeper would address disconnected lead access only.

## Smallest practical design

One broad, thin plate with an oversized visible handle and one upward-opening clearance slot for one measured lead. A wire enters sideways through the open slot without threading its connector. Its disconnected plug remains on the outside face; the plug's housing shoulder is wider than the slot and cannot follow the wire inward. The plate spans the opening and bears gently on a measured firm root land. Its outline must prevent it passing through the opening in every orientation reachable during the permitted stationary handling task.

Use only with the wing supported independently, slack leads, the slot facing up and the contact visible. The plate must release sideways without pulling wires, gripping insulation, touching terminals or prying the connector. It supports neither the wing nor a suspended cable bundle. The open slot can release the lead if the plate tilts. This first design therefore excludes carrying, rotating or transporting the wing, vibration and flight retention.

A large integral tab marked "REMOVE BEFORE ASSEMBLY" stays visible. Remove the keeper before mating connectors or fitting the wing, then follow the aircraft manual's connection and function checks. No spring gate, snap fit, foam clamp, adhesive mount, electrical connector modification, storage case or permanent aircraft installation belongs in the first prototype.

## Parametric OpenSCAD approach after approval

Extrude an original rounded 2D plate profile, then subtract one open slot with a rounded root and eased mouth. Expose plate width/height/thickness, measured slot position, wire-bundle clearance, slot depth/root radius, connector shoulder clearance, contact-land margins, handle size and label depth as named millimeter parameters. Retain a continuous solid bridge below the slot root. Avoid a thin flexure or friction grip.

Reject nonpositive dimensions, a slot that breaks the lower bridge, insufficient wall sections, a slot wide enough to admit the measured housing shoulder, or an outline that fails the measured opening/contact constraints. Slot width must clear the wire bundle yet block the smallest housing shoulder in every reachable plug orientation. That condition may be impossible for a particular lead; reject that interface rather than squeeze the insulation. Basic dimension assertions alone cannot prove orientation-dependent retention.

Export a small slot/contact coupon before the complete plate. After approval, valid and invalid parameter cases should cover small/large measured wire bundles, connector rotation, thin bridges and large rounding. Check closed connected meshes, a clear slot passage, minimum remaining sections, plate bounds and connector/opening envelopes separately. No CAD or exports are included in this proposal.

## Material, measurements and unknowns

PETG is a candidate for the prototype; PLA could serve a cool indoor fit coupon. Neither material's surface finish, stiffness, wear or temperature tolerance has been established here. No hardware is expected. Print orientation, layer edges and contact finish need slicer inspection and coupon trials. Skip the interface if an existing firm root land cannot tolerate the finished contact; do not add an untested soft pad or clamp to rescue it.

Before approval, identify the aircraft/manual, service task and baseline. Measure opening outline and depth, permitted firm contact lands, nearby covering/foam/structure, selected lead and exit direction, available slack, wire-bundle sections, each housing's minimum shoulder dimensions through its reachable rotations, strain reliefs, free hand access and removal path. Record bench support and wing orientation, expected handling motions, material/printer limits and operating temperature. Prove the oversized plate cannot enter the aperture during those motions; width alone is insufficient for an irregular opening or a plate that can turn edge-on.

## Acceptance and physical validation

First make a paper/card mockup against a spare connector and a representative opening. If a card already performs the task well, prefer it. If approved CAD passes the mesh and parameter checks, inspect the slicer and print the slot/contact coupon before a complete keeper.

On the actual supported, unpowered detached wing, confirm free sideways insertion/removal, slack leads, visible connector shoulders and stable broad contact. Reject any wedging, wire pinch, plug deformation, terminal contact, new covering/foam/root marks, lead retreat or plate entry into the opening. These absolute rejection criteria apply even if the baseline also performs poorly. Do not test by forcing leads or the plate into the wing.

Compare ten alternating matched service setups per method against the best acceptable existing holder/tape/card baseline. Keep wing orientation, lead set and task the same. Record setup/removal time, retrieval attempts, unintended releases and visible marks. Agree on a useful improvement and recording resolution before testing. Accept only if the chosen outcome improves without worsening the others and every absolute rejection criterion passes. If neither method has retrieval failures, a print may offer no useful benefit.

Repeat twenty gentle park/release cycles, inspecting slot edges, lower bridge, housing and insulation. Test only the agreed stationary bench motions. A successful CAD export proves neither fit, wire protection, durability, transport suitability nor airworthiness. No slicer, print, fit, strength or usefulness evidence exists yet.
