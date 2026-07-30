import numpy as np

from hippie import calibrate_image, invert_ratio, ratio_curve


def test_calibration_and_flooring():
    result = calibrate_image([[5, 1]], background=[[2, 2]], flatfield=[[1, 2]], floor=1)
    np.testing.assert_allclose(result, [[3, 1]])


def test_ratio_inversion_recovers_grid_point():
    energy = np.linspace(100, 3000, 500)
    temperatures = np.array([200.0, 400.0, 800.0])
    transmission_1 = np.exp(-energy / 500.0)
    transmission_2 = np.exp(-energy / 250.0)
    modeled = ratio_curve(energy, temperatures, transmission_1, transmission_2)
    result = invert_ratio(np.array([[modeled[1]]]), temperatures, modeled)
    np.testing.assert_allclose(result, [[400.0]])
