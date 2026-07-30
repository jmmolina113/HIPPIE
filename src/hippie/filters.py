"""Filter-stack and detector-response helpers."""
from __future__ import annotations
import numpy as np

def stack_transmission(*transmissions):
    if not transmissions: raise ValueError("at least one transmission curve is required")
    arrays = [np.asarray(v, dtype=float) for v in transmissions]
    if any(a.shape != arrays[0].shape for a in arrays[1:]): raise ValueError("all transmission arrays must have equal shape")
    return np.prod(arrays, axis=0)

def scale_transmission(transmission_at_reference, thickness, reference_thickness):
    if thickness <= 0 or reference_thickness <= 0: raise ValueError("thickness values must be positive")
    transmission = np.asarray(transmission_at_reference, dtype=float)
    if np.any((transmission < 0) | (transmission > 1)): raise ValueError("transmission must lie in [0, 1]")
    return np.power(transmission, float(thickness)/float(reference_thickness))

def interpolate_response(energy, response_energy, response):
    return np.interp(np.asarray(energy, dtype=float), response_energy, response, left=0.0, right=0.0)
