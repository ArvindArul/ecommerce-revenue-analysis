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
),
tiered AS (
    SELECT
        CustomerID,
        CASE
            WHEN cumulative_pct <= 0.80 THEN 'Tier A'
            WHEN cumulative_pct <= 0.95 THEN 'Tier B'
            ELSE 'Tier C'
        END AS revenue_tier
    FROM ranked
)
SELECT
    t.revenue_tier,
    COUNT(*) AS customers,
    AVG(r.Recency) AS avg_recency,
    AVG(r.Frequency) AS avg_frequency,
    AVG(r.Monetary) AS avg_monetary
FROM tiered t
JOIN dbo.customer_rfm r
    ON t.CustomerID = r.CustomerID
GROUP BY t.revenue_tier
ORDER BY t.revenue_tier;