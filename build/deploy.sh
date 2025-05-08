#!/bin/bash

# Get current Git branch
BRANCH=$(git rev-parse --abbrev-ref HEAD)

echo "Current branch: $BRANCH"

# Stop and remove any running container
docker-compose down || true

# Determine correct image
if [ "$BRANCH" == "main" ]; then
  echo "Deploying production image..."
  IMAGE="sivakumar135/guvi_project_prod:latest"
else
  echo "Deploying development image..."
  IMAGE="sivakumar135/guvi_project_dev:latest"
fi

# Pull image
docker pull "$IMAGE"

# Generate docker-compose.yml with proper quotes
cat > docker-compose.yml <<EOF
version: '3'
services:
  react-app:
    image: "$IMAGE"
    ports:
      - "80:80"
    container_name: react_app
EOF

# Deploy
docker-compose up -d
