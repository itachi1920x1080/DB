-- 1. Create and select the database
CREATE DATABASE ISDT;
USE ISDT; 

-- 2. Create the Client table

CREATE TABLE Client (
    id INT AUTO_INCREMENT PRIMARY KEY,
    f_name VARCHAR(100),
    l_name VARCHAR(100),
    address VARCHAR(255), 
    city VARCHAR(100),
    state VARCHAR(50),    
    zip_code INT
);
CREATE TABLE User (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT,                        -- This will hold the ID of the connected client
    email VARCHAR(255) UNIQUE NOT NULL,   -- Added VARCHAR and UNIQUE so emails can't be duplicated
    password VARCHAR(255) NOT NULL,       -- Added VARCHAR (spelled out password completely)
    
    -- This links the client_id in this table to the id in the Client table
    FOREIGN KEY (client_id) REFERENCES Client(id) 
); 
-- 3. Create the Item table
CREATE TABLE Item (
    code VARCHAR(50) PRIMARY KEY, 
    nameproduct VARCHAR(150) NOT NULL,
    QRcode VARCHAR(255)           
);

-- 4. Create the Orders table (Bridging Clients and Items)
CREATE TABLE Orders (
    idorder INT AUTO_INCREMENT PRIMARY KEY,
    useroder INT,
    codeitem VARCHAR(50),
    FOREIGN KEY (useroder) REFERENCES Client(id),
    FOREIGN KEY (codeitem) REFERENCES Item(code)
);
