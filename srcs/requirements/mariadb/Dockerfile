FROM debian:buster

RUN apt-get update && apt-get install -y mariadb-server

EXPOSE 3306

COPY conf/mariadb_server.cnf /etc/mysql/mariadb_server.cnf

# Here we have to run script

COPY script/script_user.sh
RUN bash ./script_user.sh

CMD
