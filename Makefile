COMPOSE_FILE = ./srcs/docker-compose.yml

COMPOSE = docker compose

all: up

up:
	$(COMPOSE) -f $(COMPOSE_FILE) up -d --build

down:
	$(COMPOSE) -f $(COMPOSE_FILE) down

stop:
	$(COMPOSE) -f $(COMPOSE_FILE) stop

start:
	$(COMPOSE) -f $(COMPOSE_FILE) start

status:
	docker container ls

re: down up

.PHONY: all up down stop start status re
