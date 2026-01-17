
select
  p.product_name,
  t.total_revenue
from (
  select
    product_id,
    sum(total_price) as total_revenue
  from orders
  group by product_id
) t
join products p on p.product_id = t.product_id
where t.total_revenue = (
  select max(x.total_revenue)
  from (
    select sum(total_price) as total_revenue
    from orders
    group by product_id
  ) x
);


select
  p.category,
  sum(o.total_price) as total_revenue
from products p
join orders o on o.product_id = p.product_id
group by p.category
order by total_revenue desc;

select p.category
from (
  select
    product_id,
    sum(total_price) as total_revenue
  from orders
  group by product_id
) t
join products p on p.product_id = t.product_id
where t.total_revenue = (
  select max(x.total_revenue)
  from (
    select sum(total_price) as total_revenue
    from orders
    group by product_id
  ) x
)
intersect
select
  p.category
from products p
join orders o on o.product_id = p.product_id
group by p.category
having sum(o.total_price) > 3000;
