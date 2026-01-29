# ONT DNA Methylation Pipeline

### Generate DSS tables for differential methylation analysis from aligned modBAM files

## 🔧 Requirements

- Conda (or micromamba)
- Snakemake
- Python ≥ 3.8
- Reference genome FASTA (with `.fai`)
- **Sorted and indexed modBAM files** containing `MM`/`ML` tags

If `mamba` is not available on your system, always run Snakemake with:

`--conda-frontend conda`
 
Per sample, the following directories are created:

### BAM 

- BAM  
- BAI  

### modkit pileup from aggregated 5mC calls

- `.bed.gz`  
- `.bed.gz.tbi`  

### DSS tables

- `.dss.tsv`  


## DSS Output Format

Each DSS table contains the following columns:

| Column | Description |
|------|-------------|
| chr  | Chromosome |
| pos  | 1-based genomic position |
| N    | Coverage |
| X    | Methylated read count |

These files are directly compatible with **bsseq** and **DSS**.


## Downstream Analysis (R)

The DSS tables can be combined into a `BSseq` object using `makeBSseqData()` for differential methylation analysis.

