select
  e.emp_name as "Tên nhân viên",
  d.dept_name as "Phòng ban",
  e.salary as "Lương"
from employees e
join departments d on d.dept_id = e.dept_id
order by d.dept_name, e.emp_name;

select
  sum(e.salary) as total_payroll,
  avg(e.salary) as avg_salary,
  max(e.salary) as max_salary,
  min(e.salary) as min_salary,
  count(e.emp_id) as employee_count
from employees e;

select
  d.dept_id,
  d.dept_name,
  avg(e.salary) as avg_salary
from departments d
join employees e on e.dept_id = d.dept_id
group by d.dept_id, d.dept_name
having avg(e.salary) > 15000000
order by avg_salary desc;

select
  p.project_name as project_name,
  d.dept_name as dept_name,
  e.emp_name as emp_name,
  e.salary as salary
from projects p
join departments d on d.dept_id = p.dept_id
left join employees e on e.dept_id = d.dept_id
order by p.project_name, d.dept_name, e.emp_name;

select
  e.emp_id,
  e.emp_name,
  d.dept_name,
  e.salary
from employees e
join departments d on d.dept_id = e.dept_id
where e.salary = (
  select max(e2.salary)
  from employees e2
  where e2.dept_id = e.dept_id
)
order by d.dept_name, e.salary desc, e.emp_name;

select d.dept_name
from departments d
join employees e on e.dept_id = d.dept_id

union

select d.dept_name
from departments d
join projects p on p.dept_id = d.dept_id;

select d.dept_name
from departments d
join employees e on e.dept_id = d.dept_id

intersect

select d.dept_name
from departments d
join projects p on p.dept_id = d.dept_id;
