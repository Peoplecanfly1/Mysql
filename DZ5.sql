 -- ѕусть в таблице users пол€ created_at и updated_at оказались незаполненными. «аполните их текущими датой и временем.
DROP DATABASE IF exists DZ3;
CREATE DATABASE DZ3;
 
USE DZ3;
DROP TABlE if EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	created_at varchar(20),
	updated_at varchar(20)
);

	
INSERT INTO users (created_at, updated_at )
values 
('20.10.2009 02:10', '20.10.2022 8:44'),
('20.10.2009 12:10', '20.10.2020 8:30'),
('20.10.2009  03:10', '20.10.2019 8:20'),
('20.10.2009 12:10', '20.10.2018 8:42'),
('20.10.2009 11:10', '20.10.2018 8:22'),
('20.10.2009 9:10',  '20.10.2017 8:33')
;

/*“аблица users была неудачно спроектирована. «аписи created_at и updated_at были заданы типом VARCHAR 
 и в них долгое врем€ помещались значени€ в формате "20.10.2017 8:10". Ќеобходимо преобразовать пол€ к типу DATETIME, сохранив введеные ранее значени€.
*/
UPDATE users
SET updated_at = (SELECT STR_TO_DATE (updated_at, '%d.%m.%Y %k:%i')),
	created_at = (SELECT STR_TO_DATE (created_at, '%d.%m.%Y %k:%i'));
 
/*
 ¬ таблице складских запасов storehouses_products в поле value могут встречатьс€ самые разные цифры: 0, 
 если товар закончилс€ и выше нул€, если на складе имеютс€ запасы. Ќеобходимо отсортировать записи таким образом, 
 чтобы они выводились в пор€дке увеличени€ значени€ value. ќднако, нулевые запасы должны выводитьс€ в конце, после всех записей.
 */

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
	ostatok INT(30)
);

INSERT INTO storehouses_products (ostatok)
values 
(1),
(2),
(3),
(0),
(0),
(33),
(121),
(13)
;

SELECT *
FROM storehouses_products
ORDER BY 
	CASE WHEN ostatok = 0 THEN ostatok = 213131313 END ;



-- ѕодсчитайте средний возраст пользователей в таблице users

SELECT  
FLOOR((sum((TO_DAYS(NOW()) - TO_DAYS(created_at)))/6)/365) as 'avarage age'
FROM users; 


-- ѕодсчитайте количество дней рождени€, которые приход€тс€ на каждый из дней недели. —ледует учесть, что необходимы дни недели текущего года, а не года рождени€.
-- Ќе пон€л как сравнить конкретно с текущим годом, нужно что бы MYSQL понимал какую  ?  


