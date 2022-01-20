USE sakila;

-- 1. How many films are there for each of the categories in the category table. Use appropriate join to write this
-- query.

SELECT c.name AS category_name, COUNT(DISTINCT(fc.film_id)) AS number_of_films
FROM sakila.category c
JOIN sakila.film_category fc
USING (category_id)
GROUP BY category_name;


-- 2. Display the total amount rung up by each staff member in August of 2005.

SELECT * FROM sakila.payment WHERE payment_date between '2005-08-01' AND '2005-08-31';

SELECT s.first_name, SUM(p.amount) AS total_rung_up
FROM sakila.staff s
JOIN sakila.payment p
USING (staff_id)
WHERE p.payment_date between '2005-08-01' AND '2005-08-31'
GROUP BY s.first_name;


-- 3. Which actor has appeared in the most films?

SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS film_appearances
FROM sakila.actor a
JOIN sakila.film_actor fa
USING (actor_id)
GROUP BY actor_id
ORDER BY film_appearances DESC
LIMIT 1;
-- output : GINA DEGENERES with 42 appearances


-- 4. Most active customer (the customer that has rented the most number of films)

SELECT c.first_name, c.last_name, COUNT(r.rental_id) AS number_rentals
FROM sakila.customer c
JOIN sakila.rental r
USING (customer_id)
GROUP BY customer_id
ORDER BY number_rentals DESC
LIMIT 1;
-- output : Eleanor Hunt who appeared in 46 movies


-- 5. Display the first and last names, as well as the address, of each staff member.

SELECT * FROM address;

SELECT s.first_name, s.last_name, a.address, a.district, c.city
FROM sakila.staff s
JOIN address a
USING (address_id)
JOIN sakila.city c
USING (city_id);
-- I have only left the address fields that contained information for the staff members
-- address2 and postal_code were both empty
-- output : Mike, Hillyer, 23 Workhaven Lane, Alberta, Lethbridge
--          Jon, Stephens, 1411 Lillydale Drive, QLD, Woodridge


-- 6. List each film and the number of actors who are listed for that film.

SELECT * FROM film;
SELECT * FROM film_actor;

SELECT f.title, COUNT(fa.actor_ID) as number_listed_actors
FROM sakila.film f
JOIN sakila.film_actor fa
USING (film_id)
GROUP BY film_id;
-- output, 1 000 rows, with in total 5 462 actor "listings"
-- extra info : movie with the highest number of actors is LAMBS CINCINATTI with 15 listed actors
-- 21 movies have 1 listed actor only


-- 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer.
-- List the customers alphabetically by last name.

SELECT * FROM sakila.payment;
SELECT * FROM sakila.customer;

SELECT c.last_name, c.first_name, SUM(p.amount) AS total_paid
FROM sakila.customer c
JOIN sakila.payment p
USING (customer_id)
GROUP BY c.last_name, c.first_name
ORDER BY c.last_name;

-- 8. List number of films per category.

SELECT c.name AS category, COUNT(DISTINCT(fc.film_id)) AS number_of_films
FROM sakila.category c
JOIN sakila.film_category fc
USING (category_id)
GROUP BY category
ORDER BY number_of_films DESC;
-- outout : 16 categories.
-- The one with the highest number of films is Sports with 74
-- The one with the lowest number of films is Music with 51