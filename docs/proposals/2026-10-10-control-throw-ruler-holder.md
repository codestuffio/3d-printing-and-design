# Control-throw ruler holder

Date: 2026-10-10
Category: RC airplane accessories
Scope: Proposal only. New CAD needs explicit implementation approval.

## Intended use and evidence

Hold one measured metal ruler beside a control surface while the user operates the transmitter and reads travel from neutral. A moving hand-held ruler can change the reference and require an awkward extra hand.

The [Hangar 9 F-22 manual](https://www.spektrumrc.com/on/demandware.static/Sites-spektrum-us-Site/Sites-horizon-master/default/Manuals/F-22RaptorARFGreyManual.pdf), printed page 48, describes establishing neutral, measuring displacement and supporting the ruler on a solid surface to avoid movement error. This grounds the task, not this aircraft's settings or a proven need for a print. The user's repeated measurement difficulty, ruler and aircraft station remain unknown. Existing clamp-on throw gauges establish prior art; no novelty or calibration claim is made.

Compare a ruler supported by a wood block or existing clamp first. Proceed only if the print improves stability, clearance or repeat placement for the actual setup. Existing aircraft stands and the wing-fastener dock address different tasks.

## Smallest practical design

A broad bench foot with a vertical socket that holds the ruler perpendicular to the bench. A short split socket and captive thumb screw retain the ruler at the measured height. One separate lightweight cursor slides on the ruler to mark the neutral reading and locks with a small screw. The metal ruler provides the scale; the print carries no measurement graduations.

Use only the foot and cursor for one ruler and one horizontal control surface. The aircraft must already be stably supported at its manual's measurement station. This tool does not support the aircraft. Avoid a tall adjustable mast, aircraft-mounted clamp, electronics, angle conversion or automatic endpoint judgment. If a fixed-height socket cannot cover neutral and both travel endpoints with adequate ruler engagement, reconsider the concept before CAD.

## Parametric OpenSCAD approach if approved

Use rounded rectangular solids for the foot and socket; subtract the measured ruler section, split and screw/nut pockets. Model the cursor as an open window around the ruler with a narrow reference edge. Keep scale markings visible and keep the cursor clear of the moving surface.

Expose ruler width/thickness, fit clearance, engagement depth, socket angle, base width/depth/thickness, cursor clearance/reference offset, screw and nut dimensions, wall thickness and edge radius as named millimeter parameters. Guard positive walls, nut capture, socket engagement and exposed scale length. Export a small socket/cursor fit coupon before the complete foot. Default dimensions would be examples until measured.

## Likely material and hardware

PLA is a candidate for a cool indoor fit trial; PETG is an alternative to test for repeated handling. Material and orientation must be chosen after evaluating socket stiffness, screw loading and creep. Likely hardware is two measured M3 thumb screws with captive nuts, plus non-slip pads. Screw tips must not dent the ruler or obscure graduations; a measured pressure pad may be needed. No aircraft hardware is replaced.

## Measurements and unknowns

- Actual ruler width, thickness, length, scale direction, zero position and graduation interval; flatness and usable clamping area.
- Aircraft/model manual, prescribed measurement station, neutral trailing-edge height above bench, full upward/downward travel and unobstructed ruler placement.
- Bench slope, aircraft support stability, viewing direction, hand/transmitter access and risk of parallax.
- Required base footprint and ruler engagement to resist drift/tipping; screw/nut/pad dimensions, printer limits and operating/storage temperatures.
- User's acceptable reading error and repeatability, agreed before tests; no universal millimeter tolerance or aircraft throw setting is assumed.

Measurement stations differ between aircraft. Follow the actual manual and keep the ruler perpendicular to the prescribed displacement direction. Read neutral and each endpoint from the same side of the scale; subtract neutral numerically to cross-check the cursor. Remove the cursor if it blocks the scale or travel. Set up with propulsion disabled according to the aircraft manual, and remove all tools before flight.

## Acceptance checks after approval

- Editable source exports separate closed connected foot and cursor meshes. Valid measured configurations and meaningful rejected wall/slot/engagement cases are documented.
- Socket/cursor coupon accepts the actual ruler without forcing, scoring it or covering the graduations; thumb screws retain it without distorting the reference.
- Neutral and both endpoints are visible at the specified station. Surface travel clears the ruler and cursor throughout the sweep.
- Ten remove/place/reset trials record neutral and endpoint readings, base drift, ruler lean and cursor slip. Compare with an independently secured ruler and the wood-block/clamp baseline using the same aircraft support.
- Twenty cursor/retention adjustment cycles leave screw capture and ruler contact intact. Readings meet the user's pre-agreed repeatability target; observed bias and range are reported separately from accuracy.
- Success means measurably fewer reference shifts or easier hands-free readings than the baseline, with adequate clearance and no new surface contact. Reject the print if an existing clamp is equally useful or placement is unreliable.

## Physical validation and decision

CAD checks cannot establish scale alignment, ruler stiffness, reading accuracy, aircraft clearance or useful handling. Inspect the slicer for socket layers, captive-nut bridging and cursor detail. Print the fit coupon, then one foot/cursor set; verify engagement, retention and scale visibility before operating control surfaces. Run the recorded trials above and inspect pads, creep and contact marks at the actual indoor temperature. Passing these trials does not establish flight suitability or override model setup instructions.

No CAD, slicer, print or physical-use evidence exists for this proposal. Implementation awaits explicit approval and the measured ruler/aircraft setup. The next daily category is home office, then gardening and rack/homelab.
