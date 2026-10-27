-- =====================================================
-- 01: CREATE DATABASE AND RAW TABLES
-- Project: Olist E-Commerce Business Analytics
-- =====================================================
CREATE DATABASE IF NOT EXISTS olist_ecommerce;
USE olist_ecommerce;

-- Create ORDERS_RAW staging table
CREATE TABLE orders_raw (
    order_id TEXT,
    customer_id TEXT,
    order_status TEXT,
    order_purchase_timestamp TEXT,
    order_approved_at TEXT,
    order_delivered_carrier_date TEXT,
    order_delivered_customer_date TEXT,
    order_estimated_delivery_date TEXT
);

-- Create CUSTOMERS_RAW staging table
CREATE TABLE customers_raw (
	customer_id TEXT,
    customer_unique_id TEXT,
    customer_zip_code_prefix TEXT,
	customer_city TEXT,
	customer_state TEXT
);

-- Create PRODUCTS_RAW staging table
CREATE TABLE products_raw (
	product_id TEXT,
	product_category_name TEXT,
	product_name_length TEXT,
	product_description_length TEXT,
	product_photos_qty TEXT,
	product_weight_g TEXT,
	product_length_cm TEXT,
	product_height_cm TEXT,
	product_width_cm TEXT
);

-- Create SELLERS_RAW staging table
CREATE TABLE sellers_raw (
    seller_id TEXT,
    seller_zip_code_prefix TEXT,
    seller_city TEXT,
    seller_state TEXT
);

-- Create PAYMENTS_RAW staging table
CREATE TABLE payments_raw (
	order_id TEXT,
    payment_sequential TEXT,
    payment_type TEXT,
    payment_installments TEXT,
    payment_value TEXT
);

-- Create ORDER_ITEMS_RAW staging table
CREATE TABLE order_items_raw (
    order_id TEXT,
    order_item_id TEXT,
    product_id TEXT,
    seller_id TEXT,
    shipping_limit_date TEXT,
    price TEXT,
    freight_value TEXT
);

-- Create REVIEWS_RAW staging table
CREATE TABLE reviews_raw (
    review_id TEXT,
    order_id TEXT,
    review_score TEXT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TEXT,
    review_answer_timestamp TEXT
);

-- Create TRANSLATION_RAW staging table
CREATE TABLE translation_raw (
	product_category_name TEXT,
	product_category_name_english TEXT
);