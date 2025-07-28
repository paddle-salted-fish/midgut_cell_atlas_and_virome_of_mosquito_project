#!/bin/bash
# make genome ref
mkdir 01.idx && cd 01.idx
~/miniconda3/envs/celescope/bin/celescope rna mkref \
    --thread 64 \
    --genome_name aae_genome \
    --fasta ../0.ref/GCF_002204515.2_AaegL5.0_genomic.fna \
    --gtf ../0.ref/GCF_002204515.2_AaegL5.0_genomic.gtf
cd ../

# generate matrix
# for Ae. aegypti with glucose
mkdir -p 02.mtx && cd 02.mtx
~/miniconda3/envs/celescope/bin/celescope rna sample \
	--outdir ./aae/00.sample \
	--sample aae \
	--thread 64 \
	--chemistry auto \
	--wells 384 \
	--fq1 ../raw_data/Aae2_227897_R1.fastq.gz

~/miniconda3/envs/celescope/bin/celescope rna starsolo \
	--outdir ./aae/01.starsolo\
	--sample aae \
	--thread 64 \
	--chemistry auto \
	--adapter_3p AAAAAAAAAAAA \
	--genomeDir "../1.idx" \
	--outFilterMatchNmin 50 --soloCellFilter "EmptyDrops_CR 3000 0.99 10 45000 90000 500 0.01 20000 0.001 10000" \
	--starMem 32 --STAR_param "--limitBAMsortRAM 9651541135 --outSAMunmapped Within" \
	--soloFeatures "Gene GeneFull_Ex50pAS" \
	--fq1 ../raw_data/Aae2_227897_R1.fastq.gz \
	--fq2 ../raw_data/Aae2_227897_R2.fastq.gz 

# for Ae. aegypti with noninfectious bloodmeal
~/miniconda3/envs/celescope/bin/celescope rna sample \
	--outdir ./aae/00.sample \
	--sample aae \
	--thread 64 \
	--chemistry auto \
	--wells 384 \
	--fq1 ../raw_data/AaeBL-2_225539_R1.fastq.gz

~/miniconda3/envs/celescope/bin/celescope rna starsolo \
	--outdir ./aae_bl/01.starsolo\
	--sample aae_bl \
	--thread 64 \
	--chemistry auto \
	--adapter_3p AAAAAAAAAAAA \
	--genomeDir "../1.idx" \
	--outFilterMatchNmin 50 --soloCellFilter "EmptyDrops_CR 3000 0.99 10 45000 90000 500 0.01 20000 0.001 10000" \
	--starMem 32 --STAR_param "--limitBAMsortRAM 9651541135 --outSAMunmapped Within" \
	--soloFeatures "Gene GeneFull_Ex50pAS" \
	--fq1 ../raw_data/AaeBL-2_225539_R1.fastq.gz \
	--fq2 ../raw_data/AaeBL-2_225539_R2.fastq.gz 

# for Ae. aegypti with DENV-infectious bloodmeal
~/miniconda3/envs/celescope/bin/celescope rna sample \
	--outdir ./aae_denv/00.sample \
	--sample aae_denv \
	--thread 64 \
	--chemistry auto \
	--wells 384 \
	--fq1 ../raw_data/Aae_denv0106_309391_R1.fastq.gz

~/miniconda3/envs/celescope/bin/celescope rna starsolo \
	--outdir ./aae_denv/01.starsolo\
	--sample aae_denv \
	--thread 64 \
	--chemistry auto \
	--adapter_3p AAAAAAAAAAAA \
	--genomeDir "../1.idx" \
	--outFilterMatchNmin 50 --soloCellFilter "EmptyDrops_CR 3000 0.99 10 45000 90000 500 0.01 20000 0.001 10000" \
	--starMem 32 --STAR_param "--limitBAMsortRAM 9651541135 --outSAMunmapped Within" \
	--soloFeatures "Gene GeneFull_Ex50pAS" \
	--fq1 ../raw_data/Aae_denv0106_309391_R1.fastq.gz \
	--fq2 ../raw_data/Aae_denv0106_309391_R2.fastq.gz