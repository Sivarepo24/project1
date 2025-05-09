#!/bin/bash

if [[ "$GIT_BRANCH" == "origin/main" ]]; then
  IMAGE_NAME="sivakumar135/guvi_project_prod:latest"
  docker build -t react_app .
  docker tag react_app "$IMAGE_NAME"
  echo "Image tagged as $IMAGE_NAME"

elif [[ "$GIT_BRANCH" == "stage_dev" ]]; then
  IMAGE_NAME="sivakumar135/guvi_project_dev:latest"
  docker build -t react_app .
  docker tag react_app "$IMAGE_NAME"
  echo "Image tagged as $IMAGE_NAME"
fi
