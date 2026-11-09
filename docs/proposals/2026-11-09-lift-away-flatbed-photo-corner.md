# Lift-away flatbed photo corner

Home-office proposal, November 9, 2026. CAD requires separate approval.

## Use and evidence

When scanning a batch of same-size prints one at a time, placing each print against the scanner frame can crop its edges. Moving each print inward by eye can make it harder to reuse a fixed scan window. Epson's V600 guide calls for about 3 mm of setback in normal preview and about 6 mm in the listed thumbnail and automatic modes. Those are setup references for that model. An owner digitizing family albums reported clipped edges and considered making a straight paper spacer. [Epson V600 scan quality guide](https://files.support.epson.com/htmldocs/prv6ph/prv6phug/html/probs_3.htm) · [V600 owner report](https://www.reddit.com/r/techsupport/comments/14lbzxi/digitizing_family_photos_scanner_cropping_corners/)

Compare with a straight cardstock corner or an ordinary lift-off square in the same scan mode. A scanning guide already documents lifting a square away from thin originals. A printed corner earns its place if the fitted bezel stops seat more reliably or give enough repeatability to reuse the scan window with fewer adjustments. The owner’s scanner, batch size and any problem with the simpler guides remain unconfirmed. [Existing square method](https://scanning.guide/placing-your-paper)

## Smallest useful design

One L-shaped guide for one scanner corner, scan mode and range of flat photo-print thicknesses. Feet sit on the plastic bezel and locate against two measured edges. Two short fences overhang the glass and register the photo at separate horizontal and vertical setbacks. Slide the print against both fences, lift the guide straight off, then close the lid. Both fence bottoms need clearance above the glass and must sit low enough to catch the thinnest test print.

Use millimeter parameters in OpenSCAD for the bezel step and corner relief, fence lengths and setbacks, gap above the glass, wall thickness and lift tab. Form the part from joined extrusions with rounded or chamfered edges. Use a short sample of the same foot and fence profile to check the interface. Plain PLA is a candidate for a rigid indoor part. The guide would use no fasteners or adhesive.

## Measurements and acceptance

- Identify the scanner and scan mode. Measure the bezel's width, steps, corner radius and height above the glass. Map the actual capture boundary on both axes with a gridded scrap and confirm that the planned fixed window has room for the entire target print plus a visible border.
- Measure the thinnest and thickest prints in scope. Allow for bezel variation, print tolerances and deflection during handling. Stop if the measured range cannot give both positive glass clearance and reliable contact with the print edge.
- After CAD approval, check that valid dimensions export a closed, connected mesh and that invalid offsets or clearances are rejected. Inspect the sliced contact faces for supports and first-layer flare. Measure the printed sample and test it on a mock bezel step before trying the full guide on the scanner with scrap prints.
- Run ten paired scans with the printed guide and the better ordinary guide, using the same fixed window and matched scrap prints. Measure position and angle spread, handling time and the number of adjustments or rescans. Check for shifts during lift-off and lid closure. Require all four edges and a visible border in every trial, with no glass contact or photo scuffing. Advance if the fitted guide measurably reduces placement variation or rework without increasing handling time.
- Repeat twenty seating and lift-off cycles to look for looseness, burrs or changes in clearance. Slicing, fit, wear and workflow benefit remain unverified.
