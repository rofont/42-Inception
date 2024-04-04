FROM debian:buster

RUN apt update -y && apt-get -y install wget \
	&& apt-get install -y php7.3 php-fpm php-mysql	mariadb-client

RUN wget https://fr.wordpress.org/wordpress-6.4.3-fr_FR.tar.gz -P /var/www \
	&& cd /var/www && tar -xzf wordpress-6.4.3-fr_FR.tar.gz && rm wordpress-6.4.3-fr_FR.tar.gz

RUN chown -R root:root /var/www/wordpress

COPY conf/www.conf /etc/php/7.3/fpm/pool.d

RUN wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&&  mv wp-cli.phar /usr/local/bin/

COPY tools/auto_config.sh /usr/local/bin/auto_config.sh

RUN chmod +x /usr/local/bin/auto_config.sh

RUN mkdir -p /run/php

EXPOSE 9000

ENTRYPOINT ["bash", "./usr/local/bin/auto_config.sh"]