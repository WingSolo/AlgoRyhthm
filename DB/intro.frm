TYPE=VIEW
query=select `algo`.`intro_inq`.`num` AS `num`,`algo`.`intro_inq`.`cust_name` AS `cust_name`,`algo`.`intro_inq`.`email` AS `email`,`algo`.`intro_inq`.`phone` AS `phone`,`algo`.`intro_inq`.`comp_name` AS `comp_name`,`algo`.`intro_inq`.`data_type` AS `data_type`,`algo`.`intro_inq`.`coun_type` AS `coun_type`,`algo`.`intro_inq`.`visit_path` AS `visit_path`,`algo`.`intro_inq`.`time` AS `time` from `algo`.`intro_inq`
md5=d521a16c9a02a316340f61fcdb383c11
updatable=1
algorithm=0
definer_user=root
definer_host=localhost
suid=2
with_check_option=0
timestamp=2024-09-06 05:21:53
create-version=2
source=SELECT \n	num,\n	cust_name,\n	email,\n	phone,\n	comp_name,\n	data_type,\n	coun_type,\n	visit_path,\n	time\nFROM intro_inq
client_cs_name=utf8mb4
connection_cl_name=utf8mb4_general_ci
view_body_utf8=select `algo`.`intro_inq`.`num` AS `num`,`algo`.`intro_inq`.`cust_name` AS `cust_name`,`algo`.`intro_inq`.`email` AS `email`,`algo`.`intro_inq`.`phone` AS `phone`,`algo`.`intro_inq`.`comp_name` AS `comp_name`,`algo`.`intro_inq`.`data_type` AS `data_type`,`algo`.`intro_inq`.`coun_type` AS `coun_type`,`algo`.`intro_inq`.`visit_path` AS `visit_path`,`algo`.`intro_inq`.`time` AS `time` from `algo`.`intro_inq`
mariadb-version=100311
