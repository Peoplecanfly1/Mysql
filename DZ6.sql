/* Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, 
 * который больше всех общался с нашим пользователем.  
 */

select  FROM_USER_ID,COUNT(FROM_USER_ID) as summ
FROM MESSAGES
WHERE TO_USER_ID = 1
GROUP BY FROM_USER_ID
ORDER BY summ DESC LIMIT 1;
 

-- попытка решить как общая сумма всех сообещиний пользователя 1  ко всем пользователям, но не до конца, не знаю
-- как суммировать например: от 3го пользователя к 1му и от 1го к 3му это одна беседа. 
SELECT from_user_id,
       to_user_id,
       COUNT(id) as 'summ'   
FROM messages
WHERE to_user_id = 1 or from_user_id =1 
GROUP BY from_user_id, to_user_id;


--  Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.
SELECT COUNT(id)
FROM LIKES WHERE  MEDIA_ID IN 
	(SELECT id FROM MEDIA WHERE USER_ID IN 
		(SELECT USER_ID from PROFILES WHERE BIRTHDAY > CURRENT_DATE - INTERVAL 10 YEAR));


-- Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT GENDER, COUNT(*) as summ 
FROM PROFILES 
WHERE USER_ID IN(SELECT id FROM USERS where id IN (SELECT USER_ID from LIKES) )
GROUP BY GENDER 
ORDER BY summ DESC  LIMIT 1;