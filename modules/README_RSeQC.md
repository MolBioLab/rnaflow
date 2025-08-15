# RSeQC Module

## Overview
RSeQC (RNA-Seq Quality Control) is a comprehensive quality control package for RNA-Seq data. This module provides various quality assessment tools to evaluate the quality of RNA-Seq data after mapping.

## Tools Included

### 1. infer_experiment.py
- **Purpose**: Infers the RNA-Seq protocol (strandedness) from mapped reads
- **Output**: Text file with strandedness information
- **Use case**: Verify if the library preparation was correctly performed

### 2. junction_annotation.py
- **Purpose**: Annotates splice junctions in mapped reads
- **Output**: Text file with junction annotation statistics
- **Use case**: Assess splice junction detection quality

### 3. read_distribution.py
- **Purpose**: Calculates read distribution over genomic features
- **Output**: Text file with read distribution statistics
- **Use case**: Evaluate how well reads map to different genomic features

### 4. geneBody_coverage.py
- **Purpose**: Calculates gene body coverage
- **Output**: Text file and PDF plot
- **Use case**: Assess 5' and 3' bias in RNA-Seq data

### 5. inner_distance.py
- **Purpose**: Calculates inner distance between paired-end reads
- **Output**: Text file and PDF plot
- **Use case**: Evaluate fragment size distribution (paired-end only)

### 6. read_duplication.py
- **Purpose**: Calculates read duplication levels
- **Output**: Text file and PDF plot
- **Use case**: Assess PCR amplification bias

### 7. bam_stat.py
- **Purpose**: Provides basic statistics for BAM files
- **Output**: Text file with mapping statistics
- **Use case**: General quality assessment of mapped reads

## Usage

### Basic Usage
```bash
nextflow run hoelzer-lab/rnaflow --reads input.csv --autodownload mmu --pathway mmu
```

### Skip RSeQC Analysis
```bash
nextflow run hoelzer-lab/rnaflow --reads input.csv --autodownload mmu --pathway mmu --skip_rseqc
```

### Custom Output Directory
```bash
nextflow run hoelzer-lab/rnaflow --reads input.csv --autodownload mmu --pathway mmu --rseqc_dir "custom/rseqc/path"
```

## Output Structure

Results are saved in `${params.output}/${params.rseqc_dir}/` with the following structure:

```
Summary/RSeQC/
├── sample1.infer_experiment.txt
├── sample1.junction_annotation.txt
├── sample1.read_distribution.txt
├── sample1.geneBodyCoverage.txt
├── sample1.geneBodyCoverage.pdf
├── sample1.inner_distance.txt
├── sample1.inner_distance.pdf
├── sample1.read_duplication.txt
├── sample1.read_duplication.pdf
└── sample1.bam_stat.txt
```

## Interpretation

### infer_experiment.py
- **FR Second Strand**: Forward-reverse stranded (most common)
- **FR First Strand**: Forward-reverse, first strand
- **Unstranded**: No strand information

### geneBody_coverage.py
- **Good coverage**: Even distribution across gene body
- **5' bias**: Higher coverage at 5' end
- **3' bias**: Higher coverage at 3' end

### read_duplication.py
- **Low duplication**: < 20% (good)
- **High duplication**: > 50% (may indicate PCR bias)

### inner_distance.py
- **Expected range**: 100-300 bp for most protocols
- **Too short**: May indicate adapter contamination
- **Too long**: May indicate poor library preparation

## Dependencies

The module requires:
- RSeQC >= 4.0.0
- matplotlib >= 3.0.0
- numpy >= 1.20.0
- pandas >= 1.3.0

## Notes

- `inner_distance.py` is only run for paired-end data
- All tools require a reference annotation file (GTF format)
- Results are automatically integrated with MultiQC for comprehensive reporting 