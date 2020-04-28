# 17 标识列

/*
含义（又称自增长列）：可以不用动手的插入值，系统提供默认的序列值
特点：
1 标识列必须与key（主键、外键、唯一）搭配
2 一个表中只有一个标识列
3 标识列的类型：只能是数值型
4 通过set auto_increment_increment语句修改标识列的步长
5 通过set auto_increment_offset语句修改标识列的起始值，也可以手动插入。  
# 在MySQL修改自增长列的起始值，没有起作用
*/

### 2 创建表时设置标识列
drop table if exists tab_identity;
create table tab_identity(
     id int primary key auto_increment,  
     N varchar(10)
     );
truncate table tab_identity;
set auto_increment_increment = 3;  #  修改自增长列的步长
set auto_increment_offset = 5;  ## 在MySQL修改自增长列的起始值，没有起作用
insert into tab_identity(N) values('ss');
insert into tab_identity(N) values('ss');
insert into tab_identity(N) values('ss');
show  variables like '%auto_increment%';    # 查看自增长设置
select * from tab_identity;  
### 3 修改表时设置标识列
drop table if exists tab_identity;
create table tab_identity(
     id int ,  
     N varchar(10)
     );
alter table tab_identity modify column id int primary key auto_increment;
desc tab_identity;
### 4 修改表时删除标识列 
alter table tab_identity modify column id int;
desc tab_identity;