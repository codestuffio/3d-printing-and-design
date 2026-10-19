# RC wheel-collar setup shim

Date: 2026-10-19. Category: RC airplane accessories. Proposal only; separate user approval is required before CAD implementation.

## Use, evidence and simpler alternatives

Temporarily space one measured wheel face and its outer retaining collar during stationary assembly. An edge-open leaf would slide off the axle sideways after positioning, potentially reducing repeated binding adjustments. Actual aircraft, recurring difficulty, required clearance and benefit are unknown.

The manufacturer-hosted [Seagull PT-19 manual](https://www.spektrumrc.com/on/demandware.static/Sites-spektrum-us-Site/Sites-horizon-master/default/Manuals/SEA3150-Manual.pdf), printed page 9, calls for free wheel rotation and moving the outer collar outward slightly if binding occurs. It supplies no numeric running gap and does not recommend this tool. The proposal infers a possible handling aid from that example; it does not establish compatibility with the user's aircraft.

First compare the actual manual method, a measured paper/plastic strip and a metal feeler gauge. Skip printing if those work comfortably. Printed thickness may be less reliable than a conventional gauge. Existing repository RC designs concern aircraft support, wing-hardware storage, control-throw reading and disconnected wing-root leads; this proposal addresses wheel setup. No novelty claim is made.

## Smallest practical design and OpenSCAD approach

One original flat leaf with an edge-open U slot and broad integral removal tab, sized for one actual axle and contact envelope. It must leave completely by radial withdrawal. No adjuster, multi-size fan, retained washer, aircraft attachment or flight use. A thicker grip is optional only outside the measured contact and withdrawal envelope.

If approved, hull rounded 2D leaf/tab profiles, subtract an edge-open slot and extrude one qualified leaf thickness. Expose millimeter parameters for axle diameter, radial clearance, slot depth/width, contact width, leaf thickness, reach, tab dimensions and edge radius. Guard positive dimensions, intact side webs and joins, an uninterrupted lateral exit and the measured contact envelope. As-printed thickness governs use; nominal CAD dimensions do not establish gauge accuracy.

A cool indoor PLA sample is a candidate only after the required thickness is compared with printer and measurement capability. PETG is another candidate if stiffness, compression and finish suit the task. No added hardware. Existing axle, wheel and collar stay unchanged. If the required leaf cannot be printed and measured reliably, use a conventional gauge. Inspect slicer layers, first-layer expansion and surface finish before selecting orientation.

## Required measurements and unknowns

Identify an actual task, its assembly instructions and a justified clearance or independently verified acceptable reference setup. Measure axle diameter, wheel hub/boss and collar faces, contact annulus, radial access, withdrawal sweep, driver/set-screw access and remaining axle engagement. Record printer/nozzle/layer behavior, measurement resolution and uncertainty, and actual leaf thickness at multiple contact positions. A recessed or stepped hub may leave no suitable flat contact. Do not derive a universal gap from the example manual or select one just because a layer height prints conveniently.

## Acceptance and physical validation after approval

- Export a same-source contact sample and complete tool. Verify closed connected consistently wound positive-volume meshes, finite bounds, an open slot, intact webs and meaningful valid/invalid parameter cases. Inspect the slicer and measure the final tool at several contact points with suitable resolution. Reject inconsistent thickness, burrs, flex or compression that could change spacing.
- Begin on a spare axle/wheel/collar fixture with independent support. Use light positioning contact; never force or tightly clamp the leaf. Confirm complete withdrawal without collar movement, fragments, scraping or trapped material. A coupon cannot establish complete-tab access or withdrawal.
- After removal, complete the actual aircraft manufacturer's collar-retention and free-rotation checks. Axial play and remaining engagement must also be acceptable for that aircraft. The tool does not replace these checks or establish readiness for flight.
- Compare ten alternating matched mock setups per method, including retrieving, positioning, removing and storing the tool. Record time, adjustment retries and final outcome. Set a useful improvement threshold before testing. Require repeatable benefit without worse total task time, false clearance, blocked access, damage, inadequate retention or excessive play.
- Inspect after twenty gentle insertion/removal cycles for thickness change, cracks and debris. Include cleaning or adjustment in the task cost. Bench trials would not establish long-term wear or flight readiness.

Thirty candidates across wheel/axle setup, linkage assembly and removable-part handling were generated before independent critique. Three bases were sound, 23 weak and four refuted; sound mechanics did not establish owner demand. One shim family remains a low-confidence exploration, not a CAD recommendation. Linkage tools faced existing alternatives, and generic part organizers repeated prior proposals. No CAD, slicer, print, fit, compression, wear or usefulness evidence exists.
