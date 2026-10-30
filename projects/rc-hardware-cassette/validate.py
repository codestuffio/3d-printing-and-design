#!/usr/bin/env python3
"""Render and check the RC hardware cassette; physical retention is separate."""
import argparse
import hashlib
import json
from pathlib import Path
import sys
import subprocess
import tempfile

sys.dont_write_bytecode = True
PROJECT = Path(__file__).resolve().parent
ROOT = PROJECT.parents[1]
sys.path.insert(0, str(ROOT / "scripts"))
from validate_sliding_rc_stand import resolve_openscad, check_mesh
from validate_pr16_tools import metrics, ray, require_ray

SOURCE = PROJECT / "rc-hardware-cassette.scad"
DEFAULTS = dict(well_length=40, well_width=24, well_depth=12,
                floor_thickness=2, wall_thickness=2.4, divider_width=2.4,
                pocket_radius=3, bottom_fillet=1.2, outer_radius=4,
                lid_thickness=2.4, skirt_thickness=1.8, skirt_depth=6,
                lateral_clearance=.3, closed_gap=0, smallest_part_thickness=.5,
                band_width=8, band_groove_depth=.6, thumb_radius=3,
                coupon_depth=16)


def run_case(executable, source, output, name, definitions, extension, expected_assertion=None,
             single_solid=True):
    target=output/f"{name}.{extension}"
    target.unlink(missing_ok=True)
    command=[executable,"-o",str(target)]
    if extension=="stl": command += ["--export-format","asciistl"]
    for definition in definitions: command += ["-D",definition]
    command.append(str(source))
    result=dict(name=name,passed=False,definitions=definitions)
    diagnostic=""
    try:
        process=subprocess.run(command,capture_output=True,text=True,timeout=180)
        diagnostic=process.stdout+process.stderr
        errors=[line for line in diagnostic.splitlines() if line.startswith("ERROR:")]
        warnings=[line for line in diagnostic.splitlines() if line.startswith("WARNING:")]
        result["exit_code"]=process.returncode
        if expected_assertion:
            if process.returncode not in (0,1) or warnings or not errors or any(
                    "Assertion" not in line or expected_assertion not in line for line in errors):
                raise ValueError("Expected assertion absent or unrelated renderer failure")
        else:
            if process.returncode or errors or warnings:
                raise ValueError("Renderer reported errors, warnings or nonzero exit")
            if not target.is_file() or not target.stat().st_size:
                raise ValueError("Renderer did not create a nonempty export")
            if extension=="stl":
                if single_solid: result["triangles"]=check_mesh(target)
                else: metrics(target)
        result["passed"]=True
    except (OSError,ValueError,subprocess.TimeoutExpired) as error:
        result["failure"]=str(error)
    (output/f"{name}.log").write_text(diagnostic+result.get("failure","")+"\n")
    return result


def dimensions(p):
    length = 2*p["well_length"] + 2*p["wall_thickness"] + p["divider_width"]
    width = 2*p["well_width"] + 2*p["wall_thickness"] + p["divider_width"]
    margin = p["lateral_clearance"] + p["skirt_thickness"]
    return length, width, p["floor_thickness"]+p["well_depth"], length+2*margin, width+2*margin


def geometry(path, p, part):
    mesh, result = metrics(path)
    length, width, height, lid_length, lid_width = dimensions(p)
    lid = part.startswith("lid")
    coupon = part.endswith("coupon")
    expected = [[-lid_length/2, -lid_width/2, 0],
                [lid_length/2, lid_width/2, p["lid_thickness"]+p["skirt_depth"]]] if lid else [
                [-length/2, -width/2, 0], [length/2, width/2, height]]
    if coupon:
        expected[1][1] = -lid_width/2+p["coupon_depth"]
    if any(abs(a-b)>.06 for row,want in zip(result["bounds_mm"],expected) for a,b in zip(row,want)):
        raise ValueError("Bounds differ from independent fixture")
    # Actual exported surfaces, not echoed source dimensions.
    y = -width/2+p["outer_radius"]+1 if coupon else width/4
    if lid:
        require_ray(mesh,(.37,y,0),[0,p["lid_thickness"]])
        require_ray(mesh,(length/2+p["lateral_clearance"]/2,y,0),[0,p["lid_thickness"]])
        require_ray(mesh,(length/2+p["lateral_clearance"]+p["skirt_thickness"]/2,y,0),
                    [0,p["lid_thickness"]+p["skirt_depth"]])
        if not coupon:
            require_ray(mesh,(lid_length/2-p["skirt_thickness"]/2,0,0),
                        [0,p["lid_thickness"]+p["skirt_depth"]-p["thumb_radius"]])
        # Side band track must stop short of the inside of the skirt.
        crossings=ray(mesh,(0,-lid_width/2,p["lid_thickness"]+1),1)
        want=[-lid_width/2+p["band_groove_depth"],-width/2-p["lateral_clearance"]]
        if not coupon:
            want += [width/2+p["lateral_clearance"],lid_width/2-p["band_groove_depth"]]
        if len(crossings)!=len(want) or any(abs(a-b)>.06 for a,b in zip(crossings,want)):
            raise ValueError("Lid band guide or skirt clearance differs")
    else:
        # Four blind wells and the full-height cross must exist.
        cy=(p["well_width"]+p["divider_width"])/2
        cx=(p["well_length"]+p["divider_width"])/2
        probe_y=-width/2+p["wall_thickness"]+p["pocket_radius"]+1 if coupon else -cy
        for sx in (-1,1):
            for py in ([probe_y] if coupon else [-cy,cy]):
                require_ray(mesh,(sx*cx,py,0),[0,p["floor_thickness"]])
        require_ray(mesh,(.23,probe_y,0),[0,height])
        if not coupon:
            require_ray(mesh,(cx,.23,0),[0,height])
            require_ray(mesh,(-cx,.23,0),[0,height])
        # Straight side lengths and divider width measured at mid-depth.
        require_ray(mesh,(.1,probe_y,height-2),[-length/2,-p["divider_width"]/2-p["well_length"],
                    -p["divider_width"]/2,p["divider_width"]/2,
                    p["divider_width"]/2+p["well_length"],length/2],0)
        require_ray(mesh,(0,-width/2+p["band_groove_depth"]/2,0),[])
        require_ray(mesh,(0,-width/2+p["band_groove_depth"]+.4,0),[0,height])
        # Bottom fillet leaves material above the flat floor near a pocket edge.
        hits=ray(mesh,(cx,-width/2+p["wall_thickness"]+p["bottom_fillet"]/2,0))
        if len(hits)!=2 or not p["floor_thickness"]+.04 < hits[1] < p["floor_thickness"]+p["bottom_fillet"]:
            raise ValueError("Rounded pocket floor missing")
    surface_width=lid_width if lid else width
    for sign in (-1,1):
        require_ray(mesh,(sign*(p["band_width"]/2-.2),-surface_width/2+p["band_groove_depth"]/2,0),[])
        require_ray(mesh,(sign*(p["band_width"]/2+.2),-surface_width/2+p["band_groove_depth"]/2,0),
                    [0,p["lid_thickness"]+p["skirt_depth"]] if lid else [0,height])
    return result


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--openscad")
    parser.add_argument("--output-dir",type=Path)
    args=parser.parse_args()
    exe=resolve_openscad(args.openscad)
    if not exe:
        parser.exit(1,"OpenSCAD executable unavailable.\n")
    try:
        out=args.output_dir.resolve() if args.output_dir else Path(tempfile.mkdtemp(prefix="rc-cassette-"))
        if args.output_dir: out.mkdir(parents=True,exist_ok=False)
        tracked=[SOURCE,Path(__file__).resolve()]
        hashes={str(f.relative_to(ROOT)):hashlib.sha256(f.read_bytes()).hexdigest() for f in tracked}
    except OSError as error:
        parser.exit(1,str(error)+"\n")
    cases=[]
    def run(name,part,params=None,extension="stl",assertion=None,pinned=True):
        values=(DEFAULTS if pinned else {}) | (params or {}) | {"part":part}
        definitions=[f"{k}={json.dumps(v)}" for k,v in values.items()]
        result=run_case(exe,SOURCE,out,name,definitions,extension,assertion)
        if result["passed"] and extension=="stl":
            try: result["geometry"]=geometry(out/(name+".stl"),DEFAULTS | (params or {}),part)
            except ValueError as error: result.update(passed=False,failure=str(error))
        cases.append(result)
        print(f"{'PASS' if result['passed'] else 'FAIL'} {name}",flush=True)
        return result
    for part in ("tray","lid","tray_coupon","lid_coupon"):
        run("default-"+part,part,pinned=False)
    small=dict(well_length=30,well_width=20,well_depth=8,skirt_depth=5,thumb_radius=2)
    for part in ("tray","lid"):
        run("small-"+part,part,small)
    large=dict(well_length=50,well_width=30,well_depth=16,wall_thickness=3,
               divider_width=3,lateral_clearance=.45,closed_gap=.1)
    for part in ("tray","lid"):
        run("large-"+part,part,large)
    for part in ("layout","assembly"):
        run(part,part,extension="csg")
    # Assembly may have separate shells/cavity surfaces; individual parts were checked above.
    for gap in (0,.1):
        params=DEFAULTS|{"part":"assembly","closed_gap":gap}
        name="assembly-gap-"+str(gap)
        result=run_case(exe,SOURCE,out,name,
                        [f"{k}={json.dumps(v)}" for k,v in params.items()],"stl",single_solid=False)
        if result["passed"]:
            try:
                mesh,_=metrics(out/(name+".stl"))
                length,width,height,lid_length,lid_width=dimensions(params)
                cx=(params["well_length"]+params["divider_width"])/2
                cy=(params["well_width"]+params["divider_width"])/2
                require_ray(mesh,(cx,cy,0),[0,params["floor_thickness"],height+gap,height+gap+params["lid_thickness"]])
                require_ray(mesh,(lid_length/2-params["skirt_thickness"]/2,width/4,0),
                            [height+gap-params["skirt_depth"],height+gap+params["lid_thickness"]])
                require_ray(mesh,(.23,.37,0),[0,height+params["lid_thickness"]] if gap==0 else
                            [0,height,height+gap,height+gap+params["lid_thickness"]])
            except ValueError as error: result.update(passed=False,failure=str(error))
        cases.append(result)
        print(f"{'PASS' if result['passed'] else 'FAIL'} {name}",flush=True)
    invalid=[("unknown",{"part":"bad"},"Unknown part"),
             ("negative-well",{"well_length":-1},"Well dimensions"),
             ("thin-floor",{"floor_thickness":.5},"Floor, walls"),
             ("thin-divider",{"divider_width":.5},"Floor, walls"),
             ("oversize-radius",{"pocket_radius":20},"Pocket radii"),
             ("erased-floor-round",{"bottom_fillet":4},"Pocket radii"),
             ("skirt-bottoms",{"skirt_depth":15},"Skirt must"),
             ("lost-skirt-overlap",{"skirt_depth":1.4,"thumb_radius":.1,"closed_gap":1.5,
                                     "smallest_part_thickness":2},"Skirt must"),
             ("thin-skirt",{"skirt_thickness":1.2},"Band grooves"),
             ("deep-groove",{"band_groove_depth":2},"Band grooves"),
             ("pinched-lid",{"lateral_clearance":0},"Lateral clearance"),
             ("washer-gap",{"closed_gap":.5},"Closed gap"),
             ("zero-part-thickness",{"smallest_part_thickness":0},"Closed gap"),
             ("large-thumb",{"thumb_radius":6},"Thumb recess"),
             ("coupon-too-long",{"coupon_depth":60},"Coupon depth")]
    for name,params,message in invalid:
        run(name,params.get("part","tray"),params,"csg",message)
    # Prove the feature checker rejects plausible wrong, still-manifold meshes.
    for label,part,wrong in [("wrong-divider","tray",{"divider_width":3.4,"well_length":39.5,"well_width":23.5}),
                              ("wrong-pocket-depth","tray",{"floor_thickness":3,"well_depth":11}),
                              ("wrong-lid-fit","lid",{"lateral_clearance":.5,"skirt_thickness":1.6}),
                              ("wrong-skirt-depth","lid",{"skirt_depth":4}),
                              ("wrong-band-width","tray",{"band_width":10})]:
        result=dict(name="reject-"+label,passed=False)
        if not any(case["name"]=="default-"+part and case["passed"] for case in cases):
            result["failure"]="Requires a successfully validated default export"
        else:
            try: geometry(out/("default-"+part+".stl"),DEFAULTS|wrong,part)
            except ValueError: result["passed"]=True
            except OSError as error: result["failure"]=str(error)
        cases.append(result)
    # Coupons are cropped from the same full parts; compare exported surfaces.
    for part in ("tray","lid"):
        result=dict(name=part+"-coupon-contact-equivalence",passed=False)
        try:
            full,_=metrics(out/("default-"+part+".stl"))
            sample,_=metrics(out/("default-"+part+"_coupon.stl"))
            length,width,height,lid_length,lid_width=dimensions(DEFAULTS)
            probes=[(-length/2+1,-width/2+2),(-21.2,-23),(0,-24),(20,-22)]
            for x,y in probes:
                a=ray(full,(x,y,0));b=ray(sample,(x,y,0))
                if len(a)!=len(b) or any(abs(u-v)>.06 for u,v in zip(a,b)):
                    raise ValueError("Coupon contact differs from full part")
            result["passed"]=True
        except (OSError,ValueError) as error: result["failure"]=str(error)
        cases.append(result)
    unchanged=all(hashlib.sha256((ROOT/f).read_bytes()).hexdigest()==h for f,h in hashes.items())
    cases.append(dict(name="sources-unchanged",passed=unchanged))
    report=dict(passed=all(x["passed"] for x in cases),cases=cases,source_sha256=hashes,
                openscad=exe,physical_fit_retention_slicing_and_usefulness_verified=False)
    (out/"summary.json").write_text(json.dumps(report,indent=2)+"\n")
    print(f"Evidence: {out}. CAD checks only; print fit coupons first.")
    return 0 if report["passed"] else 1


if __name__=="__main__":
    raise SystemExit(main())
