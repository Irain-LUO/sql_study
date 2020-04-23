#进阶7：子查询
/*
含义：
分类：
按子查询出现的位置：select（仅支持标量子查询）、from（支持表子查询）、where或having（重点：标量支持下、列支出现）、exist后面（表子查询）
按结果集的行列数不同：标量子查询（只有一行一列）、列子查询（只有一列多行—）、行子查询（一行多列）、表子查询（多行多列）

*/

#### 一、where或having
/*
1 标量子查询（单行子查询）
2 列子查询（多行子查询）
3 行子查询（多列多行）

特点：
1 子查询放在小括号内
2 支持下你一般放在条件的右侧
3 标量子查询，一般搭配着单行操作符使用： < > <= >= = <>
4 列子查询，一般搭配着多行操作符使用：in、any/some、all
5  子查询的止功能型优先于主查询执行，主查询的条件又搞到了子查询的结果
*/

#### 1 标量子查询
#####  a 查询谁的工龄比‘King’大
###### ①‘King’的工龄year多少 
select ename, year(hiredate)  #  year()函数取出date类型的年份、month()、date()
from emp
where ename = 'king';
###### ②查询谁的工龄比①的year大
select ename,year(hiredate)
from emp 
where year(hiredate) < (
          select year(hiredate)  #  year()函数取出date类型的年份、month()、date()
          from emp
          where ename = 'king');
##### b 查询工资最低的员工的名字和工作
###### ①查询工资最低的员工
select min(sal) from emp;
###### ②查询工资 = min(sal) 的员工姓名和工作
select ename, job 
from emp 
where sal = (
      select min(sal) from emp

);
##### c 查询最低工资大于20号部门最低工资的部门id和其最低工资
###### ①查询20号部门的最低工资
select min(sal) from emp where deptno = 20;
###### ②查询每个部门的最低工资
select min(sal) from emp group by deptno;
###### ③查询在 ②筛选基础上，满足min(sal) > ①
select deptno, min(sal) 
from emp 
group by deptno 
having min(sal) > (
        select min(sal) 
        from emp 
        where deptno = 20);
        
#### 2 非法使用标量查询
/*
##### a 子查询中存在多行多列
select deptno, min(sal) 
from emp 
group by deptno 
having min(sal) > (
        select sal 
        from emp 
        where deptno = 20);
*/
##### b 子查询不存在结果集 null
select deptno, min(sal) 
from emp 
group by deptno 
having min(sal) > (
        select min(sal) 
        from emp 
        where deptno = 2);
        
####  3 多行子查询
##### a 查询部门名称为sales、research的部门中的所有员工姓名
###### ②查询部门为sales、research的部门编号
select deptno from dept where dname in ('sales','research');
###### ②查询所有员工姓名，要求部门编号为① 列表中的某一个
select ename 
from emp 
where deptno in (
      select deptno 
      from dept 
      where dname in ('sales','research'));
##### b 查询其他部门中比 部门编号20任意工资低的员工号、姓名、工资
###### ①查询‘sales’部门任意工资
select distinct sal from emp where deptno = 20; 
###### ②查询员工号、姓名、工资，以工资 < (①)的任意一个
select empno, ename, sal from emp where sal < any(
select distinct sal from emp where deptno = 20)
and deptno <> 20;
###### 查询相同结果集
select empno, ename, sal from emp where sal < (
select max(sal) from emp where deptno = 20)
and deptno <> 20;
##### c 查询其他部门中比 部门编号10所有工资低的员工号、姓名、工资、部门编号
###### ①查询‘sales’部门任意工资
select distinct sal from emp where deptno = 10; 
###### ②查询员工号、姓名、工资，以工资 < (①)的任意一个
select empno, ename, sal,deptno from emp where sal < all(
select distinct sal from emp where deptno = 10)
and deptno <> 10;
###### 查询相同结果集
select empno, ename, sal,deptno from emp where sal < (
select min(sal) from emp where deptno = 10)
and deptno <> 10;

#### 4 行子查询（结果集一行多列或多行多列）
##### 查询员工编号最小并且工资最低的员工信息
###### 查询员工编号最小
select min(empno) from emp;
######  员工的最高工资
select min(sal) from emp;
###### 员工编号 = ①并且工资 = ② 的员工信息
select * 
from emp 
where empno = (select min(empno) from emp)
and sal = (select min(sal) from emp);
###### 查询相同结果集
select * from emp where (empno, sal) = (
                    select min(empno), min(sal)
                    from emp);
                    
#### 二、select
##### a 查询每个部门的员工个数
delete from emp where ename = 'Irain';
insert into emp values(7736,'IRAIN','MANAGER',7839,'1988-06-09',3600,600,40);#  补充部门编号40 的员工
select *, (
      select count(*)
      from emp e
      where e.deptno = d.deptno) 
from dept d;
##### b 查询部门编号为40的员工名字
select (  # 标量子查询：子查询结果集只能一行一列
      select ename 
      from emp
      where deptno = 40
);

#### 三、from
#####  查询每个部门的平均工资的工资等级
###### 查询部门的平均工资
select deptno, avg(sal) avgsal
from emp
group by deptno;
###### 查询每个部门的平均工资的工资等级
select deptno, grade
from (
      select deptno, avg(sal) avgsal  #  子查询中必须去别名
      from emp
      group by deptno) t, salgrade s
where t.avgsal between s.losal and hisal;

#### 四、exists
/*
语法：exists(完整的查询语句)
结果：1或0
*/
#####  a emp表中是否存在数据
select exists(select * from emp);
#####  b 查询没有有员工的部门
delete from emp where ename = 'Irain';
select dname
from dept d
where not exists(
select * 
from emp e
where d.deptno = e.deptno
);