# DNA Methylation analysis of APPNLGF mouse brains 

This is a `snakemake` pipeline that takes Oxford Nanopore Sequencing (ONT) data (fastq) as input, generates fastq stats using `nanostat`, map the reads to the genome using `minimap2` and uses `sniffles` for calling structural variants.

# Getting Started

## Input

- ONT fastq reads
- Reference genome assembly in fasta format

## Depedencies

- [miniconda](https://conda.io/miniconda.html)
- The rest of the dependencies (including snakemake) are installed via conda through the `environment.yml` file

Clone the directory:

```bash
git clone --recursive https://github.com/umranyaman/ONT_DNA_pipeline.git
```

Create conda environment for the pipeline which will install all the dependencies:

```bash
cd ONT_DNA_pipeline
conda env create -f environment.yml
```

## Usage

Edit `config.yml` to set up the working directory and input files/directories. `snakemake` command should be issued from within the pipeline directory. Please note that before you run any of the `snakemake` commands, make sure to first activate the conda environment using the command `conda activate ONT_DNA_pipeline`.

```bash
cd ONT_DNA_pipeline
conda activate ONT_DNA_pipeline
snakemake --use-conda -j <num_cores> all
```
It is a good idea to do a dry run (using -n parameter) to view what would be done by the pipeline before executing the pipeline.

```bash
snakemake --use-conda -n all
```

## Output
```
working directory  
|--- config.yml           # a copy of the parameters used in the pipeline  
|--- Nanostat/  
     |-- # output of nanostat - fastq stats   
|--- Mapping/  
     |-- # output of minimap2 - aligned reads  
|--- sniffles/  
     |-- # output of sniffles - vcf with SVs
```