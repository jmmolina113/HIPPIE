# HIPPIE user guide

HIPPIE is a reference-preserving Python package. Begin with the case definition:

```python
from hippie import load_case_config

case = load_case_config("config/golden_case_n210317_002.json")
print(case.shot_sequence_port)
```

The low-level stages are usable without private shot data:

```python
from hippie import calibrate_image, ratio_curve, invert_ratio
from hippie.post import summarize_region
```

Use `hippie-datasets path/to/shot.h5` to inspect candidate HDF5 image datasets
before selecting one explicitly. The package never overwrites source files;
write derived arrays and `manifest.json` to a separate output directory.

The numerical pipeline will be added behind this stable configuration boundary.
Data paths should point to a local, authorized copy of the shot and calibration
files; no research data are bundled in the repository.

For historical MATLAB behavior, consult the scripts under
`matlab/reference/`. Those scripts are preserved as evidence and still contain
the assumptions and exploratory plotting of the original project.
