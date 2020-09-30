/*Q1.1*/
WITH family AS (SELECT c.name AS category_name, f.title AS film_title, f.film_id
                FROM category c
                JOIN film_category fc
                ON c.category_id = fc.category_id
                JOIN film f
                ON fc.film_id = f.film_id
                WHERE name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')),

      count AS (SELECT i.film_id, COUNT(r.rental_id) AS rental_count
                FROM inventory i
                JOIN rental r
                ON i.inventory_id = r.inventory_id
                GROUP BY 1)

SELECT category_name, film_title, rental_count
FROM family
JOIN count
ON family.film_id = count.film_id
ORDER BY 1,2;
