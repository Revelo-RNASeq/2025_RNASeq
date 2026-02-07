# AI-Driven RNA-Seq Analysis: Prompt Pipeline

Quick reference guide for the practical demo. Copy prompts into Copilot Chat or ChatGPT.

---

## 🛠️ System Environment Setup (Linux Dev Container)

### Prompt 0: Environment Verification
```
Ho un ambiente Linux dev container per analisi RNA-seq (aarch64/ARM64 architecture).

Verifica la presenza di tutti gli strumenti necessari:

**Dipendenze di sistema** (apt):
- git, curl, wget
- build-essential, cmake
- zlib1g-dev, libbz2-dev, liblzma-dev (librerie di compressione)

**Bioinformatics tools**:
- fastp (QC e trimming FASTQ)
- salmon (quantificazione trascritti)
- multiqc (aggregazione report)
- samtools (manipolazione file SAM/BAM)

**R e Bioconductor** (ℝ >= 4.3.0):
- Pacchetti base: tidyverse, ggplot2, dplyr, data.table
- Bioconductor: tximport, DESeq2, ComplexHeatmap, clusterProfiler
- Pacchetti demo: airway, AnnotationDbi, org.Hs.eg.db
- Pacchetti visualizzazione: pheatmap, EnhancedVolcano

Fornisci istruzioni per:
1. Verificare presenza di dipendenze di sistema (which, dpkg -l)
2. Controllare versioni degli strumenti (fastp --version, salmon --version, R --version)
3. Testare disponibilità pacchetti R (R -e "library(DESeq2)")
4. Verificare struttura cartelle necessarie (results/, data/fastq_SUBSET/, data/trascriptome_TINY/)
5. Creare un report dello stato dell'ambiente (tool presente/mancante)

Se mancano strumenti, fornisci SOLO il comando di installazione specifico per quello mancante.
```

💡 **Cosa aspettarsi**: L'AI genererà comandi di verifica per ogni strumento/pacchetto e produrrà un report dello stato. Solo se qualcosa manca, fornirà il comando specifico di installazione.

📊 **Verifiche finali**:
- ✅ Tutti i tool di sistema disponibili: `which fastp salmon multiqc samtools R`
- ✅ R può caricare i pacchetti Bioconductor senza errori
- ✅ Le cartelle di lavoro esistono e sono accessibili

---

## �📂 Demo Data

**Pipeline in due fasi**:
1. **Fase 1 (Prompts 0a-0g)**: QC e quantificazione con 4 campioni FASTQ subset
2. **Fase 2 (Prompts 1-14)**: Analisi completa con il dataset `airway` (8 campioni)

### Fase 1: FASTQ Files

I file per il demo sono in `data/`:

| Cartella | Contenuto |
|----------|-----------|
| `fastq_SUBSET/` | 4 campioni paired-end (subset per velocità) |
| `trascriptome_TINY/` | Trascrittoma GENCODE v43 (subset) + indice Salmon |

**Campioni FASTQ** (subset didattico - 4 campioni):
| Sample | R1 | R2 | Condition |
|--------|----|----|-----------|
| SRR1039508 | `SRR1039508_pass_1_SUBSET.fastq` | `SRR1039508_pass_2_SUBSET.fastq` | control |
| SRR1039509 | `SRR1039509_pass_1_SUBSET.fastq` | `SRR1039509_pass_2_SUBSET.fastq` | treatment |
| SRR1039512 | `SRR1039512_pass_1_SUBSET.fastq` | `SRR1039512_pass_2_SUBSET.fastq` | control |
| SRR1039513 | `SRR1039513_pass_1_SUBSET.fastq` | `SRR1039513_pass_2_SUBSET.fastq` | treatment |

**Transcriptome**:
- `gencode.v43.transcripts_TINY.fa.gz` - per creare l'indice
- `gencode.v43_TINY.salmon/` - indice Salmon pre-costruito

### Fase 2: Dataset Airway (R Package)

Per l'analisi statistica e visualizzazione, useremo il dataset completo dal pacchetto Bioconductor `airway`:

**Caratteristiche**:
- **8 campioni**: 4 controlli (`untrt`) + 4 trattati con desametasone (`trt`)
- **4 linee cellulari** (biological replicates): N61311, N052611, N080611, N061011
- **~64,000 geni** quantificati
- **Design sperimentale più robusto** per analisi statistica

💡 **Perché questo switch?**: 
- Il subset FASTQ (4 campioni) è ottimo per imparare la pipeline di preprocessing (veloce, didattico)
- Il dataset `airway` completo è più appropriato per imparare l'analisi statistica (più replicati = più potenza statistica)

---

## 🔬 FASE 1: QC e Quantificazione

### 🔍 QC dei Reads (FASTQ)

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

## 🧬 FASE 2: Analisi Statistica (Dataset Airway)

**🔄 Switch Dataset**: Da questo punto in poi, useremo il dataset `airway` completo (8 campioni) per un'analisi statistica più robusta.

---

## 🔧 Setup (R Analysis)

### Prompt 1: R Environment Setup (Analysis)
```
Setup ambiente per analisi RNA-seq in R.
Librerie: DESeq2, airway, ggplot2, pheatmap, ComplexHeatmap.
Crea cartella results/
```

### Prompt 2: Load Airway Dataset
```
Carica il dataset airway dal pacchetto Bioconductor.
Estrai la matrice dei conteggi e i metadati dei campioni.
Mostra struttura del dataset: numero campioni, numero geni, condizioni.
Converti 'dex' (trattamento) in factor (untrt, trt).
```

💡 **Cosa succede**: L'AI caricherà il pacchetto `airway`, estrarrà l'oggetto `SummarizedExperiment`, e preparerà i dati per DESeq2.

📊 **Output atteso**:
- Matrice conteggi: 64,102 geni × 8 campioni
- Metadata: sample ID, cell line (4 linee), dex treatment (untrt/trt)

---

## 📊 QC Matrice

### Prompt 3: Library Size Check
```
Analizza library size della matrice di conteggi airway.
Crea barplot per condizione (untrt vs trt) e linea cellulare.
Identifica outliers.
```

### Prompt 4: Gene Filtering
```
Filtra geni a bassa espressione dal dataset airway (min 10 counts, in almeno 4 campioni).
Mostra distribuzione prima/dopo.
Spiega il razionale.
Quanti geni rimangono?
```

### Prompt 4b: PCA Esplorativa su Dati Raw
```
Prima della normalizzazione, crea un PCA plot sui dati raw airway filtrati.
Applica trasformazione log2 con pseudocount (+1) per stabilizzare la varianza.
Usa i top 500 geni più variabili.
Colora per trattamento (dex), forma per linea cellulare (cell).
Salva results/pca_raw_counts.pdf
```

💡 **Perché questo step?**: Il PCA sui dati raw (log-transformed) permette di identificare batch effects, outliers o problemi tecnici **prima** della normalizzazione. Se vediamo separazione per fattori tecnici invece che biologici, possiamo correggere il design.

📊 **Cosa cercare**: 
- I campioni dovrebbero separarsi per trattamento (biologico), non per batch tecnico
- Outliers evidenti che potrebbero richiedere rimozione
- Differenze di library size non dovrebbero dominare la varianza (altrimenti la normalizzazione è necessaria)

---

## 🔬 Analisi Esplorativa

### Prompt 5: VST Transformation
```
Crea DESeqDataSet con counts_filtered airway e metadata (design: ~dex).
Applica trasformazione VST.
Spiega perché usare VST invece di log2.
```

### Prompt 6: PCA Plot (Dati Normalizzati)
```
Crea PCA plot (top 500 geni) dei campioni airway VST-normalizzati.
Colora per trattamento (dex), forma per linea cellulare (cell).
Aggiungi ellissi 95% per gruppo di trattamento.
Salva results/pca_plot_vst.pdf
```

💡 **Confronto Raw vs VST**: Confronta questo PCA (dati normalizzati) con quello dei dati raw (Prompt 4b). La normalizzazione VST dovrebbe ridurre l'effetto della library size e stabilizzare la varianza, rendendo la separazione biologica più chiara.

📊 **Cosa cercare**: Con 8 campioni e 2 condizioni, il PCA dovrebbe mostrare una chiara separazione tra untrt e trt lungo PC1, più netta rispetto ai dati raw.

### Prompt 7: Sample Correlation
```
Crea heatmap di correlazione (Pearson) tra campioni airway VST.
Annota per trattamento (dex) e linea cellulare (cell).
Aggiungi clustering gerarchico (euclidean, complete).
Salva results/sample_correlation.pdf
```

---

## 📈 Analisi Differenziale

### Prompt 8: DESeq2 Analysis
```
Esegui analisi differenziale con DESeq2 sul dataset airway.
Contrasto: trt vs untrt (trattati con desametasone vs controlli).
Applica shrinkage (apeglm).
Mostra summary: quanti geni up/down regulated?
```

💡 **Risultati attesi**: ~1000-1500 geni differenzialmente espressi (p-adj < 0.1) tra trattati e controlli.

### Prompt 9: Diagnostic Plots
```
Crea plot diagnostici DESeq2 per il dataset airway:
1. Dispersion plot (gene-wise vs fitted)
2. P-value histogram
3. MA plot (log2FC vs mean expression)
Salva in results/
Spiega come interpretarli.
```

### Prompt 10: Filter Results
```
Filtra geni significativi dal confronto trt vs untrt (padj<0.05, |LFC|>1).
Separa UP/DOWN regulated.
Crea summary table: quanti geni in ogni categoria?
Salva results/DE_genes_airway.csv con gene names (se disponibili).
```

---

## 🎨 Visualizzazione

### Prompt 11: Volcano Plot
```
Crea volcano plot con risultati DESeq2 airway (trt vs untrt).
Colora UP (rosso), DOWN (blu), NS (grigio).
Soglie: padj<0.05, |LFC|>1.
Etichetta top 10 geni per significatività.
Salva results/volcano_plot_airway.pdf
```

### Prompt 12: Heatmap Top Genes
```
Crea heatmap top 50 geni DE del dataset airway (valori VST, z-score per riga).
Annota trattamento (dex) e linea cellulare (cell).
Cluster sia righe che colonne (euclidean, complete).
Mostra nomi dei geni.
Salva results/heatmap_top50_airway.pdf
```

💡 **Cosa cercare**: I campioni dovrebbero clusterizzare per trattamento (untrt vs trt), con pattern di espressione opposti per geni UP/DOWN.

### Prompt 13: Gene Boxplots
```
Crea boxplot top 4 geni DE airway (2 UP, 2 DOWN) con counts normalizzati.
Aggiungi punti individuali, colora per trattamento (dex).
Mostra gene symbols e adjusted p-value per ogni gene.
Griglia 2x2.
Salva results/top_genes_boxplot_airway.pdf
```

---

## 📝 Report

### Prompt 14: Summary Report
```
Genera report markdown dell'analisi completa:

**FASE 1 - QC & Quantification**:
- 4 campioni FASTQ processati (fastp, Salmon)
- Tool usati, parametri, output files

**FASE 2 - Statistical Analysis (Airway Dataset)**:
- 8 campioni, 2 condizioni (trt vs untrt)
- Geni filtrati, normalizzazione, trasformazione VST
- QC: PCA su dati raw e normalizzati (confronto), correlation heatmap
- Risultati DE: numero geni UP/DOWN, top hits
- Visualizzazioni generate

Lista tutti i file generati in results/
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
Ho [NUMERO] geni DE nel dataset airway. Sembra [troppo alto/basso].
Cosa è sbagliato? Che controlli fare?
```

### Dataset Comparison
```
Ho due dataset: FASTQ subset (4 campioni) e airway (8 campioni).
Spiega le differenze nell'analisi statistica:
- Potenza statistica
- Numero geni rilevabili come DE
- Robustezza delle stime di dispersione
```

### PCA Raw vs Normalized
```
Ho due PCA plot: uno sui dati raw (log2-transformed) e uno sui dati VST-normalizzati.
Confrontali e spiega:
- Perché la separazione dei campioni è diversa?
- Quale mostra meglio il segnale biologico?
- Quando la normalizzazione è essenziale?
```

---

## 🧹 Cleanup & Reset

### Prompt 15a: Clean Phase 1 Only
```
Ho i risultati della Fase 1 (QC e quantificazione) in data/results/.
Voglio pulire solo questi file per risparmiare spazio, mantenendo l'analisi in results/.

Rimuovi in modo sicuro:
- data/results/fastp/
- data/results/salmon/
- data/results/multiqc/
- data/counts_matrix.csv e sample_metadata.csv

Non toccare: data/fastq_SUBSET/ e data/trascriptome_TINY/
```

### Prompt 15b: Clean Phase 2 Only
```
Ho i risultati dell'analisi in results/.
Voglio ripetere l'analisi con parametri diversi.

Rimuovi in modo sicuro tutti i file in results/ (PDF, CSV, etc.).
Non toccare: data/ e scripts/
```

### Prompt 15c: Full Reset
```
Voglio resettare completamente il progetto, rimuovendo TUTTI i file generati.

Rimuovi in modo sicuro:
- data/results/ (tutto)
- results/ (tutto)
- data/counts_matrix.csv, sample_metadata.csv
- .RData, .Rhistory

Preserva solo: data/fastq_SUBSET/, data/trascriptome_TINY/, data/scripts/
```

💡 **Suggerimento**: Per dettagli completi sulle strategie di cleanup, consulta la skill `rnaseq-pipeline-cleanup` in `.github/skills/`.

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
| Cleanup | `rnaseq-pipeline-cleanup` | Safe removal of generated results |
