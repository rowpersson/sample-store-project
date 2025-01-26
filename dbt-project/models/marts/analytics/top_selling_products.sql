-- This sql query gives us an idea of the top selling products
SELECT
    p.product_name,
    COUNT(c.product_id) AS total_sales
FROM {{ ref('stg_products') }} p
JOIN {{ ref('stg_carts') }} c
    ON p.product_id = c.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC
