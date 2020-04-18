# Host: 127.0.0.1:3366  (Version 5.5.36)
# Date: 2020-04-18 22:45:03
# Generator: MySQL-Front 6.1  (Build 1.26)


#
# Structure for table "salgrade"
#

DROP TABLE IF EXISTS `salgrade`;
CREATE TABLE `salgrade` (
  `GRADE` int(11) DEFAULT NULL,
  `LOSAL` int(11) DEFAULT NULL,
  `HISAL` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "salgrade"
#

INSERT INTO `salgrade` VALUES (1,700,1200),(2,1201,1400),(3,1401,2000),(4,2001,3000),(5,3001,9999);
