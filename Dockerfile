FROM nginx
MAINTAINER drunner

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y wget git \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir /swaggertmp \
 && cd /swaggertmp \
 && git clone https://github.com/swagger-api/swagger-ui.git \
 && cp -r swagger-ui/dist/* /usr/share/nginx/html/

RUN mv /usr/share/nginx/html/index.html /usr/share/nginx/html/swagger.html

COPY ["./swaggerfiles","/usr/share/nginx/html/"]

# add in the assets.
COPY ["./drunner","/drunner"]
RUN chmod a-w -R /drunner

# lock in druser.
USER swagger
