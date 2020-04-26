# 15 常见的数据类型

/*
### 1 常见的数据类型 
数值型：整数、小数（浮点数、定点数）

字符型：
较短的文本：char、varchar
较长的文本：text、blob
日期型：
*/
### 2 数据类型详细内容
#### 2.1 整数型：
/*
分类：Tinyint（1个字节）、Smallint（2个字节）、Mediumint（3个字节）、Int（integer 、4个字节）、Bigint（8个字节）
特点：
1 如果不设置无符号还是有符号，默认有符号。添加unsigned设置有符号。
2 插入数值超出整数型范围，会报out of range错误。
3 如果不设置长度，有默认长度。
4 长度代表了显示的最大宽度，如果不够会用0在左边填充，但必须搭配zerofill使用！
*/
##### 2.1.1 设置有符号和无符号
create database if not exists tpye;
drop table if exists tab_int;
create table tab_int(
    t1 int zerofill,
    t2 int unsigned
);
insert into tab_int values(111, 3);  
#  无法插入。有些MySQL环境可以插入，但插入数值改为最接近整数类型的数值。
desc tab_int;
select * from tab_int;


#### 2.2 浮点型
/*
分类：
1 浮点型：float(M,D) 4个字节、double(M,D) 8个字节
2 定点型：dec(M,D) M+2个字节、decimal(M,D)M+2个字节  
特点：
1 M:整数位数+小数位数； D:小数位数。如果超出整数位数范围，会报out of range错误，无法插入。如果超出小数数位范围，自动四舍五入。
2 M、D可以省略。如果decimal，则M默认为10，D默认为0.如果是float、double，则会根据插入的数值的精度来决定精度。
3 定点型的精确度较高，如果要求插入的数值的精度较高，如：货币换算。
原则：所选择的类型越简单越好，能保存数值的类型越小越好
*/

##### 2.2.1 float、double、decimal类型示例
drop table if exists tab_float;
create table tab_float(  # 保留两位小数点
    f1 float(3,2) ,
    f2 double(3,2),
    f3 decimal(3,2)
);
insert  into tab_float values(1.229,1.282,1.22);
select * from tab_float;
 
#### 2.3 字符型
/*
分类：
较短的文本：char(M) 最多M个固定字符数 、varchar(M) 最多M个可变字符数
较长的文本：text、blob
其他：
binary和varbinary：把保存较短二进制
enumerate：保存枚举
set：保存集合
特点：
   类型   | 写法        |     M的意思        |        特点    | 空间 | 效率
-------- | ----- | ----- | ----- |---- | ----
 char | char(M)                  |      最大的字符数，默认为1   |  固定长度的字符 | 消耗高 | 高
varchar| varchar(M)    |      最大的字符数，不可以省略   | 可变长度的字符 | 消耗低 | 低
*/

##### 2.3.1 char和varchar示例
drop table if exists tab_char;
create table tab_char(  # 保留两位小数点
    c1 char(2),
    c2 varchar(10)
  
);
insert  into tab_char values('s','char');
select * from tab_char;

##### 2.3.2 enum和set示例
drop table if exists tab_char1;
create table tab_char1(  # 保留两位小数点
    e enum('a','b'),
    s set('a','b')
  
);
insert  into tab_char1 values('a','a');
insert  into tab_char1 values('A','A,b');  # enum、set的输入值不区分大小写
#insert  into tab_char1 values('a','c'); #  不在选择范围内，会报错
select * from tab_char1;

#### 2.4 日期型
/*
分类：
date：保存日期
time：保存时间
year：保存年份
datetime：保存日期+时间
timestamp：保存日期+时间
*/

##### 2.4.1 
drop table if exists tab_date;
create table tab_date(
  t1 datetime,
  t2 timestamp
);
insert into tab_date values(now(),now());
select * from tab_date;
show variables like 'time_zone';
set time_zone = '+9:00';  ##  东八区，改为东九区 