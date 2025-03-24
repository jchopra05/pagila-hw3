/* 
 * You also like the acting in the movies ACADEMY DINOSAUR and AGENT TRUMAN,
 * and so you'd like to see movies with actors that were in either of these movies or AMERICAN CIRCUS.
 *
 * Write a SQL query that lists all movies where at least 3 actors were in one of the above three movies.
 * (The actors do not necessarily have to all be in the same movie, and you do not necessarily need one actor from each movie.)
 */

WITH fav_movie AS (
    SELECT film_id 
    FROM film
    WHERE title in ('AMERICAN CIRCUS','ACADEMY DINOSAUR', 'AGENT TRUMAN')
)
SELECT f.title
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN (
    SELECT actor_id, COUNT(*) as count_appear
        FROM film_actor 
        WHERE film_id IN (SELECT film_id FROM fav_movie)
        GROUP BY actor_id
    ) actor_counts ON fa.actor_id = actor_counts.actor_id
GROUP BY f.title
HAVING SUM(actor_counts.count_appear) >= 3
ORDER BY f.title;
