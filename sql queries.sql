show databases;
use customer;
select * from mytable limit 10;



-- 0. Revenue by Churn Status (Quick Revenue Impact Check)
select
    target_churn,
    COUNT(*) as customer_id,
    ROUND(SUM(total_spend), 2) as total_revenue,
    ROUND(AVG(total_spend), 2) as avg_spend 
from mytable 
GROUP BY target_churn;



-- 0. Age vs Returns vs Churn (Behavioral Pattern)
SELECT 
    Age,
    ROUND(AVG(Num_of_Returns), 2) as avg_returns,
    ROUND(AVG(CASE WHEN Target_Churn = 1 THEN 1.0 ELSE 0.0 END)*100, 2) as churn_rate_pct
FROM mytable 
GROUP BY Age 
ORDER BY churn_rate_pct DESC;



-- 1. Revenue by Churn Status
SELECT 
    target_churn,
    COUNT(*) as customer_count,
    ROUND(SUM(total_spend), 2) as total_revenue,
    ROUND(AVG(total_spend), 2) as avg_spend
FROM mytable 
GROUP BY target_churn;



-- 2. Age vs Returns vs Churn Rate
SELECT 
    age,
    ROUND(AVG(num_of_returns), 2) as avg_returns,
    ROUND(AVG(CASE WHEN target_churn = 1 THEN 1.0 ELSE 0.0 END)*100, 2) as churn_rate_pct
FROM mytable 
GROUP BY age 
ORDER BY churn_rate_pct DESC
LIMIT 10;




-- 3. Top 5 High-Income Churners (Despite High Spend)
WITH avg_spend AS (
    SELECT AVG(total_spend) as overall_avg_spend FROM mytable
)
SELECT 
    customer_id,
    annual_income,
    total_spend,
    target_churn
FROM mytable, avg_spend
WHERE target_churn = 1 
  AND total_spend > overall_avg_spend
ORDER BY annual_income DESC
LIMIT 5;



-- 4. Promotion Response vs Satisfaction/Support
SELECT 
    promotion_response,
    ROUND(AVG(rating), 2) as avg_satisfaction,
    ROUND(AVG(num_of_support_contacts), 2) as avg_support_contacts,
    COUNT(*) as customer_count
FROM mytable 
GROUP BY promotion_response;



-- 5. Inactive Customers (>90 days) Churn Rate by Gender
SELECT 
    gender,
    COUNT(*) as inactive_customers,
    SUM(CASE WHEN target_churn = 1 THEN 1 ELSE 0 END) as churned_inactive,
    ROUND(SUM(CASE WHEN target_churn = 1 THEN 1.0 ELSE 0.0 END)/COUNT(*)*100, 2) as churn_rate_pct
FROM mytable 
WHERE last_purchase_days_ago > 90
GROUP BY gender;



-- 6. Top 3 age groups by Churn Rate
SELECT 
    age_group,
    SUM(CASE WHEN target_churn = 1 THEN 1 ELSE 0 END) as churned_count,
    COUNT(*) as total_customers,
    ROUND(AVG(years_as_customer), 2) as avg_tenure,
    ROUND(SUM(CASE WHEN target_churn = 1 THEN 1.0 ELSE 0.0 END)/COUNT(*)*100, 2) as churn_rate_pct
FROM mytable 
GROUP BY age_group
ORDER BY churn_rate_pct DESC
LIMIT 3;



-- 7. Loyal Customers (>3 years) Spending Patterns
WITH loyal_customers AS (
    SELECT 
        average_transaction_amount,
        total_spend,
        NTILE(3) OVER (ORDER BY average_transaction_amount) as spend_quartile_num
    FROM mytable 
    WHERE years_as_customer > 3 AND target_churn = 0
)
SELECT 
    CASE 
        WHEN spend_quartile_num = 1 THEN 'Low Spend'
        WHEN spend_quartile_num = 2 THEN 'Medium Spend'
        ELSE 'High Spend'
    END as spend_quartile,
    COUNT(*) as loyal_customer_count,
    ROUND(AVG(total_spend), 2) as avg_total_spend
FROM loyal_customers
GROUP BY spend_quartile_num
ORDER BY avg_total_spend DESC;



-- 8. Customer Value Segments by Total Spend
WITH spend_segments AS (
    SELECT 
        total_spend,
        target_churn,
        NTILE(3) OVER (ORDER BY total_spend) as value_segment
    FROM mytable
)
SELECT 
    CASE 
        WHEN value_segment = 1 THEN 'Low Value'
        WHEN value_segment = 2 THEN 'Medium Value'
        ELSE 'High Value'
    END as customer_segment,
    COUNT(*) as customer_count,
    ROUND(SUM(total_spend), 2) as segment_revenue,
    ROUND(AVG(CASE WHEN target_churn = 1 THEN 1.0 ELSE 0.0 END)*100, 2) as churn_rate_pct
FROM spend_segments
GROUP BY value_segment
ORDER BY segment_revenue DESC;



-- 9. High-Purchase Volume Churners vs Non-Churners
WITH avg_purchases AS (
    SELECT AVG(last_year_purchases) as overall_avg_purchases FROM mytable
)
SELECT 
    target_churn,
    COUNT(*) as high_volume_customers,
    ROUND(AVG(num_of_returns), 2) as avg_returns
FROM mytable, avg_purchases
WHERE last_year_purchases > overall_avg_purchases
GROUP BY target_churn
ORDER BY target_churn;



-- 10. Top 10% High Spenders by Age (Churn Risk) - Window Function
WITH spend_rank AS (
    SELECT 
        customer_id,
        age,
        total_spend,
        target_churn,
        ROW_NUMBER() OVER (PARTITION BY age ORDER BY total_spend DESC) as spend_rank,
        COUNT(*) OVER (PARTITION BY age) as age_group_size
    FROM mytable
)
SELECT 
    age,
    customer_id,
    total_spend,
    target_churn,
    spend_rank,
    ROUND(spend_rank*100.0/age_group_size, 1) as percentile
FROM spend_rank
WHERE spend_rank <= age_group_size * 0.1  -- Top 10%
  AND target_churn = 1
ORDER BY age, total_spend DESC;