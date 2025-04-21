-- Identify the highest-priced pizza.


select name from pizza_types
where pizza_type_id = (select pizza_type_id from pizzas
where price = (select max(price) from pizzas));

