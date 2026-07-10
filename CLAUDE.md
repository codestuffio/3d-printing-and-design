# CLAUDE.md

Repo for OpenSCAD source and 3D-print exports. See [README.md](README.md) for layout.

## Conventions

- Units: millimeters throughout.
- One project per folder under `projects/<name>/`, source file named `<name>.scad`.
- Parametrize dimensions at the top of each `.scad` file (don't hardcode magic numbers inline).
- Exports live in `projects/<name>/exports/` and are gitignored — regenerate via the `openscad` CLI rather than committing STLs.
- Each project folder has its own `README.md` noting print settings (layer height, infill %, orientation, supports, material) and any fit tolerances used.
- Shared libraries (BOSL2, NopSCADlib, etc.) live in `libraries/` as git submodules, not copy-pasted.
