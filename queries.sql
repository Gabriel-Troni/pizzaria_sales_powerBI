-- KPI
SELECT 	SUM(quantity*unit_price) AS total_revenue FROM orders

SELECT 	SUM(quantity*unit_price)/COUNT(DISTINCT order_id) AS avg_order_price FROM orders

SELECT 	SUM(quantity) AS total_pizzas_sold FROM orders

SELECT 	COUNT(DISTINCT order_id) AS total_orders FROM orders

SELECT	CAST(SUM(quantity) AS DECIMAL(10, 2)) /
		CAST(COUNT(DISTINCT order_id) AS DECIMAL(10, 2)) AS avg_pizzas_per_order FROM orders

-- Charts for page 1
SELECT      DATENAME(dw, order_date) AS [weekday], 
            COUNT(DISTINCT order_id) AS total_orders
FROM        orders 
GROUP BY    DATENAME(dw, order_date)

SELECT 		DATENAME(m, order_date) AS [month], 
			COUNT(DISTINCT order_id) AS total_orders
FROM 		orders 
GROUP BY 	DATENAME(m, order_date)

DECLARE 	@total_pizzas_sold INT = (
	SELECT 	CAST(SUM(quantity) AS DECIMAL(10, 2)) AS total_pizzas_sold 
	FROM	orders
	WHERE 	MONTH(order_date) = 1
)
SELECT		pizza_category AS categories,
			SUM(quantity*orders.unit_price) AS total_revenue_per_category,
			(CAST(SUM(quantity) AS DECIMAL(10, 2))/@total_pizzas_sold)*100 AS pizzas_percentage
FROM		orders 
			INNER JOIN pizzas 
				ON pizzas.pizza_name_id = orders.pizza_name_id
WHERE		MONTH(order_date) = 1
GROUP BY	pizza_category

DECLARE 	@total_pizzas_sold INT = (
	SELECT CAST(SUM(quantity) AS DECIMAL(10, 2)) AS total_pizzas_sold 
	FROM	orders
	WHERE MONTH(order_date) = 1
)
SELECT		pizza_size AS sizes,
			SUM(quantity*orders.unit_price) AS total_revenue_per_size,
			(CAST(SUM(quantity) AS DECIMAL(10, 2))/@total_pizzas_sold)*100 AS pizzas_percentage
FROM		orders 
			INNER JOIN pizzas 
				ON pizzas.pizza_name_id = orders.pizza_name_id
WHERE		MONTH(order_date) = 1
GROUP BY	pizza_size

-- Charts for page 2
SELECT 		TOP 5 
			pizza_name AS pizza, 
			SUM(quantity*orders.unit_price) AS total_revenue 
FROM 		orders 
			INNER JOIN pizzas 
				ON pizzas.pizza_name_id = orders.pizza_name_id
GROUP BY 	pizza_name
ORDER BY 	SUM(quantity*orders.unit_price) DESC

SELECT 		TOP 5 
			pizza_name AS pizza, 
			SUM(quantity) AS total_sold
FROM 		orders 
			INNER JOIN pizzas 
				ON pizzas.pizza_name_id = orders.pizza_name_id
GROUP BY 	pizza_name
ORDER BY 	SUM(quantity) DESC

SELECT 		TOP 5 
			pizza_name AS pizza, 
			COUNT(DISTINCT order_id) AS total_orders
FROM 		orders 
			INNER JOIN pizzas 
				ON pizzas.pizza_name_id = orders.pizza_name_id
GROUP BY 	pizza_name
ORDER BY 	COUNT(DISTINCT order_id) DESC

SELECT 		TOP 5 
			pizza_name AS pizza, 
			SUM(quantity*orders.unit_price) AS total_revenue 
FROM 		orders 
			INNER JOIN pizzas 
				ON pizzas.pizza_name_id = orders.pizza_name_id
GROUP BY 	pizza_name
ORDER BY 	SUM(quantity*orders.unit_price)

SELECT 		TOP 5 
			pizza_name AS pizza, 
			SUM(quantity) AS total_sold
FROM 		orders 
			INNER JOIN pizzas 
				ON pizzas.pizza_name_id = orders.pizza_name_id
GROUP BY 	pizza_name
ORDER BY 	SUM(quantity)

SELECT 		TOP 5 
			pizza_name AS pizza, 
			COUNT(DISTINCT order_id) AS total_orders
FROM 		orders 
			INNER JOIN pizzas 
				ON pizzas.pizza_name_id = orders.pizza_name_id
GROUP BY 	pizza_name
ORDER BY 	COUNT(DISTINCT order_id)