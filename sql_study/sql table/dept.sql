# Host: 127.0.0.1:3366  (Version 5.5.36)
# Date: 2020-04-18 22:44:46
# Generator: MySQL-Front 6.1  (Build 1.26)


#
# Structure for table "dept"
#

DROP TABLE IF EXISTS `dept`;
CREATE TABLE `dept` (
  `DEPTNO` int(2) NOT NULL,
  `DNAME` varchar(14) DEFAULT NULL,
  `LOC` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`DEPTNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "dept"
#

INSERT INTO `dept` VALUES (10,'ACCOUNTING','NEW YOURK'),(20,'RESEARCH','DALLAS'),(30,'SALES','CHICAGO'),(40,'OPERATIONS','BOSTON');
