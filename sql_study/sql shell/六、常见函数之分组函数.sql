# 二、分组函数
/*
功能：用作统计使用，又称为聚合函数或统计函数或组函数
分类：sum：求和、avg：平均值、max：最大值、min：最小值、count：计算个数。
特点：
1.sum、avg一般处理数值类型
  max、min、count可以处理任何类型
2.以上分组函数都忽略null值
3.可以和distinct(去重)搭配使用
4.count函数的单独介绍：一般使用count(*)统计个数
5 和分组函数一同查询的字段要求是group by 后的字段
*/

use databases car;
1.示例：sum、avg、max、min、count
select * from cars;
--  出现特殊字符报错
--  解决方案：用反引号 `  .按键位置：左上角按键  Esc 的下面、按键 1 的左边
select sum(`汽车原价/万`) as `汽车总价格/万`, avg(`汽车原价/万`) as  `汽车平均价格/万`  from cars;  
select max(`汽车原价/万`) `汽车最高价格/万` , min(`汽车原价/万`) `汽车最低价格/万` from cars;
select count(颜色) from cars;

select sum(`汽车原价/万`) as `汽车总价格/万`, avg(`汽车原价/万`) as  `汽车平均价格/万`,
max(`汽车原价/万`) `汽车最高价格/万` , min(`汽车原价/万`) `汽车最低价格/万`,
count(颜色)  颜色
from cars;  

#2.参数支持哪些类型
#2.1 sum：数值类型
select sum(颜色) from cars;  # 语法错误，但MySQL不会报错
#2.2 max：数值、字母、数值字符、日期等任何类型
select max(日期) , min(日期) from cars;  # 日期：data类型
select min(上牌时间) from cars;  #  上牌时间 ：varchar类型
select max(颜色) from cars;  # 语法错误  颜色：varchar类型
select min(颜色) from cars;  # 语法错误  颜色：varchar类型
#2.3 count:任何非空值
select count(日期)  from cars;  # 日期：data类型
select count(上牌时间) from cars;  #  上牌时间 ：varchar类型
select count(颜色) from cars;  #  颜色：varchar类型
select sum(颜色),max(日期) , min(日期), avg(颜色) , count(上牌时间) from cars;  # 语法错误  
#3 分组函数和distinct(去重)搭配
select sum(distinct `汽车原价/万`), sum(`汽车原价/万`)  from cars;

#4  count函数的详细介绍
select count(*) from cars;  #  统计行数、个数
#  在表中添加新列:该值都为'1'。其他不存在表中的列名都可以。
select count(1) from cars;  #  统计行数、个数
select count(1) ,count(*) from cars;  #  统计行数、个数
#5 和分组函数一同查询的字段有限制
 select avg(差价), 差价 from cars;  # 不合适使用