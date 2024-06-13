#!/bin/bash

# Variables
REPO_URL="https://github.com/Atanub707/wanderlust.git"
CLONE_DIR="/home/ubuntu/wanderlust"
BRANCH_NAME="dev"  # Replace with the name of the branch you want to switch to

# Clone the repository (replace with your actual repository URL)
if [ ! -d "$CLONE_DIR" ]; then
    echo "Cloning the repository..."
    git clone $REPO_URL $CLONE_DIR
else
    echo "Repository already exists. Pulling the latest code..."
    git -C $CLONE_DIR pull
fi

# Navigate to the directory containing the repository
cd $CLONE_DIR

# Checkout the specified branch
echo "Switching to branch $BRANCH_NAME..."
git checkout $BRANCH_NAME

# Pull the latest changes for the branch
echo "Pulling the latest changes for branch $BRANCH_NAME..."
git pull origin $BRANCH_NAME

# Prune Docker images and containers
echo "Pruning Docker system..."
docker system prune -af

# Add a delay to ensure Docker images and containers are properly deleted
echo "Waiting for Docker cleanup to complete..."
sleep 30

# Build and run Docker containers using Docker Compose
echo "Building and running Docker containers using Docker Compose..."
docker-compose up -d --build

# List all Docker images
echo "Listing all Docker images..."
docker images

# List all Docker containers (both running and stopped)
echo "Listing all Docker containers..."
docker ps -a

echo "Automation script completed. Please log out and log back in for the Docker group changes to take effect."
