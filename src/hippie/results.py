"""Serializable run results and provenance manifests."""
from __future__ import annotations
from dataclasses import asdict, dataclass, field
import json
from pathlib import Path
from typing import Any
import numpy as np

@dataclass
class RunManifest:
    shot: str
    mode: str
    software_version: str
    source: str | None = None
    dataset: str | None = None
    alignment: dict[str, Any] = field(default_factory=dict)
    settings: dict[str, Any] = field(default_factory=dict)
    status: str = "complete"
    def write(self, path: str | Path):
        destination = Path(path); destination.parent.mkdir(parents=True, exist_ok=True)
        destination.write_text(json.dumps(asdict(self), indent=2, default=str) + "\n")

@dataclass
class TemperatureResult:
    temperature_eV: np.ndarray
    measured_ratio: np.ndarray
    modeled_ratio: np.ndarray
    manifest: RunManifest
    def save(self, directory: str | Path):
        destination = Path(directory); destination.mkdir(parents=True, exist_ok=True)
        np.savez_compressed(destination / "temperature_result.npz", temperature_eV=self.temperature_eV, measured_ratio=self.measured_ratio, modeled_ratio=self.modeled_ratio)
        self.manifest.write(destination / "manifest.json")
