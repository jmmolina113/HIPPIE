"""Validated case configuration for HIPPIE runs.

This module is deliberately dependency-light so a case can be inspected before
the numerical stack is installed.
"""

from __future__ import annotations

from dataclasses import dataclass
import json
from pathlib import Path
from typing import Any


@dataclass(frozen=True)
class PinholePair:
    row: int
    column: int
    paired_column: int


@dataclass(frozen=True)
class CaseConfig:
    name: str
    shot_sequence_port: str
    shot_path: str
    calibration_path: str
    parameters_directory: str
    filter_data_directory: str
    where_to_look: int
    pinhole: PinholePair
    maximum_coordinate_xy: tuple[int, int]
    smoothing_pixels: int
    bin_size_xy: tuple[int, int]
    floor_value: float
    binning: str
    temperature_bounds_eV: tuple[float, float]
    status: str


def _pair(value: Any, *, name: str) -> tuple[int, int]:
    if not isinstance(value, list) or len(value) != 2:
        raise ValueError(f"{name} must be a two-element list")
    result = tuple(int(v) for v in value)
    if any(v < 1 for v in result):
        raise ValueError(f"{name} values must be positive")
    return result


def load_case_config(path: str | Path) -> CaseConfig:
    """Load and validate a HIPPIE JSON case configuration."""

    source = Path(path)
    data = json.loads(source.read_text())
    required = {
        "name", "shot_sequence_port", "shot_path", "calibration_path",
        "parameters_directory", "filter_data_directory", "where_to_look",
        "pinhole", "maximum_coordinate_xy", "smoothing_pixels", "bin_size_xy",
        "floor_value", "binning", "temperature_bounds_eV", "status",
    }
    missing = sorted(required.difference(data))
    if missing:
        raise ValueError(f"missing configuration keys: {', '.join(missing)}")
    where_to_look = int(data["where_to_look"])
    if where_to_look not in (-1, 0, 1):
        raise ValueError("where_to_look must be -1, 0, or 1")
    pinhole_data = data["pinhole"]
    pinhole = PinholePair(
        row=int(pinhole_data["row"]),
        column=int(pinhole_data["column"]),
        paired_column=int(pinhole_data["paired_column"]),
    )
    if min(pinhole.row, pinhole.column, pinhole.paired_column) < 1:
        raise ValueError("pinhole indices must be positive")
    maximum = _pair(data["maximum_coordinate_xy"], name="maximum_coordinate_xy")
    bins = _pair(data["bin_size_xy"], name="bin_size_xy")
    smoothing = int(data["smoothing_pixels"])
    if smoothing < 1:
        raise ValueError("smoothing_pixels must be positive")
    bounds = tuple(float(v) for v in data["temperature_bounds_eV"])
    if len(bounds) != 2 or not bounds[0] < bounds[1]:
        raise ValueError("temperature_bounds_eV must be increasing")
    return CaseConfig(
        name=str(data["name"]),
        shot_sequence_port=str(data["shot_sequence_port"]),
        shot_path=str(data["shot_path"]),
        calibration_path=str(data["calibration_path"]),
        parameters_directory=str(data["parameters_directory"]),
        filter_data_directory=str(data["filter_data_directory"]),
        where_to_look=where_to_look,
        pinhole=pinhole,
        maximum_coordinate_xy=maximum,
        smoothing_pixels=smoothing,
        bin_size_xy=bins,
        floor_value=float(data["floor_value"]),
        binning=str(data["binning"]),
        temperature_bounds_eV=bounds,
        status=str(data["status"]),
    )
