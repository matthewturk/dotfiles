# Start with a clean Ubuntu base managed by MS for devcontainers
FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Avoid the debconf noise we saw earlier
ENV DEBIAN_FRONTEND=noninteractive

# Install only the "glue" system libraries
# build-essential is usually good to have for npm native modules
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libgl1-mesa-glx \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# The features in your json will handle uv, node, etc. after this builds.
USER vscode
