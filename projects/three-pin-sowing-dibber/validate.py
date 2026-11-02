#!/usr/bin/env python3
"""Check three-pin dibber exports. Soil depth and usefulness need physical trials."""
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
SOURCE = PROJECT / "three-pin-sowing-dibber.scad"
DEFAULTS = dict(pitch=30, nominal_depth=10, pin_base_diameter=6, tip_diameter=3,
                tip_round=.6, shoulder_diameter=20, shoulder_thickness=3,
                spine_width=16, spine_thickness=5, grip_clearance=10,
                spine_corner_radius=4, label_height=.5, layout_gap=10, **{"$fn": 96})


def geometry(path, p, part):
    mesh, result = metrics(path)
    radius = p["shoulder_diameter"]/2
    z = p["spine_thickness"] + p["grip_clearance"]
    depth = p["nominal_depth"]
    half = radius if part == "contact_coupon" else p["pitch"]+radius
    expected = [[-half,-radius,0], [half,radius,z+depth]]
    if any(abs(a-b) > .06 for actual,want in zip(result["bounds_mm"],expected)
           for a,b in zip(actual,want)):
        raise ValueError("Bounds differ from independent dimensional fixture")
    centers = [0] if part == "contact_coupon" else [-p["pitch"],0,p["pitch"]]
    for x in centers:
        require_ray(mesh, (x+.13,.17,0), [0,z+depth])
        y = (radius+p["pin_base_diameter"]/2)/2
        hits = ray(mesh, (x+.11,y,0))
        if len(hits) < 2 or abs(hits[-1]-z) > .06:
            raise ValueError("Shoulder contact plane differs")
        for dz in (.1, (depth-p["tip_round"])/2):
            r = p["pin_base_diameter"]/2 + (p["tip_diameter"]-p["pin_base_diameter"])/2*dz/(depth-p["tip_round"])
            require_ray(mesh, (x+.11,0,z+dz), [-math.sqrt(r*r-.11**2),math.sqrt(r*r-.11**2)], 1)
        nose_radius = p["tip_diameter"]/2-p["tip_round"]+math.sqrt(
            p["tip_round"]**2-(p["tip_round"]-.001)**2)
        nose_half_width = math.sqrt(nose_radius**2-.13**2)
        require_ray(mesh, (x+.13,0,z+depth-.001), [-nose_half_width,nose_half_width], 1)
        require_ray(mesh, (x,0,z-.3), [-radius,radius], 1)
        neck = (p["spine_width"]/2-1)+(radius-(p["spine_width"]/2-1))*\
            (.5+.05)/(p["grip_clearance"]-p["shoulder_thickness"]+.1)
        require_ray(mesh, (x+.11,0,p["spine_thickness"]+.5),
                    [-math.sqrt(neck*neck-.11**2),math.sqrt(neck*neck-.11**2)], 1)
    section_radius = p["pin_base_diameter"]/2 + (p["tip_diameter"]-p["pin_base_diameter"])/2*.1/(depth-p["tip_round"])
    section_half_width = math.sqrt(section_radius**2-.11**2)
    crossings = ray(mesh, (0,.11,z+.1), 0)
    expected_section = [edge for x in centers for edge in (x-section_half_width,x+section_half_width)]
    if len(crossings) != len(expected_section) or any(
            abs(a-b) > .06 for a,b in zip(crossings,expected_section)):
        raise ValueError("Pin center section differs from pitch/taper fixture")
    measured_centers = [(a+b)/2 for a,b in zip(crossings[::2],crossings[1::2])]
    if part == "dibber":
        for x in (-p["pitch"]/2, p["pitch"]/2):
            hits = ray(mesh, (x,.13,0))
            if len(hits) != 2 or hits[-1] > p["spine_thickness"]+p["label_height"]+.06:
                raise ValueError("Cleaning gap is bridged above the spine")
            require_ray(mesh, (x,p["spine_width"]/2-1,0), [0,p["spine_thickness"]])
        label_width = p["pitch"]-2*(p["spine_width"]/2-1)-2
        for x in (-p["pitch"]/2, p["pitch"]/2):
            if not any(abs(v[0]-x) < label_width/2-.01 and abs(v[1]) < 2 and
                       v[2] > p["spine_thickness"]+p["label_height"]/2 and
                       abs(v[2]-p["spine_thickness"]-p["label_height"]) < .06
                       for triangle in mesh for v in triangle):
                raise ValueError("Raised settings label missing")
    for x in centers:
        r = p["tip_diameter"]/2-p["tip_round"]/2
        hits = ray(mesh, (x+r,0,0))
        if len(hits) != 2 or not z+depth-p["tip_round"] < hits[1] < z+depth-.02:
            raise ValueError("Rounded tip rim missing")
    result["features"] = dict(pin_count=len(measured_centers), actual_pin_centers_mm=measured_centers,
                              adjacent_pitches_mm=[b-a for a,b in zip(measured_centers,measured_centers[1:])],
                              nominal_penetration_mm=depth, shoulder_plane_mm=z)
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
        out = args.output_dir.resolve() if args.output_dir else Path(tempfile.mkdtemp(prefix="sowing-dibber-"))
        if args.output_dir:
            out.mkdir(parents=True, exist_ok=False)
        sources = [SOURCE, Path(__file__).resolve(), ADAPTER,
                   ROOT/"scripts/validate_sliding_rc_stand.py", ROOT/"scripts/validate_pr16_tools.py"]
        hashes = {str(f.relative_to(ROOT)):hashlib.sha256(f.read_bytes()).hexdigest() for f in sources}
    except OSError as error:
        parser.exit(1, str(error)+"\n")
    cases = []

    def run(name, part, params=None, extension="stl", assertion=None, source=SOURCE, pinned=True):
        p = DEFAULTS | (params or {})
        values = (p if pinned else {}) | {"part":part}
        result = renderer.run_case(exe, source, out, name,
                                   [k+"="+json.dumps(v) for k,v in values.items()], extension, assertion)
        if result["passed"] and extension == "stl":
            try:
                result["geometry"] = geometry(out/(name+".stl"), p, part)
            except (OSError, ValueError) as error:
                result.update(passed=False, failure=str(error))
        cases.append(result)
        print(f"{'PASS' if result['passed'] else 'FAIL'} {name}", flush=True)
        return result

    for name, params in [("default", {}),
                         ("small", dict(pitch=24, nominal_depth=5, shoulder_diameter=16,
                                        spine_width=12, spine_thickness=4, grip_clearance=8,
                                        shoulder_thickness=2.4, pin_base_diameter=5, tip_diameter=2.4, tip_round=.4)),
                         ("large", dict(pitch=45, nominal_depth=18, shoulder_diameter=26,
                                        spine_width=20, spine_thickness=6, grip_clearance=12,
                                        pin_base_diameter=8, tip_diameter=4)),
                         ("minimum-gap", dict(pitch=26))]:
        for part in ("dibber", "contact_coupon"):
            run(name+"-"+part, part, params, pinned=name != "default")
    run("layout", "layout", extension="csg")
    invalid = [
        ("unknown", {"part":"bad"}, "Unknown part"),
        ("overlap", {"pitch":19}, "cleaning gaps"),
        ("narrow-gap", {"pitch":25}, "cleaning gaps"),
        ("zero-depth", {"nominal_depth":0}, "Nominal depth"),
        ("pointed-tip", {"tip_diameter":0}, "Tip must retain"),
        ("erased-flat", {"tip_round":1}, "Tip must retain"),
        ("reversed-taper", {"pin_base_diameter":3}, "Pin taper"),
        ("narrow-bearing", {"shoulder_diameter":12}, "Pin taper"),
        ("thin-spine", {"spine_thickness":1}, "Spine must retain"),
        ("narrow-spine", {"spine_width":8}, "Spine must retain"),
        ("lost-neck", {"grip_clearance":3}, "Shoulder and neck"),
        ("thin-shoulder", {"shoulder_thickness":1}, "Shoulder and neck"),
        ("large-corner", {"spine_corner_radius":9}, "Spine corner"),
        ("high-label", {"label_height":9}, "Labels must remain"),
        ("low-resolution", {"$fn":24}, "Layout and curve")]
    for name, params, assertion in invalid:
        run(name, params.get("part", "dibber"), params, "csg", assertion)

    mutants = [
        ("missing-labels", "module labels() {}"),
        ("shifted-center", "module body() { union() { rounded_spine(); for(x=[-pitch,0,pitch]) translate([x+(x==0 ? -.15 : 0),0,0]) shoulder_pin(); } }"),
        ("missing-center", "module body() { union() { rounded_spine(); for(x=[-pitch,pitch]) translate([x,0,0]) shoulder_pin(); } }"),
        ("short-center", "module body() { union() { rounded_spine(); for(x=[-pitch,0,pitch]) translate([x,0,0]) scale([1,1,x==0 ? .9 : 1]) shoulder_pin(); } }"),
        ("bridged-shoulders", "module body() { union() { rounded_spine(); for(x=[-pitch,0,pitch]) translate([x,0,0]) shoulder_pin(); translate([-pitch,-1,shoulder_z-1]) cube([2*pitch,2,1]); } }"),
        ("square-tip", "module working_pin() { cylinder(h=nominal_depth,r1=pin_base_diameter/2,r2=tip_diameter/2); }")]
    for name, mutation in mutants:
        substitute = out/(name+".scad")
        substitute.write_text("include <"+str(SOURCE)+">\n"+mutation+"\n")
        result = renderer.run_case(exe, substitute, out, "reject-"+name,
                                   [k+"="+json.dumps(v) for k,v in (DEFAULTS | {"part":"dibber"}).items()], "stl")
        if result["passed"]:
            try:
                geometry(out/("reject-"+name+".stl"), DEFAULTS, "dibber")
            except ValueError as error:
                result["passed"] = True
                result["expected_feature_rejection"] = str(error)
            else:
                result.update(passed=False, failure="Wrong functional geometry accepted")
        cases.append(result)

    result = dict(name="coupon-contact-equivalence", passed=False)
    try:
        if not all(any(c["name"] == n and c["passed"] for c in cases)
                   for n in ("default-dibber", "default-contact_coupon")):
            raise ValueError("Requires validated full and coupon exports")
        full, _ = metrics(out/"default-dibber.stl")
        coupon, _ = metrics(out/"default-contact_coupon.stl")
        for x in (-8,-3,-.17,.13,3,8):
            for y in (-8,-2,.19,2,8):
                cutoff = DEFAULTS["spine_thickness"]+DEFAULTS["label_height"]+.05
                a = [z for z in ray(full,(x,y,0)) if z > cutoff]
                b = [z for z in ray(coupon,(x,y,0)) if z > cutoff]
                if len(a)!=len(b) or any(abs(u-v)>.06 for u,v in zip(a,b)):
                    raise ValueError("Coupon contact differs from full dibber")
        result["passed"] = True
    except (OSError, ValueError) as error:
        result["failure"] = str(error)
    cases.append(result)
    cases.append(dict(name="sources-unchanged", passed=all(
        hashlib.sha256((ROOT/f).read_bytes()).hexdigest()==h for f,h in hashes.items())))
    report = dict(passed=all(c["passed"] for c in cases), cases=cases, source_sha256=hashes,
                  openscad=exe, physical_soil_depth_fit_strength_wear_and_usefulness_verified=False)
    (out/"summary.json").write_text(json.dumps(report, indent=2)+"\n")
    print("Evidence: "+str(out)+". CAD only; inspect slicing and test the coupon in actual media first.")
    return 0 if report["passed"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
