#!/usr/bin/env python3
"""Export the soil shield/coupon and check CAD geometry, never physical fit."""
import argparse
import hashlib
import json
import math
from pathlib import Path
import sys
import tempfile

sys.dont_write_bytecode = True
HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parents[1] / "scripts"))
from validate_sliding_rc_stand import resolve_openscad, run_case

SOURCE = HERE / "partial-pot-rim-soil-shield.scad"
COUPON = HERE / "contact-coupon.scad"
# Fixed regression fixture, independent of editable source defaults.
DEFAULTS = dict(part="shield",pot_outer_radius=76.2, pot_inner_radius=70.2, rim_clearance=1,
                arc_angle=80, wall_height=45, wall_thickness=2.8,
                ledge_thickness=2.8, return_reach=4, return_slope=15,
                root_ball_radius=62, plant_clearance=3, grip_length=30,
                grip_thickness=5, grip_width=26, grip_overlap=3, grip_corner_radius=6,
                edge_radius=.6, coupon_angle=16, radial_facets=96, round_facets=12,
                grip_kernel_height=.01)


def triangles(path):
    vertices = [tuple(map(float, line.split()[1:]))
                for line in path.read_text().splitlines()
                if line.lstrip().startswith("vertex ")]
    return [vertices[i:i+3] for i in range(0, len(vertices), 3)]


def ray_heights(mesh, x, y):
    """Intersect a vertical line with actual triangles; deduplicate shared edges."""
    hits = []
    for a, b, c in mesh:
        den = (b[1]-c[1])*(a[0]-c[0])+(c[0]-b[0])*(a[1]-c[1])
        if abs(den) < 1e-12:
            continue
        u = ((b[1]-c[1])*(x-c[0])+(c[0]-b[0])*(y-c[1]))/den
        v = ((c[1]-a[1])*(x-c[0])+(a[0]-c[0])*(y-c[1]))/den
        if min(u, v, 1-u-v) >= -1e-8:
            hits.append(u*a[2]+v*b[2]+(1-u-v)*c[2])
    unique = []
    for z in sorted(hits):
        if not unique or z-unique[-1] > 1e-5:
            unique.append(z)
    return unique


def geometry(path, parameters=None, coupon=False):
    mesh = triangles(path)
    vertices = [v for t in mesh for v in t]
    volume = sum(a[0]*(b[1]*c[2]-b[2]*c[1]) +
                 a[1]*(b[2]*c[0]-b[0]*c[2]) +
                 a[2]*(b[0]*c[1]-b[1]*c[0]) for a,b,c in mesh)/6
    if not math.isfinite(volume) or volume <= 0:
        raise ValueError("Mesh must have positive finite signed volume")
    bounds = [[fn(v[i] for v in vertices) for i in range(3)] for fn in (min,max)]
    if abs(bounds[0][2]) > .02:
        raise ValueError("Rim-contact underside is not on z=0")
    if min(v[0] for v in vertices) <= 0:
        raise ValueError("Partial arc must leave the opposite mouth completely open")
    radial_min = min(math.hypot(v[0],v[1]) for v in vertices)
    metrics = dict(signed_volume_mm3=volume,bounds_mm=bounds,
                   sampled_radial_min_mm=radial_min,return_path_rays=0,
                   analytic_fixture=parameters is not None)
    # Current source dimensions are editable. Strict mesh checks, volume and bed
    # placement apply to them; analytic dimensions belong to pinned fixtures.
    if parameters is None:
        return metrics
    p = parameters
    drop = p["pot_inner_radius"]-p["return_reach"]
    inner = p["pot_outer_radius"]+p["rim_clearance"]
    outer = inner+p["wall_thickness"]
    top = p["ledge_thickness"]+(outer-drop)*math.tan(math.radians(p["return_slope"]))+p["wall_height"]
    top -= p["edge_radius"]*(math.tan(math.radians(p["return_slope"]))+1/math.cos(math.radians(p["return_slope"]))-1)
    if abs(bounds[1][2]-top) > .15:
        raise ValueError("Wall height/profile bounds differ from declared example")
    # Probe the actual ledge at three angles, not merely the source polygon.
    angle = p["coupon_angle"] if coupon else p["arc_angle"]
    # Above the grip, azimuth bounds describe the wall, not the handle footprint.
    angles = [math.degrees(math.atan2(v[1],v[0])) for v in vertices
              if v[2] > p["grip_thickness"]+p["edge_radius"]]
    extension = math.degrees(math.atan(p["edge_radius"]/inner) +
                             math.asin(p["edge_radius"]/(drop+p["edge_radius"])))+.1
    if (not angles or min(angles)>-angle/2+.1 or max(angles)<angle/2-.1 or
            min(angles)<-angle/2-extension or max(angles)>angle/2+extension):
        raise ValueError("Exported angular extent differs from requested sweep")
    metrics["wall_angular_bounds_deg"] = [min(angles),max(angles)]
    for degrees in (-angle/3, 0, angle/3):
        theta = math.radians(degrees)
        previous = None
        for i in range(5):
            r = drop+1+(inner-drop-2)*i/4
            hits = ray_heights(mesh,r*math.cos(theta),r*math.sin(theta))
            expected = p["ledge_thickness"]+(r-drop)*math.tan(math.radians(p["return_slope"]))
            if len(hits)!=2 or abs(hits[0])>.02 or abs(hits[1]-expected)>.15:
                raise ValueError("Return-path probe must meet one flat underside and sloping top")
            if previous is not None and hits[1] <= previous:
                raise ValueError("Return path must descend continuously toward the pot")
            previous = hits[1]
    # Every vertex stays outside the declared cylindrical plant envelope.
    # This is a sampled CAD check; physical foliage/root clearance is separate.
    if radial_min < p["root_ball_radius"]+p["plant_clearance"]-.1:
        raise ValueError("Declared plant-envelope clearance lost in exported mesh")
    if not coupon:
        hits = ray_heights(mesh,outer+p["grip_length"]/2,0)
        if len(hits)!=2 or abs(hits[0])>.02 or abs(hits[1]-p["grip_thickness"])>.1:
            raise ValueError("External grip must be a bed-flat solid of declared thickness")
    return metrics | dict(return_path_rays=15)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--openscad")
    parser.add_argument("--output-dir",type=Path,help="New directory; never reuse stale exports")
    args = parser.parse_args()
    known = Path("/Applications/OpenSCAD-2021.01.app/Contents/MacOS/OpenSCAD")
    preferred = str(known) if known.is_file() else None
    exe = resolve_openscad(args.openscad or preferred)
    if not exe:
        parser.exit(1,"OpenSCAD unavailable; pass --openscad PATH.\n")
    try:
        out = args.output_dir.resolve() if args.output_dir else Path(tempfile.mkdtemp(prefix="soil-shield-"))
        if args.output_dir:
            out.mkdir(parents=True,exist_ok=False)
    except OSError as error:
        parser.exit(1,f"Cannot create fresh output directory: {error}\n")
    tracked = [SOURCE,COUPON,Path(__file__),HERE.parents[1]/"scripts/validate_sliding_rc_stand.py"]
    hashes = {str(f):hashlib.sha256(f.read_bytes()).hexdigest() for f in tracked}
    cases = []
    # Current configuration exports preserve user edits. Regression fixtures pin
    # every dimension so they remain reproducible after those defaults change.
    valid = [
        ("shield",SOURCE,{"part":"shield"},False,False),
        ("contact-coupon",COUPON,{},True,False),
        ("coupon-selector",SOURCE,{"part":"contact_coupon"},True,False),
        ("fixture-6-inch",SOURCE,{},False,True),
        ("fixture-contact-coupon",COUPON,{"part":"contact_coupon"},True,True),
        ("small-open-arc",SOURCE,{"arc_angle":30},False,True),
        ("wide-open-arc",SOURCE,{"arc_angle":120},False,True),
        ("thin-shallow-return",SOURCE,{"wall_thickness":2.4,"ledge_thickness":2.4,
             "return_slope":8,"return_reach":2,"grip_thickness":3},False,True),
        ("steep-return",SOURCE,{"return_slope":30,"wall_height":20},False,True),
        ("larger-radius-example",SOURCE,{"pot_outer_radius":100,"pot_inner_radius":94,
             "root_ball_radius":85,"wall_height":60},False,True),
    ]
    for name,source,overrides,coupon,fixture in valid:
        parameters = DEFAULTS|overrides if fixture else None
        definitions = [f"{k}={json.dumps(v)}" for k,v in
                       (parameters if fixture else overrides).items()]
        result=run_case(exe,source,out,name,definitions,"stl",timeout=240)
        if result["passed"]:
            try:
                result["geometry"]=geometry(out/f"{name}.stl",parameters,coupon)
            except ValueError as error:
                result.update(passed=False,failure=str(error))
        cases.append(result)
        print(f"{'PASS' if result['passed'] else 'FAIL'} {name}",flush=True)
    invalid=[
        ("unknown-part",'part="bad"',"Unknown part selector"),
        ("inverted-rim","pot_inner_radius=80","pot radii"),
        ("interference","rim_clearance=-1","rim_clearance"),
        ("closed-collar","arc_angle=360","arc_angle"),
        ("tiny-arc","arc_angle=29","arc_angle"),
        ("tall-wall","wall_height=81","wall_height"),
        ("thin-wall","wall_thickness=1","minimum thickness"),
        ("thin-ledge","ledge_thickness=1","minimum thickness"),
        ("no-return","return_reach=0","return_reach"),
        ("flat-pocket","return_slope=0","return_slope"),
        ("plant-contact","root_ball_radius=66","plant envelope"),
        ("short-grip","grip_length=10","grip length/width"),
        ("disconnected-grip","grip_overlap=0","grip_overlap"),
        ("erased-core","edge_radius=2","edge_radius"),
        ("oversized-grip-round","grip_corner_radius=14","grip_corner_radius"),
        ("raised-grip","grip_thickness=10","grip top"),
        ("coupon-too-wide","coupon_angle=25","coupon_angle"),
    ]
    for name,definition,assertion in invalid:
        key,value = definition.split("=",1)
        definitions = [f"{k}={json.dumps(v)}" for k,v in
                       (DEFAULTS|{key:json.loads(value)}).items()]
        result=run_case(exe,SOURCE,out,name,definitions,"csg",assertion)
        cases.append(result)
        print(f"{'PASS' if result['passed'] else 'FAIL'} {name}",flush=True)
    if all(r["passed"] for r in cases[:3]):
        a=sorted(tuple(sorted(t)) for t in triangles(out/"contact-coupon.stl"))
        b=sorted(tuple(sorted(t)) for t in triangles(out/"coupon-selector.stl"))
        cases.append(dict(name="same-source-coupon-equivalence",passed=a==b))
    if any(r["name"]=="fixture-6-inch" and r["passed"] for r in cases):
        for wrong_angle in (30,120):
            result = dict(name=f"reject-wrong-sweep-{wrong_angle}",passed=False)
            try:
                geometry(out/"fixture-6-inch.stl",DEFAULTS|{"arc_angle":wrong_angle})
            except ValueError as error:
                result["passed"] = "angular extent" in str(error)
                if not result["passed"]:
                    result["failure"] = str(error)
            else:
                result["failure"] = "Wrong sweep unexpectedly accepted"
            cases.append(result)
    unchanged=all(hashlib.sha256(f.read_bytes()).hexdigest()==hashes[str(f)] for f in tracked)
    cases.append(dict(name="sources-unchanged-during-validation",passed=unchanged))
    report=dict(passed=all(r["passed"] for r in cases),cases=cases,source_sha256=hashes,
                openscad=exe,physical_fit_slicing_strength_and_usefulness_verified=False)
    (out/"summary.json").write_text(json.dumps(report,indent=2)+"\n")
    print(f"Evidence: {out}\nCAD checks only; inspect slicer, print coupon and test the actual pot.")
    return 0 if report["passed"] else 1


if __name__=="__main__":
    raise SystemExit(main())
