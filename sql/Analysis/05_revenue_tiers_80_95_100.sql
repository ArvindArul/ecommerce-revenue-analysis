WITH customer_revenue AS (
    SELECT
        CustomerID,
        SUM(Revenue) AS total_revenue
    FROM dbo.online_retail
    GROUP BY CustomerID
),
ranked AS (
    SELECT
        CustomerID,
        total_revenue,
        SUM(total_revenue) OVER (
            ORDER BY total_revenue DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) * 1.0 / SUM(total_revenue) OVER () AS cumulative_pct
    FROM customer_revenue
)
SELECT
    CustomerID,
    total_revenue,
    cumulative_pct,
    CASE
        WHEN cumulative_pct <= 0.80 THEN 'Tier A'
        WHEN cumulative_pct <= 0.95 THEN 'Tier B'
        ELSE 'Tier C'
    END AS revenue_tier
FROM ranked
ORDER BY total_revenue DESC;