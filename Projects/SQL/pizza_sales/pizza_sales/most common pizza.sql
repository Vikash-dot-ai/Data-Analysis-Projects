-- Identify the most common pizza size ordered.

select t1.size, count(t2.order_id) from pizzas as t1
join order_details as t2 
on t1.pizza_id = t2.pizza_id
group by t1.size
order by count(t2.order_id) desc
limit 1;






