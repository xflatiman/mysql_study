USE lesson5;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    created_at DATETIME,
    updated_at DATETIME,
    name VARCHAR(100)
);

INSERT INTO users(name) VALUES ('Vasya'),
                               ('Vasya'),
                               ('Vasya'),
                               ('Vasya'),
                               ('Vasya');

SELECT * FROM users;

UPDATE users SET created_at = CURRENT_TIMESTAMP;
UPDATE users SET updated_at = NOW();

SELECT * FROM users;
