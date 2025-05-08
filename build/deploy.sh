#!/bin/bash

# Get current Git branch
BRANCH=$(git rev-parse --abbrev-ref HEAD)

echo "Current branch: $BRANCH"

# Stop and remove any running container
docker-compose down

# Clean up old images (optional)
# docker image prune -f

# Use the correct image based on the branch
if [ "$BRANCH" == "main" ]; then
  echo "Deploying production image..."
  docker pull sivakumar135/guvi_project_prod:latest
  IMAGE="sivakumar135/guvi_project_prod:latest"
else
  echo "Deploying development image..."
  docker pull sivakumar135/guvi_project_dev:latest
  IMAGE="sivakumar135/guvi_project_dev:latest"
fi

# Generate a temporary docker-compose file and run
cat > docker-compose.override.yml <<EOF
version: '3'
services:
  react-app:
    image: $IMAGE
    ports:
      - "80:80"
    container_name: react_app
EOF

docker-compose up -d

