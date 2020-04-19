/*
>  作者：Irain
QQ：2573396010
微信：18802080892
日期：2020年4月19日
*/
#进阶5：分组查询
#语法：group by
#分组查询搭配分组函数使用
/*
语法：
select  分组函数，列（要求出现在group by的后面）
from  表
where 帅选调剂
group by  分组列表
order by  子句
注意：查询列表必须特殊，要求是分组函数和group by 后出现的字段
特点：1分组查询中的帅选条件分为两类
                  数据源               位置                  关键字
      分组前帅选  原始表                group by子句之前     where
      分组后帅选  分组后的结果集        group by子句之后     having
      ②分组函数做条件肯定是放在having子句中
      ①优先考虑使用分组前帅选
      2 group by 子句支持单个、多个字段分组（多个字段之间没有顺序要求）、表达式或函数（比较少）
      3 排序order by，位置放在最后
*/
#查询每个部门的平均工资
select deptno,avg(sal) from emp group by deptno;

###  a 查询每种岗位的最高、最低工资
select job,max(sal),min(sal) from emp group by job;

####  b 每个岗位的部门员工个数
select job, count(*) from emp group by job;

###  c  添加分组前的帅选where  
####  ①查询名字有字符‘i’的，每个部门的平均工资
select deptno,avg(sal) from emp where ename like '%i%' group by deptno;

####  ②查询每个工种没有奖金的员工的工种和最高工资
# 基于a示例，添加帅选where
select job,max(sal) from emp where comm is  null group by job;

###  d 添加分组后的帅选条件having
####  ①查询哪些部门的员工个数 > 2
# 基于示例 b，添加帅选having
select job, count(*) from emp group by job having count(*) > 2;

####  ②查询每个工种没有奖金的员工的最高工资 > 2500的工种和最高工资
# 基于示例c ②,添加帅选having
select job,max(sal) from emp where comm is  null group by job having max(sal) > 2500;

###  e 按表达式或函数分组
####  按员工姓名的长度分组，查询每一组的员工个数，帅选员工个数 > 3的有哪些
# ①查询每个长度的员工个数
select length(ename),count(*) from emp group by length(ename) ;
# ②添加帅选条件
select length(ename),count(*) from emp group by length(ename) having count(*) > 3;

###  f 按多个字段分组
####   查询每个部门每个工种的员工的平均工资
select deptno, job, avg(sal) from emp group by deptno,job;

### g 添加排序
####   查询每个部门每个工种的员工的平均工资，并且按平均工资的高低显示
# 基于f 示例，添加排序
select deptno, job, avg(sal) avg_sal from emp group by deptno,job order by avg_sal desc;select max(HIREDATE) from  emp;