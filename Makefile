NAME = inception

# DOCKER
build_nginx:
	docker build -t nginx ./srcs/requirements/nginx

run_nginx:
	docker run -d -p 443:443 nginx

build_mariadb:
	docker build -t mariadb ./srcs/requirements/mariadb

run_mariadb:
	docker run -it -d mariadb

logs_mariadb:
	docker logs -f mariadb

build_wordpress:
	docker build -t wordpress ./srcs/requirements/wordpress

run_wordpress:
	docker run -it wordpress

setup: ## Prepare folders needed
	mkdir -p /home/rofontai/data
	mkdir -p /home/rofontai/data/mariadb
	mkdir -p /home/rofontai/data/wordpress

up: setup ## Launch Inception in background
	cd srcs && docker-compose up -d

down: ## Stop Inception
	cd srcs && docker-compose down -v

build: ## Build Inception (use make start after, to launch)
	cd srcs && docker-compose build

start: build ## Begin Inception
	cd srcs && docker-compose up -d

status: ## Display Inception status
	docker ps && docker images && docker volume ls

reload: build up ## Restart Inception

logs: ## See Inception logs
	cd srcs && docker-compose logs

exec: ## option exec
	cd srcs && docker-compose exec

pull: ## option exec
	cd srcs && docker-compose pull

prune: ## option exec (prune --all --force)
	docker system prune --all --force

clean: down ## Stop Inception & Clean inception docker (prune -f)
	cd srcs \
	&& docker system prune --volume --force
	&& docker volume prune --force

cleanvol: ## Remove persistant datas
	sudo rm -rf /home/rofontai/data

fclean: down prune cleanvol ## Remove all dockers on this system & Remove persistant datas

help:
	@ awk 'BEGIN {FS = ":.*##";} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: build_nginx run_nginx build_mariadb run_mariadb build_wordpress build_wordpress run_wordpress up down build start status reload logs exec pull prune clean fclean cleanvol logs_mariadb