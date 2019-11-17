-- База курсовой работы на примере Кинопоиск )))) 


DROP DATABASE IF EXISTS kinopoisk;
CREATE DATABASE kinopoisk; 
USE kinopoisk; 

-- таблица пользователей у 
DROP TABLE IF EXISTS users; 
CREATE TABLE users  ( 
	id SERIAL PRIMARY KEY,
	nickname VARCHAR(10)UNIQUE,
	email VARCHAR(30) UNIQUE,
	`password_hash` VARCHAR(50),
	favorite_director BIGINT UNSIGNED NOT NULL,
	telephone_number VARCHAR(12) UNIQUE,
	regestration_date  DATETIME DEFAULT NOW()
	
	FOREIGN KEY (favorite_director) REFERENCES directors(id),
	
);
-- типы жанров
DROP TABLE IF EXISTS genres_type;
CREATE TABLE genres_type (
	id SERIAL PRIMARY KEY,
	`type` VARCHAR(30) UNIQUE NOT NULL
	
);

-- таблица с фильмами  и с базовой информацией о них. 
-- Так как у фильма есть несколько жанров я выделил через отдельные колонки,
--  но лучше вынести в отдельную таблицу и привзяать ключем?   как это оргнизовать лучше ? 

-- Основная таблица с фильмами
DROP TABLE IF EXISTS films;
CREATE TABLE films ( 
	id SERIAL PRIMARY KEY,
	film_name VARCHAR(30) NOT NULL, 
	release_date DATE NOT NULL, 
	director_id BIGINT UNSIGNED NOT NULL,
	main_style BIGINT UNSIGNED NOT NULL,
	sub_style BIGINT UNSIGNED NOT NULL, 
	budget_EURO INT,
	
	FOREIGN KEY (main_style) REFERENCES genres_type(id),
	FOREIGN KEY (sub_style) REFERENCES genres_type(id),
	
	INDEX (director_id),
	INDEX (film_name)
);
-- список режисеров 
DROP TABLE IF EXISTS directors;
CREATE TABLE directors ( 
	id SERIAL PRIMARY KEY,
	name VARCHAR(40),
	bio TEXT,
	birthday DATE,
	gender CHAR(1),
	
	INDEX (name)
	
	
);

-- промежуточная таблица для директоров что бы сделать связь М : М  
DROP TABLE IF EXISTS directors_films;
CREATE TABLE directors_films ( 
		id_director BIGINT UNSIGNED NOT NULL,
		id_film BIGINT UNSIGNED NOT NULL,
		
		PRIMARY KEY (id_director,id_film ),
		FOREIGN KEY (id_director) REFERENCES directors(id),
		FOREIGN KEY (id_film) REFERENCES films(id)
);

-- список фильмов добавленных пользователями в избранное
DROP TABLE IF EXISTS favorites;
CREATE TABLE favorites ( 
		user_id BIGINT UNSIGNED  NOT NULL,
		film_id BIGINT UNSIGNED NOT NULL,
		to_favorite_time DATETIME NOT NULL,  
		
		PRIMARY KEY (user_id, film_id),
		FOREIGN KEY (user_id) REFERENCES users(id),
		FOREIGN KEY (film_id) REFERENCES films(id)
		
);
-- Обзоры на фильмы сделанные пользователями, так же делал через объеденненый первичный ключ.

DROP TABLE IF EXISTS revisions; 
CREATE TABLE revisions  ( 	   
	   user_revision BIGINT UNSIGNED NOT NULL,
	   film_revision BIGINT UNSIGNED NOT NULL,
	   created_at DATETIME DEFAULT NOW(),
	   body TEXT,
	   `status` ENUM ('approved', 'rejected', 'on moderation'),
	   updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP, 
	   
	 
	PRIMARY KEY (user_revision,film_revision),
	FOREIGN KEY (user_revision) REFERENCES users(id),
	FOREIGN KEY (film_revision) REFERENCES films(id),
	INDEX(user_revision),
	INDEX(film_revision)
			   
);

-- Оценки пользоватлей фильмам, так же делал через объеденненый первичный ключ.
-- Все пользователи могут оцениват все фильмы.
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (
	user_score BIGINT UNSIGNED NOT NULL,
	film_related BIGINT UNSIGNED NOT NULL,
	score TINYINT,
	
	PRIMARY KEY (user_score,film_related),
	FOREIGN KEY (user_score) REFERENCES users(id),
	FOREIGN KEY (film_related) REFERENCES films(id),
	
    INDEX(user_score),
	INDEX(film_related)
);

-- Новостная лента, где авторами являются пользователи
-- Например если у новости есть 2 автора, как сделать так что бы была еще ссылка на юзера, 
-- только она могла бы быть нулевой если автор только 1 ?  Я сделал пример внизу. 
DROP TABLE IF EXISTS posts;
CREATE TABLE posts( 
		id SERIAL PRIMARY KEY,
		author_id BIGINT UNSIGNED NOT NULL,
		sub_author BIGINT UNSIGNED DEFAULT NULL, -- так корректно ? 
		publish_date DATETIME DEFAULT NOW(),
		body TEXT,
		post_status ENUM ('front page', 'rejected', 'on moderation'),
		about_film BIGINT UNSIGNED NOT NULL,
			
		FOREIGN KEY (author_id) REFERENCES users(id),
		FOREIGN KEY (sub_author) REFERENCES users(id),
		FOREIGN KEY (about_film) REFERENCES films(id),
		INDEX(author_id),
		INDEX(about_film)

);

-- функция комментов к новостным постам. 
DROP TABLE IF EXISTS comments;
CREATE TABLE comments( 
	author_id BIGINT UNSIGNED NOT NULL,
	post_id BIGINT UNSIGNED NOT NULL, 
	comment_body TEXT,
	comment_time DATETIME DEFAULT NOW(),
	
	 PRIMARY KEY (author_id,post_id),
	 FOREIGN KEY (author_id) REFERENCES users(id),
	 FOREIGN KEY (post_id) REFERENCES posts(id),
	 INDEX(post_id)	 
	 
);





