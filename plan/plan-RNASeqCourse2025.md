## Plan: RNA-Seq Conceptual Course for PhD Students

Create a 2-day (12-16 hours) non-coding RNA-Seq course in Italian using Quarto, mimicking the [dataViz](dataViz/) structure with RevealJS presentations. Content focuses on the core analysis pipeline: Sequencing, QC, Quantification (Reference-based & Pseudoalignment), Counts-to-Genes, Differential Expression, and Visualization. The course uses the [nf-core/rnaseq](https://nf-co.re/rnaseq/3.22.2/) pipeline as the reference workflow.

---

**Steps**

### Phase 1: Download Knowledge Base Resources

1. **Clone Galaxy Training transcriptomics tutorials** to `resources/external/galaxy_training/`:
   - `git clone --depth 1 https://github.com/galaxyproject/training-material.git` (then extract `topics/transcriptomics/`)
   - Key tutorials to archive: Reference-based RNA-Seq, RNA-seq reads to counts, Counts to genes, Volcano plot visualization.

2. **Download EBI training materials** to `resources/external/ebi_rnaseq/`:
   - Archive course description and learning outcomes from [EBI RNA-Seq 2025](https://www.ebi.ac.uk/training/events/introduction-rna-seq-and-functional-interpretation-2025/)
   - Topics: NGS technologies, file formats, QC, mapping, visualization.

3. **Create reference documents** in `resources/references/`:
   - Copy key papers listed in the PDF (Dillies normalization, Soneson DE comparison)
   - Export curated bibliography from [RNASeq/references.bib](RNASeq/references.bib)

---

### Phase 2: Create Project Scaffold (RNASeq_Course_2025/)

4. **Initialize project structure** mimicking [dataViz](dataViz/):
   ```
   RNASeq_Course_2025/
   ├── _quarto.yml          # Adapted from dataViz, Italian navbar
   ├── index.qmd            # Course homepage with 2-day schedule
   ├── setup.qmd            # skills.sh setup, no software install
   ├── resources.qmd        # Links to Galaxy, EBI, GPTomics demos
   ├── styles.css           # Copy from dataViz
   ├── .nojekyll
   ├── materials/
   │   ├── day1.qmd
   │   ├── day2.qmd
   │   ├── presentation-style.css
   │   ├── 01_*.qmd through 08_*.qmd
   │   ├── demos/           # AI demo guides
   │   ├── data/            # Pre-computed results
   │   └── images/          # Figures from RNASeq book
   ├── resources/
   │   └── external/        # Downloaded knowledge base
   ├── transcripts/         # Optional: lecture notes
   └── docs/                # GitHub Pages output
   ```

5. **Create core config files**:
   - [_quarto.yml](dataViz/_quarto.yml) adapted with Italian title "Analisi Bulk RNA-Seq per Dottorandi", 2-day navbar, links to RNASeq book
   - Copy [styles.css](dataViz/styles.css) and [presentation-style.css](dataViz/materials/presentation-style.css)
   - STRUCTURE.md documenting the module-to-source mapping

---

### Phase 3: Create Day 1 Modules (Sequencing to Quantification)

6. **materials/01_tecnologie_sequenziamento.qmd** - Sequencing technique:
   - Topic: NGS fundamentals, Illumina sequencing overview.
   - Ref: [2024_RNASeq_website/M3_RNASeq_Intro.qmd](2024_RNASeq_website/materials/M3_RNASeq_Intro.qmd).

7. **materials/02_rnaseq_reference_based.qmd** - Reference-based RNA-Seq & QC:
   - Topics: Experimental design, RNA-seq QC (FastQC), Trimming.
   - Ref: [Carpentries/02](Carpentries/_episodes/02-experimental-design-considerations.md), [Carpentries/03](Carpentries/_episodes/03-qc-of-sequencing-results.md).
   - Intro to **nf-core/rnaseq** pipeline structure (FASTQ -> MultiQC).

8. **materials/03_reads_to_counts.qmd** - Reads to Counts:
   - Topics: Alignment concepts (STAR/HISAT2) vs Pseudoalignment (Salmon/Kallisto).
   - Focus: Quantification explanation.
   - Ref: [RNASeq/001_c_sec-preproc_filtraggio.qmd](RNASeq/001_c_sec-preproc_filtraggio.qmd).
   - Demo: `bio-workflows-rnaseq-to-de` (Quantification step).

9. **materials/04_counts_to_genes.qmd** - Counts to Genes & Sample QC:
   - Topics: Gene-level summarization (tximport), Library size, PCA, Sample correlation.
   - Ref: [RNASeq/001_f_sec-preproc_EDA_trans.qmd](RNASeq/001_f_sec-preproc_EDA_trans.qmd).

10. **materials/day1.qmd** - Day 1 aggregation page.

---

### Phase 4: Create Day 2 Modules (Analysis & Visualization)

11. **materials/05_analisi_differenziale.qmd** - Differential Expression:
    - Topics: DESeq2 statistical model, normalization, design formulas.
    - Ref: [RNASeq/002_b](RNASeq/002_b_sec-DEG-stat.qmd), [RNASeq/002_c](RNASeq/002_c_sec-DEG-test.qmd).

12. **materials/06_visualizzazione_risultati.qmd** - Visualizations:
    - Topics: Volcano plots, Heatmaps, MA plots.
    - Focus: Interpreting standard RNA-seq plots.
    - Ref: [RNASeq/003_sec-Visualization.qmd](RNASeq/003_sec-Visualization.qmd).

13. **materials/07_interpretazione_finale.qmd** - Conclusion:
    - Summary of the pipeline (from nf-core perspective).
    - Best practices and resource pointers.

14. **materials/day2.qmd** - Day 2 aggregation page.

---

### Phase 5: Create AI Demo Guides & Data Files

15. **materials/demos/** - Create demo scripts aligned with new flow:
    - `demo_01_qc_mapping.md`: FastQC + mapping concepts.
    - `demo_02_quantification.md`: Pseudoalignment walkthrough.
    - `demo_03_counts_import.md`: tximport/PCA demo.
    - `demo_04_differential.md`: DESeq2 + Visualization.

16. **materials/data/** - Copy pre-computed results:
    - From [RNASeq/data](RNASeq/data/): `GSE96870_counts_cerebellum.csv`, `GSE96870_coldata_all.csv`, `DE.rds`, `vst.rds`

17. **materials/images/** - Export key figures:
    - **Crucial**: nf-core/rnaseq metro map.
    - Capture from [RNASeq/_book](RNASeq/_book/) HTML renders: PCA plots, volcano plots.

---

**Verification**

1. Run `quarto preview` from RNASeq_Course_2025/ to test local rendering
2. Verify all 8 RevealJS presentations render correctly in Italian
3. Test GPTomics demo links work with skills.sh platform
4. Verify external Galaxy/EBI resources are accessible and properly cited
5. Run `quarto render` and deploy to docs/ for GitHub Pages

---

**Decisions**

- **Galaxy + EBI focus**: Excluded HBC/UC Davis per user preference; these are code-heavy
- **8 modules for 2 days**: Consolidated Carpentries 9 episodes to fit 2-day format
- **GPTomics for demos**: AI-powered demos replace coding exercises, maintaining conceptual focus
- **Mouse GSE96870 dataset**: Primary dataset from RNASeq book for consistency
- **GitHub Pages via docs/**: Publishing target per plan specification
- **Italian language**: Consistent with existing RNASeq book and 2024_RNASeq_website
