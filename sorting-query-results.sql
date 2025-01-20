--Sorting Query Results --
select ename, job, sal
	from employee
 where deptno = 10
 order by sal asc

select ename, job, sal
	from employee
 where deptno = 10
 order by sal desc

select ename, job, sal
	from employee
 where deptno = 10
 order by 3 desc

select empno,deptno,sal,ename,job
	from employee
order by deptno, sal desc

select ename,job
	from employee
order by substring(job, length(job)-1) 

create view V
	as 
		select ename ||' '||deptno as data
			from employee

select * from V

select data 
from V
order by 
	replace(
		data,
		replace(
			translate(data,'0123456789','##########'),
			'#',
			''
		),
		''
	)

select data 
from V
order by replace(translate(data,'0123456789','##########'),'#','')

select ename,sal,comm
	from employee
order by 3

select  ename,sal,comm
	from employee
order by 3 desc 

select ename,sal,comm
	from (
select ename,sal,comm,
	   case when comm is null then 0 else 1 end as is_null
from employee
	) x
order by is_null desc, comm

select ename,sal,comm
	from (
select ename,sal,comm,
	   case when comm is null then 0 else 1 end as is_null
from employee
	) x
order by is_null desc, comm desc

select ename,sal,comm
	from (
select ename,sal,comm,
	   case when comm is null then 0 else 1 end as is_null
from employee
	) x
order by is_null, comm

select ename,sal,job,comm
	from employee
order by case when job = 'SALESMAN' then comm else sal end 