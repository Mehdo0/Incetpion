FROM debian:buster

RUN apt-get update && apt-get install -y nginx openssl

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

COPY ./conf/inception.crt /etc/nginx/ssl/inception.crt

COPY ./conf/inception.key /etc/nginx/ssl/inception.key

CMD ["nginx", "-g", "daemon off;"]