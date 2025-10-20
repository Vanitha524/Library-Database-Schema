CREATE DATABASE LibraryDB1;
USE LibraryDB1;

CREATE TABLE Category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL
);

CREATE TABLE Book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    publication_year YEAR,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Book_Author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (author_id) REFERENCES Author(author_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Member (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    membership_date DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE Loan (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    loan_date DATE DEFAULT (CURRENT_DATE),
    due_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Book(book_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (member_id) REFERENCES Member(member_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Category (category_name) VALUES ('Fiction'), ('Science'), ('History');

INSERT INTO Author (first_name, last_name)
VALUES ('George', 'Orwell'), ('Isaac', 'Newton'), ('William', 'Shakespeare');

ALTER TABLE Book MODIFY publication_year INT;

INSERT INTO Book (title, isbn, publication_year, category_id)
VALUES 
('1984', 'ISBN001', 1949, 1),
('Principia Mathematica', 'ISBN002', 1687, 2),
('Hamlet', 'ISBN003', 1603, 1);

SELECT * FROM Book;

INSERT INTO Book_Author VALUES (4, 1), (5, 2), (6, 3);

SELECT * FROM Author;

INSERT INTO Book_Author (book_id, author_id)
SELECT b.book_id, a.author_id
FROM Book b
JOIN Author a ON 
  (b.title='1984' AND a.first_name='George Orwell')
  OR (b.title='Principia Mathematica' AND a.first_name='Isaac Newton')
  OR (b.title='Hamlet' AND a.first_name='William Shakespeare');

select * from Book_Author;

INSERT INTO Member (full_name, email, phone)
VALUES ('Alice Johnson', 'alice@example.com', '9876543210'),
       ('Bob Smith', 'bob@example.com', '9123456789');

SELECT book_id, title FROM Book;

SELECT member_id, full_name FROM Member;

select * from Member;

INSERT INTO Loan (book_id, member_id, due_date)
VALUES 
(4, 1, '2025-10-30'),
(5, 2, '2025-10-28');

SHOW CREATE TABLE Loan;

SELECT * FROM Book;
SELECT * FROM Member;

