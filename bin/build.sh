#!/bin/bash

# Fail fast
set -e

# This is the order of arguments
NAME=$1
TAG=$2
DOCKERFILE=$3
CONTEXT=$4
AWS_REGION=$5
AWS_ACCOUNT_ID=$6
BUILD_ARG=$7
FULL_IMAGE="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/${NAME}:${TAG}"

# Check that aws is installed
which aws > /dev/null || { echo 'Error: aws-cli is not installed' ; exit 1; }

# Check that docker is installed and running
which docker > /dev/null && docker ps > /dev/null || { echo 'Error: docker is not running' ; exit 1; }

echo "Building $FULL_IMAGE from $DOCKERFILE"
echo "Comamnd will be docker build $BUILD_ARG -t $FULL_IMAGE -f $DOCKERFILE $CONTEXT"
docker build $BUILD_ARG -t $FULL_IMAGE -f $DOCKERFILE $CONTEXT

echo "Connect into aws"
token=$(aws ecr get-login-password --region "$AWS_REGION")
if [[ "$?" != "0" ]]; then
  echo "Wrong region or credentials not provided"
  exit 1
fi
docker login -u AWS -p "$token" "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"

if [[ "$?" != "0" ]]; then
  echo "Error: docker login failed"
  exit 1
fi

echo "Push image $FULL_IMAGE"
docker push $FULL_IMAGE
