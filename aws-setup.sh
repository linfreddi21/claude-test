#!/bin/bash

# AWS EKS Setup Script (Free Tier Compatible)
# This script sets up a minimal EKS cluster to minimize costs

echo "🚀 Setting up AWS EKS cluster..."

# Variables
CLUSTER_NAME="claude-test-cluster"
REGION="us-west-2"
NODE_GROUP_NAME="claude-test-nodes"

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI is not installed. Please install it first."
    echo "Run: brew install awscli"
    exit 1
fi

# Check if eksctl is installed
if ! command -v eksctl &> /dev/null; then
    echo "❌ eksctl is not installed. Please install it first."
    echo "Run: brew tap weaveworks/tap && brew install weaveworks/tap/eksctl"
    exit 1
fi

# Check AWS credentials
if ! aws sts get-caller-identity &> /dev/null; then
    echo "❌ AWS credentials not configured. Please run: aws configure"
    exit 1
fi

echo "✅ Prerequisites met. Creating EKS cluster..."

# Create EKS cluster with minimal configuration
eksctl create cluster \
  --name=$CLUSTER_NAME \
  --region=$REGION \
  --node-type=t3.micro \
  --nodes=1 \
  --nodes-min=1 \
  --nodes-max=2 \
  --managed \
  --version=1.28

echo "✅ EKS cluster created successfully!"

# Update kubeconfig
aws eks update-kubeconfig --region $REGION --name $CLUSTER_NAME

echo "🎉 Setup complete! Your cluster is ready."
echo "Next steps:"
echo "1. Build and push your Docker image to ECR"
echo "2. Update k8s/deployment.yaml with your image URI"
echo "3. Deploy: kubectl apply -f k8s/"