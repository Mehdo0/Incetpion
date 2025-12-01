FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    php8.2-fpm \
    php8.2-mysql \
    curl


COPY ./tools/wp-setup.sh /wp-setup.sh
RUN chmod +x /wp-setup.sh

RUN sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/g' /etc/php/8.2/fpm/pool.d/www.conf

CMD ["sh", "/wp-setup.sh"]
