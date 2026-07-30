import numpy as np

from hippie import bin_image, register_by_cross_correlation
from hippie.filters import scale_transmission, stack_transmission
from hippie.results import RunManifest

def test_bin_image_and_filter_stack():
    image = np.arange(16).reshape(4, 4)
    np.testing.assert_allclose(bin_image(image, (2, 2)), [[2.5, 4.5], [10.5, 12.5]])
    np.testing.assert_allclose(stack_transmission([.5, .4], [.8, .5]), [.4, .2])
    np.testing.assert_allclose(scale_transmission([.25], 20, 10), [.0625])

def test_registration_recovers_integer_shift():
    image = np.zeros((20, 20)); image[8:12, 9:13] = 1
    moving = np.zeros_like(image); moving[10:14, 6:10] = 1
    found = register_by_cross_correlation(image, moving, max_shift=5)
    assert (found.shift_y, found.shift_x) == (-2, 3)

def test_manifest_round_trip(tmp_path):
    manifest = RunManifest("shot", "legacy", "0.1")
    manifest.write(tmp_path / "manifest.json")
    assert '"shot": "shot"' in (tmp_path / "manifest.json").read_text()
