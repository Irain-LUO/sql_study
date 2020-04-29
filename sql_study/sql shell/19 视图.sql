# 19 视图
/*
###  1 视图含义
含义：虚拟表，和普通表一样使用
MySQL5.1版本出现的新特性,通过表动态生成的数据


  */




/*
###  2 创建视图 
语法：create view 视图名 as 查询语句；

*/

#### 2.1 创建有员工名和其部门名的视图
drop view if exists v1;
create view v1
as 
select ename,dname
from emp e
inner join dept d
on e.deptno = d.deptno;
select * from v1;

#### 2.2 创建视图：各个部门的平均工资级别
##### 2.2.1 dsal视图：存储部门平均工资
drop view if exists dsal;
create view dsal  ## dsal视图：存储部门平均工资
as 
select  e.deptno,d.dname,avg(e.sal) avgsal
from emp e
inner join dept d
on e.deptno = d.deptno
group by e.deptno;  
select * from dsal;
##### 2.2.2 dsalgrade视图：存储部门平均工资等级
drop view if exists dsalgrade;
create view dsalgrade ## dsalgrade视图：存储部门平均工资等级
as 
select t.dname,t.avgsal,s.grade
from dsal t
inner join salgrade s
on t.avgsal between s.losal and s.hisal;
select * from dsalgrade;


/*
### 3 视图的修改
方式一：创建前，是否存在同名的视图。
语法：create or replace view 视图名 as 查询语句；

方式二：
语法：alter view 视图名 as 查询语句；
*/
#### 3.1 创建或替换视图
drop view if exists dsalgrade;
create or replace view dsalgrade ## dsalgrade视图：存储部门平均工资等级
as 
select t.dname,s.grade
from dsal t
inner join salgrade s
on t.avgsal between s.losal and s.hisal;
select * from dsalgrade;
#### 3.2 修改视图
alter view dsal  ## dsal视图：存储部门平均工资
as 
select  d.dname,avg(e.sal) avgsal  ## 去掉部门编号
from emp e
inner join dept d
on e.deptno = d.deptno
group by e.deptno;  
select * from dsal;

### 4 删除视图
/*
语法：drop view 视图名，视图名。。。。。；
*/
 drop view if exists dsalgrade;

### 5 查看视图 
desc dsal;
show create view dsal;

### 6 更新视图
drop view if exists v2;
create or replace view v2
as 
select empno,ename, sal ,deptno
from emp ;
select * from v2;
#### 6.1 插入数据
delete from v2 where  empno = 3636;
insert into v2 values(3636,'Irain', 2000, 40);
select * from v2 where empno = 3636;
#### 6.2 修改数据
update v2 set ename = 'MANAGER' where empno = 3636;
select * from v2 where empno = 3636;
#### 6.3 删除数据
delete from v2 where  empno = 3636;
select * from v2 where empno = 3636;
/*


*/
  
/*


*/
