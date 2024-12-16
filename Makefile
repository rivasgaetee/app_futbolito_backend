# Variables
DOCKER_COMPOSE=docker-compose
CONTAINER_NAME=app_futbolito_backend-web-1  # Nombre del contenedor (ajusta según tu docker-compose)
PYTHON=python
MANAGE=manage.py

# Levantar contenedores
.PHONY: up
up:
	@echo "Levantando los contenedores..."
	$(DOCKER_COMPOSE) up -d --build

# Detener contenedores
.PHONY: down
down:
	@echo "Deteniendo los contenedores..."
	$(DOCKER_COMPOSE) down

# Crear migraciones dentro del contenedor
.PHONY: makemigrations
makemigrations:
	@echo "Creando migraciones..."
	docker exec -it $(CONTAINER_NAME) $(PYTHON) $(MANAGE) makemigrations

# Aplicar migraciones dentro del contenedor
.PHONY: migrate
migrate:
	@echo "Aplicando migraciones..."
	docker exec -it $(CONTAINER_NAME) $(PYTHON) $(MANAGE) migrate

# Levantar el servidor de desarrollo dentro del contenedor
.PHONY: runserver
runserver:
	@echo "Levantando el servidor de desarrollo..."
	docker exec -it $(CONTAINER_NAME) $(PYTHON) $(MANAGE) runserver 0.0.0.0:8000

# Crear un superusuario dentro del contenedor
.PHONY: createsuperuser
createsuperuser:
	@echo "Creando un superusuario..."
	docker exec -it $(CONTAINER_NAME) $(PYTHON) $(MANAGE) createsuperuser

# Acceder al contenedor
.PHONY: shell
shell:
	@echo "Entrando al contenedor..."
	docker exec -it $(CONTAINER_NAME) bash

# Ver logs del contenedor
.PHONY: logs
logs:
	@echo "Mostrando logs del contenedor..."
	$(DOCKER_COMPOSE) logs -f

# Mostrar ayuda
.PHONY: help
help:
	@echo "Comandos disponibles:"
	@echo "  make up               - Levantar los contenedores"
	@echo "  make down             - Detener los contenedores"
	@echo "  make makemigrations   - Crear migraciones en Django"
	@echo "  make migrate          - Aplicar migraciones"
	@echo "  make runserver        - Levantar servidor de desarrollo"
	@echo "  make createsuperuser  - Crear superusuario"
	@echo "  make shell            - Acceder al contenedor"
	@echo "  make logs             - Ver logs de Docker"