---------- NOT NULL CHECKS ----------
-- Ensure no nulls in user_id
SELECT user_id
FROM {{ ref('stg_users') }}
WHERE user_id IS NULL;

-- Ensure no nulls in email
SELECT user_email
FROM {{ ref('stg_users') }}
WHERE email IS NULL;

-- Ensure no nulls in username
SELECT login_username
FROM {{ ref('stg_users') }}
WHERE username IS NULL;

-- Ensure no nulls in user_first_name
SELECT user_first_name
FROM {{ ref('stg_users') }}
WHERE user_first_name IS NULL;

-- Ensure no nulls in user_last_name
SELECT user_last_name
FROM {{ ref('stg_users') }}
WHERE user_last_name IS NULL;

---------- UNIQUENESS CHECK ----------
-- Ensure user_id is unique
SELECT user_id, COUNT(*)
FROM {{ ref('stg_users') }}
GROUP BY user_id
HAVING COUNT(*) > 1;

---------- VALIDITY CHECKS ----------
-- Ensure email follows a valid format (basic regex)
SELECT user_id, email
FROM {{ ref('stg_users') }}
WHERE NOT REGEXP_CONTAINS(email, r'^[\w\.-]+@[\w\.-]+\.\w+$');

-- Ensure phone is not null or empty
SELECT user_id, phone
FROM {{ ref('stg_users') }}
WHERE phone IS NULL OR phone = '';

-- Optionally, ensure phone follows a valid format (example for US format)
SELECT user_id, phone
FROM {{ ref('stg_users') }}
WHERE NOT REGEXP_CONTAINS(phone, r'^\+?(\d{1,3})?[-.\s]?(\d{1,4})[-.\s]?(\d{1,4})[-.\s]?(\d{1,4})$');

