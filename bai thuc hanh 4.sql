select
  c.customer_name as customer_name,
  o.order_date as order_date,
  o.total_amount as total_amount
from orders o
join customers c on c.customer_id = o.customer_id
order by o.order_date, o.order_id;

select
  sum(o.total_amount) as total_revenue,
  avg(o.total_amount) as avg_order_value,
  max(o.total_amount) as max_order_value,
  min(o.total_amount) as min_order_value,
  count(o.order_id) as order_count
from orders o;

select
  c.city as city,
  sum(o.total_amount) as total_revenue
from customers c
join orders o on o.customer_id = c.customer_id
group by c.city
having sum(o.total_amount) > 10000
order by total_revenue desc;

select
  c.customer_name as customer_name,
  o.order_date as order_date,
  oi.product_name as product_name,
  oi.quantity as quantity,
  oi.price as price
from customers c
join orders o on o.customer_id = c.customer_id
join order_items oi on oi.order_id = o.order_id
order by o.order_date, c.customer_name, oi.product_name;

select
  c.customer_name as customer_name,
  t.total_revenue as total_revenue
from (
  select
    o.customer_id,
    sum(o.total_amount) as total_revenue
  from orders o
  group by o.customer_id
) t
join customers c on c.customer_id = t.customer_id
where t.total_revenue = (
  select max(x.total_revenue)
  from (
    select sum(o.total_amount) as total_revenue
    from orders o
    group by o.customer_id
  ) x
);

select city
from customers
union
select c.city
from orders o
join customers c on c.customer_id = o.customer_id;

select city
from customers
intersect
select c.city
from orders o
join customers c on c.customer_id = o.customer_id;
