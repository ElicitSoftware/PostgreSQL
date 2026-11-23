#!/bin/bash

# Elicit database image - Docker Image Build Script
#
# Builds elicitsoftware/elicit_db:latest (PostgreSQL with the Elicit roles and schemas in
# init_scripts/) with Docker Buildx, for the platform of the machine it runs on, and loads it
# into the local Docker daemon. The multi-architecture release image (amd64, arm64) is built
# and pushed by the release workflow (.github/workflows/docker.yml), not here.
#
# Usage: ./buildDockerImage.sh
#
# Prerequisites:
# - Docker with Buildx support (Docker Desktop or Docker Engine 19.03+)

echo "build elicit_db"

# --no-cache: a fresh build, so a changed init script is never served from a cached layer.
# --load: loads the built image into the local Docker daemon (a single-platform build).
docker buildx build --no-cache -t elicitsoftware/elicit_db:latest --load . || exit $?
