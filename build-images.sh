# --- Configuratie ---
WEB_DOCKERFILE="src/Web/Dockerfile"
API_DOCKERFILE="src/PublicApi/Dockerfile"
WEB_IMAGE_NAME="web"
API_IMAGE_NAME="publicapi"

echo "Building Web image..."
sudo docker build -t "$WEB_IMAGE_NAME" -f "$WEB_DOCKERFILE" .
if [ $? -ne 0 ]; then
    echo "Web image build failed!"
    exit 1
fi
echo "Web image built successfully."

echo "Building Public API image..."
sudo docker build -t "$API_IMAGE_NAME" -f "$API_DOCKERFILE" .
if [ $? -ne 0 ]; then
    echo "API image build failed!"
    exit 1
fi

echo "API image built successfully."

echo "All Docker images built successfully!"
