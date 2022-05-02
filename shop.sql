DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Название раздела',
    UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
    (DEFAULT, 'Процессоры'),
    (DEFAULT, 'Мат.платы'),
    (DEFAULT, 'Видеокарты');

UPDATE
    catalogs
SET
    name = 'Процессоры (Intel)'
WHERE
    name = 'Процессоры';

SELECT id, name FROM catalogs;



DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Имя покупателя',
    birthday_at DATE comment 'Дата рождения',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

DROP TABLE IF EXISTS products;
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Название товара',
    description TEXT COMMENT 'Описание товара',
    price DECIMAL (11,2) COMMENT 'Цена',
    catalog_id INT UNSIGNED,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY index_of_catalog_id(catalog_id)
) COMMENT = 'Товарные позиции';

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT UNSIGNED,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY index_of_user_id(user_id)
) COMMENT = 'Заказы';

DROP TABLE IF EXISTS order_products;
CREATE TABLE order_products (
    id SERIAL PRIMARY KEY,
    product_id INT UNSIGNED,
    order_id INT UNSIGNED,
    total INT UNSIGNED DEFAULT 1 COMMENT 'Количество товарных позиций',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Состав заказа';

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
    id SERIAL PRIMARY KEY,
    product_id INT UNSIGNED,
    user_id INT UNSIGNED,
    discount FLOAT UNSIGNED COMMENT 'Величина скидки от 0.0 до 1.0',
    started_at DATETIME,
    finished_at DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY index_of_user_id(user_id),
    KEY index_of_product_id(product_id)
) COMMENT = 'Скидки';

DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Имя склада',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Склады';

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
    id SERIAL PRIMARY KEY,
    storehouse_id INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED,
    value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';
