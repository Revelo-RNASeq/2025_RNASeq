# EBI RNA-Seq Course Materials

Source: [EMBL-EBI RNA-seq: A practical introduction to the analysis of gene expression data](https://www.ebi.ac.uk/training-events/events/rna-seq-practical-introduction-analysis-gene-expression-data)

## Overview
This course covers:
- RNA-seq experimental design
- Quality control and alignment
- Gene expression quantification
- Differential expression analysis
- Functional annotation

## Key Concepts to Adapt
- **Quality Control**: FastQC, Trimmomatic/Cutadapt
- **Alignment**: HISAT2, STAR
- **Quantification**: featureCounts, HTSeq
- **DE Analysis**: DESeq2, edgeR
- **Downstream**: GO term enrichment, Pathway analysis

## Notes for Course Development
- Use their explanation of **normalization methods** (TPM vs FPKM vs DESeq2 size factors).
- Adapt their **experimental design** slides for M3_RNASeq_Intro.
- Review their **bioconductor examples** for the R analysis modules.
