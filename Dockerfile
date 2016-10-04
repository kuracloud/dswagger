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

RUN groupadd -g 22021 drgroup
RUN adduser --disabled-password --gecos '' -u 22021 --gid 22021 druser

# create /drunner and allow druser write access.
RUN mkdir /drunner && chown druser:drgroup /drunner

# add in the assets.
USER druser
ADD ["./drunner","/drunner"]