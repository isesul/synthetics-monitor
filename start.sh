RUNNER_ALLOW_RUNASROOT=1

if [ -z "${RUNNER_TOKEN}" ]; then
    echo "Error: RUNNER_TOKEN no está configurado"
    exit 1
fi

if [ -z "${REPO_URL}" ]; then
    echo "Error: REPO_URL no está configurado"
    exit 1
fi

cd /home/runner

./config.sh \
    --url "${REPO_URL}" \
    --token "${RUNNER_TOKEN}" \
    --name "${RUNNER_NAME}" \
    --work "${RUNNER_WORK_DIRECTORY}" \
    --unattended \
    --replace

./run.sh

