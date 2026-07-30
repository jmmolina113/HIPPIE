import numpy as np

from hippie.post import center_lineout, summarize_region

def test_region_summary_excludes_nan():
    summary = summarize_region(np.array([[100., np.nan], [200., 300.]]))
    assert summary.count == 3
    assert summary.mean_eV == 200.

def test_center_lineout():
    image = np.arange(9).reshape(3, 3)
    np.testing.assert_array_equal(center_lineout(image, axis=0), [1, 4, 7])
