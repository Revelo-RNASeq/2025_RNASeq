# AGENTS.md

## Project Overview

This repository contains **"Analisi Bulk RNA-Seq per Dottorandi"** - a comprehensive Quarto-based educational course teaching bulk RNA-seq analysis to PhD students in Italian. The project uses an innovative AI-assisted teaching methodology where students learn to prompt AI tools rather than memorize code syntax.

### Architecture

The repository has a dual structure:

1. **RNASeq_Course_2025/** - Main course website with RevealJS slide presentations
2. **resources/external/RNASeq/** - Deep-dive reference book with detailed R tutorials

⚠️ **CRITICAL**: The `RNASeq_Course_2025/resources/` folder contains external reference materials (EBI, Galaxy Training) that **must NOT be rendered**. See [`.github/instructions/resources-folder-policy.md`](.github/instructions/resources-folder-policy.md) for details.

### Technology Stack

- **Presentation**: Quarto (website + RevealJS slides)
- **Pipeline**: nf-core/rnaseq (STAR/Salmon)
- **Analysis**: R/Bioconductor (`tximport`, `DESeq2`, `ComplexHeatmap`, `clusterProfiler`)
- **Styling**: Custom CSS (`css/theme.css`, `css/custom.css`)

### AI-Assisted Teaching Model

**Key Philosophy**: Students learn to *prompt* and *verify* AI-generated code, not write raw code from scratch. Module 4 demonstrates this approach with prompt templates that students use to generate analysis code via AI.

## Setup Commands

### Prerequisites

1. **Install Quarto**: https://quarto.org/docs/get-started/
   ```bash
   # macOS (via Homebrew)
   brew install --cask quarto
   
   # Verify installation
   quarto --version
   ```

2. **Install R** (≥ 4.3.0): https://cloud.r-project.org/

3. **Install R Packages**:
   ```r
   # Core packages
   install.packages(c("tidyverse", "quarto", "fontawesome", "rmarkdown"))
   
   # Bioconductor packages
   if (!require("BiocManager", quietly = TRUE))
       install.packages("BiocManager")
   
   BiocManager::install(c(
     "tximport", "DESeq2", "ComplexHeatmap", 
     "clusterProfiler", "GenomicFeatures", 
     "airway", "AnnotationDbi", "org.Hs.eg.db"
   ))
   ```

## Development Workflow

### Preview Course Website

```bash
cd RNASeq_Course_2025
quarto preview
# Opens in browser at http://localhost:XXXX
# Auto-reloads on file changes
```

### Preview Reference Book

```bash
cd resources/external/RNASeq
quarto preview
# Separate book preview
```

### Render Specific Module

```bash
# Render a single slide deck
quarto render RNASeq_Course_2025/modules/04_analysis_R/demo_prompts.qmd

# Render entire website
cd RNASeq_Course_2025
quarto render
# Output: docs/ directory
```

### Navigate Project Structure

```bash
# Jump to main modules
cd RNASeq_Course_2025/modules

# List available modules
ls -F modules/

# View Module 4 (AI-driven R analysis)
ls -F modules/04_analysis_R/
```

## File Organization and Naming Conventions

### Module Structure

```
modules/
  XX_topic/              # Two-digit prefix + descriptive name
    index.qmd            # Module landing page
    NN_subtopic.qmd      # Numbered subtopics (01, 02, 03...)
    images/              # Module-specific images
    demo_prompts.qmd     # AI prompt templates (Module 4)
```

### File Naming Rules

- **Modules**: `NN_descriptive_name/` (e.g., `01_intro/`, `04_analysis_R/`)
- **Content files**: `NN_topic.qmd` (e.g., `01_tools.qmd`, `02_import.qmd`)
- **Resources**: `data/`, `images/`, `scripts/` at appropriate levels

### RevealJS Slide Template

All slide `.qmd` files must include this YAML header:

```yaml
---
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
---
```

### Slide Patterns

- **Title slides**: Use `background-image` + absolute positioned text
- **Section headers**: Apply `{.tit .p-span-center}` class
- **Emphasis**: Use `{.rn}` class for roughnotation highlights
- **Two columns**: Wrap in `:::: {.columns}` with `::: {.column width="50%"}`

Example:
```markdown
## Section Title {.tit .p-span-center}

:::: {.columns}
::: {.column width="50%"}
Left content
:::
::: {.column width="50%"}
Right content
:::
::::
```

## Content Creation Guidelines

### Language and Style

- **Primary language**: Italian (all student-facing content)
- **Focus**: Biological concepts and interpretation over syntax memorization
- **Code blocks**: Always show expected output, not just code
- **Callouts**:
  - `.callout-important` - Critical concepts
  - `.callout-tip` - AI prompt templates
  - `.callout-note` - Additional context

### AI-Driven Demo Pattern (Module 4)

1. Present concept in Italian
2. Show prompt template in callout box
3. Student copies prompt → AI generates code → Student verifies

Example:
```markdown
::: {.callout-tip}
## Prompt per l'analisi differenziale

"Crea un oggetto DESeqDataSet usando la matrice dei conteggi 
e i metadati. Esegui l'analisi differenziale con DESeq2..."
:::
```

## Domain-Specific Skills

The repository includes bioinformatics skills in `.github/skills/` that provide expert knowledge for RNA-seq analysis. **Always consult these skills** before creating or modifying analysis content:

| Skill | When to Use |
|-------|-------------|
| `bio-rnaseq-qc` | FastQC/MultiQC interpretation, QC thresholds, library validation |
| `bio-rna-quantification-count-matrix-qc` | Count matrix validation before differential expression |
| `bio-workflows-rnaseq-to-de` | End-to-end Salmon → DESeq2 pipeline guidance |
| `bio-data-visualization-heatmaps-clustering` | ComplexHeatmap patterns, clustering strategies |
| `bio-data-visualization-specialized-omics-plots` | Volcano, MA, PCA plots for RNA-seq |
| `rnaseq-pipeline-cleanup` | Safely remove AI pipeline-generated results (QC, quantification, analysis outputs) without affecting source data |

### Using Skills

```bash
# Read skill content before generating analysis code
cat .github/skills/bio-workflows-rnaseq-to-de/SKILL.md

# Skills contain best practices, parameter choices, and common pitfalls
```

## Testing and Quality Checks

### Render Tests

```bash
# Test single file render
quarto render RNASeq_Course_2025/modules/04_analysis_R/03_deseq2.qmd

# Check for render errors
echo $?  # Should return 0

# Full website build test
cd RNASeq_Course_2025
quarto render
# Verify docs/ directory created without errors
```

### Link Validation

```bash
# Check for broken internal links
cd RNASeq_Course_2025
grep -r "](.*\.qmd)" modules/ | grep -v "^Binary"
# Verify all referenced .qmd files exist
```

### Preview Validation Checklist

Before committing new content:
- [ ] File renders without errors in `quarto preview`
- [ ] RevealJS slides display correctly (if applicable)
- [ ] All images load properly
- [ ] Code blocks execute (if not set to `eval: false`)
- [ ] Italian text is grammatically correct
- [ ] Links navigate to correct locations

## R Code Execution

### Demo Data Setup

The `data/` directory uses the **airway** dataset from Bioconductor:

```r
# Generate demo data (run once)
library(airway)
library(SummarizedExperiment)
data(airway)

# Export counts matrix
counts <- assay(airway)
write.csv(counts, "RNASeq_Course_2025/data/counts_matrix.csv")

# Export metadata
metadata <- as.data.frame(colData(airway))
metadata$sample_id <- rownames(metadata)
metadata$condition <- ifelse(metadata$dex == "untrt", "control", "treatment")
write.csv(metadata[, c("sample_id", "condition", "cell")], 
          "RNASeq_Course_2025/data/sample_metadata.csv", 
          row.names = FALSE)
```

### Running R Code in Quarto

Code chunks with `eval: true` will execute during render:

```r
# In .qmd file
```{r}
#| eval: true
#| echo: true
library(DESeq2)
# Code runs during render
```
````

Set `eval: false` for demonstration-only code.

## Configuration Files

### Main Website (_quarto.yml)

Located at `RNASeq_Course_2025/_quarto.yml`:
- Defines website structure and navigation
- Output directory: `docs/`
- Theme: `cosmo`
- Code folding enabled by default

### Reference Book (_quarto.yml)

Located at `resources/external/RNASeq/_quarto.yml`:
- Book-type project with chapters
- Output directory: `_book/`
- Italian UI text: `code-summary: "Mostra il codice R"`
- Includes custom CSS: `r4ds.scss`

### Common R Settings (_common.R)

The reference book uses `resources/external/RNASeq/_common.R` for consistent knitr chunk options:
- Figure dimensions: `fig.width = 6, fig.asp = 2/3`
- Console output formatting
- ggplot2 theme defaults

## CI/CD and Deployment

Currently manual deployment. Rendered output in `docs/` can be deployed to:
- GitHub Pages (set `output-dir: docs` in `_quarto.yml`)
- Netlify
- Custom web server

### Deployment Preparation

```bash
cd RNASeq_Course_2025
quarto render
# Upload docs/ directory to hosting service
```

## Common Tasks

### Add New Module

1. Create directory: `mkdir RNASeq_Course_2025/modules/NN_topic`
2. Create landing page: `touch RNASeq_Course_2025/modules/NN_topic/index.qmd`
3. Add to `_quarto.yml` sidebar
4. Follow RevealJS template for slides

### Add New Slide Deck

1. Copy YAML header from existing slide file
2. Structure content with `##` for slides
3. Use vertical navigation for related slides
4. Test with `quarto preview`

### Update Demo Prompts

Edit `RNASeq_Course_2025/modules/04_analysis_R/demo_prompts.qmd`:
- Wrap prompts in `.callout-tip` blocks
- Provide clear context in Italian
- Show expected code output structure
- Reference relevant skills for accuracy

### Modify Reference Book

```bash
cd resources/external/RNASeq

# Edit chapter files (001_*.qmd, 002_*.qmd, etc.)
# Part structure defined in _quarto.yml

quarto preview  # Test changes
```

## Troubleshooting

### Render Errors

```bash
# Increase verbosity
quarto render --verbose

# Check specific file
quarto render path/to/file.qmd --trace
```

### Missing R Packages

```r
# Check if package is installed
if (!require("packagename")) {
  BiocManager::install("packagename")  # For Bioconductor
  # OR
  install.packages("packagename")      # For CRAN
}
```

### RevealJS Slide Issues

- Verify YAML header includes all required fields
- Check CSS file paths are relative to `.qmd` location
- Test with basic slide first, then add complexity
- Use browser developer tools (F12) to debug layout

### Link Navigation Problems

- Always use workspace-relative paths in links
- Format: `[text](../path/to/file.qmd)`
- For slides: `[text](slides.qmd#/section-id)` (RevealJS anchor)

## Additional Notes

### Important Reminders

- **Language consistency**: All teaching content in Italian, code comments in English (standard practice)
- **AI-first approach**: Don't write complete analysis scripts for students - provide prompt templates instead
- **Biological focus**: Emphasize interpretation of results, not R syntax details
- **Skill consultation**: Read relevant `.github/skills/*.md` before generating bioinformatics content
- **Version control**: Ignore rendered outputs (`.gitignore` configured)

### External Resources

- **Course reference book**: Deep technical details in `resources/external/RNASeq/`
- **nf-core/rnaseq docs**: https://nf-co.re/rnaseq
- **Quarto documentation**: https://quarto.org/docs/guide/
- **RevealJS guide**: https://quarto.org/docs/presentations/revealjs/

## Agent Memory Prompt

Reminder for the agent:

- Always work inside the `RNASeq_Course_2025/` folder of the repository.
- Run commands from the repository root and use paths relative to `RNASeq_Course_2025/`.
- When creating or modifying files, prefer placing them under `RNASeq_Course_2025/`.
- Do not modify files or folders outside the repository without explicit permission.
- Before running tools that alter data (e.g., trimming, cleanup), verify that source files exist in `RNASeq_Course_2025/data/`.
- When showing commands to the user, display the full path relative to the repository root, for example:

```bash
bash RNASeq_Course_2025/scripts/run_fastp_batch.sh
```

Purpose: keep operations consistent and safe during demonstrations and course edits.


### Performance Considerations

- Large count matrices: Use `data.table::fread()` for faster loading
- Rendering time: Full website render can take 5-10 minutes with code execution
- Preview mode: Uses incremental rendering (faster for development)

