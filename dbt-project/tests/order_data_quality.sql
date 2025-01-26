SELECT
    order_id
FROM {{ ref('stg_carts') }}
WHERE order_id IS NULL
