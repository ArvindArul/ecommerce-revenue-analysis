SELECT TOP 10
    CustomerID,
    SUM(Revenue) AS total_revenue
FROM dbo.online_retail
GROUP BY CustomerID
ORDER BY total_revenue DESC;