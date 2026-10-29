-- =====================================================
-- 06: DELIVERY AND OPERATIONAL EFFICIENCY
-- Project: Olist E-Commerce Business Analytics
-- =====================================================

-- What percentage of delivered orders arrived later than their estimated delivery dates?
SELECT 
	COUNT(DISTINCT order_id) AS total_delivered_orders,
    SUM(
    CASE 
		WHEN order_estimated_delivery_date < order_delivered_customer_date THEN 1
        ELSE 0
	END) AS late_deliveries,
    SUM(
        CASE
            WHEN order_delivered_customer_date IS NOT NULL
				AND order_estimated_delivery_date IS NOT NULL THEN 1
            ELSE 0
        END
    ) AS orders_with_valid_dates,
    ROUND(
        100.0 * SUM(
            CASE 
                WHEN order_estimated_delivery_date < order_delivered_customer_date THEN 1
                ELSE 0
            END
		) / SUM(
				CASE
                    WHEN order_delivered_customer_date IS NOT NULL
                         AND order_estimated_delivery_date IS NOT NULL THEN 1
                    ELSE 0
                END
            ), 2) AS late_delivery_percentage
FROM orders 
WHERE order_status = 'delivered';
-- RESULTS: 
-- Of the 96,470 delivered orders with valid delivery dates,
-- 7,826 (8.11%) arrived after their estimated delivery dates.

-- What is the average delivery time for delivered orders, measured in days?
SELECT 
	COUNT(DISTINCT order_id) AS total_valid_delivered_orders,
	ROUND(
		AVG(
			DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)
	), 2) AS average_delivery_time_days
FROM orders
WHERE order_status = 'delivered'
AND order_delivered_customer_date IS NOT NULL;
-- RESULTS
-- The average time from purchase to customer delivery is 12.50 days.

-- How does delivery performance vary across states?
SELECT 
	c.customer_state,
	ROUND(AVG(
		DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp)
    ), 2) AS average_delivery_time_days,
    ROUND(
		100.0 * SUM(
			CASE 
				WHEN o.order_estimated_delivery_date < o.order_delivered_customer_date THEN 1
				ELSE 0
			END) / COUNT(*), 2) AS late_delivery_percentage
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
	AND o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY average_delivery_time_days DESC;
-- RESULTS:
-- Roraima (RR) had the longest average delivery time at 29.34 days, 
-- followed by Amapa (AP) at 27.18 days.
-- Sao Paulo (SP) had the shortest average delivery time at 8.70 days.
-- Alagoas (AL) had the highest late delivery percentage at 23.93%,
-- followed by Maranhao (MA) at 19.67%.
-- Longer average delivery times did not always correspond to higher
-- late delivery percentages. For instance, Amazonas (AM) had one of the 
-- longest average delivery times at 26.36 days, yet only 4.14% of delivered 
-- orders arrived after their estimated delivery dates.

-- How long does it take for an order to be handed over to the carrier after purchase?
SELECT 
	COUNT(DISTINCT order_id) AS total_valid_delivered_orders,
	ROUND(
		AVG(
			DATEDIFF(order_delivered_carrier_date, order_purchase_timestamp)
	), 2) AS average_days_to_carrier
FROM orders
WHERE order_status = 'delivered'
AND order_purchase_timestamp IS NOT NULL
AND order_delivered_carrier_date IS NOT NULL
AND order_delivered_carrier_date >= order_purchase_timestamp;
-- RESULTS: 
-- Average time from purchase to carrier handoff: 3.22 days.
-- DATA QUALITY NOTE:
-- Excluded 165 delivered orders where carrier handoff
-- timestamps occurred before purchase timestamps.

