#!/bin/bash

# Get current Git branch
BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || echo "main")

echo "Building Docker image for branch: $BRANCH"

# Set Docker image name based on branch
if [ "$BRANCH_NAME" == "origin/main" ]; then
  IMAGE_NAME="sivakumar135/guvi_project_prod:latest"
else
  IMAGE_NAME="sivakumar135/guvi_project_dev:latest"
fi

# Build the image
docker build -t react_app .
docker tag react_app $IMAGE_NAME

echo "Image tagged as $IMAGE_NAME"
