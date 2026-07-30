"""Dimension-aware smoothing, binning, and image registration."""
from __future__ import annotations
from dataclasses import dataclass
import numpy as np

def gaussian_smooth(image, sigma: float):
    image = np.asarray(image, dtype=float)
    if sigma <= 0: return image.copy()
    try:
        from scipy.ndimage import gaussian_filter
        return gaussian_filter(image, sigma=sigma)
    except ImportError:
        radius = max(1, int(np.ceil(3 * sigma))); axis = np.arange(-radius, radius + 1, dtype=float)
        kernel = np.exp(-(axis ** 2) / (2 * sigma ** 2)); kernel /= kernel.sum(); result = image
        for axis_index in range(image.ndim):
            result = np.apply_along_axis(lambda v: np.convolve(v, kernel, mode="same"), axis_index, result)
        return result

def bin_image(image, bin_size, method="mean"):
    image = np.asarray(image, dtype=float); by, bx = (int(v) for v in bin_size)
    if by < 1 or bx < 1: raise ValueError("bin dimensions must be positive")
    height, width = image.shape[-2:]; trimmed = image[..., :height-height % by, :width-width % bx]
    reshaped = trimmed.reshape(*trimmed.shape[:-2], trimmed.shape[-2]//by, by, trimmed.shape[-1]//bx, bx)
    if method == "mean": return reshaped.mean(axis=(-1, -3))
    if method == "sum": return reshaped.sum(axis=(-1, -3))
    raise ValueError("method must be 'mean' or 'sum'")

@dataclass(frozen=True)
class Registration:
    shift_y: int
    shift_x: int
    score: float

def register_by_cross_correlation(reference, moving, max_shift=50):
    reference = np.asarray(reference, dtype=float); moving = np.asarray(moving, dtype=float)
    if reference.shape != moving.shape or reference.ndim != 2: raise ValueError("registration requires equal-shaped 2D images")
    ref = reference - np.nanmean(reference); best = Registration(0, 0, -np.inf)
    for dy in range(-int(max_shift), int(max_shift)+1):
        for dx in range(-int(max_shift), int(max_shift)+1):
            ys = slice(max(0, dy), min(ref.shape[0], ref.shape[0]+dy)); xs = slice(max(0, dx), min(ref.shape[1], ref.shape[1]+dx))
            ym = slice(max(0, -dy), min(ref.shape[0], ref.shape[0]-dy)); xm = slice(max(0, -dx), min(ref.shape[1], ref.shape[1]-dx))
            a, b = ref[ys, xs], moving[ym, xm] - np.nanmean(moving[ym, xm]); denom = np.linalg.norm(a) * np.linalg.norm(b)
            score = float(np.sum(a*b)/denom) if denom else -np.inf
            if score > best.score: best = Registration(dy, dx, score)
    return best
