FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx openssl

COPY nginx/conf/nginx.conf /etc/nginx/nginx.conf

COPY nginx/conf/inception.crt /etc/nginx/ssl/inception.crt

COPY nginx/conf/inception.key /etc/nginx/ssl/inception.key

CMD ["nginx", "-g", "daemon off;"]
