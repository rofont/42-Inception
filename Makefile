start: setup
	cd srcs \
	&& docker compose up --build -d


setup: ## Prepare folders needed
	mkdir -p /home/rofontai/data
	mkdir -p /home/rofontai/data/mariadb
	mkdir -p /home/rofontai/data/wordpress


up: ## Launch Inception in background
	cd srcs && docker compose up -d


down: ## Stop Inception
	cd srcs && docker-compose down -v


build: ## Build Inception (use make start after, to launch)
	cd srcs && docker compose build


status: ## Display Inception status
	docker ps && docker images && docker volume ls


reload: build up ## Restart Inception


logs: ## See Inception logs
	cd srcs && docker compose logs -f


prune: ## option exec (prune --all --force)
	docker system prune --all --force


clean: down ## Stop Inception & Clean inception docker (prune -f)
	cd srcs \
	&& docker image prune --force \
	&& docker volume prune --force


cleanvol: ## Remove persistant datas
	sudo rm -rf /home/rofontai/data


fclean: down clean prune cleanvol ## Remove all dockers on this system & Remove persistant datas

re: fclean start

help:
	@ awk 'BEGIN {FS = ":.*##";} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: start setup up down build status reload logs prune clean cleanvol fclean re help