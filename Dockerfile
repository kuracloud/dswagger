FROM nginx

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y wget git \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir /swaggertmp \
 && cd /swaggertmp \
 && git clone https://github.com/swagger-api/swagger-ui.git \
 && cp -r swagger-ui/dist/* /usr/share/nginx/

RUN mv /usr/share/nginx/index.html /usr/share/nginx/swagger.html

COPY ["./html","/usr/share/nginx"]

