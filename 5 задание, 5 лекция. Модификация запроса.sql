USE shop;

SELECT * FROM catalogs WHERE id IN (1, 2);

SELECT FIELD(2, 1, 2);

SELECT * FROM catalogs WHERE id IN (1, 2) ORDER BY FIELD (id, 5, 1, 2);
