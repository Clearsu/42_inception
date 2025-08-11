all: add-host build up

add-host:
	@if ! grep -q "$(USER).42.fr" /etc/hosts; then \
       		echo "Adding $(USER).42.fr to /etc/hosts"; \
        	echo "127.0.0.1 $(USER).42.fr" | sudo tee -a /etc/hosts; \
    	else \
        	echo "$(USER).42.fr already exists in /etc/hosts"; \
    	fi

remove-host:
	@if grep -q "127.0.0.1 $(USER).42.fr" /etc/hosts; then \
        	echo "Removing 127.0.0.1 $(USER).42.fr from /etc/hosts"; \
        	sudo sed -i '/127.0.0.1 $(USER).42.fr/d' /etc/hosts; \
    	else \
        	echo "Entry 127.0.0.1 $(USER).42.fr not found in /etc/hosts"; \
    	fi

up: 
	docker-compose -f srcs/docker-compose.yml up -d

build:
	mkdir -p ./src/data/database ./src/data/website
	docker-compose -f srcs/docker-compose.yml build

prune:
	docker system prune

clean:
	rm -rf ./src/data
	docker-compose -f srcs/docker-compose.yml down --rmi all -v

fclean: clean prune

re: fclean all

.PHONY: add-host remove-host all up build prune clean fclean re
