# 20 变量

/*
系统变量：全局变量、会话变量
自定义变量：用户变量、局部变量
*/


/*
### 1 系统变量
说明：变量又系统提供，不是用户定义，属于服务其层面
使用语法：
1 查看所有的系统变量：show global|【session】 varialbles
2 查看满足条件的部分系统变量：show global|【session】 variables like '%char%'
3 查看制定的某个系统变量的值：select @@global|【session】 .系统变量名；
4 为某个系统变量赋值：set global|【session】 系统变量名 = 值； set @@global|【session】.系统变量名 = 值；
注意：如果是全局级别，则需要加global，如果是会话级别，则需要加session，如果不写，则默认是会话级别
*/

/*
#### 1.1 全局变量
作用域：服务器每次启动将为所有的全局变量赋初始值，针对于所有的会话（连接—）有效，但不能跨重启
*/
##### 1.1.1查看所有全局变量
show global variables;
##### 1.1.2 查看部分全局变量
show global variables like '%char%';
##### 1.1.3 查看制定的全局变量
select @@global.autocommit;
select @@tx_isolation;
##### 1.1.4 为某个制定的全局变量赋值
set @@global.autocommit=1; #  所有会话窗口有效

/*
#### 1.2 会话变量
作用域：仅仅针对于当前会话有效
*/
##### 1.2.1 查看所有会话变量
show variables;
show session variables;
##### 1.2.2 查看部分会话变量
show variables like '%char%';
show session variables like '%char%';
##### 1.2.3 查看指定的会话变量
select @@session.autocommit;
select @@tx_isolation;
##### 1.2.4 为某个制定的会话变量赋值
set @@session.autocommit=1; #  当前会话窗口有效
set session tx_isolation = 'REPEATABLE-READ';
select @@tx_isolation;

/*
### 2 自定义变量
说明：变量使用户自定义的，不是由系统的
使用步骤：声明、赋值、使用（查看、比较、运算等）
*/
/*
#### 2.1 用户变量
作用域：针对于当前会话（连接）有效，同于会话变量的作用域
应用在任何地方，也就是begin end里面或begin end 外面
赋值的操作符： = 或 :=

*/
/*
##### 2.1.1 声明并初始化  set、select
set @用户变量名=值；
set @用户变量名:=值；
select @用户变量名:=值；
*/
set @num=1000;
select @varname:='Good';
/*
##### 2.1.2 赋值 set、select、select into
set @用户变量名=值；
set @用户变量名:=值；
select @用户变量名:=值；
select 字段 into @变量名 from 表；
*/
insert into tab values(100,'Bad');
set @varname='Jack';
select count(*) into @num from tab where id=100;
##### 2.1.3 查看用户变量的值
#select @用户变量名；
select @num ; 
select @varname;


/*
#### 2.2 局部变量
作用域：仅仅在定义它的begin end中有效
应用在begin end中的第一句话
*/

/*
##### 2.2.1 声明并初始化  
declare 变量名 类型；
declare 变量名 类型 default 值；
*/

/*
##### 2.2.2 赋值 set、select、select into
set 局部变量名=值；
set 局部变量名:=值；
select @局部变量名:=值；
select 字段 into 局部变量名 from 表；
*/

##### 2.1.3 查看局部变量的值
#select 局部变量名；
