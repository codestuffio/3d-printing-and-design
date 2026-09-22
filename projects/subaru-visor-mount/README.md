# Subaru visor mount

Editable OpenSCAD reconstruction of the supplied `SubaruVisorMount.STL`.
The model uses native OpenSCAD shapes; it does not import or depend on that STL.
All dimensions are millimeters, inferred from the mesh's scale.

Open `subaru-visor-mount.scad` in OpenSCAD. F5 previews; F6 renders; then export
STL. The default preserves the original dimensions rather than automatically
thickening the socket. The source needs no external libraries.

## Measured features

| Feature | Value |
| --- | ---: |
| Overall reconstructed size | 57.658 × 39.887 × 18.739 mm |
| Mounting-hole center spacing | 34.798 mm |
| Screw through-hole diameter | 5.969 mm |
| Underside counterbore diameter / depth | 11.2776 / 4.953 mm |
| Plate thickness | 7.620 mm |
| Socket tilt from vertical | 19° |
| Socket outside diameter | 15.240 mm |
| Main bore diameter | 11.2776 mm |
| Diameter across internal lands | 10.4648 mm |
| Retaining opening diameter | 9.2456 mm |
| Retaining lip axial thickness | 2.032 mm |
| Four rounded slots, width | 2.286 mm |

The socket has a through-bore with four relieved sectors, a smaller opening at
the tip, and four flexible fingers. Its axis leans toward the screw holes.
Socket heights and slot positions are measured along that tilted axis.

The triangular plate's large lower edge round is reconstructed with 24 sections.
Small rounds at the three underside openings are approximated with chamfers;
the tilted bore exit is also an approximation. The rib outline is reconstructed
from measured tangencies. This is a close reconstruction, not an exact CAD
conversion or a claim that the source design fits every Subaru.

## Adjusting it

- `socket_extra_wall = 0`: original socket outer diameter. Try `0.5` for 0.5 mm
  added radially outward (1 mm larger diameter). Bore, slots, and retaining lip
  opening stay unchanged. Check clearance and insertion force; extra stiffness
  can prevent the fingers from snapping over the shaft.
- `rib_height` and `rib_width`: change the low triangular reinforcing ribs.
- `plate_bottom_round = 0`: removes the large underside edge round and increases
  first-layer area. This changes the outer seating envelope; verify vehicle fit.
- `section_view = true`: cuts away half the model for internal inspection.
  Set it back to `false` before exporting a printable part.

The parameters are intended for small fit and reinforcement adjustments, not
arbitrary rescaling or a family of unrelated mounts. No automatic fit allowance
is added to the measured holes. Calibrate hole sizing on your own printer and
avoid scaling the whole part, which also changes mounting-hole spacing.

## Starting print setup

For an Ender 3 with Sprite extruder and a 0.4 mm nozzle: PETG, 0.20 mm layers,
6 walls, about 1.2 mm top/bottom thickness, and 50% infill. Check that the socket
walls slice solid. Use dry filament and its manufacturer's temperature profile.

The export is already plate-down, with the socket upward. Check support needs
in the slicer: the rounded plate underside expands quickly near the first layer,
and the two underside counterbores have horizontal shoulders. A brim may help
adhesion; it does not replace support beneath overhangs. Avoid support inside the
socket if possible, since removal could damage the fingers. The tilted lip also
needs inspection in layer preview.

Begin with a fit print. Check screw seating, shaft insertion, retention, and full
visor movement. This model has not been printed, mechanically tested, or
heat-tested. PETG may relax under sustained load in a hot vehicle; a sound STL
alone does not establish long-term strength or retention.

## Export

```sh
openscad -o exports/subaru-visor-mount.stl subaru-visor-mount.scad
```

For an experimental thicker socket:

```sh
openscad -D 'socket_extra_wall=0.5' -o exports/subaru-visor-mount-thicker.stl subaru-visor-mount.scad
```

On this Mac the executable is
`/Applications/OpenSCAD-2021.01.app/Contents/MacOS/OpenSCAD`.
Exports are generated files and are ignored by Git.

## Verification

The default model rendered successfully in OpenSCAD 2021.01 and its STL was
checked as one connected, watertight solid with consistent winding. Its volume
is 11,259.55 mm³ versus 11,308.88 mm³ for the supplied STL (about 0.44% less).

With the meshes aligned, 15,000 surface samples in each direction had median
nearest-surface distances of about 0.0012 mm. The 95th percentiles were 0.0444 mm
(original to recreation) and 0.0351 mm (recreation to original). Maximum sampled
difference was about 0.64 mm, principally at the approximated underside entries.
This sampling checks geometric similarity; it is not a maximum-error guarantee
or a fit/strength test. Functional dimensions were separately derived from
cross-sections and planar faces of the original mesh.

No software unit-test suite applies to this standalone CAD artifact. Verification
uses actual OpenSCAD rendering, mesh checks, dimensional comparison, and visual
inspection instead.
