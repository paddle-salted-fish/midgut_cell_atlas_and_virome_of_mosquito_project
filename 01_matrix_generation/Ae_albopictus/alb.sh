#!/bin/bash
# make genome ref
mkdir 01.idx && cd 01.idx
~/miniconda3/envs/celescope/bin/celescope rna mkref \
    --thread 64 \
    --genome_name alb_genome \
    --fasta ../0.ref/GCF_035046485.1_AalbF5_genomic.fna \
    --gtf ../0.ref/GCF_035046485.1_AalbF5_genomic.gtf
cd ../
# generate matrix
mkdir 02.mtx && cd 02.mtx
~/miniconda3/envs/celescope/bin/celescope rna sample \
	--outdir ./alb/00.sample \
	--sample alb \
	--thread 64 \
	--chemistry auto \
	--wells 384 \
	--fq1 ../raw_data/Aal2_221722_R1.fastq.gz

~/miniconda3/envs/celescope/bin/celescope rna starsolo \
	--outdir ./alb/01.starsolo \
	--sample alb \
	--thread 64 \
	--chemistry auto \
	--adapter_3p AAAAAAAAAAAA \
	--genomeDir "../1.idx" \
	--outFilterMatchNmin 50 \
	--soloCellFilter "EmptyDrops_CR 3000 0.99 10 45000 90000 500 0.01 20000 0.001 10000" \
	--starMem 32 \
	--STAR_param "--limitBAMsortRAM 9651541135 --outSAMunmapped Within" \
	--soloFeatures "Gene GeneFull_Ex50pAS" \
	--fq1 ../raw_data/Aal2_221722_R1.fastq.gz \
	--fq2 ../raw_data/Aal2_221722_R2.fastq.gz 