-- =====================================================
-- 07: CUSTOMER SATISFACTION
-- Project: Olist E-Commerce Business Analytics
-- =====================================================

-- What is the overall customer satisfaction level based on recorded review scores?
SELECT
	COUNT(*) AS total_review_records,
    ROUND(
		AVG(review_score)
	, 2) AS average_review_score
FROM reviews;
-- RESULTS:
-- Total recorded reviews: 99,224
-- Average recorded review score: 4.09 / 5

-- What is the distribution of customer review scores?
SELECT
	review_score,
	COUNT(*) AS total_recorded_reviews,
    ROUND(
		100.00 * COUNT(*) / 
			(SELECT 
				COUNT(*) FROM reviews)
    , 2) AS percentage_of_total_recorded_reviews
FROM reviews
GROUP BY review_score
ORDER BY total_recorded_reviews DESC;
-- RESULTS:
-- 5-star reviews: 57,328 (57.78%)
-- 4-star reviews: 19,142 (19.29%)
-- 3-star reviews: 8,179 (8.24%)
-- 2-star reviews: 3,151 (3.18%)
-- 1-star reviews: 11,424 (11.51%)

-- Are late deliveries associated with lower customer review scores?
WITH delivery_classification AS (
	SELECT
		r.review_score,
        CASE 
			WHEN o.order_estimated_delivery_date < o.order_delivered_customer_date 
            THEN 'Late'
			ELSE 'On Time'
		END AS delivery_type
	FROM reviews r
	JOIN orders o
		ON r.order_id = o.order_id
	WHERE o.order_status = 'delivered'
		AND o.order_delivered_customer_date IS NOT NULL
)
SELECT 
	delivery_type,
    COUNT(*) AS total_recorded_reviews,
    ROUND(
		AVG(review_score), 2
    ) AS average_review_score
FROM delivery_classification
GROUP BY delivery_type
ORDER BY average_review_score;
-- RESULTS: 
-- Late deliveries: 7,700 recorded reviews - average score = 2.57 / 5
-- On-time deliveries: 88,653 recorded reviews - average score = 4.29 / 5
-- Average review score was 1.72 points lower for late deliveries

-- Which product categories have the lowest average review scores?
WITH order_category_reviews AS (
    SELECT DISTINCT
        r.order_id,
        r.review_score,
        p.product_category_name
    FROM reviews r
    JOIN order_items i
        ON r.order_id = i.order_id
    JOIN products p
        ON i.product_id = p.product_id
    WHERE p.product_category_name IS NOT NULL
)
SELECT
    t.product_category_name_english,
    cte.product_category_name,
    COUNT(*) AS total_reviewed_orders,
    ROUND(
		AVG(cte.review_score), 2
	) AS average_review_score
FROM order_category_reviews cte
LEFT JOIN translation t
    ON t.product_category_name = cte.product_category_name
GROUP BY
    t.product_category_name_english,
    cte.product_category_name
HAVING COUNT(*) >= 100
ORDER BY average_review_score ASC;
-- RESULTS:
-- Office Furniture had the lowest average review score among
-- categories having at least 100 reviewed orders with 3.62 / 5 (1,266 reviewed orders),
-- followed by Fashion Male Clothing with 3.70 / 5 (111 reviewed orders), 
-- Audio with 3.83 / 5 (348 reviewed orders), Construction Tools & Safety with 3.85 / 5 (166 reviewed orders),
-- and Home Comfort with 3.86 / 5 (397 reviewed orders).

-- NOTE: Product categories with fewer than 100 reviewed orders are excluded
-- to reduce the influence of averages based on small sample sizes.
    
