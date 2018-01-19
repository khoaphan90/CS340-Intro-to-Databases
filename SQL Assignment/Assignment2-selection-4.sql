#1 Find all films with maximum length or minimum rental duration (compared to all other films). 
#In other words let L be the maximum film length, and let R be the minimum rental duration in the 
#table film. You need to find all films that have length L or duration R or both length L and duration R.
#You just need to return attribute film id for this query. 

SELECT film_id 
FROM film
WHERE rental_duration = (SELECT MIN(rental_duration) FROM film) 
AND length = (SELECT MAX(length) FROM film
);


#2 We want to find out how many of each category of film ED CHASE has started in so return a table with 
#category.name and the count of the number of films that ED was in which were in that category order 
#by the category name ascending (Your query should return every category even if ED has been in no films 
#in that category).

SELECT c.category_id, c.name, COUNT(a.actor_id)
FROM category c
LEFT JOIN film_category fc ON c.category_id = fc.category_id
LEFT JOIN film f ON fc.film_id = f.film_id
LEFT JOIN film_actor fa ON fa.actor_id = a.actor_id
AND a.first_name = 'ED' AND a.last_name = 'CHASE'
GROUP BY c.category_id, c.name


#3 Find the first name, last name and total combined film length of Sci-Fi films for every actor
#That is the result should list the names of all of the actors(even if an actor has not been in any 
#Sci-Fi films)and the total length of Sci-Fi films they have been in.
SELECT a.first_name AS 'First Name', a.last_name AS 'Last Name', SUM(f.length) AS 'Total Sci-Fi Film Length'
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN film f ON fa.film_id = f.film_id
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id && c.name="Sci-Fi"
GROUP BY a.first_name ASC;


#4 Find the first name and last name of all actors who have never been in a Sci-Fi film

SELECT a.first_name AS 'First', a.last_name AS 'Last'
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
INNER JOIN film_actor fa ON f.film_id = fa.film_id
INNER JOIN actor a ON fa.actor_id = a.actor_id
WHERE c.name NOT IN (SELECT name FROM category WHERE name = 'Sci-Fi')
GROUP BY a.first_name ASC;

#5 Find the film title of all films which feature both KIRSTEN PALTROW and WARREN NOLTE
#Order the results by title, descending (use ORDER BY title DESC at the end of the query)
#Warning, this is a tricky one and while the syntax is all things you know, you have to think oustide
#the box a bit to figure out how to get a table that shows pairs of actors in movies

SELECT T1.title, T1.first_name, T2.first_name, T2.last_name 
FROM (SELECT f.title, a.first_name, a.last_name
	FROM actor a
	INNER JOIN film_actor ac ON a.actor_id = fa.actor_id
	INNER JOIN film f ON fa.film_id = f.film_id
	WHERE a.first_name = 'KIRSTEN' AND a.last_name = 'PALTROW') AS T1

INNER JOIN (SELECT f.title, a.first_name, a.last_name
	FROM actor a
	INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
	INNER JOIN film f ON fa.film_id = f.film_id
	WHERE a.first_name = 'WARREN' AND a.last_name = "NOLTE") AS T2
ON T1.title = T2.title;