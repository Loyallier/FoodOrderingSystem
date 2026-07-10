CREATE DATABASE IF NOT EXISTS food_ordering_system
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'foodapp'@'localhost'
IDENTIFIED BY 'foodapp123';

GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, INDEX, REFERENCES
ON food_ordering_system.*
TO 'foodapp'@'localhost';

FLUSH PRIVILEGES;