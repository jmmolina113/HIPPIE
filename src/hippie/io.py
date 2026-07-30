"""Portable HDF5 ingestion with explicit dataset selection and provenance."""

from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
from typing import Any
import numpy as np

@dataclass(frozen=True)
class ImageSet:
    images: np.ndarray
    source: str
    dataset: str
    attributes: dict[str, Any]

def _numeric_datasets(group, prefix=""):
    found = []
    for name, item in group.items():
        key = f"{prefix}/{name}" if prefix else name
        if hasattr(item, "items"):
            found.extend(_numeric_datasets(item, key))
        elif getattr(item, "dtype", None) is not None and np.issubdtype(item.dtype, np.number) and item.ndim >= 2:
            found.append((key, item.shape))
    return found

def discover_datasets(path: str | Path) -> list[tuple[str, tuple[int, ...]]]:
    import h5py
    with h5py.File(path, "r") as handle:
        return _numeric_datasets(handle)

def read_hdf5_images(path: str | Path, dataset: str | None = None) -> ImageSet:
    import h5py
    source = Path(path).expanduser()
    if not source.exists():
        raise FileNotFoundError(source)
    with h5py.File(source, "r") as handle:
        candidates = _numeric_datasets(handle)
        if dataset is None:
            if len(candidates) != 1:
                raise ValueError("dataset is ambiguous; choose one of: " + ", ".join(n for n, _ in candidates))
            dataset = candidates[0][0]
        if dataset not in handle:
            raise KeyError(f"HDF5 dataset not found: {dataset}")
        node = handle[dataset]
        images = np.asarray(node[...], dtype=float)
        attributes = {str(k): v.item() if hasattr(v, "item") else v for k, v in node.attrs.items()}
    if images.ndim < 2:
        raise ValueError("image dataset must have at least two dimensions")
    return ImageSet(images, str(source), dataset, attributes)
