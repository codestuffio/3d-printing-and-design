"""Check the public validation command retains evidence on renderer failure."""
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest


class ReportFailure(unittest.TestCase):
    def test_zero_exit_renderer_failure_retains_failed_summary(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            renderer = root / "broken-renderer"
            renderer.write_text("#!" + sys.executable + "\nimport sys\nprint('ERROR: deliberate failure', file=sys.stderr)\n")
            renderer.chmod(0o700)
            out = root / "evidence"
            result = subprocess.run([sys.executable, str(Path(__file__).with_name("validate.py")),
                                     "--openscad", str(renderer), "--output-dir", str(out)],
                                    capture_output=True, text=True, timeout=30)
            self.assertNotEqual(result.returncode, 0)
            self.assertTrue((out / "summary.json").is_file(), result.stderr)
            report = json.loads((out / "summary.json").read_text())
            self.assertFalse(report["passed"])
            self.assertTrue(report["cases"])
            self.assertTrue(all(not case["passed"] for case in report["cases"]
                                if case["name"].startswith(("default-", "reject-", "coupon-"))))


if __name__ == "__main__":
    unittest.main()
