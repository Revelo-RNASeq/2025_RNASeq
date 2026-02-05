# AI-Driven RNA-Seq Analysis: Prompt Pipeline

Quick reference guide for the practical demo. Copy prompts into Copilot Chat or ChatGPT.

---

## � Demo Data

I file per il demo sono in `data/`:

| Cartella | Contenuto |
|----------|-----------|
| `fastq_SUBSET/` | 4 campioni paired-end (airway dataset) |
| `trascriptome_TINY/` | Trascrittoma GENCODE v43 (subset) + indice Salmon |

**Campioni FASTQ** (subset per velocità):
| Sample | R1 | R2 | Condition |
|--------|----|----|-----------|
| SRR1039508 | `SRR1039508_pass_1_SUBSET.fastq` | `SRR1039508_pass_2_SUBSET.fastq` | control |
| SRR1039509 | `SRR1039509_pass_1_SUBSET.fastq` | `SRR1039509_pass_2_SUBSET.fastq` | treatment |
| SRR1039512 | `SRR1039512_pass_1_SUBSET.fastq` | `SRR1039512_pass_2_SUBSET.fastq` | control |
| SRR1039513 | `SRR1039513_pass_1_SUBSET.fastq` | `SRR1039513_pass_2_SUBSET.fastq` | treatment |

**Transcriptome**:
- `gencode.v43.transcripts_TINY.fa.gz` - per creare l'indice
- `gencode.v43_TINY.salmon/` - indice Salmon pre-costruito

---

## �🔍 QC dei Reads (FASTQ)

### Prompt 0a: QC e Trimming dei FASTQ
```
Ho file FASTQ paired-end in data/fastq_SUBSET/ (SRR1039508).

Analizza la qualità delle raw reads e rimuovi adattatori.
Salva in results/fastp/
```

💡 **Cosa succede**: L'AI riconoscerà che serve uno strumento di QC per FASTQ e genererà il comando appropriato (tipicamente `fastp`), spiegando ogni opzione.

📊 **Output atteso**: Un report HTML da aprire nel browser con:
- Qualità delle basi prima/dopo il trimming
- Contenuto di adattatori rimossi
- Distribuzione delle lunghezze dei reads
- % di reads filtrati

### Prompt 0a-bis: Batch Processing (tutti i campioni)
```
Ho 4 campioni FASTQ in data/fastq_SUBSET/ (SRR1039508, SRR1039509, SRR1039512, SRR1039513).

Analizza tutti i campioni con fastp in batch.
Salva in results/fastp/
```

### Prompt 0b: Aggregare i report con MultiQC
```
Ho report fastp in results/fastp/ per 4 campioni.

Combina i report in un unico MultiQC report.
Salva in results/multiqc/
```

💡 **Perché MultiQC?**: Confrontare 4 report separati è difficile. MultiQC li unifica in un'unica dashboard interattiva.

### Prompt 0c: Interpretazione Report MultiQC
```
Ho un report MultiQC dei miei campioni RNA-seq.

[INCOLLA QUI SCREENSHOT O STATISTICHE CHIAVE]

Interpreta il report: la qualità è buona? Ci sono outliers?
```

---

## 🧬 Quantificazione (Salmon)

### Prompt 0d: Creare l'indice Salmon (demo didattico)
```
Ho il trascrittoma in data/trascriptome_TINY/gencode.v43.transcripts_TINY.fa.gz

Crea un indice Salmon.
Salva in data/trascriptome_TINY/my_salmon_index/

Spiega cos'è un indice e perché serve.
```

💡 **Demo vs Produzione**: Questo step mostra *come* si crea un indice. Per l'analisi vera, useremo l'indice pre-costruito in `gencode.v43_TINY.salmon/` per risparmiare tempo (~5-10 min per il subset, ore per un genoma completo).

### Prompt 0e: Quantificare con Salmon
```
Ho FASTQ trimmed in results/fastp/ (SRR1039508) e indice Salmon in data/trascriptome_TINY/gencode.v43_TINY.salmon/

Quantifica l'espressione genica.
Salva in results/salmon/SRR1039508/
```

📊 **Output atteso**: Cartella con:
- `quant.sf` - quantificazione per trascritto (TPM, counts)
- `cmd_info.json` - parametri usati
- `logs/` - log del processo

### Prompt 0f: Quantificare tutti i campioni (batch)
```
Ho 4 campioni FASTQ trimmed in results/fastp/ e indice Salmon in data/trascriptome_TINY/gencode.v43_TINY.salmon/

Quantifica tutti i campioni in batch.
Salva in results/salmon/{sample}/
```

### Prompt 0g: Importare Salmon in R (tximport)
```
Ho risultati Salmon in results/salmon/{sample}/quant.sf per 4 campioni.

Importa in R con tximport, aggrega a livello di gene.
Salva counts_matrix.csv e sample_metadata.csv in data/
```

---

## 🔧 Setup

### Prompt 1: Environment Setup
```
Setup ambiente per analisi RNA-seq in R.
Librerie: DESeq2, tximport, ggplot2, pheatmap.
Crea cartella results/
```

### Prompt 2: Load Data
```
Carica data/counts_matrix.csv e data/sample_metadata.csv
Verifica corrispondenza campioni.
Converti condition in factor (control, treatment).
```

---

## 📊 QC Matrice

### Prompt 3: Library Size Check
```
Analizza library size della matrice di conteggi.
Crea barplot per condizione.
Identifica outliers.
```

### Prompt 4: Gene Filtering
```
Filtra geni a bassa espressione (min 10 counts, in almeno 3 campioni).
Mostra distribuzione prima/dopo.
Spiega il razionale.
```

---

## 🔬 Analisi Esplorativa

### Prompt 5: VST Transformation
```
Crea DESeqDataSet con counts_filtered e metadata (design: ~condition).
Applica trasformazione VST.
Spiega perché usare VST invece di log2.
```

### Prompt 6: PCA Plot
```
Crea PCA plot (top 500 geni) dei campioni VST-normalizzati.
Colora per condition, aggiungi ellissi 95%.
Salva results/pca_plot.pdf
```

### Prompt 7: Sample Correlation
```
Crea heatmap di correlazione (Pearson) tra campioni VST.
Annota per condition, aggiungi clustering.
Salva results/sample_correlation.pdf
```

---

## 📈 Analisi Differenziale

### Prompt 8: DESeq2 Analysis
```
Esegui analisi differenziale con DESeq2.
Controllo: control, trattamento: treatment.
Applica shrinkage. Mostra summary.
```

### Prompt 9: Diagnostic Plots
```
Crea plot diagnostici DESeq2: dispersion plot, p-value histogram, MA plot.
Salva in results/
Spiega come interpretarli.
```

### Prompt 10: Filter Results
```
Filtra geni significativi (padj<0.05, |LFC|>1).
Separa UP/DOWN, crea summary.
Salva results/DE_genes.csv
```

---

## 🎨 Visualizzazione

### Prompt 11: Volcano Plot
```
Crea volcano plot con risultati DESeq2.
Colora UP (rosso), DOWN (blu), NS (grigio).
Etichetta top 10 geni. Salva results/volcano_plot.pdf
```

### Prompt 12: Heatmap Top Genes
```
Crea heatmap top 50 geni DE (valori VST, z-score).
Annota condition, cluster righe/colonne.
Salva results/heatmap_top50.pdf
```

### Prompt 13: Gene Boxplots
```
Crea boxplot top 4 geni DE (counts normalizzati).
Aggiungi punti, colora per condition, mostra p-value.
Griglia 2x2. Salva results/top_genes_boxplot.pdf
```

---

## 📝 Report

### Prompt 14: Summary Report
```
Genera report markdown dell'analisi:
- Dataset, filtri, QC, risultati DE, top geni
- Lista file generati
```

---

## 🔥 Troubleshooting Prompts

### When Code Doesn't Work
```
Ho questo errore in R:
[INCOLLA ERRORE]

Correggi l'errore e spiega.
```

### When Plot Looks Wrong
```
Il plot non è come volevo.
Modifiche: [SPECIFICA]

Rigenera il codice.
```

### When Results Seem Off
```
Ho [NUMERO] geni DE. Sembra [troppo alto/basso].
Cosa è sbagliato? Che controlli fare?
```

---

## Skills Reference

| Phase | Skill Used | Key Functions |
|-------|------------|---------------|
| Trimming | CLI tool | fastp (QC + adapter trimming) |
| QC Aggregation | CLI tool | MultiQC (combine reports) |
| Quantification | CLI tool | salmon (transcript-level quant) |
| FastQC | `bio-rnaseq-qc` | Phred, adapters, duplication |
| QC | `bio-rna-quantification-count-matrix-qc` | Filter, PCA, correlation |
| DE | `bio-workflows-rnaseq-to-de` | DESeq2, tximport |
| Viz | `bio-data-visualization-specialized-omics-plots` | Volcano, MA, heatmap |
| Heatmaps | `bio-data-visualization-heatmaps-clustering` | ComplexHeatmap, pheatmap |
