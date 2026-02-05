# AI-Driven RNA-Seq Analysis: Prompt Pipeline

Quick reference guide for the practical demo. Copy prompts into Copilot Chat or ChatGPT.

---

## � QC dei Reads (FASTQ)

### Prompt 0: MultiQC Interpretation
```
Sono un bioinformatico principiante. Spiegami come interpretare un report MultiQC per dati RNA-seq (Illumina).

Quali sono i 3 segnali di allarme più gravi (red flags) che dovrebbero fermare la mia analisi prima ancora di iniziare?
Focalizzati su: qualità delle basi (Phred score), contenuto di adattatori e duplicazione.
```

---

## �🔧 Setup

### Prompt 1: Environment Setup
```
Sto iniziando un'analisi RNA-seq in R. Ho bisogno di:
1. Caricare le librerie necessarie (DESeq2, tximport, ggplot2, pheatmap)
2. Impostare un seed per la riproducibilità
3. Creare una cartella 'results' per salvare i plot

Genera il codice di setup.
Includi anche una spiegazione:
- Perché carichiamo queste specifiche librerie?
- Cosa ci aspettiamo di vedere eseguendo il setup?
```

### Prompt 2: Load Data
```
Ho due file CSV:
- 'data/counts_matrix.csv': matrice di conteggi (geni x campioni)
- 'data/sample_metadata.csv': metadati campioni (colonne: sample_id, condition, batch)

Carica questi file e:
1. Mostra le prime 5 righe di ogni tabella
2. Verifica che i nomi dei campioni corrispondano tra i due file
3. Converti 'condition' in un fattore con livelli: control, treatment

Inoltre spiega:
- Perché serve convertire 'condition' in factor?
- Perché controllare l'ordine dei campioni è critico in DESeq2?
```

---

## 📊 QC Matrice

### Prompt 3: Library Size Check
```
Analizza la qualità della matrice di conteggi:
1. Calcola i conteggi totali per campione (library size)
2. Conta quanti geni sono espressi (>0 reads) per campione
3. Crea un barplot dei library size colorati per condizione
4. Identifica campioni con library size anomala (>2SD dalla media)

Commenta i risultati:
- È normale avere library size diverse?
- Quando una differenza diventa preoccupante (bias)?
```

### Prompt 4: Gene Filtering
```
Filtra i geni a bassa espressione:
1. Rimuovi geni con meno di 10 conteggi totali
2. Mantieni solo geni espressi in almeno 3 campioni
3. Mostra quanti geni rimangono dopo il filtro
4. Crea un istogramma della distribuzione dei conteggi (log2+1) prima e dopo

Spiega il razionale:
- Come impatta questo filtro sulla potenza statistica (FDR)?
- Perché rimuovere gli zero migliora la stima della dispersione?
```

---

## 🔬 Analisi Esplorativa

### Prompt 5: VST Transformation
```
Crea un oggetto DESeqDataSet da:
- counts_filtered: matrice di conteggi filtrata
- metadata: metadati campioni
- design formula: ~ condition

Poi applica la trasformazione VST (variance stabilizing transformation)
e spiega dettagliatamente:
- Il "Come": cosa fa matematicamente la VST rispetto al log2?
- Il "Perché": perché non usare i conteggi grezzi per la PCA?
```

### Prompt 6: PCA Plot
```
Crea un PCA plot dei campioni VST-normalizzati:
1. Usa i top 500 geni più variabili
2. Colora per 'condition'
3. Aggiungi ellissi di confidenza al 95%
4. Mostra la varianza spiegata da PC1 e PC2 negli assi
5. Salva come 'results/pca_plot.pdf'

Il plot deve essere publication-ready.
Aggiungi una guida alla lettura:
- Cosa significa se i campioni si sovrappongono?
- Cosa indica la percentuale di varianza sugli assi?
```

### Prompt 7: Sample Correlation
```
Crea una heatmap di correlazione tra i campioni:
1. Calcola la matrice di correlazione (Pearson) sui dati VST
2. Usa pheatmap con annotazioni per condition
3. Usa una palette blue → white per la correlazione
4. Aggiungi dendrogramma per clustering gerarchico
5. Salva come 'results/sample_correlation.pdf'

Spiega il risultato atteso:
- Che pattern (blocchi) dovremmo vedere se l'esperimento ha funzionato?
- Cosa indica una correzione bassa tra replicati?
```

---

## 📈 Analisi Differenziale

### Prompt 8: DESeq2 Analysis
```
Esegui l'analisi differenziale con DESeq2:
1. Imposta 'control' come livello di riferimento
2. Esegui DESeq()
3. Estrai i risultati per treatment vs control
4. Applica shrinkage con apeglm (se disponibile) o normal
5. Mostra il summary dei risultati

Spiega l'output:
- Cosa indica il **log2FoldChange** positivo vs negativo?
- Qual è la differenza pratica tra **pvalue** e **padj**?
```

### Prompt 9: Diagnostic Plots
```
Crea i plot diagnostici di DESeq2:
1. Dispersion plot (plotDispEsts) - verifica il fit del modello
2. P-value histogram - verifica la distribuzione attesa
3. MA plot con highlight dei geni significativi

Salva ogni plot in 'results/'.
Per ogni grafico, spiegami:
- Cosa rappresenta.
- "Goodness": che forma ha un buon grafico?
- "Badness": quali pattern indicano problemi?
```

### Prompt 10: Filter Results
```
Dai risultati DESeq2:
1. Filtra i geni significativi: padj < 0.05 AND |log2FoldChange| > 1
2. Separa in UP-regulated e DOWN-regulated
3. Crea una tabella summary con: totale testati, significativi, UP, DOWN
4. Salva i geni significativi in 'results/DE_genes.csv'
5. Mostra i top 10 geni per significatività

Spiega:
- Perché usiamo sia padj che LFC per filtrare?
- Come verificare se i top genes hanno senso biologico (sanity check)?
```

---

## 🎨 Visualizzazione

### Prompt 11: Volcano Plot
```
Crea un volcano plot publication-ready:
1. Asse X: log2FoldChange
2. Asse Y: -log10(pvalue)
3. Colora: rosso=UP (LFC>1, padj<0.05), blu=DOWN (LFC<-1, padj<0.05), grigio=NS
4. Aggiungi linee tratteggiate per i cutoff
5. Etichetta i top 10 geni più significativi con ggrepel
6. Usa tema minimal senza griglia
7. Salva come 'results/volcano_plot.pdf' (8x6 inches)

Spiega come leggere il grafico:
- Dove si trovano i geni più interessanti?
- Cosa rappresentano i punti grigi?
```

### Prompt 12: Heatmap Top Genes
```
Crea una heatmap dei top 50 geni differenzialmente espressi:
1. Seleziona i 50 geni con padj più basso
2. Usa i valori VST normalizzati
3. Scala per riga (z-score)
4. Aggiungi annotazione colonna per 'condition'
5. Usa palette RdBu (blue=bassa, red=alta espressione)
6. Cluster righe e colonne
7. Non mostrare i nomi dei geni (troppi)
8. Salva come 'results/heatmap_top50.pdf' (8x10 inches)

Spiega:
- Cosa rappresentano i colori (Z-score)?
- Cosa ci dice il clustering sulle righe (geni)?
```

### Prompt 13: Gene Boxplots
```
Per i top 4 geni significativi, crea un pannello di boxplot:
1. Estrai i conteggi normalizzati (counts(dds, normalized=TRUE))
2. Crea un boxplot per ogni gene con punti sovrapposti
3. Colora per condizione
4. Aggiungi il p-value (asterischi) sopra ogni confronto
5. Disponi in griglia 2x2
6. Salva come 'results/top_genes_boxplot.pdf'

Spiega:
- Perché visualizzare i singoli punti è meglio del solo boxplot?
- Cosa ci dice la distribuzione dei punti sulla variabilità?
```

---

## 📝 Report

### Prompt 14: Summary Report
```
Genera un report summary dell'analisi in formato markdown:
1. Descrizione dataset (campioni, condizioni)
2. Filtri applicati (geni rimossi)
3. Risultati QC (PCA interpretation, outlier?)
4. Risultati DE (numero geni UP/DOWN)
5. Top 10 geni per pathway relevance (se conosci la biologia)
6. Lista dei file generati

Formatta come report professionale breve.
```

---

## 🔥 Troubleshooting Prompts

### When Code Doesn't Work
```
Ho questo errore in R:
[INCOLLA ERRORE QUI]

Il codice che ho eseguito è:
[INCOLLA CODICE QUI]

Correggi l'errore e spiega cosa non andava.
```

### When Plot Looks Wrong
```
Il plot generato non è come lo volevo. Modifiche richieste:
- [SPECIFICA PROBLEMA 1]
- [SPECIFICA PROBLEMA 2]

Rigenera il codice con queste correzioni.
```

### When Results Seem Off
```
Ho ottenuto [NUMERO] geni differenzialmente espressi. Questo sembra [troppo alto/troppo basso].
Cosa potrebbe essere sbagliato? Quali controlli fare?
```

---

## Skills Reference

| Phase | Skill Used | Key Functions |
|-------|------------|---------------|
| FastQC | `bio-rnaseq-qc` | Phred, adapters, duplication |
| QC | `bio-rna-quantification-count-matrix-qc` | Filter, PCA, correlation |
| DE | `bio-workflows-rnaseq-to-de` | DESeq2, tximport |
| Viz | `bio-data-visualization-specialized-omics-plots` | Volcano, MA, heatmap |
| Heatmaps | `bio-data-visualization-heatmaps-clustering` | ComplexHeatmap, pheatmap |
