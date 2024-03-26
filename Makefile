NAME = inception

build_nginx:
	docker build -t nginx ./srcs/requirements/nginx

run_nginx:
	docker run -d -p 443:443 nginx

clean:
	cd srcs && docker-compose down
fclean:

.PHONY: build_nginx run_nginx clean fclean