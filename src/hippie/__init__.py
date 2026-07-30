"""HIPPIE: X-ray Pinhole Imaging Pipeline.

The package is being ported in two explicit modes:

``legacy``
    Reproduce the historical MATLAB behavior for comparison.
``corrected``
    Apply documented, opt-in fixes and dimension-aware behavior.
"""

from .config import CaseConfig, load_case_config
from .pipeline import RatioResult, form_ratio
from .preprocess import calibrate_image, registered_ratio
from .theory import bremsstrahlung_spectrum, filtered_signal, invert_ratio, ratio_curve

__all__ = [
    "CaseConfig", "load_case_config", "RatioResult", "form_ratio",
    "calibrate_image", "registered_ratio", "bremsstrahlung_spectrum",
    "filtered_signal", "invert_ratio", "ratio_curve",
]
__version__ = "0.1.0.dev0"
