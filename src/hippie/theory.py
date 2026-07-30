"""Differential-filter bremsstrahlung model and temperature inversion."""

from __future__ import annotations

import numpy as np


def bremsstrahlung_spectrum(energy_eV, temperature_eV):
    """Return the temperature-dependent spectral shape used by HIPPIE.

    This is the energy-dependent part of the optically thin thermal
    bremsstrahlung model. Density, charge-state, and absolute calibration
    factors cancel in a two-filter ratio and are therefore not included.
    """
    energy = np.asarray(energy_eV, dtype=float)
    temperature = np.asarray(temperature_eV, dtype=float)
    if np.any(energy < 0) or np.any(temperature <= 0):
        raise ValueError("energy must be non-negative and temperature positive")
    if energy.ndim == 1 and temperature.ndim == 1 and energy.size != temperature.size:
        energy = energy[None, :]
        temperature = temperature[:, None]
    return np.exp(-energy / temperature) / np.sqrt(temperature)


def filtered_signal(energy_eV, temperature_eV, transmission, response=None):
    """Integrate emissivity through a filter and detector response."""
    energy = np.asarray(energy_eV, dtype=float)
    transmission = np.asarray(transmission, dtype=float)
    if response is None:
        response = np.ones_like(energy)
    response = np.asarray(response, dtype=float)
    if not (energy.shape == transmission.shape == response.shape):
        raise ValueError("energy, transmission, and response must have equal shape")
    # ``trapezoid`` is newer than the NumPy version used by the historical
    # environments; keep the port runnable there as well.
    integrate = getattr(np, "trapezoid", np.trapz)
    return integrate(
        bremsstrahlung_spectrum(energy, temperature_eV) * transmission * response,
        energy,
        axis=-1,
    )


def ratio_curve(energy_eV, temperatures_eV, transmission_1, transmission_2, response=None):
    """Calculate the model signal ratio for a temperature grid."""
    high = filtered_signal(energy_eV, temperatures_eV, transmission_1, response)
    low = filtered_signal(energy_eV, temperatures_eV, transmission_2, response)
    with np.errstate(divide="ignore", invalid="ignore"):
        return np.divide(high, low, out=np.full_like(high, np.nan), where=low != 0)


def invert_ratio(measured_ratio, temperatures_eV, modeled_ratio):
    """Map measured ratios to the nearest modeled electron temperature."""
    measured = np.asarray(measured_ratio, dtype=float)
    temperatures = np.asarray(temperatures_eV, dtype=float)
    modeled = np.asarray(modeled_ratio, dtype=float)
    if temperatures.ndim != 1 or modeled.ndim != 1 or temperatures.size != modeled.size:
        raise ValueError("temperature and model grids must be equal-length vectors")
    if np.any(np.diff(temperatures) <= 0):
        raise ValueError("temperature grid must be strictly increasing")
    distances = np.abs(measured[..., None] - modeled)
    valid = np.isfinite(distances).any(axis=-1)
    result = np.full(measured.shape, np.nan, dtype=float)
    result[valid] = temperatures[np.nanargmin(distances[valid], axis=-1)]
    return result
