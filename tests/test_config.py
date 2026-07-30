from pathlib import Path

from hippie.config import load_case_config


ROOT = Path(__file__).parents[1]


def test_golden_case_loads():
    config = load_case_config(ROOT / "config" / "golden_case_n210317_002.json")
    assert config.name.startswith("N210317-002")
    assert config.pinhole.row == 2
    assert config.pinhole.paired_column == 2
    assert config.temperature_bounds_eV == (100.0, 10000.0)
