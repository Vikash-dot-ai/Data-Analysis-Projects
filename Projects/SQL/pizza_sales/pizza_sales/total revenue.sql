-- Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM((t1.price) * (t2.quantity)), 2) AS Total_Revenue
FROM
    pizzas AS t1
        INNER JOIN
    order_details AS t2 ON t1.pizza_id = t2.pizza_id;


