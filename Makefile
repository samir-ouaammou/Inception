COMPOSE_FILE = srcs/docker-compose.yml
DATA_DIR_WORDPRESS = /home/souaammo/data/wordpress
DATA_DIR_MARIADB = /home/souaammo/data/mariadb

all: prepare build up

prepare:
	@mkdir -p $(DATA_DIR_WORDPRESS)
	@mkdir -p $(DATA_DIR_MARIADB)

build:
	@docker compose -f $(COMPOSE_FILE) build

up:
	@docker compose -f $(COMPOSE_FILE) up -d

start:
	@docker compose -f $(COMPOSE_FILE) start

stop:
	@docker compose -f $(COMPOSE_FILE) stop

down:
	@docker compose -f $(COMPOSE_FILE) down

clean: down
	@docker system prune -af --volumes

fclean:
	@docker compose -f $(COMPOSE_FILE) down --rmi all --volumes --remove-orphans
	@docker system prune -af --volumes

re: down up

logs:
	@docker compose -f $(COMPOSE_FILE) logs -f

net:
	@docker network ls

volume:
	@docker volume ls

ps:
	@docker compose -f $(COMPOSE_FILE) ps

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

.PHONY: build up start stop down clean fclean re logs net volume ps
