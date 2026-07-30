"""Post-analysis summaries that preserve masks and sample counts."""
from __future__ import annotations
from dataclasses import dataclass
import numpy as np

@dataclass(frozen=True)
class RegionSummary:
    count: int
    mean_eV: float
    median_eV: float
    standard_deviation_eV: float

def summarize_region(temperature_eV, mask=None):
    values = np.asarray(temperature_eV, dtype=float)
    if mask is not None:
        mask = np.asarray(mask, dtype=bool)
        if mask.shape != values.shape: raise ValueError("mask must match temperature map")
        values = values[mask]
    values = values[np.isfinite(values)]
    if values.size == 0: return RegionSummary(0, float("nan"), float("nan"), float("nan"))
    return RegionSummary(int(values.size), float(values.mean()), float(np.median(values)), float(values.std(ddof=1)) if values.size > 1 else 0.0)

def center_lineout(image, axis=0):
    image = np.asarray(image, dtype=float)
    if image.ndim != 2 or axis not in (0, 1): raise ValueError("image must be 2D and axis must be 0 or 1")
    index = image.shape[1-axis] // 2
    return image[:, index] if axis == 0 else image[index, :]

def temperature_interval(measured_ratio, ratio_low, ratio_high, temperatures):
    """Return inversion bounds from a ratio interval using the same lookup grid."""
    from .theory import invert_ratio
    return (invert_ratio(ratio_low, temperatures, measured_ratio), invert_ratio(ratio_high, temperatures, measured_ratio))
