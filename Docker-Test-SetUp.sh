#!/bin/bash

# Update and upgrade system
echo "Updating and upgrading system..."
sudo apt-get update
sudo apt-get upgrade -y

# Install dependencies for Docker
echo "Installing dependencies..."
sudo apt-get install ca-certificates curl gnupg git -y

# Add Docker's official GPG key
echo "Adding Docker GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the Docker repository to Apt sources
echo "Adding Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index again after adding Docker repository
sudo apt-get update

# Install Docker
echo "Installing Docker..."
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Add current user to Docker group to run Docker without sudo
echo "Adding user to Docker group..."
sudo usermod -aG docker $USER

# Install Docker Compose (latest version)
echo "Installing Docker Compose..."
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
sudo curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Verify Docker and Docker Compose installation
echo "Docker and Docker Compose installation verification:"
docker --version
docker-compose --version

# Clone the repository (replace with your actual repository URL)
REPO_URL="https://github.com/Atanub707/Node-Hello-Dockerfile"
CLONE_DIR="/home/ubuntu/Node-Hello-Dockerfile"

if [ ! -d "$CLONE_DIR" ]; then
    echo "Cloning the repository..."
    git clone $REPO_URL $CLONE_DIR
else
    echo "Repository already exists. Pulling the latest code..."
    git -C $CLONE_DIR pull
fi

# Navigate to the directory containing the docker-compose.yml file
cd $CLONE_DIR

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
