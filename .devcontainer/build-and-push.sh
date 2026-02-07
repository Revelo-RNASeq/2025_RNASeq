#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
DOCKER_USERNAME="chiapellom"
IMAGE_NAME="rnaseq-course"
TAG="2025"
FULL_IMAGE="${DOCKER_USERNAME}/${IMAGE_NAME}:${TAG}"

echo -e "${BLUE}🐳 Building Docker image for RNA-seq Course 2025${NC}"
echo "Image: ${FULL_IMAGE}"
echo ""

# Clean up old images
echo -e "${YELLOW}🧹 Cleaning up old images...${NC}"
docker rmi $(docker images -q 'vsc-2025_rnaseq*') 2>/dev/null || echo "No old dev container images to remove"
docker rmi ${FULL_IMAGE} 2>/dev/null || echo "No existing ${FULL_IMAGE} to remove"
echo ""

# Build the image
echo -e "${BLUE}📦 Step 1: Building image (this may take 20-30 minutes)...${NC}"
cd "$(dirname "$0")/.."
docker build \
    -t ${FULL_IMAGE} \
    -f .devcontainer/Dockerfile \
    .

echo ""
echo -e "${GREEN}✅ Build complete!${NC}"
echo ""

# Test the image
echo -e "${BLUE}🧪 Step 2: Testing image...${NC}"
docker run --rm ${FULL_IMAGE} bash -c "
    source /opt/conda/etc/profile.d/conda.sh
    conda activate rnaseq
    echo '📊 Testing installed tools...'
    echo -n 'Quarto: ' && quarto --version
    echo -n 'Salmon: ' && salmon --version 2>&1 | head -n1
    echo -n 'FastQC: ' && fastqc --version
    echo -n 'MultiQC: ' && multiqc --version
    echo -n 'fastp: ' && fastp --version 2>&1 | head -n1
    echo -n 'Samtools: ' && samtools --version | head -n1
    echo -n 'Python: ' && python --version
    echo -n 'R: ' && R --version | head -n1
    echo -n 'R packages: ' && R --quiet --vanilla -e \"library(DESeq2); library(tximport); cat('✅ OK\n')\"
"

echo ""
echo -e "${GREEN}✅ Tests passed!${NC}"
echo ""

# Login to Docker Hub
echo -e "${BLUE}🔐 Step 3: Logging in to Docker Hub...${NC}"
echo "Please enter your Docker Hub password for user: ${DOCKER_USERNAME}"
docker login -u ${DOCKER_USERNAME}

echo ""
echo -e "${BLUE}📤 Step 4: Pushing image to Docker Hub...${NC}"
docker push ${FULL_IMAGE}

echo ""
echo -e "${GREEN}🎉 Success! Image pushed to Docker Hub${NC}"
echo ""
echo "Students can now use: ${FULL_IMAGE}"
echo ""
echo "📝 Next steps:"
echo "  1. Update devcontainer.json to use: \"image\": \"${FULL_IMAGE}\""
echo "  2. Share the repository with students"
echo "  3. Students will pull the image automatically when opening the container"
echo ""
echo "📊 Image size:"
docker images ${FULL_IMAGE} --format "{{.Size}}"
