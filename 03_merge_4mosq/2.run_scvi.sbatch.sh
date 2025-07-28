#!/bin/bash

export OMP_NUM_THREADS=64         # 控制OpenMP并行线程数
export OPENBLAS_NUM_THREADS=64    # 限制OpenBLAS线程数
export MKL_NUM_THREADS=64         # MKL库线程限制（如使用Intel MKL）
export NUMEXPR_NUM_THREADS=64     # NumPy表达式引擎线程数
export VECLIB_MAXIMUM_THREADS=64  # macOS加速库限制（如适用）

date +%Y-%m-%d\ %H:%M:%S

~/miniconda3/envs/hy-scvi/bin/python 2.run_scvi.py

date +%Y-%m-%d\ %H:%M:%S
