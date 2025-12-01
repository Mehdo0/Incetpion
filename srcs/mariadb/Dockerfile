FROM debian:bookworm  

RUN apt-get update && apt-get install -y mariadb-server

COPY ../tools/setup_db.sh /setup_db.sh
RUN chmod +x /setup_db.sh
RUN sed -i "s|bind-address            = 127.0.0.1|bind-address            = 0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf
CMD ["sh", "/setup_db.sh"]
