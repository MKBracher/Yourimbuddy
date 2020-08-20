DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS question;

CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    studentID CHAR(8) UNIQUE NOT NULL,
    firstName TEXT  NOT NULL,
    lastName TEXT  NOT NULL,
    password TEXT NOT NULL,
    degree TEXT,
    course TEXT,
    phNumber INT,
    email VARCHAR(200) UNIQUE NOT NULL,
    is_admin INT DEFAULT 0
);

CREATE TABLE question(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    author_id INTEGER NOT NULL,
    created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES user(id)
);