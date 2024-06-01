
# Задание 1

CREATE USER 'sys_temp'@'%' IDENTIFIED BY 'qazWSX12345678';
SELECT User FROM mysql.user ;
GRANT ALL PRIVILEGES ON sakila.* TO 'sys_temp'@'%' WITH GRANT OPTION;
SHOW GRANTS FOR 'sys_temp'@'%';
ALTER USER 'sys_temp'@'%' IDENTIFIED WITH mysql_native_password BY 'qazWSX12345678';
FLUSH PRIVILEGES;

SELECT USER();

SELECT User FROM mysql.user ;


# Задание 2

USE sakila;

SELECT TABLE_NAME, COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'sakila'
AND CONSTRAINT_NAME = 'PRIMARY';


# Задание 3

REVOKE INSERT, UPDATE, DELETE ON sakila.* FROM 'sys_temp'@'%';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'sys_temp'@'%';

