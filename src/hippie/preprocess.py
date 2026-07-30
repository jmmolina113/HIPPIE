"""Detector preparation primitives shared by legacy and corrected modes."""

from __future__ import annotations

import numpy as np


def calibrate_image(raw, background=None, flatfield=None, floor=0.0):
    """Subtract background, divide by flatfield, and apply a signal floor."""
    image = np.asarray(raw, dtype=float)
    if background is not None:
        background = np.asarray(background, dtype=float)
        if background.shape != image.shape:
            raise ValueError("background shape must match raw image")
        image = image - background
    if flatfield is not None:
        flatfield = np.asarray(flatfield, dtype=float)
        if flatfield.shape != image.shape:
            raise ValueError("flatfield shape must match raw image")
        if np.any(flatfield <= 0):
            raise ValueError("flatfield values must be positive")
        image = image / flatfield
    return np.maximum(image, float(floor))


def registered_ratio(numerator, denominator, floor=0.0):
    """Form a safe pixelwise ratio after pair registration."""
    numerator = np.asarray(numerator, dtype=float)
    denominator = np.asarray(denominator, dtype=float)
    if numerator.shape != denominator.shape:
        raise ValueError("registered images must have equal shape")
    valid = denominator > floor
    return np.divide(numerator, denominator, out=np.full_like(numerator, np.nan), where=valid)
