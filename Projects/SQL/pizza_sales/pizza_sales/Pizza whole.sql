-- Join relevant tables to find the category-wise distribution of pizzas.

select category, count(name) from pizza_types
group by category;


-- Group the orders by date and calculate the average number of pizzas ordered per day.


select round(avg(total_quantity), 2) from
(select order_date, sum(quantity) as total_quantity from 
orders as t1 join order_details as t2
on t1.order_id =  t2.order_id 
group by order_date) as order_quantity;


-- Determine the top 3 most ordered pizza types based on revenue.

select t1.name, sum(t2.price*t3.quantity) as Total_Revenue from pizza_types as t1 
join pizzas as t2
join order_details as t3
on t1.pizza_type_id = t2.pizza_type_id and
t2.pizza_id = t3.pizza_id
group by t1.name
order by sum(t2.price*t3.quantity) desc
limit 3;



-- Calculate the percentage contribution of each pizza type to total revenue.


select name, round((revenue/Total_Revenue)*100) as percentage_revenue
from
(select t1.name, sum(t2.price*t3.quantity) as revenue, sum(sum(t2.price*t3.quantity)) over() as Total_Revenue
from pizza_types as t1 
join pizzas as t2
join order_details as t3
on t1.pizza_type_id = t2.pizza_type_id and
t2.pizza_id = t3.pizza_id
group by t1.name) as a;



-- Analyze the cumulative revenue generated over time.

select order_date, sum(Total_Revenue) over (order by order_date) as cum_revenue from ( 
select t1.order_date, sum(t2.price*t3.quantity) as Total_Revenue from orders as t1 
join pizzas as t2
join order_details as t3
on t1.order_id = t3.order_id and
t2.pizza_id = t3.pizza_id
group by t1.order_date
order by order_date)as sales;


-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

select category, name, revenue 
from
(select category, name, revenue,
rank() over(partition by category order by revenue desc) as rn
from
(select t1.category, t1.name, sum(t2.price*t3.quantity) as revenue from pizza_types as t1 
join pizzas as t2
join order_details as t3
on t1.pizza_type_id = t2.pizza_type_id and
t2.pizza_id = t3.pizza_id
group by t1.category, t1.name) as a) as b
where rn <=3;