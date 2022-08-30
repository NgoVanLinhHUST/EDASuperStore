
-- create table Store in SUPER STORE
CREATE TABLE Store (
	ShipMode VARCHAR(50),
	Segment VARCHAR(25),
	Country VARCHAR(50),
	City VARCHAR(50),
	State VARCHAR(50),
	PostalCode INT,
	Region VARCHAR(12),
	Category VARCHAR(25),
	SubCategory VARCHAR(25),
	Sales FLOAT,
	Quantity INT,
	Discount FLOAT,
	Profit FLOAT
	)

SELECT * FROM Store;
/* Importing csv file */
BULK INSERT Store
FROM 'C:\Users\Linh\Desktop\sql\Superstore\SampleSuperstore.csv'
WITH
(
    FIRSTROW = 2, -- as 1st one is header
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
)

----- dataset information of store table
-- Ship Mode : Shipping Class
-- Segment : Product Segment
-- Country : United States
-- City : City of the product ordered
-- State : State of product ordered
-- Category : Product category
-- Sub_Category : Product sub category
-- Sales : Sales contribution of the order
-- Quantity : Quantity Ordered
-- Discount : % discount given
-- Profit : Profit for the order



-- COUNT ROWS IN STORE
SELECT COUNT(*) FROM STORE
/* column count of data */
SELECT COUNT(*) 
FROM information_schema.columns
WHERE table_name = 'store';

/* Check Dataset Information */
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'store'

/*  get column names of store data */
select column_name, data_type
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME='store'
----
SELECT * FROM store
WHERE (select column_name
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME='store') = NULL;
------
-- Analysis Shipmode 
Select shipmode,category, sum(quantity) as sum_quantity
From Store
group by shipmode,category
order by shipmode 


---- Analysis State-----
--- top 5 state max sale
Select top 5 state, max(sales) as Maximum_Sales
From store
group by state
order by Maximum_Sales DESC
----
--- top 5 state max profit
SELECT TOP 5 State, MAX(Profit) as Max_Profit 
FROM STORE 
GROUP BY State
ORDER BY Max_Profit DESC
----
----Categoty analysis-----
-- extract state, category, subcategory , maxsales, max profit, sum quantity 
SELECT State, Category, Subcategory, MAX(Sales) as MaxSale , MAX(Profit) as MaxProfit , SUM(Quantity) as SumQuantity
FROM Store 
GROUP BY State, Category, SubCategory
ORDER BY SubCategory
---- extract maxsale product 
SELECT State, Category, Subcategory, MAX(Sales) as MaxSale 
FROM Store 
GROUP BY State, Category, SubCategory
ORDER BY MaxSale DESC
---- Extract MaxProfit	Product
SELECT State, Category, SubCategory, Max(Profit) as MaxProfit
FROM Store
GROUP BY State , Category, SubCategory
ORDER BY MaxProfit DESC
---- Extract SumQuantity Product
SELECT State, Category, SubCategory, SUM(Quantity) as SumQuantity
FROM Store
GROUP BY State , Category, SubCategory
ORDER BY SumQuantity DESC
------
--Find Sum Total Sales of Superstore?
Select CAST(SUM(Sales) AS INT) AS SumSale FROM Store;
--Find a region having maximum number of Profit?
SELECT  Region, SUM(Profit) AS MaxProfit
FROM Store 
GROUP BY Region
