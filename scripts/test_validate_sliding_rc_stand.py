import importlib.util
from pathlib import Path
import tempfile
import unittest


SCRIPT = Path(__file__).with_name("validate_sliding_rc_stand.py")
spec = importlib.util.spec_from_file_location("validator", SCRIPT)
validator = importlib.util.module_from_spec(spec)
spec.loader.exec_module(validator)


def tetrahedron():
    faces = [((0, 0, 0), (0, 1, 0), (1, 0, 0)),
             ((0, 0, 0), (1, 0, 0), (0, 0, 1)),
             ((0, 0, 0), (0, 0, 1), (0, 1, 0)),
             ((1, 0, 0), (0, 1, 0), (0, 0, 1))]
    return "solid test\n" + "".join(
        "facet normal 0 0 0\nouter loop\n" + "".join(
            "vertex %s %s %s\n" % v for v in face
        ) + "endloop\nendfacet\n" for face in faces
    ) + "endsolid test\n"


class ValidatorTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.root = Path(self.temp.name)
        self.addCleanup(self.temp.cleanup)

    def mesh(self, content):
        path = self.root / "hub.stl"
        path.write_text(content)
        return path

    def fake(self, code):
        path = self.root / "fake-openscad"
        path.write_text("#!/usr/bin/env python3\n" + code)
        path.chmod(0o755)
        return str(path)

    def case(self, executable, expected=None, timeout=5):
        return validator.run_case(executable, self.root / "source.scad",
                                  self.root, "case", ["part=\"hub\""],
                                  "csg", expected, timeout)

    def test_closed_mesh(self):
        self.assertEqual(validator.check_mesh(self.mesh(tetrahedron())), 4)

    def test_open_mesh(self):
        content = tetrahedron()
        start = content.index("facet normal")
        end = content.index("endfacet") + len("endfacet\n")
        with self.assertRaises(ValueError):
            validator.check_mesh(self.mesh(content[:start] + content[end:]))

    def test_empty_mesh(self):
        with self.assertRaises(ValueError):
            validator.check_mesh(self.mesh("solid empty\nendsolid empty\n"))

    def test_unterminated_extra_facet(self):
        content = tetrahedron().replace("endsolid test", "facet normal 0 0 0\nouter loop\nvertex 0 0 0\nendsolid test")
        with self.assertRaises(ValueError):
            validator.check_mesh(self.mesh(content))

    def test_trailing_stl_content(self):
        with self.assertRaises(ValueError):
            validator.check_mesh(self.mesh(tetrahedron() + "vertex 1 2 3\n"))

    def test_missing_loop_marker(self):
        with self.assertRaises(ValueError):
            validator.check_mesh(self.mesh(tetrahedron().replace("endloop\n", "", 1)))

    def test_nonfinite_mesh(self):
        with self.assertRaises(ValueError):
            validator.check_mesh(self.mesh(tetrahedron().replace("vertex 0", "vertex nan", 1)))

    def test_zero_exit_error_is_failure(self):
        exe = self.fake("print('ERROR: Parser error', flush=True)\n")
        self.assertFalse(self.case(exe)["passed"])

    def test_expected_assertion_with_zero_exit(self):
        exe = self.fake("print(\"ERROR: Assertion '(spine_length >= 620)' failed\")\n")
        self.assertTrue(self.case(exe, "spine_length")["passed"])

    def test_unrelated_assertion_is_failure(self):
        exe = self.fake("print(\"ERROR: Assertion '(wall >= 5)' failed\")\n")
        self.assertFalse(self.case(exe, "spine_length")["passed"])

    def test_assertion_plus_parser_error_is_failure(self):
        exe = self.fake("print(\"ERROR: Assertion '(spine_length >= 620)' failed\\nERROR: Parser error\")\n")
        self.assertFalse(self.case(exe, "spine_length")["passed"])

    def test_missing_output_is_failure(self):
        self.assertFalse(self.case(self.fake("pass\n"))["passed"])

    def test_valid_csg(self):
        exe = self.fake("import pathlib,sys\npathlib.Path(sys.argv[sys.argv.index('-o')+1]).write_text('cube(size = [1,1,1]);')\n")
        self.assertTrue(self.case(exe)["passed"])

    def test_missing_executable_is_failure(self):
        self.assertFalse(self.case(str(self.root / "missing"))["passed"])

    def test_timeout_is_failure(self):
        self.assertFalse(self.case(self.fake("import time\ntime.sleep(10)\n"), timeout=0.05)["passed"])


if __name__ == "__main__":
    unittest.main()
