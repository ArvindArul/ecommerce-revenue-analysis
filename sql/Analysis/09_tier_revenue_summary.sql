select revenue_tier, sum(total_revenue) as revenue, count(CustomerID) as customers,avg(total_revenue) as avg_customer_revenue,
SUM(total_revenue) * 1.0 /
        SUM(SUM(total_revenue)) OVER () AS revenue_share
from customer_revenue_tier
group by revenue_tier
order by revenue_tier