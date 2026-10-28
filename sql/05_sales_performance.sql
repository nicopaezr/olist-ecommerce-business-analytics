-- =====================================================
-- 05: SQL ANALYSIS
-- Project: Olist E-Commerce Business Analytics
-- =====================================================

-- 1. SALES REVENUE AND PERFORMANCE

-- How many orders have recorded items and were delivered?
-- What is the total product sales, freight, and combined value?
-- What is the average order value with and without freight?
SELECT 
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(i.price) AS total_product_sales,
    SUM(i.freight_value) AS total_freight,
    SUM(i.price + i.freight_value) AS total_sales_including_freight,
    SUM(i.price) / COUNT(DISTINCT o.order_id) AS average_product_value_per_order,
    SUM(i.price + i.freight_value) / COUNT(DISTINCT o.order_id) AS average_order_value_including_freight
FROM orders o
JOIN order_items i 
    ON o.order_id = i.order_id
WHERE o.order_status = 'delivered';
-- RESULTS:
-- Delivered orders with item records: 96,478
-- Total product sales: R$13,221,498.11
-- Total freight: R$2,198,275.64
-- Total sales including freight: R$15,419,773.75
-- Average product value per order: R$137.04
-- Average order value including freight: R$159.83

-- How do monthly product sales and delivered order volume change over time?
SELECT 
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS year_and_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(i.price) AS total_sales
FROM
    orders o
        JOIN
    order_items i ON o.order_id = i.order_id
WHERE
    o.order_status = 'delivered'
GROUP BY year_and_month
ORDER BY year_and_month;
-- RESULTS:
-- Highest monthly product sales: November 2017 (R$987,765.37)
-- Highest monthly delivered order volume: November 2017 (7,289 orders)
-- Sales and order volume grew substantially from early 2017 into 2018

-- Which product categories generate the highest product sales and appear in the greatest number of delivered orders?
SELECT 
    t.product_category_name_english AS product_category,
    p.product_category_name AS original_category_name,
    COUNT(DISTINCT o.order_id) AS total_category_orders,
    SUM(i.price) AS total_category_sales
FROM orders o
JOIN order_items i
	ON o.order_id = i.order_id
JOIN products p
	ON i.product_id = p.product_id
LEFT JOIN translation t
	ON p.product_category_name = t.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY t.product_category_name_english, p.product_category_name
ORDER BY total_category_sales DESC 
LIMIT 10;
-- RESULTS:
-- Health & Beauty leads sales among the top 10 categories, generating approximately R$1.23 million.
-- Bed, Bath & Table has the most orders among the high-sales categories, with 9,272, but generates less sales than Health & Beauty and Watches & Gifts.
-- Watches & Gifts generates high sales with fewer orders than Bed, Bath & Table.

-- Which states generate the highest product sales and have the most delivered orders?
SELECT 
	c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(i.price) AS total_product_sales
FROM orders o
JOIN order_items i 
	ON o.order_id = i.order_id
JOIN customers c
	ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY total_product_sales DESC
LIMIT 10;
-- RESULTS:
-- Sao Paulo (SP) is the state with the highest product sales with R$5,067,633.16.
-- Sao Paulo (SP) has 40,501 delivered orders, far more than any other state.
-- Rio de Janeiro (RJ) ranked second, with R$1,759,651.13.
-- Minas Gerais (MG) ranked third, with R$1,552,481.83.

-- Which payment methods are most commonly used, and which account for the highest total payment value?
SELECT 
	p.payment_type,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(p.payment_value) AS total_payment_value
FROM orders o
JOIN payments p
	ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
GROUP BY p.payment_type
ORDER BY total_orders DESC;
-- RESULTS:
-- The most commonly used payment type is credit card, associated with
-- 74,304 delivered orders and R$12,101,094.88 in total payment value.
-- The least commonly used payment type is debit card, associated with
-- 1,485 delivered orders and R$208,421.12 in total payment value.









