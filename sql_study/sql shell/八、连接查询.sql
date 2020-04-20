#进阶6：连接查询
/*
含义：又称多表查询，当查询的字段来自于多个表时，就会用到连接查询
笛卡尔乘积现象：表1：m行， 表2：n行  结果：m*n行
发生原因：没有有效的连接条件
避免方式：添加有效的连接条件
分类：
按年代分类：
sql 92标准：仅仅支持内连接
sql 99标准【推荐】：支持内连接+外链接（支持左、右）+ 交叉连接
按功能分类：
内连接：等值连接、非等值连接、自连接
外链接：左外链接、右外链接、完全外链接
交叉连接
*/

###  1 sql 92标准
#### a 等值连接 
/*
1 多表等值连接的结果为多表的交际部分 
2 n表连接，至少需要n-1个连接条件
3 多表的顺序没有要求
4 一般需要为表起别名
5 可以搭配使用：排序order by、分组group by、帅选where
*/
#### 为表取别名 
/*
1 提高语句的简洁度
2 区分多个重名字段
注意：如果为表取别名，则查询就不能使用原来的表明限定
*/
#### 查询员工名和对应的部门名
select ename, dname from emp e , dept d  where e.deptno = d.deptno;
#### b 两张表的顺序可以调换
select ename, dname from  dept d, emp e   where e.deptno = d.deptno;
#### c and连接多个帅选条件
#### 查询工资 > 2000 的员工名、员工工资和其对应的部门 
select ename, sal, dname from  dept d, emp e   where e.deptno = d.deptno and e.sal > 2000;
#### d 添加分组:group by
#### 部门名、每个部门的员工个数
select dname, count(*) from emp, dept where emp.deptno =dept.deptno group by dname;
#### e 添加排序:order by
#### 查询工资 > 2000 的员工名、员工工资和其对应的部门 ，按员工工资升序
select ename, sal, dname from  dept d, emp e   where e.deptno = d.deptno and e.sal > 2000 order by e.sal asc;
#### f 三表连接查询
#### 查询员工工资等级、员工部门名、员工名、按工资等级降序
select ename, grade, dname from emp e, dept d, salgrade s where e.deptno = d.deptno and e.sal between s.losal and s.hisal order by grade desc; 
### 2 非等值查询
#### 查询员工工资等级、员工名、按工资等级降序
select ename, grade from emp e,  salgrade s where e.sal between s.losal and s.hisal order by grade desc; 
### 3 自连接
#### 查询员工编号、员工名、领导编号、领导名
select w.empno, w.ename, l.empno, l.ename from emp w, emp l where w.mgr = l.empno;