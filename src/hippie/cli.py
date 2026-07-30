"""Small command-line entry points that never mutate source data."""
from __future__ import annotations
import argparse
from .io import discover_datasets

def datasets(argv=None):
    parser = argparse.ArgumentParser(description="Inspect HIPPIE HDF5 image datasets")
    parser.add_argument("path")
    args = parser.parse_args(argv)
    for name, shape in discover_datasets(args.path): print(f"{name}\t{shape}")
