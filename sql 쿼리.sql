/*analysis 테이블*/
CREATE TABLE `analysis` (
	`num` INT(11) NOT NULL AUTO_INCREMENT,
	`email` VARCHAR(255) NOT NULL,
	`file_path` VARCHAR(255) NULL DEFAULT NULL,
	`result` VARCHAR(1000) NULL DEFAULT NULL,
	PRIMARY KEY (`num`),
	UNIQUE INDEX `email` (`email`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

/*emp_user 테이블*/
CREATE TABLE `emp_user` (
	`emp_id` VARCHAR(20) NOT NULL,
	`password` VARCHAR(20) NOT NULL,
	`emp_name` VARCHAR(20) NOT NULL,
	`email` VARCHAR(255) NOT NULL,
	`phone` VARCHAR(50) NOT NULL,
	`user_dept` VARCHAR(50) NULL DEFAULT NULL,
	`user_pos` VARCHAR(50) NULL DEFAULT NULL,
	PRIMARY KEY (`emp_id`),
	UNIQUE INDEX `email` (`email`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;
/*intro_inq 테이블*/
CREATE TABLE `intro_inq` (
	`num` INT(11) NOT NULL AUTO_INCREMENT,
	`cust_name` VARCHAR(20) NOT NULL,
	`email` VARCHAR(255) NOT NULL,
	`phone` VARCHAR(50) NOT NULL,
	`comp_name` VARCHAR(20) NULL DEFAULT '없음',
	`data_type` ENUM('image','text','ect') NULL DEFAULT NULL,
	`coun_type` ENUM('dataset','ai','visualization','ect') NULL DEFAULT NULL,
	`visit_path` ENUM('recom','news','offline','sns','letter','youtube','talk','mail','potal','ect') NULL DEFAULT NULL,
	`content` VARCHAR(1000) NULL DEFAULT NULL,
	`time` TIMESTAMP NOT NULL DEFAULT '',
	PRIMARY KEY (`num`),
	UNIQUE INDEX `email` (`email`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=2
;

/*notice 테이블*/
CREATE TABLE `notice` (
	`num` INT(11) NOT NULL AUTO_INCREMENT,
	`title` VARCHAR(100) NOT NULL,
	`content` VARCHAR(1000) NOT NULL,
	`emp_id` VARCHAR(20) NOT NULL,
	`emp_name` VARCHAR(50) NOT NULL,
	`created_at` TIMESTAMP NOT NULL DEFAULT '',
	PRIMARY KEY (`num`),
	INDEX `fk_emp_user` (`emp_id`),
	CONSTRAINT `fk_emp_user` FOREIGN KEY (`emp_id`) REFERENCES `emp_user` (`emp_id`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=2
;
