#!/bin/bash

set -e

# Update package list
sudo apt update -y

# Install Docker
sudo apt install -y docker.io

# Add developer user to Docker group
sudo usermod -aG docker developer

# Install Java (required for Jenkins)
sudo apt install -y fontconfig openjdk-21-jre

# Create directory for Jenkins key
sudo mkdir -p /etc/apt/keyrings

# Download Jenkins GPG key
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

# Add Jenkins repository
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package list after adding Jenkins repo
sudo apt update -y

# Install Jenkins
sudo apt install -y jenkins

# Install Node.js 18
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Add Jenkins user to Docker group
sudo usermod -aG docker jenkins

# Restart services
sudo systemctl restart docker
sudo systemctl restart jenkins

# Show Jenkins initial admin password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
