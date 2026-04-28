FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# 1. Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# 2. Create a persistent virtual environment in a standard location
ENV VIRTUAL_ENV=/home/vscode/venv
RUN uv venv $VIRTUAL_ENV

# 3. Force this venv to be the primary path for EVERYTHING
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

USER vscode
