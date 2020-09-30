/*Q1.3*/
WITH t1 AS (SELECT f.film_id, f.title, c.name AS category_name, f.rental_duration, NTILE(4) OVER (PARTITION BY rental_duration ORDER BY rental_duration) AS quartile
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
JOIN film f
ON f.film_id = fc.film_id
WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music'))

SELECT category_name, quartile, COUNT(*)
FROM t1
GROUP BY 1,2
ORDER BY 1,2;
