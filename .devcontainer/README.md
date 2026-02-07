# Dev Container - Build & Deployment Guide

## 🎯 Overview

This directory contains configuration for building and distributing a pre-built Docker image for the RNA-seq course.

## 📦 For Course Instructor (You)

### First Time: Build and Push Image

```bash
# 1. Make sure Docker Desktop is running

# 2. Navigate to project root
cd /Users/chiapell/personale/REVELO/2025_RNASeq_v2

# 3. Build and push to Docker Hub (15-30 minutes)
./.devcontainer/build-and-push.sh

# You'll be prompted for your Docker Hub password
```

This script will:
1. Build the image with all tools pre-installed
2. Test that everything works
3. Push to `chiapellom/rnaseq-course:2025`

### Update the devcontainer.json for Students

After successful push, replace `.devcontainer/devcontainer.json` with the student version:

```bash
# Copy student version to main config
cp .devcontainer/devcontainer.STUDENT.json .devcontainer/devcontainer.json
```

### Rebuild the Image (for updates)

If you need to update tools or packages:

```bash
# 1. Make changes to Dockerfile
vim .devcontainer/Dockerfile

# 2. Rebuild and push
./.devcontainer/build-and-push.sh

# 3. Students will get the update next time they rebuild their container
```

## 👨‍🎓 For Students

**Students don't build anything!** They just:

1. Install Docker Desktop + VS Code + Dev Containers extension
2. Clone the course repository
3. Open in VS Code → "Reopen in Container"
4. Wait 3-5 minutes for the image to download
5. Start working ✅

See [SETUP_STUDENTI.md](./SETUP_STUDENTI.md) for detailed Italian instructions.

## 📦 What's Included

### Bioinformatics Tools
- **Salmon** - RNA-seq quantification
- **FastQC** - Quality control
- **MultiQC** - Aggregate QC reports
- **fastp** - Read trimming and filtering
- **samtools** - BAM file manipulation

### R/Bioconductor
- **DESeq2** - Differential expression
- **tximport** - Import quantification data
- **ComplexHeatmap** - Advanced heatmaps
- **clusterProfiler** - Pathway enrichment
- **EnhancedVolcano** - Volcano plots
- **airway** - Demo dataset

### Development Tools
- **Quarto** - Render course materials
- **Python 3.11** - Analysis scripts
- **VS Code extensions** - R, Python, Quarto, Jupyter

## 🧪 Test Your Environment

```bash
# Check R and packages
R --version
R -e "library(DESeq2); library(tximport)"

# Check bioinformatics tools
salmon --version
fastqc --version
multiqc --version

# Check Quarto
quarto --version
```

## 📁 Files Explanation

```
.devcontainer/
├── Dockerfile                    # Build recipe for the image
├── devcontainer.BUILD.json       # Config for building (instructor use)
├── devcontainer.STUDENT.json     # Config for students (pulls image)
├── devcontainer.json             # Active config (copy from STUDENT version)
├── build-and-push.sh            # Automated build+push script
├── SETUP_STUDENTI.md            # Italian instructions for students
└── README.md                     # This file
```

## 🐳 Docker Hub

**Image**: `chiapellom/rnaseq-course:2025`

**Contains**:
- Bioconductor 3.19 (R 4.3+)
- Quarto CLI
- Bioinformatics tools: Salmon, FastQC, MultiQC, fastp, samtools
- R packages: DESeq2, tximport, ComplexHeatmap, clusterProfiler, etc.
- Python packages: pandas, matplotlib, seaborn
- Node.js 20

## 🔄 Workflow

### Instructor Workflow
1. Make changes to course materials
2. If tools/packages change: update Dockerfile → rebuild → push
3. Students pull latest image

### Student Workflow
1. Install prerequisites (one time)
2. Clone repo
3. Open in container (downloads image automatically)
4. Work on assignments
5. Commit changes (files are persistent)

## 🎓 During the Course

**No internet needed** during course (after initial setup):
- Image is already downloaded locally
- All tools pre-installed
- Students can work offline

## ✅ Testing

Test on both platforms:

```bash
# Windows (PowerShell) or macOS (Terminal)
docker pull chiapellom/rnaseq-course:2025
docker run -it --rm chiapellom/rnaseq-course:2025 bash

# Inside container, verify:
salmon --version
R -e "library(DESeq2)"
quarto --version
```

## 🐛 Common Issues

**Build fails**: Check Docker Desktop is running and has enough resources

**Push fails with "unauthorized"**: Run `docker login` first

**Image too large**: Current size should be ~3-4GB

**Students get rate limit errors**: Consider GitHub Container Registry (ghcr.io)
