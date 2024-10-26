#!/bin/bash
# setup-environment.sh

# Colores para output
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}Preparando el entorno para GitHub Runner...${NC}"

# Crear directorio de trabajo
echo "Creando directorio de trabajo..."
mkdir -p _work
mkdir -p _work/_update
mkdir -p _work/_tool
mkdir -p _work/_temp

# Asignar permisos
echo "Configurando permisos..."
# Obtener el UID del usuario runner del contenedor
RUNNER_UID=$(docker run --rm -it $(docker compose config | grep "image:" | awk '{print $2}') id -u runner)
RUNNER_GID=$(docker run --rm -it $(docker compose config | grep "image:" | awk '{print $2}') id -g runner)

# Asignar permisos
sudo chown -R $RUNNER_UID:$RUNNER_GID _work

echo -e "${GREEN}Entorno preparado correctamente${NC}"
echo "Puedes ejecutar 'docker compose up -d' para iniciar el runner"

curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L \
    https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz
