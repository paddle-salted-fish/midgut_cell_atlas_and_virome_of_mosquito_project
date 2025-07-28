#!/bin/bash

#SBATCH --job-name=run_memento     # 作业名称
#SBATCH --output=2.run_memento.output_%j.log       # 输出文件名（%j 会自动替换为作业ID）
#SBATCH --error=2.run_memento.error_%j.log         # 错误日志文件


~/miniconda3/envs/hy-scanpy/bin/python 2.diff.memento.py
