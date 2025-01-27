---------- NOT NULL CHECKS ----------
-- Ensure no nulls in order_id
SELECT order_id
FROM {{ ref('stg_carts') }}
WHERE order_id IS NULL;

-- Ensure no nulls in user_id
SELECT user_id
FROM {{ ref('stg_carts') }}
WHERE user_id IS NULL;

-- Ensure no nulls in transaction_date
SELECT transaction_date
FROM {{ ref('stg_carts') }}
WHERE transaction_date IS NULL;

-- Ensure no nulls in product_id
SELECT product_id
FROM {{ ref('stg_carts') }}
WHERE product_id IS NULL;

-- Ensure no nulls in product_quantity
SELECT product_quantity
FROM {{ ref('stg_carts') }}
WHERE product_quantity IS NULL;

---------- UNIQUENESS CHECK ----------
-- Ensure order_id is unique across the dataset
SELECT order_id, COUNT(*)
FROM {{ ref('stg_carts') }}
GROUP BY order_id
HAVING COUNT(*) > 1;

---------- POSITIVE VALUE CHECK ----------
-- Ensure product_quantity is positive
SELECT order_id, product_id, product_quantity
FROM {{ ref('stg_carts') }}
WHERE product_quantity <= 0;

---------- PRODUCT CONSISTENCY ----------
-- Ensure product_id in stg_carts exists in the products table
SELECT product_id
FROM {{ ref('stg_carts') }}
WHERE product_id NOT IN (SELECT product_id FROM {{ ref('stg_products') }});

