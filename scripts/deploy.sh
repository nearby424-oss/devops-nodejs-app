#!/bin/bash

echo "Deploying application..."
kubectl apply -f k8s/

kubectl rollout status deployment/devops-nodejs-app

echo "Deployment successful!"