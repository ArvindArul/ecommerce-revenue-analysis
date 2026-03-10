WITH monthly_revenue AS (
    SELECT
        [Year],
        [Month],
        SUM(Revenue) AS monthly_revenue
    FROM dbo.online_retail
    GROUP BY [Year], [Month]
)
SELECT
    [Year],
    [Month],
    monthly_revenue,
    SUM(monthly_revenue) OVER (
        ORDER BY [Year], [Month]
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_revenue
FROM monthly_revenue
ORDER BY [Year], [Month];