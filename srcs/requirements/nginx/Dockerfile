FROM debian:buster

RUN apt update -y && apt install -y nginx openssl nano curl

RUN mkdir -p /etc/nginx/ssl && mkdir -p /run/nginx

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
	-out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=CA/ST=QC/L=Quebec/O=42/OU=42/CN=rofontai.42.fr/UID=rofontai"

COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]