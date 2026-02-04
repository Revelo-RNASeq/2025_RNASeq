---
name: bio-data-visualization-specialized-omics-plots
description: Complete visualization toolkit for RNA-seq and omics data. Includes DESeq2/edgeR built-in plots (plotMA, plotPCA, plotDispEsts), custom ggplot2 implementations (volcano, MA, heatmaps), and enrichment visualizations. Use for any DE or expression visualization task.
tool_type: mixed
primary_tool: ggplot2
---

# Specialized Omics Plots

## Scope

This skill provides a **complete visualization toolkit** for RNA-seq analysis:
- DESeq2/edgeR built-in functions (plotMA, plotPCA, plotDispEsts, plotCounts)
- Custom ggplot2 volcano, MA, and PCA plots with labels
- EnhancedVolcano for publication-ready figures
- Sample distance heatmaps and p-value histograms
- Enrichment dotplots and expression boxplots

## DESeq2 Built-in Plots

### MA Plot (DESeq2)

```r
# Built-in MA plot
plotMA(res, ylim = c(-5, 5), main = 'MA Plot')

# With custom alpha threshold
plotMA(res, alpha = 0.01, ylim = c(-5, 5))

# Highlight specific genes
plotMA(res, ylim = c(-5, 5))
with(subset(res, padj < 0.01 & abs(log2FoldChange) > 2),
     points(baseMean, log2FoldChange, col = 'red', pch = 20))
```

### PCA Plot (DESeq2)

```r
# Variance stabilizing transformation first
vsd <- vst(dds, blind = FALSE)

# Basic PCA
plotPCA(vsd, intgroup = 'condition')

# Multiple grouping variables
plotPCA(vsd, intgroup = c('condition', 'batch'), ntop = 500)

# Return data for custom ggplot
pca_data <- plotPCA(vsd, intgroup = c('condition', 'batch'), returnData = TRUE)
percentVar <- round(100 * attr(pca_data, 'percentVar'))

ggplot(pca_data, aes(x = PC1, y = PC2, color = condition, shape = batch)) +
    geom_point(size = 4) +
    xlab(paste0('PC1: ', percentVar[1], '% variance')) +
    ylab(paste0('PC2: ', percentVar[2], '% variance')) +
    theme_bw()
```

### Dispersion Plot

```r
# DESeq2 dispersion estimates
plotDispEsts(dds, main = 'Dispersion Estimates')
```

### Counts for Individual Genes

```r
# DESeq2 plotCounts
plotCounts(dds, gene = 'GENE_NAME', intgroup = 'condition')

# With ggplot2 styling
d <- plotCounts(dds, gene = 'GENE_NAME', intgroup = 'condition', returnData = TRUE)
ggplot(d, aes(x = condition, y = count, color = condition)) +
    geom_point(position = position_jitter(width = 0.1), size = 3) +
    scale_y_log10() +
    ggtitle('GENE_NAME Expression') +
    theme_bw()
```

## edgeR Built-in Plots

```r
# MD plot (mean-difference)
plotMD(qlf, main = 'MD Plot')
abline(h = c(-1, 1), col = 'blue', lty = 2)

# Biological coefficient of variation
plotBCV(y, main = 'Biological Coefficient of Variation')

# MDS plot (similar to PCA)
plotMDS(log_cpm, col = as.numeric(group), pch = 16)
```

## EnhancedVolcano (Publication-Ready)

```r
library(EnhancedVolcano)

EnhancedVolcano(res,
    lab = rownames(res),
    x = 'log2FoldChange',
    y = 'pvalue',
    pCutoff = 0.05,
    FCcutoff = 1,
    title = 'Differential Expression',
    subtitle = 'Treatment vs Control')
```

## Custom Volcano Plot (R)

```r
library(ggplot2)
library(ggrepel)

volcano_plot <- function(res, fdr = 0.05, lfc = 1, top_n = 10) {
    res <- res %>%
        mutate(
            significance = case_when(
                padj < fdr & log2FoldChange > lfc ~ 'Up',
                padj < fdr & log2FoldChange < -lfc ~ 'Down',
                TRUE ~ 'NS'
            ),
            label = ifelse(rank(padj) <= top_n & significance != 'NS', gene, '')
        )

    ggplot(res, aes(log2FoldChange, -log10(pvalue), color = significance)) +
        geom_point(alpha = 0.6, size = 1.5) +
        geom_text_repel(aes(label = label), color = 'black', size = 3, max.overlaps = 20) +
        scale_color_manual(values = c('Up' = '#E64B35', 'Down' = '#4DBBD5', 'NS' = 'grey60')) +
        geom_vline(xintercept = c(-lfc, lfc), linetype = 'dashed', color = 'grey40') +
        geom_hline(yintercept = -log10(fdr), linetype = 'dashed', color = 'grey40') +
        labs(x = expression(Log[2]~Fold~Change), y = expression(-Log[10]~P-value)) +
        theme_bw() + theme(panel.grid = element_blank())
}
```

## Custom MA Plot (R)

```r
ma_plot <- function(res, fdr = 0.05) {
    res <- res %>%
        mutate(significant = padj < fdr & !is.na(padj))

    ggplot(res, aes(log10(baseMean), log2FoldChange, color = significant)) +
        geom_point(alpha = 0.5, size = 1) +
        scale_color_manual(values = c('FALSE' = 'grey60', 'TRUE' = '#E64B35')) +
        geom_hline(yintercept = 0, color = 'black', linewidth = 0.5) +
        labs(x = expression(Log[10]~Mean~Expression), y = expression(Log[2]~Fold~Change)) +
        theme_bw() + theme(panel.grid = element_blank(), legend.position = 'none')
}
```

## Custom PCA Plot (R)

```r
pca_plot <- function(vsd, intgroup = 'condition', ntop = 500) {
    rv <- rowVars(assay(vsd))
    select <- order(rv, decreasing = TRUE)[seq_len(min(ntop, length(rv)))]
    pca <- prcomp(t(assay(vsd)[select, ]))
    percentVar <- round(100 * pca$sdev^2 / sum(pca$sdev^2), 1)

    pca_df <- data.frame(PC1 = pca$x[, 1], PC2 = pca$x[, 2], colData(vsd))

    ggplot(pca_df, aes(PC1, PC2, color = .data[[intgroup]])) +
        geom_point(size = 3) +
        stat_ellipse(level = 0.95, linetype = 'dashed') +
        labs(x = paste0('PC1 (', percentVar[1], '%)'),
             y = paste0('PC2 (', percentVar[2], '%)')) +
        theme_bw() + theme(panel.grid = element_blank())
}
```

## P-value Histogram

```r
# Check p-value distribution (uniform under null, peak near 0 for true signal)
res_df <- as.data.frame(res)
ggplot(res_df, aes(x = pvalue)) +
    geom_histogram(bins = 50, fill = 'steelblue', color = 'white') +
    labs(x = 'P-value', y = 'Frequency', title = 'P-value Distribution') +
    theme_bw()
```

## Sample Distance Heatmap

```r
library(pheatmap)

vsd <- vst(dds, blind = FALSE)
sampleDists <- dist(t(assay(vsd)))
sampleDistMatrix <- as.matrix(sampleDists)

annotation <- data.frame(
    condition = colData(dds)$condition,
    row.names = colnames(dds)
)

pheatmap(sampleDistMatrix,
         annotation_col = annotation,
         annotation_row = annotation,
         clustering_distance_rows = sampleDists,
         clustering_distance_cols = sampleDists,
         color = colorRampPalette(c('white', 'steelblue'))(100),
         main = 'Sample Distance Matrix')
```

## Top DE Genes Heatmap

```r
# Get top significant genes
sig_genes <- rownames(subset(res, padj < 0.01))

# Get normalized counts
vsd <- vst(dds, blind = FALSE)
mat <- assay(vsd)[sig_genes, ]

# Scale by row (z-score)
mat_scaled <- t(scale(t(mat)))

annotation_col <- data.frame(
    condition = colData(dds)$condition,
    row.names = colnames(mat)
)

pheatmap(mat_scaled,
         annotation_col = annotation_col,
         show_rownames = FALSE,
         clustering_distance_rows = 'correlation',
         clustering_distance_cols = 'correlation',
         color = colorRampPalette(c('blue', 'white', 'red'))(100),
         main = 'Top DE Genes')
```

## Dotplot for Enrichment (R)

```r
enrichment_dotplot <- function(enrich_result, top_n = 20) {
    df <- enrich_result %>%
        arrange(p.adjust) %>%
        head(top_n) %>%
        mutate(Description = factor(Description, levels = rev(Description)),
               GeneRatio_numeric = sapply(strsplit(GeneRatio, '/'), function(x) as.numeric(x[1])/as.numeric(x[2])))

    ggplot(df, aes(GeneRatio_numeric, Description, size = Count, color = p.adjust)) +
        geom_point() +
        scale_color_gradient(low = '#E64B35', high = '#4DBBD5', trans = 'log10') +
        scale_size_continuous(range = c(3, 10)) +
        labs(x = 'Gene Ratio', y = NULL, color = 'Adj. P-value', size = 'Count') +
        theme_bw() + theme(panel.grid.major.y = element_blank())
}
```

## Boxplot with Statistics (R)

```r
library(ggpubr)

expression_boxplot <- function(df, gene, group_var) {
    ggboxplot(df, x = group_var, y = gene, color = group_var,
              add = 'jitter', palette = 'npg') +
        stat_compare_means(method = 't.test', label = 'p.signif') +
        labs(y = paste0(gene, ' Expression')) +
        theme(legend.position = 'none')
}
```

## Saving Plots

```r
# Save as PDF (vector)
pdf('volcano_plot.pdf', width = 8, height = 6)
# ... plot code ...
dev.off()

# Save as PNG (raster)
png('volcano_plot.png', width = 800, height = 600, res = 150)
# ... plot code ...
dev.off()

# Using ggsave for ggplot objects
p <- ggplot(...) + ...
ggsave('plot.pdf', p, width = 8, height = 6)
ggsave('plot.png', p, width = 8, height = 6, dpi = 300)
```

## Color Palettes

```r
library(RColorBrewer)

# Diverging (for expression: blue-white-red)
colorRampPalette(rev(brewer.pal(n = 7, name = 'RdBu')))(100)

# Sequential (for distances)
colorRampPalette(brewer.pal(n = 9, name = 'Blues'))(100)

# Categorical groups
brewer.pal(n = 8, name = 'Set1')
```

## Quick Reference

| Plot | Purpose | Function |
|------|---------|----------|
| MA plot | LFC vs mean expression | `plotMA()`, custom ggplot2 |
| Volcano | LFC vs significance | EnhancedVolcano, custom ggplot2 |
| PCA | Sample clustering | `plotPCA()`, custom ggplot2 |
| Heatmap | Gene patterns | `pheatmap()` |
| Dispersion | Model fit | `plotDispEsts()` |
| Counts | Individual genes | `plotCounts()` |
| P-value hist | QC check | ggplot2 histogram |

## Related Skills

- bio-data-visualization-heatmaps-clustering - Advanced heatmap customization
- bio-rna-quantification-count-matrix-qc - Pre-DE QC plots
- bio-workflows-rnaseq-to-de - Complete pipeline context
