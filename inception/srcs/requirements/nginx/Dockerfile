FROM debian:buster

RUN apt-get -y update && apt-get -y install \
	nginx \
	net-tools \
	openssl

COPY conf/nginx.conf /etc/nginx/sites-available/default
COPY conf/nginx.conf /etc/nginx/sites-enabled/defaultt

RUN openssl req -x509 -days 365\
	-newkey rsa:2048 -nodes \
	-keyout /etc/ssl/private/nginx.key \
	-out /etc/ssl/certs/nginx.crt \
	-sha256 -subj "/CN=ypetruzz.42.fr"

EXPOSE 443/tcp

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
