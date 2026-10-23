#!/usr/bin/env python3
"""Render printable parts and check their topology; does not certify physical fit."""
import argparse
from concurrent.futures import ThreadPoolExecutor
import hashlib
import importlib.util
import json
from pathlib import Path
import sys
import subprocess

HERE = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location(
    'mesh_checks', HERE.parents[1] / 'scripts/validate_sliding_rc_stand.py')
checks = importlib.util.module_from_spec(spec)
spec.loader.exec_module(checks)


def check_assembly(executable, output):
    results = []
    for pair in ('body-screw', 'body-desk', 'body-shoe', 'screw-shoe',
                 'cable-default', 'cable-thin', 'cable-large'):
        target = output / f'collision-{pair}.stl'
        target.unlink(missing_ok=True)
        process = subprocess.run(
            [executable, '-o', str(target), '-D', f'check="{pair}"',
             str(HERE / ('cable-clearance.scad' if pair.startswith('cable-')
                         else 'assembly-check.scad'))],
            capture_output=True, text=True, timeout=180)
        log = process.stdout + process.stderr
        (output / f'collision-{pair}.log').write_text(log)
        passed = (process.returncode == 1 and 'Current top level object is empty.' in log
                  and 'ERROR:' not in log and 'WARNING:' not in log and not target.exists())
        results.append({'name': 'collision-' + pair, 'passed': passed,
                        'screw_retraction_mm': 0.01 if pair == 'screw-shoe' else 0})
        print(f"collision-{pair}: {'PASS' if passed else 'FAIL'}", flush=True)
    return results


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--openscad', default='/Applications/OpenSCAD-2021.01.app/Contents/MacOS/OpenSCAD')
    args = parser.parse_args()
    output = HERE / 'exports'
    output.mkdir(exist_ok=True)
    source = HERE / 'desk-headphone-hook.scad'
    source_hash = hashlib.sha256(source.read_bytes()).hexdigest()
    cases = [(part, [f'part="{part}"'], 'stl', None) for part in
             ('body', 'screw', 'shoe', 'thread_sample', 'screw_sample')]
    cases += [
        ('body-thin', ['part="body"', 'desk_thickness=18', 'body_width=36', 'saddle_length=45'], 'stl', None),
        ('body-large', ['part="body"', 'desk_thickness=30', 'body_width=50', 'saddle_length=65'], 'stl', None),
        ('thread-tight', ['part="thread_sample"', 'thread_clearance=0.2', 'thread_axial_clearance=0.1'], 'stl', None),
        ('thread-loose', ['part="thread_sample"', 'thread_clearance=0.6', 'thread_axial_clearance=0.25'], 'stl', None),
    ]
    for name, definition, assertion in [
        ('thin-rejected', 'desk_thickness=17.9', 'desk_thickness'),
        ('thick-rejected', 'desk_thickness=30.1', 'desk_thickness'),
        ('narrow-rejected', 'body_width=35', 'body_width'),
        ('long-rejected', 'saddle_length=66', 'saddle_length'),
        ('tight-rejected', 'thread_clearance=0.19', 'thread_clearance'),
        ('axial-rejected', 'thread_axial_clearance=0.3', 'thread_axial_clearance'),
        ('selector-rejected', 'part="unknown"', 'Unknown part selector'),
    ]:
        cases.append((name, [definition], 'csg', assertion))

    def run(case):
        name, definitions, extension, assertion = case
        result = checks.run_case(args.openscad, source, output, name, definitions,
                                 extension, assertion, timeout=600)
        if result['passed'] and extension == 'stl':
            vertices = [list(map(float, line.split()[1:])) for line in
                        (output / f'{name}.stl').read_text().splitlines()
                        if line.strip().startswith('vertex ')]
            result['bounds_mm'] = [[min(v[i] for v in vertices) for i in range(3)],
                                   [max(v[i] for v in vertices) for i in range(3)]]
            result['bed_flat'] = abs(result['bounds_mm'][0][2]) < 0.001
            result['passed'] = result['bed_flat']
        print(f"{name}: {'PASS' if result['passed'] else 'FAIL'}", flush=True)
        return result

    with ThreadPoolExecutor(max_workers=3) as pool:
        results = list(pool.map(run, cases))
    if all(r['passed'] for r in results):
        results.extend(check_assembly(args.openscad, output))
    unchanged = source_hash == hashlib.sha256(source.read_bytes()).hexdigest()
    report = {'source_sha256': source_hash, 'source_unchanged': unchanged,
              'cases': results, 'passed': unchanged and all(r['passed'] for r in results),
              'physical_fit_load_and_slicing_verified': False}
    (output / 'validation.json').write_text(json.dumps(report, indent=2) + '\n')
    return 0 if report['passed'] else 1


if __name__ == '__main__':
    sys.exit(main())
