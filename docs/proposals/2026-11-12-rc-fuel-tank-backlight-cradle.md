# Backlight cradle for RC fuel-tank inspection

November 12, 2026 · RC airplane bench tool · Proposal

## When it would help

When a clean, empty translucent tank is already off the airplane for a build or fuel-line service, hold it to a bright light to check the vent and the weighted pickup, or clunk. DU-BRO calls for this visual check and specifies that the pickup must move freely inside the tank. If holding the tank in front of a lamp makes it hard to find the same view twice, a bench cradle could hold the shell steady while the builder looks or takes a reference photo. The owner's tank, frequency of service and visibility problem are unknown. Try hand-held inspection against the same fixed lamp and then a scrap V-block before approving CAD. [DU-BRO assembly guide](https://www.dubro.com/blogs/du-bro-101/du-bro-101-how-to-set-up-rc-airplane-fuel-tank)

## First print

Fit one measured tank. Use a one-piece bench base with low, rounded support lands and two gravity seats for the same shell. One seats the tank on its side to view the vent and rear wall. The second parks it with the stopper end up for a repeatable view of the pickup near the opposite wall, using a tank where both views provide useful contrast. Confirm both views with temporary supports before modeling. Leave an open light path and space around the stopper, fittings and tubing. Lift the tank out to tilt it by hand and observe the pickup through its full intended swing. Use an existing fixed lamp and candidate PLA for the dry bench cradle. The tank lifts out without clamps or fasteners.

After separate approval, build the base and support lands from millimeter profiles in OpenSCAD. Measure the actual shell width, height, length, corner radii, molded seams and lip, all fitting projections, the areas that transmit light and the space for fingers. Parameterize the two seat angles, contact spacing, seating clearance, fitting relief and base footprint. Size the base for stable seating in both poses. Reject invalid values that pinch the shell, close the fitting relief or leave a disconnected support. Verify that the thin tank wall remains undeformed and that the supports, bench and light leave the full inspection area visible.

## How to check it

Export a closed, connected solid at measured dimensions, exercise invalid parameter cases and inspect the sliced support roots and contact faces. Start with a same-source contact sample on a spare, dry tank. Check stable seating in both poses, easy lift-off and clearance around every fitting. Reject rocking, scuffing, tank deformation and any support shadow that hides the vent, pickup or the wall near it.

Compare the cradle with the better ordinary method using the same lamp. Use an unused dry tank or sacrificial fixture with known free and deliberately obstructed pickup states, including one that binds between the parked views. Alternate methods over ten matched trials. Keep the same hand-tilt check in both methods. Record correctly identified states, inconclusive views, tank repositionings and elapsed time from setup through the final check. Require correct identification of every control state and a useful reduction in repositioning or total time, with the improvement threshold chosen before testing. Recheck seating and contact wear after twenty extra placements.

A recurring need and an advantage over handheld backlighting or a V-block would justify CAD approval. Slicing, fit, visibility and handling need their own evidence. Fuel flow, leak testing and flight readiness remain separate manufacturer checks. [DU-BRO fuel-system setup](https://www.dubro.com/blogs/masterclass/masterclass-szn-3-ep-9-rc-airplane-fuel-system-setup)
