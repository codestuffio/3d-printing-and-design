# Booklet staple-marking strip

Date: 2026-10-20. Category: home office. Proposal only; original OpenSCAD implementation requires separate approval.

## Use and evidence

Transfer the same staple positions onto the outer cover of a repeated booklet format without reading a ruler for every copy. A loose flat strip would align with the intended spine and one paper end, expose the chosen positions through edge-open pencil notches, then lift completely away before the booklet enters the stapler. The practical target is fewer measuring retries and placement errors across a real batch, without increasing total work. The user's stapler, booklet routine, recurring difficulty and batch size are unknown.

[Bostitch's long-reach stapler procedure](https://bostitchoffice.com/articles/product-faq/how-to-use-a-long-reach-stapler/) uses its integrated ruler and paper stop to align the spine, then repeats stapling along that spine. This documents a task, not demand for another guide. The possible benefit of transferring longitudinal positions from fixed notches is an inference. The source does not establish an optimal station count or spacing for the user's booklet; determine those from the actual task and tool instructions. The existing stapler still controls spine depth and performs all stapling.

Compare a ruler and pencil, a reusable cardstock template and any existing manufacturer guide first. Skip printing if any already works comfortably or booklet production is rare. There is no novelty claim. The prior corner jogger squares a stack; this strip would transfer marks to one cover.

## Smallest practical design

One original flat strip for one booklet length and one agreed station pattern. Its short end is visually aligned with the paper end; its long notched edge follows the intended spine line. Open shallow V-shaped pencil notches expose each mark location. The cover rests on an ordinary flat backing, and the strip rests loosely on the cover. Use only permitted light pencil marks on expendable or suitable stock. If the marks would remain objectionable or cannot be placed accurately, reject this workflow.

The first version has no clamp, downward end lip, adjustment slider, raised stop, staple slot or attachment to the stapler. A downward lip could tilt a strip resting on thin paper. Visual end alignment also has error, so it must be measured rather than called a positive stop. A loose guide can slide, bow or obscure the intended line. Remove it entirely before assembling and stapling by the normal method; no printed material enters the stapler's head, throat or anvil area. The tool is a marking template, not a stapler operating guide or precision gauge.

## Parametric OpenSCAD approach after approval

Extrude a rounded 2D strip outline, subtract edge-open notch profiles at a named list of measured station positions, and ease the paper-contact edges without erasing the locating features. Expose millimeter parameters for strip length, width, thickness, notch depth/width/tip radius, end margins, remaining web and grip allowance. Station count and coordinates belong to the actual format; no universal spacing is assumed. Use a flat end as the visual datum. Include the effect of pencil tip width and angle when checking the mark positions.

Reject nonpositive dimensions, stations outside the useful length, overlapping notches, insufficient remaining material and rounding that removes a station or disconnects the strip. Verify finite bounds, closed connected positive-volume meshes and meaningful valid/invalid combinations. A same-source short coupon would check one complete notch, paper contact and pencil access; the full strip would still need separate length, flatness and alignment checks. Keep editable source and ignored exports under repository conventions. No CAD accompanies this brief.

## Material, hardware and measurements

PLA is a candidate for a cool indoor prototype; PETG is an alternative only if its stiffness, finish and flatness suit the actual tool. No added hardware is intended. Begin with the broad face on the bed and inspect notch toolpaths, first-layer bulging, seams and paper-contact finish. The measured format must fit the printer bed as one piece; do not add joints or silently scale the stations to fit.

Before CAD, confirm a recurring booklet task, actual stapler model and instructions, allowed sheet count/stock and normal assembly sequence. Record cover dimensions and cut variation, fold thickness/springback, intended spine line, station count/coordinates/end margins, permitted marking location, pencil tip, hand access and backing surface. Measure available bed/nozzle/layer settings, material and actual as-printed length/flatness with recorded measurement resolution. Set a useful improvement threshold and representative batch size before comparison. Nominal CAD distances cannot establish final staple positions after the cover is assembled. Fold thickness, springback and cover movement can change that result.

## Acceptance and physical validation

1. Compare ruler marks and a cardstock template on representative expendable covers before CAD. Include template preparation, retrieval, marking, assembly, stapling and cleanup. Skip the print if the simple method is adequate.
2. After separate approval, verify mesh and parameter cases, inspect the slicer and print the notch coupon. Confirm pencil access and clean removal without paper scuffs, tears, unwanted marks, residue or tool fragments. Reject sharp or snagging edges. The coupon cannot establish full-strip flatness or position accuracy.
3. Print the full strip only after the coupon succeeds. Measure actual notch positions, end datum and flatness. Run ten matched booklets per method and representative stock/stack range, alternating method order and using the same intended station pattern. Record total batch time including setup, retries, rejects, mark-position error and final staple-position error along and across the spine. Record measurement resolution and any drift during assembly.
4. Continue only if the preselected outcome repeatedly improves by the agreed useful margin, total work and paper waste do not worsen, and no new damage, wrong station count or stapling defect occurs. A good-looking mark under the strip is insufficient. Existing manufacturer limits and normal stapling checks still apply.
5. Inspect the printed strip after twenty gentle marking/removal cycles for notch wear, bowing, debris and paper marks. Recheck measured locations. These short trials cannot establish long-term wear or general compatibility.

Confidence is low: the geometry is simple, but a paper template may eliminate its value. No CAD, slicer, print, fit, accuracy, wear or usefulness evidence exists. This remains a baseline investigation until the actual task and separate implementation approval are supplied.
