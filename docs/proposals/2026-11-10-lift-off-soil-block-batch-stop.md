# Lift-off soil-block batch stop

November 10, 2026 · Gardening proposal for review

## The job

Place two successive sets from one handheld soil blocker in the same flat tray. Leave the intended gap between the sets without nudging the fresh blocks. Iowa State Extension describes releasing the blocks directly on a sturdy, flat tray and lifting the blocker straight up. The Gardener’s Workshop describes leaving a small channel between sets in its own mini-block workflow. [Iowa State Extension](https://yardandgarden.extension.iastate.edu/how-to/starting-seeds-soil-blocks) · [The Gardener’s Workshop](https://thegardenersworkshop.com/blogs/blog/faq-seed-starting-with-soil-blocking-2)

Try the current method, two tape marks and a clamped scrap stop first. Johnny’s Speed Tray already has molded guides for blocker alignment. A compatible guided tray may solve the problem. Consider a print only for a recurring job on an existing flat tray where poor placement still crowds neighboring blocks or wastes usable space. The owner’s equipment and placement difficulty are unknown. [Johnny’s Speed Tray](https://www.johnnyseeds.com/tools-supplies/seed-starting-supplies/trays-domes-and-flats/support-trays/polypro-endurance-shallow-speed-tray-no-holes-black-4-count-8387.0.html)

## The smallest print

A short rail drops onto one stiff side rim and locates against the tray end. The rail’s side face and one of two tabs locate the same rigid corner of the blocker housing at each position. The blocker rests on the tray floor and ejects as usual. The tabs guide light contact and leave the plunger, hands and straight-up lift path clear. Seat the rail once, place both sets and lift it away before moving or watering the tray.

## Measurements and OpenSCAD approach

Measure the tray’s rim profile, corner radius, stiffness and usable flat floor. Map the blocker’s fixed housing contact surfaces, loaded footprint and full plunger and lift sweep. Measure the actual freshly ejected array and its spread across a few baseline deposits. Use the chosen gap window and usable tray space to set the tab pitch. Reject the pairing if rim play, housing skew and block size variation consume the gap tolerance, or either tab can contact fresh blocks or interfere with ejection.

After separate approval, use millimeter-parametric OpenSCAD profiles for the rim saddle, end shoulder and tabs. Expose rim clearance, offsets, pitch, tab reach and wall thickness as parameters. Use a cropped section of the same model to check the rim and tab contact before printing the rail. PETG is a candidate for the damp bench tool. The rail needs no fasteners. Check closed, connected exports and reject parameter cases with overlapping footprints, excessive span, insufficient wall or intersecting keepouts.

## Physical acceptance

1. Inspect sliced layers at the tab roots and saddle. Fit the sample, then dry-run the full rail at both positions with the empty blocker. The rail should stay seated under light contact, the blocker should sit flat, and the plunger and lift should move freely. Check at both extremes of rim play.
2. Alternate ten paired trials against the better ordinary method. Use two fresh sets per trial, the same blocker and tray, and equivalent mix and moisture. Record the gap at both ends of the seam, blocks touching or distorted, tray-edge clearance, reseats, recasts, and total handling and cleanup time. Set the acceptable gap, usable tray capacity and minimum worthwhile reduction in rework in advance. Require that reduction with no loss of capacity or increase in block damage or total handling and cleanup time. Record fitting and print effort separately.
3. Check for rail drift, cracks and difficult cleanup after twenty extra seat-and-lift cycles. Stop early if either tab catches the blocker or the rail moves enough to push a set outside tolerance.

The placement benefit, CAD, slicing, physical fit and wear remain unverified. Confirm the recurring job and the baseline gap before approving CAD.
