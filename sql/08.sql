/*
 * The film 'BUCKET BROTHERHOOD' is your favorite movie, but you're tired of watching it.
 * You want to find something new to watch that is still similar to 'BUCKET BROTHERHOOD'.
 * To find a similar movie, you decide to search the history of movies that other people have rented.
 * Your idea is that if a lot of people have rented both 'BUCKET BROTHERHOOD' and movie X,
 * then movie X must be similar and something you'd like to watch too.
 * Your goal is to create a SQL query that finds movie X.
 * Specifically, write a SQL query that returns all films that have been rented by at least 3 customers who have also rented 'BUCKET BROTHERHOOD'.
 *
 * HINT:
 * This query is very similar to the query from problem 06,
 * but you will have to use joins to connect the rental table to the film table.
 *
 * HINT:
 * If your query is *almost* getting the same results as mine, but off by 1-2 entries, ensure that:
 * 1. You are not including 'BUCKET BROTHERHOOD' in the output.
 * 2. Some customers have rented movies multiple times.
 *    Ensure that you are not counting a customer that has rented a movie twice as 2 separate customers renting the movie.
 *    I did this by using the SELECT DISTINCT clause.
 */

-- Find movies rented by at least 3 customers who also rented 'BUCKET BROTHERHOOD'

WITH bucket_customers AS (
    -- Get distinct customers who rented 'BUCKET BROTHERHOOD'
    SELECT DISTINCT r.customer_id
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    WHERE f.title = 'BUCKET BROTHERHOOD'
),
other_films_by_bucket_customers AS (
    -- Get films (other than 'BUCKET BROTHERHOOD') rented by those customers
    SELECT DISTINCT f.film_id, r.customer_id
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    WHERE r.customer_id IN (SELECT customer_id FROM bucket_customers)
      AND f.title != 'BUCKET BROTHERHOOD'
),
film_customer_counts AS (
    -- Count how many distinct bucket_customers rented each film
    SELECT film_id, COUNT(DISTINCT customer_id) AS customer_count
    FROM other_films_by_bucket_customers
    GROUP BY film_id
    HAVING COUNT(DISTINCT customer_id) >= 3
)

-- Final output: film titles
SELECT f.title
FROM film f
JOIN film_customer_counts fcc ON f.film_id = fcc.film_id
ORDER BY f.title;
