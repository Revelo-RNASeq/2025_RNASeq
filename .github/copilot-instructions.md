````instructions
# Copilot Instructions for REVELO RNA-Seq Course

Quarto-based educational course: **"Analisi Bulk RNA-Seq per Dottorandi"** in Italian for PhD students.

## Project Architecture

```
RNASeq_Course_2025/           # ACTIVE - Website + RevealJS slides
├── modules/
│   ├── 01_intro/             # Course introduction
│   ├── 02_rnaseq_basics/     # RNA-seq biology & experimental design
│   │   └── index.qmd         # Main slide deck with examples
│   ├── 03_pipeline_nfcore/   # nf-core/rnaseq pipeline
│   │   └── index.qmd
│   └── 04_analysis_R/        # R analysis (AI-driven demos)
│       ├── index.qmd         # Module landing page
│       ├── 01_tools.qmd      # RStudio setup
│       ├── 02_import.qmd     # tximport workflow
│       ├── 03_deseq2.qmd     # DESeq2 statistics explained
│       ├── 04_visualization.qmd
│       ├── demo_prompts.qmd  # ⭐ AI prompt templates (763 lines)
│       ├── prompt_reference.md
│       └── review.qmd
├── data/                     # Demo datasets (airway) + scripts
│   ├── fastq_SUBSET/         # 4 paired-end samples (SRR1039508-13)
│   ├── trascriptome_TINY/    # GENCODE v43 subset + Salmon index
│   ├── scripts/              # Setup & analysis helpers
│   ├── txi_salmon.rds        # Pre-computed tximport object
│   └── README.md             # Data setup instructions
├── _quarto.yml               # Website config (output-dir: docs/)
└── index.qmd                 # Landing page with module links

resources/external/RNASeq/    # REFERENCE BOOK - Deep-dive R tutorials
├── 001_sec-preproc*.qmd      # Preprocessing (import, filter, EDA)
├── 002_sec-DEG*.qmd          # Differential expression
├── 003_sec-vis*.qmd          # Visualization
├── _quarto.yml               # Book config (type: book)
└── _common.R                 # Shared knitr options

.github/skills/               # AI skills for domain knowledge
```

## Developer Workflow

```bash
# Preview website
cd RNASeq_Course_2025 && quarto preview

# Preview reference book
cd resources/external/RNASeq && quarto preview

# Render single slide deck
quarto render modules/04_analysis_R/demo_prompts.qmd
```

## RevealJS Slide Template

All slide files use this YAML header:
```yaml
format: 
  revealjs:
    navigation-mode: vertical
    slide-number: true
    width: 1600
    height: 900
    logo: "images/revelo.png"
    footer: "[home page](https://revelo-rnaseq.github.io/2024_RNASeq_website)"
    css: ["css/theme.css", "css/custom.css"]
    theme: simple
    controls: true
mainfont: "Times New Roman"
editor: source
filters:
  - roughnotation
```

**Slide patterns** (see `modules/02_rnaseq_basics/index.qmd` and `03_deseq2.qmd`):

- **Title slides**: background-image + absolute positioned styled div
  ```markdown
  ##  {#TitleSlide background-image="images/back001.jpg" background-opacity="0.3"}
  ::: {style="position: absolute; left: 180px; top: 200px; ..."}
  [Module Title]{style="font-size: 100px; font-weight: bold;"}
  :::
  ```

- **Section headers**: `{.tit .p-span-center}` class for centered titles
  ```markdown
  #  {background-image="images/back001.jpg" background-opacity="0.1"}
  [Your Section Title]{.tit .p-span-center}
  ```

- **Subsection headers**: `{.subtit}` class for subtitles
  ```markdown
  [Median of Ratios]{.subtit}
  ```

- **Emphasis**: `{.rn}` class for roughnotation highlight (underline/circle)
  ```markdown
  [Important term]{.rn}
  ```

- **Two-column layout**: Use columns div with 50% width
  ```markdown
  :::: {.columns}
  ::: {.column width="50%" .f30}
  Left content
  :::
  ::: {.column width="50%" .f30}
  Right content
  :::
  ::::
  ```

- **Text utilities**: `.tcenter` (centered), `.f30`/`.f100` (font sizes), `.p-img-center` (centered images)

## AI-Assisted Teaching Model

**Philosophy**: Students learn to *prompt* and *verify*, not write raw code.

**Module 4 Demo Flow** (see `modules/04_analysis_R/demo_prompts.qmd` - 763 lines):
1. Present concept (Italian explanation)
2. Show prompt template in `::: {.callout-tip}` block
3. Student copies prompt → AI generates code → Student runs & verifies

**Prompt template example** (from demo_prompts.qmd):
```markdown
::: {.callout-tip}
## Copia questo prompt in Copilot Chat

```
Ho file FASTQ paired-end da un esperimento RNA-seq Illumina
nella cartella data/fastq_SUBSET/. Esegui il quality control
e il trimming degli adattatori.
Voglio:
1. Rimuovere le basi di bassa qualità (Phred < 20)
2. Rimuovere automaticamente gli adattatori Illumina
3. Salvare gli output in 'results/fastp/'
```
:::
```

**Dataset**: Airway (4 paired-end samples) with pre-computed files:
- Raw FASTQ in `data/fastq_SUBSET/` (SRR1039508, 09, 12, 13)
- Transcriptome index in `data/trascriptome_TINY/`
- Pre-computed tximport object: `data/txi_salmon.rds`

**Available Skills** (`.github/skills/`):
| Skill | Use Case |
|-------|----------|
| `bio-rnaseq-qc` | FastQC/MultiQC interpretation, QC thresholds |
| `bio-rna-quantification-count-matrix-qc` | Count matrix validation before DE |
| `bio-workflows-rnaseq-to-de` | End-to-end Salmon → DESeq2 pipeline |
| `bio-data-visualization-heatmaps-clustering` | ComplexHeatmap patterns |
| `bio-data-visualization-specialized-omics-plots` | Volcano, MA, PCA plots |
| `rnaseq-pipeline-cleanup` | Safely clean AI-generated results without affecting source data |

When creating new demo content, read relevant `SKILL.md` to ensure accuracy.

## Content Guidelines

- **Language**: All student-facing content in **Italian** (code comments in English)
- **Focus**: Concepts and biological interpretation, NOT syntax memorization
- **Code blocks**: Show expected output, not just code
- **Callouts**:
  - `.callout-important` - Critical concepts (e.g., "Use adjusted p-value, not p-value")
  - `.callout-tip` - AI prompt templates for students to copy
  - `.callout-note` - Additional context or references

**Biological emphasis examples** (from `03_deseq2.qmd`):
- Explain *why* median-of-ratios, not just *how*
- Teach dispersion shrinkage concept before showing DESeq() function
- Always contextualize statistics in biological terms

## File Conventions

- **Naming**: `NN_topic.qmd` (e.g., `01_tools.qmd`, `02_import.qmd`, `03_deseq2.qmd`)
- **Images**: `modules/<module>/images/` (module-specific) NOT FOUND - check actual paths
- **Links**: Relative paths from document root
  ```markdown
  [Module 4](modules/04_analysis_R/index.qmd)
  ```
- **Data structure**:
  - `data/fastq_SUBSET/` - Raw paired-end FASTQ files
  - `data/trascriptome_TINY/` - GENCODE v43 subset + Salmon index
  - `data/scripts/` - Helper scripts (R and bash)
  - `data/txi_salmon.rds` - Pre-computed tximport object (saves 10-15 min)
  - `data/README.md` - Instructions for generating demo data from airway package

## Tech Stack

- **Render**: Quarto → HTML website (main) + HTML book (reference)
- **Pipeline**: nf-core/rnaseq (STAR/Salmon)
- **Analysis**: R/Bioconductor (`tximport`, `DESeq2`, `ComplexHeatmap`, `clusterProfiler`)
- **Styling**: Custom CSS for slides (`css/theme.css`, `css/custom.css`), `r4ds.scss` for book

## Reference Book Structure

**Location**: `resources/external/RNASeq/` - Complete technical reference (type: book)

**Purpose**: Deep-dive tutorials with executable R code, complementing the slide-based course.

**Organization** (via `_quarto.yml`):
- **Part 1 (001_sec-preproc\*.qmd)**: Data import, filtering, EDA on raw/transformed counts
- **Part 2 (002_sec-DEG\*.qmd)**: Normalization, statistical theory, testing, shrinkage
- **Part 3 (003_sec-vis\*.qmd)**: Volcano plots, heatmaps

**Key differences from main course**:
- Main course: Slide-based, prompt-driven, Italian narrative
- Reference book: Code-heavy, detailed explanations, executed R chunks
- Shared R settings: `_common.R` (figure dimensions, ggplot2 themes)
- Italian UI: `code-summary: "Mostra il codice R"` in book config

## Critical Non-Obvious Patterns

1. **Pre-computed data usage**: `data/txi_salmon.rds` lets students skip 10-15 min quantification
   - Generated from airway package (see `data/README.md`)
   - Used in Module 4 demos to start directly from count matrix

2. **Salmon index structure**: `data/trascriptome_TINY/my_salmon_index/`
   - GENCODE v43 subset (not full) for demo speed
   - See `SALMON_INDEX_EXPLAINED.md` for rationale

3. **Skills-first approach**: Before generating bioinformatics code, **always read relevant skill**
   - Example: Creating volcano plot? Read `bio-data-visualization-specialized-omics-plots/SKILL.md`
   - Skills contain parameter best practices, common pitfalls

4. **Dual language context**: Italian for concepts, English for code
   - Slide text: Italian scientific terminology
   - R comments: English (standard practice)
   - Error handling prompts: Italian (student-facing)

## Verification Workflows

```bash
# Test single file render
quarto render RNASeq_Course_2025/modules/04_analysis_R/03_deseq2.qmd

# Check for render errors
echo $?  # Should return 0

# Validate all skills present
ls .github/skills/

# Quick preview without full render
cd RNASeq_Course_2025 && quarto preview
# Auto-reloads on save
```

**Before committing new content**:
- [ ] File renders without errors
- [ ] RevealJS navigation works (vertical mode)
- [ ] All images load (check paths relative to .qmd)
- [ ] Italian text is grammatically correct
- [ ] If bioinformatics code: consulted relevant skill

````
