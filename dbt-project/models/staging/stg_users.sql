WITH stg_users AS (
    SELECT * 
    FROM {{ source('store_schema', 'users') }}
)
SELECT
    address.city AS user_city_address,
    address.geolocation.lat AS user_address_latitude,
    address.gelocation.long AS user_address_longitude,
    address.number AS user_address_number,
    address.street AS user_address_street,
    address.zipcode AS user_address_zip,
    id AS user_id,
    email AS user_email,
    username AS login_username,
    password AS login_password,
    name.firstname AS user_first_name,
    name.lastname AS user_last_name,
    phone AS user_phone,
    __v AS version
FROM stg_users
