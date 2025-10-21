#!/bin/bash

ECR_URL="${AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com"
IMAGES=("eshopwebmvc:latest" "eshoppublicapi:latest")
REGION="us-east-1"

aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ECR_URL

for IMAGE in "${IMAGES[@]}"; do
  SUCCESS=0
  while [ $SUCCESS -eq 0 ]; do
    echo "Pulling $IMAGE..."
    docker pull "$ECR_URL/$IMAGE"
    if docker images | grep -q "${IMAGE%:*}"; then
      echo "$IMAGE gepulled!"
      SUCCESS=1
    else
      echo "$IMAGE nog niet beschikbaar..."
      sleep 10
    fi
  done
done

echo "IMAGES SUCCESVOL GEPULLED YIPPIE"
