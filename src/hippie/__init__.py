"""HIPPIE: X-ray Pinhole Imaging Pipeline.

The package is being ported in two explicit modes:

``legacy``
    Reproduce the historical MATLAB behavior for comparison.
``corrected``
    Apply documented, opt-in fixes and dimension-aware behavior.
"""

from .config import CaseConfig, load_case_config

__all__ = ["CaseConfig", "load_case_config"]
__version__ = "0.1.0.dev0"
