##  九、分组查询之sql 99 语法

/*
> 语法：
select 查询列表
from 表1 别名 【连接类型】
join 表2 别名
on 连接条件
【where 筛选条件】
【group by 分组】
【having 筛选条件】
【order by 排序列表】

分类：
内连接（*）：inner
外连接：
左外（*）：left 【outer】
右外（*）：right 【outer】
全外： full  【outer】
交叉连接： cross
*/

### 1 内连接：
/*
select 查询列表
from 表1  别名
inner join 表2 别名
on 连接条件；
分类：等值、非等值、自连接
特点：
①添加排序、分组、筛选
②inner可以省略
③筛选条件放在where后面，连接条件放在on后面，提高分离性，便于阅读
④inner join连接和sql 92标准语句总的等值连接效果一样，都是查询多表的交集
*/

/*
sql 92 vs sql 99
功能：sql 99支持功能比较多
可读性：sql 99实现连接条件和筛选条件的分离，可读性较高
*/
####  a 等值连接
##### ①查询员工名和对应的部门名
select ename, dname 
from emp e 
inner join dept d 
on e.deptno = d.deptno;
##### ②查询名字中包含‘t’的员工名字和其部门名称  添加筛选where
select ename, dname 
from emp 
inner join dept on emp.deptno = dept.deptno 
where ename like '%t%';
##### ③部门名、每个部门的员工个数 < 3  添加分组:group by、筛选having
select dname, count(*) 
from emp inner join  dept 
on emp.deptno =dept.deptno 
group by dname 
having count(*) < 3;
##### ③查询工资 > 2000 的员工名、员工工资和其对应的部门 ，按员工工资升序 添加排序:order by
select ename, sal, dname 
from  dept d 
inner join emp e   
on  e.deptno = d.deptno 
and e.sal > 2000 
order by e.sal asc;
##### ④查询员工工资等级、员工部门名、员工名 三表连接查询：需要连接条件
select ename, grade, dname 
from emp e 
inner join dept d 
on e.deptno = d.deptno 
inner join salgrade s  
on e.sal between s.losal
and s.hisal ;
####  b 非等值连接
##### ①查询员工工资等级、工资等级员工个数 > 2的个数、按工资等级员工个数降序 
select  grade, count(*) 
from emp e  
inner join salgrade s  
on e.sal between s.losal
and s.hisal
group by grade 
having count(*) > 2
order by count(*) desc;
#### c 自连接
##### ①查询员工编号、员工名、领导编号、领导名
select w.empno 员工编号, w.ename 员工名, l.empno 领导编号, l.ename 领导名 from emp w inner join emp l on w.mgr = l.empno;
##### ①查询员工编号、员工名、领导编号、工资 > 2000的领导名、领导工资
select w.empno 员工编号, w.ename 员工名, l.empno 领导编号, l.ename 领导名, l.sal 领导工资 from emp w inner join emp l on w.mgr = l.empno where l.sal > 2000;
### 2 外连接
/*
> 应用场景：用于查询一个表中有，另一个表中没有
特点：
1、外连接的查询结构为主表中的所有记录
如果从表中有和它匹配的，则显示匹配的值
如果从表中没有和他匹配的，则显示null
2、左外连接，left左边的是主表
右外连接，right右边的是主表
3、左外和右外交换两个表的顺序，效果一样
4、全外连接 = 内连接的结果 + 表1中有但表2中没有 + 表2中有但表1中没有
*/
#### a 左外连接
##### 查询没有领导的员工名、领导名
select w.ename 员工名,l.ename 领导名
from emp w
left outer join emp l
on w.mgr = l.empno
where l.empno is null;
#### b 右外连接
##### 查询员工名、没有员工的领导名
select w.ename 员工名,l.ename 领导名
from emp w
right outer join emp l
on w.mgr = l.empno
where w.empno is null;
### 3 全外连接  MySQL不支持
##### 查询员工名、没有员工的领导名
/*
select w.ename 员工名,l.ename 领导名
from emp w
full outer join emp l
on w.mgr = l.empno;
*/
#where w.empno is null;
### 4 交叉连接；笛卡尔乘积
select emp.*, dept.* 
from dept
cross join emp;
