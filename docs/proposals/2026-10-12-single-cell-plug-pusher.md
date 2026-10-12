# Single-cell seedling plug pusher

Date: 2026-10-12. Category: gardening. Proposal only; CAD implementation requires separate approval.

## Use and practical problem

Loosen one established seedling plug through the drain hole of one measured cell tray before lifting the plug by its soil/root mass. The proposed tool offers a broad hand contact and a bounded tip projection when finger access underneath a cell is awkward. It assists loosening; it does not eject a whole tray or guarantee intact roots.

Actual recurring difficulty, tray ownership and benefit are unconfirmed. First compare normal tray flexing/hand removal with a blunt dowel sized to the drain hole. If either is comfortable and causes no extra damage, a print may add little value.

[Bootstrap Farmer's plug poppers](https://www.bootstrapfarmer.com/collections/plug-trays/products/plug-poppers) establish this tool category. Their tools fit their own trays, and the manufacturer warns that cell sizes, spacing and drain-hole centers vary. It also identifies root establishment, growing medium and moisture as factors in removal. That grounds the task and fit dependency, not the performance of this proposed print. No novelty claim or borrowed CAD is intended.

## Smallest practical design

One handheld piece with a broad palm pad, a short blunt pin and a rounded shoulder around the pin. Approach from below while supporting the tray; gently loosen one plug, then support and remove it from above. The shoulder must meet a measured, firm underside contact land before excessive pin insertion. It limits geometric projection only while the tray remains undeformed.

Use one pin so array spacing and multi-cell registration are unnecessary. Keep the pin short and its contact face broad enough for the actual hole and plug. Exclude springs, sharp tips, clamps, multi-pin arrays, tray supports and seed-placement functions from the first design.

Reject this interface if ribs, recessed holes, fragile plastic or an unsupported tray prevent broad shoulder contact. Existing hand/bench support must keep the tray stable and underside alignment visible; reject if operation requires a new support fixture. A shoulder pressing a thin cell bottom can deform it; it is not a force limiter. The user must stop if the plug resists or the tray bends. If the measured hole cannot admit a sufficiently broad contact tip, use another removal method rather than a narrow spike.

## Parametric OpenSCAD approach after approval

Use named top-level dimensions in millimeters for tip diameter, tip edge radius, pin projection above the shoulder, shoulder diameter/profile, palm-pad diameter/thickness and junction radius. Build coaxial rounded profiles with a solid junction and accessible surfaces. Do not copy commercial geometry or assume a standard tray.

Keep drain-hole diameter/shape, underside recess and permissible insertion as measured inputs. Derive clearance explicitly. Assert positive dimensions, tip clearance, usable shoulder contact, bounded projection and adequate junction thickness. Export a small tip-and-shoulder fit coupon before a full handle. Check valid small/large measured interfaces and invalid interference, excessive projection, missing contact land and inadequate junction cases. Do not encode a universal safe stroke or load rating.

## Material, hardware and measurements

PETG is a candidate for a washable fit prototype; PLA may suffice for a cool dry fit coupon. Neither has verified cleaning, repeated-load, heat or outdoor durability here. The first design needs no hardware. Inspect layer orientation and the pin-to-pad junction in the slicer; choose orientation after the actual dimensions and load direction are known.

Measure or establish:

- Actual tray make/model, material, condition and whether the recurring removal problem exists.
- Drain-hole diameter/shape and center access, cell taper/depth, underside ribs/recess, firm shoulder contact area and space for the hand/pad.
- Tip clearance, useful loosening travel and maximum permissible projection for that tray/plug, accounting for tray flex and print variation.
- Representative crop, root establishment, growing medium/moisture, plug cohesion and current removal method.
- Printer/material capability, contact smoothness, cleaning routine and where the tool is stored.

The fit coupon verifies the tray interface only. It cannot establish suitable pressure on a living root mass or repeatable release.

## Acceptance and physical validation

Before implementation approval, confirm a real tray/task and record the blunt-dowel and ordinary-removal baseline. After approval, require a closed connected mesh with finite, consistently wound, nondegenerate triangles; verify bounds, pin/shoulder contact geometry and the valid/invalid parameter cases. Inspect the slicer for weak junctions, rough contact surfaces and supports that affect fit.

Print the coupon first. It must enter and withdraw without scraping or forced fit, seat on the intended shoulder land and preserve tray clearance. Then print one tool and test gently on spare cells/plugs before valuable seedlings. Record any tray deflection, puncture, cracking, plug breakup or root damage. Clean and dry it using the user's chosen process; inspect for retained soil, cracks and surface wear. Do not claim disinfection or compatibility with unspecified cleaning chemicals.

Compare at least ten matched plug removals per method from representative cells, alternating methods and recording moisture/root condition. Agree on a useful improvement target and observation resolution before testing. Measure removal time, attempts, plug breakup, visible root damage and tray deformation. Accept only if the chosen outcome improves without worsening the other outcomes. Visible inspection cannot establish later plant survival; make no transplant-success claim.

For twenty insertion/removal cycles, record the same support arrangement, projection, plug condition, push direction and effort protocol used in the successful trial. Measure push effort if a suitable instrument is available; otherwise record the qualitative effort and claim handling observations only, not quantified strength. Inspect pin alignment, shoulder wear, junction damage and tray marks. Reject if the shoulder slips, the tip gouges the plug, the tray distorts or the baseline is equally useful. There is currently no CAD, slicer, print, fit, strength, cleaning or utility evidence for this proposal.
