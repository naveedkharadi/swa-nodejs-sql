-- Create the database
CREATE DATABASE CompanyDB;
GO

-- Use the database
USE CompanyDB;
GO

-- Create the Employees table
CREATE TABLE Employees (
    Id INT PRIMARY KEY IDENTITY(1,1),
    EmployeeId NVARCHAR(50) NOT NULL,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    DateOfBirth DATE NOT NULL,
    DateOfJoining DATE NOT NULL,
    DepartmentName NVARCHAR(100) NOT NULL
);
GO

-- Insert 50 records into the Employees table
INSERT INTO Employees (EmployeeId, FirstName, LastName, DateOfBirth, DateOfJoining, DepartmentName)
VALUES 
('E001', 'John', 'Doe', '1980-01-01', '2010-06-15', 'HR'),
('E002', 'Jane', 'Smith', '1985-02-02', '2011-07-20', 'Finance'),
('E003', 'Michael', 'Johnson', '1990-03-03', '2012-08-25', 'IT'),
('E004', 'Emily', 'Davis', '1992-04-04', '2013-09-30', 'Marketing'),
('E005', 'Daniel', 'Brown', '1988-05-05', '2014-10-05', 'Sales'),
('E006', 'Jessica', 'Wilson', '1991-06-06', '2015-11-10', 'HR'),
('E007', 'David', 'Moore', '1983-07-07', '2016-12-15', 'Finance'),
('E008', 'Sarah', 'Taylor', '1987-08-08', '2017-01-20', 'IT'),
('E009', 'James', 'Anderson', '1989-09-09', '2018-02-25', 'Marketing'),
('E010', 'Laura', 'Thomas', '1993-10-10', '2019-03-30', 'Sales'),
('E011', 'Robert', 'Jackson', '1984-11-11', '2020-04-05', 'HR'),
('E012', 'Linda', 'White', '1986-12-12', '2021-05-10', 'Finance'),
('E013', 'William', 'Harris', '1991-01-13', '2022-06-15', 'IT'),
('E014', 'Barbara', 'Martin', '1992-02-14', '2023-07-20', 'Marketing'),
('E015', 'Richard', 'Thompson', '1985-03-15', '2010-08-25', 'Sales'),
('E016', 'Susan', 'Garcia', '1987-04-16', '2011-09-30', 'HR'),
('E017', 'Joseph', 'Martinez', '1990-05-17', '2012-10-05', 'Finance'),
('E018', 'Karen', 'Robinson', '1992-06-18', '2013-11-10', 'IT'),
('E019', 'Charles', 'Clark', '1988-07-19', '2014-12-15', 'Marketing'),
('E020', 'Nancy', 'Rodriguez', '1991-08-20', '2015-01-20', 'Sales'),
('E021', 'Thomas', 'Lewis', '1983-09-21', '2016-02-25', 'HR'),
('E022', 'Betty', 'Lee', '1985-10-22', '2017-03-30', 'Finance'),
('E023', 'Christopher', 'Walker', '1990-11-23', '2018-04-05', 'IT'),
('E024', 'Sandra', 'Hall', '1992-12-24', '2019-05-10', 'Marketing'),
('E025', 'Matthew', 'Allen', '1988-01-25', '2020-06-15', 'Sales'),
('E026', 'Ashley', 'Young', '1991-02-26', '2021-07-20', 'HR'),
('E027', 'Joshua', 'Hernandez', '1984-03-27', '2022-08-25', 'Finance'),
('E028', 'Donna', 'King', '1986-04-28', '2023-09-30', 'IT'),
('E029', 'Andrew', 'Wright', '1990-05-29', '2010-10-05', 'Marketing'),
('E030', 'Patricia', 'Lopez', '1992-06-30', '2011-11-10', 'Sales'),
('E031', 'Steven', 'Hill', '1988-07-31', '2012-12-15', 'HR'),
('E032', 'Kimberly', 'Scott', '1991-08-01', '2013-01-20', 'Finance'),
('E033', 'Brian', 'Green', '1983-09-02', '2014-02-25', 'IT'),
('E034', 'Deborah', 'Adams', '1985-10-03', '2015-03-30', 'Marketing'),
('E035', 'Kevin', 'Baker', '1990-11-04', '2016-04-05', 'Sales'),
('E036', 'Sharon', 'Gonzalez', '1992-12-05', '2017-05-10', 'HR'),
('E037', 'Edward', 'Nelson', '1988-01-06', '2018-06-15', 'Finance'),
('E038', 'Michelle', 'Carter', '1991-02-07', '2019-07-20', 'IT'),
('E039', 'George', 'Mitchell', '1984-03-08', '2020-08-25', 'Marketing'),
('E040', 'Laura', 'Perez', '1986-04-09', '2021-09-30', 'Sales'),
('E041', 'Kenneth', 'Roberts', '1990-05-10', '2022-10-05', 'HR'),
('E042', 'Amy', 'Turner', '1992-06-11', '2023-11-10', 'Finance'),
('E043', 'Ronald', 'Phillips', '1988-07-12', '2010-12-15', 'IT'),
('E044', 'Angela', 'Campbell', '1991-08-13', '2011-01-20', 'Marketing'),
('E045', 'Jason', 'Parker', '1983-09-14', '2012-02-25', 'Sales'),
('E046', 'Melissa', 'Evans', '1985-10-15', '2013-03-30', 'HR'),
('E047', 'Jeffrey', 'Edwards', '1990-11-16', '2014-04-05', 'Finance'),
('E048', 'Rebecca', 'Collins', '1992-12-17', '2015-05-10', 'IT'),
('E049', 'Gary', 'Stewart', '1988-01-18', '2016-06-15', 'Marketing'),
('E050', 'Stephanie', 'Sanchez', '1991-02-19', '2017-07-20', 'Sales');
GO