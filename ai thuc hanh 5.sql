select
  s.full_name as "Tên sinh viên",
  c.course_name as "Môn học",
  e.score as "Điểm"
from students s
join enrollments e on e.student_id = s.student_id
join courses c on c.course_id = e.course_id
order by s.full_name, c.course_name;

select
  s.student_id,
  s.full_name,
  avg(e.score) as avg_score,
  max(e.score) as max_score,
  min(e.score) as min_score
from students s
join enrollments e on e.student_id = s.student_id
group by s.student_id, s.full_name
order by avg_score desc;

select
  s.major,
  avg(e.score) as avg_score
from students s
join enrollments e on e.student_id = s.student_id
group by s.major
having avg(e.score) > 7.5
order by avg_score desc;

select
  s.full_name as full_name,
  c.course_name as course_name,
  c.credit as credit,
  e.score as score
from students s
join enrollments e on e.student_id = s.student_id
join courses c on c.course_id = e.course_id
order by s.full_name, c.course_name;

select
  s.student_id,
  s.full_name,
  avg(e.score) as avg_score
from students s
join enrollments e on e.student_id = s.student_id
group by s.student_id, s.full_name
having avg(e.score) > (
  select avg(score)
  from enrollments
)
order by avg_score desc;

select s.student_id, s.full_name
from students s
join enrollments e on e.student_id = s.student_id
where e.score >= 9

union

select s.student_id, s.full_name
from students s
where exists (
  select 1
  from enrollments e
  where e.student_id = s.student_id
);

select s.student_id, s.full_name
from students s
join enrollments e on e.student_id = s.student_id
where e.score >= 9

intersect

select s.student_id, s.full_name
from students s
where exists (
  select 1
  from enrollments e
  where e.student_id = s.student_id
);
