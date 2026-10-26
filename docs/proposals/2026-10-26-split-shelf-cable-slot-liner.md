# Split shelf cable-slot liner

2026-10-26. Category: 10 inch rack / homelab. Proposal only; separate user approval is required before CAD implementation.

## Intended use and evidence

Two printed halves would cover the edge of one measured rack-shelf cable opening, installing around already terminated, disconnected Ethernet leads. The practical target is a cable jacket repeatedly catching on an awkward opening during equipment servicing. No owner shelf, snagging problem or service frequency has been reported. Usefulness confidence is low; this is a conditional discussion brief, not a reason to print yet.

[icotek UT](https://www.icotek.com/en-us/products/multi-cable-transit/ut) demonstrates split installation around terminated cables, using elastomer and a defined panel interface. [HellermannTyton EdgeGuard](https://www.hellermanntyton.com/products/edge-protection/tha-012/251-06101) supplies flexible panel-edge strip. These are established alternatives, not evidence that a printed liner performs like either product. [DeskPi's shelf example](https://wiki.deskpi.com/rackmate/accessories/dp-0056-heavy-duty-rack-shelf/) shows why actual sheet thickness, lip direction and ventilation openings matter. No universal fit follows from the 10 inch rack name.

First confirm a repeated servicing problem and compare rerouting with an existing loose strap, commercial edge trim and an appropriately sized split grommet. Commercial trim is the stronger starting option. Drop the print if one of those solves the problem with less preparation, or if the opening is already smooth. Custom cutout geometry is the only proposed reason to pursue this version. No novelty, electrical insulation, sealing, fire, strain-relief or abrasion-lifetime rating is claimed.

## Smallest practical design

A pair of panel-grooved half-rims follows one rounded rectangular cable opening. Each half presses over its portion of the sheet edge, with broad rounded cable-contact faces. Split joints sit outside the observed cable travel and meet without a proud step. The halves must cover every edge reachable by those leads and remain seated as cables move. Retention is an unresolved interface, not an assumed snap fit.

One opening and one measured cable route only. No added teeth, cable clamps, hinges, fasteners, adhesive, new shelf holes or cooling features. This differs from the existing service-loop saddle: it lines an opening rather than supporting slack. It does not replace a required or rated equipment cable-entry component.

## Parametric approach if approved

Use original OpenSCAD 2D rounded-rectangle offsets and extrusions for the rim, subtract a sheet-thickness groove, then split it into two connected halves with cable-contact transitions rounded in section. Expose dimensions in millimeters at the top: cutout width/height/corner radius, sheet thickness, groove clearance/depth, rim width, top/bottom flange thickness, contact radius and joint location/clearance. Check that the reduced opening still passes the required connector envelope; split installation alone does not prove later cable replacement clearance.

Guard positive walls/flanges, a feasible groove, compatible radii, connected halves, full edge coverage and clearance between the halves. A short straight-and-corner coupon must use the same profile and groove modules as the complete liner. No CAD or exports accompany this proposal.

## Material and measurements

TPU around 95A hardness is a candidate for a compliant fit, subject to the actual printer and filament specification. A rigid material may serve only as a geometry coupon; it does not establish flexible-part retention. No metal hardware is planned. Printed surface texture, compression set and warm-rack creep may make commercial trim preferable.

Measure the actual shelf cutout and corner shape, coating-inclusive sheet thickness and variation, nearby bends/perforations, top/bottom access, usable groove depth, opening-to-device clearance, cable diameter, boots/connectors, cable travel and bend requirements. Establish shelf temperature, available printer/nozzle and a usable TPU profile. Confirm that the opening is not part of an equipment enclosure or a specified cable-entry assembly. Owner measurements and an actual photo of the task are missing.

## Acceptance and physical validation after approval

- Record the current safe method and commercial alternative before CAD. Agree what recurring snag or handling delay would justify a custom part; reject an unnecessary print.
- Export each half and the coupon as finite, closed, consistently wound, nondegenerate connected meshes with positive volume. Check groove, flange and contact geometry analytically; exercise meaningful valid/invalid combinations and deliberately wrong-feature cases. Inspect slicing, seams, bridging, layers and cable-contact texture separately.
- Fit the coupon on a spare matching panel, then the full liner without force or shelf deformation. Check complete reachable-edge coverage, joint steps, boot passage, adjacent equipment removal and bend clearance. Reject looseness, flange lifting or a seam entering the cable route.
- Use disconnected sacrificial Ethernet leads on a bench fixture first. Perform 20 liner installation/removal cycles and 50 representative cable movements; inspect seating, cracks, compression set, jacket marks and debris. Agree an additional warm-condition observation period using measured operating conditions. These trials establish only the tested conditions, not lifetime protection.
- If those checks pass, predeclare catch count per identical cable movement as the primary benefit measure and agree the minimum useful improvement. Compare ten matched servicing rehearsals per safe method, alternating order. Report initial preparation and installation separately from recurring service, removal and cleanup; retain both first-use total and recurring time. Count catches, reseating, dropped parts and connector-access failures. Reject if the liner dislodges, marks a jacket, obstructs equipment or offers no agreed benefit over trim/rerouting. Without a commercial sample, do not claim to outperform it.

No CAD, slicer, print, retention, cable-wear, temperature or usefulness evidence exists. The next decision is whether a real awkward opening warrants measurements and separate CAD approval.
