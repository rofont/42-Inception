FROM debian:buster

RUN apt update -y			\
	&& apt install nginx openssl -y

RUN apt install nano -y		\
	&& apt install curl -y

RUN mkdir -p /etc/nginx/ssl \
	&& openssl req -x509 -nodes \
	-out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=CA/ST=QC/L=Quebec/O=42/OU=42/CN=rofontai.42.fr/UID=rofontai"

COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]