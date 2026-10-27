-- =====================================================
-- 04: DATA VALIDATION
-- Project: Olist E-Commerce Business Analytics
-- =====================================================
USE olist_ecommerce;

-- ORDERS TABLE
-- 1. Validate row counts and unique order IDs
SELECT
COUNT(*) AS total_rows,
COUNT(DISTINCT order_id) AS unique_order_ids
FROM orders_raw;

SELECT
COUNT(*) AS total_rows,
COUNT(DISTINCT order_id) AS unique_order_ids
FROM orders;
-- 2. Check missing timestamps
SELECT
    SUM(order_purchase_timestamp = '') AS blank_purchase_dates,
    SUM(order_approved_at = '') AS blank_approval_dates,
    SUM(order_delivered_carrier_date = '') AS blank_carrier_dates,
    SUM(order_delivered_customer_date = '') AS blank_delivery_dates,
    SUM(order_estimated_delivery_date = ' ') AS blanck_estimated_dates
FROM orders_raw;

SELECT
    SUM(order_purchase_timestamp IS NULL) AS blank_purchase_dates,
    SUM(order_approved_at IS NULL) AS blank_approval_dates,
    SUM(order_delivered_carrier_date IS NULL) AS blank_carrier_dates,
    SUM(order_delivered_customer_date IS NULL) AS blank_delivery_dates,
    SUM(order_estimated_delivery_date IS NULL) AS blanck_estimated_dates
FROM orders;

-- 3. Check order status distribution
SELECT
order_status,
COUNT(*) AS number_of_orders
FROM orders
GROUP BY order_status
ORDER BY number_of_orders DESC;

-- CUSTOMERS TABLE
-- 1. Validate row counts and unique customer IDs
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_id) AS unique_customer_ids,
    COUNT(DISTINCT customer_unique_id) AS unique_customerS
FROM customers_raw;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_id) AS unique_customer_ids,
    COUNT(DISTINCT customer_unique_id) AS unique_customers
FROM customers;

-- 2. Check missing values
SELECT
    SUM(TRIM(customer_id) = '') AS missing_customer_id,
    SUM(TRIM(customer_unique_id) = '') AS missing_unique_id,
    SUM(TRIM(customer_zip_code_prefix) = '') AS missing_zip_code,
    SUM(TRIM(customer_city) = '') AS missing_city,
    SUM(TRIM(customer_state) = '') AS missing_state
FROM customers_raw;

-- PRODUCTS TABLE
-- 1. Validate row counts and unique product IDs
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT product_id) AS unique_product_ids
FROM products_raw;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT product_id) AS unique_product_ids
FROM products;

-- 2. Check missing values
SELECT
    SUM(TRIM(product_id) = '') AS missing_product_id,
    SUM(TRIM(product_category_name) = '') AS missing_category,
    SUM(TRIM(product_name_length) = '') AS missing_name_length,
    SUM(TRIM(product_description_length) = '') AS missing_description_length,
    SUM(TRIM(product_photos_qty) = '') AS missing_photo_count,
    SUM(TRIM(product_weight_g) = '') AS missing_weight,
    SUM(TRIM(product_length_cm) = '') AS missing_length,
    SUM(TRIM(product_height_cm) = '') AS missing_height,
    SUM(TRIM(product_width_cm) = '') AS missing_width
FROM products_raw;

SELECT
    SUM(product_category_name IS NULL) AS missing_category,
    SUM(product_name_length IS NULL) AS missing_name_length,
    SUM(product_description_length IS NULL) AS missing_description_length,
    SUM(product_photos_qty IS NULL) AS missing_photo_count,
    SUM(product_weight_g IS NULL) AS missing_weight,
    SUM(product_length_cm IS NULL) AS missing_length,
    SUM(product_height_cm IS NULL) AS missing_height,
    SUM(product_width_cm IS NULL) AS missing_width
FROM products;

-- SELLERS TABLE
-- 1. Validate row counts and unique seller IDs
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT seller_id) AS unique_seller_ids
FROM sellers_raw;

SELECT
	COUNT(*) AS total_rows,
    COUNT(DISTINCT seller_id) AS unique_seller_ids
FROM sellers;

-- 2. Check missing values
SELECT
    SUM(TRIM(seller_id) = '') AS missing_seller_id,
    SUM(TRIM(seller_zip_code_prefix) = '') AS missing_zip_code,
    SUM(TRIM(seller_city) = '') AS missing_city,
    SUM(TRIM(seller_state) = '') AS missing_state
FROM sellers_raw;

-- PAYMENTS TABLE
-- 1. Check total rows and unique order IDs
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_order_ids
FROM payments_raw;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_order_ids
FROM payments;

-- 2. Check missing values
SELECT
    SUM(TRIM(order_id) = '') AS missing_order_id,
    SUM(TRIM(payment_sequential) = '') AS missing_payment_sequential,
    SUM(TRIM(payment_type) = '') AS missing_payment_type,
    SUM(TRIM(payment_installments) = '') AS missing_payment_installments,
    SUM(TRIM(payment_value) = '') AS missing_payment_value
FROM payments_raw;

-- 3. Check for duplicate payment records
SELECT
    order_id,
    payment_sequential,
    COUNT(*) AS occurrences
FROM payments_raw
GROUP BY
    order_id,
    payment_sequential
HAVING COUNT(*) > 1;

-- ORDER ITEMS TABLE
-- 1. Check row count and unique IDs
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_order_ids,
    COUNT(DISTINCT product_id) AS unique_product_ids,
    COUNT(DISTINCT seller_id) AS unique_seller_ids
FROM order_items_raw;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_order_ids,
    COUNT(DISTINCT product_id) AS unique_product_ids,
    COUNT(DISTINCT seller_id) AS unique_seller_ids
FROM order_items;

-- 2. Check missing values
SELECT
    SUM(TRIM(order_id) = '') AS missing_order_id,
    SUM(TRIM(order_item_id) = '') AS missing_order_item_id,
    SUM(TRIM(product_id) = '') AS missing_product_id,
    SUM(TRIM(seller_id) = '') AS missing_seller_id,
    SUM(TRIM(shipping_limit_date) = '') AS missing_shipping_limit_date,
    SUM(TRIM(price) = '') AS missing_price,
    SUM(TRIM(freight_value) = '') AS missing_freight_value
FROM order_items_raw;

-- 3. Check for duplicate item keys
SELECT
    order_id,
    order_item_id,
    COUNT(*) AS occurrences
FROM order_items_raw
GROUP BY order_id, order_item_id
HAVING COUNT(*) > 1;

-- REVIEWS TABLE
-- 1. Check row count and unique IDs
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT review_id) AS unique_review_ids,
    COUNT(DISTINCT order_id) AS unique_order_ids
FROM reviews_raw;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT review_id) AS unique_review_ids,
    COUNT(DISTINCT order_id) AS unique_order_ids
FROM reviews;

-- 2. Check missing values
SELECT
    SUM(TRIM(review_id) = '') AS missing_review_id,
    SUM(TRIM(order_id) = '') AS missing_order_id,
    SUM(TRIM(review_score) = '') AS missing_review_score,
    SUM(TRIM(review_comment_title) = '') AS missing_comment_title,
    SUM(TRIM(review_comment_message) = '') AS missing_comment_message,
    SUM(TRIM(review_creation_date) = '') AS missing_creation_date,
    SUM(TRIM(review_answer_timestamp) = '') AS missing_answer_timestamp
FROM reviews_raw;

SELECT
    SUM(review_comment_title IS NULL) AS missing_comment_title,
    SUM(review_comment_message IS NULL) AS missing_comment_message
FROM reviews;

-- 3. Check for duplicate review keys
SELECT
    review_id,
    order_id,
    COUNT(*) AS occurrences
FROM reviews_raw
GROUP BY review_id, order_id
HAVING COUNT(*) > 1;

-- TRANSLATION TABLE
-- 1. Check total rows and distinct category names
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT product_category_name) AS unique_portuguese_categories,
    COUNT(DISTINCT product_category_name_english) AS unique_english_categories
FROM translation_raw;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT product_category_name) AS unique_portuguese_categories,
    COUNT(DISTINCT product_category_name_english) AS unique_english_categories
FROM translation;

-- 2. Check missing values
SELECT
    SUM(TRIM(product_category_name) = '') AS missing_portuguese_category,
    SUM(TRIM(product_category_name_english) = '') AS missing_english_category
FROM translation_raw;

-- 3. Check maximum category name lengths
SELECT 
	MAX(LENGTH(product_category_name)) AS max_portuguese_category,
	MAX(LENGTH(product_category_name_english)) AS max_english_category
FROM translation_raw;

SELECT 
	MAX(LENGTH(product_category_name)) AS max_portuguese_category,
	MAX(LENGTH(product_category_name_english)) AS max_english_category
FROM translation;



