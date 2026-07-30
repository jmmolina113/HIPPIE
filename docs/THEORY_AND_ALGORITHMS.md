# Theory and algorithms

The physical background and assumptions are documented in
[`THEORY_BACKGROUND_SCHAEFFER2021.md`](THEORY_BACKGROUND_SCHAEFFER2021.md),
which grounds HIPPIE in the differential-filter gated-pinhole diagnostic paper
that the original pipeline replicated.

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

The inversion searches a logarithmic temperature grid and selects the model
temperature whose ratio is closest to `S`. The grid and tie behavior are
configuration, not hidden constants.

## Uncertainty channels

The historical code carries uncertainty through filter-thickness bounds and
small image-space registration shifts. HIPPIE will report these separately:

1. filter transmission uncertainty;
2. registration uncertainty;
3. signal/background uncertainty;
4. inversion resolution and out-of-range status.

The combined interval must not be presented as a single formal confidence
interval unless its statistical meaning is established.

## Alignment assumptions

The reference implementation uses a vertical target-edge landmark and a
horizontal plume/current-sheet landmark. The corrected implementation will
retain those landmarks but expose their coordinates, shift values, fit quality,
and failure state in the output manifest.
