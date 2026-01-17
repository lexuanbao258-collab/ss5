create table customers (
  customer_id int primary key,
  customer_name varchar(100),
  city varchar(50)
);

create table orders (
  order_id int primary key,
  customer_id int,
  order_date date,
  total_price numeric,
  foreign key (customer_id) references customers(customer_id)
);

create table order_items (
  item_id int primary key,
  order_id int,
  product_id int,
  quantity int,
  price numeric,
  foreign key (order_id) references orders(order_id)
);

insert into customers (customer_id, customer_name, city) values
(1, 'Nguyễn Văn A', 'Hà Nội'),
(2, 'Trần Thị B', 'Đà Nẵng'),
(3, 'Lê Văn C', 'Hồ Chí Minh'),
(4, 'Phạm Thị D', 'Hà Nội');

insert into orders (order_id, customer_id, order_date, total_price) values
(101, 1, '2024-12-20', 3000),
(102, 2, '2025-01-05', 1500),
(103, 1, '2025-02-10', 2500),
(104, 3, '2025-02-15', 4000),
(105, 4, '2025-03-01', 800);

insert into order_items (item_id, order_id, product_id, quantity, price) values
(1, 101, 1, 2, 1500),
(2, 102, 2, 1, 1500),
(3, 103, 3, 5, 500),
(4, 104, 2, 4, 1000);

select
  c.customer_id,
  c.customer_name,
  sum(o.total_price) as total_revenue,
  count(o.order_id) as order_count
from customers c
join orders o on o.customer_id = c.customer_id
group by c.customer_id, c.customer_name
having sum(o.total_price) > 2000
order by total_revenue desc;

select
  t.customer_id,
  t.customer_name,
  t.total_revenue
from (
  select
    c.customer_id,
    c.customer_name,
    coalesce(sum(o.total_price), 0) as total_revenue
  from customers c
  left join orders o on o.customer_id = c.customer_id
  group by c.customer_id, c.customer_name
) t
where t.total_revenue > (
  select avg(x.total_revenue)
  from (
    select
      c.customer_id,
      coalesce(sum(o.total_price), 0) as total_revenue
    from customers c
    left join orders o on o.customer_id = c.customer_id
    group by c.customer_id
  ) x
)
order by t.total_revenue desc;

select
  c.city,
  sum(o.total_price) as total_revenue
from customers c
join orders o on o.customer_id = c.customer_id
group by c.city
having sum(o.total_price) = (
  select max(t.city_revenue)
  from (
    select
      c.city,
      sum(o.total_price) as city_revenue
    from customers c
    join orders o on o.customer_id = c.customer_id
    group by c.city
  ) t
);

select
  c.customer_name,
  c.city,
  sum(oi.quantity) as total_products,
  sum(oi.quantity * oi.price) as total_spent
from customers c
join orders o on o.customer_id = c.customer_id
join order_items oi on oi.order_id = o.order_id
group by c.customer_id, c.customer_name, c.city
order by total_spent desc;
