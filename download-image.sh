#!/bin/bash
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 730335381450.dkr.ecr.us-east-1.amazonaws.com
docker pull 730335381450.dkr.ecr.us-east-1.amazonaws.com/eshopwebmvc:latest
docker pull 730335381450.dkr.ecr.us-east-1.amazonaws.com/eshoppublicapi:latest
