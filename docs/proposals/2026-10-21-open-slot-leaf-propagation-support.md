# Open-slot leaf-propagation support

Date: 2026-10-21. Category: gardening. Proposal only; CAD requires separate user approval.

## Intended use and evidence

Support one suitable leaf cutting over one measured water jar, with its petiole hanging in water and its leaf blade above it. An open radial slot would let the user remove the plate sideways around the petiole while holding the cutting separately. The proposed benefit is easier removal and water changes without rebuilding a pierced film cover.

[University of Nevada Extension's houseplant propagation guide](https://extension.unr.edu/small-business-education/pub.aspx?PubID=3384) describes a foil or waxed-paper cover secured with a rubber band to hold a leaf upright over water. This establishes an improvised support to compare against. The guide was published in 1998 and remains hosted by Extension; it does not establish that a printed plate is better or appropriate for every plant. Follow current guidance for the actual species.

No recurring propagation task, suitable plant, jar or frustrating water-change routine has been reported by the owner. Confidence in practical value is low, about 30%; the geometry appears simple. Compare existing foil/paper and rubber band before approval, including simply tearing the film away. Reusability adds cleaning work and may not save effort. Reject the print if that method works comfortably, or if direct support by the jar already suffices. This is distinct from seed dispensing, plug removal and the implemented pot-rim soil shield. No novelty or improved-rooting claim is made.

## Smallest practical design

One original loose plate rests broadly across a single jar rim. A radial slot leads from its outside edge to a rounded central opening. The cutting's own leaf geometry must permit broad smooth support around the petiole junction without pinching; the slot provides clearance, never a friction clamp. Keep a small external handling tab away from the leaf. There is no snap fit, sealed lid, stem-gripping insert, multi-cutting array or reservoir attachment.

An open slot also permits accidental escape. Before CAD, test the arrangement with a smooth card mockup and a substitute cutting. Reject it if a stable resting orientation cannot be achieved without trapping, constricting or sharply bending the petiole. The leaf's size and off-center weight can tip the plate or jar; jar diameter alone does not establish stability. This tool never lifts the jar. Hold the cutting independently before lifting and sliding the plate free; carry out water changes with the cutting safely supported elsewhere, without pouring through the slot. The rooted cutting must fit through the jar mouth without pulling or compressing roots. A narrow-necked jar that traps roots is unsuitable.

## Parametric OpenSCAD approach after approval

Extrude a rounded plate profile, subtract the central opening and continuous radial slot, and union a broad rounded handling tab. Expose measured jar mouth/rim envelope, outer plate diameter, bearing overlap, plate thickness, opening diameter, slot width, slot-end radius, edge rounding and tab size. A loose locating feature is optional only if rim measurements show it necessary; do not silently add a skirt or clamp. Keep source units in millimeters and all dimensions at the top.

Assert positive dimensions, a slot wide enough for the measured petiole plus clearance, an opening at least as wide as the slot, adequate remaining connected web, and a genuine rim-bearing area outside the mouth. Limit rounding so it preserves both support and the continuous escape path. Export a short same-source slot/contact coupon first. Test measured small/large configurations and rejection cases for closed escape, lost bearing land, erased web, excessive rounding and nonpositive dimensions. Inspect actual slot and support geometry, not just mesh connectivity. CAD checks cannot prove gentle contact or retention.

## Material, hardware and unknowns

PETG is a candidate for a washable indoor prototype; PLA could serve for a cool short fit trial. Neither has established cleaning, plant-contact, water-exposure or long-term durability here. No purchased hardware is intended. Prefer an accessible one-piece plate with no hidden cavities. Print flat if the actual profile permits, then inspect supports, edge finish and flatness in the slicer. Printed texture may catch delicate tissue or retain residue, making disposable film preferable.

Measure the actual jar mouth, outer rim and rim profile; usable bearing land; petiole diameter and bending clearance; leaf blade/contact geometry and weight distribution; desired stem immersion and water level; and the mature root-removal path. Establish species suitability, light/temperature, water-change and cleaning routines, printer/material capability and measurement resolution. Determine whether one hand can safely support the cutting during removal. No universal stem size, immersion depth, jar diameter or cleaning chemistry is assumed.

## Acceptance and physical validation after approval

First compare foil/paper with a smooth card mockup using a substitute cutting, including setup, water changes, removal and cleanup. Agree on a useful improvement before printing. If the open slot cannot support the representative shape without escape or contact damage, stop rather than narrow the slot into a clamp.

After CAD approval, require closed, connected, consistently wound, finite, nondegenerate meshes with positive volume, correct bounds, measured rim overlap and an uninterrupted side-release path across the declared parameter cases. Print the coupon before the whole plate. Verify clearance without force and inspect smoothness, flatness and cracks; a coupon does not prove full-plate stability. Test the full plate on a stable tray with a surrogate leaf/petiole mass first, across the actual jar fill levels and credible gentle handling. Reject tipping, sliding into the mouth, side escape, sharp bending or wetting of the supported leaf.

Then compare ten matched handling cycles per method, alternating order, using the same surrogate cutting and jar. Record setup, water-change and cleanup time, retries, spills, unintended contact and escapes. Require a pre-agreed useful improvement without worse handling or damage. Inspect twenty gentle installation/removal and cleaning cycles for slot wear, roughness, bowing, cracks and retained residue. Only after mechanical handling passes, cautiously observe one expendable suitable cutting through the intended propagation period, checking contact marks, water cleanliness, support changes and root removal. Handling trials do not establish root health, disinfection or improved propagation success. No CAD, slicer, print, fit, cleaning, stability, wear or practical-use evidence exists yet.
