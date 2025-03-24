/*
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 */

SELECT f2.title
FROM film f2
JOIN film_actor fa2 ON f2.film_id = fa2.film_id
WHERE fa2.actor_id IN (
    SELECT fa1.actor_id
    FROM film_actor fa1
    JOIN film f1 ON fa1.film_id = f1.film_id
    WHERE f1.title = 'AMERICAN CIRCUS'
)
GROUP BY f2.title
HAVING COUNT(DISTINCT fa2.actor_id) >= 2
ORDER BY f2.title;
