#!/usr/bin/env python3
"""Check exported meshes and interface preservation. No physical claims."""
import hashlib, importlib.util, json, subprocess, sys
sys.dont_write_bytecode = True
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
HERE=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('mesh_checks',HERE.parents[1]/'scripts/validate_sliding_rc_stand.py')
checks=importlib.util.module_from_spec(spec); spec.loader.exec_module(checks)
SCAD='/Applications/OpenSCAD-2021.01.app/Contents/MacOS/OpenSCAD'
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
    results=[]
    for name in ('body','screw','shoe','watch-fit-sample','thread_sample','screw_sample'):
        path=HERE/'exports'/f'{name}.stl'
        n=checks.check_mesh(path)
        vertices=[list(map(float,l.split()[1:])) for l in path.read_text().splitlines() if l.strip().startswith('vertex ')]
        bounds=[[f(v[i] for v in vertices) for i in range(3)] for f in (min,max)]
        results.append(dict(name=name,triangles=n,bounds_mm=bounds,passed=abs(bounds[0][2])<0.001))
    def run(name):
        target=HERE/'exports'/f'check-{name}.stl'; target.unlink(missing_ok=True)
        process=subprocess.run([SCAD,'-o',str(target),'-D',f'check="{name}"',str(HERE/'geometry-checks.scad')],capture_output=True,text=True,timeout=300)
        log=process.stdout+process.stderr
        (HERE/'exports'/f'check-{name}.log').write_text(log)
        passed=process.returncode==1 and 'Current top level object is empty.' in log and 'ERROR:' not in log and 'WARNING:' not in log and not target.exists()
        print(name, 'PASS' if passed else 'FAIL',flush=True)
        return dict(name=name,passed=passed)
    names=('body-desk','body-screw','body-shoe','fit-material-removed','fit-material-added','usb-jaw-port','rear-cable','headphone-cables')
    with ThreadPoolExecutor(max_workers=3) as pool: results.extend(pool.map(run,names))
    hashes={str(p.relative_to(HERE)):sha(p) for p in [HERE/'desk-headphone-hook-watch.scad',HERE/'geometry-checks.scad',*sorted((HERE/'reference').glob('*.stl')),*sorted((HERE/'exports').glob('*.stl'))]}
    report=dict(passed=all(r['passed'] for r in results),cases=results,sha256=hashes,physical_print_fit_load_and_slicing_verified=False)
    (HERE/'exports'/'validation.json').write_text(json.dumps(report,indent=2)+'\n')
    return 0 if report['passed'] else 1
if __name__=='__main__': raise SystemExit(main())
