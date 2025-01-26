-- This query gives us an idea of products sold per month
SELECT
    EXTRACT(MONTH FROM c.transaction_date) AS month,
    SUM(p.product_price) AS total_revenue
FROM {{ ref('stg_carts') }} c
JOIN {{ ref('stg_products') }} p
ON c.product_id = c.product_id
GROUP BY month
ORDER BY month
