WITH stg_products AS (
    SELECT * 
    FROM {{ source('store_schema', 'products') }}
)
SELECT
    id AS product_id,
    title AS product_name,
    description AS product_description,
    price AS product_price,
    category AS product_category,
    image AS product_image,
    rating.count AS product_rating_count,
    rating.rate AS overall_product_rating
FROM stg_products
