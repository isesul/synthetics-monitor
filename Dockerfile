FROM ubuntu:22.04

# Argumentos de construcción
ARG RUNNER_VERSION="2.311.0"
ARG DEBIAN_FRONTEND=noninteractive

# Variables de entorno
ENV RUNNER_NAME="elastic-synthetics-runner"
ENV RUNNER_WORK_DIRECTORY="_work"
ENV RUNNER_TOKEN=""
ENV REPO_URL=""

# Instalar dependencias básicas y .NET Core
RUN apt-get update && apt-get install -y \
    curl \
    jq \
    wget \
    tar \
    unzip \
    git \
    sudo \
    libicu70 \
    liblttng-ust1 \
    libssl3 \
    && rm -rf /var/lib/apt/lists/*

# Instalar Node.js 18.x
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest

# Crear usuario para el runner y darle permisos sudo
RUN useradd -m -r -s /bin/bash runner && \
    usermod -aG sudo runner && \
    echo "runner ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Crear todos los directorios necesarios
RUN mkdir -p /home/runner/_work/_temp/_github_workflow \
    && mkdir -p /home/runner/_work/_tool \
    && mkdir -p /home/runner/_work/_actions \
    && mkdir -p /usr/lib/node_modules \
    && mkdir -p /usr/local/lib/node_modules \
    && mkdir -p /home/runner/.npm-global

# Configurar todos los permisos necesarios
RUN chown -R runner:runner /home/runner && \
    chown -R runner:runner /usr/lib/node_modules && \
    chown -R runner:runner /usr/local/lib/node_modules && \
    chown -R runner:runner /usr/local/bin && \
    chmod -R 777 /home/runner/_work

# Cambiar al usuario runner
USER runner

# Configurar npm para el usuario runner
RUN npm config set prefix '/home/runner/.npm-global'

# Agregar el path de npm global
ENV PATH=/home/runner/.npm-global/bin:$PATH

# Configurar directorio de trabajo
WORKDIR /home/runner

# Copiar y extraer el runner
COPY --chown=runner:runner actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz .
RUN tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && rm actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Ejecutar el script de dependencias del runner
RUN sudo ./bin/installdependencies.sh

# Instalar Elastic Synthetics
RUN npm install -g @elastic/synthetics

# Copiar script de inicio
COPY --chown=runner:runner ./start.sh .
RUN chmod +x ./start.sh

ENTRYPOINT ["./start.sh"]

