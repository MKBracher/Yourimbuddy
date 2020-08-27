DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS question;

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    stdID CHAR(8) UNIQUE NOT NULL,
    firstName VARCHAR(50)  NOT NULL,
    lastName VARCHAR(25)  NOT NULL,
    password VARCHAR(20) NOT NULL,
    degree_id INTEGER NULL REFERENCES degree(id),
    course_id INTEGER NULL REFERENCES course(id),
    phNumber VARCHAR(20),
    email VARCHAR(200) UNIQUE NOT NULL,
    is_admin INT DEFAULT 0
);

CREATE TABLE degree (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    degreeName VARCHAR(100) UNIQUE
    
);

CREATE TABLE course (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    degree_id INTEGER NULL REFERENCES degree(id),
    courseName VARCHAR (100) UNIQUE
);


CREATE TABLE question(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    author_id INTEGER NOT NULL,
    created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES user(id)
);