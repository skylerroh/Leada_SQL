USE ProblemSet;
#1
SELECT COUNT(*)
FROM Concession;

SELECT MIN(order_create_time)
FROM Concession;

#alternative solution to earliest order time, taking first row value
#SELECT order_create_time
#FROM Concession
#ORDER BY order_create_time ASC;

SELECT MAX(order_create_time)
FROM Concession;

#2
SELECT SUM(revenue)
FROM Concession;

SELECT category_name, SUM(revenue)
FROM Concession
GROUP BY category_name
ORDER BY SUM(revenue) DESC;

SELECT category_group, SUM(revenue)
FROM Concession
GROUP BY category_group
ORDER BY SUM(revenue) DESC;

#3
SELECT category_group, SUM(revenue)/COUNT(*) as avg_revenue_per_order  #summing total revenue and dividing by number of orders
FROM Concession
GROUP BY category_group 
ORDER BY SUM(revenue) DESC;

SELECT category_name, SUM(revenue)/COUNT(*) as avg_revenue_per_order  #summing total revenue and dividing by number of orders
FROM Concession
GROUP BY category_name
ORDER BY avg_revenue_per_order DESC;

SELECT category_name, SUM(revenue)/SUM(quantity) as avg_revenue_per_item #summing total revenue and dividing by total number of items sold
FROM Concession
GROUP BY category_name
ORDER BY avg_revenue_per_item DESC;