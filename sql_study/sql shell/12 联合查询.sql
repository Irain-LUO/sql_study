# 进阶12 联合查询
/*
union联合、合并：讲多条查询语句的结果集合成一个结果集
语法：
查询语句1
union
查询语句 2
union
。。。。
应用场景：查询的结果集来自多个表，且多个表没有直接的连接关系，但查询信息一致
特点：
1 要求多条查询语句的查询列数一致
2 要求多条查询语句的查询的每一列的类型和顺序最好一致
3 union关键字默认去重。使用union all包含重复项
*/

##### a查询部门编号为20 或 员工工资 > 2000 的员工信息
select * from emp where deptno = 20 or sal > 2000;
##### 用union实现a
select * from emp where  sal > 2000
union
select * from emp where deptno = 20 ;
##### b 查询emp表的员工工资<2000 和emp_copy表的员工工资>3000的员工名和工资
select ename, sal from emp where sal < 2000
union
select ename, sal from emp_copy where sal >3000;

##### b 查询emp表的员工工资<2000 和emp_copy表的员工工资<3000的员工名和工资
select ename, sal from emp where sal < 2000
union all #  去重
select ename, sal from emp_copy where sal < 3000;
