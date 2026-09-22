# Magnetic Plate Holder

This holder seats a nominal 4 x 4 x 3/16 in (101.6 x 101.6 x 4.7625 mm) steel
plate on one face. The opposite face has six circular pockets for nominal
1/2 x 1/4 in (12.7 x 6.35 mm) N52 disc magnets in a 37 mm-radius pattern.

The part has a 1/4 in (6.35 mm) printed backing plate. Its six magnet holes
go all the way through, so the installed magnets directly touch the steel
plate in its locating pocket. The pocket is intentionally slightly oversized
for ordinary FDM printing. To use a different square plate, change only
`steel_plate_width_in` and `steel_plate_thickness_in` in `dimensions.scad`;
both printable parts update automatically. Adjust the fit-clearance settings
after measuring the actual plate and magnets.

## Print settings

- Material: PETG is recommended; PLA also works for a cool, indoor use case.
- Orientation: print with the magnet-pocket face on the build plate.
- Layer height: 0.20 mm.
- Perimeters: 4 or more.
- Infill: 30% or more.
- Supports: none required.

Install the magnets from the back after printing; press them in until they
touch the steel plate. The holes default to a slight press fit. If your
printer makes holes tight, increase `magnet_hole_fit` toward zero; use a small
amount of CA glue or epoxy if the fit is loose. Test polarity against the
intended mating surface before gluing.

## Optional TPU protective sleeve

`protective-tpu-sleeve.scad` is a separate 0.6 mm-floor TPU bumper that slips
over the magnet face and protects the surface being mounted to. It provides a
soft barrier over the magnets, so expect a small reduction in magnetic holding
force. Print it in 95A TPU with the floor flat on the build plate, at 0.20 mm
layers, 3 perimeters, and 100% infill. Adjust `sleeve_fit_clearance` in that
file if it is too loose or too tight.

## Render / export

```
openscad -o projects/magnet-plate-holder/exports/magnet-plate-holder.stl \
  projects/magnet-plate-holder/magnet-plate-holder.scad

openscad -o projects/magnet-plate-holder/exports/protective-tpu-sleeve.stl \
  projects/magnet-plate-holder/protective-tpu-sleeve.scad
```
