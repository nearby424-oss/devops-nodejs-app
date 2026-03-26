#!/bin/bash

STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:30007/health)

if [ "$STATUS" == "200" ]; then
  echo "Application is healthy ✅"
else
  echo "Application is NOT healthy ❌"
  exit 1
fi