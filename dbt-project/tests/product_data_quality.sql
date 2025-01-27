---------- NOT NULL CHECKS ---------- 
-- Ensure no nulls in product_id
SELECT product_id
FROM {{ ref('stg_products') }}
WHERE product_id IS NULL;

-- Ensure no nulls in product_name
SELECT product_name
FROM {{ ref('stg_products') }}
WHERE product_name IS NULL;

-- Ensure no nulls in product_price
SELECT product_price
FROM {{ ref('stg_products') }}
WHERE product_price IS NULL;

-- Ensure no nulls in product_category
SELECT product_category
FROM {{ ref('stg_products') }}
WHERE product_category IS NULL;


---------- POSITIVE VALUE CHECKS ---------- 
-- Ensure product_price is positive
SELECT product_price
FROM {{ ref('stg_products') }}
WHERE product_price <= 0;

