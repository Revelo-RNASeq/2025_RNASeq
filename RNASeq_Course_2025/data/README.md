# Demo Data Setup

This folder should contain the sample data for the AI-driven RNA-seq demo.

## Required Files

Create or download these files before running the demo:

### Option 1: Use Airway Dataset (Recommended)

```r
# Install if needed
BiocManager::install("airway")

# In R, generate the files:
library(airway)
library(SummarizedExperiment)

data(airway)

# Export counts
counts <- assay(airway)
write.csv(counts, "counts_matrix.csv")

# Export metadata
metadata <- as.data.frame(colData(airway))
metadata$sample_id <- rownames(metadata)
metadata$condition <- ifelse(metadata$dex == "untrt", "control", "treatment")
write.csv(metadata[, c("sample_id", "condition", "cell")], "sample_metadata.csv", row.names = FALSE)
```

### Option 2: Use GSE96870 (Mouse Cerebellum)

Download from the RNASeq book repository:
- `GSE96870_counts_cerebellum.csv` → rename to `counts_matrix.csv`
- `GSE96870_coldata_all.csv` → rename to `sample_metadata.csv`

## File Format

### counts_matrix.csv
```
,SRR1039508,SRR1039509,SRR1039512,...
ENSG00000000003,679,448,873,...
ENSG00000000005,0,0,0,...
```

### sample_metadata.csv
```
sample_id,condition,batch
SRR1039508,control,A
SRR1039509,treatment,A
SRR1039512,control,B
...
```

## Verify Setup

After creating the files, run this check in R:

```r
counts <- read.csv("data/counts_matrix.csv", row.names = 1)
metadata <- read.csv("data/sample_metadata.csv")

cat("Counts matrix:", nrow(counts), "genes x", ncol(counts), "samples\n")
cat("Metadata:", nrow(metadata), "samples\n")
cat("Conditions:", unique(metadata$condition), "\n")
```
