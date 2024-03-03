CREATE DATABASE social;

USE social;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    username VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users(name, surname, username, age, email)
VALUES 
('Laura', 'Palmer', 'muffin', 17, 'lp@tp.net'),
('Dale', 'Cooper', 'coop', 35, 'dc@tp.net'),
('Bobby', 'Briggs', 'bobby', 19, 'bb@tp.net'),
('Shelly', 'Johnson', 'cherrypie', 19, 'sj@tp.net'),
('Leland', 'Palmer', 'bob', 45, 'bob@tp.net'),
('Audrey', 'Horne', 'audrey', 18, 'audrey@tp.net'),
('Donna', 'Hayward', 'donna', 17, 'donna@tp.net'),
('Madeleine', 'Ferguson', 'maddie', 20, 'maddie@tp.net'),
('Pete', 'Martell', 'pete', 52, 'pete@tp.net'),
('James', 'Hurley', 'james', 18, 'james@tp.net');

CREATE INDEX idx_name_surname
ON users (name, surname);

CREATE TABLE posts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    title VARCHAR(100) NOT NULL,
    body TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO posts(user_id, title, body)
VALUES
(1, 'Dear Diary', 'Tonight is the night that I die'),
(1, 'Faster and faster', "And for a long time you wouldn't feel anything. And then you'd burst into fire.
 Forever... And the angels wouldn't help you. Because they've all gone away."),
(2, 'Damn fine coffee', 'You know, this is - excuse me - a damn fine cup of coffee.'),
(3, 'You want to know who killed Laura? You did! We all did.', "She said people try to be good but they're really sick and rotten, her most of all"),
(4, 'Leo doesn’t talk, he hits', 'He was so great at first, you know. This flashy guy in his hot car.'),
(5, "You may think I've gone insane", "... but I promise. I will kill again.");

CREATE INDEX idx_title
ON posts (title);

CREATE TABLE comments (
    comment_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    post_id INT,
    body TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(user_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO comments(user_id, post_id, body)
VALUES
(1, 3, "I was standing right behind you, but you're too dumb to turn around."),
(2, 5, "The time has come for you to seek the Path."),
(7, 1, "As much as I love you, Laura, most of the time we were trying to solve your problems."),
(9, 1, "She's dead. Wrapped in plastic.");

CREATE TABLE likes (
    like_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    post_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(user_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO likes(user_id, post_id)
VALUES (1, 3), (1,2), (5,5), (5,1), (2,4), (4,2);

CREATE TABLE follows (
    following_user_id INT,
    followed_user_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (following_user_id) REFERENCES users(user_id),
    FOREIGN KEY (followed_user_id) REFERENCES users(user_id)
);

INSERT INTO follows(following_user_id, followed_user_id)
VALUES (3,1), (3,4), (2,1), (5,1);



SELECT surname, COUNT(1) as count FROM users
GROUP BY surname
HAVING count > 1
ORDER BY count DESC;

SELECT name FROM users
WHERE LENGTH(name) BETWEEN 4 AND 5
ORDER BY LENGTH(name) DESC;

SELECT title from posts
WHERE title LIKE 'D%';

SELECT SUM(age) from users;

SELECT name, surname FROM users
WHERE age BETWEEN 20 AND 40
ORDER BY NAME;



SELECT p.post_id, p.title, u.username, COUNT(*) AS num_of_likes 
FROM posts AS p
INNER JOIN likes AS l ON p.post_id = l.post_id
INNER JOIN users AS u ON u.user_id = p.user_id
GROUP BY l.post_id
ORDER BY num_of_likes DESC;






