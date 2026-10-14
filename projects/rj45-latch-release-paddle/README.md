# RJ45 latch-release paddle

An original parametric prototype for depressing one ordinary Ethernet plug latch from the cable side. The other hand withdraws the plug by its body. The tool is one piece: a short broad grip, solid narrowed neck, rounded latch pad and a lower shoulder that locates against a firm external plug-body face.

All defaults are **UNMEASURED EXAMPLE dimensions**, in millimeters. They do not represent an RJ45 standard or a verified plug family. Replace them with measurements from a spare connector and its prescribed release method. The shoulder bounds forward reach only. It does not limit pressure or downward latch travel. No fit, strength, non-marring, electrical or ESD suitability is established.

## Coordinate and contact contract

The source models the tool in its initial contact alignment, before depression. +X advances from the cable toward the socket; -Z depresses the latch; Y spans its width. The neck root is X=0, the main underside is Z=0 and the tool centerline is Y=0. The neck occupies X=0..20 in the example. The handle overlaps it through X=3.

```text
Side view, Y=0, initial contact alignment (mm; not to scale)
                           +X, cable side toward socket ->
  handle / neck Z=0..3    =====================
  underside Z=0          _________|__       ___
                                 |  |     (pad) bottom Z=-1.5
  firm datum Z=-4.5..-3         |  |       latch contact
  shoulder bottom Z=-5           |__|
  X:                     0      9.5 12     15   22     26
                                    ^                   ^
                         firm body datum face      socket-mouth plane
                         shoulder forward face
  Press direction: -Z. Shoulder slides down the firm face during depression.
```

Measure a firm accessible body face that opposes +X motion, below and behind the exposed latch. Its face becomes X=`shoulder_position` and must have a centered contact band described by `datum_band_bottom`, `datum_band_top` and `datum_contact_width`. A soft boot or cable jacket is not a datum. The example shoulder's front face is X=12, with a flat region across Y=-3.3..3.3. Its vertical extent is Z=-5..3. A measured firm band Z=-4.5..-3, width 6, fits that face. Its rounded side corners do not provide the stop datum. For this simple interface, measure the firm face upper edge and confirm firm body material below the pad path has no higher top. The code requires that edge below the fully depressed pad by `contact_margin`; the example pad bottom reaches Z=-2.3 and the body top is no higher than Z=-3. Reject a different body profile or an obstruction that violates this clearance. Measuring a convenient lower band while ignoring a higher body surface is insufficient.

Measure the exposed latch contact window along X from that face. The example window is X=14..23 and width 6; the whole pad, X=15..22 and width 5, has a 0.5 margin. `pad_drop` equals `latch_plane_drop` at initial contact. The XYZ-rounded pad has a flat bottom core X=15.7..21.3, Y=-1.8..1.8 at Z=-1.5. Its neck overlap is 5 mm. Measure `latch_release_travel` to describe the downward stroke; the example is 0.8. These values describe alignment and access, not an allowable applied force.

Measure the nearest socket-mouth plane from the firm datum: X=`shoulder_position + socket_mouth_distance`, which is 26 in the example. Set `allowed_insertion_depth` to a smaller permitted forward reach from the datum, which is 12 here. All tool material reaches at most X=22, or 10 ahead of the datum. The code requires that reach to be within the permitted depth and that the permitted depth leave at least `socket_clearance` behind the mouth. Never insert the paddle into the socket or contact electrical contacts.

The measured narrow approach corridor begins at `approach_start` along X. It is centered in Y, has width `approach_gap`, and extends from Z=-`approach_depth` to Z=`approach_height`. Measure this empty corridor with adjacent plugs, boots, cables, LEDs and any recess present. Include the entire withdrawal path and the second hand's access to the plug body. The code checks side margins and the downward swept envelope through `latch_release_travel`. The broad grip ends before this corridor; hand access behind it requires a separate physical check. The shoulder must disengage freely when the plug moves toward -X.

Reject this interface if there is no firm accessible datum, the pad is hidden or obstructed, the neck would need an impractically thin section, the shoulder catches during withdrawal, both hands cannot reach, or release requires levering on the port face. Use only the intended latch contact. Do not pull the cable jacket.

The neck must extend at least `minimum_section` beyond `pad_start+edge_radius`,
the rear of the rounded pad's flat contact core. Nominal overlap at the rear
edge alone can leave a detached pad when the corner radius is large.

## Parameters and example values

All parameters are at the source top. Radius and section minimums are geometry choices for this example, not validated printer or strength limits.

| Parameters | Example | Meaning |
| --- | --- | --- |
| `handle_length`, `handle_width`, `handle_thickness` | 35, 22, 3 | Full grip; X=-32..3 |
| `neck_length`, `neck_width`, `neck_thickness` | 20, 7, 3 | Solid neck; X=0..20 |
| `junction_overlap`, `minimum_section`, `edge_radius` | 3, 2, 0.7 | Grip overlap, retained sections, rounded edges |
| `pad_length`, `pad_width`, `pad_offset`, `pad_drop` | 7, 5, 3, 1.5 | Pad rear is shoulder X + offset; drop below underside |
| `shoulder_position`, `shoulder_length`, `shoulder_width`, `shoulder_height` | 12, 2.5, 8, 5 | Stop forward plane, rearward thickness, width, downward extent |
| `latch_contact_start`, `latch_contact_end`, `latch_contact_width` | 2, 11, 6 | Exposed window relative to firm face; centered Y |
| `latch_plane_drop`, `latch_release_travel`, `contact_margin` | 1.5, 0.8, 0.5 | Initial latch plane, downward stroke, contact-window margin |
| `datum_band_bottom`, `datum_band_top`, `datum_contact_width` | -4.5, -3, 6 | Firm body face band at initial alignment |
| `socket_mouth_distance`, `allowed_insertion_depth`, `socket_clearance` | 14, 12, 2 | Mouth plane and permitted reach from datum |
| `approach_start`, `approach_gap`, `approach_height`, `approach_depth` | 4, 10, 5, 6.5 | Narrow approach corridor in tool coordinates |
| `side_clearance`, `vertical_clearance` | 0.5, 0.5 | Corridor margins including depression stroke |
| `coupon_grip_length`, `coupon_grip_width` | 16, 18 | Shorter grip with same contact geometry |
| `part`, `$fn` | `"tool"`, 40 | `"tool"` or `"contact_coupon"`; curve tessellation |

Guards reject nonpositive dimensions/clearances, erased rounded profiles, inadequate retained neck and junction sections, unsupported shoulder or pad overlap, out-of-window contact, mismatched latch plane, excessive reach and a blocked approach corridor. They check the declared geometric envelope. They cannot establish that the measurements are accurate or that this is a suitable release method.

## Export and parameter checks

From the repository root, using the installed OpenSCAD executable:

```sh
/Applications/OpenSCAD-2021.01.app/Contents/MacOS/OpenSCAD --export-format asciistl -o projects/rj45-latch-release-paddle/exports/contact-coupon.stl projects/rj45-latch-release-paddle/contact-coupon.scad
/Applications/OpenSCAD-2021.01.app/Contents/MacOS/OpenSCAD --export-format asciistl -o projects/rj45-latch-release-paddle/exports/tool.stl projects/rj45-latch-release-paddle/rj45-latch-release-paddle.scad
```

The wrapper selects `part="contact_coupon"` in the same source. It shortens only the grip, from X=-32..3 to X=-13..3, and narrows the grip to 18. It keeps the same neck, pad, shoulder and datums, leaving a grip clear of the contact region. Both meshes stay in the same coordinate frame. Generated exports are ignored; retain editable SCAD and regenerate.

Use `-D` definitions before the source path. For example, this is a smaller unmeasured example case, not an alternative tested plug fit:

```sh
/Applications/OpenSCAD-2021.01.app/Contents/MacOS/OpenSCAD --export-format asciistl -o projects/rj45-latch-release-paddle/exports/small-example.stl -D 'handle_length=28' -D 'handle_width=18' -D 'neck_width=6' -D 'pad_width=4' -D 'shoulder_width=7' -D 'datum_contact_width=5' -D 'latch_contact_width=5' projects/rj45-latch-release-paddle/rj45-latch-release-paddle.scad
```

| Case definitions in addition to defaults | Expected result |
| --- | --- |
| No overrides, both part selectors and wrapper | Closed connected tool/coupon meshes; shared contact geometry |
| Small example shown above | Valid narrower geometry with retained contact margins |
| `handle_length=42`, `handle_width=26`, `neck_width=8`, `pad_width=6`, `shoulder_width=9`, `latch_contact_width=7`, `datum_contact_width=7`, `approach_gap=11` | Valid wider example |
| `part="unknown"` | Reject selector |
| `pad_length=0` | Reject positive dimensions |
| `neck_thickness=1` | Reject retained solid section |
| `junction_overlap=1` | Reject grip junction |
| `edge_radius=1.3` | Reject erased shoulder inner profile |
| `pad_offset=1` | Reject pad outside exposed contact window |
| `neck_length=16` | Reject inadequate pad overlap |
| `shoulder_height=4` | Reject datum coverage |
| `datum_band_top=-1` | Reject body datum overlapping latch level |
| `allowed_insertion_depth=9` | Reject excessive forward reach |
| `socket_mouth_distance=13` | Reject insufficient socket clearance |
| `approach_gap=8` | Reject neighbor clearance |
| `approach_depth=6` | Reject swept vertical clearance |
| `pad_drop=2` | Reject mismatched contact alignment |

For rejection cases, require the intended assertion in the OpenSCAD diagnostics. A CSG export can exit zero after an assertion; an exit code alone is insufficient. Mesh validation must check finite, closed, connected, consistently wound, nondegenerate triangles and actual bounds. A rendered preview is provided in `preview.png`; it shows example geometry only.

## Print and bench checks

Print the contact coupon first. Starting settings are a 0.4 mm nozzle, 0.20 mm layers, 4 walls and 100% infill. PLA can serve for a cool fit coupon; PETG is a candidate for an indoor tool. Neither material's stiffness, fatigue, contact wear or equipment suitability has been tested.

Try the broad grip/neck plane parallel to the bed, with the contact protrusions facing upward so the neck stays in the bed plane. With the defaults, the common upper plate surface Z=3 can be rotated to face the bed. If you increase grip thickness above neck thickness, this orientation can leave a gap under the neck that needs supports. Inspect the rounded pad transitions for overhangs and supports in the actual slicer layers. Choose support placement that avoids damaging the contact face; remove any residue and inspect all contact edges before use. No support-free print or slicer result is claimed. Do not print a weak neck to obtain clearance.

1. Record the equipment model, actual plug/boot family, handling requirements, release method, measurements, printer, filament, temperature and service task. Try finger access and an existing blunt plastic tool first. Moving an ordinary service loop may resolve the access problem. If a simpler method works comfortably, keep it.
2. Test the coupon on a spare cable and unpowered spare port with representative neighbors. Confirm pad position visually or unambiguously on the spare connector. Confirm the intended shoulder face locates on the firm body datum, stays outside the socket through the full stroke and leaves freely during body withdrawal. Stop on scraping, wedging, forced depression or contact outside the latch. Inspect tool, latch spring-back, boot and port face for marks.
3. Print the handle only after the coupon fits. On the same bench arrangement check full reach, grip, neck flex, body grip by the other hand and withdrawal clearance. Do not lever against the port face.
4. Before timing, choose the improvement target and observation resolution. Run ten paired remove/reinsert trials per method, alternating order, comparing finger access, the existing blunt tool and this paddle. Record release time, failed attempts, neighboring-plug movement and contact marks. Accept only if the chosen outcome improves without worse results on the others. If the baseline is equally useful, retain it and stop.
5. Run twenty further gentle release cycles on the same connector, support arrangement, contact point and effort protocol. Record latch return, tool flex, pad/junction wear and plug/port damage. Stop on cracking, slipping, permanent deformation or unreliable re-latching. Measure effort if a suitable instrument is available; otherwise record handling observations without a strength claim. Visual checks do not establish network performance.

Across **every physical trial**, reject new plug/port damage, unintended neighboring release or unreliable re-latching, regardless of baseline performance. A faster release cannot offset these failures.

Excluded: security, locking or proprietary release connectors, fiber connectors, socket/contact entry, port-face levering, cable-jacket pulling, grippers, multi-port combs and permanent mounts. No downloaded/copied CAD or externally generated code was used. Digital validation proves geometry only. Slicer, print, contact fit, latch life, port protection and usefulness remain unverified.
