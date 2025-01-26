WITH stg_carts AS (
    SELECT * 
    FROM {{ source('store_schema', 'carts') }}
)
SELECT
    id AS order_id,
    userId AS user_id,
    date AS transaction_date,
    product.productId AS product_id,
    product.quantity AS product_quantity,
    __v AS version
FROM stg_carts,
UNNEST(products) AS product
