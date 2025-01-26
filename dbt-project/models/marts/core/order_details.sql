-- This model surfaces information about the orders
WITH order_data AS (
    SELECT
        c.order_id,
        c.user_id,
        c.product_id,
        c.product_quantity,
        c.transaction_date,
        p.product_name,
        p.product_price
    FROM {{ ref('stg_carts') }} c
    JOIN {{ ref('stg_products') }} p
        ON o.product_id = p.product_id
)
SELECT * FROM order_data
