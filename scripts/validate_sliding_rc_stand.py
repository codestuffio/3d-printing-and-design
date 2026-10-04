#!/usr/bin/env python3
"""Export and check both sliding RC stand hubs without changing CAD sources."""

import argparse
from collections import Counter, defaultdict
import hashlib
import json
import math
from pathlib import Path
import re
import shutil
import subprocess
import tempfile


PROJECT = Path(__file__).resolve().parents[1] / "projects/sliding-x-rc-plane-stand"
SOURCES = ("sliding-x-rc-plane-stand.scad", "flush-sleeve-hub.scad")


def check_mesh(path):
    """Require a nonempty, closed, consistently wound, connected ASCII STL."""
    lines = [line.strip() for line in path.read_text(encoding="ascii").splitlines()
             if line.strip()]
    if (len(lines) < 2 or lines[0].split()[0] != "solid"
            or lines[-1].split()[0] != "endsolid" or (len(lines) - 2) % 7):
        raise ValueError("Malformed ASCII STL structure")
    if len(lines) == 2:
        raise ValueError("STL has no triangles")
    edges = Counter()
    directions = Counter()
    neighbors = defaultdict(set)
    for index in range(1, len(lines) - 1, 7):
        facet = [line.split() for line in lines[index:index + 7]]
        if (facet[0][:2] != ["facet", "normal"] or len(facet[0]) != 5
                or facet[1] != ["outer", "loop"] or facet[5] != ["endloop"]
                or facet[6] != ["endfacet"]
                or any(len(v) != 4 or v[0] != "vertex" for v in facet[2:5])):
            raise ValueError("Malformed STL triangle")
        normal = tuple(float(n) for n in facet[0][2:])
        vertices = [tuple(float(n) for n in v[1:]) for v in facet[2:5]]
        if not all(math.isfinite(n) for v in [normal, *vertices] for n in v):
            raise ValueError("STL contains nonfinite coordinates")
        a, b, c = vertices
        u, v = tuple(b[i] - a[i] for i in range(3)), tuple(c[i] - a[i] for i in range(3))
        cross = (u[1]*v[2]-u[2]*v[1], u[2]*v[0]-u[0]*v[2], u[0]*v[1]-u[1]*v[0])
        if sum(n*n for n in cross) == 0:
            raise ValueError("STL contains a degenerate triangle")
        for start, end in ((a, b), (b, c), (c, a)):
            edge = tuple(sorted((start, end)))
            edges[edge] += 1
            directions[edge] += 1 if start < end else -1
            neighbors[start].add(end)
            neighbors[end].add(start)
    if any(count != 2 for count in edges.values()):
        raise ValueError("STL has open or nonmanifold edges")
    if any(directions.values()):
        raise ValueError("STL has inconsistent winding")
    seen, pending = set(), [next(iter(neighbors))]
    while pending:
        vertex = pending.pop()
        if vertex not in seen:
            seen.add(vertex)
            pending.extend(neighbors[vertex] - seen)
    if len(seen) != len(neighbors):
        raise ValueError("Hub STL has disconnected components")
    return (len(lines) - 2) // 7


def run_case(executable, source, output, name, definitions, extension,
             expected_assertion=None, timeout=180):
    target = output / f"{name}.{extension}"
    # A rerun must not treat a stale export as new evidence.
    target.unlink(missing_ok=True)
    command = [executable, "-o", str(target)]
    if extension == "stl":
        command.extend(["--export-format", "asciistl"])
    for definition in definitions:
        command.extend(["-D", definition])
    command.append(str(source))
    result = {"name": name, "source": source.name, "definitions": definitions,
              "expected_assertion": expected_assertion, "passed": False}
    diagnostic = ""
    try:
        process = subprocess.run(command, capture_output=True, text=True, timeout=timeout)
        diagnostic = process.stdout + process.stderr
        result["exit_code"] = process.returncode
        errors = [line for line in diagnostic.splitlines() if line.startswith("ERROR:")]
        warnings = [line for line in diagnostic.splitlines() if line.startswith("WARNING:")]
        if expected_assertion:
            # CSG assertion failures can exit zero. Require the intended assertion,
            # and reject unrelated parser/runtime errors rather than counting them.
            result["passed"] = (process.returncode in (0, 1) and bool(errors)
                                and not warnings and all(
                "Assertion" in line and expected_assertion in line for line in errors))
            if not result["passed"]:
                result["failure"] = "Expected assertion was absent or another error occurred"
        else:
            if process.returncode != 0 or errors or warnings:
                raise ValueError("OpenSCAD reported an error, warning or nonzero exit")
            if not target.is_file() or target.stat().st_size == 0:
                raise ValueError("OpenSCAD did not produce a nonempty export")
            if extension == "stl":
                if not re.search(r"Simple:\s+yes\b", diagnostic):
                    raise ValueError("OpenSCAD did not report a simple mesh")
                if not re.search(r"Volumes:\s+2\b", diagnostic):
                    raise ValueError("Hub must have one solid plus the exterior volume")
                result["triangles"] = check_mesh(target)
            result["passed"] = True
    except (OSError, ValueError, subprocess.TimeoutExpired) as error:
        result["failure"] = str(error)
    (output / f"{name}.log").write_text(diagnostic + result.get("failure", "") + "\n")
    return result


def resolve_openscad(requested):
    if requested:
        return shutil.which(requested)
    executable = shutil.which("openscad")
    if executable:
        return executable
    for app in ("OpenSCAD", "OpenSCAD-2021.01"):
        executable = shutil.which(f"/Applications/{app}.app/Contents/MacOS/OpenSCAD")
        if executable:
            return executable
    return None


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--openscad", help="OpenSCAD executable name or path")
    parser.add_argument("--output-dir", type=Path, help="New directory for exports, logs and summary")
    args = parser.parse_args()
    executable = resolve_openscad(args.openscad)
    if not executable:
        parser.exit(1, "OpenSCAD executable unavailable; install it or pass --openscad PATH.\n")
    try:
        if args.output_dir:
            output = args.output_dir.resolve()
            output.mkdir(parents=True, exist_ok=False)
        else:
            output = Path(tempfile.mkdtemp(prefix="sliding-rc-validation-"))
    except OSError as error:
        parser.exit(1, f"Cannot create a fresh output directory: {error}\n")
    results, hashes = [], {}
    for source_name in SOURCES:
        source = PROJECT / source_name
        try:
            hashes[source_name] = hashlib.sha256(source.read_bytes()).hexdigest()
        except OSError as error:
            parser.exit(1, f"Cannot read CAD source: {error}\n")
        prefix = source.stem
        cases = [
            ("hub", ['part="hub"'], "stl", None),
            ("spacing-500", ['part="assembly"', "station_spacing=500"], "csg", None),
            ("spacing-501", ['part="assembly"', "station_spacing=501"], "csg", "spine_length"),
            ("spacing-120", ['part="assembly"', "station_spacing=120"], "csg", "station_spacing"),
            ("drop-20", ['part="hub"', "spine_drop=20"], "csg", "spine_drop"),
            ("unknown-part", ['part="bad_selector"'], "csg", "Unknown part selector"),
        ]
        for name, definitions, extension, assertion in cases:
            result = run_case(executable, source, output, f"{prefix}-{name}",
                              definitions, extension, assertion)
            results.append(result)
            print(f"{'PASS' if result['passed'] else 'FAIL'} {result['name']}", flush=True)
    summary = {"openscad": executable, "source_sha256": hashes, "cases": results,
               "passed": all(result["passed"] for result in results)}
    (output / "summary.json").write_text(json.dumps(summary, indent=2) + "\n")
    print(f"Evidence: {output}")
    print("CAD checks only. Slicer supports, physical fit and strength still need testing.")
    return 0 if summary["passed"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
