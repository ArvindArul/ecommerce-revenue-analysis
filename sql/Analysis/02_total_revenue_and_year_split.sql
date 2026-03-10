SELECT SUM(Revenue) AS total_revenue
FROM dbo.online_retail;

SELECT
    [Year],
    SUM(Revenue) AS revenue
FROM dbo.online_retail
GROUP BY [Year]
ORDER BY [Year];