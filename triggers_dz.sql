CREATE TRIGGER `update_users` AFTER INSERT ON `users` FOR EACH ROW insert into 
	logs set id = new.id, logs.time_mod = CURRENT_TIMESTAMP, logs.table_name = 'users', logs.name = new.name;
	
CREATE TRIGGER `update_catalogs` AFTER INSERT ON `catalogs` FOR EACH ROW insert into 
	logs set id = new.id, logs.time_mod = CURRENT_TIMESTAMP, logs.table_name = 'catalogs', logs.name = new.name;
	
CREATE TRIGGER `update_products` AFTER INSERT ON `products` FOR EACH ROW insert into 
	logs set id = new.id, logs.time_mod = CURRENT_TIMESTAMP, logs.table_name = 'products', logs.name = new.name	 ;