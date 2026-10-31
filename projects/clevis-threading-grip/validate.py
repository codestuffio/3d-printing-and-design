#!/usr/bin/env python3
"""Export and check clevis grip geometry. Real-fitting contact remains unverified."""
import argparse
import hashlib
import importlib.util
import json
import math
from pathlib import Path
import sys
import tempfile

sys.dont_write_bytecode = True
PROJECT = Path(__file__).resolve().parent
ROOT = PROJECT.parents[1]
sys.path.insert(0, str(ROOT / "scripts"))
from validate_sliding_rc_stand import resolve_openscad
from validate_pr16_tools import metrics, ray, require_ray

ADAPTER = ROOT / "projects/rc-hardware-cassette/validate.py"
spec = importlib.util.spec_from_file_location("cassette_renderer", ADAPTER)
renderer = importlib.util.module_from_spec(spec)
spec.loader.exec_module(renderer)
SOURCE = PROJECT / "clevis-threading-grip.scad"
DEFAULTS = dict(flat_spacing=5.5, flat_clearance=.15, contact_depth=2.4,
                entry_chamfer=.25, arm_clearance_radius=6.5, head_radius=9,
                handle_length=44, handle_width=14, handle_thickness=5.5,
                handle_corner_radius=3, minimum_wall=1.8, coupon_back=12,
                layout_gap=8, cut_epsilon=.02, **{"$fn": 96})


def geometry(path, p, part):
    mesh, result = metrics(path)
    gap = p["flat_spacing"] + 2*p["flat_clearance"]
    h = gap/math.sqrt(3)
    radius = p["head_radius"]
    depth = p["contact_depth"]
    thick = p["handle_thickness"]
    relief = p["arm_clearance_radius"]
    left = -p["coupon_back"] if part == "contact_coupon" else -p["handle_length"]
    expected = [[left, -radius, 0], [math.sqrt(radius**2-(gap/2)**2), radius, thick]]
    if any(abs(a-b) > .07 for actual,want in zip(result["bounds_mm"],expected)
           for a,b in zip(actual,want)):
        raise ValueError("Bounds differ from independent dimensional fixture")
    require_ray(mesh, (0, 0, depth/2), [-radius, -gap/2, gap/2, radius], 1)
    require_ray(mesh, (0, .0, depth/2), [left, -h], 0)
    x = -.75*h
    outside = math.sqrt(radius**2-x*x)
    require_ray(mesh, (x, 0, depth/2), [-outside, -gap/4, gap/4, outside], 1)
    for x in (0, h+.4, radius-.2):
        for y in (-gap/2+.1, .11, gap/2-.1):
            require_ray(mesh, (x,y,0), [])
    if thick > depth:
        z = (thick+depth)/2
        require_ray(mesh, (0,0,z), [-radius,-relief,relief,radius], 1)
        y = (gap/2+p["entry_chamfer"]+relief)/2
        circle_exit = math.sqrt(relief**2-y*y)
        head_exit = math.sqrt(radius**2-y*y)
        for x in (0, relief/2, (circle_exit+head_exit)/2):
            for sign in (-1, 1):
                require_ray(mesh, (x,sign*y,0), [0,depth])
        require_ray(mesh, (0,.13,z), [left,-math.sqrt(relief**2-.13**2)], 0)
    y = gap/2+p["entry_chamfer"]/2
    hits = ray(mesh, (radius*.45,y,0))
    c = p["entry_chamfer"]
    if (len(hits) != 2 or not c/4 < hits[0] < c or
            not depth-c < hits[1] < depth-c/4):
        raise ValueError("Jaw entry chamfers missing or wrong contact depth")
    result["features"] = dict(flat_gap_mm=gap, hex_back_mm=h,
                              axial_contact_mm=depth, arm_relief_radius_mm=relief,
                              release_path_samples=9, chamfer_checked=True)
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--openscad", help="OpenSCAD executable name or path")
    parser.add_argument("--output-dir", type=Path, help="New evidence directory; must not exist")
    args = parser.parse_args()
    exe = resolve_openscad(args.openscad)
    if not exe:
        parser.exit(1, "OpenSCAD executable unavailable.\n")
    try:
        out = args.output_dir.resolve() if args.output_dir else Path(tempfile.mkdtemp(prefix="clevis-grip-"))
        if args.output_dir:
            out.mkdir(parents=True, exist_ok=False)
        sources = [SOURCE, Path(__file__).resolve(), ADAPTER,
                   ROOT/"scripts/validate_sliding_rc_stand.py", ROOT/"scripts/validate_pr16_tools.py"]
        hashes = {str(f.relative_to(ROOT)):hashlib.sha256(f.read_bytes()).hexdigest() for f in sources}
    except OSError as error:
        parser.exit(1, str(error)+"\n")
    cases = []

    def run(name, part="grip", overrides=None, extension="stl", assertion=None, pinned=True):
        params = DEFAULTS | (overrides or {})
        values = (params if pinned else {}) | {"part":part}
        result = renderer.run_case(exe, SOURCE, out, name,
                                   [k+"="+json.dumps(v) for k,v in values.items()], extension, assertion)
        if result["passed"] and extension == "stl":
            try:
                result["geometry"] = geometry(out/(name+".stl"), params, part)
            except (OSError, ValueError) as error:
                result.update(passed=False, failure=str(error))
        cases.append(result)
        print(("PASS " if result["passed"] else "FAIL ")+name, flush=True)
        return result

    for part in ("grip", "contact_coupon"):
        run("default-"+part, part, pinned=False)
    for label, params in [("small", dict(flat_spacing=4.5, contact_depth=1.8, entry_chamfer=.2)),
                           ("large", dict(flat_spacing=7, contact_depth=3.2, arm_clearance_radius=7.5,
                                          head_radius=11, handle_width=16, coupon_back=14)),
                           ("close-fit", dict(flat_clearance=.08))]:
        for part in ("grip", "contact_coupon"):
            run(label+"-"+part, part, params)
    run("layout", "layout", extension="csg")
    invalid = [
        ("unknown", {"part":"bad"}, "Unknown part"),
        ("negative-flat", {"flat_spacing":-1}, "Flat size and clearance"),
        ("no-clearance", {"flat_clearance":0}, "Flat size and clearance"),
        ("loose-flat", {"flat_clearance":1}, "Flat size and clearance"),
        ("thin-contact", {"contact_depth":.5}, "Contact depth and handle"),
        ("short-handle-height", {"handle_thickness":2}, "Contact depth and handle"),
        ("erased-contact", {"entry_chamfer":1.2}, "Chamfer must leave"),
        ("thin-wall", {"minimum_wall":.2}, "Jaw must retain"),
        ("small-head", {"head_radius":5}, "Jaw must retain"),
        ("small-relief", {"arm_clearance_radius":3}, "Arm relief must clear"),
        ("large-relief", {"arm_clearance_radius":8}, "Arm relief must clear"),
        ("narrow-handle", {"handle_width":2}, "Handle must retain width"),
        ("large-corner", {"handle_corner_radius":8}, "Handle must retain width"),
        ("short-handle", {"handle_length":16}, "Handle must extend"),
        ("short-coupon", {"coupon_back":8}, "Coupon must preserve"),
        ("low-resolution", {"$fn":24}, "Layout, resolution")]
    for name, params, message in invalid:
        run(name, params.get("part", "grip"), params, "csg", message)

    default = out/"default-grip.stl"
    for label, wrong in [("flat", {"flat_spacing":6}), ("depth", {"contact_depth":2.8}),
                          ("relief", {"arm_clearance_radius":6}), ("chamfer", {"entry_chamfer":.45})]:
        result = dict(name="reject-wrong-"+label, passed=False)
        if not any(c["name"] == "default-grip" and c["passed"] for c in cases):
            result["failure"] = "Requires a validated default export"
        else:
            try:
                geometry(default, DEFAULTS | wrong, "grip")
            except ValueError:
                result["passed"] = True
            except OSError as error:
                result["failure"] = str(error)
        cases.append(result)

    for name, module in [("closed-mouth", "module jaw_profile(extra=0) { difference() { offset(delta=extra) union() { polygon([for(a=[0:60:300]) [hex_radius*cos(a),hex_radius*sin(a)]]); translate([0,-jaw_spacing/2]) square([head_radius+cut_epsilon,jaw_spacing]); } translate([hex_radius+.2,-jaw_spacing]) square([.8,2*jaw_spacing]); } }"),
                         ("blocked-relief", "module relief_profile() { difference() { union() { circle(r=arm_clearance_radius); translate([0,-arm_clearance_radius]) square([head_radius+cut_epsilon,2*arm_clearance_radius]); } translate([-1,jaw_spacing/2+.3]) square([2,arm_clearance_radius-jaw_spacing/2]); } }"),
                         ("asymmetric-exit", "module relief_profile() { union() { circle(r=arm_clearance_radius); translate([0,-jaw_spacing/2]) square([head_radius+cut_epsilon,arm_clearance_radius+jaw_spacing/2]); } }"),
                         ("narrow-exit", "module relief_profile() { union() { circle(r=arm_clearance_radius); translate([0,-jaw_spacing/2]) square([head_radius+cut_epsilon,jaw_spacing]); } }")]:
        substitute = out/(name+".scad")
        substitute.write_text("include <"+str(SOURCE)+">\n"+module+"\n")
        result = renderer.run_case(exe, substitute, out, "reject-"+name,
                                   [k+"="+json.dumps(v) for k,v in DEFAULTS.items()], "stl")
        if result["passed"]:
            try:
                geometry(out/("reject-"+name+".stl"), DEFAULTS, "grip")
            except ValueError as error:
                result["passed"] = "Feature ray" in str(error) or "Jaw entry chamfers" in str(error)
                result["expected_feature_rejection"] = str(error)
            else:
                result.update(passed=False, failure="Wrong functional geometry accepted")
        cases.append(result)

    result = dict(name="coupon-contact-equivalence", passed=False)
    try:
        if not all(any(c["name"] == n and c["passed"] for c in cases)
                   for n in ("default-grip", "default-contact_coupon")):
            raise ValueError("Requires validated full and coupon exports")
        full, _ = metrics(default)
        sample, _ = metrics(out/"default-contact_coupon.stl")
        for x in (-8, -5, -2, 0, 3, 6):
            for y in (-7, -4, -.13, 4, 7):
                a, b = ray(full, (x,y,0)), ray(sample, (x,y,0))
                if len(a) != len(b) or any(abs(u-v) > .06 for u,v in zip(a,b)):
                    raise ValueError("Coupon contact differs from full grip")
        result["passed"] = True
    except (OSError, ValueError) as error:
        result["failure"] = str(error)
    cases.append(result)
    cases.append(dict(name="sources-unchanged", passed=all(
        hashlib.sha256((ROOT/name).read_bytes()).hexdigest() == digest for name,digest in hashes.items())))
    report = dict(passed=all(c["passed"] for c in cases), cases=cases, source_sha256=hashes,
                  openscad=exe, physical_fit_grip_damage_wear_and_usefulness_verified=False)
    (out/"summary.json").write_text(json.dumps(report, indent=2)+"\n")
    print("Evidence: "+str(out)+". CAD checks only; measure a spare fitting and print the coupon first.")
    return 0 if report["passed"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
