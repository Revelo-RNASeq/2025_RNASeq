#!/bin/bash
# Quick test script to verify the built image

set -e

IMAGE="chiapellom/rnaseq-course:2025"

echo "🧪 Testing Docker image: ${IMAGE}"
echo ""

docker run --rm ${IMAGE} bash -c '
echo "✅ Verifying installation..."
echo ""

echo -n "📊 Quarto: "
quarto --version

echo -n "🧬 Salmon: "
salmon --version | head -n1

echo -n "🔬 FastQC: "
fastqc --version

echo -n "📈 MultiQC: "
multiqc --version

echo -n "✂️  fastp: "
fastp --version 2>&1 | head -n1

echo -n "🧰 Samtools: "
samtools --version | head -n1

echo -n "🐍 Python: "
python --version

echo ""
echo "📦 Testing R packages..."
R --quiet --vanilla -e "
  packages <- c(\"DESeq2\", \"tximport\", \"ComplexHeatmap\", \"clusterProfiler\", \"airway\")
  for (pkg in packages) {
    if (require(pkg, character.only = TRUE, quietly = TRUE)) {
      cat(sprintf(\"  ✅ %s\n\", pkg))
    } else {
      cat(sprintf(\"  ❌ %s NOT FOUND\n\", pkg))
      quit(status = 1)
    }
  }
"

echo ""
echo "🎉 All tests passed!"
'
