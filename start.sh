#!/bin/bash

# Función para logging
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S'): $1"
}

# Validar variables requeridas
if [ -z "${RUNNER_TOKEN}" ]; then
    log "Error: RUNNER_TOKEN no está configurado"
    exit 1
fi

if [ -z "${REPO_URL}" ]; then
    log "Error: REPO_URL no está configurado"
    exit 1
fi

cd /home/runner

# Remover cualquier configuración anterior
if [ -f ".runner" ]; then
    log "Limpiando configuración anterior..."
    rm -rf .runner
fi

log "Configurando el runner para: ${REPO_URL}"
log "Iniciando proceso de registro con GitHub..."

# Configurar el runner con labels
./config.sh \
    --url "${REPO_URL}" \
    --token "${RUNNER_TOKEN}" \
    --name "${RUNNER_NAME}" \
    --work "${RUNNER_WORK_DIRECTORY}" \
    --unattended \
    --replace \
    --labels "self-hosted,elastic-synthetics"

if [ $? -eq 0 ]; then
    log "Runner configurado exitosamente"
    log "Iniciando runner..."
    ./run.sh
else
    log "Error al configurar el runner"
    exit 1
fi

