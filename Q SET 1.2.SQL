/*Q1.2*/
SELECT f.title, c.name AS category_name, f.rental_duration,
      NTILE(4) OVER (PARTITION BY rental_duration ORDER BY rental_duration) AS quartile
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
JOIN film f
ON f.film_id = fc.film_id
WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music');
