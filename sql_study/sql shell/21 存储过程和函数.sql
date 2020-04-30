#  21 存储过程和函数

/*
存储过程和函数：类似于Java中的方法
好处：
1 提高代码的重用性
2 简化操作
*/

/*
### 1 存储过程：一组预先编译好的sql语句的集合，理解成批处理语句
1 提高代码的重用性
2 简化操作
3 减少了编译次数和数据库服务器的连接次数，提高了效率
*/

/*
#### 1.1 创建语法
create procedure 存储过程名(参数列表)
begin
      存储过程体（一组合法sql语句）
end
*/

/*
注意：
1 参数列表包含三部分：参数模式 参数名 参数类型
参数模式：
in：该参数可以作为输入，就是该参数需要调用方传入值
out：该参数可以作为输出，就是该参数可以作为返回值
inout： 该参数可以作为输出又可以输入，就是该参数可以作为返回值又可以作为输入值
案例：in stuname varchar(20)

2 如果存储过程题仅仅只有一句话，begin end可以省略
存储过程体中的每条sql语句的结尾要求必须加分号
存储过程的结尾可以使用delimiter重新设置
delimiter 结束标记
案例： delimiter $


*/
##### 1.1.1 空参列表
delimiter $ #  设置语句结束标记 $
create procedure insert_tab()
begin
  insert into  tab(id,varname) values(1,'ee'),(1,'ee'),(1,'ee');
end $

#### 1.2 调用语法
#call 存储过程名（实参列表）；
call insert_tab()$  # 之前使用delimiter 设置$ 字符作为语句结束字符


### 1.3 创建带in模式参数的存储过程
#### 1.3.1  输入id ，查询该id数据
create procedure id_tab(in id int)
begin
     select * from tab t where t.id=id;
end$

#### 1.4 创建带out模式的存储过程
##### 1.4.1 查询id的名字
create procedure id_name_tab4(in id int, out varname varchar(20))
begin 
  select distinct tab.varname into varname
  from tab
  where tab.id = id;
end $
call id_name_tab4(100,@id_name)$
select @id_name$

#### 1.5 带inout模式参数的存储过程
##### 1.5.1 传入两个值，输入该值的两倍
create procedure v1(inout a int, inout b int)
begin 
    set a = a*2;
    set b = b*2;
end $
set @n=1$
set @m=10$
call v1(@n,@m)$
select @n, @m$

/*
### 1.6 删除存储过程(没有修改存储过程)
语法：drop procedure 存储过程名； 一次只能删除一个；
*/
drop procedure v1$
drop procedure v2$
drop procedure if exists id_tab$

### 1.7 查看存储过程的信息
show create procedure id_name_tab;


/*
## 2 函数
含义：一组预先编译好的sql语句的集合，理解成批处理语句
1 提高代码的重用性
2 简化操作
3 减少了编译次数和数据库服务器的连接次数，提高了效率

区别：
存储过程：可以有0或多个返回，适合做批量插入、批量更新
函数：有且仅有1个返回，适合做处理数据后返回一个结果
*/



/*

#### 2.1 创建语法
create function 函数名（参数列表） returns 范湖类型
begin
    函数体
end
注意：
1 参数列表包含两部分：参数名 参数类型
2 函数体：肯定会有return语句，如果没有会报错
如果return语句没有放在函数体的最后也不报错，但不建议
return 值；
3 函数体中仅有一句话，则可以省略begin end
4 使用delimiter语句设置结束标记
*/
/*
### 

#### 2.2 调用语句
select 函数名（参数列表）
*/

#### 2.3 无参有返回
##### 函数：返回员工人数
create function workers() returns int
begin
    declare num int default 0; # 定义变量
    select count(*) into num ## 赋值
    from emp;
    return num  ;
end $
select workers()$


#### 2.4 有参数有返回
##### 函数: 根据员工名，返回员工工资
create function worker_sal(ename varchar(20)) returns double
begin
    set @sal = 0; # 定义变量
    select emp.sal  into @sal ## 赋值
    from emp
    where emp.ename = ename
    limit 1; # 防止查询多个值
    return @sal   ;
end $
select worker_sal('SMITH')$




/*


*/