FROM debian:buster

RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    curl \
    php7.3-fpm \
    php7.3-mysql

COPY ./tools/wp-setup.sh /wp-setup.sh

RUN chmod +x /wp-setup.sh

CMD ["sh", "/wp-setup.sh"]