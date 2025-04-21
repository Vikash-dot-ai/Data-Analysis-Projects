-- List the top 5 most ordered pizza types along with their quantities.

select t1.name, sum(t3.quantity) from pizza_types as t1 
join pizzas as t2
join order_details as t3
on t1.pizza_type_id = t2.pizza_type_id and
t2.pizza_id = t3.pizza_id
group by t1.name
order by sum(t3.quantity) desc
limit 5;





        

