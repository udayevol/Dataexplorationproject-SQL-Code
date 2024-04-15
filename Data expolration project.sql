SELECT *
  FROM [Superstore]..[Superstore]
  order by 1,2

-- Identify top selling products
SELECT [Product_Name], SUM(Quantity) AS TotalQuantity
FROM [Superstore]..[Superstore]
GROUP BY [Product_Name]
ORDER BY TotalQuantity DESC

-- Calculate average profit margin by category
SELECT [Category], AVG(Profit / Sales) AS AvgProfitMargin
FROM [Superstore]..[Superstore]
GROUP BY [Category]

-- Segment sales by region and category
SELECT [Region], [Category], SUM(Sales) AS TotalSales
FROM [Superstore]..[Superstore]
GROUP BY [Region], [Category]


--Identify top customers by total sales or total profit.
SELECT [Customer_Name], SUM(Sales) AS TotalSales
FROM [Superstore]..[Superstore]
GROUP BY [Customer_Name]
ORDER BY TotalSales DESC

-- Analyze sales trends over time (monthly).
SELECT YEAR(Order_Date) AS Year, MONTH(Order_Date) AS Month, SUM(Sales) AS MonthlySales
FROM [Superstore]..[Superstore]
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Year, Month;

--Calculate product profitability by analyzing sales and profit margins.
SELECT [Product_Name], SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfit, AVG(Profit / Sales) AS AvgProfitMargin
FROM [Superstore]..[Superstore]
GROUP BY [Product_Name]
ORDER BY TotalSales DESC

--Analyze sales performance by city.
SELECT [City], [Country], SUM(Sales) AS TotalSales
FROM [Superstore]..[Superstore]
GROUP BY [City], [Country]
ORDER BY TotalSales DESC

 --Analyze profit performance by state
  select [State],SUM(Profit) AS TotalProfit
   from [Superstore]..[Superstore]
   GROUP BY [State]
   ORDER BY TotalProfit DESC


-- Segmentation Analysis: Segment customers based on purchasing behavior.
SELECT
    CustomerSegment,
    COUNT(*) AS CustomerCount,
    AVG(TotalSales) AS AvgTotalSales,
    AVG(TotalProfit) AS AvgTotalProfit
FROM (
    SELECT
        CASE
            WHEN TotalSales > 10000 THEN 'High Value'
            WHEN TotalSales > 5000 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS CustomerSegment,
        TotalSales,
        TotalProfit
    FROM (
        SELECT
            Customer_Name,
            SUM(Sales) AS TotalSales,
            SUM(Profit) AS TotalProfit
        FROM[Superstore]..[Superstore]
        GROUP BY Customer_Name
    ) AS CustomerSummary
) AS SegmentedCustomers
GROUP BY CustomerSegment;