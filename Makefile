COMPOSE_FILE = ./srcs/docker-compose.yml

all: up

up:
	docker-compose -f $(COMPOSE_FILE) up -d --build

down:
	docker-compose -f $(COMPOSE_FILE) down

stop:
	docker-compose -f $(COMPOSE_FILE) stop

start:
	docker-compose -f $(COMPOSE_FILE) start

status:
	docker container ls

re: down up

.PHONY: all up down stop start status re
