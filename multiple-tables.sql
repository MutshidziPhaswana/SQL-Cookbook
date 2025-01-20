--Working with Multiple Tables--

select ename as ename_and_dname, deptno
	from employee
where deptno = 10
union all
select dname, deptno 
	from department

select e.ename, d.loc
	from employee e, department d
where e.deptno = d.deptno and e.deptno = 10

select e.ename, d.loc, 
	   e.deptno as emp_deptno,
	   d.deptno as dept_deptno
	from employee e, department d
where e.deptno = d.deptno and e.deptno = 10

select e.ename, d.loc
	from employee e inner join department d 
		on (e.deptno = d.deptno)
	where e.deptno = 10

create view vi
as
select ename,job,sal
	from employee
where job = 'CLERK'

select * from vi

select empno,ename,job,sal,deptno
	from employee 
where (ename,job,sal) in (
	select ename,job,sal from employee
intersect 
	select ename,job,sal from vi
)

select deptno from department
except
select deptno from employee

select d.*
from department d left outer join employee e 
	on (d.deptno = e.deptno)
where e.deptno is null

select e.ename, e.deptno as emp_deptno, d.*
	from department d left join employee e 
		on (d.deptno = e.deptno)

select * from employee_bonus 

select e.ename, d.loc 
	from employee e, department d 
where e.deptno = d.deptno 

select e.ename, d.loc, eb.recieved
	from employee e, department d, employee_bonus eb 
where e.deptno = d.deptno 
	and e.empno = eb.empno 

select e.ename, d.loc, eb.recieved
	from employee e join department d 
		on (e.deptno = d.deptno)
	left join employee_bonus eb
		on (e.empno = eb.empno)
order by 2

select e.ename, d.loc,
		(select eb.recieved from employee_bonus eb
			where eb.empno=e.empno) as recieved
	from employee e, department d
		where e.deptno = d.deptno
order by 2

-- Determine Whether Two Tables Have the Same Data --
create view VW 
as
select * from employee where deptno != 10
	union all 
select * from employee where ename = 'WARD'

select * from VW
-- Comparing the above view with the EMPLOYEE TABLE --
(
	select empno,ename,job,mgr,hiredate,sal,comm,deptno,
		count(*) as cnt
	 from VW
	group by empno,ename,job,mgr,hiredate,sal,comm,deptno
	except 
		select empno,ename,job,mgr,hiredate,sal,comm,deptno,
		count(*) as cnt
	 from employee
	 group by empno,ename,job,mgr,hiredate,sal,comm,deptno
)
union all
(
select empno,ename,job,mgr,hiredate,sal,comm,deptno,
	count(*) as cnt
from employee 
group by empno,ename,job,mgr,hiredate,sal,comm,deptno
except 
select empno,ename,job,mgr,hiredate,sal,comm,deptno,
	count(*) as cnt
from vw 
group by empno,ename,job,mgr,hiredate,sal,comm,deptno
)

-- Compare cardinalities alone --
select count(*)
	from employee
union
select count(*)
	from department
	
-- 3.8 Identifying and Avoiding Cartesian Products --
/** 
 * You want to return the name of each employee in department 10 along with the
 * location of the department. The following query is returning incorrect data
 */
select e.ename, d.loc
	from employee e, department d 
where e.deptno = 10
/*
 * Solution: Use a join between the tables in the from clause to 
 * return the correct result
 * */
select e.ename, d.loc 
	from employee e, department d
where e.deptno = 10 and d.deptno = e.deptno 

-- 3.10 Performing Outer Joins When Using Aggregates --
/**
 */
select * from employee_bonus 

select deptno,
			sum(sal) as total_sal,
			sum(bonus) as total_bonus
	from (
select e.empno,
	   e.ename,
	   e.sal,
	   e.deptno,
	   e.sal*case when eb.bonus_type = 1 then .1
	   			  when eb.bonus_type = 2 then .2
	   			  else .3 end as bonus
	   from employee e, employee_bonus eb
	where e.empno = eb.empno and e.deptno = 10
	)
group by deptno