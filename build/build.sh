#!/bin/bash

# Get current Git branch
BRANCH=$(git rev-parse --abbrev-ref HEAD)

echo "Building Docker image for branch: $BRANCH"

# Set Docker image name based on branch
if [ "$BRANCH" == "main" ]; then
  IMAGE_NAME="sivakumar135/guvi_project_prod:latest"
else
  IMAGE_NAME="sivakumar135/guvi_project_dev:latest"
fi

# Build the image
docker build -t react_app .
docker tag react_app $IMAGE_NAME

echo "Image tagged as $IMAGE_NAME"
