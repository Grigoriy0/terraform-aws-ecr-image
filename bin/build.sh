#!/bin/bash

# Inspiration from https://github.com/onnimonni/terraform-ecr-docker-build-module

# Fail fast
set -e

# This is the order of arguments
REGISTRY_URL=$1
IMAGE_WITH_TAG=$2
DOCKERFILE=$3
CONTEXT=$4
FULL_IMAGE="${REGISTRY_URL}/${IMAGE_WITH_TAG}"

# Check that aws is installed
which aws > /dev/null || { echo 'Error: aws-cli is not installed' ; exit 1; }

# Check that docker is installed and running
which docker > /dev/null && docker ps > /dev/null || { echo 'Error: docker is not running' ; exit 1; }

echo "Building $FULL_IMAGE from $DOCKERFILE"
docker build -t $FULL_IMAGE -f $DOCKERFILE $CONTEXT

echo "Connect into aws"
aws ecr get-login-password | docker login --username AWS --password-stdin $REGISTRY_URL

if [[ "$?" != "0" ]]; then
  echo "Error: aws ecr docker login failed"
  exit 1
fi

echo "Push image $FULL_IMAGE"
docker push $FULL_IMAGE
