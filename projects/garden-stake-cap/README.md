# Garden Stake Cap

A disc-shaped cap that slides over a garden stake and gives you tie-off
holes around the rim for connecting plant support string.

## Fit

- Designed for stakes ~0.45 in (11.43 mm) diameter — **measure your actual
  stakes with calipers before printing**, they vary by brand/batch.
- `fit_clearance` (default 0.4 mm) sets how loose/tight the slide-on fit
  is. Too tight or too loose after a test print? Adjust it in
  `garden-stake-cap.scad` and reprint.

## Print settings

- Material: PETG recommended (better UV/moisture resistance outdoors than
  PLA, which will embrittle over a season or two in the sun).
- Layer height: 0.2 mm
- Infill: 20–30% (light functional load from string tension only)
- Orientation: **disc face down on the bed, sleeve pointing up.** This
  avoids all overhangs — no supports needed. Flip it over for actual use
  (sleeve slides down over the stake).
- Supports: none, with the orientation above.

## Notes

- Includes a small vent hole through the disc into the (blind) stake
  socket so trapped air doesn't stop the cap from seating fully.
- 8 tie holes (3.5 mm) evenly spaced around the rim by default.
- 8 triangular gussets brace the disc to the sleeve, one in each gap
  between tie holes, so string tension doesn't snap the disc off at that
  joint. They're sloped at 45° so they stay self-supporting in the
  disc-down/sleeve-up print orientation above.
