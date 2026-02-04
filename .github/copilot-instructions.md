# Copilot Instructions for REVELO RNA-Seq Course

This project is a Quarto-based educational course: **"Analisi Bulk RNA-Seq per Dottorandi"**.

## Project Architecture
- **Root**: `RNASeq_Course_2025/` contains the source code for the Quarto website and slides.
- **Modules**: Located in `modules/<module_name>/`.
  - Content is organized into `.qmd` files (RevealJS presentations).
  - Each module typically has an `index.qmd` acting as a landing page or main slide deck.
- **Reference**: `2024_RNASeq_website/` contains legacy material, but `RNASeq_Course_2025/` is the active development target.
- **Language**: All student-facing content must be in **Italian**.

## Content Guidelines
- **Target Audience**: PhD students with biological backgrounds. Focus on *concepts* and *logic*, not syntax memorization.
- **Format**:
  - Use `revealjs` format for slides.
  - Apply standard YAML headers: `theme: simple`, `navigation-mode: vertical`, `mainfont: "Times New Roman"`.
  - Use `roughnotation` filters for highlighting.
- **Module 4 Specifics (R Analysis)**:
  - **No explicit code blocks** in slides. Use high-level descriptions or pseudo-code logic.
  - Emphasize AI-assisted workflows (prompting, verifying) over typing raw R code.
  - Key Libraries: `tximport`, `DESeq2`, `clusterProfiler`.
- **Pipeline Reference**: The course uses `nf-core/rnaseq` (Star/Salmon) as the standard upstream workflow.

## File & Path Conventions
- **Links**: Use relative paths from the document root.
- **Images**: Store module-specific images in `modules/<module>/images/` or shared in `materials/images/`.
- **Naming**: Use snake_case for directories and files (e.g., `01_intro.qmd`, `02_rnaseq_basics/`).

## Tech Stack
- **Engine**: Quarto (render to HTML/Website).
- **Styling**: `css/theme.css` and `css/custom.css`.
- **Bibliography**: `resources/references/references.bib`.
