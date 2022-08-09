CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER 'ypetruzz'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'ypetruzz'@'%';
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'UwU42';
