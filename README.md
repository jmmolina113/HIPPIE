# HIPPIE

<p align="center">
  <strong>High-energy Imaging Pinhole Pipeline for Inference of Electron temperature</strong>
</p>

<p align="center">
  A MATLAB-reference and Python-portable analysis pipeline for filtered,
  gated x-ray pinhole images from high-energy-density plasma experiments.
</p>

HIPPIE is the **X-ray Pinhole Imaging Pipeline** developed from the SULI/PPPL
magnetic-reconnection work. The name is intentionally retained: this is the
same project, rebuilt with a cleaner public structure.

The MATLAB implementation is the reference framework. The Python package is
not allowed to silently change the scientific contract: every modernization is
paired with a legacy comparison, a documented assumption, and a validation
case.

## Current status

This is the isolated revival workspace. The original archive remains on the
user-owned research drive; its local path is deliberately not embedded in the
public repository.

No files in that archive or on the external drive are modified by this
workspace. The public package now includes executable calibration,
registration, filter-stack, theory/inversion, HDF5 inspection, result-manifest,
and post-analysis stages. Shot-specific MATLAB/Python numerical parity remains
pending until the raw HDF5 data and calibration tables are made available to a
reproducible test run.

The first golden case is the N210317-002 shot with the corresponding
N180916-003 calibration. Its paths are recorded in
`config/golden_case_n210317_002.json`; the data are intentionally not copied
into this repository.

## Planned package layers

1. **I/O and provenance** — HDF5 ingestion, metadata tables, filter tables, and
   immutable run manifests.
2. **Detector preparation** — pre-shot subtraction, non-negative flooring,
   mirror/rotation transforms, and flat-fielding.
3. **Pinhole geometry** — grid selection, smoothing, peak localization, and
   extraction into a canonical coordinate frame.
4. **Registration** — horizontal and vertical alignment with explicit shift
   diagnostics and failure states.
5. **Signal and theory** — ratios, binning, filter transmission, detector
   response, emissivity integration, and temperature inversion.
6. **Post-analysis** — maps, lineouts, region averages, uncertainty summaries,
   comparison plots, and exportable result manifests.

See `docs/HIPPIE_ARCHAEOLOGY.md` and `docs/HIPPIE_REVIVAL_PROPOSAL.md` for the
source-grounded study and implementation plan.

## Measurement contract

HIPPIE estimates an electron-temperature field from two spatially registered
images formed through different filter responses. In the simplest form,

```text
S(x, y) = N_high-filter(x, y) / N_low-filter(x, y)
```

The theoretical ratio is the corresponding ratio of detector- and
filter-weighted emissivity integrals:

```text
R(T_e) = ∫ j(E, T_e) K(E) W_high(E) dE
         --------------------------------
         ∫ j(E, T_e) K(E) W_low(E) dE
```

where `j` is the bremsstrahlung emissivity model, `K` is the detector response,
and `W` is the filter transmission. The inversion finds the temperature whose
`R(T_e)` matches the measured `S`.

## MATLAB reference workflow

The historical MATLAB framework is preserved under `matlab/reference/`.
The intended modern entry point will make the data and parameter paths
explicit, then run the stages in order:

```matlab
case = hippie.configure("config/golden_case_n210317_002.json");
hippie.describe(case);
preview = hippie.preview(case);
result = hippie.run(case);
analysis = hippie.post.analyze(result);
```

The exact API is being implemented against the existing MATLAB call graph,
not invented independently of it.

## Python package

The Python port will expose the same stages through `src/hippie/`, including
HDF5 I/O, calibration, pinhole extraction, registration, filter theory,
temperature inversion, maps, lineouts, region averages, and exports. The
`legacy` directory contains the original PlasmaPy notebooks and documentation
for comparison; it is not silently treated as a validated replacement.

## Repository layout

| Path | Purpose |
|---|---|
| `matlab/reference/` | SULI 2021, PPPL 2022, and Spring 2023 MATLAB lineage |
| `src/hippie/` | Modern Python package and explicit processing stages |
| `legacy/python_notebooks/` | Original PlasmaPy port and interactive notebooks |
| `legacy/documentation/` | Preserved PPPL presentations and explanatory material |
| `config/` | Portable case definitions and golden validation inputs |
| `docs/` | Archaeology, theory, architecture, and revival documentation |
| `tests/` | Cross-stage and MATLAB/Python parity tests |

## Provenance and validation

HIPPIE separates historical reproduction from modernization. A result must
identify its source shot, calibration, parameter tables, filter data, software
revision, processing mode, and uncertainty settings. Legacy parity is required
before corrected behavior becomes a default.

The external archive is the preserved source record. It is not part of this
repository and is never modified by the HIPPIE build process.
