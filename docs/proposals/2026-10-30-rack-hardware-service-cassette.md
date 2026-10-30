# Four-set rack hardware service cassette

2026-10-30. Category: 10 inch rack / homelab. Proposal only; CAD implementation needs separate user approval.

## Intended use and evidence

A small covered cassette would carry four sets of removed rack fasteners between a rack and workbench, keeping each screw, washer and any removed nut in its own well. The target is a recurring service job where loose nonmagnetic parts become mixed or escape during transfer. No owner task, hardware set, loss or dimensions are confirmed. This is a low-confidence discussion hypothesis.

[Rackstuds' tutorials](https://www.rackstuds.com/pages/tutorials) describe small-part handling during removal and returning pieces to a zip bag. [iFixit's FixMat](https://www.ifixit.com/products/fixmat) already offers sorting bins and a magnetic surface for magnetizable parts. These establish an operation and strong alternatives, not a need for this print. Follow the actual mounting hardware instructions, including separate equipment support. The cassette never supports equipment or assists screw installation.

Try labeled zip bags, an existing compartment box or pillbox, a small covered cup and the current service mat first. Four separate bags may preserve matching better than one custom part. Only pursue a print if an actual mixed-material fastener set does not fit available boxes and the current transfer method repeatedly loses or mixes parts. Identical interchangeable fasteners may need only one bag. Drop the idea if an existing container works. No novelty, ESD, cleanliness, transport-rating or time-saving claim is established.

## Smallest practical design

Two original printed parts: a shallow rounded tray with four blind wells in a two-by-two arrangement and a lift-off lid. Each well holds one complete measured fastener set loosely. A short outer skirt locates the lid; its underside meets the tray rim and dividers so thin washers cannot migrate between wells. One ordinary removable elastic band retains the lid in an exterior groove. Closure and migration resistance remain unverified.

A thumb recess exposes the lid edge for opening above a clear bench. Finger access and rounded well floors should let the smallest part lift out without tipping the tray. Keep the cassette on a clear work surface away from equipment openings. It has no rack attachment, magnets, hinge, printed spring latch, thread engagement or device support. The four wells are a bounded first concept, not an assumption that every rack device has four fasteners. Decline it if the actual job does not benefit from four sets.

This differs from the RC wing fastener bench dock: it encloses removed rack hardware for transfer rather than parking a wing fastener at the assembly bench. It also differs from the cable saddle, adapter cradle, connector paddle, termination nest and shelf liner. A generic open screw tray previously lacked a specific advantage; covered transfer and mixed-material set matching are the hypothesis that must earn this version a place.

## Parametric approach after approval

Build a rounded rectangular OpenSCAD tray, subtract four rounded blind wells, and generate the lid from the same rim/divider layout. Keep named millimeter parameters at the top for well length/width/depth, floor and wall thickness, divider width, corner radii, lid thickness, skirt depth, lateral fit allowance, closed vertical gap, thumb access and band groove dimensions. Label wells with shallow numeric marks only if set identity matters. Measure the largest loose arrangement and the smallest loose part; do not assume screw sizes or washer thickness.

Guard positive continuous floors, dividers and walls, adequate lid/skirt joins, feasible radii, intact band grooves and loose hardware clearance. Check the proposed maximum assembled gap against the smallest part dimension in every possible escape path. That geometric check cannot establish a printed seal or retention. Export a short same-source rim/divider/lid fit coupon first. Keep exports ignored and document actual print settings if implementation is approved.

## Material, hardware and measurements

PLA is a candidate for a cool indoor bench fit prototype; PETG is an alternative if measured conditions justify it. Neither establishes ESD behavior, cleanliness, impact strength or heat resistance. One existing elastic band is the only added hardware. Its tension, groove seating and ageing need physical checks. Inspect the slicer for lid/skirt overhangs, band-groove bridges, layers and accessible well floors before choosing orientation or claiming support-free printing.

Measure the actual complete sets, screw length/head/thread envelopes, washers and nuts, smallest loose part thickness, finger access, desired transfer distance and motion, storage envelope, band width/thickness/tension, room/storage conditions and printer dimensional error. Determine whether the mounting nuts should remain on the rack under the actual procedure; only hardware deliberately removed goes in the cassette. Keep captive washers and retained assemblies together; never remove rack hardware merely to populate the organizer. Confirm that four separate sets matter and record the current loss/mixing frequency. Do not copy commercial geometry.

## Acceptance and physical validation after approval

- Establish a repeated transfer problem and compare the existing bag/box/mat methods before CAD approval. Agree a useful reduction in dropped or mixed parts and acceptable whole-task time. Stop if ordinary containers already meet it.
- Export tray, lid and coupon as finite, closed, connected, consistently wound, nondegenerate positive-volume meshes. Check pocket count, remaining floors, divider continuity, lid seating and escape-path dimensions. Exercise meaningful valid/invalid cases and deliberately wrong pocket/divider/gap cases. Mesh checks do not prove assembly retention.
- Inspect slicing and print the coupon before full parts. Fit without force. Use spare hardware over a clear catch tray, then check every well with the smallest loose part, lid seated and band fitted. Test normal carrying, gentle inversion and tilting in each direction. Reject escape, inter-well migration, lid lift, band slip, binding, cracks, hardware wedging, unwanted marks or plastic debris. No drop/shock rating is inferred.
- Compare ten matched remove-store-transfer-retrieve-reassemble rehearsals per method with spare hardware on a bench mockup, alternating order and keeping part counts and route equal. Preserve the actual hardware manufacturer's support/removal procedure. Count the original pieces before and after each trial. Record missing/mixed/dropped parts, retries, loading/retrieval and total time. If the strongest baseline has no failures, leave loss/mixing improvement unestablished; a short failure-free comparison cannot demonstrate a reliability advantage. Limit mockup findings to the tested rehearsal. Keep fabrication and first-use setup separate from recurring time, and retain the first-use total. Do not deliberately leave equipment unsupported to perform a comparison.
- Perform 20 additional opening/closing/band cycles and repeat the migration checks. Inspect lid seating, divider edges, debris, band wear and permanent deformation. Record conditions and limit any use claim to what was tested. Without the strongest available container sample, do not claim to outperform it.

No CAD, slicer, print, fit, closure, migration, wear or usefulness evidence exists. The next decision is whether an actual recurring fastener-transfer problem survives the ordinary-container comparison and warrants measurements plus separate CAD approval.
