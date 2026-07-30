# Theory background: differential-filter x-ray pinhole thermometry

HIPPIE is a software reconstruction of the diagnostic method described by
Schaeffer et al., *Measurements of Electron Temperature in High-Energy-Density
Plasmas using Gated X-Ray Pinhole Imaging*, Review of Scientific Instruments
92, 043524 (2021), DOI [10.1063/5.0043833](https://doi.org/10.1063/5.0043833).
The open OSTI record and full text are [OSTI 1810690](https://www.osti.gov/biblio/1810690).

This paper is the theory reference for HIPPIE. The MATLAB source remains the
behavioral reference for the software implementation.

## Physical measurement

The diagnostic records self-emitted x-ray bremsstrahlung from a laser-driven
plasma through neighboring pinholes covered by different filter stacks. The
two images are acquired by the same gated detector system, so the useful
temperature information is in their relative attenuation rather than their
absolute brightness.

For an optically thin, approximately Maxwellian plasma, the continuum
emissivity can be written in the proportional form

```text
j(E, T_e) ∝ n_e^2 sqrt(T_e) exp(-E / T_e),
```

when photon energy and electron temperature are expressed in the same energy
units. The exact prefactor is not needed for the differential-filter ratio;
the density and common geometric factors cancel under the matched-view
assumptions.

## Pinhole and detector model

For a pinhole of diameter `a` at source distance `d`, the paper uses the small-
angle solid-angle approximation

```text
Ω_ph ≈ π a² / (4 d²).
```

The photon signal per detector area is proportional to

```text
N / dA ∝ Ω_ph V τ / dA ∫ j(E, T_e) K(E) dE,
```

where `V` is the line-of-sight emitting volume, `τ` is the gate duration, and
`K(E)` is the detector response. A filter with transmission `W_i(E)` adds its
response inside the same integral.

For two pinholes or filter channels, the model ratio is therefore

```text
R(T_e) = N_1 / N_2
       = ∫ j(E, T_e) K(E) W_1(E) dE
         --------------------------------
         ∫ j(E, T_e) K(E) W_2(E) dE.
```

HIPPIE evaluates this function over a temperature grid and inverts the
measured ratio. The grid search is a numerical implementation choice; the
physical observable is the ratio above.

## Why calibration and registration are not optional

The paper describes background subtraction followed by division by a
mean-normalized flat-field image. This corrects strip- and detector-response
variation before comparing channels. HIPPIE's `ReadHDF5Data` and
`MakeProcessedData` lineage implements the same conceptual boundary.

The two pinhole images must also refer to the same source coordinates. A small
relative displacement can create a false ratio gradient, especially at sharp
plume or target edges. The historical HIPPIE code addresses this by selecting
landmarks, aligning the images, and estimating ratio bounds from small spatial
shifts. The modern package will retain the shifts and alignment diagnostics in
the run manifest rather than reducing them to an unexplained error bar.

## Line-of-sight assumption

The paper assumes negligible temperature gradients along the viewing direction
for the demonstrated cases. Under that assumption, line-of-sight integration
changes the photon count but not the ratio's temperature interpretation. If
temperature varies strongly along the line of sight, the correct model is a
weighted integral over the temperature distribution rather than a single
`T_e`; HIPPIE must report that as a model limitation, not silently fit an
effective temperature and call it local.

## Filter choice and temperature resolution

Filter selection is a signal-to-contrast tradeoff:

- filters that are too similar produce little ratio contrast;
- filters that are too thick suppress the signal through the high-filter
  channel;
- at high temperature, some ratio curves flatten, so small ratio errors map to
  large temperature errors;
- increasing the difference in filter thickness broadens the useful temperature
  range only while both channels remain measurable and within detector linearity.

This motivates HIPPIE's separation of filter transmission, detector response,
signal uncertainty, and inversion resolution. A temperature result outside the
well-conditioned portion of `R(T_e)` should be flagged even if a numerical
inverse exists.

## What HIPPIE inherits and what it adds

The MATLAB pipeline inherits the paper's core model: paired filtered images,
flat-field correction, a detector response function, filter transmission, and
ratio-based temperature inversion. HIPPIE adds explicit software boundaries
around those assumptions:

1. source and calibration provenance;
2. canonical pinhole geometry and registration diagnostics;
3. separate uncertainty components;
4. conditioning and out-of-range flags for the inversion;
5. MATLAB/Python parity reports before modernization is treated as equivalent.

The paper validates the diagnostic method for its demonstrated HED-plasma
conditions. It does not by itself validate every later shot, every filter
combination, or every automated alignment choice in HIPPIE.
