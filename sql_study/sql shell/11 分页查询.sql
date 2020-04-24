##进阶8 分页查询
/*
应用场景：一页显示不全，分页提交sql请求
语法：
select 查询列表 
from 表1
【join type】 join 表2
on 连接条件
where 筛选条件
group by 分组后的筛选
order by 排序字段
limit offset， size;   
##  offset：显示条目的其实索引，（起始索引从0开始）
##  size：显示条目个数
特点：
1 limit语句放在查询语句的最后
2 公式：limit （page - 1）*size，size （page：显示页数，size：每页条数）
 
*/

#### a 查询前五条员工信息 
select * from emp limit 0,5;
# 相同效果
select * from emp limit 5;  
#### b 查询第11条---第25条
select * from emp limit 10,15;
#### c 查询有奖金的员工新，并且工资较高的前2名
select * from emp where comm is not null order by sal desc limit 0,2;