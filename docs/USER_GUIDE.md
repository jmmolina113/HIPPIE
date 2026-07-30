# HIPPIE user guide

HIPPIE is currently being ported in stages. Begin with the case definition:

```python
from hippie import load_case_config

case = load_case_config("config/golden_case_n210317_002.json")
print(case.shot_sequence_port)
```

The numerical pipeline will be added behind this stable configuration boundary.
Data paths should point to a local, authorized copy of the shot and calibration
files; no research data are bundled in the repository.

For historical MATLAB behavior, consult the scripts under
`matlab/reference/`. Those scripts are preserved as evidence and still contain
the assumptions and exploratory plotting of the original project.
