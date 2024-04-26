-- 1. Sales Analysis

-- Monthly sales trends
SELECT 
    CONVERT(VARCHAR(7), Order_Date, 120) AS month,
    SUM(Sales) AS total_sales
FROM [Superstore].[dbo].[Superstore]
GROUP BY CONVERT(VARCHAR(7), Order_Date, 120)
ORDER BY CONVERT(VARCHAR(7), Order_Date, 120);

-- Best-selling products and categories
SELECT 
    Product_Name,
    Category,
    SUM(Quantity) AS total_quantity_sold
FROM [Superstore].[dbo].[Superstore]
GROUP BY Product_Name, Category
ORDER BY total_quantity_sold DESC

-- Sales performance by region
SELECT 
    Region,
    SUM(Sales) AS total_sales
FROM [Superstore].[dbo].[Superstore]
GROUP BY Region
ORDER BY total_sales DESC;

--2. Profitability Analysis

-- Profit margins by category
SELECT 
    Category,
    AVG(Profit / Sales) AS profit_margin
FROM [Superstore].[dbo].[Superstore]
GROUP BY Category
ORDER BY profit_margin DESC;

-- Products with the highest and lowest profitability
SELECT 
    Product_Name,
    Profit
FROM [Superstore].[dbo].[Superstore]
ORDER BY Profit DESC

SELECT 
    Product_Name,
    Profit
FROM [Superstore].[dbo].[Superstore]
ORDER BY Profit ASC

-- 3.Customer Analysis

-- Customer segmentation based on purchasing behavior
SELECT 
    Customer_ID,
    COUNT(Order_ID) AS num_orders,
    SUM(Sales) AS total_sales
FROM [Superstore].[dbo].[Superstore]
GROUP BY Customer_ID
ORDER BY total_sales DESC;

-- Customer retention rate
SELECT 
    COUNT(DISTINCT Customer_ID) AS total_customers,
    COUNT(DISTINCT CASE WHEN DATEDIFF(day, Order_Date, GETDATE()) <= 365 THEN Customer_ID END) AS retained_customers,
    (COUNT(DISTINCT CASE WHEN DATEDIFF(day, Order_Date, GETDATE()) <= 365 THEN Customer_ID END) / COUNT(DISTINCT Customer_ID)) * 100 AS retention_rate
FROM [Superstore].[dbo].[Superstore]

-- 4. Product Analysis

-- Product performance based on sales volume
SELECT 
    Product_Name,
    SUM(Sales) AS total_sales
FROM [Superstore].[dbo].[Superstore]
GROUP BY Product_Name
ORDER BY total_sales DESC

-- Product trends and seasonality
SELECT 
    Product_Name,
    MONTH(Order_Date) AS month,
    SUM(Sales) AS monthly_sales
FROM [Superstore].[dbo].[Superstore]
GROUP BY Product_Name, MONTH(Order_Date)
ORDER BY Product_Name, MONTH(Order_Date);

-- 5. Inventory Analysis. 

-- Inventory turnover rates
SELECT 
    Product_Name,
    SUM(Quantity) AS total_quantity_sold,
    AVG(Quantity) AS avg_daily_sales
FROM [Superstore].[dbo].[Superstore]
GROUP BY Product_Name
ORDER BY avg_daily_sales DESC;

-- Slow-moving or obsolete inventory
SELECT 
    Product_Name,
    SUM(Quantity) AS total_quantity
FROM [Superstore].[dbo].[Superstore]
GROUP BY Product_Name

-- 6. Supply Chain Analysis

-- Shipping modes and delivery times analysis
SELECT 
    Ship_Mode,
    AVG(DATEDIFF(year, Ship_Date, Order_Date)) AS avg_delivery_time
FROM [Superstore].[dbo].[Superstore]
GROUP BY Ship_Mode;

--7. Forecasting and Predicitive Analytics

-- Sales forecasting
SELECT 
    YEAR(Order_Date) AS year,
    MONTH(Order_Date) AS month,
    SUM(Sales) AS total_sales
FROM [Superstore].[dbo].[Superstore]
WHERE Order_Date >= DATEADD(MONTH, -12, GETDATE())
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY year, month;

-- Customer churn prediction
SELECT 
    Customer_ID,
    COUNT(DISTINCT Order_Date) AS num_orders,
    DATEDIFF(DAY, MIN(Order_Date), MAX(Order_Date)) AS customer_tenure
FROM [Superstore].[dbo].[Superstore]
GROUP BY Customer_ID;


