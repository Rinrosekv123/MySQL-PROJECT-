-- Create the library database if it doesn't exist
CREATE DATABASE library;

-- Use the library database
USE library;

-- Create the Books table
CREATE TABLE Books (
    ISBN VARCHAR(20) PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(50),
    Rental_Price DECIMAL(10, 2),
    Status VARCHAR(3),
    Author VARCHAR(100),
    Publisher VARCHAR(100)
);

-- Create the Branch table
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);

-- Create the Employee table
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2)
);

-- Create the Customer table
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);

-- Create the IssueStatus table
CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(20),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);
-- Create the ReturnStatus table
CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(20),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);
-- Inserting Values to each Table
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES(101, 201, '123 Main St', '123-456-7890'),
      (102, 202, '456 Elm St', '987-654-3210'),
      (103, 203, '789 Oak St', '555-555-5555'),
      (104, 204, '567 Maple St', '777-888-9999'),
      (105, 205, '890 Pine St', '111-222-3333');
INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary)
VALUES(201, 'John Doe', 'Manager', 75000),
      (202, 'Jane Smith', 'Librarian', 60000),
      (203, 'Michael Johnson', 'Clerk', 45000),
      (204, 'Emily Brown', 'Clerk', 42000),
      (205, 'David Wilson', 'Security', 55000);
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES(301, 'Alice Williams', '123 Oak St', '2021-05-15'),
      (302, 'Bob Anderson', '456 Elm St', '2022-02-10'),
      (303, 'Carol Davis', '789 Maple St', '2020-11-20'),
      (304, 'Daniel Martin', '567 Pine St', '2022-04-05'),
      (305, 'Eve Thompson', '890 Birch St', '2021-09-30');
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES('978-1234567890', 'Introduction to Programming', 'Computer Science', 2.50, 'yes', 'John Smith', 'ABC Publications'),
      ('978-9876543210', 'The Great Gatsby', 'Fiction', 3.00, 'yes', 'F. Scott Fitzgerald', 'XYZ Books'),
	  ('978-5555555555', 'History of World War II', 'History', 2.75, 'no', 'David Johnson', 'History Press'),
      ('978-7778889999', 'Data Structures and Algorithms', 'Computer Science', 3.25, 'yes', 'Emily Davis', 'Tech Books'),
      ('978-1112223333', 'Learning French in 30 Days', 'Language', 2.00, 'yes', 'Sophie Martin', 'Language Academy');
INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES(401, 301, 'Introduction to Programming', '2023-06-10', '978-1234567890'),
      (402, 302, 'The Great Gatsby', '2023-07-05', '978-9876543210'),
      (403, 303, 'Data Structures and Algorithms', '2023-08-20', '978-7778889999'),
      (404, 304, 'Learning French in 30 Days', '2023-06-15', '978-1112223333'),
      (405, 305, 'Introduction to Programming', '2023-07-20', '978-1234567890');
INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES(501, 301, 'Introduction to Programming', '2023-07-05', '978-1234567890'),
      (502, 302, 'The Great Gatsby', '2023-08-10', '978-9876543210'),
      (503, 303, 'Data Structures and Algorithms', '2023-09-02', '978-7778889999'),
      (504, 304, 'Learning French in 30 Days', '2023-08-15', '978-1112223333'),
      (505, 305, 'Introduction to Programming', '2023-08-30', '978-1234567890');

SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';
     
SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;
      
SELECT B.Book_title, C.Customer_name
FROM IssueStatus AS I
JOIN Books AS B ON I.Isbn_book = B.ISBN
JOIN Customer AS C ON I.Issued_cust = C.Customer_Id;

SELECT Category, COUNT(*) AS Total_Count
FROM Books
GROUP BY Category;

SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;


SELECT C.Customer_name
FROM Customer AS C
LEFT JOIN IssueStatus AS I ON C.Customer_Id = I.Issued_cust
WHERE C.Reg_date < '2022-01-01' AND I.Issue_Id IS NULL;

SELECT B.Branch_no, COUNT(*) AS Total_Employees
FROM Branch AS B
JOIN Employee AS E ON B.Manager_Id = E.Emp_Id
GROUP BY B.Branch_no;


SELECT C.Customer_name
FROM Customer AS C
JOIN IssueStatus AS I ON C.Customer_Id = I.Issued_cust
WHERE I.Issue_date >= '2023-06-01' AND I.Issue_date < '2023-07-01';

SELECT Book_title
FROM Books
WHERE Category LIKE '%history%';

SELECT B.Branch_no, COUNT(*) AS Total_Employees
FROM Branch AS B
JOIN Employee AS E ON B.Manager_Id = E.Emp_Id
GROUP BY B.Branch_no
HAVING Total_Employees > 5;

