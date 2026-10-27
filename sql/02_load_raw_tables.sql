-- =====================================================
-- 02: LOAD RAW DATA
-- Project: Olist E-Commerce Business Analytics
-- =====================================================
USE olist_ecommerce;

-- NOTE: Update each file path below to match the location
-- of the CSV files on your local computer

-- olist_orders_dataset.csv TO orders_raw
LOAD DATA LOCAL INFILE
'C:/Users/Nicolas/Documents/olist-ecommerce-business-analytics/data/olist_orders_dataset.csv'
INTO TABLE orders_raw
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- olist_customers_dataset.csv TO customers_raw
LOAD DATA LOCAL INFILE
'C:/Users/Nicolas/Documents/olist-ecommerce-business-analytics/data/olist_customers_dataset.csv'
INTO TABLE customers_raw
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- olist_products_dataset.csv TO products_raw
LOAD DATA LOCAL INFILE
'C:/Users/Nicolas/Documents/olist-ecommerce-business-analytics/data/olist_products_dataset.csv'
INTO TABLE products_raw
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- olist_sellers_dataset.csv TO sellers_raw
LOAD DATA LOCAL INFILE
'C:/Users/Nicolas/Documents/olist-ecommerce-business-analytics/data/olist_sellers_dataset.csv'
INTO TABLE sellers_raw
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- olist_order_payments_dataset.csv TO payments_raw
LOAD DATA LOCAL INFILE
'C:/Users/Nicolas/Documents/olist-ecommerce-business-analytics/data/olist_order_payments_dataset.csv'
INTO TABLE payments_raw
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- olist_order_items_dataset.csv TO order_items_raw
LOAD DATA LOCAL INFILE
'C:/Users/Nicolas/Documents/olist-ecommerce-business-analytics/data/olist_order_items_dataset.csv'
INTO TABLE order_items_raw
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- olist_order_reviews_dataset.csv TO reviews_raw
LOAD DATA LOCAL INFILE
'C:/Users/Nicolas/Documents/olist-ecommerce-business-analytics/data/olist_order_reviews_dataset.csv'
INTO TABLE reviews_raw
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- product_category_name_translation.csv TO translation_raw
LOAD DATA LOCAL INFILE
'C:/Users/Nicolas/Documents/olist-ecommerce-business-analytics/data/product_category_name_translation.csv'
INTO TABLE translation_raw
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;