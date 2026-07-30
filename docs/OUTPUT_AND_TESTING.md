# Output and testing contract

Every HIPPIE run will write a manifest alongside its outputs. At minimum it
will identify the shot, calibration, parameter and filter tables, processing
mode, software revision, alignment shifts, temperature grid, uncertainty
settings, and completion status.

Validation proceeds in layers:

1. configuration and path validation;
2. HDF5 dataset shape and metadata checks;
3. stage-level MATLAB/Python array comparisons;
4. end-to-end golden-case comparison;
5. post-analysis figure and table inspection.

A generated file is not evidence of scientific validity by itself. A run must
also carry the diagnostics needed to explain how it was produced.
