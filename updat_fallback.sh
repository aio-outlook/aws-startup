#!/bin/bash

set -e

COMPOSE_FILE="docker-compose.yml"

# Get running image URIs
CURRENT_DEV_IMAGE=$(docker inspect dev --format='{{.Config.Image}}' 2>/dev/null || echo "")
CURRENT_PROD_IMAGE=$(docker inspect prod1 --format='{{.Config.Image}}' 2>/dev/null || echo "")

if [[ -z "$CURRENT_DEV_IMAGE" || -z "$CURRENT_PROD_IMAGE" ]]; then
  echo "ERROR: Could not find running containers or their images."
  exit 1
fi

# Escape for sed
ESCAPED_DEV_IMAGE=$(printf '%s\n' "$CURRENT_DEV_IMAGE" | sed 's/[&/\]/\\&/g')
ESCAPED_PROD_IMAGE=$(printf '%s\n' "$CURRENT_PROD_IMAGE" | sed 's/[&/\]/\\&/g')

# Update fallback values in the compose file
sed -i "s#DEV_ECR_IMAGE:-.*}#DEV_ECR_IMAGE:-$ESCAPED_DEV_IMAGE}#g" "$COMPOSE_FILE"
sed -i "s#PROD_ECR_IMAGE:-.*}#PROD_ECR_IMAGE:-$ESCAPED_PROD_IMAGE}#g" "$COMPOSE_FILE"

echo "Updated docker-compose fallback images:"
echo "  DEV_ECR_IMAGE fallback: $CURRENT_DEV_IMAGE"
echo "  PROD_ECR_IMAGE fallback: $CURRENT_PROD_IMAGE"
