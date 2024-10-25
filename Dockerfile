# Dockerfile
FROM ubuntu:22.04

# Argumentos para configuración del runner
ARG RUNNER_VERSION="2.311.0"
ARG DEBIAN_FRONTEND=noninteractive

# Variables de entorno que se pueden sobrescribir al ejecutar el contenedor
ENV RUNNER_NAME="docker-runner"
ENV RUNNER_WORK_DIRECTORY="_work"
ENV RUNNER_TOKEN=""
ENV REPO_URL=""

# Instalar dependencias
RUN apt-get update && apt-get install -y \
    curl \
    jq \
    wget \
    tar \
    unzip \
    git \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Crear usuario para el runner
RUN useradd -m -r -s /bin/bash runner

# Crear directorio para el runner
WORKDIR /home/runner
USER runner

# Descargar y configurar el runner
RUN curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L \
    https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && rm actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Instalar Elastic Synthetics globalmente
RUN npm install -g @elastic/synthetics

# Script de entrada
COPY --chown=runner:runner ./start.sh .
RUN chmod +x ./start.sh

ENTRYPOINT ["./start.sh"]

