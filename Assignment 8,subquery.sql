Create table country (Id int not null primary key, Country_name varchar(15) not null,
Population int not null,Area int not null );

desc country;

create table Persons(Id int not null primary key,Fname varchar(15) not null ,
Lname varchar(15)not null,Population int not null ,Rating float not null ,
Country_id varchar(5) not null,Country_name varchar(20)not null );

desc persons;

#Insert 10 rows to Table Country

insert into Country(Id,Country_name,Population,Area)values
(200,'China' , 1400000, 9600000 ),
 ( 201,'India', 1400000,  3300000) ,
( 202,'United States', 335000 , 9800000 ),
( 203,'Indonesia',  277000 , 1900000 ),
( 204,'Brazil',  215000, 8400000),
 (205,'Pakistan',  2350000 , 881913 ),
 (206,'Nigeria',21800, 923768 ),
  (207,'Bangladesh',80000, 148571) ,
 (208,'Russia',1440000, 17125191 ),
(209,'Australia',260000,7692024 );

select * from country;

insert into persons(Id,Fname,Lname,Population,Rating,Country_id,Country_name)values
(205,'John', 'Doe', 10000 , 4.5 ,'US' ,'United states'),
( 206 ,'Jane', 'Smith',  9000 , 3.8 , 'CA', 'Canada' ),
( 207 ,'Michael', 'Johnson', 800000, 4.2 ,' AU','Australia' ),
(208,'Emily', 'Davis' ,7000,  4.0 , 'CA', 'Canada'),
( 209,'Ethan ','Lee',9000 , 4.7,  'CN  ','China'),
( 210,'Olivia',  'Martinez' ,600000,3.9,'US','United states'), 
 (211,'Ava','Williams' ,12000,4.8,'UK','UK'),
(212,'Sophia','Alex' , 400000 , 3.7,'IN', 'India'),
(213,'Isabella','Jones', 15000 , 4.9,'JP', 'Japan'),
( 214,'Liam', 'Miller',  30000  ,3.6,'MX','Mexico');

select * from persons;

-- 1. Find the number of persons in each country.
select Country_name,count(*) as Persons_count from (select Country_name from country 
union all
select Country_name from persons) as combined_data group by Country_name;


-- 2. Find the number of persons in each country sorted from high to low.
select Country_name,count(*) as Persons_count from (select Country_name from country 
union all
select Country_name from persons) as combined_data group by Country_name order by Persons_count desc;


-- 3. Find out an average rating for Persons in respective countries if the average is greater than 3.0 
select Country_name,avg(Rating) as Avg_rating from  persons
 where Rating>3 group by Country_name ;


 -- 4. Find the countries with the same rating as the USA. (Use Subqueries)
 select Country_name  from persons where Rating in 
 (select Rating from persons where Country_name='United states') group by Country_name;
 
--  5. Select all countries whose population is greater than the average population of all nations.
SELECT Country_Name
FROM Country
WHERE Population > (SELECT AVG(Population) FROM Country);

 -- Create a database named Product and create a table called Customer 
--  with the following fields in the Product database: Customer_Id - Make PRIMARY KEY 
-- First_name Last_name Email Phone_no Address City State Zip_code Country

Create database Product;

use product;
CREATE TABLE Customer (Customer_Id INT PRIMARY KEY,First_name VARCHAR(50) NOT NULL,
    Last_name VARCHAR(50) NOT NULL,Email VARCHAR(100) NOT NULL,
    Phone_no VARCHAR(15),Address VARCHAR(255),
    City VARCHAR(50),State VARCHAR(50),
    Zip_code VARCHAR(10),Country VARCHAR(50) NOT NULL
);

desc customer;

INSERT INTO Customer (Customer_Id, First_name, Last_name, Email, Phone_no, Address, City, State, Zip_code, Country)
VALUES
    (1, 'John', 'Doe', 'john.doe@example.com', '1234567890', '123 Elm St', 'Los Angeles', 'California', '90001', 'USA'),
    (2, 'Jane', 'Smith', 'jane.smith@example.com', '2345678901', '456 Maple Ave', 'Toronto', 'Ontario', 'M4B 1B3', 'Canada'),
    (3, 'Mike', 'Johnson', 'mike.johnson@example.com', '3456789012', '789 Oak Rd', 'London', 'London', 'E1 6AN', 'UK'),
    (4, 'Emily', 'Davis', 'emily.davis@example.com', '4567890123', '101 Pine Blvd', 'Montreal', 'Quebec', 'H1A 0B1', 'Canada'),
    (5, 'David', 'Brown', 'david.brown@example.com', '5678901234', '202 Birch Ct', 'Las Vegas', 'Nevada', '89101', 'USA'),
    (6, 'Laura', 'Wilson', 'laura.wilson@example.com', '6789012345', '303 Cedar Dr', 'Seattle', 'Washington', '98101', 'USA'),
    (7, 'Carlos', 'Martinez', 'carlos.martinez@example.com', '7890123456', '404 Spruce St', 'Madrid', 'Madrid', '28001', 'Spain'),
    (8, 'Sophia', 'Garcia', 'sophia.garcia@example.com', '8901234567', '505 Willow Way', 'Houston', 'Texas', '77001', 'USA'),
    (9, 'Emma', 'Taylor', 'emma.taylor@example.com', '9012345678', '606 Fir Pl', 'Sydney', 'New South Wales', '2000', 'Australia'),
    (10, 'Liam', 'Anderson', 'liam.anderson@example.com', '0123456789', '707 Palm St', 'Victoria', 'British Columbia', 'V8W 1N8', 'Canada');
    
    select * from customer;
    
--  1. Create a view named customer_info for the Customer table that displays 
-- Customer’s Full name and email address. Then perform the SELECT
--  operation for the customer_info view.
create view Customer_info as select concat(First_name,' ' ,Last_name)as Full_name,email from customer;

select * from customer_info;

--  2. Create a view named US_Customers that displays customers located in the US.
create view US_Customers as select Customer_id,First_name,Last_name,State,Country FROM customer where Country='USA';

select * from Us_customers;

-- 3. Create another view named Customer_details with columns 
-- full name(Combine first_name and last_name), email, phone_no, and state.

Create view Customer_details as select Customer_id,concat(First_name,' ' ,Last_name)as 
Full_name,email,Phone_no,State from customer;

select * from customer_details;

-- 4. Update phone numbers of customers who live in California for Customer_details view.
Update customer_details set Phone_no='1111222233' where state='California';
set sql_safe_updates=0;
SELECT * from customer_details;

-- 5. Count the number of customers in each state and show only states with more than 5 customers.
SELECT State, COUNT(Customer_Id) AS Number_of_Customers
FROM Customer GROUP BY State
HAVING COUNT(Customer_Id) > 5;

-- 6. Write a query that will return the number of customers in each state, based 
-- on the "state" column in the "customer_details" view.
select State,count(Customer_id) as Number_of_customers from customer_details
group by State ;
 
 -- 7. Write a query that returns all the columns from the "customer_details"
-- view, sorted by the "state" column in ascending order.
select *  from customer_details order by State asc; 



