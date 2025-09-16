# Makefile for managing Docker Compose services


# Path to the docker-compose.yml file
COMPOSE_FILE = srcs/docker-compose.yml


# Paths to persistent data directories for MariaDB and WordPress
DATA_DIR_MARIADB = /home/souaammo/data/mariadb
DATA_DIR_WORDPRESS = /home/souaammo/data/wordpress


# <===( all )===>
# Default target: prepare directories, build images, and start services
all: prepare build up


# <===( prepare )===>
# Create directories for persisting MariaDB and WordPress data
# This ensures that Docker volumes can bind to these paths
prepare:
	@mkdir -p $(DATA_DIR_WORDPRESS)
	@mkdir -p $(DATA_DIR_MARIADB)


# <===( build )===>
# Build all Docker images defined in docker-compose.yml
build:
	@docker compose -f $(COMPOSE_FILE) build


# <===( up )===>
# Start all services in detached mode (-d) using Docker Compose
up:
	@docker compose -f $(COMPOSE_FILE) up -d


# <===( start )===>
# Start already created (but stopped) services
# Useful when containers exist but are stopped
start:
	@docker compose -f $(COMPOSE_FILE) start


# <===( stop )===>
# Stop running services without removing containers
stop:
	@docker compose -f $(COMPOSE_FILE) stop


# <===( down )===>
# Stop services and remove containers, networks, and default volumes
down:
	@docker compose -f $(COMPOSE_FILE) down


# <===( clean )===>
# Stop services and remove all unused Docker data including volumes
# Useful to free up disk space
clean: down
	@docker compose -f $(COMPOSE_FILE) down -v
	@docker system prune -af --volumes


# <===( fclean )===>
# Full clean: remove all containers, volumes, images, and orphaned resources
# Use with caution as this deletes everything related to the project
fclean:
	@docker compose -f $(COMPOSE_FILE) down -v --rmi all --volumes --remove-orphans
	@docker system prune -af --volumes


# <===( re )===>
# Restart services: stops and starts all services (rebuild not included)
re: down up


# <===( logs )===>
# Stream logs from all services
# Useful for debugging or monitoring containers
logs:
	@docker compose -f $(COMPOSE_FILE) logs -f


# <===( net )===>
# List all Docker networks on the system
# Useful to check if the 'inception' network exists
net:
	@docker network ls


# <===( volume )===>
# List all Docker volumes
# Useful to verify persistent storage for MariaDB and WordPress
volume:
	@docker volume ls


# <===( ps )===>
# Show status of all containers defined in docker-compose.yml
ps:
	@docker compose -f $(COMPOSE_FILE) ps


# <===( help )===>
# Display a list of available targets and what they do
help:
	@echo "Available targets:"
	@echo "  build    - Build the Docker images"
	@echo "  up       - Start the Docker Compose services"
	@echo "  start    - Start stopped Docker Compose services"
	@echo "  stop     - Stop the Docker Compose services"
	@echo "  down     - Stop and remove the Docker Compose services"
	@echo "  clean    - Remove unused Docker data"
	@echo "  fclean   - Remove all containers, volumes, networks, and images"
	@echo "  re       - Restart the Docker Compose services"
	@echo "  logs     - View logs from the Docker Compose services"
	@echo "  net      - List Docker networks"
	@echo "  volume   - List Docker volumes"
	@echo "  ps       - List running containers"


# <===( .PHONY )===>
# Declare phony targets to avoid conflicts with files of the same name
.PHONY: build up start stop down clean fclean re logs net volume ps



