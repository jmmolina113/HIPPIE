# HIPPIE in a published application

The historical HIPPIE MATLAB pipeline is used and described in the appendix of:

> V. Valenzuela-Villaseca *et al.*, “X-ray imaging and electron temperature
> evolution in laser-driven magnetic reconnection experiments at the National
> Ignition Facility,” *Physics of Plasmas* **31**, 082106 (2024).
> [doi:10.1063/5.0213598](https://doi.org/10.1063/5.0213598)

The paper is downstream provenance for this project, not merely a related
citation. Its appendix names HIPPIE and documents the analysis path that the
original MATLAB implementation was built to execute.

## Published analysis path

The paper's appendix maps onto the HIPPIE stages as follows:

1. Select the gated x-ray images, pinhole pairs, filter metadata, and detector
   response for each shot.
2. Subtract background and apply the flat-field correction.
3. Isolate the paired pinhole images, smooth/bin them as configured, and place
   them in a common object-plane coordinate system.
4. Register the pair and form the two-dimensional filtered-intensity ratio.
5. Convolve the thermal-bremsstrahlung model with filter transmission and MCP
   response, then invert the expected-ratio curve pixel by pixel for a
   line-of-sight-averaged electron temperature.
6. Compare redundant filter/pinhole measurements to expose random and
   systematic differences before interpreting plume and current-sheet maps.

The published setup reports 1.75x magnification, 150 micrometre pinholes, and
approximately 240 micrometre object-plane spatial resolution. Its examples
include plume temperatures of about 240 +/- 20 eV at 2 ns and a reconnection
layer near 280 +/- 50 eV at 3 ns. Those values belong to the experiment in the
paper; they are not HIPPIE regression fixtures.

## What this establishes

- The historical MATLAB call graph and the flowchart in this repository
  correspond to a real published diagnostic workflow.
- Differential filtered self-emission ratios can provide spatially resolved,
  line-of-sight-averaged electron-temperature maps under the paper's stated
  assumptions.
- Redundant images are useful for separating finite-photon-statistics noise
  from registration, detector, and other systematic differences.

## Boundaries for the modern port

This publication does not by itself prove numerical equivalence of the new
Python package. The port must still be validated against preserved MATLAB
outputs and explicit test fixtures. In particular, the package should keep
line-of-sight averaging, optically thin thermal-emission assumptions, detector
linearity, filter-stack metadata, finite spatial resolution, and uncertainty
provenance visible in its outputs.

The appendix also records practical details that are useful port requirements:
Gaussian image smoothing, filter-stack transmission multiplication, detector
response convolution, numerical ratio lookup/inversion, and redundant
filter/filter comparison plots. These are implementation requirements only
where the preserved source and test data support them; the paper is not a
license to invent missing calibration constants.

## Related theory reference

The physical ratio model is introduced in
[`THEORY_BACKGROUND_SCHAEFFER2021.md`](THEORY_BACKGROUND_SCHAEFFER2021.md),
which cites the earlier gated-pinhole diagnostic paper by Schaeffer *et al.*
The two papers should be read together: Schaeffer establishes the measurement
model and filter-selection logic, while Valenzuela-Villaseca *et al.* documents
the HIPPIE application and its uncertainty/ensemble-analysis practice.
