# synthetics-monitor
# GitHub Actions Runner con Elastic Synthetics

Este proyecto implementa un runner de GitHub Actions containerizado específicamente configurado para ejecutar y desplegar monitores de Elastic Synthetics.

## Estructura del Proyecto

```
.
├── Dockerfile              # Configuración del contenedor del runner
├── README.md              # Este archivo
├── actions-runner-*.tar.gz # Binario del GitHub runner
├── docker-compose.yml     # Configuración de servicios Docker
├── setup-environment.sh   # Script de preparación del entorno
├── start.sh              # Script de inicio del runner
└── synthetics/           # Directorio de monitores Synthetics
    ├── journeys/        # Monitores individuales
    │   └── debug.test.js
    ├── package.json     # Dependencias de Node.js
    └── synthetic.config.js # Configuración de Synthetics
```

## Prerrequisitos

- Docker y Docker Compose
- Git
- Acceso a un repositorio GitHub
- Acceso a un cluster de Elasticsearch
- API Key de Elasticsearch con permisos necesarios

## Configuración Inicial

1. **Clonar el repositorio:**
```bash
git clone <url-del-repo>
cd <directorio-del-repo>
```

2. **Configurar variables de entorno:**
   - Crear archivo `.env` basado en `.env.example`:
```bash
cp .env.example .env
```
   - Editar `.env` con tus valores:
```env
RUNNER_TOKEN=<token-de-github>
REPO_URL=https://github.com/tu-org/tu-repo
ELASTICSEARCH_URL=https://tu-elasticsearch:9200
ELASTIC_API_KEY=tu-api-key
ELASTICSEARCH_SSL_VERIFY=false
```

3. **Preparar el entorno:**
```bash
chmod +x setup-environment.sh
./setup-environment.sh
```

## Instalación

1. **Construir y levantar el contenedor:**
```bash
docker compose build --no-cache
docker compose up -d
```

2. **Verificar el estado del runner:**
```bash
docker compose logs -f
```

## Configuración de Monitores

Los monitores se definen en el directorio `synthetics/journeys/`. Cada archivo `.js` en este directorio representa un monitor individual.

Ejemplo de monitor:
```javascript
// synthetics/journeys/ejemplo.journey.js
const { journey, step, expect } = require('@elastic/synthetics');

journey('Nombre del Monitor', async ({ page }) => {
  journey.options = {
    schedule: '*/5 * * * *'  // Ejecutar cada 5 minutos
  };

  await step('Paso de prueba', async () => {
    const response = await page.goto('https://elastic.co');
    expect(response.status()).toBe(200);
  });
});
```

## Despliegue de Monitores

Los monitores se despliegan automáticamente cuando:
1. Se hace push al repositorio
2. Se modifican archivos en el directorio `synthetics/`

También se pueden desplegar manualmente desde GitHub:
1. Ir a Actions en el repositorio
2. Seleccionar "Deploy Elastic Synthetics Monitors"
3. Click en "Run workflow"

## Mantenimiento

### Logs del Runner
```bash
docker compose logs -f
```

### Reiniciar el Runner
```bash
docker compose restart
```

### Actualizar el Runner
```bash
docker compose down
docker compose build --no-cache
docker compose up -d
```

### Limpiar y Reconstruir
```bash
docker compose down
./setup-environment.sh
docker compose up -d
```

## Troubleshooting

### El runner no se conecta
- Verificar el token de GitHub
- Revisar logs: `docker compose logs -f`
- Verificar conectividad a GitHub

### Fallos en el despliegue de monitores
- Verificar la API Key de Elasticsearch
- Comprobar la conectividad a Elasticsearch
- Revisar la sintaxis de los monitores

### Problemas de permisos
```bash
docker compose down
sudo chown -R 999:999 _work
docker compose up -d
```

## Referencias

- [Documentación de Elastic Synthetics]((https://www.elastic.co/guide/en/observability/current/synthetics-create-test.html))
- [GitHub Actions Self-hosted Runners](https://docs.github.com/en/actions/hosting-your-own-runners)
- [Docker Compose Documentation](https://docs.docker.com/compose/)

## Licencia

[Incluir información de licencia]
