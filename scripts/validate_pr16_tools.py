#!/usr/bin/env python3
"""Validate the three PR16 tools locally; no physical fit or strength claim."""
import argparse
import hashlib
import json
import math
from pathlib import Path
import sys
import tempfile

sys.dont_write_bytecode = True
ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'scripts'))
from validate_sliding_rc_stand import resolve_openscad, run_case

# Pinned regression inputs are separate from user-editable CAD defaults.
FIXTURES = {'leaf': {'folder': 'open-slot-leaf-propagation-support',
          'part': 'support',
          'parameters': {'part': 'support',
                         'jar_mouth_diameter': 60,
                         'jar_outer_rim_diameter': 66,
                         'bearing_overlap': 2,
                         'petiole_diameter': 3,
                         'petiole_clearance': 1,
                         'plate_diameter': 76,
                         'plate_thickness': 3,
                         'opening_diameter': 8,
                         'slot_width': 5,
                         'minimum_web': 6,
                         'edge_rounding': 0.6,
                         'tab_length': 12,
                         'tab_width': 18,
                         'tab_overlap': 4,
                         'tab_corner_radius': 3,
                         '$fn': 96,
                         'rounding_steps': 6},
          'valid': [('small',
                     {'jar_mouth_diameter': 40,
                      'jar_outer_rim_diameter': 46,
                      'plate_diameter': 56,
                      'opening_diameter': 6,
                      'slot_width': 4,
                      'petiole_diameter': 2,
                      'plate_thickness': 2.4,
                      'edge_rounding': 0.4,
                      'tab_length': 10,
                      'tab_width': 16,
                      'minimum_web': 5}),
                    ('large',
                     {'jar_mouth_diameter': 84,
                      'jar_outer_rim_diameter': 92,
                      'bearing_overlap': 3,
                      'plate_diameter': 104,
                      'opening_diameter': 12,
                      'slot_width': 8,
                      'petiole_diameter': 5,
                      'petiole_clearance': 1.5,
                      'plate_thickness': 4,
                      'edge_rounding': 0.8,
                      'tab_length': 16,
                      'tab_width': 22,
                      'tab_overlap': 5,
                      'tab_corner_radius': 4,
                      'minimum_web': 8}),
                    ('wide-opening',
                     {'opening_diameter': 18,
                      'slot_width': 10,
                      'petiole_diameter': 6,
                      'petiole_clearance': 2})],
          'invalid': [('unknown', {'part': 'bad'}, 'Unknown part selector'),
                      ('zero-thickness', {'plate_thickness': 0}, 'Dimensions must be positive'),
                      ('lost-rim',
                       {'jar_outer_rim_diameter': 62},
                       'Jar rim must provide bearing_overlap'),
                      ('small-plate', {'plate_diameter': 68}, 'Rounded plate must overhang'),
                      ('pinched-slot', {'slot_width': 4}, 'Slot must clear the petiole'),
                      ('small-opening',
                       {'opening_diameter': 4},
                       'Opening must be at least as wide'),
                      ('over-round', {'edge_rounding': 1.5}, 'Edge rounding must preserve'),
                      ('erased-web',
                       {'opening_diameter': 64},
                       'Rounded opening must preserve minimum_web'),
                      ('tab-gap', {'tab_overlap': 1}, 'Tab must retain a connected'),
                      ('low-facets', {'$fn': 12}, 'Curve sampling requires'),
                      ('fractional-steps',
                       {'rounding_steps': 1.5},
                       'rounding_steps must be an integer'),
                      ('opening-erases-bearing',
                       {'opening_diameter': 61},
                       'Rounded opening must remain inside the jar mouth')],
          'wrong_feature': {'slot_width': 6}},
 'nest': {'folder': 'single-jack-bench-termination-nest',
          'part': 'nest',
          'parameters': {'part': 'nest',
                         'base_length': 92,
                         'base_width': 60,
                         'base_thickness': 8,
                         'base_radius': 4,
                         'jack_length': 34,
                         'jack_width': 20,
                         'recess_depth': 3,
                         'recess_clearance': 0.5,
                         'support_land_width': 8,
                         'support_land_length': 14,
                         'support_land_spacing': 20,
                         'support_land_height': 0.8,
                         'cable_exit_width': 10,
                         'latch_relief_width': 12,
                         'latch_relief_length': 10,
                         'latch_relief_extra_depth': 0.5,
                         'ear_width': 24,
                         'ear_projection': 22,
                         'ear_overlap': 8,
                         'ear_radius': 3,
                         'clamp_pad_length': 14,
                         'clamp_pad_width': 12,
                         'clamp_pad_margin': 1,
                         'coupon_length': 50,
                         'coupon_width': 32,
                         'tool_bottom_above_support': 8,
                         'tool_envelope_length': 40,
                         'tool_envelope_width': 30,
                         'minimum_floor': 3,
                         'minimum_wall': 4,
                         'minimum_land_width': 6,
                         'minimum_land_length': 12,
                         'minimum_ear_join': 4,
                         'minimum_access_gap': 1,
                         '$fn': 48,
                         'cut_epsilon': 0.02},
          'valid': [('close-fit', {'recess_clearance': 0.2}),
                    ('larger-jack',
                     {'jack_length': 42,
                      'jack_width': 24,
                      'support_land_spacing': 26,
                      'support_land_width': 10,
                      'support_land_length': 18,
                      'coupon_length': 58,
                      'coupon_width': 36,
                      'cable_exit_width': 12,
                      'latch_relief_width': 14}),
                    ('deeper',
                     {'base_thickness': 10,
                      'recess_depth': 4,
                      'support_land_height': 1.2,
                      'latch_relief_extra_depth': 1,
                      'tool_bottom_above_support': 7})],
          'invalid': [('unknown', {'part': 'bad'}, 'part must be nest or contact_coupon'),
                      ('thin-floor',
                       {'recess_depth': 6},
                       'recess and latch relief must preserve minimum floor'),
                      ('thin-land',
                       {'support_land_width': 5},
                       'support lands must retain broad bearing faces'),
                      ('outer-land',
                       {'support_land_spacing': 30},
                       'support lands must remain separated'),
                      ('closed-exit', {'cable_exit_width': 0}, 'cable exit must be open'),
                      ('no-latch-relief',
                       {'latch_relief_length': 0},
                       'latch relief must be positive'),
                      ('weak-ear-join',
                       {'ear_overlap': 5},
                       'ears must retain broad connected joins'),
                      ('large-pad', {'clamp_pad_width': 18}, 'clamp pads must fit wholly'),
                      ('tool-collision',
                       {'tool_bottom_above_support': 1},
                       'tool envelope must clear'),
                      ('negative-base', {'base_length': -1}, 'base dimensions must be positive'),
                      ('narrow-coupon', {'coupon_width': 20}, 'contact coupon must retain')],
          'wrong_feature': {'support_land_height': 1.8}},
 'rests': {'folder': 'lift-off-hinge-taping-rests',
           'part': 'rest',
           'parameters': {'part': 'rest',
                          'base_width': 76,
                          'base_length': 50,
                          'base_thickness': 3,
                          'minimum_floor_thickness': 2,
                          'base_edge_radius': 2,
                          'left_land_width': 20,
                          'right_land_width': 18,
                          'left_land_length': 44,
                          'right_land_length': 40,
                          'left_land_elevation': 12,
                          'right_land_elevation': 10,
                          'seam_relief_width': 22,
                          'contact_edge_radius': 1,
                          'placement_margin': 3,
                          'tape_access_width': 16,
                          'tape_access_clearance': 2,
                          'access_height': 5,
                          'coupon_length': 12,
                          '$fn': 24},
           'valid': [('low-lands',
                      {'left_land_elevation': 8, 'right_land_elevation': 9, 'access_height': 4}),
                     ('wide-seam',
                      {'base_width': 96,
                       'seam_relief_width': 30,
                       'tape_access_width': 22,
                       'left_land_width': 24,
                       'right_land_width': 22}),
                     ('long-contact',
                      {'base_length': 66,
                       'left_land_length': 58,
                       'right_land_length': 54,
                       'coupon_length': 16})],
           'invalid': [('unknown', {'part': 'bad'}, 'Part must be rest or contact_coupon'),
                       ('negative-base', {'base_width': -1}, 'Base dimensions must be positive'),
                       ('thin-floor', {'base_thickness': 1}, 'Base must retain'),
                       ('zero-land', {'left_land_width': 0}, 'Land dimensions must be positive'),
                       ('over-round', {'contact_edge_radius': 10}, 'Contact rounding must leave'),
                       ('low-land',
                        {'left_land_elevation': 4},
                        'Land elevations must retain rounded'),
                       ('outside-base', {'left_land_width': 40}, 'Each land must fit'),
                       ('blocked-tape', {'tape_access_width': 30}, 'Seam relief must clear'),
                       ('no-access-height', {'access_height': 9}, 'Land elevations must clear'),
                       ('long-coupon', {'coupon_length': 40}, 'Coupon length must retain'),
                       ('rounded-base-margin',
                        {'base_edge_radius': 4},
                        'Placement margin must cover the rounded base corners')],
           'wrong_feature': {'left_land_elevation': 13}}}


def triangles(path):
    vertices = [tuple(map(float, line.split()[1:])) for line in path.read_text().splitlines()
                if line.lstrip().startswith('vertex ')]
    return [vertices[i:i+3] for i in range(0, len(vertices), 3)]


def ray(mesh, point, axis=2):
    """Intersections of an axis-parallel line with actual exported triangles."""
    i, j = [d for d in range(3) if d != axis]
    hits = []
    for a, b, c in mesh:
        den = (b[j]-c[j])*(a[i]-c[i])+(c[i]-b[i])*(a[j]-c[j])
        if abs(den) < 1e-12:
            continue
        u = ((b[j]-c[j])*(point[i]-c[i])+(c[i]-b[i])*(point[j]-c[j]))/den
        v = ((c[j]-a[j])*(point[i]-c[i])+(a[i]-c[i])*(point[j]-c[j]))/den
        if min(u, v, 1-u-v) >= -1e-8:
            hits.append(u*a[axis]+v*b[axis]+(1-u-v)*c[axis])
    unique = []
    for value in sorted(hits):
        if not unique or value-unique[-1] > 1e-5:
            unique.append(value)
    return unique


def require_ray(mesh, point, expected, axis=2):
    hits = ray(mesh, point, axis)
    if len(hits) != len(expected) or any(abs(a-b) > .06 for a,b in zip(hits,expected)):
        raise ValueError(f'Feature ray at {point} axis {axis}: expected {expected}, got {hits}')


def metrics(path):
    mesh = triangles(path)
    vertices = [v for t in mesh for v in t]
    volume = sum(a[0]*(b[1]*c[2]-b[2]*c[1])+a[1]*(b[2]*c[0]-b[0]*c[2])+
                 a[2]*(b[0]*c[1]-b[1]*c[0]) for a,b,c in mesh)/6
    bounds = [[fn(v[i] for v in vertices) for i in range(3)] for fn in (min,max)]
    if not math.isfinite(volume) or volume <= 0:
        raise ValueError('Export must have positive finite signed volume')
    if abs(bounds[0][2]) > .02:
        raise ValueError('Export must rest on z=0')
    return mesh,dict(volume_mm3=volume,bounds_mm=bounds)


def geometry(key, mesh, p, coupon=False):
    vertices = [v for t in mesh for v in t]
    bounds = [[fn(v[i] for v in vertices) for i in range(3)] for fn in (min,max)]
    if key == "leaf":
        half = p["opening_diameter"]/2+p["minimum_web"]+2*p["edge_rounding"]
        expected = [[-half,-half,0],[p["plate_diameter"]/2,half,p["plate_thickness"]]] if coupon else [[-p["plate_diameter"]/2-p["tab_length"],-p["plate_diameter"]/2,0],[math.sqrt((p["plate_diameter"]/2)**2-(p["slot_width"]/2)**2),p["plate_diameter"]/2,p["plate_thickness"]]]
    elif key == "nest":
        x=p["coupon_length"]/2 if coupon else p["base_length"]/2
        y=p["coupon_width"]/2 if coupon else p["base_width"]/2+p["ear_projection"]
        expected=[[-x,-y,0],[x,y,p["base_thickness"]]]
    else:
        x=p["base_width"]/2;y=(p["coupon_length"] if coupon else p["base_length"])/2
        expected=[[-x,-y,0],[x,y,max(p["left_land_elevation"],p["right_land_elevation"])]]
    if any(abs(a-b)>.06 for row,want in zip(bounds,expected) for a,b in zip(row,want)):
        raise ValueError(f"Bounds differ from declared dimensions: {bounds} expected {expected}")
    if coupon:
        if key == "leaf":
            require_ray(mesh,(0,0,0),[])
            require_ray(mesh,(p["plate_diameter"]/2-1,0,0),[])
            require_ray(mesh,(-p["opening_diameter"]/2-2,0,0),[0,p["plate_thickness"]])
        elif key == "nest":
            for sign in (-1,1):
                require_ray(mesh,(sign*p["support_land_spacing"]/2,0,0),[0,p["base_thickness"]-p["recess_depth"]+p["support_land_height"]])
            require_ray(mesh,(0,0,0),[0,p["base_thickness"]-p["recess_depth"]])
        else:
            for side in ("left","right"):
                sign=-1 if side=="left" else 1
                require_ray(mesh,(sign*(p["seam_relief_width"]/2+p[side+"_land_width"]/2),0,0),[0,p[side+"_land_elevation"]])
            require_ray(mesh,(0,0,0),[0,p["base_thickness"]])
        return {"same_source_crop_bounds":True,"contact_rays":3}

    if key == "leaf":
        t = p["plate_thickness"]
        # Side-release corridor must remain void from the opening to outside.
        for x in (0, p["opening_diameter"]/2+2, p["plate_diameter"]/2-1):
            require_ray(mesh,(x,0,0),[])
        for x,y in ((0,p["jar_mouth_diameter"]/2+p["bearing_overlap"]/2),
                    (0,-p["jar_mouth_diameter"]/2-p["bearing_overlap"]/2),
                    (-p["jar_mouth_diameter"]/2-p["bearing_overlap"]/2,0)):
            require_ray(mesh,(x,y,0),[0,t])
        require_ray(mesh,(-p["plate_diameter"]/2-p["tab_length"]/2,0,0),[0,t])
        crossings = ray(mesh,(p["opening_diameter"]/2+2,0,t/2),1)
        if len(crossings)!=4 or abs(crossings[1]+p["slot_width"]/2)>.06 or abs(crossings[2]-p["slot_width"]/2)>.06:
            raise ValueError("Actual side-release slot width differs from fixture")
        for point in ((.3*p["plate_diameter"],p["slot_width"]/2+p["edge_rounding"]/2,0),
                      (-p["opening_diameter"]/2-p["edge_rounding"]/2,0,0)):
            hits = ray(mesh,point)
            r = p["edge_rounding"]
            if (len(hits)!=2 or not r/24 < hits[0] < r or
                    not t-r < hits[1] < t-r/24):
                raise ValueError("Contact-edge rounding missing at leaf opening or slot")
        return {"rounded_contact_rays":2,"release_void_rays":3,"rim_bearing_rays":3,"tab_rays":1,"slot_width_mm":crossings[2]-crossings[1]}
    if key == "nest":
        floor = p["base_thickness"]-p["recess_depth"]
        top = floor+p["support_land_height"]
        for sign in (-1,1):
            require_ray(mesh,(sign*p["support_land_spacing"]/2,0,0),[0,top])
            require_ray(mesh,(0,sign*(p["base_width"]/2+p["ear_projection"]/2),0),[0,p["base_thickness"]])
        require_ray(mesh,(0,0,0),[0,floor])
        require_ray(mesh,(p["base_length"]/2-1,0,0),[0,floor])
        require_ray(mesh,(-(p["jack_length"]+2*p["recess_clearance"])/2-p["latch_relief_length"]/2,0,0),[0,floor-p["latch_relief_extra_depth"]])
        # The recessed cable corridor has no wall above the floor at the edge.
        crossings = ray(mesh,(p["base_length"]/2-1,0,(floor+p["base_thickness"])/2),1)
        if len(crossings)!=4 or abs(crossings[1]+p["cable_exit_width"]/2)>.06 or abs(crossings[2]-p["cable_exit_width"]/2)>.06:
            raise ValueError("Cable channel width differs from fixture")
        return {"support_land_rays":2,"clamp_ear_rays":2,"floor_exit_latch_rays":3}
    if key == "rests":
        require_ray(mesh,(-p["seam_relief_width"]/2-p["left_land_width"]/2,0,0),[0,p["left_land_elevation"]])
        require_ray(mesh,(p["seam_relief_width"]/2+p["right_land_width"]/2,0,0),[0,p["right_land_elevation"]])
        require_ray(mesh,(0,0,0),[0,p["base_thickness"]])
        expected = [-p["seam_relief_width"]/2-p["left_land_width"],-p["seam_relief_width"]/2,
                    p["seam_relief_width"]/2,p["seam_relief_width"]/2+p["right_land_width"]]
        require_ray(mesh,(0,0,p["base_thickness"]+p["contact_edge_radius"]),expected,0)
        for side, sign in (("left",-1),("right",1)):
            r = p["contact_edge_radius"]
            elevation = p[side+"_land_elevation"]
            points = [(sign*(p["seam_relief_width"]/2+r/2),0,0),
                      (sign*(p["seam_relief_width"]/2+p[side+"_land_width"]/2),p[side+"_land_length"]/2-r/2,0)]
            for point in points:
                hits = ray(mesh,point)
                if len(hits)!=2 or abs(hits[0])>.02 or not elevation-r < hits[1] < elevation-r/24:
                    raise ValueError("Contact-edge rounding missing at rest land top")
        return {"rounded_contact_rays":4,"land_height_rays":2,"seam_floor_rays":1,"seam_width_ray":1}
    raise ValueError("Unknown geometry fixture")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--openscad', help='Explicit OpenSCAD CLI path')
    parser.add_argument('--output-dir', type=Path, help='New evidence directory, must not exist')
    args = parser.parse_args()
    known = Path('/Applications/OpenSCAD-2021.01.app/Contents/MacOS/OpenSCAD')
    exe = resolve_openscad(args.openscad or (str(known) if known.is_file() else None))
    if not exe:
        parser.exit(1, 'OpenSCAD unavailable; pass --openscad PATH.\n')
    try:
        out = args.output_dir.resolve() if args.output_dir else Path(tempfile.mkdtemp(prefix='pr16-cad-'))
        if args.output_dir:
            out.mkdir(parents=True, exist_ok=False)
        sources = [ROOT/'projects'/f['folder']/n for f in FIXTURES.values()
                   for n in (f['folder']+'.scad','contact-coupon.scad')]
        sources += [Path(__file__),ROOT/'scripts/validate_sliding_rc_stand.py']
        hashes = {str(f.relative_to(ROOT)):hashlib.sha256(f.read_bytes()).hexdigest() for f in sources}
    except OSError as error:
        parser.exit(1, f'Cannot prepare evidence/source inputs: {error}\n')
    cases = []
    for key, f in FIXTURES.items():
        source = ROOT/'projects'/f['folder']/(f['folder']+'.scad')
        coupon = source.with_name('contact-coupon.scad')
        valid = [('current',source,{'part':f['part']},None),
                 ('current-coupon',coupon,{},None),
                 ('coupon-selector',source,{'part':'contact_coupon'},None),
                 ('fixture',source,f['parameters'],f['parameters']),
                 ('fixture-coupon',source,f['parameters']|{'part':'contact_coupon'},f['parameters']|{'part':'contact_coupon'})]
        valid += [(name,source,f['parameters']|overrides,f['parameters']|overrides)
                  for name,overrides in f['valid']]
        for name, path, definitions, pinned in valid:
            name = key+'-'+name
            result = run_case(exe,path,out,name,[k+'='+json.dumps(v) for k,v in definitions.items()],'stl',timeout=240)
            if result['passed']:
                try:
                    mesh, result['geometry'] = metrics(out/(name+'.stl'))
                    if pinned is not None:
                        result['geometry']['feature_checks'] = geometry(key,mesh,pinned,coupon=pinned['part']=='contact_coupon')
                except ValueError as error:
                    result.update(passed=False,failure=str(error))
            cases.append(result)
            print(('PASS ' if result['passed'] else 'FAIL ')+name,flush=True)
        for name, overrides, expected in f['invalid']:
            definitions = f['parameters']|overrides
            result = run_case(exe,source,out,key+'-'+name,[k+'='+json.dumps(v) for k,v in definitions.items()],'csg',expected)
            cases.append(result)
            print(('PASS ' if result['passed'] else 'FAIL ')+result['name'],flush=True)
        names = [key+'-current-coupon',key+'-coupon-selector']
        if all(any(r['name']==n and r['passed'] for r in cases) for n in names):
            a,b = [sorted(tuple(sorted(t)) for t in triangles(out/(n+'.stl'))) for n in names]
            cases.append(dict(name=key+'-coupon-equivalence',passed=a==b))
        # A deliberately wrong functional dimension must fail against the real mesh.
        target = out/(key+'-fixture.stl')
        if any(r['name']==key+'-fixture' and r['passed'] for r in cases):
            mesh,_ = metrics(target)
            try:
                geometry(key,mesh,f['parameters']|f['wrong_feature'])
            except ValueError:
                cases.append(dict(name=key+'-wrong-feature-rejected',passed=True))
            else:
                cases.append(dict(name=key+'-wrong-feature-rejected',passed=False))
    # Deliberately square-edge substitutes retain the same bounds and earlier
    # center/slot probes; only the contact-edge probes must reject them.
    mutations = {
        "leaf": "module rounded_contact_plate() { union() { linear_extrude(height=plate_thickness) contact_profile(); translate([-plate_diameter/4,0,plate_thickness/4]) cube([0.1,0.1,plate_thickness/2]); } }",
        "rests": "module bearing_land(x_min,width,length,elevation) { translate([x_min,-length/2,base_thickness-0.1]) cube([width,length,elevation-base_thickness+0.1]); }",
    }
    for key, mutation in mutations.items():
        f = FIXTURES[key]
        original = ROOT/'projects'/f['folder']/(f['folder']+'.scad')
        substitute = out/(key+'-square.scad')
        substitute.write_text('include <'+str(original)+'>\n'+mutation+'\n')
        result = run_case(exe,substitute,out,key+'-reject-square-edges',
                          [k+'='+json.dumps(v) for k,v in f['parameters'].items()],'stl')
        if result['passed']:
            mesh,_ = metrics(out/(result['name']+'.stl'))
            try:
                geometry(key,mesh,f['parameters'])
            except ValueError as error:
                result['passed'] = 'Contact-edge rounding' in str(error)
                result['expected_rejection'] = str(error)
            else:
                result.update(passed=False,failure='Square contact edges unexpectedly accepted')
        cases.append(result)
        print(('PASS ' if result['passed'] else 'FAIL ')+result['name'],flush=True)
    unchanged = all(hashlib.sha256((ROOT/f).read_bytes()).hexdigest()==h for f,h in hashes.items())
    cases.append(dict(name='sources-unchanged',passed=unchanged))
    report = dict(passed=bool(FIXTURES) and all(r['passed'] for r in cases),cases=cases,
                  source_sha256=hashes,openscad=exe,physical_validation=False)
    (out/'summary.json').write_text(json.dumps(report,indent=2)+'\n')
    print(f'Evidence: {out}\nCAD checks only. Measure interfaces, inspect slicing and print coupons first.')
    return 0 if report['passed'] else 1


if __name__ == '__main__':
    raise SystemExit(main())
