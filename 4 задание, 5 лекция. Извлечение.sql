USE lesson5;

SELECT * FROM users;

SELECT name, DATE_FORMAT(birthday_at, '%M') FROM users;

SELECT name FROM users WHERE DATE_FORMAT(birthday_at, '%M') IN ('may', 'august');
