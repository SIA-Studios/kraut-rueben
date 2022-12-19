CREATE USER 'user'@'%' IDENTIFIED BY 'password';

GRANT SELECT ON krautundrueben.* TO 'user'@'%';
GRANT ALL PRIVILEGES ON krautundrueben.* TO 'user'@'%';