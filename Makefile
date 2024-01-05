all: build up

up: 
	docker-compose -f srcs/docker-compose.yml up -d

build:
	docker-compose -f srcs/docker-compose.yml build

prune:
	docker system prune

clean:
	docker-compose -f srcs/docker-compose.yml down --rmi all -v

re: clean prune all

.PHONY: all up build prune clean re