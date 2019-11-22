-- Пусть в таблице users поля created_at и updated_at оказались незаполненными.
-- Заполните их текущими датой и временем

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
('11.12.1966 02:10', '20.10.2022 8:44'),
('10.11.1990 12:10', '20.10.2020 8:30'),
('22.06.2012  03:10', '20.10.2019 8:20'),
('10.10.2011 12:10', '20.10.2018 8:42'),
('23.10.2049 11:10', '20.10.2018 8:22'),
('20.10.2029 9:10',  '20.10.2017 8:33')
;

/*Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR 
 и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
*/

UPDATE users
SET updated_at = STR_TO_DATE (updated_at, '%d.%m.%Y %k:%i'),
	created_at = STR_TO_DATE (created_at, '%d.%m.%Y %k:%i');



/* В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры:
 * 0, если товар закончился и выше нуля, если на складе имеются запасы.
 * Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения 
 * значения value. Однако, нулевые запасы должны выводиться в конце, 
 * после всех записей.
 */ 

DROP TABLE IF EXISTS storage; 
CREATE TABLE storage (
	value INT

);

INSERT INTO storage VALUES (1),(33),(23), (3), (77), (2), (0), (132), (0);

Select * 
from STORAGE 
ORDER BY CASE WHEN value = 0 THEN value = 999 END, VALUE ;  -- можно было решить как-то проще? 


-- Подсчитайте средний возраст пользователей в таблице users

select  FLOOR(AVG((TO_DAYS(now())- TO_DAYS(created_at))/365)) as avarage
from USERS;

-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.
SELECT  DAYNAME(CREATED_AT), count(*)
from USERS
GROUP BY DAYNAME(CREATED_AT);











