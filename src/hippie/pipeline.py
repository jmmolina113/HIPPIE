"""Small, explicit processing stages for HIPPIE experiments."""

from __future__ import annotations

from dataclasses import dataclass
import numpy as np

from .preprocess import calibrate_image, registered_ratio


@dataclass(frozen=True)
class RatioResult:
    numerator: np.ndarray
    denominator: np.ndarray
    ratio: np.ndarray
    mode: str = "legacy-compatible"


def form_ratio(numerator, denominator, *, background=None, flatfield=None, floor=0.0):
    """Prepare two paired pinhole images and return their ratio manifest."""
    first = calibrate_image(numerator, background=background, flatfield=flatfield, floor=floor)
    second = calibrate_image(denominator, background=background, flatfield=flatfield, floor=floor)
    return RatioResult(first, second, registered_ratio(first, second, floor=floor))
