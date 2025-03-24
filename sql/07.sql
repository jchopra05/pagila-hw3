/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

-- List all actors with Bacall Number 2
-- That is, actors who have acted with someone who has acted with RUSSELL BACALL,
-- but not with RUSSELL BACALL directly, and not RUSSELL BACALL himself.

-- List all actors with Bacall Number 2
-- That is, actors who have acted with someone who has acted with RUSSELL BACALL,
-- but not with RUSSELL BACALL directly, and not RUSSELL BACALL himself.

WITH bacall AS (
    -- Get Russell Bacall's actor_id
    SELECT actor_id
    FROM actor
    WHERE first_name = 'RUSSELL' AND last_name = 'BACALL'
),
bacall_1 AS (
    -- Actors who acted in a movie with Russell Bacall
    SELECT DISTINCT fa1.actor_id
    FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
    JOIN bacall b ON fa2.actor_id = b.actor_id
    WHERE fa1.actor_id != b.actor_id
),
bacall_2 AS (
    -- Actors who acted in a movie with someone from bacall_1,
    -- excluding those already in bacall_1 or Russell Bacall himself
    SELECT DISTINCT fa1.actor_id
    FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
    WHERE fa2.actor_id IN (SELECT actor_id FROM bacall_1)
      AND fa1.actor_id NOT IN (
          SELECT actor_id FROM bacall_1
          UNION
          SELECT actor_id FROM bacall
      )
)
-- Final output: Bacall Number 2 actors by full name
SELECT DISTINCT CONCAT(a.first_name, ' ', a.last_name) AS "Actor Name"
FROM actor a
JOIN bacall_2 b2 ON a.actor_id = b2.actor_id
ORDER BY "Actor Name";
