## 14 DDL数据定义语言

/*
### 1 库和表的管理操作
创建：create
修改：alter
删除：drop
if exsits 或者 if not exists 用在库和表的创建和删除
*/

###  2 库的管理
####  2.1 库的创建
create database if not exists datas;
####  2.2 库的修改
# rename database datas to ss; # 不能使用，手动修改
####  2.3 更改库的字集符
alter database datas character set gbk;
####  2.4 库的删除
drop database if  exists datas;

### 3 表的管理
#### 3.1 表的创建
/*
create table 表明(
      列名 列的类型 【（长度） 约束】，
      列名 列的类型 【（长度） 约束】，
      列名 列的类型 【（长度） 约束】，
      列名 列的类型 【（长度） 约束】，
      列名 列的类型 【（长度） 约束】
)；

*/
drop table if exists book;
create table if not exists book(
      id int,# 编号
      bname varchar(16), # 图书名
      Btime datetime
);

desc book;
####  3.2 表的修改
/*
alter table 表名 【add、drop、modify、change】  column 列名 【列类型 约束】；
*/##### 3.2.1 修改列名
alter table book change column btime puldate datetime; # column 可以省略
desc book;
##### 3.2.2 修改列的类型或约束
alter table book modify column puldate time;
desc book;
##### 3.2.3 添加新列
alter table book add column annual double;
desc book;
##### 3.2.4 删除列
alter table book drop column  annual;
desc book;
##### 3.2.5 修改表名
#Drop table books;
alter table book rename  to books;
desc books;

#### 3.3 表的删除
Drop table books;
show tables;

####  3.4 表的复制8

create table if not exists book(
      id int,# 编号
      bname varchar(16) # 图书名
);

insert into book values(1,'愿你安好'),(2,'红楼梦');
#####  3.4.1 仅仅复制表的结构
drop table copy;
create table copy like book; 
##### 3.4.2 复制表的结构+数据
drop table if exists c;
create table c select * from book;
##### 3.4.3 复制部分数据
drop table if exists c1;
create table c1 select * from book where id = 1;
##### 3.4.4 只复制部分列，没有数据
drop table if exists c2;
create table c2 select id from book where 0;
##### 3.4.5 复制部分列和数据
drop table if exists c3;
create table c3 select id from book where id = 1;
