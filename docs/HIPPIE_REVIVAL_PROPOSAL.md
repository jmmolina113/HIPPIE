# HIPPIE revival proposal

## Objective

Turn the original MATLAB research pipeline into a reproducible, testable
software package while preserving the MATLAB implementation as the reference
against which the Python port is judged.

## Architecture

```text
HDF5 + parameter tables
        |
        v
detector preparation -----> provenance manifest
        |
        v
pinhole geometry ----------> selection diagnostics
        |
        v
registration --------------> shift/confidence diagnostics
        |
        v
ratio + uncertainty
        |
        +----> response/filter theory ----> temperature inversion
                                             |
                                             v
                         maps, lineouts, averages, exports
```

The package will expose both a high-level `run_case()` entry point and small
stage functions so that a scientist can inspect or replace any stage.

## Implementation sequence

### 1. Freeze a reference case

Use `config/golden_case_n210317_002.json`. Extract the needed archive members
without altering the source archive. Record input hashes, dataset shapes,
parameter-table rows, and the MATLAB output artifacts.

### 2. Port MATLAB behavior literally

Implement HDF5 reads, pre-shot subtraction, flooring, mirror operations,
flat-fielding, pinhole extraction, legacy alignment, filter transmission,
detector response, integration, ratio inversion, and post-analysis. Preserve
historical constants behind named configuration fields.

### 3. Add a compatibility report

For each stage, compare MATLAB and Python arrays with tolerances and record
shape, NaN mask, extrema, alignment shifts, ratio statistics, and temperature
differences. A mismatch is a report item, not something to hide with a new
default.

### 4. Add corrected mode

Only after legacy parity exists, add dimension-aware geometry, explicit rotation,
safe filter-table loading, robust parameter validation, quantitative alignment
confidence, and named uncertainty components.

### 5. Port post-analysis completely

Include temperature-map plotting, lineout generation, target-edge cropping,
region averaging, error summaries, shot-to-shot comparisons, and export to
portable NumPy/CSV/PNG/JSON artifacts. Every exported result receives a run
manifest pointing back to the source shot, calibration, parameter rows, and
software version.

### 6. Validate scientifically

Use the historical benchmark cases in the MATLAB scripts and presentations,
then compare trends against the SULI/PPPL reported values and, where available,
Thomson-scattering benchmarks. This validates behavior; it does not prove the
underlying plasma model beyond its assumptions.

## Proposed Python layout

```text
src/hippie/
  io.py              # HDF5 and table readers
  config.py           # validated case configuration
  calibration.py     # background, mirror, flat-field
  geometry.py        # pinhole grid and extraction
  alignment.py       # legacy and corrected registration
  filters.py         # transmission and detector response
  theory.py          # emissivity-weighted integrations
  inversion.py       # ratio-to-temperature mapping
  postprocess.py     # maps, lineouts, averages, exports
  pipeline.py         # orchestration and run manifests
```

The initial scaffold intentionally contains no replacement physics yet. That
keeps the provenance boundary honest while the MATLAB reference is being
ported stage by stage.
