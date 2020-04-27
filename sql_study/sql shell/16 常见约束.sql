# 16 常见约束

/*
###  1 常见约束内容
含义：一种限制，用于限制表中的数据，为了保证表中的数据的准确和可靠性
分类：六大约束
1 not null：非空，用于保证该字段的值不能为空、
比如：学号、名字
2 default：默认，用于保证该字段有默认值
比如：奖金、
3 primary key：主键，用于保证该字段的值具有唯一性和非空性
比如：学好、员工编号
4 unique：唯一，用于保证该字段的值是惟一的
比如：座位号
5 check：检查约束【MySQL中不支持】
比如：年年、性别
6 foreign key：外键，用于限制两个表的关系，用于保证该字段的值必须来自于主表的关联列的值
在从表添加约束，用于引用主表中某列的值。
如：专业编号、工种编号


添加约束的时间：创建和修改表时
约束的添加分类：
1 列级约束：六大的约束语法上都支持，除了外键约束
2 表级约束：除了非空、默认、其他都支持
主键 vs 唯一
  主键/唯一  |   保证唯一 | 是否允许为空  | 表中数量 |  允许组合 |     
-------- | ----- | ----- | ------------- | ----- | ----- 
  主键 |     √      |    ×     |  一个 |  √（不推荐）  |         
  唯一 |    √  |    √ （空值唯一）| 	多个 |  √（不推荐）    |         
外键：
1 要求在从表设置外键关系
2 从表的外键列的类型和主表的关联列的类型要求一致或兼容
3 主表的关联列必须是唯一（key或unique）
4 插入数据时，先插入主表，再插入从表。
5 删除数据时，先删除从表，再删除主表。
添加约束创建表：
create table 表明(
      字段名 字段类型
      字段名 字段类型 列级约束，
      表级约束
);
*/
### 2 常见约束示例
create database if not exists students;
use students;
####  2.1 创建表时添加约束
#####  2.1.1  添加列级约束
/*
语法：
直接在字段类型后面追加约束类型即可
只支持：默认、非空、主键、唯一
*/
create table if not exists lie_stuinfo(
           id int  primary key, # 主键
           stuName varchar(10) not null, # 非空
           gender char check(gender='男' or dender='女'), # 检查
           seat int unique, # 唯一
           age int default 18, #  默认值
           majorId int references major(id) # 外键，但无效
);

create table if not exists major(
        id int primary key,
        majorName varchar(10)
);

show index from lie_stuinfo;
desc lie_stuinfo;

#####  2.1.2  添加表级约束
/*
语法：在各个字段的最下面
【constraint 约束名】（可省略） 约束类型（字段名）
*/
drop table if exists tab_stuinfo;
create table tab_stuinfo(
       id int,
       stuname varchar(20),
       gender char,
       seat int ,
       age int,
       majorid int,
       constraint pk primary key(id), #
       constraint uq unique(seat),
       constraint ck check(gender='男' or dender='女'),
       constraint fk_stuinfo_major foreign key(majorid) references major(id)
    #   not null(stuname)
);

show index from tab_stuinfo;
desc tab_stuinfo;
#####  2.1.3  添加约束通用写法
drop table if exists stuinfo;
create table stuinfo(
           id int  primary key, # 主键
           stuName varchar(10) not null, # 非空
           gender char check(gender='男' or dender='女'), # 检查
           seat int unique, # 唯一
           age int default 18, #  默认值
           majorid int,
           constraint fk_stuinfo_major1 foreign key(majorid) references major(id)
           #  外键不能重名，两张表用外键关联相同的第三张表
           );
           
#####  2.1.4  添加多个约束
drop table if exists stuinfo1;
create table stuinfo1(
           id int  primary key, # 主键
           stuName varchar(10) not null unique # 非空且唯一
           );
desc stuinfo1;

####  2.2 修改表时添加约束
/*
1 添加阶级约束
alter table 表明 modify column 字段名 字段类型 新约束；
2 添加表级约束
alter table 表名 add 【constraint 约束名】 约束类型（字段名） 【外键引用】
*/
drop table if exists stuinfo2;
create table stuinfo2(
           id int  , 
           stuName varchar(10) ,
           gender char,
           seat int ,
           age int,
           majorid int

           );
desc stuinfo2;
##### 2.2.1 添加非空约束
alter table stuinfo2 modify column stuName varchar(10) not null;
##### 2.2.2 添加默认约束
alter table stuinfo2 modify column age int default 18;
##### 2.2.3 添加主键列级约束
alter table stuinfo2 modify column id int primary key;
##### 2.2.4 添加主键表级约束
alter table stuinfo2 drop primary key;  #  删除主键
alter table stuinfo2 add primary key(id);
##### 2.2.5 添加唯一列级约束
alter table stuinfo2 modify column  seat int unique;
##### 2.2.6 添加唯一表级约束
alter table stuinfo2 drop index seat;  #  删除唯一
alter table stuinfo2 add unique(seat);
##### 2.2.7 添加外键约束
alter table stuinfo2 add constraint fk_s_m foreign key(majorid) references major(id);
desc stuinfo2;

####  2.3 修改表时删除约束
##### 2.3.1 删除非空约束
alter table stuinfo2 modify column stuName varchar(10) null;
##### 2.3.2 删除默认约束
alter table stuinfo2 modify column age int;
##### 2.3.3 删除主键约束
alter table stuinfo2 drop primary key;
##### 2.3.4 删除唯一约束
alter table stuinfo2 drop index seat;
##### 2.3.5 删除外键约束
#drop table major;
alter table stuinfo2 drop foreign key fk_s_m;
#alter table stuinfo2 drop constraint fk_s_m;
desc stuinfo2;
show index from stuinfo2;
show create table stuinfo2;