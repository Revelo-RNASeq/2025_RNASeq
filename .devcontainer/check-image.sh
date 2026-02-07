#!/bin/bash

echo "Checking build status..."
echo ""

# Check if image exists
if docker images | grep -q "chiapellom/rnaseq-course.*2025"; then
    echo "✅ Image chiapellom/rnaseq-course:2025 EXISTS!"
    docker images chiapellom/rnaseq-course:2025 --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}\t{{.CreatedAt}}"
else
    echo "❌ Image not found yet"
fi

echo ""
echo "Recent builds:"
docker images | head -10
