# SULI 2021 report: measurement model and original workflow

The first-party report *Measurement of Electron Temperature in High Energy
Density Magnetic Reconnection Experiments* (J. M. Molina, D. B. Schaeffer,
and W. Fox, 18 September 2021) documents the experiment and the earliest
end-to-end HIPPIE analysis. The source PDF is retained in the project archive;
this note records the scientific content relevant to the public code without
redistributing the report.

## Experimental question

The experiment collided two laser-driven plasma plumes carrying oppositely
directed Biermann-battery magnetic fields. A face-on gated x-ray detector
viewed the reconnection layer while a side-on detector viewed the expanding
plumes. Each gated x-ray detector combined a pinhole array, a strip-filter
array, and an MCP/CCD framing camera. Neighboring strips were gated at the same
time but covered by different filter thicknesses, so they supplied the paired
images needed for differential-filter thermometry.

The 2021 analysis used multiple NIF shots to reconstruct an 8 ns temperature
history. It reported a rapid rise after plume collision, a peak spatially
averaged electron temperature of approximately 280 eV near 3 ns, and slower
cooling afterward. These values are historical results from that campaign, not
bundled regression targets for the Python package.

## Response model

For photon frequency `nu`, electron temperature `T_e`, electron density `n_e`,
detector response `D(nu)`, and filter transmission `W_i(nu)`, the report first
introduces the thermal bremsstrahlung shape

```text
j(nu, T_e) proportional to n_e^2 T_e^(-1/2) exp(-h nu / T_e).
```

The temperature-dependent model ratio is

```text
R(T_e) = integral j(nu,T_e) D(nu) W_1(nu) dnu
         ------------------------------------------------.
         integral j(nu,T_e) D(nu) W_2(nu) dnu
```

The implementation section records the more specific spectral approximation
used in the original calculation,

```text
j(nu,T_e) proportional to K_0(-h nu / T_e)
                         n_e^2 T_e^(-1) exp(-h nu / T_e),
```

where `K_0` is a modified Bessel function. The sign shown in the report's
argument is reproduced here as historical provenance; a physical
implementation should resolve the argument convention against the reference
method and executable MATLAB before using this form. The present Python helper
uses the simpler exponential continuum shape, so Bessel-corrected parity with
the SULI calculation is not currently claimed.

For a reference filter transmission `T_s` tabulated at thickness `d_s`, the
report rescales to thickness `d` using Beer-Lambert composition:

```text
T(E; d) = T_s(E)^(d / d_s).
```

This is the same multiplicative optical-depth rule used when HIPPIE combines
or rescales filter layers.

## From detector image to measured ratio

The original workflow made the comparison in the following order:

1. subtract a no-plasma background image;
2. divide by a calibration image to correct detector nonuniformity;
3. divide the 4200 x 4200 detector image into pinhole unit cells;
4. isolate the like-time-gated, differently filtered pinhole pair;
5. place the selected region-of-interest maximum at a common image coordinate;
6. average approximately 300 micrometres across each vertical lineout;
7. translate one normalized lineout over a search window and minimize the area
   enclosed by the two curves;
8. remove residual baseline using the mean of the lineout tail;
9. form the high-filter/low-filter signal ratio over a 1-2 mm analysis region.

Writing the aligned signals as `L_1(z)` and `L_2(z)`, the measured ratio is

```text
S(z) = L_1(z) / L_2(z).
```

The 2021 scalar estimate used the mean ratio over a region with no resolved
ratio structure and found the temperature satisfying `R(T_e) = mean(S)`. If
the ratio varies spatially, averaging is not innocuous: the later 2D pipeline
instead inverts the registered ratio field to obtain a temperature map.

## Uncertainty construction

The report separates three experimental sensitivity channels.

### Filter thickness

For a thickness tolerance of approximately `delta d = 0.1 micrometre`, it
recalculates each transmission at `d +/- delta d`. Conservative ratio envelopes
pair opposite perturbations in numerator and denominator:

```text
R_+(T_e) = I_1[W_1(d_1 + delta d)] / I_2[W_2(d_2 - delta d)],
R_-(T_e) = I_1[W_1(d_1 - delta d)] / I_2[W_2(d_2 + delta d)].
```

### Signal noise and alignment

The signal-noise term is the standard deviation of the ratio over the selected
lineout region. The alignment term is estimated by recomputing the ratio after
opposite `+/- 0.05 mm` displacements, chosen to match the spatial smoothing
scale:

```text
epsilon_noise = sigma_S,
epsilon_alignment = mean(|S - S_+|, |S - S_-|),
epsilon_lineout = sqrt(epsilon_alignment^2 + epsilon_noise^2).
```

The temperature bounds are then found from the crossed extremes

```text
mean(S) +/- epsilon_lineout = R_+/- (T_e).
```

This is a sensitivity envelope assembled from bounded systematic perturbations
and an empirical scatter term. It should not be labeled a formal confidence or
credible interval without a statistical model for those components.

## Detection floor and interpretation

The report states that the 0-2 ns points in its time history were manually set
to 0 eV because available filters suppressed too many low-energy photons. Those
points therefore represent unresolved measurements below the useful diagnostic
range, not evidence of a zero-temperature plasma. More generally, numerical
inversion is physically meaningful only where both channels remain above
background and `R(T_e)` is sufficiently sensitive to temperature.

The same caution applies to line-of-sight structure. A single inferred value is
a spatially averaged or ratio-weighted effective temperature unless the source
is adequately uniform along the sightline and within the selected region.

## Relationship to current HIPPIE

The report closes a provenance gap between the 2021 MATLAB source and the later
published 2D application. It supports the sequence of calibration, isolation,
registration, ratio formation, response integration, inversion, and separate
sensitivity channels. It does not establish numerical equivalence of the
current Python implementation. That requires the original shot and calibration
HDF5 data, response tables, parameter workbooks, and reference outputs.
