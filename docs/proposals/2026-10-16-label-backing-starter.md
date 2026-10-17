# Cut-label backing starter

Date: 2026-10-16. Category: home office. Proposal only; OpenSCAD implementation requires separate approval.

## Use and evidence

Start separating the backing from one already-cut laminated label before applying it to an office item. The proposed tool is a small slotted paddle that bends the label gently around a smooth lip, leaving an edge of the liner available to grasp. Its practical target is fewer failed peel attempts without adding time or damaging the label. The user's label printer, tape stock, recurring difficulty and task frequency are unknown.

The [Brother PT-1180 manual](https://download.brother.com/welcome/docp000113/pt1180ug01usen.pdf), PDF page 1 under "LETTERING STICK", describes an included tool: thread a laminated label through a narrow hole, turn the stick and withdraw it to start backing removal. This establishes a real operation and a strong supplied-tool baseline. It does not establish printable performance or compatibility with other tapes. Use original measured geometry; no product dimensions, CAD or novelty claim are implied.

Brother also describes easy-peel split-back tape on its [PT-D450 product page](https://www.brother-usa.com/p/label-makers/PTD450). Check the actual liner first. Skip this proposal if its split, the supplied peeler or ordinary manual peeling already works comfortably. No printer or tape purchase is part of this proposal. Existing repository card supports display information, and the paper jogger aligns sheets; this tool would prepare a consumable for application.

## Smallest practical design

One short rigid paddle with a rounded grip and one closed through-slot for one measured tape width. The slot's long dimension clears the label's full width; its narrow gap passes the combined label and liner freely. Broad smooth lips would guide a gentle curl without gripping or cutting. Both tape ends must remain reachable during threading, curling and removal. The tool operates on detached labels away from the printer, feed path and cutter.

The intended mechanism depends on the actual label and liner responding differently to bending. A generous gap may do nothing; a tight or rough gap may scratch, jam or crease the label. These are reasons to test a small contact sample before a complete handle. Do not prescribe the historical tool's turn angle for an untested printed shape or force a label through resistance. If normal gentle handling cannot start separation, reject the interface.

Start with one slot and no blade, thin splitting nib, spring, adjustable jaw, tape dispenser, label-positioning fixture or scrap collector. Multi-width slots are variants of this same idea and add no first-prototype value. Very short labels may leave too little grip; do not lengthen labels or add waste just to make the tool work.

## Parametric OpenSCAD approach after approval

Extrude an original rounded paddle outline and subtract one transverse capsule-ended slot. Model eased entry/exit lips as explicit symmetric reliefs, preserving a straight central passage. Expose named millimeter parameters for grip length/width, plate thickness, tape width, slot length and gap, end-web/side-web minimums, outside corner radius and lip relief. Keep label length and measured free grip allowance as separate interface inputs. A slot that fits the tape width alone does not establish usable hand access or peeling behavior.

Reject nonpositive dimensions, a slot intersecting the outside, insufficient remaining webs, overlapping lip reliefs that erase the guiding section, and radius/thickness combinations that disconnect the body. Check the narrowest finished passage, including slot ends and lip transitions. Gap and lip radius must be tunable independently; do not assume a universal value from nominal tape width. Export a small same-source slot-and-lip coupon with the full contact length and enough grip for the permitted motion, then the full paddle only after that comparison succeeds.

After approval, verify closed connected meshes, positive volume, bounds and minimum sections for coupon and paddle. Exercise meaningful valid/invalid combinations of tape width, gap, thin webs, large rounding and lip relief. Confirm the wrapper exports the same contact geometry as the full source. Keep editable millimeter sources and ignored exports under repository conventions. No CAD or exports accompany this proposal.

## Material, measurements and unknowns

PLA is a candidate for a stiff indoor contact prototype; PETG is an alternative only after checking stringing, surface finish and stiffness. Neither material has demonstrated label compatibility here. No hardware is expected. Start with the broad face on the bed, but inspect the actual slot and lip toolpaths, seam position and bottom-layer bulging before deciding the orientation works. The printer must resolve the open passage and leave smooth, clean lips. Inspect any finished surface before contact; do not assume sanding produces a reliable radius.

Before CAD, confirm one recurring task and collect the actual printer/tape identity, manufacturer's handling instructions, backing type and split location. Measure tape width and combined thickness with a tool whose resolution is recorded, shortest/typical label length, blank margins, curl, stiffness, available finger grip and the current peeling method. Record the supplied peeler, any permitted simple substitute, printer/nozzle/layer settings, available material, workspace and expected temperature. Select a useful improvement target and timing/error recording method before testing. Width, thickness and printable slot fit cannot predict liner release by themselves.

## Acceptance and physical validation

1. Compare the actual tape's manual or split-back method and any supplied tool first. If those are adequate, stop. A smooth existing slot tool can test the curling hypothesis where appropriate; a paper mockup establishes hand access only, not the contact finish or release behavior.
2. After separate approval and CAD checks, inspect the slicer and print the contact coupon. Use expendable detached labels from the measured stock. Confirm free threading and withdrawal, reachable ends, gentle motion and a liner edge that can be grasped without touching the adhesive. Reject any snag, jam, tear, permanent crease, print abrasion, unwanted laminate separation, adhesive fouling or broken/rough tool edge in any trial, even if the baseline also performs poorly.
3. After the coupon succeeds, export and print the full paddle. Confirm comfortable grip, reachable label ends, clear threading/rotation/removal paths and the same absolute damage gates. Run ten matched pairs of fresh labels per representative short and typical length using this final paddle, alternating baseline/tool order. Use the same stock, text, lengths, operator and prepared target material. Time the whole prepare-and-apply task, including retrieving, threading, removing and setting down the tool. Record peel retries, discarded labels, unintended adhesive contact and application defects. Comparing only the successful peel motion hides setup cost.
4. Continue only if the agreed outcome improves repeatedly by the preselected useful margin, total task time and waste do not worsen, and every absolute rejection criterion passes. Inspect applied labels for new curl or edge lift immediately and after a recorded agreed interval on the same target. This comparison does not certify long-term adhesive performance. If both methods work easily, prefer the existing method.
5. Repeat twenty gentle operations on additional expendable labels and inspect lips, webs, debris and residue. Record any cleaning needed and include it in the workflow cost. Reject a geometry that relies on force, sacrifices label length or needs constant adjustment.

No CAD, slicer, print, peeling, surface, wear, adhesion or usefulness evidence exists. The coupon cannot establish full-handle comfort; a successful mesh cannot establish that a liner will release.

## Selection rationale

Thirty candidates across consumable preparation, reference reading and peripheral maintenance were generated before critique. The backing-starter family has a documented operation, one small original contact geometry and a cheap falsification test. Its value remains conditional on an actual troublesome tape sample. This is a handling tool, not another generic label holder.

Book weights already provide mass and compliant contact that a light rigid print lacks. Scanner fixtures must avoid image-processing interference. Keyboard cleaning supports add device-specific stability obligations to an existing hand-held method. Cable parking and general trays repeat prior proposals. Label applicators, multi-slot paddles and collection features expand the task before the basic separation step has earned a print.
