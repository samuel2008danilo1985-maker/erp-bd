CREATE TABLE categories (
    CategoryID INT PRIMARY KEY auto_increment,
    CategoryName VARCHAR(50),
    Description VARCHAR(255)
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/categories.csv"
INTO TABLE categories
FIELDS TERMINATED BY ';'      -- Campos separados por vírgula
ENCLOSED BY ''                -- Não há delimitador de texto (aspas)
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- --------TABELA CUSTOMERS --------

CREATE TABLE customers (
    CustomerID INT PRIMARY KEY auto_increment,
    CustomerName VARCHAR(100),
    ContactName VARCHAR(100),
    Address VARCHAR(100),
    City VARCHAR(50),
    PostalCode VARCHAR(10),
    Country VARCHAR(50)
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customers.csv"
INTO TABLE customers
FIELDS TERMINATED BY ';'      -- Campos separados por vírgula
ENCLOSED BY ''                -- Não há delimitador de texto (aspas)
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- -------------TABELA employees --------

CREATE TABLE employees (
    EmployeeID INT PRIMARY KEY auto_increment,
    LastName VARCHAR(50),
    FirstName VARCHAR(50),
    BirthDate DATE,
    Photo VARCHAR(100),
    Notes TEXT
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/employees.csv"
INTO TABLE employees
FIELDS TERMINATED BY ';'      -- Campos separados por vírgula
ENCLOSED BY ''                -- Não há delimitador de texto (aspas)
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(EmployeeID,LastName,FirstName,@BirthDate,Photo,Notes)
set BirthDate = str_to_date(@BirthDate,"%d/%m/%Y");

-- -------------  orderdetails ---------

CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL
);
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/OrderDetails.csv"
INTO TABLE OrderDetails
FIELDS TERMINATED BY ';'      -- Campos separados por vírgula
ENCLOSED BY ''                -- Não há delimitador de texto (aspas)
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- ---------- orders --------------
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY auto_increment,
    CustomerID INT NOT NULL,
    EmployeeID INT NOT NULL,
    OrderDate DATE NOT NULL,
    ShipperID INT NOT NULL
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Orders.csv"
INTO TABLE Orders
FIELDS TERMINATED BY ';'      -- Campos separados por vírgula
ENCLOSED BY ''                -- Não há delimitador de texto (aspas)
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(OrderID,CustomerID,EmployeeID,@OrderDate,ShipperID)
set OrderDate = str_to_date(@OrderDate,"%d/%m/%Y");
 -- ---------products --------
 CREATE TABLE Products (
    ProductID INT PRIMARY KEY auto_increment,
    ProductName VARCHAR(100) NOT NULL,
    SupplierID INT NOT NULL,
    CategoryID INT NOT NULL,
    Unit VARCHAR(50),
    Price DECIMAL(10,2) NOT NULL
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Products.csv"
INTO TABLE Products
FIELDS TERMINATED BY ';'      -- Campos separados por vírgula
ENCLOSED BY ''                -- Não há delimitador de texto (aspas)
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ProductID,ProductName,SupplierID,CategoryID,Unit,@Price)
set Price = replace(@Price,",",".");

-- ------ shippers ---------------
CREATE TABLE Shippers (
    ShipperID INT PRIMARY KEY auto_increment,
    ShipperName VARCHAR(100) NOT NULL,
    Phone VARCHAR(20)
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Shippers.csv"
INTO TABLE Shippers
FIELDS TERMINATED BY ';'      -- Campos separados por vírgula
ENCLOSED BY ''                -- Não há delimitador de texto (aspas)
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- --------- suppliers -------

CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY auto_increment,
    SupplierName VARCHAR(100) NOT NULL,
    ContactName VARCHAR(100),
    Address VARCHAR(150),
    City VARCHAR(100),
    PostalCode VARCHAR(20),
    Country VARCHAR(50),
    Phone VARCHAR(25)
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Suppliers.csv"
INTO TABLE Suppliers
FIELDS TERMINATED BY ';'      -- Campos separados por vírgula
ENCLOSED BY ''                -- Não há delimitador de texto (aspas)
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
