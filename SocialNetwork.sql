DROP DATABASE IF EXISTS vk;

CREATE DATABASE IF NOT EXISTS vk;

USE vk;

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    phone CHAR(11) NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL,
    password_hash CHAR(65),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX(lastname),
    INDEX(phone)
);

INSERT INTO users
VALUES (1, 'Dmitry', 'Sorokin', '89999999999', 'mail@mail.ru', 'f43f43r43r34fred54343ferfeteretretretertretretreter', DEFAULT, DEFAULT);

INSERT INTO users (firstname, lastname, phone, email, password_hash)
VALUES ('Daria', 'Sergeeva', '88888888888', 'mail@gmail.com', '5h4382h54g32h57845h32785hg3824h5g8324hg5');

CREATE TABLE profiles (
    user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    gender ENUM('f', 'm', 'x') NOT NULL,
    birthday_at DATE NOT NULL,
    photo_id BIGINT UNSIGNED NOT NULL,
    country VARCHAR(50) NOT NULL,
    city VARCHAR(130) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id)
);

INSERT INTO profiles VALUES (1, 'm', '1997-12-01', 1, 'Russia', 'Moscow');

INSERT INTO profiles VALUES (2, 'f', '1995-05-05', 2, 'Russia', 'Moscow');

CREATE TABLE messages (
    id SERIAL PRIMARY KEY,
    from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    message TEXT,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    status_message BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (from_user_id) REFERENCES users (id),
    FOREIGN KEY (to_user_id) REFERENCES users (id)
);

INSERT INTO messages VALUES (1, 1, 2, 'Hello, how are you?', DEFAULT, DEFAULT, TRUE);
INSERT INTO messages(from_user_id, to_user_id, message) VALUES (2, 1, 'Hello! Iam fine! How are u?');

CREATE TABLE friend_requests (
    from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    status_friend_requests BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (from_user_id) REFERENCES users (id),
    FOREIGN KEY (to_user_id) REFERENCES users (id),
    PRIMARY KEY(from_user_id, to_user_id)
);

INSERT INTO friend_requests VALUES (1, 2, TRUE);

CREATE TABLE communities (
    id SERIAL,
    name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255),
    admin_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY(id),
    INDEX communities_name_index (name),
    CONSTRAINT fk_communities_admin_id FOREIGN KEY (admin_id) REFERENCES users (id)
);

INSERT INTO communities VALUES (1, 'Travels_photo', 'Group about travels', 1);
INSERT INTO communities(name, admin_id) VALUES ('TheMountains_photos', 2);

CREATE TABLE communities_users (
    community_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (community_id, user_id),
    FOREIGN KEY (community_id) REFERENCES communities (id),
    FOREIGN KEY (user_id) REFERENCES users (id)
);

INSERT INTO communities_users VALUES (1, 2);

CREATE TABLE media_types (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO media_types VALUES (DEFAULT, 'Аудио');
INSERT INTO media_types VALUES (DEFAULT, 'Изображение');
INSERT INTO media_types VALUES (DEFAULT, 'Документ');

CREATE TABLE media (
    id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    media_type_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (media_type_id) REFERENCES media_types(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    file_name VARCHAR(255),
    file_size BIGINT UNSIGNED,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO media VALUES (DEFAULT, 1, 2, 'travel_photo.jpg', 100, DEFAULT);
INSERT INTO media(user_id, media_type_id, file_name, file_size) VALUES (2, 1, 'linkin_park-numb.mp4', 37);

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    from_user_id BIGINT UNSIGNED NOT NULL,
    title_post VARCHAR(255),
    text_post TEXT,
    media_id BIGINT UNSIGNED,
    FOREIGN KEY (from_user_id) REFERENCES users(id)
);

INSERT INTO posts(from_user_id, text_post, media_id) VALUES (1, 'Недавно путшествовал и сделал красивое фото!', 1);
INSERT INTO posts VALUES (DEFAULT, 2, 'Площадка GB, интересная статья', 'Вчера узнала о образавательной площадке GB и мне скинули интересную статью, кому интересно - пишите в личку!', NULL);

CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED,
    to_post_id BIGINT UNSIGNED,
    to_communities_id BIGINT UNSIGNED,
    to_comments_id BIGINT UNSIGNED,
    text_comments TEXT,
    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_post_id) REFERENCES posts(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id),
    FOREIGN KEY (to_communities_id) REFERENCES communities(id),
    FOREIGN KEY (to_comments_id) REFERENCES comments(id)
);

INSERT INTO comments VALUES (DEFAULT, 2, 1, 1, NULL, NULL, 'Вау! Фото действительно крутое!');
INSERT INTO comments VALUES (DEFAULT, 1, 2, NULL, NULL, 1, 'Спасибо, я знал, что ты оценишь!');

CREATE TABLE likes (
    id SERIAL PRIMARY KEY,
    from_user_id BIGINT UNSIGNED NOT NULL,
    to_post_id BIGINT UNSIGNED,
    to_comments_id BIGINT UNSIGNED,
    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_post_id) REFERENCES posts(id),
    FOREIGN KEY (to_comments_id) REFERENCES comments(id)
);

INSERT INTO likes VALUES (DEFAULT, 2, 1, NULL);
INSERT INTO likes VALUES (DEFAULT, 1, NULL, 1);

ALTER TABLE users ADD COLUMN passport_number VARCHAR(10);

ALTER TABLE users MODIFY COLUMN passport_number VARCHAR(20);

ALTER TABLE users RENAME COLUMN passport_number TO passport;

ALTER TABLE users ADD INDEX passport_idx (passport);

ALTER TABLE users DROP INDEX passport_idx;

ALTER TABLE users DROP COLUMN passport;

ALTER TABLE friend_requests ADD CONSTRAINT CHECK (from_user_id != to_user_id);

ALTER TABLE users ADD CONSTRAINT CHECK (REGEXP_LIKE(phone, '^[0-9]{11}$'));

ALTER TABLE profiles ADD CONSTRAINT fk_profiles_media FOREIGN KEY (photo_id) REFERENCES media (id);

ALTER TABLE profiles MODIFY COLUMN photo_id BIGINT UNSIGNED DEFAULT NULL UNIQUE;

INSERT users (id, firstname, lastname, phone, email, password_hash, created_at, update_at)
VALUES (DEFAULT, 'Oleg', 'Rusin', '89054335344', 'oleg@yandex.ru', '543hihhg534h', DEFAULT, DEFAULT);

INSERT INTO users (firstname, lastname, phone, email, password_hash)
VALUES ('Vacheslav', 'Yandaev', '89990345786', 'yandaev@inbox.ru', '4g523j5hjg3k2');

INSERT users VALUES (DEFAULT, 'Daria', 'Bazurina', '89059871654', 'bazurina@gmail.com', 'g543hkg543', DEFAULT, DEFAULT);

INSERT INTO users (firstname, lastname, email, phone) SELECT name, surname, email, phone FROM test1.users;

INSERT INTO users (firstname, lastname, phone, email, password_hash) VALUES ('Denis', 'Osyanin', '89067895643', 'osyanin@yahoo.com', 'gjdklghui43t3nkjgne'),
                                                                            ('Orehova', 'Irina', '89538903212', 'orehova@rumbler.ru', 'grehnjk532kjgnerjk');

INSERT users SET
                 firstname = 'Evgeniy',
                 lastname = 'Medvedev',
                 phone = '89063478125',
                 email = 'medvedev@mail.ru';

SELECT lastname, firstname, phone FROM users;

SELECT firstname FROM users;

SELECT DISTINCT firstname FROM users;

SELECT * FROM users WHERE firstname = 'Аноним';

SELECT * FROM users WHERE id >= 85 AND id <=100 AND firstname = 'Елена';

SELECT * FROM users WHERE id BETWEEN 85 AND 100;

SELECT CONCAT(lastname, ' ', SUBSTR(firstname, 1, 1), '.') AS username, phone FROM users;

SELECT * FROM users LIMIT 4;

SELECT * FROM users LIMIT 5 OFFSET 10;

SELECT * FROM users LIMIT 10, 5;

SELECT * FROM users ORDER BY lastname ASC;

SELECT * FROM users ORDER BY lastname DESC;

INSERT INTO messages (from_user_id, to_user_id, message) VALUES (38, 72, 'Hi man');
INSERT INTO messages (from_user_id, to_user_id, message) VALUES (38, 72, 'Lets jump');

SELECT * FROM messages;

UPDATE messages SET message = 'Hug me' WHERE id = 4;

UPDATE messages SET status_message = TRUE;

DELETE FROM users WHERE lastname = 'Иванов' OR  lastname = 'Ivanov';

TRUNCATE TABLE communities_users;