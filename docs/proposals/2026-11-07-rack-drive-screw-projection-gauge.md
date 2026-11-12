# Proposal: Screw protrusion gauge for a 10-inch rack drive tray

2026-11-07 · 10-inch rack maintenance · Proposal only

## Use and evidence

When swapping 2.5-inch drives on a rack shelf, similar-looking screws can extend different distances into the drive after passing through the tray. A small bench gauge would screen loose screws for excess protrusion before the drive comes near the tray.

DeskPi documents underside drive slots on its DP-0033 10-inch shelf. The 2.5-inch WD Blue 3D NAND SATA SSD manual specifies a 3.5 mm maximum screw penetration for that drive family. These are examples of the interface and the constraint. The pairing and its hardware have not been measured. [DeskPi shelf documentation](https://wiki.deskpi.com/rackmate/accessories/dp-0033-sbc-shelf/) · [WD drive manual, printed page 17](https://documents.westerndigital.com/content/dam/doc-library/en_us/assets/public/western-digital/product/internal-drives/wd-blue-ssd/user-manual-wd-blue-3d-nand-sata-ssd.pdf#page=22)

Use the specified fasteners from a labeled kit where available. For repeated sorting, compare the gauge with measuring the seated screw on the empty tray using calipers and the drive manual. No recurring swaps, mixed fasteners, or caliper difficulty have been confirmed. Pursue CAD only if a real recurring job exposes a measurable gap in that baseline.

## Smallest practical design

Use one rigid bridge sized for one tray revision, drive model and bottom-mount position. Two feet sit on the same lands the drive would contact. With the drive removed, hold the screw and any specified washer square and fully seated in the actual tray. Lower the bridge gently over the indexed hole. The roof spans the screw's full allowed side play, and the open side keeps the tip visible. If the tip touches the roof or either foot fails to seat, set the screw aside for a caliper check. Use a conservative roof height below the manufacturer's limit to account for measurement error and print variation. Label the tool with the exact setup.

The check covers maximum projection only. Verify screw type, head seating and required thread engagement independently against the kit or manufacturer instructions. Keep the gauge and all trial screws on the bench. Exclude setups with inaccessible or uneven drive seating lands or screws that cannot be held square and fully seated.

## OpenSCAD approach after approval

Model the bridge in millimeters from extruded profiles with coplanar reference pads and a subtracted side-open window. Expose pad spacing, width, locating offset, window width, roof thickness, specified limit and clearance margin. Use a short same-source pad and roof coupon to measure the printed height before printing the full bridge. PLA is a candidate for this indoor bench tool. The gauge needs no fasteners.

Measure the installed drive's contact lands and reference plane, shelf and specified washer stack, screw head and seating geometry, slot position and play, available space around the hole, and the exact drive model's published penetration limit for that mounting face. Check that the screw can be held without tilting or lifting and quantify print and caliper repeatability before choosing a margin.

## Acceptance and physical checks

1. Export closed, connected coupon and bridge meshes. Check the intended pad coplanarity and roof height. Reject parameters that remove a pad, leave a thin roof or produce a nonpositive screened height.
2. Inspect the slice for a clean roof and flat pads. Print the coupon, measure it, then print one bridge and verify its seating and height on the empty tray. Test tip visibility and check all intended hole locations for rocking or lateral slip.
3. Use caliper-characterized samples below, near and above the threshold on the empty tray. Repeat at the ends of the allowed slot play. Challenge the setup with tilt, partial seating and light handling pressure to see whether any produces false clearance. Require zero false clearances in the trial and route borderline results to calipers. Leave any actual drive out of the test.
4. Run ten paired screenings with the gauge and the caliper baseline, alternating method order. Record hands-on time, disagreements and follow-up measurements. Recheck dimensions after twenty additional placements for wear or distortion. Count setup and calibration effort when deciding whether the tool saves time.

Slicer behavior, dimensional accuracy, repeatability, wear and usefulness remain unverified. CAD needs separate approval.
