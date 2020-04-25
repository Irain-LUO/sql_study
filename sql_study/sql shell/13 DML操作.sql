# 13 DML语言
/*
### 1 数据操作语言：
插入：insert
修改：update
删除：delete
*/

### 2 插入语句
/*
语法一：
insert into 表明（列名1，列名2。。。）
values(值1，值2.。。。。);
*/
#### 插入操作示例
#### 1  插入值的类型与列的类型一致或兼容
insert into emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(7777,'Irian', 'MANAGER', '7396', '1988-09-09', 2000, 300, 40);
select * from emp where ename = 'Irian';
#### 2 非null的列必须插入值，为null的列的插入方式
##### 2.1 方式一：列名 = null
insert into emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(7772,'Irian', 'MANAGER', '7396', '1988-09-09', 2000, null, 40);
##### 2.2 方式二 ：不写列名和值
insert into emp(empno, ename, job, mgr, hiredate, sal,  deptno)
values(7771,'HERO', 'MANAGER', '7396', '1988-09-09', 2000,  40);
##### 2.3 调换列的顺序
insert into emp(empno, ename, job, mgr,  deptno, hiredate, sal)
values(7770,'PANDA', 'MANAGER', '7396',  40, '1988-09-09', 2000);
##### 2.4 列数与值的个数一致
insert into emp(empno, ename, job, mgr,  deptno, hiredate, sal)
values(7773,'JACK', 'MANAGER', '7396',  40, '1988-09-09', 2000);
##### 2.5 省去列名，默认输入值的顺序与表中列的顺序一致
insert into emp
values(77778,'Apple', 'MANAGER', '7396', '1988-09-09', 2000, 300, 40);
/*
### 3 语法二：
inset into 表
set 列名 = 值。。。。。
*/
insert into emp
set empno = 7779;

### 语法一 vs 语法二
#### a 语法一支持 多行插入，语法二不支持
insert into emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
values(7707,'Irian', 'MANAGER', '7396', '1988-09-09', 2000, 300, 40),
(7727,'Irian', 'MANAGER', '7396', '1988-09-09', 2000, 300, 40),
(7737,'Irian', 'MANAGER', '7396', '1988-09-09', 2000, 300, 40);
####  b 语法一支持子查询，语法二不支持
insert into emp (empno) select 6666;


## 二、修改语句
/*
###  修改语句内容
1 修改单标的记录
update 表
set 列 =  值，列 = 值。。。。
where 筛选条件;
2 修改多表的记录【补充】
*/
### 修改语句示例
#### 1 修改单表记录
##### a 修改emp中的名字是Apple的奖金comm为 500 和工资为1000
update emp set comm = 500, sal = 1000 where ename = 'Apple';
#### 2 修改多表记录
/*
语法：
sql 92
update 表1 别名， 表2 别名
set 列=值。。。。
where  连接条件
and 筛选条件;

sql 99
update 表1 别名
【inner、left、right】 join 表2 别名
on  连接条件
set 列=值。。。。
where 筛选条件;
*/
##### a 修改部门地址为NEW YOURK的员工的奖金为100
update dept d
inner join emp e 
on d.deptno = e.deptno
set e.comm = 100
where d.loc = 'NEW YOURK';


##  三、删除语句
/*
### 删除语法内容
#### 方法一：delete
语法：
1 单表删除
delete  from 表 where 筛选条件
2 多表删除【补充】

sql 92语法：
delete 表1的别名， 表2的别名
from 表1 别名， 表2 别名
where 连接条件
and 筛选条件;


sql 99语法：
delete 表1的别名
from 表1 别名
【inner、left、right】 join 表2 别名
on 连接条件
where 筛选条件;


####  方式二、truncate
语法：truncate table 表；

#### delete vs truncate
1 delete 可以加where筛选条件，truncate不能加
2 truncate删除，效率高一丢丢
3 加入要删除的表中有资政长列，
如果用delete删除后，在杀入数据，自增长列的值从断点开始，
而trancate删除后，再插入数，自增长列从头开始
4 truncate删除没有返回值，delete删除有返回值
5 truncate删除不能回滚，delete删除可以回滚
*/

#方式一：delete

### 示例
#### 1 单表删除
##### 删除emp表中名字为Irian的员工
delete from emp where ename = 'Irian';
#### 2 多表删除
##### a 删除部门地址为BOSTON的员工信息
delete e
from emp e
inner join dept d
on e.deptno = d.deptno
where d.loc = 'BOSTON';
##### b 删除部门地址为‘GUAGNZHOU’和该部门的员工信息
delete from emp where deptno = 50;
delete from dept where deptno = 50;
insert into emp(empno,deptno) values(1234,50);
insert into dept set deptno = 50, loc = 'GUANGZHOU';
delete e, d
from emp e
inner join dept d
on e.deptno = d.deptno
where d.loc = 'GUANGZHOU';
#### 3 truncate删除
##### 清空表
truncate table emp_copy_copy;