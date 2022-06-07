CREATE DATABASE IF NOT EXISTS lesson5;

USE lesson5;

DROP TABLE IF EXISTS storehouses_products;

CREATE TABLE storehouses_products (
    id SERIAL PRIMARY KEY,
    storehouse_id INT UNSIGNED,
    product_id INT UNSIGNED,
    value INT UNSIGNED COMMENT 'Запас товара на складе',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запас на складе';

INSERT INTO storehouses_products (storehouse_id, product_id, value) VALUES (1, 543, 0),
                                                                           (1, 432, 3200),
                                                                           (1, 891, 3),
                                                                           (1, 999, 0),
                                                                           (1, 765, 500);

SELECT * FROM storehouses_products ORDER BY value;

SELECT id, value, IF (value > 0, 0, 1) AS sort FROM storehouses_products ORDER BY value;

SELECT * FROM storehouses_products ORDER BY IF (value > 0, 0, 1), value;