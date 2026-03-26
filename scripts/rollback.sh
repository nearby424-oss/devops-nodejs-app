#!/bin/bash

echo "Rolling back deployment..."
kubectl rollout undo deployment/devops-nodejs-app

echo "Rollback complete!"