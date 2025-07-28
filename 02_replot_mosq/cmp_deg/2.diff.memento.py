import pandas as pd
import scanpy as sc
import numpy as np
import os
import sys
from tqdm import tqdm

sys.path.insert(0, '/public21/home/sc90258/huangying/tools/scrna-parameter-estimation-master/')
import memento


if __name__ == '__main__':
    idir = './1.input'
    odir = './2.cmp_res'

    if not os.path.exists(odir):
        os.mkdir(odir)

    for ipath in tqdm(os.listdir(idir)):
        cmp_name = ipath

        opath = os.path.join(odir, ipath)
        ipath = os.path.join(idir, ipath)

        if not os.path.exists(opath):
            os.mkdir(opath)     
    
        for ifile in tqdm(os.listdir(ipath)):
            cell = ifile[:-5]
            ifile = os.path.join(ipath, ifile)
            print(f"> Read in AnnData: {ifile}")
            adata = sc.read(ifile)
            print(adata)

            print(f"> Compare {cell} {cmp_name.replace('_', ' ')}...")
            result_1d = memento.binary_test_1d(
                adata=adata, 
                capture_rate=0.07, 
                treatment_col='cmp', 
                num_cpus=64,
                num_boot=5000)
            
            ofile = f"{cmp_name}.{cell}.memento.csv"
            ofile = os.path.join(opath, ofile)
            print(f"> Save result to: {ofile}")
            result_1d.to_csv(ofile, index=False)