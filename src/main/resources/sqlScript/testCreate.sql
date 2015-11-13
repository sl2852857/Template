DROP TABLE IF EXISTS t_admin;

CREATE TABLE t_admin (
	id int(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	username varchar(100) NOT NULL,
	password varchar(100) not null
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


/*Data for the table `t_admin` */

insert  into t_admin (id,username,password) values (1,'测试','123123');