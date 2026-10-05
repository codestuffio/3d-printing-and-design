# 3D Printing & Design

OpenSCAD sources and print-ready exports for 3D printing projects.

## Layout

```
projects/<name>/
  <name>.scad       # source, parametric where possible
  README.md         # print settings: layer height, infill, orientation, supports, material
  exports/          # generated .stl / .3mf (gitignored, regenerate from source)
  you can also all things like screenshots of rendered files, or the finished stl files of each part

libraries/           # shared OpenSCAD libraries (e.g. BOSL2), added as git submodules
```

## Rendering exports

Requires the `openscad` CLI on PATH.

```
openscad -o projects/<name>/exports/<name>.stl projects/<name>/<name>.scad
```

## Validating the sliding RC stands

For repeatable checks of both sliding RC stand hubs, run `python3 scripts/validate_sliding_rc_stand.py`. See the [sliding stand validation instructions](projects/sliding-x-rc-plane-stand/README.md#repeatable-local-validation) for requirements, parameter cases and evidence output.

## Adding a shared library

```
git submodule add https://github.com/BelfrySCAD/BOSL2.git libraries/BOSL2
```

Then in a `.scad` file: `include <BOSL2/std.scad>` (with `-I libraries` passed to openscad, or a symlink/`OPENSCADPATH` set to `libraries`).

## License

TBD — add a LICENSE file (e.g. CC-BY-SA for hardware/designs) before sharing publicly.
