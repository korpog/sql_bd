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
(5, "You may think I've gone insane", "... but I promise. I will kill again."),
(5, "I was just a boy. I saw him in my dreams.", "When he was inside, I didn’t know and when he was gone I couldn’t remember. He made me do things, terrible things. He said he wanted lives, he wanted others."),
(9, "Fellas, don't drink that coffee!", "You'd never guess. There was a fish in the percolator! Sorry."),
(8, "When we were growing up, Laura and I were so close.", "It was scary. I could feel her thoughts, like our brains were connected or something."),
(10, "I remember this one night when we first started seeing each other", "She was still doing drugs then. Well, we were in the woods when she started saying this scary poem, over and over, about fire.");


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
(9, 1, "She's dead. Wrapped in plastic."),
(1, 1, "I am dead. Yet I live."),
(8, 10, "You looked at me and you saw Laura."),
(10, 2, "You're not a turkey. A turkey is one of the dumbest birds on earth."),
(2, 3, "Diane, 11:30 a.m., February Twenty-fourth. Entering the town of Twin Peaks, five miles south of the Canadian border, twelve miles west of the state line."),
(2, 4, "You didn't love her anyway."),
(1, 2, "I feel like I know her... but sometimes my arms bend back.");


CREATE TABLE likes (
    user_id INT,
    post_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(user_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO likes(user_id, post_id)
VALUES (1,3), (1,2), (5,5), (5,1), (2,4), (4,2), (7,10), (7,1), (1,9), (4,10);

CREATE TABLE follows (
    following_user_id INT,
    followed_user_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (following_user_id) REFERENCES users(user_id),
    FOREIGN KEY (followed_user_id) REFERENCES users(user_id)
);

INSERT INTO follows(following_user_id, followed_user_id)
VALUES (3,1), (3,4), (2,1), (5,1), (10, 1), (8,1), (7,1), (5,8), (6,2), (10,8), (8,10);



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

SELECT * from users
NATURAL JOIN posts
NATURAL JOIN likes;

SELECT u.username, p.title, c.body from users u, posts p, comments c
WHERE p.user_id = u.user_id
AND c.post_id = p.post_id;

SELECT p.post_id, p.title, c.comment_id 
FROM posts p
LEFT JOIN comments c ON p.post_id = c.post_id
LEFT JOIN users u ON u.user_id = c.user_id;
WHERE c.comment_id IS NULL;

SELECT p.post_id, p.title, u.username
FROM posts p
RIGHT JOIN likes l ON p.post_id = l.post_id
RIGHT JOIN users u ON u.user_id = l.user_id;
ORDER BY created_at DESC;




