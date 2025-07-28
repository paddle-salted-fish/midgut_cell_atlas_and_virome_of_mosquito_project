# Input files

**Genome Reference**
For *Ae. aegypti*, *Ae. albopictus* and *Cx. p. pallens*, the genome and their original gtf annotation files could be found in NCBI genome database.
*Ae. aegypti*：[assembly AaegL5.0](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_002204515.2/)
*Ae. albopictus*: [assembly AalbF5](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_035046485.1/)
*Cx. p. pallens*: [assembly TS_CPP_V2](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_016801865.2/)
For *Cx. tritaeniorhynchus*, the genome and its gtf annotation files are unavailable for its corresponding literature being unpublished.
**Raw sequencing data**
The raw data is available on the NCBI GEO database with accession [GSE301762](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE301762). Another copy is available on the CNCB (China National Center for Bioinformation) [GSA](https://ngdc.cncb.ac.cn/gsa/) database with accession CRA027708.

# Output files
**Matrix files**
The processed scRNA-seq data (barcodes.tsv, features.tsv.gz, matrix.mtx.gz) is available on the NCBI GEO database with accession [GSE301762](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE301762). Another copy is available on the CNCB [OMIX](https://ngdc.cncb.ac.cn/omix/) with accession MIX010740.
**Bam files**
Bam files with umapped reads retained by the parameter "--outSAMunmapped Within" were used for single-cell virome analysis.