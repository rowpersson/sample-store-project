-- This model summarizes total order information by user/customer
SELECT
    u.user_first_name,
    u.user_last_name
    u.user_email,
    COUNT(c.order_id) AS total_orders,
    SUM(c.product_quantity) AS total_products
FROM {{ ref('stg_user') }} u
JOIN {{ ref('stg_carts') }} c
    ON c.user_id = o.user_id
GROUP BY u.user_first_name, u.user_last_name, u.user_email
