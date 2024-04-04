FROM debian:buster

RUN apt update -y && apt-get install mariadb-server -y

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/

COPY ./tools/entry_point.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entry_point.sh

RUN mkdir /run/mysqld && chown -R mysql:mysql /run/mysqld

EXPOSE 3306

ENTRYPOINT ["./usr/local/bin/entry_point.sh"]