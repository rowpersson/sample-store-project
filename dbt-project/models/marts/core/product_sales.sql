-- This model summarizes the total amount of product sales
SELECT
    p.product_name,
    p.product_id,
    COUNT(c.product_id) AS total_product_units,
    SUM(p.product_price) AS total_revenue
FROM {{ ref('stg_products') }} p
JOIN {{ ref('stg_carts') }} c
    ON p.product_id = c.product_id
GROUP BY p.product_name, p.product_id
