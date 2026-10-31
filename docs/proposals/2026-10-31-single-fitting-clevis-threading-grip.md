# Single-fitting clevis threading grip

Date: 2026-10-31. Category: RC airplane accessories. Status: proposal only; CAD implementation requires separate approval.

A small hand grip could hold one measured nylon clevis while threading a loose pushrod into it at the bench. The practical problem is repeatedly losing purchase on the small clevis body. The smallest useful print is one original short handle with a profile that bears on the fitting's intended gripping flats and leaves its arms, pin and keeper clear. It is a temporary assembly tool used on spare, disconnected parts. It is distinct from the repository's servo-eyelet insertion puck, throw-ruler holder and loose-hardware cassette.

## Evidence and ordinary alternatives

The [Tower Hobbies Vista Grande manual, builder tip on page 12](https://www.towerhobbies.com/on/demandware.static/-/Sites-horizon-master/default/dwd44c21d0/Manuals/TOWA2045_Manual_EN.pdf) describes tedious clevis threading with fingers or pliers and a wrench slipping off the hexagonal base. It recommends the Great Planes GPMR8030 tool. [DU-BRO's E/Z Threader](https://www.dubro.com/products/e-z-threader) is an existing commercial tool for several linkage types, including nylon Kwik-Links. These sources establish a task and strong alternatives. Their marketing claims do not prove printed-tool performance.

No difficult clevis assembly, compatible fitting or inadequate tool has been observed for the owner. The owner's 1.2 m E-flite Timber X reference supplies no clevis dimensions or evidence that this tool is needed. Compare fingers, an appropriate wrench where the fitting maker permits it, and an existing manufacturer tool before CAD. If one works comfortably, stop. This print has no established novelty, savings, faster assembly or damage-prevention benefit.

## Smallest design worth exploring

Use one hand-sized body with a short open-sided profile engaging only the actual clevis's intended gripping region. Leave the pushrod entry and thread start visible. Provide clearance around the clevis arms, hinge, pin, keeper and adjustment end. The profile must release sideways without opening or bending the clevis. Confirm that the real fitting has suitable flats and a removal path before choosing this interface.

If the fitting has no suitable gripping region, needs a closed socket that traps the assembled linkage, requires contact on its arms, or needs extra leverage to force a reluctant thread, reject this version. Do not add a clamp, ratchet, interchangeable inserts or universal-size claims. The handle is for gentle hand use on a loose spare fitting, with no wrench-drive feature. It is not a clevis opener or a tool for levering against an installed control horn. It changes no flight part and is removed before installation.

## Parametric OpenSCAD approach after approval

Build an original rounded handle with a short measured contact profile subtracted from one edge. Use `hull()` for rounded outer profiles and `linear_extrude()` for the body. Expose millimeter parameters for contact-flat spacing, contact depth/length, entry clearance, arm/pin/keeper relief, side-release opening, handle width/length/thickness and corner radii. Keep the contact shape tied to the actual fitting, rather than copying a commercial tool's geometry. Guard positive dimensions, continuous walls, connected handle-to-head joins, thread visibility and a clear side-removal envelope.

Print a short same-source contact coupon first. Verify closed, connected, consistently wound finite meshes and actual contact/relief/removal features. Include meaningful valid/invalid parameter cases and a deliberately wrong relief or closed release path that must fail feature checks. Preserve generated exports as ignored evidence with source hashes. Geometry checks cannot prove grip, torque capacity or absence of damage.

PLA is a candidate for a cool indoor fit coupon; PETG is an alternative for the full bench trial. Neither is assumed soft, nonmarring or durable. No added hardware, lubricant or adhesive is proposed. Inspect slicer orientation, continuous walls and contact finish before printing. Any finish cleanup must preserve measured geometry. There is no support-free or material-strength claim.

## Required measurements and unknowns

Identify a recurring loose-clevis assembly task, the actual fitting and its permitted gripping region. Measure its flats, taper, body length, arm/pin/keeper envelopes, pushrod entry, assembled removal path and tolerances across spare examples. Record fitting and pushrod thread compatibility from their manufacturer, normal assembly resistance, printer dimensional error, contact texture and room conditions. Obtain the manufacturer's assembly and inspection procedure. Do not transfer another aircraft's thread engagement, turn count or linkage setting to this fitting.

## Acceptance and physical validation

Agree on a worthwhile whole-task improvement over the best ordinary method before CAD. After separate approval, use replaceable spare fittings off the aircraft. The coupon must seat with finger pressure, contact only the intended gripping region, preserve visible thread access and release without spreading arms or disturbing the pin/keeper. Reject any wedging, slip, binding, unusual resistance, whitening, mark, abrasion, debris, crack or permanent distortion. A larger handle must never justify forcing a thread. Compare pre/post fitting condition and gentle engagement with an untouched matching spare. Use separate specimens for these preliminary engagement checks; do not prethread fittings reserved for timed first-use trials. Follow the fitting manufacturer's inspection criteria; uncertain or damaged trial parts stay out of flight use.

Then test one full grip on the same spare-part task. Run ten matched whole-task trials per method with comparable fresh spare fittings and compatible pushrods, alternating method order. Include tool retrieval, seating, starting/threading, release, inspection and put-away. Record successful assemblies, slips, retries, damage and total time against the best available baseline. Use the fitting manufacturer's correct assembly endpoint for every trial; turn count alone is not acceptance. Record consumables and first-use/fabrication effort separately from recurring time. If the baseline already has no failures, reduced failure rate remains unestablished. This small sample cannot establish reliability.

Use spare parts for twenty further seating/removal cycles and inspect both print and fittings for wear. Reusing a thread during comparison may change its resistance; keep first-threading observations separate from repeat-use trials. Assembly and wear findings remain bench evidence. They do not establish neutral settings, thread engagement, control freedom or airworthiness.

There is no CAD, slicer, print, fit, grip, damage, wear or usefulness evidence yet. The next decision is whether a real awkward fitting and an inadequate ordinary-tool baseline justify separate implementation approval.
