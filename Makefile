NAME = inception

# NGINX
build_nginx:
	docker build -t nginx ./srcs/requirements/nginx

run_nginx:
	docker run -d -p 443:443 nginx

build_mariadb:
	docker build -t nginx ./srcs/requirements/mariadb

run_mariadb:
	docker run -d mariadb

build_wordpress:
	docker build -t wordpress ./srcs/requirements/wordpress

run_wordpress:
	docker run -it wordpress


up:
	cd srcs && docker-compose up -d

down:
	cd srcs && docker-compose down -v

build:
	cd srcs && docker-compose build

start:
	cd srcs && docker-compose start

stop:
	cd srcs && docker-compose stop

restart:
	cd srcs && docker-compose restart

ps:
	cd srcs && docker-compose ps

logs:
	cd srcs && docker-compose logs

exec:
	cd srcs && docker-compose exec

pull:
	cd srcs && docker-compose pull

clean: down
	cd srcs \
	&& docker image prune \
	&& docker volume prune --all --force

fclean: down
	cd srcs
	docker system prune -a

.PHONY: build_nginx run_nginx clean fclean up down build start stop restart ps logs exec pull