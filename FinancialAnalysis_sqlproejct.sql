CREATE DATABASE Financial_analysis;

USE Financial_analysis;

CREATE TABLE Customers(
Customer_id INT PRIMARY KEY,
First_name VARCHAR(50) NOT NULL,
Last_name VARCHAR(50) NOT NULL,
City VARCHAR(50) NOT NULL,
State VARCHAR(2) NOT NULL
);

INSERT INTO Customers VALUES
(1,'John','Doe','New York','NY'),
(2,'Jane','Doe','New York','NY'),
(3,'Bob','Smith','San Francisco','CA'),
(4,'Alice','Jojnson','San Francisco','CA'),
(5,'Michael','Lee','Los Angeles','CA'),
(6,'Jennifer','Wang','Los Angeles','CA');


CREATE TABLE Branches(
Branch_ID INT PRIMARY KEY,
Branch_name VARCHAR(50) NOT NULL,
City VARCHAR(50) NOT NULL,
State VARCHAR (2) NOT NULL
);

INSERT INTO Branches VALUES
(1,'Main','New York','NY'),
(2,'Downtown','San Francisco','CA'),
(3,'West LA','Los Angeles','CA'),
(4,'East LA','Los Angeles','CA'),
(5,'Uptown','New York','NY'),
(6,'Financial District','San Francisco','CA'),
(7,'Midtown','New York','NY'),
(8,'South Bay','San Francisco','CA'),
(9,'Downtown','Los Angeles','CA'),
(10,'Chinatown','New York','NY'),
(11,'Marina','Sam Francisco','CA'),
(12,'Beverly Hills','Los Angeles','CA'),
(13,'Brooklyn','New York','NY'),
(14,'North Beach','San Francisco','CA'),
(15,'Pasadena','Los Angeles','CA');

CREATE TABLE Accounts(
Account_id INT PRIMARY KEY,
Customer_id INT NOT NULL,
Branch_id INT NOT NULL,
Account_type VARCHAR(50) NOT NULL,
Balance DECIMAL(10,2) NOT NULL,
FOREIGN KEY(Customer_id) REFERENCES Customers(Customer_id),
FOREIGN KEY(Branch_id) REFERENCES Branches(Branch_id)
);


INSERT INTO Accounts VALUES
(1,1,5,'Checking',1000.00),
(2,1,5,'Savings',5000.00),
(3,2,1,'Checking',2500.00),
(4,2,1,'Savings',15000.00),
(5,3,2,'Checking',5000.00),
(6,3,2,'Savings',15000.00),
(7,4,8,'Checking',5000.00),
(8,4,8,'Savings',20000.00),
(9,5,14,'Checking',10000.00),
(10,5,14,'Savings',50000.00),
(11,6,2,'Checking',5000.00),
(12,6,2,'Savings',10000.00),
(13,1,5,'Credit Card',-500.00),
(14,2,1,'Credit Card',-1000.00),
(15,3,2,'Crdit Card',-2000.00);

CREATE TABLE Transactions
(Transaction_id INT PRIMARY KEY,
Account_id INT NOT NULL,
Transaction_date DATE NOT NULL,
Amount DECIMAL(10,2) NOT NULL,
FOREIGN KEY (Account_id) REFERENCES Accounts(Account_id));

INSERT INTO Transactions VALUES 
(1, 1, '2022-01-01', -500.00),
(2, 1, '2022-01-02', -250.00),
(3, 2, '2022-01-03', 1000.00),
(4, 3, '2022-01-04', -1000.00),
(5, 3, '2022-01-05', 500.00),
(6, 4, '2022-01-06', 1000.00),
(7, 4, '2022-01-07', -500.00),
(8, 5, '2022-01-08', -2500.00),
(9, 6, '2022-01-09', 500.00),
(10, 6, '2022-01-10', -1000.00),
(11, 7, '2022-01-11', -500.00),
(12, 7, '2022-01-12', -250.00),
(13, 8, '2022-01-13', 1000.00),
(14, 8, '2022-01-14', -1000.00),
(15, 9, '2022-01-15', 500.00);

SELECT * FROM accounts;

SELECT * FROM branches;

SELECT * FROM customers;

SELECT * FROM transactions;

-- 1. What are the names of all the customers who live in New York?
Select concat(First_Name,' ', Last_name) as Fullname
from customers
Where City = 'New York';

-- 2. What is the total number of accounts in the Accounts table?
SELECT COUNT(DISTINCT Account_ID) AS no_of_accounts
FROM accounts;

-- 3. What is the total balance of all checking accounts?
Select SUM(balance)as total_balance from accounts ;

-- 4. What is the total balance of all accounts 
-- associated with customers who live in Los Angeles?
Select SUM(balance) as total_balance
from accounts a
Inner Join customers c
on a.customer_id=c.customer_id
where c.city = 'Los Angeles';

-- 5. Which branch has the highest average account balance?
Select b.Branch_name,AVG(a.balance) as average_balance
from branches b
Join accounts a 
on b.branch_id=a.branch_id
Group by b.branch_name
Order by average_balance
Limit 1;

-- 6. Which customer has the highest current balance in their  Saving accounts?
Select Concat(first_name,' ',Last_name) as Fullname,MAX(a.balance)
From customers c
Join accounts a 
on c.customer_id=a.customer_id
Group by 1
Order by 2 Desc
Limit 1;

-- 7. Which customer has made the most transactions in the Transactions table?
Select Concat(first_name,' ',Last_name) as fullname,Count(transaction_id) as total_transactions
From accounts a
Join customers c
on c.Customer_id= a.Customer_id
Inner Join transactions t on a.account_id=t.account_id
Group by 1
order by 2 Desc
Limit 1;

-- 8.Which branch has the highest total balance across all of its accounts?
Select b.Branch_name,SUM(a.balance) as total_balance
from accounts a
Inner Join branches b
on a.branch_id=b.branch_id
Group by 1
Order by 2 Desc
Limit 1;

-- 9. Which customer has the highest total balance across all of their accounts,
-- including savings and checking accounts?
Select c.customer_id,Concat(first_name,' ', Last_name) as fullname,Sum(a.balance)
from customers c
Inner Join accounts a 
on c.customer_id=a.customer_id
Group by 1
Order by 3 Desc
Limit 1;

-- 10. Which branch has the highest number of transactions in the Transactions table?
Select b.branch_name,Count(t.transaction_id) as total_transactions
From transactions t
Join accounts a
On t.account_id=t.account_id
Join branches b on b.branch_id=a.branch_id
Group by b.branch_name
Order by total_transactions
Limit 1;












