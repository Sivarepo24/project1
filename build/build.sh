#!/bin/bash

# Get current Git branch

echo "Building Docker image for branch: $BRANCH"

# Set Docker image name based on branch
if [ "$BRANCH_NAME" == "main" ]; then
  IMAGE_NAME="sivakumar135/guvi_project_prod:latest"
else
  IMAGE_NAME="sivakumar135/guvi_project_dev:latest"
fi

# Build the image
docker build -t react_app .
docker tag react_app $IMAGE_NAME

echo "Image tagged as $IMAGE_NAME"
