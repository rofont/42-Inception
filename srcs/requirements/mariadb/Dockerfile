FROM debian:buster

RUN apt update -y			\
	&& apt-get install mariadb-server -y

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/entry_point.sh .

EXPOSE 3306

ENTRYPOINT ["bash", "entry_point.sh"]