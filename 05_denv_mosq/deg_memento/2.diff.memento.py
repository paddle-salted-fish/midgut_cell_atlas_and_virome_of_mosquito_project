import pandas as pd
import scanpy as sc
import numpy as np
import os
import sys

sys.path.insert(0, '/public21/home/sc90258/huangying/tools/scrna-parameter-estimation-master/')
import memento


if __name__ == '__main__':
    idir = './1.input'
    odir = './2.cmp_res'
    for ifile in os.listdir(idir):
        cell = ifile[:-5]
        ifile = os.path.join(idir, ifile)
        print(f"> Read in AnnData: {ifile}")
        adata = sc.read(ifile)
        print(adata)

        print(f"> Compare {cell} dv vs bl...")
        result_1d = memento.binary_test_1d(
            adata=adata, 
            capture_rate=0.07, 
            treatment_col='cmp', 
            num_cpus=64,
            num_boot=5000)
        
        ofile = f"dv_vs_bl.{cell}.memento.csv"
        ofile = os.path.join(odir, ofile)
        print(f"> Save result to: {ofile}")
        result_1d.to_csv(ofile, index=False)