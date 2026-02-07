#!/bin/bash
# Remove 'set -e' to continue even if some steps fail
set +e

echo "🧬 Setting up RNA-seq bioinformatics environment..."

# Install Quarto (skip if fails)
echo "📚 Installing Quarto..."
if command -v wget &> /dev/null; then
  wget -q https://github.com/quarto-dev/quarto-cli/releases/download/v1.4.550/quarto-1.4.550-linux-amd64.deb || echo "⚠️  Quarto download failed, skipping..."
  if [ -f quarto-1.4.550-linux-amd64.deb ]; then
    dpkg -i quarto-1.4.550-linux-amd64.deb 2>/dev/null || echo "⚠️  Quarto install failed, may need manual install"
    rm -f quarto-1.4.550-linux-amd64.deb
  fi
else
  echo "⚠️  wget not found, skipping Quarto installation"
fi

# Install bioinformatics tools via conda/mamba (already in Bioconductor image)
echo "🔬 Installing bioinformatics tools..."
if command -v mamba &> /dev/null; then
  mamba install -y -c bioconda -c conda-forge \
    salmon \
    fastqc \
    multiqc \
    fastp \
    samtools || echo "⚠️  Some bioinformatics tools failed to install"
else
  echo "⚠️  mamba not found, skipping tool installation"
if command -v R &> /dev/null; then
  R --vanilla --quiet -e "
    tryCatch({
      if (!require('BiocManager', quietly = TRUE)) install.packages('BiocManager', repos='https://cloud.r-project.org/')
      BiocManager::install(c(
        'tximport',
        'DESeq2',
        'ComplexHeatmap',
        'clusterProfiler',
        'org.Hs.eg.db',
        'AnnotationDbi',
        'GenomicFeatures',
        'airway',
        'apeglm',
        'EnhancedVolcano'
      ), update = FALSE, ask = FALSE)
      
      # Install CRAN packages
      install.packages(c(
        'tidyverse',
        'pheatmap',
        'RColorBrewer',
        'ggrepel',
        'cowplot',
        'data.table'
      ), repos='https://cloud.r-project.org/')
      message('✅ R packages installed successfully')
    }, error = function(e) {
      message('⚠️  Some R packages failed to install: ', e$message)
    })
  " || echo "⚠️  R package installation had issues"
else
if command -v pip &> /dev/null; then
  pip install --no-cache-dir \
    pandas \
    numpy \
    matplotlib \
    seaborn \
    pyyaml || echo "⚠️  Some Python packages failed to install"
else
  echo "⚠️  pip not found"
fi

echo ""
echo "✅ Setup complete! Your RNA-seq environment is ready."
echo "📖 To preview the course: cd RNASeq_Course_2025 && quarto preview"
echo ""
echo "💡 Check installed tools:"
echo "  - salmon --version"
echo "  - fastqc --version"  
echo "  - quarto --version"
echo "  - R -e 'library(DESeq2)'
pip install --no-cache-dir \
  pandas \
  numpy \
  matplotlib \
  seaborn \
  pyyaml

echo "✅ Setup complete! Your RNA-seq environment is ready."
echo "📖 To preview the course: cd RNASeq_Course_2025 && quarto preview"
