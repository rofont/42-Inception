#!bin/bash

sleep 30

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
	wp-cli.phar config create --allow-root \
		--dbname=$SQL_DATABASE \
		--dbuser=$SQL_USER \
		--dbpass=$SQL_PASS \
		--dbhost=mariadb:3306 \
		--path="/var/www/wordpress"

	wp-cli.phar core install --allow-root \
		--url='https://rofontai.42.fr' \
        --title="Inception" \
        --admin_user="$WP_ADMIN" \
        --admin_password="$WP_ADMIN_PASS" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --path="/var/www/wordpress"

	wp-cli.phar user create --allow-root\
    	"$WP_USER" \
        "$WP_USER_EMAIL" \
		--role=author \
        --user_pass="$WP_USER_PASS" \
        --path="/var/www/wordpress"

	echo "end config"

else
	echo "config exist"

fi

/usr/sbin/php-fpm7.3 -F