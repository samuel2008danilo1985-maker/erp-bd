# erp-bd

# Projeto de Banco de Dados Relacional MySQL: Estrutura e Carga Otimizada

## 1. Introdução

Este documento apresenta o esquema completo (DDL) e os scripts de carga de dados (DML) para a implementação de um banco de dados relacional em MySQL [1-8]. O projeto utiliza o comando **`LOAD DATA INFILE`**, que é a ferramenta mais **rápida e eficaz** para transferir uma lista extensa de dados tabulares (CSV) para o Sistema de Gerenciamento de Banco de Dados (SGBD) [9].

O formato CSV (Comma-Separated Values) é amplamente utilizado para armazenar e transmitir dados tabulares, sendo flexível quanto ao caractere delimitador [10]. Neste projeto, o delimitador utilizado nos arquivos CSV é o **ponto e vírgula** (`;`) [1-8, 11].

## 2. Esquema do Banco de Dados

O banco de dados é composto por **oito tabelas** principais, estruturadas com chaves primárias e campos `NOT NULL` que definem os relacionamentos.

### 2.1. Definição das Tabelas (DDL) e Chaves Primárias

| Tabela | Colunas Chave e Restrições |
| :--- | :--- |
| `categories` | `CategoryID INT PRIMARY KEY auto_increment`, `CategoryName VARCHAR(50)`, `Description VARCHAR(255)` [1] |
| `customers` | `CustomerID INT PRIMARY KEY auto_increment`, `CustomerName VARCHAR(100)`, `ContactName VARCHAR(100)` [1, 2], `Address VARCHAR(100)`, `City VARCHAR(50)`, `PostalCode VARCHAR(10)`, `Country VARCHAR(50)` [2] |
| `employees` | `EmployeeID INT PRIMARY KEY auto_increment`, `LastName VARCHAR(50)` [3], `FirstName VARCHAR(50)`, `BirthDate DATE`, `Photo VARCHAR(100)`, `Notes TEXT` [3] |
| `Shippers` | `ShipperID INT PRIMARY KEY auto_increment`, `ShipperName VARCHAR(100) NOT NULL`, `Phone VARCHAR(20)` [7] |
| `Suppliers` | `SupplierID INT PRIMARY KEY auto_increment`, `SupplierName VARCHAR(100) NOT NULL`, `ContactName VARCHAR(100)` [8], `Address VARCHAR(150)`, `City VARCHAR(100)`, `PostalCode VARCHAR(20)`, `Country VARCHAR(50)`, `Phone VARCHAR(25)` [8] |
| `Products` | `ProductID INT PRIMARY KEY auto_increment`, `ProductName VARCHAR(100) NOT NULL`, `SupplierID INT NOT NULL`, `CategoryID INT NOT NULL` [6], `Unit VARCHAR(50)`, `Price DECIMAL(10,2) NOT NULL` [6] |
| `Orders` | `OrderID INT PRIMARY KEY auto_increment`, `CustomerID INT NOT NULL`, `EmployeeID INT NOT NULL` [5], `OrderDate DATE NOT NULL`, `ShipperID INT NOT NULL` [5] |
| `OrderDetails` | `OrderDetailID INT AUTO_INCREMENT PRIMARY KEY`, `OrderID INT NOT NULL`, `ProductID INT NOT NULL`, `Quantity INT NOT NULL` [4] |

---

## 3. Scripts de Implementação e Carga de Dados (DDL e DML)

Todos os scripts de carga utilizam a cláusula `IGNORE 1 ROWS` para pular a linha de cabeçalho do arquivo CSV [1-8, 12]. O delimitador de campo é `FIELDS TERMINATED BY ';'`.

### 3.1. `categories`

```sql
CREATE TABLE categories (
    CategoryID INT PRIMARY KEY auto_increment,
    CategoryName VARCHAR(50),
    Description VARCHAR(255)
); [1]

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/categories.csv"
INTO TABLE categories
FIELDS TERMINATED BY ';'
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; [1]
3.2. customers
CREATE TABLE customers (
    CustomerID INT PRIMARY KEY auto_increment,
    CustomerName VARCHAR(100),
    ContactName VARCHAR(100), [2]
    Address VARCHAR(100),
    City VARCHAR(50),
    PostalCode VARCHAR(10),
    Country VARCHAR(50)
); [1, 2]

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customers.csv"
INTO TABLE customers
FIELDS TERMINATED BY ';'
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; [2]
3.3. employees
Nota: Durante a carga, a data de nascimento (BirthDate) é convertida do formato "%d/%m/%Y" para o tipo DATE do MySQL.
CREATE TABLE employees (
    EmployeeID INT PRIMARY KEY auto_increment,
    LastName VARCHAR(50),
    FirstName VARCHAR(50), [3]
    BirthDate DATE,
    Photo VARCHAR(100),
    Notes TEXT
); [3]

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/employees.csv"
INTO TABLE employees
FIELDS TERMINATED BY ';'
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(EmployeeID,LastName,FirstName,@BirthDate,Photo,Notes)
set BirthDate = str_to_date(@BirthDate,"%d/%m/%Y"); [3]
3.4. Shippers
CREATE TABLE Shippers (
    ShipperID INT PRIMARY KEY auto_increment, [7]
    ShipperName VARCHAR(100) NOT NULL,
    Phone VARCHAR(20)
); [7]

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Shippers.csv"
INTO TABLE Shippers
FIELDS TERMINATED BY ';'
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; [7]
3.5. Suppliers
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY auto_increment,
    SupplierName VARCHAR(100) NOT NULL,
    ContactName VARCHAR(100), [8]
    Address VARCHAR(150),
    City VARCHAR(100),
    PostalCode VARCHAR(20),
    Country VARCHAR(50),
    Phone VARCHAR(25)
); [8]

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Suppliers.csv"
INTO TABLE Suppliers
FIELDS TERMINATED BY ';'
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; [8]
3.6. Products
Nota: Durante a carga, o campo Price tem a vírgula (,) substituída por ponto (.) para garantir o formato correto para o tipo DECIMAL(10,2).
CREATE TABLE Products (
    ProductID INT PRIMARY KEY auto_increment,
    ProductName VARCHAR(100) NOT NULL,
    SupplierID INT NOT NULL, [6]
    CategoryID INT NOT NULL,
    Unit VARCHAR(50),
    Price DECIMAL(10,2) NOT NULL
); [6]

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Products.csv"
INTO TABLE Products
FIELDS TERMINATED BY ';'
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ProductID,ProductName,SupplierID,CategoryID,Unit,@Price)
set Price = replace(@Price,",","."); [6]
3.7. Orders
Nota: Durante a carga, a data do pedido (OrderDate) é convertida do formato "%d/%m/%Y" para o tipo DATE do MySQL.
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY auto_increment,
    CustomerID INT NOT NULL,
    EmployeeID INT NOT NULL, [5]
    OrderDate DATE NOT NULL,
    ShipperID INT NOT NULL
); [5]

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Orders.csv"
INTO TABLE Orders
FIELDS TERMINATED BY ';'
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(OrderID,CustomerID,EmployeeID,@OrderDate,ShipperID)
set OrderDate = str_to_date(@OrderDate,"%d/%m/%Y"); [5]
3.8. OrderDetails
CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY, [4]
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL
); [4]

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/OrderDetails.csv"
INTO TABLE OrderDetails
FIELDS TERMINATED BY ';'
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; [4]
4. Configurações de Carga de Dados
O comando LOAD DATA INFILE requer que a localização do arquivo CSV seja acessível pelo MySQL. A sintaxe utilizada garante que o processo de importação seja rápido e coerente com os dados de origem.
As configurações globais de importação, aplicadas em todas as tabelas, são:
Cláusula
Configuração
Descrição
Fonte
LOAD DATA INFILE
Caminho Fixo
C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/
FIELDS TERMINATED BY
; (Ponto e vírgula)
Define o caractere usado para separar as colunas nos arquivos CSV.
ENCLOSED BY
'' (Vazio)
Indica que não há delimitador de texto (como aspas) envolta dos campos.
LINES TERMINATED BY
\n (Nova linha)
Define o caractere que indica o final de cada linha.
IGNORE
1 ROWS
Ignora a primeira linha do arquivo (o cabeçalho).
