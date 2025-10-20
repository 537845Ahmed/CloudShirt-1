# --- Configuratie ---
WEB_DOCKERFILE="src/Web/Dockerfile"
API_DOCKERFILE="src/PublicApi/Dockerfile"
WEB_IMAGE_NAME="web"
API_IMAGE_NAME="publicapi"
AWS_REGION="us-east-1"
AWS_ACCOUNT_ID="VUL IN"

aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

echo "Building Web image..."
sudo docker build -t "$WEB_IMAGE_NAME" -f "$WEB_DOCKERFILE" .
if [ $? -ne 0 ]; then
    echo "Web image build failed!"
    exit 1
fi
sudo docker tag $WEB_IMAGE_NAME $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$WEB_IMAGE_NAME:latest
sudo docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$WEB_IMAGE_NAME:latest
echo "Web image built successfully."

echo "Building Public API image..."
sudo docker build -t "$API_IMAGE_NAME" -f "$API_DOCKERFILE" .
if [ $? -ne 0 ]; then
    echo "API image build failed!"
    exit 1
fi
sudo docker tag $API_IMAGE_NAME $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$API_IMAGE_NAME:latest
sudo docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$API_IMAGE_NAME:latest
echo "API image built successfully."
