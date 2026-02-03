## Plan: RNA-Seq Conceptual Course for PhD Students (Italian)

A 2-day (12-16 hours) non-coding RNA-Seq course that blends the conceptual flow already captured in [RNASeq/_quarto.yml](RNASeq/_quarto.yml) with Carpentries narratives, Galaxy Training and EBI resources, supported by AI-powered demos via GPTomics/skills.sh.

**TL;DR:** Create a Quarto-based course mimicking the [dataViz](dataViz/) structure with RevealJS presentations while reusing the curated book chapters in [RNASeq](RNASeq/) for scientific depth. The course focuses on interpretation rather than hands-on coding. AI demos (GPTomics bio-workflows-rnaseq-to-de) replace traditional coding exercises, and Galaxy plus EBI materials supply external context. Existing [Carpentries/_episodes](Carpentries/_episodes) and [RNASeq/002_sec-DEG.qmd](RNASeq/002_sec-DEG.qmd) through [RNASeq/003_sec-Visualization.qmd](RNASeq/003_sec-Visualization.qmd) underpin the storyline.

---

**Steps**

1. **Create project scaffold** - Copy structure from [dataViz](dataViz/) and align with the existing RNASeq book hierarchy:
   - Create new folder RNASeq_Course/ at workspace root
   - Copy and adapt [_quarto.yml](dataViz/_quarto.yml) with new title, Italian settings, 2-day navbar structure and cross-links back to [RNASeq/index.qmd](RNASeq/index.qmd) for further reading
   - Copy [styles.css](dataViz/styles.css) and [presentation-style.css](dataViz/materials/presentation-style.css)
   - Create materials/, materials/data/, materials/images/, transcripts/, resources/ folders mirroring the modular structure used in [RNASeq/001_sec-preproc.qmd](RNASeq/001_sec-preproc.qmd) through [RNASeq/003_sec-Visualization.qmd](RNASeq/003_sec-Visualization.qmd)

2. **Create core config files** integrating references to the RNASeq book:
   - index.qmd - Course homepage with schedule, objectives, prerequisites, and call-outs highlighting deeper chapters in [RNASeq/001_sec-preproc.qmd](RNASeq/001_sec-preproc.qmd) and [RNASeq/summary.qmd](RNASeq/summary.qmd)
   - setup.qmd - Setup instructions for GPTomics/skills.sh account plus optional links to [RNASeq/_common.R](RNASeq/_common.R) for instructors who want to replicate the computational environment
   - resources.qmd - Links to Galaxy, EBI, Carpentries, and curated references already listed in [RNASeq/references.qmd](RNASeq/references.qmd)
   - STRUCTURE.md - Project documentation describing how the RevealJS slides map to the RNASeq book parts and the Carpentries episodes

3. **Download external knowledge base** - Create resources/external/ with:
   - Galaxy Training transcriptomics tutorials (clone/download from https://training.galaxyproject.org/training-material/topics/transcriptomics/)
   - EBI RNA-Seq training materials (from https://www.ebi.ac.uk/training/events/introduction-rna-seq-and-functional-interpretation-2025/)
   - Store as reference PDFs, markdown files, and slide decks

4. **Create Day 1 modules** (focus: fundamentals and QC) weaving in RNASeq book narratives:
   - materials/01_introduzione_rnaseq.qmd - RNA-Seq overview, experimental design (adapt from [Carpentries/_episodes/01-introduction.md](Carpentries/_episodes/01-introduction.md), [Carpentries/_episodes/02-experimental-design-considerations.md](Carpentries/_episodes/02-experimental-design-considerations.md), and the scenario framing in [RNASeq/intro.qmd](RNASeq/intro.qmd))
   - materials/02_qualita_sequenze.qmd - FastQC interpretation, QC metrics (adapt from [Carpentries/_episodes/03-qc-of-sequencing-results.md](Carpentries/_episodes/03-qc-of-sequencing-results.md) and the preprocessing walkthrough in [RNASeq/001_a_sec-preproc_import.qmd](RNASeq/001_a_sec-preproc_import.qmd))
   - materials/03_workflow_bioinformatico.qmd - Alignment, SAM/BAM, counting concepts (adapt from [Carpentries/_episodes/04-bioinformatic-workflow.md](Carpentries/_episodes/04-bioinformatic-workflow.md) and [RNASeq/001_c_sec-preproc_filtraggio.qmd](RNASeq/001_c_sec-preproc_filtraggio.qmd)); include GPTomics demo for pipeline walkthrough referencing the datasets bundled under [RNASeq/data](RNASeq/data)
   - materials/04_valutazione_qualita.qmd - PCA, normalization, sample QC (adapt from [Carpentries/_episodes/05-descriptive-plots.md](Carpentries/_episodes/05-descriptive-plots.md) and [RNASeq/001_f_sec-preproc_EDA_trans.qmd](RNASeq/001_f_sec-preproc_EDA_trans.qmd))
   - materials/day1.qmd - Day 1 aggregation page with reading pointers into the preprocessing part of the RNASeq book

5. **Create Day 2 modules** (focus: differential expression and interpretation) grounding content in the DEG and visualization parts of the RNASeq book:
   - materials/05_analisi_differenziale.qmd - DESeq2 concepts, volcano plots, MA plots (adapt from [Carpentries/_episodes/06-differential-analysis.md](Carpentries/_episodes/06-differential-analysis.md) and [RNASeq/002_b_sec-DEG-stat.qmd](RNASeq/002_b_sec-DEG-stat.qmd)); include GPTomics demo for DE analysis tied to [RNASeq/002_d_sec-DEG-allinone.qmd](RNASeq/002_d_sec-DEG-allinone.qmd)
   - materials/06_arricchimento_funzionale.qmd - GO, KEGG, GSEA concepts (adapt from [Carpentries/_episodes/07-functional-enrichment.md](Carpentries/_episodes/07-functional-enrichment.md) and the supplementary insights in [RNASeq/summary.qmd](RNASeq/summary.qmd))
   - materials/07_interpretazione_risultati.qmd - Biological interpretation, pathway visualization (adapt from [Carpentries/_episodes/08-cluster-analysis.md](Carpentries/_episodes/08-cluster-analysis.md), [Carpentries/_episodes/09-metabolic-pathways.md](Carpentries/_episodes/09-metabolic-pathways.md), and [RNASeq/003_sec-Visualization.qmd](RNASeq/003_sec-Visualization.qmd))
   - materials/08_conclusioni_qa.qmd - Summary, best practices, Q&A, referencing [RNASeq/visualize.qmd](RNASeq/visualize.qmd) and [RNASeq/references.qmd](RNASeq/references.qmd)
   - materials/day2.qmd - Day 2 aggregation page with links back to DEG and visualization chapters for optional self-study

6. **Create AI demo guides** - Since no coding is involved, create demo scripts for GPTomics that echo the analyses in the RNASeq book:
   - materials/demos/demo_01_qc_pipeline.md - GPTomics prompts for FastQC walkthrough using screenshots and talking points from [RNASeq/001_d_sec-preproc_EDA_raw.html](RNASeq/_book/001_d_sec-preproc_EDA_raw.html)
   - materials/demos/demo_02_alignment_counting.md - GPTomics prompts for alignment/counting aligned with [RNASeq/001_b_sec-preproc_params.qmd](RNASeq/001_b_sec-preproc_params.qmd)
   - materials/demos/demo_03_differential_analysis.md - GPTomics prompts for DESeq2 workflow mirroring [RNASeq/002_c_sec-DEG-test.qmd](RNASeq/002_c_sec-DEG-test.qmd)
   - materials/demos/demo_04_enrichment.md - GPTomics prompts for functional enrichment drawing on figures captured in [RNASeq/_book/003_a_sec-vis-volcano.html](RNASeq/_book/003_a_sec-vis-volcano.html)

7. **Copy/adapt data files** for examples:
   - Copy [raw_counts.csv](Carpentries/r_analysis/tutorial/raw_counts.csv) and [samples_to_conditions.csv](Carpentries/r_analysis/tutorial/samples_to_conditions.csv) to materials/data/
   - Reuse summarized objects already available in [RNASeq/data](RNASeq/data) (for example GSE96870_coldata_all.csv, DE.rds, vst.rds) so that figures shown in class match the RNASeq book outputs
   - Copy pre-computed results like [differential_genes.tsv](Carpentries/r_analysis/tutorial/differential_genes.tsv) for showing outputs without running code

8. **Create figure exports** from Carpentries scripts and RNASeq book renders:
   - Export key visualizations (PCA plots, volcano plots, heatmaps) from [Carpentries/r_analysis/tutorial/episode_05.R](Carpentries/r_analysis/tutorial/episode_05.R), [Carpentries/r_analysis/tutorial/episode_06.R](Carpentries/r_analysis/tutorial/episode_06.R), [Carpentries/r_analysis/tutorial/episode_07.R](Carpentries/r_analysis/tutorial/episode_07.R) as static images
   - Capture high-resolution plots directly from [RNASeq/_book](RNASeq/_book) HTML outputs for consistency with book styling
   - Store in materials/images/ for embedding in presentations and AI demo scripts

---

**Verification**

1. Run quarto preview from RNASeq_Course/ to test local rendering
2. Verify all RevealJS presentations render correctly
3. Test GPTomics demo scripts work with skills.sh platform while ensuring datasets pulled from [RNASeq/data](RNASeq/data) are accessible for demonstrations
4. Verify external resources are accessible and properly cited
5. Review Italian translations for technical accuracy

---

**Decisions**

- **Quarto over Jekyll**: Chosen for consistency with dataViz and better RevealJS integration while leveraging the existing Quarto book in [RNASeq](RNASeq/)
- **8 modules over 9 episodes**: Consolidated content for 2-day format mapped onto the three-part structure already defined in the RNASeq book
- **Galaxy + EBI focus**: Per user preference, excluding HBC/UC Davis code-heavy materials but retaining the RNASeq book as the primary detailed reference
- **GPTomics for demos**: AI-powered demos replace traditional coding, allowing conceptual focus while showing real workflow execution using the datasets and visuals already curated in the RNASeq project
- **No exercise file triples**: Since course is non-coding, replaced with demo guide markdown files that tie back to RNASeq chapters and Carpentries exercises
