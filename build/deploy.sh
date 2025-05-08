#!/bin/bash

# Get current Git branch
BRANCH=$(git rev-parse --abbrev-ref HEAD)

echo "Current branch: $BRANCH"

# Stop and remove running containers
docker-compose down || true

# Choose image based on branch
if [ "$BRANCH" == "main" ]; then
  echo "Deploying production image..."
  IMAGE="sivakumar135/guvi_project_prod:latest"
else
  echo "Deploying development image..."
  IMAGE="sivakumar135/guvi_project_dev:latest"
fi

# Pull the image
docker pull "$IMAGE"

# Create docker-compose.yml dynamically
cat > docker-compose.yml <<EOF
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
