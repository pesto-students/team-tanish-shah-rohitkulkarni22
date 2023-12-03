
SHOW DATABASES;

CREATE DATABASE WAREHOUSE;

USE WAREHOUSE;

CREATE TABLE CITIES (
	CITY CHAR(20) PRIMARY KEY,
    STATE CHAR(20)
);

CREATE TABLE WAREHOUSES (
	WID INTEGER PRIMARY KEY, 
	WNAME CHAR(30), 
    LOCATION CHAR(20), 
    EXTRA_CONTEXT JSON,
	CITY CHAR(20),
	FOREIGN KEY (CITY) REFERENCES CITIES(CITY)
);

CREATE TABLE STORES (
  SID INTEGER PRIMARY KEY,
  STORE_NAME CHAR(20),
  LOCATION_CITY CHAR(20),
  FOREIGN KEY (LOCATION_CITY) REFERENCES CITIES(CITY)
);

-- CUSTOMER (CNO INTEGER, CNAME CHAR(50), ADDR VARCHAR(50), CU_CITY CHAR(20))

CREATE TABLE CUSTOMER (
	CNO INTEGER PRIMARY KEY,
    CNAME CHAR(50),
    ADDR VARCHAR(50),
    CU_CITY CHAR(20),
    FOREIGN KEY (CU_CITY) REFERENCES CITIES(CITY)
);

-- Create the ORDERS table with a foreign key reference to CUSTOMER

CREATE TABLE ORDERS (
  ONO INT PRIMARY KEY,
  ODATE DATE,
  CUSTOMER_NO INTEGER,
  FOREIGN KEY (CUSTOMER_NO) REFERENCES CUSTOMER(CNO)
);

-- Create the ITEMS table

CREATE TABLE ITEMS (
  ITEMNO INTEGER PRIMARY KEY,
  DESCRIPTION TEXT,
  WEIGHT DECIMAL(5,2),
  COST DECIMAL(5,2)
);

-- Adding the WAREHOUSE_NO column as a foreign key in the STORES table to establish a 1:M (1 to many relationship between warehouses and stores:
-- ALTER TABLE STORES
-- ADD COLUMN WAREHOUSE_NO INTEGER,
-- ADD FOREIGN KEY (WAREHOUSE_NO) REFERENCES WAREHOUSES(WID)

-- SELECT * FROM STORES;

-- Create the ORDERED_ITEMS table to represent the Many-to-Many relationship between ITEMS and ORDERS
CREATE TABLE ORDERED_ITEMS (
  ORDER_NO INT,
  ITEM_NO INT,
  ORDERED_QUANTITY INT,
  PRIMARY KEY (ORDER_NO, ITEM_NO),
  FOREIGN KEY (ORDER_NO) REFERENCES ORDERS(ONO),
  FOREIGN KEY (ITEM_NO) REFERENCES ITEMS(ITEMNO)
);



-- Create the STORED_ITEMS table to represent the Many-to-Many relationship between STORES and ITEMS
CREATE TABLE STORED_ITEMS (
  STORE_NO INT,
  ITEM_NO INT,
  QUANTITY INT,
  PRIMARY KEY (STORE_NO, ITEM_NO),
  FOREIGN KEY (STORE_NO) REFERENCES STORES(SID),
  FOREIGN KEY (ITEM_NO) REFERENCES ITEMS(ITEMNO)
);

-- now inserting data into our warehouse database using insert (A DML command) 

-- Insert data into the CITIES table
INSERT INTO CITIES (CITY, STATE) VALUES
  ('Pune', 'Maharashtra'),
  ('Mumbai', 'Maharashtra'),
  ('Delhi', 'Delhi'),
  ('Bangalore', 'Karnataka');
  
-- Insert data into the WAREHOUSES table
INSERT INTO WAREHOUSES (WID, WNAME, LOCATION, CITY) VALUES
  (1, 'Warehouse 1', 'Location 1', 'Pune'),
  (2, 'Warehouse 2', 'Location 2', 'Mumbai'),
  (3, 'Warehouse 3', 'Location 3', 'Pune');
  
-- Update the EXTRA_CONTEXT column for specific records in the WAREHOUSES table
UPDATE WAREHOUSES
SET EXTRA_CONTEXT = '{"key1": "new_value1", "key2": "new_value2"}'
WHERE WID = 1; -- Adjust the WHERE clause to specify which record(s) 

UPDATE WAREHOUSES
SET EXTRA_CONTEXT = '{"key1": "value2", "key2": "value2"}'
WHERE WID = 1; 

UPDATE WAREHOUSES
SET EXTRA_CONTEXT = '{"key1": "value3", "key2": "value4"}'
WHERE WID = 2; 

UPDATE WAREHOUSES
SET EXTRA_CONTEXT = '{"key1": "value5", "key2": "value6"}'
WHERE WID = 3; 

-- Thus we have updated the WAREHOUSES TABLE BY ADDING DATA INTO THE EXTRA_CONTEXT COLUMN:

-- Insert data into the STORES table with the WAREHOUSE_NO column
INSERT INTO STORES (SID, STORE_NAME, LOCATION_CITY, WAREHOUSE_NO) VALUES
  (1, 'Store 1', 'Mumbai', 1),  -- Store 1 belongs to Warehouse 1
  (2, 'Store 2', 'Pune', 2),    -- Store 2 belongs to Warehouse 2
  (3, 'Store 3', 'Mumbai', 1);  -- Store 3 belongs to Warehouse 1

-- Insert data into the CUSTOMER table
INSERT INTO CUSTOMER (CNO, CNAME, ADDR, CU_CITY) VALUES
  (1, 'Mr. Patil', 'Address 1', 'Pune'),
  (2, 'Mrs. Sharma', 'Address 2', 'Delhi'),
  (3, 'Mr. Khan', 'Address 3', 'Mumbai');

-- Insert data into the ORDERS table
INSERT INTO ORDERS (ONO, ODATE, CUSTOMER_NO) VALUES
  (101, '2023-10-01', 1),
  (102, '2023-10-02', 2),
  (103, '2023-10-03', 1);
  
-- Insert data into the ITEMS table
INSERT INTO ITEMS (ITEMNO, DESCRIPTION, WEIGHT, COST) VALUES
  (1, 'Item 1', 2.5, 10.99),
  (2, 'Item 2', 1.8, 7.50),
  (3, 'Item 3', 3.2, 15.00);

-- Insert data into the ORDERED_ITEMS table (Many-to-Many relationship)
INSERT INTO ORDERED_ITEMS (ORDER_NO, ITEM_NO, ORDERED_QUANTITY) VALUES
  (101, 1, 5),
  (101, 2, 3),
  (102, 3, 2);

-- Insert data into the STORED_ITEMS table (Many-to-Many relationship)
INSERT INTO STORED_ITEMS (STORE_NO, ITEM_NO, QUANTITY) VALUES
  (1, 1, 10),
  (2, 2, 8),
  (3, 3, 15);
  
