# Copilot Instructions for REVELO RNA-Seq Course

This project is a Quarto-based educational course: **"Analisi Bulk RNA-Seq per Dottorandi"**.

## Project Architecture
- **Root**: `RNASeq_Course_2025/` contains the active source code for the Quarto website and slides.
- **Legacy**: `2024_RNASeq_website/` contains reference material (do not edit unless specified).
- **Modules**: Located in `RNASeq_Course_2025/modules/<module_name>/`.
  - Content is organized into `.qmd` files (RevealJS presentations).
  - Each module has an `index.qmd` acting as the landing page.
- **Skills**: `.github/skills/` contains "GitHub Skills" definitions used for AI-assisted practical demos.

## Content Guidelines
- **Target Audience**: PhD students with biological backgrounds. Focus on *concepts* and *logic*, not syntax memorization.
- **Language**: All student-facing content must be in **Italian**.
- **Format**:
  - **Slides**: Use `revealjs` format in `.qmd` files.
  - **YAML Headers**: standard configuration:
    ```yaml
    format:
      revealjs:
        theme: simple
        navigation-mode: vertical
        mainfont: "Times New Roman"
        logo: "images/revelo.png"
    ```
  - **Highlighting**: Use `roughnotation` filters for emphasis.

## AI-Assisted Analysis & GitHub Skills
- **Philosophy**: The course teaches "AI as a pair programmer". Students focus on prompting and verification.
- **Practical Demos (Module 4)**:
  - Do **not** expect students to write raw R code.
  - **Workflow**:
    1.  **Select Skill**: Use skills from `.github/skills/` (e.g., `bio-data-visualization-heatmaps-clustering`).
    2.  **Prompt**: Students prompt the AI (Copilot/ChatGPT) using the skill's context.
    3.  **Verify**: Students run and validate the generated code using provided datasets.
  - **Reference**: When creating demo content, refer to the specific `SKILL.md` in `.github/skills/`.

## File & Path Conventions
- **Links**: Use relative paths from the document root.
- **Images**: Store module-specific images in `modules/<module>/images/` or shared in `RNASeq_Course_2025/data/images/`.
- **Naming**: Use snake_case for directories and files (e.g., `01_intro.qmd`, `02_rnaseq_basics/`).
- **Data**: Pre-computed results for demos are in `RNASeq_Course_2025/data/`.

## Tech Stack
- **Engine**: Quarto (render to HTML/Website).
- **Pipeline**: `nf-core/rnaseq` (Star/Salmon) is the reference upstream workflow.
- **Analysis**: R (Bioconductor) via AI-generated scripts.
  - Key Libraries: `tximport`, `DESeq2`, `clusterProfiler`, `ComplexHeatmap`.
- **Styling**: `css/theme.css` and `css/custom.css`.
