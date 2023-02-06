SHOW DATABASES;
USE sakila;
SHOW TABLES;

-- 1a all columns from actor table
SELECT * FROM actor LIMIT 20;
-- 1b only last_name column from actor table
SELECT last_name
FROM actor 
LIMIT 20;
-- 1c film_id, title, release_year from film table
SELECT film_id, title, release_year
FROM film
LIMIT 20;

-- 2a ALL distinct last_names from actor
SELECT DISTINCT last_name
FROM actor;
-- 2b ALL distinct postal codes from address table
SELECT DISTINCT postal_code
FROM address;
-- 2c ALL distinct ratings from film table
SELECT DISTINCT rating
FROM film;

-- 3a title, description, rating, movie_length from film that are 3hrs +
SELECT title, description, rating, length
FROM film
WHERE length >= 180;
-- 3b payment id,amount, payment date from payments on or after 05/27/2005
SELECT * FROM payment ORDER BY payment_date;
SELECT payment_id, amount, payment_date
FROM payment
WHERE payment_date >= '2005-05-27';
-- 3c primary key, amount, payment date from payment payments made on 05/27/2005
DESCRIBE payment;
SELECT payment_id, amount, payment_date
FROM payment
WHERE payment_date LIKE '2005-05-27%';
-- 3d ALL columns from customer with last_name begin with S and first_name end with N
SELECT * FROM customer LIMIT 20;
SELECT * 
FROM customer
WHERE last_name LIKE 'S%' 
  AND first_name LIKE '%N';
-- 3e ALL columns customer table for rows customer is inactive or has last_name begin with M
SELECT * 
FROM customer
WHERE active = 0 
  OR last_name LIKE 'M%';
-- 3f ALL columns category table primary key is greater than 4 AND name begins with C, S, or T
SELECT * FROM category;
SElECT *
FROM category 
WHERE category_id > 4 
  AND (name LIKE 'C%'
    OR name LIKE 'S%'
    OR name LIKE 'T%'
      )
;
-- 3g ALL columns except password col from staff table for rows containing a password
SELECT * FROM staff;
SELECT staff_id, first_name, last_name,address_id, picture, email, store_id, active, username, last_update
FROM staff
WHERE password IS NOT NULL;
-- 3h ALL col except password col from staff table for rows do not contain password
SELECT staff_id, first_name, last_name,address_id, picture, email, store_id, active, username, last_update
FROM staff
WHERE password IS NULL;

-- 4a phone and district cols from address table for addresses in Cali/England/Taipei/West Java
SELECT * FROM address;
SELECT phone, district
FROM address 
WHERE district IN ('California','England','Taipei','West Java');
-- 4b payment_id amount payment_date from payment table for dates 5-25,5-27,5-29 ALL 2005
SELECT payment_id, amount, payment_date
FROM payment
WHERE DATE(payment_date) IN ('2005-05-25','2005-05-27','2005-05-29');

-- 4c ALL col from film table rated G/PG-13/NC-17
SELECT *
FROM film
WHERE rating IN ('PG','PG-13','NC-17');

-- 5a
