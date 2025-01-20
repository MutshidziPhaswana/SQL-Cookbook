--Retrieving Records--

select * from employee

select empno,ename,job,mgr,hiredate,sal,comm,deptno from employee

select * from employee where deptno = 10

select * from employee where ( deptno = 10 
					   		   or comm is not null 
					           or sal <= 2000
					 		 )  and deptno = 20

select ename, deptno, sal from employee

select sal, comm from employee

select sal as salary, comm as commission from employee

select sal as salary, comm as commission 
	from employee 
where salary < 5000

select * from (
	select sal as salary, comm as commission
		from employee
			  ) x
where salary < 5000

select ename, job
	from employee
	where deptno = 10

select ename||' WORKS AS A '|| job as msg
	from employee
	where deptno = 10

select ename,sal,
	case when sal <= 2000 then 'UNDERPAID'
		 when sal >= 400 then 'OVERPAID'
		 else 'OK'
	end as status
from employee

select * from employee limit 5

select ename, job
	from employee
order by random() limit 5 

select * from employee 
	where comm is not null

select coalesce(comm, 0) from employee

select case 
	when comm is not null then comm
	else 0
	end
from employee 

select ename, job 
	from employee
where deptno in (10, 20)

select ename, job from employee
 where deptno in (10, 20) and 
 	(ename like '%I' or job like '%ER')
end
