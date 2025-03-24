/* 
 * In the previous query, the actors could come from any combination of movies.
 * Unfortunately, you've found that if the actors all come from only 1 or 2 of the movies,
 * then there is not enough diversity in the acting talent.
 *
 * Write a SQL query that lists all of the movies where:
 * at least 1 actor was also in AMERICAN CIRCUS,
 * at least 1 actor was also in ACADEMY DINOSAUR,
 * and at least 1 actor was also in AGENT TRUMAN.
 *
 * HINT:
 * There are many ways to solve this problem,
 * but I personally found the INTERSECT operator to make a convenient solution.
 */

WITH american_circus_movies AS (
    SELECT DISTINCT f2.title
    FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.actor_id = fa2.actor_id
    JOIN film f1 ON fa1.film_id = f1.film_id
    JOIN film f2 ON fa2.film_id = f2.film_id
    WHERE f1.title = 'AMERICAN CIRCUS'
    AND f2.title <> 'AMERICAN CIRCUS'
),
academy_dinosaur_movies AS (
    SELECT DISTINCT f2.title
    FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.actor_id = fa2.actor_id
    JOIN film f1 ON fa1.film_id = f1.film_id
    JOIN film f2 ON fa2.film_id = f2.film_id
    WHERE f1.title = 'ACADEMY DINOSAUR'
    AND f2.title <> 'ACADEMY DINOSAUR'
),
agent_truman_movies AS (
    SELECT DISTINCT f2.title
    FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.actor_id = fa2.actor_id
    JOIN film f1 ON fa1.film_id = f1.film_id
    JOIN film f2 ON fa2.film_id = f2.film_id
    WHERE f1.title = 'AGENT TRUMAN'
    AND f2.title <> 'AGENT TRUMAN'
)

SELECT title
FROM american_circus_movies
INTERSECT
SELECT title
FROM academy_dinosaur_movies
INTERSECT
SELECT title
FROM agent_truman_movies
ORDER BY title;
