#!/bin/bash

# Get current Git branch
BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || echo "main")
echo "Current branch: $BRANCH"

# Stop and remove any existing containers
docker-compose down || true

# Determine image to use
if [ "$BRANCH" == "orgin/main" ]; then
  echo "Deploying production image..."
  IMAGE="sivakumar135/guvi_project_prod:latest"
else
  echo "Deploying development image..."
  IMAGE="sivakumar135/guvi_project_dev:latest"
fi

# Pull the image
docker pull "$IMAGE"

# Generate docker-compose.yml with proper YAML formatting
cat <<EOF > docker-compose.yml
version: '3'
services:
  react-app:
    image: "$IMAGE"
    ports:
      - "80:80"
    container_name: react_app
EOF

# Start container
docker-compose up -d
