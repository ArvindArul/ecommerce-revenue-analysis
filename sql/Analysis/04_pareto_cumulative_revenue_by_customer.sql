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
        ROW_NUMBER() OVER (ORDER BY total_revenue DESC) AS rn,
        SUM(total_revenue) OVER (
            ORDER BY total_revenue DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS cumulative_revenue,
        SUM(total_revenue) OVER () AS company_revenue
    FROM customer_revenue
)
SELECT
    CustomerID,
    total_revenue,
    rn,
    cumulative_revenue * 1.0 / company_revenue AS cumulative_pct
FROM ranked
ORDER BY total_revenue DESC;