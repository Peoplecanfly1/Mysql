 -- ����� � ������� users ���� created_at � updated_at ��������� ��������������. ��������� �� �������� ����� � ��������.
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

/*������� users ���� �������� ��������������. ������ created_at � updated_at ���� ������ ����� VARCHAR 
 � � ��� ������ ����� ���������� �������� � ������� "20.10.2017 8:10". ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.
*/
UPDATE users
SET updated_at = (SELECT STR_TO_DATE (updated_at, '%d.%m.%Y %k:%i')),
	created_at = (SELECT STR_TO_DATE (created_at, '%d.%m.%Y %k:%i'));
 
/*
 � ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����: 0, 
 ���� ����� ���������� � ���� ����, ���� �� ������ ������� ������. ���������� ������������� ������ ����� �������, 
 ����� ��� ���������� � ������� ���������� �������� value. ������, ������� ������ ������ ���������� � �����, ����� ���� �������.
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



-- ����������� ������� ������� ������������� � ������� users

SELECT  
FLOOR((sum((TO_DAYS(NOW()) - TO_DAYS(created_at)))/6)/365) as 'avarage age'
FROM users; 


-- ����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������. ������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������.
-- �� ����� ��� �������� ��������� � ������� �����, ����� ��� �� MYSQL ������� �����  ?  


