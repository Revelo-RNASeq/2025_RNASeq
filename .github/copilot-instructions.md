# Copilot Instructions for REVELO RNA-Seq Course

Quarto-based educational course: **"Analisi Bulk RNA-Seq per Dottorandi"** in Italian for PhD students.

## Project Architecture

```
RNASeq_Course_2025/           # ACTIVE - Website + RevealJS slides
├── modules/
│   ├── 01_intro/             # Course introduction
│   ├── 02_rnaseq_basics/     # RNA-seq biology & experimental design
│   ├── 03_pipeline_nfcore/   # nf-core/rnaseq pipeline  
│   └── 04_analysis_R/        # R analysis (AI-driven demos)
│       ├── index.qmd         # Module landing page
│       ├── 01_tools.qmd      # RStudio setup
│       ├── 02_import.qmd     # tximport workflow
│       ├── 03_deseq2.qmd     # DESeq2 statistics
│       ├── 04_visualization.qmd
│       └── demo_prompts.qmd  # AI prompt templates
├── data/                     # Demo datasets (airway)
└── _quarto.yml               # Website config

resources/external/RNASeq/    # REFERENCE BOOK - Deep-dive R tutorials
├── 001_sec-preproc*.qmd      # Preprocessing (import, filter, EDA)
├── 002_sec-DEG*.qmd          # Differential expression
├── 003_sec-vis*.qmd          # Visualization
└── _quarto.yml               # Book config

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
    css: ["css/theme.css", "css/custom.css"]
    theme: simple
mainfont: "Times New Roman"
filters:
  - roughnotation
```

**Slide patterns** (see `modules/02_rnaseq_basics/index.qmd`):
- Title slides: background-image + absolute positioned text box
- Section headers: `{.tit .p-span-center}` class
- Emphasis: `{.rn}` class for roughnotation highlight
- Two-column layout: `:::: {.columns}` / `::: {.column width="50%"}`

## AI-Assisted Teaching Model

**Philosophy**: Students learn to *prompt* and *verify*, not write raw code.

**Module 4 Demo Flow** (see `demo_prompts.qmd`):
1. Present concept (Italian explanation)
2. Show prompt template in `::: {.callout-tip}` block
3. Student copies prompt → AI generates code → Student runs & verifies

**Available Skills** (`.github/skills/`):
| Skill | Use Case |
|-------|----------|
| `bio-rnaseq-qc` | FastQC/MultiQC interpretation, QC thresholds |
| `bio-rna-quantification-count-matrix-qc` | Count matrix validation before DE |
| `bio-workflows-rnaseq-to-de` | End-to-end Salmon → DESeq2 pipeline |
| `bio-data-visualization-heatmaps-clustering` | ComplexHeatmap patterns |
| `bio-data-visualization-specialized-omics-plots` | Volcano, MA, PCA plots |

When creating new demo content, read relevant `SKILL.md` to ensure accuracy.

## Content Guidelines

- **Language**: All student-facing content in **Italian**
- **Focus**: Concepts and biological interpretation, NOT syntax memorization
- **Code blocks**: Show expected output, not just code
- **Callouts**: Use `.callout-important` for critical concepts, `.callout-tip` for prompts

## File Conventions

- **Naming**: `NN_topic.qmd` (e.g., `01_tools.qmd`, `02_import.qmd`)
- **Images**: `modules/<module>/images/` or shared in `data/images/`
- **Links**: Relative paths from document root
- **Data**: Pre-computed in `data/` (airway dataset for demos)

## Tech Stack

- **Render**: Quarto → HTML website
- **Pipeline**: nf-core/rnaseq (STAR/Salmon)
- **Analysis**: R/Bioconductor (`tximport`, `DESeq2`, `ComplexHeatmap`, `clusterProfiler`)
- **Styling**: `css/theme.css`, `css/custom.css`
