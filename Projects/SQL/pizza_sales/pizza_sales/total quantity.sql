-- Join the necessary tables to find the total quantity of each pizza category ordered.

select t1.category, sum(t3.quantity) from pizza_types as t1 
join pizzas as t2
join order_details as t3
on t1.pizza_type_id = t2.pizza_type_id and
t2.pizza_id = t3.pizza_id
group by t1.category
order by sum(t3.quantity) desc;