#!/bin/bash
mkdir 01.idx && cd 01.idx
~/miniconda3/envs/celescope/bin/celescope rna mkref \
    --thread 64 \
    --genome_name cxtri_genome \
    --fasta ../0.ref/CxTri.mt.fa \
    --gtf ../0.ref/CxTri.mt.gtf
cd ../

# generate matrix
# for Cx. tritaeniorhynchus with glucose
mkdir -p 02.mtx && cd 02.mtx
~/miniconda3/envs/celescope/bin/celescope rna sample \
	--outdir ./cxtri/00.sample \
	--sample cxtri \
	--thread 64 \
	--chemistry auto \
	--wells 384 \
	--fq1 ../raw_data/CXTri-1_216177_R1.fastq.gz 

~/miniconda3/envs/celescope/bin/celescope rna starsolo \
	--outdir ./cxtri/01.starsolo \
	--sample cxtri \
	--thread 64 \
	--chemistry auto \
	--adapter_3p AAAAAAAAAAAA \
	--genomeDir "../1.idx" \
	--outFilterMatchNmin 50 \
	--soloCellFilter "EmptyDrops_CR 3000 0.99 10 45000 90000 500 0.01 20000 0.001 10000" \
	--starMem 32 \
	--STAR_param "--limitBAMsortRAM 9651541135 --outSAMunmapped Within" \
	--soloFeatures "Gene GeneFull_Ex50pAS" \
	--fq1 ../raw_data/CXTri-1_216177_R1.fastq.gz \
	--fq2 ../raw_data/CXTri-1_216177_R2.fastq.gz 

# for Cx. tritaeniorhynchus with noninfectious bloodmeal
~/miniconda3/envs/celescope/bin/celescope rna sample \
	--outdir ./cxtri_bl/00.sample \
	--sample cxtri_bl \
	--thread 64 \
	--chemistry auto \
	--wells 384 \
	--fq1 ../raw_data/CxTri-BL_216791_R1.fastq.gz 

~/miniconda3/envs/celescope/bin/celescope rna starsolo \
	--outdir ./cxtri_bl/01.starsolo \
	--sample cxtri_bl \
	--thread 64 \
	--chemistry auto \
	--adapter_3p AAAAAAAAAAAA \
	--genomeDir "../1.idx" \
	--outFilterMatchNmin 50 \
	--soloCellFilter "EmptyDrops_CR 3000 0.99 10 45000 90000 500 0.01 20000 0.001 10000" \
	--starMem 32 \
	--STAR_param "--limitBAMsortRAM 9651541135 --outSAMunmapped Within" \
	--soloFeatures "Gene GeneFull_Ex50pAS" \
	--fq1 ../raw_data/CxTri-BL_216791_R1.fastq.gz \
	--fq2 ../raw_data/CxTri-BL_216791_R2.fastq.gz