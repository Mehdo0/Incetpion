#!/bin/sh

sleep 10

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

mkdir -p /var/www/html/wordpress
cd /var/www/html/wordpress

wp core download --allow-root

wp config create --allow-root \
                 --dbname=$MYSQL_DATABASE \
                 --dbuser=$MYSQL_USER \
                 --dbpass=$MYSQL_PASSWORD \
                 --dbhost=mariadb

wp core install --allow-root \
                --url=$DOMAIN_NAME \
                --title="42 Inception" \
                --admin_user=$WP_ADMIN_USER \
                --admin_password=$WP_ADMIN_PASS \
                --admin_email=$WP_ADMIN_EMAIL

exec php-fpm7.3 -F