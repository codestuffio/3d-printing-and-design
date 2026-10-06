---
date: 2026-10-06
category: home-office
topic: single-card-next-action-perch
---

# Proposal: single-card next-action perch

A small freestanding foot could hold one handwritten task card upright beside the keyboard. The card would keep the next action visible while windows change, then lift out for writing or replacement. This is a proposal only. Creating OpenSCAD files requires separate approval.

## Intended use and evidence

Write the next action on an existing card, place it in the perch and read it from the normal seated position. Remove the card to write on it. The holder would support a paper habit the user already finds useful; it would not require a new task system or claim to improve attention.

[Ugmonk's Analog kit](https://ugmonk.com/products/analog-starter-kit) uses a front slot to display the current card, with extra storage behind it. Its manufacturer lists 3 × 5 inch cards and non-slip feet. This is real prior art for visible paper tasks. It does not establish the user's card size, demand, or the performance of a lightweight printed foot. Use ordinary existing cards and develop an original measured support rather than copying the product's geometry, card graphics or branding.

No report of missed tasks, unreadable notes or desk clutter has been collected. There is no home-office card holder in current main or the prior daily proposals. The rack cable saddle and RC wing-fastener dock serve different interactions. Benefit and novelty remain unverified. If the user does not use paper prompts, skip this idea. If a folded paper tent or an existing card holder works as well, prefer that baseline.

## Smallest practical design

One low, broad base with a shallow slot that lets a single card lean back. The slot would cradle the lower edge with clearance rather than grip it by spring force. The base stays on the desk; the exposed card lifts out by its upper edge. Leave enough blank lower margin for insertion so no written action is hidden.

The first prototype has no reserve-card compartment, pen holder, clamp, magnet, moving indicator or attachment to a monitor. A second slot would introduce task sorting before the one-card reading interaction has demonstrated value. The main tradeoff is simple: a wider base improves resistance to tipping but occupies more desk area. Card curl and desk friction may make the smallest foot unsuitable.

## Parametric OpenSCAD approach

If approved, form a rounded base from a 2D profile and linear extrusion, then subtract a shallow rectangular slot at the chosen backward lean. Measure lean angle from vertical and use that convention throughout. Expose millimeter parameters for base width, front/rear footprint, height, edge radius, card thickness, slot clearance, insertion depth and minimum floor/wall thickness. Keep the angle named at the top alongside dimensions.

Assertions would reject nonpositive dimensions, a slot that breaks through the floor or side walls, and angle/depth combinations that remove the supporting rear wall. They would check geometric validity, not certify stability. Export a small slot coupon to tune printer clearance, followed by a complete base to test tipping with the actual card. Keep editable source, ignored exports and usage/print guidance under the repository's project conventions.

## Material, hardware and required measurements

PLA is a candidate for a room-temperature indoor prototype. Start with the flat base on the bed; inspect the toolpath for the inclined slot and rounded edges before deciding whether support is needed. Printer resolution may limit a narrow slot. No purchased hardware is required. Grip pads would be a later option only if the actual desk test shows that a useful base slides.

Before CAD, confirm an existing paper-card routine and one use location. Record card width, height, thickness, orientation, stiffness/curl and the blank insertion margin. Measure available desk footprint, reading distance and viewing angle, hand access, nearby keyboard/mouse movement and the desk surface. Record printer bed/nozzle, available filament, expected temperature and direct sunlight. Check slot fit with the actual paper stock; nominal card dimensions alone are insufficient.

## Acceptance and physical validation

1. A slot coupon accepts the actual card without forcing, creasing or scraping it; the card lifts out easily by its exposed upper edge.
2. The complete base exports as one closed, connected mesh. Approved parameter cases preserve positive floor and wall thickness; invalid geometry is rejected clearly.
3. The written action is readable from the usual seated position without lifting the card or hiding text below the slot opening.
4. Over twenty recorded place/read/remove cycles, the complete perch does not tip, slide or release the card during ordinary nearby keyboard and mouse use. Record the desk surface and any card curl. This is a proposed check, not a demonstrated result.
5. Compare the same short paper-prompt routine with a flat card and a folded paper tent. Continue only if the perch makes reading or replacement easier while keeping an acceptable footprint and adding no unwanted ritual.

Print the coupon first, inspect its surfaces and clearance, then print one full base. Test actual card stock, retrieval, desk contact and stability. Recheck after a normal workday for slot wear, card marks and any heat-related deformation at the recorded temperature. A fit coupon cannot establish full-base stability. No CAD, slicer, print, fit, cycle, temperature or usefulness evidence exists for this proposal.

## Selection rationale

Thirty candidates across six ideation lenses were generated before critique. A single-card support keeps the strongest documented mechanism and provides a cheap comparison against paper alone. The final choice depends on confirming that this paper habit actually exists; it is a candidate to test, not a proven productivity improvement.

Other card feet and plinths collapse into the same family. Desk clamps, keyboard parking feet and shelves require unmeasured interfaces or load paths. Manual sliders and device selectors add state-setting steps and can drift from reality. General trays repeat organization patterns without a measured inventory; labeled object pockets overlap the earlier dock. Those additions would need stronger evidence than this first proposal has.
