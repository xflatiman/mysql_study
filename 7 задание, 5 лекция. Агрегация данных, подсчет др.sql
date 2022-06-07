USE lesson5;

SELECT name, birthday_at FROM users;

SELECT MONTH(birthday_at), DAY(birthday_at) FROM users;

SELECT YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at) FROM users;

SELECT DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))) AS day FROM users;

SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day FROM users;

SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day FROM users GROUP BY day;

SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))),'%W') AS day, COUNT(*) AS total FROM users GROUP BY day;