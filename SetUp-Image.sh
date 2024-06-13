# Pull Docker image
echo "Pulling Docker image..."
docker pull <image_name>

# Prune Docker system
echo "Pruning Docker system..."
docker system prune -af

# Add a delay to ensure Docker images and containers are properly deleted
echo "Waiting for Docker cleanup to complete..."
sleep 30

# Run Docker container
echo "Running Docker container..."
docker run -d <image_name>

echo "Automation script completed."

