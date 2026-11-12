# Lift-off microSD catch tray for a 10-inch rack

When a small computer sits low in a populated rack, a microSD card that slips during removal can fall behind the equipment or into the cables below. This proposal is for one existing setup where the operator regularly swaps cards and has seen a drop or a near miss. Try a shallow parts dish where it can sit securely, or a folded cardstock trough held in place with a clip or low-tack tape on a suitable exterior surface. If either stays put, covers the observed drop path and leaves room for fingers, use it.

Raspberry Pi documents pushing to unlock the card, then pulling it out, on a CM5 IO Board with a CM5Lite installed. Akasa lists an exterior rear microSD opening on its Fermi CM5 case and an optional 1U 10-inch front panel. Those are examples of the interface and installation. Actual hand access, drop frequency and a place to seat the tray still need checking. [Raspberry Pi CM5 IO Board datasheet, section 4.3](https://pip-assets.raspberrypi.com/categories/1097-raspberry-pi-compute-module-5-io-board/documents/RP-008182-DS/cm5io-datasheet.pdf#page=8) · [Akasa Fermi CM5 specifications](https://www.akasa.co.uk/update.php?model=A-RA18-M1B&tpl=product/product.detail.tpl&type=CHASSIS+POWER&type_sub=FANLESS+CASES)

## Smallest useful print

One shallow, light-colored trough with rounded corners and a finger scoop. A lift-off saddle seats over one measured stationary rack or shelf edge and offsets the trough below the slot. The operator powers down the device, fits the tray, removes the card by hand and lifts the tray off when done. The print touches only the selected support edge and catches gravity drops during extraction or the first regrip. The fit needs an unobstructed path for both the card and the operator's fingers.

Model the saddle and trough in OpenSCAD using millimeter profiles and extrusions. Set the edge thickness, saddle clearance, slot-to-edge offsets, trough width and reach, wall height and scoop radius from measurements. Use light PETG as a candidate with no separate fasteners. The print is a temporary accessory. Its mounting and removal must work with the rack hardware secured.

## Measure before CAD

Measure the actual edge and stop surfaces, slot location, finger and card travel through the full push and pull, nearby plugs and cables, and the drop path during the first regrip. Check room to seat and lift the tray and recover a card lying flat in either orientation. Check that the measured layout leaves a catch area under the drop path at both extremes of saddle play and leaves no path into a chassis or cable gap in the intended use. If a dish or cardstock covers the path, or the rack has no suitable edge, stop there.

## Acceptance after separate CAD approval

1. Check that the OpenSCAD export is one closed, connected solid. Exercise at least one tighter and one looser valid fit, and reject impossible saddle clearance, a disconnected trough and a scoop that cuts through the floor. Inspect the slice at the saddle root, trough floor and rim. Print a same-source saddle sample before the full tray.
2. Dry-fit on the measured edge with power off. Check both seating extremes for a clear slot, cable clearance and full finger access. Recover a flat spare card from the trough and lift the tray without shifting the equipment or leaving marks.
3. Compare the print with the best dish or folded-cardstock setup on the same powered-off arrangement or a matching mock-up. Use blank spare cards and secondary containment. Alternate ten paired trials covering normal handling and deliberate slips at observed extraction and regrip positions. Log captures, misses or trapped cards, blocked movements and setup-to-retrieval time. Set the useful improvement before testing. Reject the print if it blocks removal or a card enters the rack during the defined trials.
4. After twenty extra seat and lift cycles, recheck for cracks, looseness, marks and loss of capture coverage. The trials check the tested geometry and handling. A real recurring service job and a meaningful advantage over the ordinary setup are still required.
