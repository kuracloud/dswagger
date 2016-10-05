FROM nginx
MAINTAINER drunner

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y git sudo \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir /swaggertmp \
 && cd /swaggertmp \
 && git clone https://github.com/swagger-api/swagger-ui.git \
 && cp -r swagger-ui/dist/* /usr/share/nginx/html/

RUN mv /usr/share/nginx/html/index.html /usr/share/nginx/html/swagger.html

COPY ["./swaggerfiles","/usr/share/nginx/html/"]

RUN groupadd -g 22511 drgroup
RUN adduser --disabled-password --gecos '' -u 22511 --gid 22511 druser

# create /drunner and allow druser write access.
RUN mkdir /drunner && chown druser:drgroup /drunner

# allow sudo to use nginx.
RUN echo "druser ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/druser
RUN chmod 0440 /etc/sudoers.d/druser

# add in the assets.
USER druser
ADD ["./drunner","/drunner"]

CMD ["sudo", "nginx", "-g", "daemon off;"]