## Plan: RNA-Seq Conceptual Course for PhD Students (Italian)

A 2-day (12-16 hours) non-coding RNA-Seq course using concepts from existing Carpentries materials, Galaxy Training and EBI resources as knowledge base, with AI-powered demos via GPTomics/skills.sh for interactive workflow demonstrations.

**TL;DR:** Create a Quarto-based course mimicking the [dataViz](dataViz/) structure with RevealJS presentations. The course will focus on RNA-Seq concepts and interpretation rather than hands-on coding. AI demos (GPTomics bio-workflows-rnaseq-to-de) will replace traditional coding exercises. Download Galaxy Training and EBI materials to build a knowledge base. Content will be adapted from existing [Carpentries/_episodes](Carpentries/_episodes) covering introduction through functional enrichment.

---

**Steps**

1. **Create project scaffold** - Copy structure from [dataViz](dataViz/):
   - Create new folder `RNASeq_Course/` at workspace root
   - Copy and adapt [_quarto.yml](dataViz/_quarto.yml) with new title, Italian settings, 2-day navbar structure
   - Copy [styles.css](dataViz/styles.css) and [presentation-style.css](dataViz/materials/presentation-style.css)
   - Create `materials/`, `materials/data/`, `materials/images/`, `transcripts/`, `resources/` folders

2. **Create core config files**:
   - `index.qmd` - Course homepage with schedule, objectives, prerequisites (based on [dataViz/index.qmd](dataViz/index.qmd))
   - `setup.qmd` - Setup instructions for GPTomics/skills.sh account, no R/Python installation needed
   - `resources.qmd` - Links to Galaxy, EBI, and Carpentries resources
   - `STRUCTURE.md` - Project documentation (adapt from [dataViz/STRUCTURE.md](dataViz/STRUCTURE.md))

3. **Download external knowledge base** - Create `resources/external/` with:
   - Galaxy Training transcriptomics tutorials (clone/download from https://training.galaxyproject.org/training-material/topics/transcriptomics/)
   - EBI RNA-Seq training materials (from https://www.ebi.ac.uk/training/events/introduction-rna-seq-and-functional-interpretation-2025/)
   - Store as reference PDFs, markdown files, and slide decks

4. **Create Day 1 modules** (focus: fundamentals and QC):
   - `materials/01_introduzione_rnaseq.qmd` - RNA-Seq overview, experimental design (adapt from [Carpentries/_episodes/01-introduction.md](Carpentries/_episodes/01-introduction.md) and [02-experimental-design-considerations.md](Carpentries/_episodes/02-experimental-design-considerations.md))
   - `materials/02_qualita_sequenze.qmd` - FastQC interpretation, QC metrics (adapt from [03-qc-of-sequencing-results.md](Carpentries/_episodes/03-qc-of-sequencing-results.md))
   - `materials/03_workflow_bioinformatico.qmd` - Alignment, SAM/BAM, counting concepts (adapt from [04-bioinformatic-workflow.md](Carpentries/_episodes/04-bioinformatic-workflow.md)) - include GPTomics demo for pipeline walkthrough
   - `materials/04_valutazione_qualita.qmd` - PCA, normalization, sample QC (adapt from [05-descriptive-plots.md](Carpentries/_episodes/05-descriptive-plots.md))
   - `materials/day1.qmd` - Day 1 aggregation page

5. **Create Day 2 modules** (focus: differential expression and interpretation):
   - `materials/05_analisi_differenziale.qmd` - DESeq2 concepts, volcano plots, MA plots (adapt from [06-differential-analysis.md](Carpentries/_episodes/06-differential-analysis.md)) - include GPTomics demo for DE analysis
   - `materials/06_arricchimento_funzionale.qmd` - GO, KEGG, GSEA concepts (adapt from [07-functional-enrichment.md](Carpentries/_episodes/07-functional-enrichment.md))
   - `materials/07_interpretazione_risultati.qmd` - Biological interpretation, pathway visualization (adapt from [08-cluster-analysis.md](Carpentries/_episodes/08-cluster-analysis.md) and [09-metabolic-pathways.md](Carpentries/_episodes/09-metabolic-pathways.md))
   - `materials/08_conclusioni_qa.qmd` - Summary, best practices, Q&A
   - `materials/day2.qmd` - Day 2 aggregation page

6. **Create AI demo guides** - Since no coding is involved, create demo scripts for GPTomics:
   - `materials/demos/demo_01_qc_pipeline.md` - GPTomics prompts for FastQC walkthrough
   - `materials/demos/demo_02_alignment_counting.md` - GPTomics prompts for alignment/counting
   - `materials/demos/demo_03_differential_analysis.md` - GPTomics prompts for DESeq2 workflow
   - `materials/demos/demo_04_enrichment.md` - GPTomics prompts for functional enrichment

7. **Copy/adapt data files** for examples:
   - Copy [raw_counts.csv](Carpentries/r_analysis/tutorial/raw_counts.csv) and [samples_to_conditions.csv](Carpentries/r_analysis/tutorial/samples_to_conditions.csv) to `materials/data/`
   - Copy pre-computed results like [differential_genes.tsv](Carpentries/r_analysis/tutorial/differential_genes.tsv) for showing outputs without running code

8. **Create figure exports** from Carpentries R scripts:
   - Export key visualizations (PCA plots, volcano plots, heatmaps) from [episode_05.R](Carpentries/r_analysis/tutorial/episode_05.R), [episode_06.R](Carpentries/r_analysis/tutorial/episode_06.R), [episode_07.R](Carpentries/r_analysis/tutorial/episode_07.R) as static images
   - Store in `materials/images/` for embedding in presentations

---

**Verification**

1. Run `quarto preview` from `RNASeq_Course/` to test local rendering
2. Verify all RevealJS presentations render correctly
3. Test GPTomics demo scripts work with skills.sh platform
4. Verify external resources are accessible and properly cited
5. Review Italian translations for technical accuracy

---

**Decisions**

- **Quarto over Jekyll**: Chosen for consistency with dataViz and better RevealJS integration
- **8 modules over 9 episodes**: Consolidated content for 2-day format
- **Galaxy + EBI focus**: Per user preference, excluding HBC/UC Davis code-heavy materials
- **GPTomics for demos**: AI-powered demos replace traditional coding, allowing conceptual focus while showing real workflow execution
- **No exercise file triples**: Since course is non-coding, replaced with demo guide markdown files
