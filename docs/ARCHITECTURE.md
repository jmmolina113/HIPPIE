# HIPPIE architecture

HIPPIE keeps the reference MATLAB call graph visible while the Python package
adds explicit data objects and provenance.

```text
case configuration
      |
      v
read HDF5 + parameter tables
      |
      v
background subtraction -> flat-field calibration -> mirror/rotation
      |
      v
4x4 pinhole grid -> selected pair -> canonical 1051-pixel frame
      |
      v
vertical target-edge alignment -> horizontal feature alignment
      |
      v
registered images -> ratio and spatial error bounds
      |
      v
filter/detector-weighted theory -> temperature inversion
      |
      v
maps, lineouts, averages, figures, and manifests
```

The pipeline has two execution modes:

- `legacy`: reproduce the historical MATLAB assumptions for comparison;
- `corrected`: enable dimension-aware geometry, explicit rotations, safe table
  loading, and quantitative alignment diagnostics.

No corrected mode is considered validated until it has a comparison report
against the MATLAB reference case.
