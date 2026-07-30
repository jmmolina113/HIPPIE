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
from .geometry import Registration, bin_image, gaussian_smooth, register_by_cross_correlation
from .filters import interpolate_response, scale_transmission, stack_transmission
from .io import ImageSet, discover_datasets, read_hdf5_images
from .results import RunManifest, TemperatureResult
from .post import RegionSummary, center_lineout, summarize_region, temperature_interval

__all__ = [
    "CaseConfig", "load_case_config", "RatioResult", "form_ratio",
    "calibrate_image", "registered_ratio", "bremsstrahlung_spectrum",
    "filtered_signal", "invert_ratio", "ratio_curve",
    "Registration", "bin_image", "gaussian_smooth", "register_by_cross_correlation",
    "interpolate_response", "scale_transmission", "stack_transmission",
    "ImageSet", "discover_datasets", "read_hdf5_images", "RunManifest", "TemperatureResult",
    "RegionSummary", "center_lineout", "summarize_region", "temperature_interval",
]
__version__ = "0.1.0.dev0"
