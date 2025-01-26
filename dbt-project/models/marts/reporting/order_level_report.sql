-- This query gives us an order level report of a customer/user
SELECT
    c.order_id,
    c.user_id,
    c.product_quantity,
    c.transaction_date,
    p.product_name,
    p.product_price
FROM {{ ref('stg_carts') }} c
JOIN {{ ref('stg_products') }} p
    ON c.product_id = p.product_id
ORDER BY c.order_created_at

