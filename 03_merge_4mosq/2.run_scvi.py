# -*- coding: utf-8 -*-
import scvi
import scanpy as sc
import torch
import numpy as np

adata = sc.read('./1.pre_merge.h5ad')
model = scvi.model.SCVI.load('./2.trained_model.pth', adata)
SCVI_LATENT_KEY = "X_scVI"
adata.obsm[SCVI_LATENT_KEY] = model.get_latent_representation()
SCVI_MDE_KEY = "X_scVI_MDE"
adata.obsm[SCVI_MDE_KEY] = scvi.model.utils.mde(adata.obsm[SCVI_LATENT_KEY], accelerator="cpu")
adata.layers["scvi_normalized"] = model.get_normalized_expression()
adata.write('new.integrated.h5ad')

