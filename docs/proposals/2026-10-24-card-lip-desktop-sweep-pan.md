---
date: 2026-10-24
category: home office
status: proposal-only
---

# Proposal: card-lip desktop sweep pan

A small reusable pan could collect loose, dry coarse debris from a cleared desktop using an existing hand brush. A replaceable cardstock strip would bridge the printed front ramp to the desk. This is a conditional design proposal. CAD implementation requires separate approval.

## Intended use and evidence

The target is a recurring cleanup where brushing debris onto folded card spills during pickup or carrying it to a bin. No such owner problem, brush inventory or cleanup frequency has been confirmed. Confidence in useful improvement is low, about 25% as an author judgment rather than a measured probability. Geometry complexity is low to medium because the card interface needs testing.

[OXO's Sweep & Swipe](https://www.oxo.com/shop/cleaning-organization/home-office/oxo-sweep-and-swipe-laptop-cleaner.html) establishes a compact brush-based crumb cleanup task. [Its Compact Dustpan & Brush Set](https://www.oxo.com/compact-dustpan-brush-set.html) already uses a soft rubber lip that conforms to the surface. [Redecker also makes a table sweeping set](https://shop.redecker.de/en/table-sweeping-set-428473). These are strong existing alternatives, not evidence of demand for a print or of printed performance. No novelty claim is made.

First compare a folded-card receiver, the current cleanup method and an existing small dustpan if available. The possible advantage is a rigid carrying floor and sidewalls while retaining a thin replaceable entry edge. If folded card alone works as well, stop. A rigid printed ramp without the card is not assumed to collect small debris effectively. This tool is for a bare desk surface; it would not enter keyboards, electronics or machinery, or handle liquids or hazardous debris.

## Smallest practical design

One shallow printed pan with two sidewalls, a rear wall, a short rear handgrip and a broad open front ramp. Two short, open-ended side channels would locate a cut rectangular cardstock strip over the ramp. The strip overlaps the interior floor and projects forward to touch the desk. Keep its central sweep path open. The channels provide location, not a proven grip: reject a strip that buckles, shifts, lifts or falls out during sweep, lift and emptying.

No printed brush, lid, desk attachment, snap joint, brush storage or separate rubber component. Empty through the open front over a bin, remove the card and brush or wipe the accessible pan clean. If retained debris or the card interface adds more work than the baseline, abandon the design rather than add mechanisms.

## Parametric OpenSCAD approach after approval

Use original rounded profiles and extrusions for the floor, walls and rear grip; form the front ramp with a wedge and subtract the two card channels. Expose millimeter parameters for mouth width, floor depth/thickness, wall height/thickness, corner radius, ramp length/rise, card thickness/clearance/overlap/projection, channel length and grip dimensions. Size the mouth around the actual brush sweep envelope, not a universal brush model. Avoid a knife-thin printed edge; the card supplies the final desk contact.

Guards would reject nonpositive dimensions, a ramp that removes the floor, disconnected walls/grip, channels that break through the supporting floor or walls, and card placement that blocks the mouth or lacks supported overlap. Check meaningful valid/invalid parameter cases, closed connected positive-volume meshes, mouth/ramp/channel dimensions and the clear sweep path. A short same-source ramp-and-channel coupon would test card location before the full pan. Coupon success cannot establish whole-pan flatness or pickup.

## Material, hardware and measurements

PLA is a candidate for a cool indoor trial; PETG is an alternative if finish and stiffness are acceptable. Use ordinary replaceable cardstock and an existing brush, with no metal hardware. Card stiffness, curl, moisture sensitivity and edge wear need trials; neither material is selected for food handling or electronic cleaning. Provisional orientation would put the pan floor on the bed, subject to slicer inspection of channel roofs and the front ramp. Set layer height, walls and infill after measuring the smallest features; remove support contact from the card and desk interfaces or revise the prototype.

Measure the brush head width, bristle splay and sweep angle; actual coarse debris size/count; clear desk area, texture and flatness; desired pan capacity; grip and bin access; card thickness, width, stiffness and unsupported reach; printer bed, nozzle, layers and achievable channel/ramp dimensions. Establish the acceptable residual debris and useful time or spill reduction before testing. All dimensions remain unknown. Do not infer fine-dust pickup or a seal from the card touching the desk.

## Acceptance and physical validation

Before CAD approval, confirm the recurring task and compare the paper receiver with the current method. If approved, inspect slicing, print the ramp/channel coupon, then one pan. Verify card insertion/removal, unsupported edge contact, channel clearance, sweep access, flatness and absence of sharp edges or desk scratches on a sacrificial surface before using the actual desk.

Run ten matched cleanups per method with the same brush, cleared area and counted representative coarse debris, alternating method order. Include card preparation, setup, sweeping, pickup, carrying, emptying and tool cleaning in total time. Record residual and spilled particle counts, extra passes, card movement, buckling, trapped debris and surface marks. Retain the design only if it meets the previously agreed useful improvement without worse cleanup or new damage. If no commercial pan is available for comparison, results cannot establish an advantage over that alternative. Fine dust requires separate evidence and is outside this first trial.

Repeat twenty sweep/lift/empty cycles and inspect channel debris, card wear, ramp damage and desk marks. Replace the card when damaged and record replacement effort. No CAD, slicer, print, card fit, pickup, spill, durability or usefulness evidence exists. This differs from the existing paper-stack jogger, card perch and headphone clamps by performing temporary debris collection rather than aligning or supporting office objects.
