# Theory and algorithms

The physical background and assumptions are documented in
[`THEORY_BACKGROUND_SCHAEFFER2021.md`](THEORY_BACKGROUND_SCHAEFFER2021.md),
which grounds HIPPIE in the differential-filter gated-pinhole diagnostic paper
that the original pipeline replicated.

The historical pipeline's published application is documented in
[`PUBLISHED_APPLICATION_VALENZUELA_VILLASECA2024.md`](PUBLISHED_APPLICATION_VALENZUELA_VILLASECA2024.md).
The first-party SULI report and original lineout workflow are analyzed in
[`SULI_2021_REPORT.md`](SULI_2021_REPORT.md).

## Filtered bremsstrahlung ratio

The detector records self-emitted x-ray bremsstrahlung through two neighboring
pinhole/filter channels. For a channel with transmission `W(E)` and detector
response `K(E)`, the model signal at electron temperature `T_e` is

```text
I(T_e) = ∫ j(E, T_e) W(E) K(E) dE.
```

The theoretical ratio used by HIPPIE is

```text
R(T_e) = I_high-filter(T_e) / I_low-filter(T_e).
```

The measured ratio is formed only after background subtraction, flat-fielding,
pair registration, and any explicitly configured flooring or binning:

```text
S(x, y) = N_high-filter(x, y) / N_low-filter(x, y).
```

The inversion searches a caller-supplied, strictly increasing temperature grid
and selects the model temperature whose ratio is closest to `S`. A logarithmic
grid is often useful when the range spans orders of magnitude, but the grid is
an analysis choice rather than a hidden constant.

The 2021 report records both the simple exponential continuum used to explain
the measurement and a Bessel-corrected emissivity in its implementation
section. The current Python function uses the simple exponential shape. We do
not claim exact SULI-response parity until the Bessel convention and response
tables are checked against the executable MATLAB golden case.

## Uncertainty channels

The historical code carries uncertainty through filter-thickness bounds and
small image-space registration shifts. These are most useful when considered
as separate contributions:

1. filter transmission uncertainty;
2. registration uncertainty;
3. signal/background uncertainty;
4. inversion resolution and out-of-range status.

The combined interval must not be presented as a single formal confidence
interval unless its statistical meaning is established.

In the original lineout analysis, signal noise was represented by the standard
deviation of the measured ratio, alignment sensitivity by opposite 0.05 mm
shifts of the paired profiles, and those two terms were added in quadrature.
Filter-thickness bounds were evaluated separately by perturbing the two filter
thicknesses in opposite directions. This produces a useful sensitivity
envelope, not automatically a confidence interval.

## Alignment assumptions

The reference implementation uses a vertical target-edge landmark and a
horizontal plume/current-sheet landmark. The Python package now also provides
cross-correlation registration with reported integer shifts and a match score.
The landmark-specific and automated approaches can be compared directly in the
golden-case analysis.

## Scalar lineouts versus 2D maps

SULI 2021 inferred one spatially averaged temperature from the mean ratio over
a 1-2 mm lineout region after averaging roughly 300 micrometres across the
profile. That averaging was justified only when no significant ratio structure
was resolved. The later pipeline performs the inversion across registered
spatial bins and therefore preserves gradients that the scalar workflow would
discard.

Values outside the filter/detector sensitivity window should be marked as
unresolved. In particular, the SULI report's manually plotted 0 eV points at
0-2 ns denote insufficient low-energy signal, not measured zero temperature.
