FROM ubuntu:22.04

# Argumentos de construcción
ARG RUNNER_VERSION="2.311.0"
ARG DEBIAN_FRONTEND=noninteractive

# Variables de entorno
ENV RUNNER_NAME="elastic-synthetics-runner"
ENV RUNNER_WORK_DIRECTORY="_work"
ENV RUNNER_TOKEN=""
ENV REPO_URL=""

# Instalar dependencias básicas
RUN apt-get update && apt-get install -y \
    curl \
    jq \
    wget \
    tar \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Instalar Node.js 18.x
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest

# Crear usuario para el runner
RUN useradd -m -r -s /bin/bash runner

# Crear directorios necesarios y configurar permisos
RUN mkdir -p /usr/lib/node_modules \
    && mkdir -p /usr/local/lib/node_modules \
    && mkdir -p /home/runner/.npm-global \
    && chown -R runner:runner /usr/lib/node_modules \
    && chown -R runner:runner /usr/local/lib/node_modules \
    && chown -R runner:runner /usr/local/bin \
    && chown -R runner:runner /home/runner/.npm-global

# Cambiar al usuario runner
USER runner

# Configurar npm para el usuario runner
RUN npm config set prefix '/home/runner/.npm-global'

# Agregar el path de npm global
ENV PATH=/home/runner/.npm-global/bin:$PATH

# Configurar directorio de trabajo
WORKDIR /home/runner

# Descargar y configurar el runner
RUN curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L \
    https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && rm actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Instalar Elastic Synthetics en el directorio del usuario
RUN npm install -g @elastic/synthetics

# Copiar script de inicio
COPY --chown=runner:runner ./start.sh .
RUN chmod +x ./start.sh

ENTRYPOINT ["./start.sh"]

