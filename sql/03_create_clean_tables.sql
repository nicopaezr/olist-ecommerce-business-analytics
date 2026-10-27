-- =====================================================
-- 03: CREATE CLEAN TABLES
-- Project: Olist E-Commerce Business Analytics
-- =====================================================
USE olist_ecommerce;

-- Create the analysis-ready ORDERS table
CREATE TABLE orders (
    order_id VARCHAR(40) NOT NULL PRIMARY KEY,
    customer_id VARCHAR(40),
    order_status VARCHAR(30),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME
);
-- Convert timestamp strings to DATETIME
-- Convert blank timestamps to NULL
INSERT INTO orders (
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date
)
SELECT
    order_id,
    customer_id,
    order_status,
    STR_TO_DATE(order_purchase_timestamp, '%Y-%m-%d %H:%i:%s'),
    STR_TO_DATE(NULLIF(order_approved_at, ''), '%Y-%m-%d %H:%i:%s'),
    STR_TO_DATE(NULLIF(order_delivered_carrier_date, ''), '%Y-%m-%d %H:%i:%s'),
    STR_TO_DATE(NULLIF(order_delivered_customer_date, ''), '%Y-%m-%d %H:%i:%s'),
    STR_TO_DATE(order_estimated_delivery_date, '%Y-%m-%d %H:%i:%s')
FROM orders_raw;

-- Create the analysis-ready CUSTOMERS table
CREATE TABLE customers (
	customer_id VARCHAR(40) NOT NULL PRIMARY KEY,
	customer_unique_id VARCHAR(40),
	customer_zip_code_prefix VARCHAR(10),
	customer_city VARCHAR(100),
	customer_state CHAR(2)
);
INSERT INTO customers (
	customer_id,
	customer_unique_id,
	customer_zip_code_prefix,
	customer_city,
	customer_state
)
SELECT 
	TRIM(customer_id),
	TRIM(customer_unique_id),
	TRIM(customer_zip_code_prefix),
	TRIM(customer_city),
	TRIM(customer_state)
FROM customers_raw;

-- Create the analysis-ready PRODUCTS table
CREATE TABLE products (
	product_id VARCHAR(40) NOT NULL PRIMARY KEY,
	product_category_name VARCHAR(100),
	product_name_length INT,
	product_description_length INT,
	product_photos_qty INT,
	product_weight_g INT,
	product_length_cm INT,
	product_height_cm INT,
	product_width_cm INT
);
-- Convert blank strings to NULL and cast numeric columns
INSERT INTO products (
	product_id, 
	product_category_name,
	product_name_length,
	product_description_length,
	product_photos_qty,
	product_weight_g,
	product_length_cm,
	product_height_cm,
	product_width_cm
)
SELECT 
	product_id,
	NULLIF(TRIM(product_category_name), ''),
	CAST(NULLIF(TRIM(product_name_length), '') AS UNSIGNED),
	CAST(NULLIF(TRIM(product_description_length), '') AS UNSIGNED),
	CAST(NULLIF(TRIM(product_photos_qty), '') AS UNSIGNED),
	CAST(NULLIF(TRIM(product_weight_g), '') AS UNSIGNED),
	CAST(NULLIF(TRIM(product_length_cm), '') AS UNSIGNED),
	CAST(NULLIF(TRIM(product_height_cm), '') AS UNSIGNED),
	CAST(NULLIF(TRIM(product_width_cm), '') AS UNSIGNED)
FROM products_raw;

-- Create the analysis-ready SELLERS table
CREATE TABLE sellers (
    seller_id VARCHAR(40) NOT NULL PRIMARY KEY,
    seller_zip_code_prefix VARCHAR(10),
    seller_city VARCHAR(100),
    seller_state CHAR(2)
);
INSERT INTO sellers (
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
)
SELECT
    TRIM(seller_id),
    TRIM(seller_zip_code_prefix),
    TRIM(seller_city),
    TRIM(seller_state)
FROM sellers_raw;

-- Create the analysis-ready PAYMENTS table
CREATE TABLE payments (
    order_id VARCHAR(40) NOT NULL,
    payment_sequential INT NOT NULL,
    payment_type VARCHAR(30),
    payment_installments INT,
    payment_value DECIMAL(10,2),
    PRIMARY KEY (order_id, payment_sequential)
);
INSERT INTO payments (
	order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value
)
SELECT 
    TRIM(order_id),
    CAST(TRIM(payment_sequential) AS UNSIGNED),
    TRIM(payment_type),
    CAST(TRIM(payment_installments) AS UNSIGNED),
    CAST(TRIM(payment_value) AS DECIMAL(10,2))
FROM payments_raw;

-- Create the analysis-ready ORDER_ITEMS table
CREATE TABLE order_items (
	order_id VARCHAR(40) NOT NULL,
    order_item_id INT NOT NULL,
    product_id VARCHAR(40),
    seller_id VARCHAR(40),
    shipping_limit_date DATETIME,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2),
    PRIMARY KEY (order_id, order_item_id)
);
INSERT INTO order_items (
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value
)
SELECT
    TRIM(order_id),
    CAST(TRIM(order_item_id) AS UNSIGNED),
    TRIM(product_id),
    TRIM(seller_id),
    STR_TO_DATE(TRIM(shipping_limit_date), '%Y-%m-%d %H:%i:%s'),
    CAST(TRIM(price) AS DECIMAL(10,2)),
    CAST(TRIM(freight_value) AS DECIMAL(10,2))
FROM order_items_raw;

-- Create the analysis-ready REVIEWS table
CREATE TABLE reviews (
    review_id VARCHAR(40) NOT NULL,
    order_id VARCHAR(40) NOT NULL,
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date DATETIME,
    review_answer_timestamp DATETIME,
    PRIMARY KEY (review_id, order_id)
);
INSERT INTO reviews (
	review_id,
	order_id,
	review_score,
	review_comment_title,
	review_comment_message,
	review_creation_date,
	review_answer_timestamp
)
SELECT 
	TRIM(review_id), 
	TRIM(order_id),
	CAST(TRIM(review_score) AS UNSIGNED),
	NULLIF(TRIM(review_comment_title), ''),
	NULLIF(TRIM(review_comment_message), ''),
	STR_TO_DATE(TRIM(review_creation_date), '%Y-%m-%d %H:%i:%s'),
	STR_TO_DATE(TRIM(review_answer_timestamp), '%Y-%m-%d %H:%i:%s')
FROM reviews_raw;

-- Create the analysis-ready TRANSLATION table
CREATE TABLE translation (
	product_category_name VARCHAR(50) NOT NULL PRIMARY KEY,
	product_category_name_english VARCHAR(50) NOT NULL
);
INSERT INTO translation (
	product_category_name, 
	product_category_name_english
)
SELECT 
	TRIM(product_category_name), 
	TRIM(product_category_name_english)
FROM translation_raw;



