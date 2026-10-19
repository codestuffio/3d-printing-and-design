# Rack screw-starting fork

Date: 2026-10-18. Category: 10 inch rack homelab. Proposal only; separate user approval is required before CAD implementation.

## Use, evidence and simpler alternatives

Hold one measured rack screw at a difficult mounting position while starting it with a screwdriver, then withdraw the tool sideways before tightening. Actual rack access trouble, hardware and task frequency are unconfirmed. The proposed benefit is fewer drops or retries without adding whole-task time. Equipment must already be independently supported; this tool carries no equipment load.

[StarTech's CABSCREWM6B datasheet](https://media.startech.com/cms/pdfs/cabscrewm6b_datasheet.pdf) describes one square-hole M6 kit for 10 inch and 19 inch racks, with steel fasteners and preinstalled washers. It establishes a real hardware example, not universal rack geometry or demand for this tool. Do not assume screws are nonmagnetic or washers are loose. [Eli Fulkerson's printed thread test kit](https://www.elifulkerson.com/articles/rack-bolt-size-kit.php) already addresses rack fastener identification; this proposal concerns access during a start, not another identification card.

First compare fingers and the normal driver, a magnetic bit where appropriate, an existing screw holder or tweezers, and a paper mockup of the withdrawal path. Skip printing if those are adequate. No novelty or universal compatibility is claimed, and no existing CAD would be copied.

## Smallest practical design and OpenSCAD approach

One short handle with a thin open U-shaped tip and shallow head/washer seat. It supports one actual fastener by its head/washer envelope, leaves the driver accessible and releases laterally. No captive undercut, torque transmission, thread contact or guiding, cage-nut clip manipulation, interchangeable tip, adjuster or rail mount.

If approved, hull original rounded 2D tip/handle profiles, extrude and subtract the edge-open slot and seat. Keep millimeter parameters at the top for shank/head/washer envelope, slot clearance, tip width/thickness, seat depth, edge radius, neck/handle length and minimum web. Guard positive dimensions, intact joins and an uninterrupted lateral exit. Those guards cannot establish thread engagement or withdrawal in a rack.

PLA is a candidate for an indoor tip-fit sample; PETG is a handled-prototype candidate after stiffness and finish checks. No added hardware; use the actual rack fastener. Inspect layer direction, tip toolpaths and support contact in the slicer before choosing orientation. Neither material has demonstrated wear or strength here.

## Required measurements and unknowns

Identify the actual screw thread, usable length, head and washer dimensions, including captive versus loose washers. Measure rack-ear/panel thickness and recess, rail/cage-nut position, driver access, reach, hand clearance and the entire lateral withdrawal sweep. Confirm an under-head gap large enough to release the tip while retaining manufacturer-appropriate thread engagement. If both conditions cannot coexist, reject the interface rather than shorten engagement. Record printer/nozzle/layers and actual contact finish. No dimensions follow merely from a rack being 10 inches wide.

## Acceptance and physical validation after approval

- Export a same-source tip coupon and complete tool. Verify finite closed connected positive-volume meshes, winding, bounds, intact webs, an open exit and meaningful valid/invalid parameters. A coupon cannot prove full-handle reach or withdrawal.
- Inspect the slicer and print the coupon. On spare hardware in a noncritical fixture, confirm supported head/washer contact without touching threads, pushing the panel, obscuring the driver or trapping the washer. Then test the complete handle with equipment independently supported.
- Verify adequate engagement and complete sideways release before clamping. Reject scratching, dropped/trapped washers, tip breakage, panel pressure, thread contact, torque transfer or a blocked withdrawal path. The screw must never be tightened onto the tool.
- Compare ten alternating matched starts per method on the actual fixture. Record whole retrieve/start/remove/store time, drops, retries, withdrawal failures and cross-threading. Preselect a useful improvement threshold. Require repeatable benefit without worse total task time, damage, inadequate engagement or cross-threading, even if a baseline also fails.
- Inspect tip/web/surface after twenty gentle cycles. Record any cleaning or adjustment burden. These trials would not establish long-term wear or a load rating.

Thirty candidates were generated before critique on October 18. The fork family was retained as a low-confidence exploration; no observed owner need justified CAD. Generic bins and identification cards overlapped existing solutions. Publication was delayed by the expired workflow lease. No CAD, slicer, print, fit, strength or usefulness evidence exists.
