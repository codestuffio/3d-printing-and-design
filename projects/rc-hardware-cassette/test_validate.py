"""The public validation CLI must retain its report after renderer failures."""
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

sys.dont_write_bytecode = True
VALIDATOR = Path(__file__).with_name("validate.py")


class FailureReportTest(unittest.TestCase):
    def test_renderer_error_with_zero_exit_still_writes_failed_summary(self):
        with tempfile.TemporaryDirectory(prefix="cassette-cli-test-") as directory:
            base = Path(directory)
            renderer = base / "renderer-error"
            renderer.write_text(
                "#!" + sys.executable + "\n"
                "import sys\n"
                "print('ERROR: intentional renderer failure', file=sys.stderr)\n"
            )
            renderer.chmod(0o700)
            output = base / "evidence"
            result = subprocess.run(
                [sys.executable, str(VALIDATOR), "--openscad", str(renderer),
                 "--output-dir", str(output)], capture_output=True, text=True, timeout=30
            )
            self.assertNotEqual(result.returncode, 0)
            report = output / "summary.json"
            self.assertTrue(report.is_file(), result.stderr)
            summary = json.loads(report.read_text())
            self.assertFalse(summary["passed"])
            defaults = [case for case in summary["cases"] if case["name"].startswith("default-")]
            self.assertTrue(defaults)
            self.assertTrue(all(not case["passed"] for case in defaults))
            dependent = [case for case in summary["cases"] if case["name"].startswith("reject-")]
            self.assertTrue(dependent)
            self.assertTrue(all(not case["passed"] for case in dependent))


if __name__ == "__main__":
    unittest.main()
