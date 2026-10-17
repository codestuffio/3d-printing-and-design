# Partial pot-rim soil shield

Date: 2026-10-17. Category: gardening. Proposal only; separate user approval is required before CAD implementation.

## Intended use and evidence

Temporarily hold a small curved wall above one sector of a pot rim while spooning potting mix around an installed root ball. The practical hypothesis is fewer misses onto the outside of an awkward occupied pot, without enclosing the plant or narrowing the mix path into a funnel. No particular pot, recurring spill problem or user demand has been confirmed.

[University of Maryland Extension](https://extension.umd.edu/resource/potting-and-repotting-indoor-plants) describes filling around a root ball and leaving watering headroom below the rim. This establishes the task, not a need for this tool. [Burgon & Ball's container scoop](https://www.burgonandball.com/collections/trowels-planting-tools/products/container-scoop-rhs-endorsed) already uses a collar to contain compost during transfer. Its claims are manufacturer claims, not comparative test evidence. No novelty or universal compatibility is claimed; no CAD would be copied.

First compare the actual spoon or scoop and tray with a curved scrap-paper shield. Skip the print if those work comfortably, or if needing one hand for the shield compromises support of the plant or pot. A stable pot and a root ball that does not require a supporting hand are prerequisites for this particular two-hand workflow.

## Smallest practical design

One continuous rigid partial arc with rounded exposed edges, a broad loose rim-resting ledge and an outside grip tab. Hold the tab throughout filling; the ledge locates the shield and does not clamp, snap onto or carry the pot. The inward face and ends remain open. The ledge upper face slopes inward across the rim to a free drop edge just inside the measured mouth, above the target fill and clear of the root ball. It must provide a visible uninterrupted return path, with no horizontal soil pocket or inward shelf that holds mix. If the measured clearance cannot accommodate that path, reject this interface. Scoop weight must not bear on the shield. No full collar, narrow outlet, seed dispenser, depth stop, plant support or permanent installation.

Use it only for the selected accessible rim sector. Remove it before final level inspection, settling and watering; preserve the plant's appropriate root-ball height and watering headroom. Reject the concept if it hides the fill level, requires raising the root ball, contacts foliage/stems/roots, catches the scoop or prevents normal finger access.

## Parametric OpenSCAD approach if approved

Create an original annular sector from a measured pot-rim radius, union a broad radial ledge and external rounded grip, and ease the exposed edges. Keep dimensions in millimeters with named parameters for rim radius/profile clearance, arc angle, wall height/thickness, ledge width/thickness, inward return reach/slope, grip length/width, edge radii and minimum connected section. Radius clearance is a locating allowance, not an interference fit. The required ledge contact must remain outside the plant/root-ball clearance envelope.

Guard positive dimensions, non-inverted radii, a limited open arc, intact rounded wall/ledge/grip overlaps and usable grip clearance. Check thin-wall/large-radius and minimum-ledge cases adversarially. Export a same-source short rim-contact coupon first, then the complete shield; the coupon cannot prove full-arc hand access, stability, removal or soil behavior.

PLA is a candidate for a brief indoor fit coupon; PETG is a candidate for the handled prototype after checking stiffness and surface finish. No hardware. Select orientation after examining layer directions, ledge/grip joins and support contact in the slicer. Ease and inspect contact edges. Material choice alone proves no cleanability, plant compatibility, UV resistance or outdoor life; store the tool indoors.

## Measurements and unknowns

Confirm an actual recurring filling task, plant-specific handling guidance, the current baseline and a useful improvement threshold. Measure the pot's local outer/inner rim radii, lip cross-section, taper, flexibility and condition; exposed arc, foliage/root-ball clearance, desired fill/headroom, spoon path, grip and removal access. Record mix particle/clump size and moisture, quantities transferred, tray arrangement, printer/nozzle/layers and measurement resolution. Thin nursery pots and glazed or fragile rims may make a rigid ledge unsuitable. No force, load or universal fit rating is proposed.

## Acceptance and physical validation after approval

- Verify editable parameters, closed connected consistently wound nondegenerate positive-volume meshes, bounds and minimum sections; exercise valid boundaries and intended invalid assertions. Inspect actual rounded joins and ledge clearance, not just nominal overlap.
- Inspect the slicer and print the contact coupon. Reject wobble, rim deformation, scratches, trapped grit or sharp/stringing contact edges. Then check the complete shield with an empty stable pot and inert root-ball surrogate before any living plant; verify grip, spoon path, full-arc access and removal. Keep an underlying catch tray.
- Compare ten matched filling tasks per method, alternating baseline and shield order with the same measured pot geometry, mix condition, starting surrogate and target fill. Include paper shield if it is the strongest baseline. Set the combined handling-waste measurement resolution and worthwhile reduction before testing. Measure escaped mix and mix retained on the shield or rim separately and as combined handling waste; do not count retained mix as successful transfer. Measure total retrieve/place/fill/remove/clean/store time, retries, final level and cleanup burden. Do not repeatedly repot a living plant for the comparison.
- Require the agreed reduction in combined handling waste to recur without worse total task time or incorrect fill/headroom. Reject every trial with pot slip, tipping, rim damage, plant-contact risk, blocked access, mix trapped beneath the ledge, uncontrolled dumping or tool breakage, even if the baseline also fails. A surrogate comparison does not establish live-plant suitability; a later ordinary repotting task needs its own observation.
- Inspect wall/ledge/grip joins and contact surfaces after twenty gentle placement/removal/cleaning cycles. Record cleaning method and retained grit. Skip the design if cleaning or setup cancels its gain. No slicer, print, fit, surface, strength, wear, plant-health or usefulness evidence exists yet.

This is a proposal for a measured bench task. It does not authorize CAD, replace horticultural guidance or establish physical readiness of any existing repository design.
