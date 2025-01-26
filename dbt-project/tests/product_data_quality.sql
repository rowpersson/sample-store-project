SELECT
    product_id
FROM {{ ref('stg_products') }}
WHERE product_id IS NULL
