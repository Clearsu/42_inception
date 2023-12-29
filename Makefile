all: clean re

stop:
	docker-compose -f srcs/docker-compose.yml down

clean:
	docker system prune -f

re:
	docker-compose -f srcs/docker-compose.yml up --build