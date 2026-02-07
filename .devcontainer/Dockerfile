# Use mambaforge as base - includes Python 3, mamba, and conda
FROM condaforge/mambaforge:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH=/opt/conda/bin:$PATH

USER root

# Install only Quarto (skip all apt R dependencies)
# Detect architecture and install appropriate version
RUN ARCH=$(dpkg --print-architecture) && \
    wget -q https://github.com/quarto-dev/quarto-cli/releases/download/v1.4.550/quarto-1.4.550-linux-${ARCH}.deb && \
    dpkg -i quarto-1.4.550-linux-${ARCH}.deb || true && \
    rm quarto-1.4.550-linux-${ARCH}.deb

# Create conda environment with R and bioinformatics tools
# All tools via conda only - no apt dependencies
RUN mamba create -n rnaseq -y -c conda-forge -c bioconda \
    python=3.11 \
    r-base=4.3 \
    bioconductor-deseq2 \
    bioconductor-tximport \
    bioconductor-complexheatmap \
    bioconductor-clusterprofiler \
    bioconductor-org.hs.eg.db \
    bioconductor-annotationdbi \
    bioconductor-genomicfeatures \
    bioconductor-apeglm \
    bioconductor-enhancedvolcano \
    bioconductor-airway \
    r-tidyverse \
    r-pheatmap \
    r-rcolorbrewer \
    r-ggrepel \
    r-cowplot \
    r-data.table \
    salmon \
    fastqc \
    multiqc \
    fastp \
    samtools \
    pandas \
    numpy \
    matplotlib \
    seaborn \
    pyyaml \
    && mamba clean -a -y

# Make conda environment default
RUN echo "source /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate rnaseq" >> ~/.bashrc

# Create rstudio user for compatibility
RUN useradd -m -s /bin/bash rstudio && \
    echo "source /opt/conda/etc/profile.d/conda.sh" >> /home/rstudio/.bashrc && \
    echo "conda activate rnaseq" >> /home/rstudio/.bashrc

# Create welcome message
RUN echo '#!/bin/bash' > /usr/local/bin/welcome.sh && \
    echo 'source /opt/conda/etc/profile.d/conda.sh' >> /usr/local/bin/welcome.sh && \
    echo 'conda activate rnaseq' >> /usr/local/bin/welcome.sh && \
    echo 'echo "🧬 RNA-seq Course 2025 - Bioinformatics Environment"' >> /usr/local/bin/welcome.sh && \
    echo 'echo "=================================================="' >> /usr/local/bin/welcome.sh && \
    echo 'echo "📦 Included tools:"' >> /usr/local/bin/welcome.sh && \
    echo 'echo "  - Salmon, FastQC, MultiQC, fastp, samtools"' >> /usr/local/bin/welcome.sh && \
    echo 'echo "  - R 4.3 + Bioconductor (DESeq2, tximport, airway, etc.)"' >> /usr/local/bin/welcome.sh && \
    echo 'echo "  - Python 3.11 + analysis packages"' >> /usr/local/bin/welcome.sh && \
    echo 'echo "  - Quarto for course materials"' >> /usr/local/bin/welcome.sh && \
    echo 'echo ""' >> /usr/local/bin/welcome.sh && \
    echo 'echo "📖 Course: cd RNASeq_Course_2025 && quarto preview"' >> /usr/local/bin/welcome.sh && \
    echo 'echo ""' >> /usr/local/bin/welcome.sh && \
    chmod +x /usr/local/bin/welcome.sh && \
    echo '/usr/local/bin/welcome.sh' >> /home/rstudio/.bashrc

# Set working directory
WORKDIR /workspace

# Switch to rstudio user
USER rstudio

# Initialize conda for this user
SHELL ["/bin/bash", "-c"]

# Labels
LABEL org.opencontainers.image.title="RNA-seq Course 2025"
LABEL org.opencontainers.image.description="Complete bioinformatics environment with Salmon, FastQC, R/Bioconductor, and Quarto"
LABEL org.opencontainers.image.authors="REVELO"
LABEL org.opencontainers.image.version="2025.1-conda"

