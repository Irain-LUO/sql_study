#  18 TCL 事务控制语言和事务并发

/*
### 1 事务 Transaction Control Language 
含义：一个或一组sql语句注册一个执行单元，这个执行单元要么全部执行，要么全部不执行
特性：原子性、一致性、隔离性、持久性（ACID）
*/

### 2 事务的创建

/*
隐式事务：事务没有明显的开启和结束的标记
比如：insert、update、delete语句
显式事务：事务有明显的开启和结束的标记
前提：必须先设置自动提交功能为禁用
set autocommit = 0; # 关闭自动提交，当前会话有效
显式事务步骤：
步骤1：set autocommit = 0; 或 start transaction；可选
步骤2：编写事务中的sql语句（select、inset、update、delete）
步骤3：结束事务。commit：提交事务； rollback：回滚事务。
savepoint  节点名； 设置保存点

事务的隔离级别：read uncommitted、read committed、repeatable read、serializable
MySQL默认：repeatable read
Oracle默认：read committed
查看事务隔离级别：select @@tx_isolation;
设置隔离级别：set session/global transaction isolation level 隔离级别；

*/
drop table if exists tab;
create table if not exists tab(
    id int,
    varname varchar(10)
);

#### 2.1 成功提交事务
set autocommit = 0;
start transaction;
insert into tab values(1,'aa');#  编写一组事务的语句
insert into tab values(2,'bb');
commit; # 结束事务
select * from tab;

#### 2.2 回滚事务
set autocommit = 0;
start transaction;
insert into tab values(3,'cc');#  编写一组事务的语句
insert into tab values(4,'dd');
rollback; # 回滚事务
select * from tab;
#### 2.3 savepoint与rollback搭配
select * from tab;
set autocommit=0;
start transaction;  # 开启事务
delete from tab where id=3;  # 成功删除id=3的数据
savepoint id1;  # rollback回滚到位置，仍然执行删除id=3数据的指令
delete from tab where id=4;  # 因为rollback回滚，没有删除id=4的数据
rollback to id1;  # 回滚到savepoint节点位置。rollback与savepoint之间的执行无效
select * from tab;



/*


*/
/*


*/