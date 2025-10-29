FROM debian:buster

RUN apt-get update && apt-get install -y mariadb-server

COPY ./tools/setup_db.sh /setup_db.sh

RUN chmod +x /setup_db.sh

CMD ["sh", "/setup_db.sh"]